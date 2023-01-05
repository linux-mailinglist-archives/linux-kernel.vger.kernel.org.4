Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C923265F70A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjAEWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236225AbjAEWva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:51:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B50A5881E;
        Thu,  5 Jan 2023 14:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672959074; bh=RjBrwrzDF0HUQvM108jehXVM85PyLM9sDZAL/eCo9+M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C9bEvWCx2W8Vru8k/xxoqFq+fEoeBjgnMInhC7r5LI4XZju164jhgyLA7KVrOyeul
         RAwa1hUOkukbV0noUBlIC/9Y3lDopcVMFRhDAeBHV6B1EKXLDC+bi/oEPaNKKhOkah
         kTItynBceGjZwFMkzzIZLIpXjE8LJdwYZmxmXuj2yeOwp2CzmiAm06iO5Gc2UrR1K3
         uFzq8X/PuB6VGUNHVP1mPbFxbaxI4qbLHmbIVNUSwuMWkSzCHrfSJUqte3lT4PlIAp
         p4c6K4w+zUBkkLwsaKdUQRCL7WGtBssWnpbLGWo11C9ydmHghcctvR1UXMiN/n9lix
         7Tic554Hq2kXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MKsjH-1pVvPY3gRp-00LBJf; Thu, 05 Jan 2023 23:51:13 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp
Date:   Thu,  5 Jan 2023 23:51:06 +0100
Message-Id: <20230105225107.58308-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105225107.58308-1-W_Armin@gmx.de>
References: <20230105225107.58308-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qQrA4b148lSVLX8UdMqK/Gj8LX7LaLydj8KCi7RZ/PBspX/3Czh
 kQIRqlEarBb3wOPD2GXkhPe0BuA1cXF+K/fO5oMhClGoI2u7Bc+wYym1b/vfuHq79GwWsjs
 //oYI+1i5Mom5sA0skXIO4Yv/piHe8NkU12+/ddN4kVpFqxGcLMb6FsVD9J7i/LJjFdUt5e
 BKV2X5ikDc2fJqrlpdmog==
UI-OutboundReport: notjunk:1;M01:P0:67q0j3DOJHo=;cAMZ8cvMj/epiNtrS5c4MF/IjTF
 FycRaiDshPKslNucIYNze+i0KZehZrr3OH/Qi8FGHCyIJqpH+Q4yFklP+9B7Rg0dP+6coYaHm
 gG7xq4oEC1dRuxxlDp8SY8+HHXqapt7zu79nzQFHY5KKQz26he1AXlfA3Xj+onrs+0hpjttFD
 xAykjAAsnG4g2WQaRMr4eqfPsohJsS0+kPGRilkQDGNDycHIT4dhHeNkic6OKZhS6gnuUxDXc
 JBIx+HG8B2gHdXixcgUtoLjT+SnbDTRtdz1wZvXhU3CVZFVghF5nmQ42d9G10BYqRbTfxghH+
 HSpSFE7jKSOukYv5e5PfnymDVwyA1FYZdB2pIycZhGr8QStPl7I6lCvFaqjp0F/nCkB3W1unj
 +0V1Fkld4f/ZQ8BPrKDc3XQOAbRQMxe3xKX5r8c+0OxgjkPR07dFqOLXjaC9pxL/xWs+dT11z
 6UhzmBJyDwiDaShBAbLkmAGeRdJjBXCJrHvaAD6nzfeJCgdH+rmh/UhuJneZWYJaAcXmQU1Ys
 gFGMtjfpFBY5G3IZoExErLQ6ryKqqTT/mB57VoMk9hGVM3mSZ+Y2p6g+fmXt6OCCyjT/1b5cO
 BXXvI9ONURVUTaEZOPAYIqzxrak+uBK+ozVUQAvgN5+GZJ0kL7kIj8z8jFC7XDicrzA1FE9I8
 /9hihkvz9kUwXhDMZngqyTIF3IP2TEH6qCQ1VaxOf7ASp7qtvXku8gp85EnQS9Ibs6o+03+OG
 MYNX+u25jVKynNdOcLqtzwKXH9vJ4Kka6IL2k7bCCo/lvoxoM7Nn+PTQheUFFYe4/YLdZH/uf
 swjSCdOOd/Wkuw8v38b7hrWU23V2povnnJSJ49EqAKHwGoUZu1Si++KaZvpPuVCmuHzwTu3Nz
 tT/qwjUSHwvKlLa8SxtohekhG2mrF8vnzSzAyF4k6LinCLF1T60SCnWjqwR51uMoPAi9v9XzO
 YpVp4uBbINcWDtD416dJ+CZupPg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the nonstandard fanX_source attributes with the standardized
pwmX_auto_channels_temp attributes and document the special behaviour
associated with those attributes.

Tested on a Fujitsu DS3401-B1.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/ftsteutates.rst |  5 ++
 drivers/hwmon/ftsteutates.c         | 77 +++++++++++------------------
 2 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/Documentation/hwmon/ftsteutates.rst b/Documentation/hwmon/fts=
teutates.rst
index 198fa8e2819d..b3bfec36661d 100644
=2D-- a/Documentation/hwmon/ftsteutates.rst
+++ b/Documentation/hwmon/ftsteutates.rst
@@ -22,6 +22,11 @@ enhancements. It can monitor up to 4 voltages, 16 tempe=
ratures and
 8 fans. It also contains an integrated watchdog which is currently
 implemented in this driver.

+The ``pwmX_auto_channels_temp`` attributes show which temperature sensor
+is currently driving which fan channel. This value might dynamically chan=
ge
+during runtime depending on the temperature sensor selected by
+the fan control circuit.
+
 The 4 voltages require a board-specific multiplier, since the BMC can
 only measure voltages up to 3.3V and thus relies on voltage dividers.
 Consult your motherboard manual for details.
diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index 23dc3a74f84b..0d8ab94250a9 100644
=2D-- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -6,9 +6,7 @@
  *		  Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>
  */
 #include <linux/err.h>
-#include <linux/fs.h>
 #include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
@@ -16,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/watchdog.h>

 #define FTS_DEVICE_ID_REG		0x0000
@@ -48,6 +45,8 @@
 #define FTS_NO_TEMP_SENSORS		0x10
 #define FTS_NO_VOLT_SENSORS		0x04

+#define FTS_FAN_SOURCE_INVALID		0xff
+
 static const unsigned short normal_i2c[] =3D { 0x73, I2C_CLIENT_END };

 static const struct i2c_device_id fts_id[] =3D {
@@ -187,7 +186,7 @@ static int fts_update_device(struct fts_data *data)
 			data->fan_source[i] =3D err;
 		} else {
 			data->fan_input[i] =3D 0;
-			data->fan_source[i] =3D 0;
+			data->fan_source[i] =3D FTS_FAN_SOURCE_INVALID;
 		}
 	}

@@ -339,50 +338,6 @@ static int fts_watchdog_init(struct fts_data *data)
 	return devm_watchdog_register_device(&data->client->dev, &data->wdd);
 }

-static ssize_t fan_source_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
-
-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
-
-	return sprintf(buf, "%u\n", data->fan_source[index]);
-}
-
-static SENSOR_DEVICE_ATTR_RO(fan1_source, fan_source, 0);
-static SENSOR_DEVICE_ATTR_RO(fan2_source, fan_source, 1);
-static SENSOR_DEVICE_ATTR_RO(fan3_source, fan_source, 2);
-static SENSOR_DEVICE_ATTR_RO(fan4_source, fan_source, 3);
-static SENSOR_DEVICE_ATTR_RO(fan5_source, fan_source, 4);
-static SENSOR_DEVICE_ATTR_RO(fan6_source, fan_source, 5);
-static SENSOR_DEVICE_ATTR_RO(fan7_source, fan_source, 6);
-static SENSOR_DEVICE_ATTR_RO(fan8_source, fan_source, 7);
-
-static struct attribute *fts_fan_attrs[] =3D {
-	&sensor_dev_attr_fan1_source.dev_attr.attr,
-	&sensor_dev_attr_fan2_source.dev_attr.attr,
-	&sensor_dev_attr_fan3_source.dev_attr.attr,
-	&sensor_dev_attr_fan4_source.dev_attr.attr,
-	&sensor_dev_attr_fan5_source.dev_attr.attr,
-	&sensor_dev_attr_fan6_source.dev_attr.attr,
-	&sensor_dev_attr_fan7_source.dev_attr.attr,
-	&sensor_dev_attr_fan8_source.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group fts_attr_group =3D {
-	.attrs =3D fts_fan_attrs
-};
-
-static const struct attribute_group *fts_attr_groups[] =3D {
-	&fts_attr_group,
-	NULL
-};
-
 static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_type=
s type, u32 attr,
 			      int channel)
 {
@@ -408,6 +363,7 @@ static umode_t fts_is_visible(const void *devdata, enu=
m hwmon_sensor_types type,
 			break;
 		}
 		break;
+	case hwmon_pwm:
 	case hwmon_in:
 		return 0444;
 	default:
@@ -460,6 +416,19 @@ static int fts_read(struct device *dev, enum hwmon_se=
nsor_types type, u32 attr,
 			break;
 		}
 		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			if (data->fan_source[channel] =3D=3D FTS_FAN_SOURCE_INVALID)
+				*val =3D 0;
+			else
+				*val =3D BIT(data->fan_source[channel]);
+
+			return 0;
+		default:
+			break;
+		}
+		break;
 	case hwmon_in:
 		switch (attr) {
 		case hwmon_in_input:
@@ -576,6 +545,16 @@ static const struct hwmon_channel_info *fts_info[] =
=3D {
 			   HWMON_F_INPUT | HWMON_F_ALARM,
 			   HWMON_F_INPUT | HWMON_F_ALARM
 			   ),
+	HWMON_CHANNEL_INFO(pwm,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP,
+			   HWMON_PWM_AUTO_CHANNELS_TEMP
+			   ),
 	HWMON_CHANNEL_INFO(in,
 			   HWMON_I_INPUT,
 			   HWMON_I_INPUT,
@@ -672,7 +651,7 @@ static int fts_probe(struct i2c_client *client)
 	revision =3D err;

 	hwmon_dev =3D devm_hwmon_device_register_with_info(&client->dev, "ftsteu=
tates", data,
-							 &fts_chip_info, fts_attr_groups);
+							 &fts_chip_info, NULL);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);

=2D-
2.30.2

