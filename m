Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02276E1668
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDMVX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDMVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:23:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C56B5FDB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 14:23:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pn4Py-0004rB-4n; Thu, 13 Apr 2023 23:23:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pn4Pu-00B3Td-SR; Thu, 13 Apr 2023 23:23:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pn4Pu-00CzGq-3G; Thu, 13 Apr 2023 23:23:42 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Olivier Moysan <olivier.moysan@foss.st.com>,
        linux-iio@vger.kernel.org, Lee Jones <lee@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] counter: stm32-timer-cnt: Reset TIM_TISEL to its default value in probe
Date:   Thu, 13 Apr 2023 23:23:39 +0200
Message-Id: <20230413212339.3611722-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1841; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=vxtaBmxwNsBkr9CdtdCf+mVLWRBggCM6EPnGO9VbZeY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkOHLZP6hHl9jieHDPCcxLcjQxJ/8Ne4sNwuePK TlBhuZ4IxyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZDhy2QAKCRCPgPtYfRL+ Tr6DB/4tCTTgUX3YN1QgGIcU6A0L0zrWPI1weshKJPCTfVssBBfSkNNltw6R4oGgeyTytC/KvRR B1g+lOIxVkWzJJjTrgJth/kIJBddPzXIl6RyLxna/0Yan0+cr3enI0HaNwgOLQsQBSdFUoKzIwa gV6SFTAoB9RfTuXoWXz6wYCsodwZHOMdMrjLdq54ivczK+Uco86JTA8QGaShoROWnhU8gFo5xB1 1pZRzOt1g+OOLQ/A8LN8nFOUsPJkFDwsNgyoLuMPU9fsrrpNFFhBFiZmUMzUad2c00WuxpIwjm2 NZwXX1xo1R+oEvZYObv5E50hyEYQPfhYm165gP5OaKV7QBSd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver assumes that the input selection register (TIM_TISEL) is at
its reset default value. Usually this is the case, but the bootloader
might have modified it.

This bases on a similar patch submitted by Olivier Moysan for pwm-stm32.

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Changes since (implicit) v1 sent with Message-Id:
20230412153709.3557323-1-u.kleine-koenig@pengutronix.de .

 - Only reset TIM_TISEL as suggested by Fabrice
 - Add Fabrice's Review tag

 drivers/counter/stm32-timer-cnt.c | 3 +++
 include/linux/mfd/stm32-timers.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index 9bf20a5d6bda..6206d2dc3d47 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -342,6 +342,9 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
+	/* Reset input selector to its default input */
+	regmap_write(priv->regmap, TIM_TISEL, 0x0);
+
 	/* Register Counter device */
 	ret = devm_counter_add(dev, counter);
 	if (ret < 0)
diff --git a/include/linux/mfd/stm32-timers.h b/include/linux/mfd/stm32-timers.h
index 5f5c43fd69dd..1b94325febb3 100644
--- a/include/linux/mfd/stm32-timers.h
+++ b/include/linux/mfd/stm32-timers.h
@@ -31,6 +31,7 @@
 #define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
 #define TIM_DCR		0x48	/* DMA control register    */
 #define TIM_DMAR	0x4C	/* DMA register for transfer */
+#define TIM_TISEL	0x68	/* Input Selection         */
 
 #define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
 #define TIM_CR1_DIR	BIT(4)  /* Counter Direction	   */

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

