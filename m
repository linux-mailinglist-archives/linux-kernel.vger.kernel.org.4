Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BDB6ABA24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCFJle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCFJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:41:32 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C94233CB;
        Mon,  6 Mar 2023 01:41:28 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=0443564136=fe@dev.tdt.de>)
        id 1pZ7LQ-0002zt-Da; Mon, 06 Mar 2023 10:41:24 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pZ7LP-000Ran-Mq; Mon, 06 Mar 2023 10:41:23 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 53421240049;
        Mon,  6 Mar 2023 10:41:23 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id BB57A24004D;
        Mon,  6 Mar 2023 10:41:22 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 8346A2E30C;
        Mon,  6 Mar 2023 10:41:22 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH v8 3/3] ledtrig-tty: call correct brightness set function
Date:   Mon,  6 Mar 2023 10:41:13 +0100
Message-ID: <20230306094113.273988-4-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230306094113.273988-1-fe@dev.tdt.de>
References: <20230306094113.273988-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1678095684-535C951F-3B7F81B3/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is, however, that with LEDs that are connected directly to
the SOC via a GPIO, the LED cannot be switched on or off.
Because the 'leds-gpio' device driver does not need a delayed work.

If we look at the callstack for the function 'led_set_brightness_sync',
then at the end it is checked whether the LED device driver has the
function 'brightness_set_blocking' implemented. This is not the case for
the 'leds-gpio' device.

The function 'brightness_set_blocking' returns LED devices -ENOTSUPP.
This is not evaluated in 'ledtrig-tty' trigger.

In order for the trigger to also work with LED that does not have the
'brightness_set_blocking' function implemented, we must therefore use the
internal API of the LED subsystem and use the function
'led_set_brightness_nosleep'.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/leds/trigger/ledtrig-tty.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index d3407830fa69..132e809898a7 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -7,6 +7,8 @@
 #include <linux/tty.h>
 #include <uapi/linux/serial.h>
=20
+#include "../leds.h"
+
 enum tty_led_mode {
 	TTY_LED_RXTX,
 	TTY_LED_CTS,
@@ -164,9 +166,9 @@ static void ledtrig_tty_flags(struct ledtrig_tty_data=
 *trigger_data, unsigned in
=20
 	status =3D tty_get_mget(trigger_data->tty);
 	if (status & flag)
-		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+		led_set_brightness_nosleep(trigger_data->led_cdev, LED_ON);
 	else
-		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
+		led_set_brightness_nosleep(trigger_data->led_cdev, LED_OFF);
 }
=20
 static void ledtrig_tty_work(struct work_struct *work)
@@ -229,12 +231,12 @@ static void ledtrig_tty_work(struct work_struct *wo=
rk)
 		}
=20
 		if (icount.rx !=3D trigger_data->rx || icount.tx !=3D trigger_data->tx=
) {
-			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+			led_set_brightness_nosleep(trigger_data->led_cdev, LED_ON);
=20
 			trigger_data->rx =3D icount.rx;
 			trigger_data->tx =3D icount.tx;
 		} else {
-			led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
+			led_set_brightness_nosleep(trigger_data->led_cdev, LED_OFF);
 		}
 		break;
 	}
--=20
2.30.2

