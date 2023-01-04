Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9068165D124
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 12:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbjADLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 06:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbjADLCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 06:02:21 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E2B18E36;
        Wed,  4 Jan 2023 03:02:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DC01341DF4;
        Wed,  4 Jan 2023 11:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1672830123; bh=6O6u/DiwF8q7P6Yv/PpHELUbZYJkapFUTj1HP8/Sg6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xbUI3R/qFHwBvDCZsyCio7NVckEz+1/4EhgmDZkgYjeU6h2mgnP/V9akZ7+uJxjBA
         BS0694famCGv6qB8Yy5449gpx8Ij5lnifJVPJmJlHJARuXbw3oAw6myUiQ+lvCJDgZ
         MsE3dj4wzOJolPr18opaUPXj6cyXVIiYbrGQs+Whl7MP7abQhqvkuVlHgqdGxZCf5L
         o5eZb8rTSzoqRz6S2rSp5oZ09I6ex3Pxcc/DL9eyh/gLvm5jKXNj2qZw8FMW6diWrK
         KPxjtLx519xsTQ8mOTfcE2dzfwXrFKGEdKS1P+m39DJCRlJxuknw4bWlTdpA/tRsOX
         sClceEQUxXmrA==
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
Date:   Wed,  4 Jan 2023 20:00:11 +0900
Message-Id: <20230104110013.24738-6-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230104110013.24738-1-marcan@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
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

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/apple-dart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 189487c1d978..03a3cb5638ba 100644
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

