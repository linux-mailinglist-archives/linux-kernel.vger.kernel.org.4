Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46966BAECA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCOLJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCOLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:09:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E785280E01;
        Wed, 15 Mar 2023 04:07:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so1538005pjz.1;
        Wed, 15 Mar 2023 04:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678878427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erfjIHSmGXfoAF8ObS8yp8f/sPlytQRqicin+mQofyE=;
        b=hdXigU3R6KAcjNj0bYviTN6QNoX9fU+TVX2vOj3PLR2GJBVAIuFCuCTVwx2oA4QiuO
         Mm38P96tRgZbxkx4D6J++L4g4Ejy5NuHk6HMrHEgBWfRAThZwPuZnLSfd8tJWRuIIKZZ
         BZjcMp1TIpLlT6DY0XChSrVO4FfxSJMbjI61qagzM7gGcwP81mHDAT5qWPfoHOcvl2E6
         k0IYg9scNojB05W8sQy7PRlBenZ5Q+x70D79BTzoNfEg+OjjJymk5CXBYqLk8PEwz9O1
         hQd/Gil2ynOyaYo+K3V887aS4PWZyd+YnCkKhKlcunJy7BIV8qB+iY+rUx4rOLlFEO7I
         +e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678878427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erfjIHSmGXfoAF8ObS8yp8f/sPlytQRqicin+mQofyE=;
        b=uDaVjTn9tnG5743ZMwoZBsaC4dT5rzvTeKs3qOOuRlOpwhBty9rd0dIPWPtdEsEMfW
         1ZA/AeLsklO3R8QToVdrspDsCG5Xs4eZIpQfefDzbdbkq6CxC6gni+f19rs/xuCJ/t5r
         6StUVSfyosFyUd1JWsMGeUaq0Ywu/NwkI72XYFe6vsPAX7RYCfj2oAfq2DTSAcQnBsWw
         ykwChIoDlrp/QYTj7GaZY38b6PwLLBmPRsJK62Vhnvm28+F9Q9wwYj/YluTEKzIzYPWL
         wpWQXjL2GySHF12ZxS4tUXVcIvcZ3M12sJS6BJ/+F6/RbraYEbW+nxQVNSKQwP/Vu2hd
         bJXw==
X-Gm-Message-State: AO0yUKVFUh7GiITNiPYoSufxHUAGOy0DUtmiC/L6mST66L+78t7Y1Kpy
        nybeV9pryyKIA3hjIbU0acyvCktKYb7b0Q==
X-Google-Smtp-Source: AK7set/2tKoo97CmIefQTlqsJEeNZfDRiU2LnEzZhC2h2SQBe52QyQnM/yx0WYLPaEN9a+zXJ0ZYmw==
X-Received: by 2002:a05:6a20:160f:b0:d3:a13a:4c43 with SMTP id l15-20020a056a20160f00b000d3a13a4c43mr15223302pzj.0.1678878426702;
        Wed, 15 Mar 2023 04:07:06 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v4-20020aa78084000000b005892ea4f092sm3337489pff.95.2023.03.15.04.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:07:06 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v3 1/4] gpio: loongson1: Convert to SPDX identifier
Date:   Wed, 15 Mar 2023 19:06:47 +0800
Message-Id: <20230315110650.142577-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315110650.142577-1-keguang.zhang@gmail.com>
References: <20230315110650.142577-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier instead of the license text.

The current author name is unofficial, change it to my real name.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V2 -> V3: Explain the reason for changing the author name in commit message
V1 -> V2: Keep GPLv2, just convert to SPDX identifier
---
 drivers/gpio/gpio-loongson1.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 5d90b3bc5a25..8862c9ea0d41 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * GPIO Driver for Loongson 1 SoC
  *
- * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
+ * Copyright (C) 2015-2023 Keguang Zhang <keguang.zhang@gmail.com>
  */
 
 #include <linux/module.h>
@@ -90,6 +87,6 @@ static struct platform_driver ls1x_gpio_driver = {
 
 module_platform_driver(ls1x_gpio_driver);
 
-MODULE_AUTHOR("Kelvin Cheung <keguang.zhang@gmail.com>");
+MODULE_AUTHOR("Keguang Zhang <keguang.zhang@gmail.com>");
 MODULE_DESCRIPTION("Loongson1 GPIO driver");
 MODULE_LICENSE("GPL");
-- 
2.34.1

