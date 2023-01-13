Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C920266A4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjAMU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjAMU7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:59:40 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095BE39C;
        Fri, 13 Jan 2023 12:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7Ycz4sOcMTZWS9UTeHxz8IEHqp/XNO5Nlvj5YrrENHU=; b=IP+O+5rrpKSQ+vlYlSEio+A812
        +ulVgdTMpZfDLIookFWdS5A7xFa9lfAaRmw/bx3s8Rtobfba45806uZSLAFyS4gNdoiO1BJGgkner
        ta580r+/Mh0ZdXXj9EH+g/fAzLoXv7ZA/Roe7qEftxpwKwsw2w9wIV9pK4psf/3TxC6WSyKSrmMeI
        f4x7ZKTAj8pvbRVDawW+lZMJxDCGbIvIsOJsf8coyzwVgiz/PMTd3tm/+ij6I6JNz4Nx+gWxkYkBy
        giozuQ7g9z/ky/noow9lU9q2dkSXyd47TWUqv7JUc1hD2pQHg8EWgI87tedcUEwU6u/UP3a1pDbcH
        mEsBffEw==;
Received: from p200300ccff089e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:9e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pGR98-00059m-6A; Fri, 13 Jan 2023 21:59:30 +0100
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pGR97-009hiS-Ae; Fri, 13 Jan 2023 21:59:29 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org,
        linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] gpio: omap: use dynamic allocation of base
Date:   Fri, 13 Jan 2023 21:59:22 +0100
Message-Id: <20230113205922.2312951-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static allocatin is deprecated and may cause probe mess,
if probe order is unusual.

like this example
[    2.553833] twl4030_gpio twl4030-gpio: gpio (irq 145) chaining IRQs 161..178
[    2.561401] gpiochip_find_base: found new base at 160
[    2.564392] gpio gpiochip5: (twl4030): added GPIO chardev (254:5)
[    2.564544] gpio gpiochip5: registered GPIOs 160 to 177 on twl4030
[...]
[    2.692169] omap-gpmc 6e000000.gpmc: GPMC revision 5.0
[    2.697357] gpmc_mem_init: disabling cs 0 mapped at 0x0-0x1000000
[    2.703643] gpiochip_find_base: found new base at 178
[    2.704376] gpio gpiochip6: (omap-gpmc): added GPIO chardev (254:6)
[    2.704589] gpio gpiochip6: registered GPIOs 178 to 181 on omap-gpmc
[...]
[    2.840393] gpio gpiochip7: Static allocation of GPIO base is deprecated, use dynamic allocation.
[    2.849365] gpio gpiochip7: (gpio-160-191): GPIO integer space overlap, cannot add chip
[    2.857513] gpiochip_add_data_with_key: GPIOs 160..191 (gpio-160-191) failed to register, -16
[    2.866149] omap_gpio 48310000.gpio: error -EBUSY: Could not register gpio chip

So probing was done in an unusual order, causing mess
and chips not getting their gpio in the end.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
maybe CC stable? not sure about good fixes tag.

 drivers/gpio/gpio-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 80ddc43fd875..f5f3d4b22452 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1020,7 +1020,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
 		if (!label)
 			return -ENOMEM;
 		bank->chip.label = label;
-		bank->chip.base = gpio;
+		bank->chip.base = -1;
 	}
 	bank->chip.ngpio = bank->width;
 
-- 
2.30.2

