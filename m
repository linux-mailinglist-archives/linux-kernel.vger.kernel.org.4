Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD95BAC08
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiIPLJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiIPLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:08:22 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82C513DEF;
        Fri, 16 Sep 2022 04:01:25 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 56C60277A;
        Fri, 16 Sep 2022 13:01:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663326083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ugzyUxYeBPrKpDFT2/k3C9G3kNNbWTr4z18MeL1qf54=;
        b=iaK/ku1z0zzm4T9xpVTu+DDGiRRj0xapmsAf5TJjnThjATGwhbXSBvi2JYBryAqByTTgTY
        Xokld+jXWGrlPPV2ToQjDo9r62nUVv+5jiUcTh0KtwGoZm81bBD/kl2bY42OFY5hbsIXRO
        VVDZbmiWu8ZfXCM2yeXjR0Jq+TeI0PV74jKFygkxYcPvkm2TZIu0o9jyOaR8wNdr6zWj2Q
        UokjWS4UWgfrxJSLgl4oGmHGukGXADg0QGIULDxcJaEFFn9lYJALlfRUFh1JsRsgMFAyJF
        HLv6MC95XF2jvSd49ApxM8EqTTx7GygHj6tfP1ZScV4ypfJjExElktmxYXixzg==
From:   Michael Walle <michael@walle.cc>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] gpiolib: fix OOB access in quirk callbacks
Date:   Fri, 16 Sep 2022 13:01:18 +0200
Message-Id: <20220916110118.446132-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
introduced an array of quirk functions which get iterated over. But a
sentinal value is missing. Add it.

Fixes: a2b5e207cade ("gpiolib: rework quirk handling in of_find_gpio()")
Signed-off-by: Michael Walle <michael@walle.cc>
---
FWIW here is the kernel oops backtrace:
[    4.108706] Internal error: SP/PC alignment exception: 8a000000 [#1] SMP
[    4.115470] Modules linked in:
[    4.118549] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.0.0-rc5-next-20220916-00091-g6cae0fcbd5e7 #1821
[    4.128033] Hardware name: Kontron KBox A-230-LS (DT)
[    4.133127] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.140154] pc : 0x61722d6f697067
[    4.143495] lr : of_find_gpio+0x138/0x174
[    4.147546] sp : ffff80000a24b680
[    4.150884] x29: ffff80000a24b680 x28: 0000000000000000 x27: ffff80000996044c
[    4.158090] x26: 0000000000000001 x25: ffff80000970f588 x24: ffff800009297968
[    4.165295] x23: ffff80000a24b770 x22: 0000000000000000 x21: ffff0020009a7010
[    4.172500] x20: ffff8000097752f8 x19: fffffffffffffffe x18: 0000000000000000
[    4.179703] x17: ffff8000085fb9d0 x16: ffff8000085fb264 x15: ffff8000085f96ac
[    4.186907] x14: 0000000000000000 x13: ffff80000884b3e8 x12: ffff80000884ab04
[    4.194111] x11: ffff80000884aa54 x10: 0000000000025080 x9 : ffff8000085fce78
[    4.201316] x8 : 0101010101010101 x7 : ffff800009750268 x6 : 051f521459491b57
[    4.208520] x5 : 571b495914521f05 x4 : 6e61722d6f697067 x3 : ffff80000a24b6d4
[    4.215724] x2 : 0000000000000000 x1 : ffff8000097752f8 x0 : ffff00207f7e4b20
[    4.222928] Call trace:
[    4.225389]  0x61722d6f697067
[    4.228377]  gpiod_get_index+0x12c/0x440
[    4.232334]  devm_gpiod_get_index+0x34/0xf0
[    4.236553]  devm_gpiod_get_optional+0x20/0x40
[    4.241036]  uart_get_rs485_mode+0x104/0x180
[    4.245345]  serial8250_register_8250_port+0x198/0x484
[    4.250532]  of_platform_serial_probe+0x358/0x640
[    4.255279]  platform_probe+0x70/0xe0
[    4.258973]  really_probe+0xc4/0x2e4
[    4.262577]  __driver_probe_device+0x80/0xec
[    4.266882]  driver_probe_device+0x44/0x150
[    4.271100]  __driver_attach+0x88/0x1a0
[    4.274967]  bus_for_each_dev+0x78/0xdc
[    4.278833]  driver_attach+0x2c/0x40
[    4.282437]  bus_add_driver+0x15c/0x210
[    4.286303]  driver_register+0x80/0x13c
[    4.290170]  __platform_driver_register+0x30/0x3c
[    4.294915]  of_platform_serial_driver_init+0x24/0x30
[    4.300013]  do_one_initcall+0x4c/0x240
[    4.303882]  kernel_init_freeable+0x29c/0x30c
[    4.308276]  kernel_init+0x2c/0x140
[    4.311793]  ret_from_fork+0x10/0x20
[    4.315401] Code: bad PC value

 drivers/gpio/gpiolib-of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 95be5f0d2623..0e4e1291604d 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -498,6 +498,7 @@ static const of_find_gpio_quirk of_find_gpio_quirks[] = {
 	of_find_regulator_gpio,
 	of_find_arizona_gpio,
 	of_find_usb_gpio,
+	NULL
 };
 
 struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
-- 
2.30.2

