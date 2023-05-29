Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EE77145B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjE2HpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjE2HpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:45:01 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F62AC;
        Mon, 29 May 2023 00:44:54 -0700 (PDT)
X-QQ-mid: bizesmtp75t1685346271t2dsh6fi
Received: from wxdbg.localdomain.com ( [183.159.96.128])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 29 May 2023 15:44:22 +0800 (CST)
X-QQ-SSF: 01400000000000J0Z000000A0000000
X-QQ-FEAT: eSZ1CZgv+JDnClWgMPbLdL6Yn+9Meybq4WT4eTj7rXbJ1L6TQWpUnAm2mROMV
        ofkFElQi08BdjMr3eXJJvzEyZrfjFKXQKDeDc+xIjLLOe+89hbMXvZLj85XvjjHkQCwHVeI
        QOsqlNZg3wFTsPTgJaSN1+tNg9K6HIWXe9ZhPcSvCvDJCLbXMv3b6upAPUc0c4Zc9PdjDl3
        M0C57woFwk39p2d3WLFdVHSYL1TwEsCegCK1Ojglw2g8QGG+/XhaydOaBuxFANp/hLp3b6W
        cOTuiLInlp3THu6N0GA2tFCej5jx72TcKz7pPtp+X7carWLjqzSi+n8d6CjnYQ9KbSw/2VN
        mXhXQcPJMn96a2YqLBPugtpj9d9fuF/z3Mf4FAyGYmI3AwezwUD9M84vd1i4w==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 9551324987145372188
From:   Jiawen Wu <jiawenwu@trustnetic.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, andy.shevchenko@gmail.com,
        shreeya.patel@collabora.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH] gpiolib: Fix GPIO chip IRQ initialization restriction
Date:   Mon, 29 May 2023 15:42:27 +0800
Message-Id: <20230529074227.636933-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
Cc: shreeya.patel@collabora.com
---
 drivers/gpio/gpiolib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 04fb05df805b..1b6cd4ffb761 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1789,6 +1789,7 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
+	gc->irq.initialized = true;
 
 	return 0;
 }
-- 
2.27.0

