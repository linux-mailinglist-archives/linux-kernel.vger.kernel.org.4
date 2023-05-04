Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5B26F64A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 08:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjEDGEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 02:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjEDGEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 02:04:50 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59941FFB;
        Wed,  3 May 2023 23:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yJ77h21arVzofepbkIoYut2Go9+A93qkebZbDt34MiQ=; b=hALYOdPlt6C4E/QeA2BWscfwow
        OCdj2wlfQOSvVckJRoL+1OsIzTT8PYs9+9nFe7ZjyVLUU9dmXNhB3T68QS9GJjdYIA2MLuEHfUI3b
        WWQ8XSs2T+orWlezSk8ND+qIkaEukm4UE6tHvwiDw8vVHIm4VfGxRfNgAIAQCX2aAlR3BLnhQyzs8
        XtLkzhN8ekZCY4WcR57PGqjdAKstrTKVsOWRg7VSWJ3nKvZOf3dTi3SYFILFE/0hC46QHLc59ZAQW
        Youo5E7ixgsq1+S4Hlk1vNXY6OUC1DWSWtQ88sEBfiXyohxKRJRkUWGusTaj6SZcaA145SOQolzD4
        y+QCzWIg==;
Received: from p200300ccff0d59001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0d:5900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1puS4v-0008W0-Fm; Thu, 04 May 2023 08:04:33 +0200
Received: from andi by aktux with local (Exim 4.96)
        (envelope-from <andreas@kemnade.info>)
        id 1puS4v-003NCf-09;
        Thu, 04 May 2023 08:04:33 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        christophe.leroy@csgroup.eu, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3] gpiolib: fix allocation of mixed dynamic/static GPIOs
Date:   Thu,  4 May 2023 08:04:21 +0200
Message-Id: <20230504060421.804168-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If static allocation and dynamic allocation GPIOs are present,
dynamic allocation pollutes the numberspace for static allocation,
causing static allocation to fail.
Enforce dynamic allocation above GPIO_DYNAMIC_BASE.

Seen on a GTA04 when omap-gpio (static) and twl-gpio (dynamic)
raced:
[some successful registrations of omap_gpio instances]
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

On that device it is fixed invasively by
commit 92bf78b33b0b4 ("gpio: omap: use dynamic allocation of base")
but let's also fix that for devices where there is still
a mixture of static and dynamic allocation.

Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: <christophe.leroy@csgroup.eu>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in V3:
   typos

Changes in V2:
   handle also the case of overlapping static allocation
   across DYNAMIC_BASE

 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 19bd23044b017..4472214fcd43a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -193,6 +193,8 @@ static int gpiochip_find_base(int ngpio)
 			break;
 		/* nope, check the space right after the chip */
 		base = gdev->base + gdev->ngpio;
+		if (base < GPIO_DYNAMIC_BASE)
+			base = GPIO_DYNAMIC_BASE;
 	}
 
 	if (gpio_is_valid(base)) {
-- 
2.39.2

