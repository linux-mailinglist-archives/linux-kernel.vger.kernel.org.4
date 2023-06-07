Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D2872576A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjFGIVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 04:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbjFGIVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 04:21:06 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60851FDC;
        Wed,  7 Jun 2023 01:20:52 -0700 (PDT)
X-QQ-mid: bizesmtp81t1686126015tij1hqko
Received: from wxdbg.localdomain.com ( [122.235.137.64])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 16:20:06 +0800 (CST)
X-QQ-SSF: 01400000000000J0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJlWz8h9pkBblPfRUT02IjaMSbr4acK3xfZ6D3K7hFxp/p1AGukcB
        twgiMIpKrFXolURkQR1vr51Zd9RxTg8ZuBnaSDm8iHlBl2RWNYAMaR350cG1JVezHidLoEX
        ZIrT8u7K1YybOuoUpMfCA8UGUPBQPmOYOnaNRheQ6xKboqrdmJ8B0i9tqXpKA86mE69XEWQ
        CbdZhy3Fb2SiAq8sBTRoGDo3YWI/ng/sWYvtLyPw7ae5PEkfri+DMfx5uRa6QkWPiZTM2AK
        6UV6zrqzGBRICvX0XNxubrWESmBTu79LaDXHIbCIoNMYxvyDqL2y8s/DrxevhTGYntkFW+e
        KG4QAOntDaxCGDjcaQSYV9zPkE30/FR8LRuMYRCJB5T3g1D2KxeBQkcL+Xk5Q==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16544725819709452032
From:   Jiawen Wu <jiawenwu@trustnetic.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl,
        shreeya.patel@collabora.com, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
Date:   Wed,  7 Jun 2023 16:18:03 +0800
Message-Id: <20230607081803.778223-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of gpio-regmap, IRQ chip is added by regmap-irq and associated with
GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag was not
added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to return
-EPROBE_DEFER.

Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members before initialization")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
v1 -> v2:
- add compiler barrier
---
 drivers/gpio/gpiolib.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index a7220e04a93e..9ecf93cbd801 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1792,6 +1792,14 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
 
+	/*
+	 * Using barrier() here to prevent compiler from reordering
+	 * gc->irq.initialized before adding irqdomain.
+	 */
+	barrier();
+
+	gc->irq.initialized = true;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
-- 
2.27.0

