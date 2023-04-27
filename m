Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3F6F056C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243822AbjD0MKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243754AbjD0MKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:10:07 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC32524F
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:10:05 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f004943558so2404685e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682597404; x=1685189404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNvCCMPMF278Wqr3jAy5GhuoPQm5kPBgkMVcgaYk7hs=;
        b=kzyVHrQBPyLbh7Z7H9tNdb7DTY2g7oozYbJpteZq3a4GM52Ed4wUr0jSg76ineFNmB
         8Fd3VSBeUZoQbr4P25HBYfhnF8E24xT7KYf+OCFoXfO3hgdXAktHyrLzP290wxZLmxIL
         tCdiCoA5hdLspOIEMV/a9m+iKX/2Dww3tsGq7X5ZDH0PO7aql7YKmuwuBrVklRER6xO/
         NjDtuX2NNZwTNy1sQ5rqxB4uaf5zoI6Z7f1PDf7R/sHfqzFy5u+Cdw3WFhEn3XiZmVCG
         CCJ1e1uIA3BVYj8cTRWJEmaPpTNyb9nvTM5lBG9cpQ4shI1iR9DiTSDUUDG38d/EE9Yo
         x2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682597404; x=1685189404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNvCCMPMF278Wqr3jAy5GhuoPQm5kPBgkMVcgaYk7hs=;
        b=VtjOlg19s64rgtHVho4wmx+yx9shmhrWlq2nyOJY87ibGP2kQYsjoKN0tXJ+bZeQxB
         kKQDvjf6iKa1KQ3VLE4pVROv+kO3ngHwxcmGDDiAFF95fsZygZqp/Go+CpusGaAHORlg
         ikzb3RvwtCZee1pr9MhwwflEJA3hjf8QHhsEVd3brTUVrHF132uEAUjuop3FBCYaBH0O
         1tLKalk9LtYTPWupchnm99ld2zQ49V7KuDCRz+PA/ktCfP4zz90zZCBu1guzqmWbDJf7
         j86enqXAAog4l0CVHOiLJ9e0d9ZpYVQpUu66kNdlVUjTcyou9u2nd5C92V2g9SBLBX71
         T3AA==
X-Gm-Message-State: AC+VfDxG9dNc0NkIcZpCLTzhRJKfj2bxtd0QxdQw15efVquZuVV9GqiS
        f/r0gEmdVl8j4RjhL0NCy2nJSQ==
X-Google-Smtp-Source: ACHHUZ4k5tqT/e7Tm+ZkgWv3u5PbF2kWhz24FovFMaYm4ehf6Yey1ZUqce5Rir4CZKSKaKbVL0GsNw==
X-Received: by 2002:ac2:48b3:0:b0:4ef:f630:5c1e with SMTP id u19-20020ac248b3000000b004eff6305c1emr491617lfg.51.1682597404231;
        Thu, 27 Apr 2023 05:10:04 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id e7-20020ac25467000000b004d4d7fb0e07sm2892044lfn.216.2023.04.27.05.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 05:10:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 27 Apr 2023 14:10:00 +0200
Subject: [PATCH v2 5/8] dmaengine: ste_dma40: Pass dev to OF function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v2-5-cdaa68a4b863@linaro.org>
References: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v2-0-cdaa68a4b863@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF platform data population function only wants to
use struct device *dev, so pass that instead.

This change makes the compiler realize that the local
platform data variable is unused, so drop that too.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/dma/ste_dma40.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index e5df28cdc4c8..fe98f12b8130 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3480,14 +3480,14 @@ static int __init d40_lcla_allocate(struct d40_base *base)
 	return ret;
 }
 
-static int __init d40_of_probe(struct platform_device *pdev,
+static int __init d40_of_probe(struct device *dev,
 			       struct device_node *np)
 {
 	struct stedma40_platform_data *pdata;
 	int num_phy = 0, num_memcpy = 0, num_disabled = 0;
 	const __be32 *list;
 
-	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
 
@@ -3500,7 +3500,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 	num_memcpy /= sizeof(*list);
 
 	if (num_memcpy > D40_MEMCPY_MAX_CHANS || num_memcpy <= 0) {
-		d40_err(&pdev->dev,
+		d40_err(dev,
 			"Invalid number of memcpy channels specified (%d)\n",
 			num_memcpy);
 		return -EINVAL;
@@ -3515,7 +3515,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 	num_disabled /= sizeof(*list);
 
 	if (num_disabled >= STEDMA40_MAX_PHYS || num_disabled < 0) {
-		d40_err(&pdev->dev,
+		d40_err(dev,
 			"Invalid number of disabled channels specified (%d)\n",
 			num_disabled);
 		return -EINVAL;
@@ -3526,7 +3526,7 @@ static int __init d40_of_probe(struct platform_device *pdev,
 				   num_disabled);
 	pdata->disabled_channels[num_disabled] = -1;
 
-	pdev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	return 0;
 }
@@ -3534,7 +3534,6 @@ static int __init d40_of_probe(struct platform_device *pdev,
 static int __init d40_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct stedma40_platform_data *plat_data = dev_get_platdata(dev);
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *np_lcpa;
 	int ret = -ENOENT;
@@ -3544,7 +3543,7 @@ static int __init d40_probe(struct platform_device *pdev)
 	int num_reserved_chans;
 	u32 val;
 
-	if (d40_of_probe(pdev, np)) {
+	if (d40_of_probe(dev, np)) {
 		ret = -ENOMEM;
 		goto report_failure;
 	}

-- 
2.40.0

