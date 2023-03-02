Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940C6A82B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCBMxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCBMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:52:56 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782EF4A1EA;
        Thu,  2 Mar 2023 04:52:45 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id fa28so588333pfb.12;
        Thu, 02 Mar 2023 04:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zyweGzdA9jS1fyEsOsHkcKiajwcBVlOAfPTENEP1t0=;
        b=TvwBcY9uVbl0p2l5Yxd74SXG0WA0SKa4wQOKSTf9WIfRoiRXc5LqQAaAQEnbRUq64e
         pOi6hAYoLcWAkKvD4nIRNWT6qnxxmOIsCk2w3NfjpGJDEmrI3rXqeoSqvhj80amgN3DB
         gs3pwd0zwlwGoTsWtutGfr7LmSYvWwxCTIgdnqfWws0wM0BjbdFEIJ6A+vv/8zpWifXH
         94o+Lqt+GkhExg+PTovFYp60EiK4N39enher3M+MBFTLIOUTN11ak07QeHd0awpnfmYs
         IHNzEuF6+tinBZZzRPr57ybxkrNKp1DTPcn7eZhcBMCV5+xKAo1YzNsxT86fPD3iEAtz
         2Mkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zyweGzdA9jS1fyEsOsHkcKiajwcBVlOAfPTENEP1t0=;
        b=OTffPWGjpkU3H2Y5d+TGxzwYe4FBcqyz/fsMGIjx9NpNs6URpFQkGt3zLSmLaK5G16
         pIApP0XzK3sV1CH7aS3ESKxQBWNWMxjGSIoOyhJU5MKEPG1vK+0DGjsZxQ3yLh5fVYr3
         3AyKHlZ2N8HenCuV/ofC9+kwSGvTovoQ18g+0nLjNZKnFASqaIS222dwoPLPyDolFu8h
         zDVjkqA6/0jF+XYY7+swvyLbtmOKJxal92aRWzGX+blmjpmumC0Rz3yqYqhSUgjejzKL
         InScO0QOKailjlPZe1ZA3pB2f373qTUVL2AFxfRxwnioZrd48bWW82XNkHBYh37Ow0/J
         DwFg==
X-Gm-Message-State: AO0yUKUg2RNQRIIIvE2azNKO0k3eCb3/GaRAL7ZElOKgqm5itnWc1ymK
        6653tqs14Gh57k2+QsU2iOvhDy0w5Qs=
X-Google-Smtp-Source: AK7set+SHWxvXTEjyB2cx85BN6na/7p9fbFI/+Z2RCGcFfbBp6lmnaWXTlThJIF+e6yXgqC3+WfZ2A==
X-Received: by 2002:a62:62c6:0:b0:5a8:aa1d:30e9 with SMTP id w189-20020a6262c6000000b005a8aa1d30e9mr7493277pfb.18.1677761564572;
        Thu, 02 Mar 2023 04:52:44 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([223.85.203.147])
        by smtp.gmail.com with ESMTPSA id j7-20020a62e907000000b005aa60d8545esm9791955pfh.61.2023.03.02.04.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:52:44 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 1/5] gpio: loongson1: Convert to SPDX identifier
Date:   Thu,  2 Mar 2023 20:52:11 +0800
Message-Id: <20230302125215.214014-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230302125215.214014-1-keguang.zhang@gmail.com>
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
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

Use SPDX-License-Identifier instead of the license text and
update the author information.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
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

