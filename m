Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0536694DA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241078AbjAMKyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjAMKx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:27 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4A977AF4;
        Fri, 13 Jan 2023 02:51:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 578D44206F;
        Fri, 13 Jan 2023 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673607110; bh=XN7W4wHaV4CYylxXNUod7fpaKbnCRKcr/LnEs1SZri8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lm1OI8ZmxoHebhJKLPlRDpInHCgUpIecT+3XN2nnu+fLs+th+5YQYk9IqXLrQdImt
         K0fOEhs0+OpDPLNaB0AjR/iMUL2GYphZ6BY5NQt8gWnza+U7iOaCA/QMufkefDwgkV
         CCjpMh8GUSJhKBWwpkD56lcslFmfDjyyeasxUEBpqfKnAin/8boa4Y5kPGdN5OTZJy
         7bAmCAz4hO3eFWLZmAcvlp37pw65DlnDQcUcAh13Quc+Me2ojJhVKwW/acErloBMlS
         DrEuMagqhKOCtaOl1oc8+EWkUrjeSbyZhxcBPlh1zC6icxZSj+pAYlXtpffMV/lg0D
         H/9ywWdQHcTiA==
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
Subject: [PATCH 5/7] iommu: dart: Fix DART_PARAMS1/2 bit define names
Date:   Fri, 13 Jan 2023 19:50:28 +0900
Message-Id: <20230113105029.26654-6-marcan@marcan.st>
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

They didn't have the PARAMS reg index in them, but they should.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 82b2581d909c..89be055a44be 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -40,10 +40,10 @@
 
 
 #define DART_PARAMS1 0x00
-#define DART_PARAMS_PAGE_SHIFT GENMASK(27, 24)
+#define DART_PARAMS1_PAGE_SHIFT GENMASK(27, 24)
 
 #define DART_PARAMS2 0x04
-#define DART_PARAMS_BYPASS_SUPPORT BIT(0)
+#define DART_PARAMS2_BYPASS_SUPPORT BIT(0)
 
 #define DART_STREAM_COMMAND 0x20
 #define DART_STREAM_COMMAND_BUSY BIT(2)
@@ -893,8 +893,8 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	dart_params[0] = readl(dart->regs + DART_PARAMS1);
 	dart_params[1] = readl(dart->regs + DART_PARAMS2);
-	dart->pgsize = 1 << FIELD_GET(DART_PARAMS_PAGE_SHIFT, dart_params[0]);
-	dart->supports_bypass = dart_params[1] & DART_PARAMS_BYPASS_SUPPORT;
+	dart->pgsize = 1 << FIELD_GET(DART_PARAMS1_PAGE_SHIFT, dart_params[0]);
+	dart->supports_bypass = dart_params[1] & DART_PARAMS2_BYPASS_SUPPORT;
 
 	dart->num_streams = dart->hw->max_sid_count;
 
-- 
2.35.1

