Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899DA6D6A7D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236066AbjDDRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbjDDRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:23:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD675B93
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ew6so133506419edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6heumvUXponVh3RKpQNyq3EGPwF7qwIsRx59+iTBPyU=;
        b=Yp9SCiNZSJTp63JPfZH8YZ8qGzP7rb8oa8MSHHTMu1pl+4b1OyqkCnRiiMDMYWmHOo
         nIVyUw9tEdSbsFV8xDMi3EWvGOigXnV6SxPpzn++hBQD1qIz2OYsoPm7bAIg8/cicw5Z
         rtpJtY6pIKQM/MTPITfMNxYTX6bCr65taFdVWJI/V1JmK3hCW8GXwAaxWGSMwEcVWjlL
         1l4YufvykMiiO3yPF27TA2TYnhsCLWzYOWXGhJzzBQ1lPLLzcEL5lRqS3ZyC9iseEyLp
         VreYJtOhvzFsuHYWrTsJAqVeAysGbNObHZzP9igrZ1jcS6XEj+iJEjeFAfRKFJ2V8t0u
         6rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6heumvUXponVh3RKpQNyq3EGPwF7qwIsRx59+iTBPyU=;
        b=apc3I3wg/GoOMa6I40kYb0e2m7VBWvRoLFiJOVOrArvLH5NMVtsTp/K0KB66qB6yi5
         evmxdlTqSIlBT2c2eEo2DJdTMFJU0AtBzAEXMoi0b/59XC62LsZUt81GoGZ7zEwYG7MC
         2WFizuQqBWuqwMdKOIYdOcXZIBepxMLUvUQQbuoGnH2hgU7YiNFC8wreJJtN7DtKG3PU
         ssXE6NmH5yJwS0qH0qC1l0zwVy4YwE2KGt6elzOH746Cr3EEWxOBbkfR1gnrPNRLLjAA
         kHO7NHC56WPcIlmxv+NhcL6pQKTrJfrx2XPDSmRi8pyKK/yVEPfj/oVegZ932XZ+mgCf
         vblg==
X-Gm-Message-State: AAQBX9dB5YMWQgUD7dDG4Ngj6a/aAbdx9ENoAgkqg6RPrxqd868tI0Ea
        7jusPjoA63WLGkQfgCVN9PlnnsT/okMSbSo9GiI=
X-Google-Smtp-Source: AKy350aNqmYN/WQcKwVijzyP7tSEI+6Rjsqzm32p/BK9AK8Oayr3zjOyYBNbJZgJxlAiyvXPjHcnLw==
X-Received: by 2002:a17:906:3591:b0:932:6601:4910 with SMTP id o17-20020a170906359100b0093266014910mr263725ejb.54.1680628984848;
        Tue, 04 Apr 2023 10:23:04 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 30/40] nvmem: bcm-ocotp: Use devm_platform_ioremap_resource()
Date:   Tue,  4 Apr 2023 18:21:38 +0100
Message-Id: <20230404172148.82422-31-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

According to commit 7945f929f1a7 ("drivers: provide
devm_platform_ioremap_resource()"), convert platform_get_resource(),
devm_ioremap_resource() to a single call to use
devm_platform_ioremap_resource(), as this is exactly what this function
does.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/bcm-ocotp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index a128c7f5e351..0c1fa0c4feb2 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -244,7 +244,6 @@ MODULE_DEVICE_TABLE(acpi, bcm_otpc_acpi_ids);
 static int bcm_otpc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	struct otpc_priv *priv;
 	struct nvmem_device *nvmem;
 	int err;
@@ -259,8 +258,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Get OTP base address register. */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base)) {
 		dev_err(dev, "unable to map I/O memory\n");
 		return PTR_ERR(priv->base);
-- 
2.25.1

