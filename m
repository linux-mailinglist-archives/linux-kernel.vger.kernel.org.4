Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF78F642662
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiLEKJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiLEKJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:09:19 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F2183AA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:09:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DF71242137;
        Mon,  5 Dec 2022 10:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1670234956; bh=/lyXjIyUIb+1pgEaMmUwZNYl0uV1GrDjGWI2beTmvj0=;
        h=From:To:Cc:Subject:Date;
        b=m5sgsXXtSrqefqkY+9rLDHCdHtIuKLYn/OuPT+lybjBXgnPgK4kP9ZReDUcpmDmoS
         c1/7bQzBphZxXoYjhy/8FMOxpVooUeVACX4o7mCPZ+jfRJoYUMoptCKE8bSspRqQn1
         G9qJxD3f1sHwP9JbMmaV7DvbMf5WgxYWa+MN/2dyc7ECMe+53CxF/L/2RgEH2evwAh
         T5erlbKK2tLu4HcbSoBGNiFfR7wnLb2/RGpWWc/zbZOx/+gzTXbCkQg+HSehHcZAEV
         AeoMO8Mz2cYYR6HWiPgNT6HcU0IK0G7PvYZ/XaA8t2Az8Gi6KSVAGqqZjwgAZRYE23
         QlU6oP/9NfpVg==
From:   Hector Martin <marcan@marcan.st>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH] iommu: dart: Add suspend/resume support
Date:   Mon,  5 Dec 2022 19:09:07 +0900
Message-Id: <20221205100907.10230-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
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

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 4f4a323be0d0..ed524765ad87 100644
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
@@ -932,6 +935,50 @@ static const struct apple_dart_hw apple_dart_hw_t6000 = {
 	.fmt = APPLE_DART2,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int apple_dart_suspend(struct device *dev)
+{
+	struct apple_dart *dart = dev_get_drvdata(dev);
+	unsigned int sid, idx;
+
+	for (sid = 0; sid < DART_MAX_STREAMS; sid++) {
+		dart->save_tcr[sid] = readl_relaxed(dart->regs + DART_TCR(sid));
+		for (idx = 0; idx < DART_MAX_TTBR; idx++)
+			dart->save_ttbr[sid][idx] =
+				readl_relaxed(dart->regs + DART_TTBR(sid, idx));
+	}
+
+	return 0;
+}
+
+static int apple_dart_resume(struct device *dev)
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
+			writel_relaxed(dart->save_ttbr[sid][idx],
+				       dart->regs + DART_TTBR(sid, idx));
+		writel_relaxed(dart->save_tcr[sid], dart->regs + DART_TCR(sid));
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops apple_dart_pm_ops = {
+	.suspend	= apple_dart_suspend,
+	.resume		= apple_dart_resume,
+};
+#endif
+
 static const struct of_device_id apple_dart_of_match[] = {
 	{ .compatible = "apple,t8103-dart", .data = &apple_dart_hw_t8103 },
 	{ .compatible = "apple,t6000-dart", .data = &apple_dart_hw_t6000 },
@@ -944,6 +991,9 @@ static struct platform_driver apple_dart_driver = {
 		.name			= "apple-dart",
 		.of_match_table		= apple_dart_of_match,
 		.suppress_bind_attrs    = true,
+#ifdef CONFIG_PM_SLEEP
+		.pm			= &apple_dart_pm_ops,
+#endif
 	},
 	.probe	= apple_dart_probe,
 	.remove	= apple_dart_remove,
-- 
2.35.1

