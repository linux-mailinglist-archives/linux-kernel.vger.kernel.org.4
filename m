Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D5869481E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBMOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBMOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:32:56 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A59ECE;
        Mon, 13 Feb 2023 06:32:55 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=9422104eba=fe@dev.tdt.de>)
        id 1pRZTk-0002KQ-0a; Mon, 13 Feb 2023 15:06:48 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pRZTj-000M80-4i; Mon, 13 Feb 2023 15:06:47 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id D0CCF24004D;
        Mon, 13 Feb 2023 15:06:46 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 4770C240049;
        Mon, 13 Feb 2023 15:06:46 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id EE5F22D807;
        Mon, 13 Feb 2023 15:06:45 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH 1/2] tty: new helper function tty_get_mget
Date:   Mon, 13 Feb 2023 15:06:37 +0100
Message-ID: <20230213140638.620206-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230213140638.620206-1-fe@dev.tdt.de>
References: <20230213140638.620206-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1676297207-8F7FCB00-141C17CC/0/0
X-purgate-type: clean
X-purgate: clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For a given struct tty_struct, this provides the appropriate tty line
state flags needed to add more modes to the ledtrig-tty trigger.

The new function is then used to get via tty_tiocmget() the different tty
line states.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/tty/tty_io.c | 32 +++++++++++++++++++++++++-------
 include/linux/tty.h  |  3 ++-
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3149114bf130..e4dc59eda43f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2493,26 +2493,44 @@ static int send_break(struct tty_struct *tty, uns=
igned int duration)
 	return retval;
 }
=20
+/*
+ * tty_get_mget		-	get modem status
+ * @tty: tty device
+ *
+ * Obtain the modem status bits from the tty driver if the feature
+ * is supported. Return -ENOTTY if it is not available.
+ *
+ */
+
+int tty_get_mget(struct tty_struct *tty)
+{
+	int retval =3D -ENOTTY;
+
+	if (tty->ops->tiocmget)
+		retval =3D tty->ops->tiocmget(tty);
+
+	return retval;
+}
+EXPORT_SYMBOL_GPL(tty_get_mget);
+
 /**
  * tty_tiocmget		-	get modem status
  * @tty: tty device
  * @p: pointer to result
  *
  * Obtain the modem status bits from the tty driver if the feature is
- * supported. Return -%ENOTTY if it is not available.
+ * supported.
  *
  * Locking: none (up to the driver)
  */
 static int tty_tiocmget(struct tty_struct *tty, int __user *p)
 {
-	int retval =3D -ENOTTY;
+	int retval;
=20
-	if (tty->ops->tiocmget) {
-		retval =3D tty->ops->tiocmget(tty);
+	retval =3D tty_get_mget(tty);
+	if (retval >=3D 0)
+		retval =3D put_user(retval, p);
=20
-		if (retval >=3D 0)
-			retval =3D put_user(retval, p);
-	}
 	return retval;
 }
=20
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 730c3301d710..9c1485c31081 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -419,8 +419,9 @@ void tty_unthrottle(struct tty_struct *tty);
 int tty_throttle_safe(struct tty_struct *tty);
 int tty_unthrottle_safe(struct tty_struct *tty);
 int tty_do_resize(struct tty_struct *tty, struct winsize *ws);
-int tty_get_icount(struct tty_struct *tty,
+int tty_get_icount(struct tty_struct *tty
 		struct serial_icounter_struct *icount);
+extern int tty_get_mget(struct tty_struct *tty);
 int is_current_pgrp_orphaned(void);
 void tty_hangup(struct tty_struct *tty);
 void tty_vhangup(struct tty_struct *tty);
--=20
2.30.2

