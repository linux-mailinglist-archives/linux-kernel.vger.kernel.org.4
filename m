Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1657C62AF3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 00:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbiKOXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 18:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiKOXMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 18:12:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B62E9D7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:12:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so2487862pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 15:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUrJd0ClH04zE7+FZG1iIcCrqg/chKo2CqMXeBC8xoA=;
        b=i+IoW6ryNF6E4I6qeDPuLgcJfpSq0zi2D3p+Hnv+sQV3oJTr8uc/R3IW7WC1Rs3o5j
         WcwZAx+NRW+4JWbYwV9KIhwfmRMOlLsMX7c4ZGRDGENMBfhsOMRHTnVcz/TgphjCF5il
         Xr8klWNHfFFFhLyvgSOnD3TOp/9Z3CyYIX2k8uVSfdIKvmVSrlIOojolq1ochmMLvqbC
         ZGllTLaYPa4BpyWPD2D8XMzN3yFlyK5AH29yMy3WN1o0m/JGS682yPme9C0/zlYKzjy7
         gCXHDcd2HPUdho5WQNidB7g6l4uNyepJXNwHc6lLqXrJ5UljhFhEdjZILg53birjyGFQ
         ol/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUrJd0ClH04zE7+FZG1iIcCrqg/chKo2CqMXeBC8xoA=;
        b=pqemGjud4+rJSgc9QRhtuz6xDa0IlOuSxTFQc9g6Jw43xN2UTFVMvAmIU4cOphvndT
         536dFcgm6+2NJR3B9tfPCHEyTTTDGck6ipAXZb+gjSdowQ5qzfkMYXu9IW5ZeMwNiMzQ
         DhQ5DnrO8ZpcZQMkDsElBQFZyuas17ljImIqa8BVBtu2A6mSisbivZ/9uYk2ZR+PbnB8
         pVM8q7TlHBOgOfD4EynWtOLRYf/wwz4f03VR0RcU7+GhzcJg+8kpOmoT/3MDekqi+TPT
         6Zr3NOE610C4hyIIl5a+8VI/E8cLGosvDoT+pcPnj6adkMmCugTNzkrOCV4gli9WI6dU
         AWxQ==
X-Gm-Message-State: ANoB5pmljVQJF6daN2UU3Z8QUaQIVR8fKP8zBRQpKIUAQMHprN2S+XB4
        qHaZ38drICGeZbigpAh0J56in0+eZfY=
X-Google-Smtp-Source: AA0mqf530va7GXwyAwZ4xfIPh6VmEBLttOHSILPNRav7Sbl6Ds91ZfVwXnno+LL4ZpnVkM+K5MqpBg==
X-Received: by 2002:a17:902:a70e:b0:185:3659:1ce9 with SMTP id w14-20020a170902a70e00b0018536591ce9mr6056420plq.26.1668553965143;
        Tue, 15 Nov 2022 15:12:45 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id v7-20020a17090a458700b001fd6066284dsm107286pjg.6.2022.11.15.15.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 15:12:44 -0800 (PST)
Date:   Tue, 15 Nov 2022 15:12:41 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: mvebu: switch to using gpiod API in pm-board code
Message-ID: <Y3Qc6et/d+vhd71Q@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This switches PM code to use the newer gpiod API instead of legacy
gpio API that we want to retire.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-mvebu/pm-board.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index 7fa1806acd65..beec22e17e89 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -8,19 +8,19 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_gpio.h>
 #include <linux/slab.h>
 #include "common.h"
 
 #define ARMADA_PIC_NR_GPIOS 3
 
 static void __iomem *gpio_ctrl;
-static int pic_gpios[ARMADA_PIC_NR_GPIOS];
+static struct gpio_desc *pic_gpios[ARMADA_PIC_NR_GPIOS];
 static int pic_raw_gpios[ARMADA_PIC_NR_GPIOS];
 
 static void mvebu_armada_pm_enter(void __iomem *sdram_reg, u32 srcmd)
@@ -90,27 +90,17 @@ static int __init mvebu_armada_pm_init(void)
 		char *name;
 		struct of_phandle_args args;
 
-		pic_gpios[i] = of_get_named_gpio(np, "ctrl-gpios", i);
-		if (pic_gpios[i] < 0) {
-			ret = -ENODEV;
-			goto out;
-		}
-
 		name = kasprintf(GFP_KERNEL, "pic-pin%d", i);
 		if (!name) {
 			ret = -ENOMEM;
 			goto out;
 		}
 
-		ret = gpio_request(pic_gpios[i], name);
-		if (ret < 0) {
-			kfree(name);
-			goto out;
-		}
-
-		ret = gpio_direction_output(pic_gpios[i], 0);
-		if (ret < 0) {
-			gpio_free(pic_gpios[i]);
+		pic_gpios[i] = fwnode_gpiod_get_index(of_fwnode_handle(np),
+						      "ctrl", i, GPIOD_OUT_HIGH,
+						      name);
+		ret = PTR_ERR_OR_ZERO(pic_gpios[i]);
+		if (ret) {
 			kfree(name);
 			goto out;
 		}
@@ -118,7 +108,7 @@ static int __init mvebu_armada_pm_init(void)
 		ret = of_parse_phandle_with_fixed_args(np, "ctrl-gpios", 2,
 						       i, &args);
 		if (ret < 0) {
-			gpio_free(pic_gpios[i]);
+			gpiod_put(pic_gpios[i]);
 			kfree(name);
 			goto out;
 		}
-- 
2.38.1.431.g37b22c650d-goog


-- 
Dmitry
