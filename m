Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334E269A87F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 10:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBQJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 04:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjBQJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 04:44:19 -0500
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8CD503;
        Fri, 17 Feb 2023 01:44:15 -0800 (PST)
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <prvs=942639ee83=fe@dev.tdt.de>)
        id 1pSxHm-000Dg5-Cu; Fri, 17 Feb 2023 10:44:10 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1pSxHl-0002St-LR; Fri, 17 Feb 2023 10:44:09 +0100
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 357B0240040;
        Fri, 17 Feb 2023 10:44:09 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id 9B55924004D;
        Fri, 17 Feb 2023 10:44:08 +0100 (CET)
Received: from localhost.localdomain (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 2609A2D99D;
        Fri, 17 Feb 2023 10:44:08 +0100 (CET)
From:   Florian Eckert <fe@dev.tdt.de>
To:     u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, pavel@ucw.cz, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Eckert.Florian@googlemail.com
Subject: [PATCH v2 2/2] trigger: ledtrig-tty: add additional modes
Date:   Fri, 17 Feb 2023 10:44:03 +0100
Message-ID: <20230217094403.1574468-3-fe@dev.tdt.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230217094403.1574468-1-fe@dev.tdt.de>
References: <20230217094403.1574468-1-fe@dev.tdt.de>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Content-Transfer-Encoding: quoted-printable
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1676627050-0EBEFD43-C8CBA2E2/0/0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the LED is flashed when data is transmitted. With a
legacy serial interface there are additional input signal lines.

CTS: Clear To Send       -> DCE is ready to accept data from the DTE
DSR: Data Set Ready      -> DCE is ready to receive and send data.
CAR: Data Carrier Detect -> DCE is receiving a carrier from a remote DCE.
RNG: Ring Indicator      -> DCE has detected an incoming ring on the line=
.

Add additional modes to trigger the selected LED.
The following modes are supported:

Tx/Rx:	Flash LED on data transmission (default)
CTS:	DCE Ready to accept data from the DTE.
DSR:	DCE is ready to receive and send data.
CAR:	DCE is receiving a carrier from a remote DTE.
RNG:	DCE has detected an incoming ring signal.

The mode can be changed for example with the following command:
echo "CTS" > /sys/class/leds/<led>/tty_led_mode

This would turn on the LED, when the DTE(modem) signals the DCE that it
is ready to accept data.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 .../ABI/testing/sysfs-class-led-trigger-tty   |  16 ++
 drivers/leds/trigger/ledtrig-tty.c            | 146 ++++++++++++++++--
 2 files changed, 147 insertions(+), 15 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Docu=
mentation/ABI/testing/sysfs-class-led-trigger-tty
index 2bf6b24e781b..31d62a5ae095 100644
--- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
+++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
@@ -4,3 +4,19 @@ KernelVersion:	5.10
 Contact:	linux-leds@vger.kernel.org
 Description:
 		Specifies the tty device name of the triggering tty
+
+What:		/sys/class/leds/<led>/mode
+Date:		January 2023
+KernelVersion:	6.3
+Description:
+		Specifies the operating to trigger the LED.
+		The following operating modes are supported:
+		Tx/Rx: Flash LED on data transmission (default)
+		CTS:   DCE Ready to accept data from the DTE.
+		       LED on if line is high.
+		DSR:   DCE is ready to receive and send data.
+		       LED on if line is high.
+		CAR:   DCE is receiving a carrier from a remote DTE.
+		       LED on if line is high.
+		RNG:   DCE has detected an incoming ring signal.
+		       LED on if line is high.
diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/le=
dtrig-tty.c
index f62db7e520b5..09d1be7b8ffb 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -7,6 +7,15 @@
 #include <linux/tty.h>
 #include <uapi/linux/serial.h>
=20
+enum tty_led_mode {
+	TTY_LED_CNT,
+	TTY_LED_CTS,
+	TTY_LED_DSR,
+	TTY_LED_CAR,
+	TTY_LED_RNG,
+	__TTY_LED_MAX
+};
+
 struct ledtrig_tty_data {
 	struct led_classdev *led_cdev;
 	struct delayed_work dwork;
@@ -14,6 +23,15 @@ struct ledtrig_tty_data {
 	const char *ttyname;
 	struct tty_struct *tty;
 	int rx, tx;
+	enum tty_led_mode mode;
+};
+
+static const char * const mode[] =3D {
+	[TTY_LED_CNT] =3D "Tx/Rx", // Trasmit Data / Receive Data
+	[TTY_LED_CTS] =3D "CTS", // CTS Clear To Send
+	[TTY_LED_DSR] =3D "DSR", // DSR Data Set Ready
+	[TTY_LED_CAR] =3D "CAR", // CAR Data Carrier Detect (DCD)
+	[TTY_LED_RNG] =3D "RNG", // RNG Ring Indicator (RI)
 };
=20
 static void ledtrig_tty_restart(struct ledtrig_tty_data *trigger_data)
@@ -21,6 +39,71 @@ static void ledtrig_tty_restart(struct ledtrig_tty_dat=
a *trigger_data)
 	schedule_delayed_work(&trigger_data->dwork, 0);
 }
=20
+static ssize_t ledtrig_tty_mode_show(char *buf, enum tty_led_mode tty_mo=
de)
+{
+	int len =3D 0;
+	int i;
+
+	for (i =3D 0; i < __TTY_LED_MAX; i++) {
+		bool hit;
+
+		hit =3D tty_mode =3D=3D i;
+		len +=3D sysfs_emit_at(buf, len, "%s%s%s",
+				  hit ? "[" : "",
+				  mode[i],
+				  hit ? "]" : "");
+
+		if (i < __TTY_LED_MAX - 1)
+			len +=3D sysfs_emit_at(buf, len, " ");
+	}
+
+	len +=3D sysfs_emit_at(buf, len, "\n");
+
+	return len;
+}
+
+static ssize_t tty_led_mode_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
+	enum tty_led_mode tty_mode;
+
+	mutex_lock(&trigger_data->mutex);
+	tty_mode =3D trigger_data->mode;
+	mutex_unlock(&trigger_data->mutex);
+
+	return ledtrig_tty_mode_show(buf, tty_mode);
+}
+
+static ssize_t tty_led_mode_store(struct device *dev,
+			  struct device_attribute *attr, const char *buf,
+			  size_t size)
+{
+	struct ledtrig_tty_data *trigger_data =3D led_trigger_get_drvdata(dev);
+	ssize_t ret =3D size;
+	enum tty_led_mode tty_mode =3D __TTY_LED_MAX;
+	int i;
+
+	/* Check for new line in string*/
+	if (size > 0 && buf[size - 1] =3D=3D '\n')
+		size -=3D 1;
+
+	for (i =3D 0; i < __TTY_LED_MAX; i++) {
+		if (strncmp(buf, mode[i], size) =3D=3D 0)
+			tty_mode =3D i;
+	}
+
+	if (tty_mode =3D=3D __TTY_LED_MAX)
+		return -EINVAL;
+
+	mutex_lock(&trigger_data->mutex);
+	trigger_data->mode =3D tty_mode;
+	mutex_unlock(&trigger_data->mutex);
+
+	return ret;
+}
+static DEVICE_ATTR_RW(tty_led_mode);
+
 static ssize_t ttyname_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -76,6 +159,18 @@ static ssize_t ttyname_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(ttyname);
=20
+static void ledtrig_tty_flags(struct ledtrig_tty_data *trigger_data,
+		unsigned int flag)
+{
+	unsigned int status;
+
+	status =3D tty_get_mget(trigger_data->tty);
+	if (status & flag)
+		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+	else
+		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
+}
+
 static void ledtrig_tty_work(struct work_struct *work)
 {
 	struct ledtrig_tty_data *trigger_data =3D
@@ -113,21 +208,38 @@ static void ledtrig_tty_work(struct work_struct *wo=
rk)
 		trigger_data->tty =3D tty;
 	}
=20
-	ret =3D tty_get_icount(trigger_data->tty, &icount);
-	if (ret) {
-		dev_info(trigger_data->tty->dev, "Failed to get icount, stopped pollin=
g\n");
-		mutex_unlock(&trigger_data->mutex);
-		return;
-	}
-
-	if (icount.rx !=3D trigger_data->rx ||
-	    icount.tx !=3D trigger_data->tx) {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
-
-		trigger_data->rx =3D icount.rx;
-		trigger_data->tx =3D icount.tx;
-	} else {
-		led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
+	switch (trigger_data->mode) {
+	case TTY_LED_CTS:
+		ledtrig_tty_flags(trigger_data, TIOCM_CTS);
+		break;
+	case TTY_LED_DSR:
+		ledtrig_tty_flags(trigger_data, TIOCM_DSR);
+		break;
+	case TTY_LED_CAR:
+		ledtrig_tty_flags(trigger_data, TIOCM_CAR);
+		break;
+	case TTY_LED_RNG:
+		ledtrig_tty_flags(trigger_data, TIOCM_RNG);
+		break;
+	case TTY_LED_CNT:
+	default:
+		ret =3D tty_get_icount(trigger_data->tty, &icount);
+		if (ret) {
+			dev_info(trigger_data->tty->dev, "Failed to get icount, stopped polli=
ng\n");
+			mutex_unlock(&trigger_data->mutex);
+			return;
+		}
+
+		if (icount.rx !=3D trigger_data->rx ||
+		    icount.tx !=3D trigger_data->tx) {
+			led_set_brightness_sync(trigger_data->led_cdev, LED_ON);
+
+			trigger_data->rx =3D icount.rx;
+			trigger_data->tx =3D icount.tx;
+		} else {
+			led_set_brightness_sync(trigger_data->led_cdev, LED_OFF);
+		}
+		break;
 	}
=20
 out:
@@ -137,6 +249,7 @@ static void ledtrig_tty_work(struct work_struct *work=
)
=20
 static struct attribute *ledtrig_tty_attrs[] =3D {
 	&dev_attr_ttyname.attr,
+	&dev_attr_tty_led_mode.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(ledtrig_tty);
@@ -149,6 +262,9 @@ static int ledtrig_tty_activate(struct led_classdev *=
led_cdev)
 	if (!trigger_data)
 		return -ENOMEM;
=20
+	/* set default mode */
+	trigger_data->mode =3D TTY_LED_CNT;
+
 	led_set_trigger_data(led_cdev, trigger_data);
=20
 	INIT_DELAYED_WORK(&trigger_data->dwork, ledtrig_tty_work);
--=20
2.30.2

