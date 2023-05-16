Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61838704E53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjEPM4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjEPM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:56:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6542B6A7C
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:55:51 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ac80da3443so152490821fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684241745; x=1686833745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXDujZjOmn14EqjwMZcmym6IEUeRVyRNkVM6UCS7Ld4=;
        b=k1m1MrvGvq5UvjWEb3hZnJWob9bx/nsIVHunAtM9VFyioxd759fGt1mhyGiMgAT+uO
         8RVl3mKIdHywmcC6Y4Zlu0h4qDZdBGDXirdUKysfV0bzhpkDDWAEazste7YOqjKF5K+m
         ytPHrDbprC1nF75ovu23TCFzZPoRjPPlJ8DkBRm53mitT9o9R1LEEEScazLdKcANfhS6
         WToWOgO6PaiW/Iz1o7MgDvtS1HYSxsw//7LnsKYXXf+qKABN+gG07o7ZjPSJQscExk3T
         Ue7jxwAW2vvpkWNh4jjs2nDamyCzkA4z1K2NCSLQSuXTAqB3HgOvW4V8u9eO9KLusiUe
         PebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684241745; x=1686833745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXDujZjOmn14EqjwMZcmym6IEUeRVyRNkVM6UCS7Ld4=;
        b=W9Bvl4XFsBDUNN2IVUSm8Xk+YeIkBI1Z/9YBvH0T0kXpo8JEKQswE0dn5+RqS8KdMa
         eE/6Y+dt9JAuur3N7Wq6QbMgGFVvD85XU8UjbnSH93o7arW4iU6Kfv5lpdt1Iy/u04T8
         xGXRBOZGfRGoDpRswBqPiJrTkYVq0/yYm/1ZRODqTWK8E+ByPD7/iHAisdNbaltm1c+f
         Km2mjpLoGvukb9StrEjE2U7xiDWZ0fCQVH/ftxEImzOzxqjkjspcQTeYi7Usxma5b9Ic
         6N2Qr9t1EH4m9jfbRNU4oHdVtVTQ+GmSCKE+RvVL6bECLQwCObRo/Wpuyx4RcVVeYpr6
         33Aw==
X-Gm-Message-State: AC+VfDw086AnQJ5QJDSGy6YeEkQ6NeFctHmCpbtfqb9g4S9KeraHfpkw
        YOiwcywuRfyXCuMg6FI0gpfiefpjxOg34b76Ozo=
X-Google-Smtp-Source: ACHHUZ4FC9snn34bdwiHmnmhxll/Nmpcg9xoRfCJ8p24i6clsi+U4FrZaYbVvn9ePp12VgQZln39MQ==
X-Received: by 2002:a2e:9d97:0:b0:2ac:d51f:2d60 with SMTP id c23-20020a2e9d97000000b002acd51f2d60mr8540364ljj.33.1684241744893;
        Tue, 16 May 2023 05:55:44 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id o23-20020a2e7317000000b002add1f4a92asm1647789ljc.113.2023.05.16.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:55:44 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 14:55:35 +0200
Subject: [PATCH v3 5/7] dmaengine: ste_dma40: Pass dev to OF function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-ux500-dma40-cleanup-v3-5-60bfa6785968@linaro.org>
References: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
In-Reply-To: <20230417-ux500-dma40-cleanup-v3-0-60bfa6785968@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
index 48c9606cfd46..87f57457e4d9 100644
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
2.40.1

