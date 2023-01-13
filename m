Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AC96694CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbjAMKxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbjAMKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:12 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E777AC5;
        Fri, 13 Jan 2023 02:51:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2D25841A42;
        Fri, 13 Jan 2023 10:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673607096; bh=kZ5l2St5RyPUjKSIYXwu/uDFjCyPWx8nT0BPyLp8JKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ae6JuKjU00sx2HlcWmPSHOOZ6+AsJUs2stuywa5lTiHEy/YHVyhuP8cLlNhyfNuDJ
         dT3X5k/glqXl8aDaTc7iEgvdq3mBUWuTTxrJjvJ0m6ev4ZWmxmuz8KFkN0Yx0nsw+9
         8XtaZYbyBtGNF0p4jHFJ6tRhMVlRv36PMWCZ1mDTXZGbdnarK9OQRR6c61JH9fc1Pm
         WFhv3oJAorH1hQBYSw1Pz6jqdI0Z+T4/gNFmsYCLxPjYyT9gpLvnvIbNfRiJ2+Olq+
         HJcQVI4ORIKsrIzTMm2Ksl6Av2ZiazoV589IOT3Y0nMlMuJbZlHhypOuOJK8LXjOGq
         4bK0m04MRxKfw==
From:   Hector Martin <marcan@marcan.st>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH 2/7] iommu: dart: Add suspend/resume support
Date:   Fri, 13 Jan 2023 19:50:25 +0900
Message-Id: <20230113105029.26654-3-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230113105029.26654-1-marcan@marcan.st>
References: <20230113105029.26654-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to save/restore the TCR/TTBR registers, since they are lost
on power gate.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4f4a323be0d0..2458416122f8 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -121,6 +121,9 @@ struct apple_dart {
 
 	struct iommu_group *sid2group[DART_MAX_STREAMS];
 	struct iommu_device iommu;
+
+	u32 save_tcr[DART_MAX_STREAMS];
+	u32 save_ttbr[DART_MAX_STREAMS][DART_MAX_TTBR];
 };
 
 /*
@@ -932,6 +935,45 @@ static const struct apple_dart_hw apple_dart_hw_t6000 = {
 	.fmt = APPLE_DART2,
 };
 
+static __maybe_unused int apple_dart_suspend(struct device *dev)
+{
+	struct apple_dart *dart = dev_get_drvdata(dev);
+	unsigned int sid, idx;
+
+	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
+		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
+		for (idx = 0; idx < DART_MAX_TTBR; idx++)
+			dart->save_ttbr[sid][idx] =
+				readl(dart->regs + DART_TTBR(sid, idx));
+	}
+
+	return 0;
+}
+
+static __maybe_unused int apple_dart_resume(struct device *dev)
+{
+	struct apple_dart *dart = dev_get_drvdata(dev);
+	unsigned int sid, idx;
+	int ret;
+
+	ret = apple_dart_hw_reset(dart);
+	if (ret) {
+		dev_err(dev, "Failed to reset DART on resume\n");
+		return ret;
+	}
+
+	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
+		for (idx = 0; idx < DART_MAX_TTBR; idx++)
+			writel(dart->save_ttbr[sid][idx],
+			       dart->regs + DART_TTBR(sid, idx));
+		writel(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
+	}
+
+	return 0;
+}
+
+DEFINE_SIMPLE_DEV_PM_OPS(apple_dart_pm_ops, apple_dart_suspend, apple_dart_resume);
+
 static const struct of_device_id apple_dart_of_match[] = {
 	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
 	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
@@ -944,6 +986,7 @@ static struct platform_driver apple_dart_driver = {
 		.name			= "apple-dart",
 		.of_match_table		= apple_dart_of_match,
 		.suppress_bind_attrs    = true,
+		.pm			= pm_sleep_ptr(&apple_dart_pm_ops),
 	},
 	.probe	= apple_dart_probe,
 	.remove	= apple_dart_remove,
-- 
2.35.1

