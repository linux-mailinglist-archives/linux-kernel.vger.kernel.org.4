Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7309C65EE9C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjAEOTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:19:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjAEOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:19:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ED0D2D7;
        Thu,  5 Jan 2023 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672928361; bh=RjBrwrzDF0HUQvM108jehXVM85PyLM9sDZAL/eCo9+M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dGdcS26gJuZZ2JM/TaqRQOhLZAgS1TuCf57XTUmX8pFkmv/FMWLqCntIG0gqsljr0
         +CUM1VAN35giGtNP7GRLyuHqyrPc6dw4M4BI/bVLOj6WafjP1B0cEVcLwaMSdgee7s
         kK1zZPS0RXIXzrLiNlT1FP/m/ewwaQwLchhQhiMn+y8xsH88MRMw6yPquz8r8oyLHS
         VOibJwiOoqMw1SuVbHPO91hsToSWUn4lyAlnWL2lErsARXu09wD4ZINVMEJow97ScX
         t5xId2KmWgwehzO+hdkAvGKOgNzA9XBYeY0F5YVXUfsAyc5Vsal0aMoJxNb5fEA/lt
         bbhRz12AxklwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvK4f-1ovuIq1zWL-00rFUK; Thu, 05 Jan 2023 15:19:21 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (ftsteutates) Replace fanX_source with pwmX_auto_channels_temp
Date:   Thu,  5 Jan 2023 15:19:10 +0100
Message-Id: <20230105141911.8040-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105141911.8040-1-W_Armin@gmx.de>
References: <20230105141911.8040-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ru50W+qdfPb9At5rpiAcQ5PdK4qBfkTaf7yQw/v1zIQjyl4cADr
 amESEKh6KNh9AWnic4KBzSh/J0YYBr9YyUZNzSkt4jSxzwStaMrEfK6yAIzABnlrOPjydm4
 Xqeg2bbhvgIG6GFMlsY1UjJbzHvo2UtS3sOqySgPn8dIakPgAPfsRz9xoiB5q8mt/cAUPC/
 wKAYGdXOvQsFkR0AQSzWw==
UI-OutboundReport: notjunk:1;M01:P0:PxaAWqHeM6g=;SWd6Qu6SZI1o6VOv1PHvjsrU6Eg
 h9BDAu0MIk5FkTqEjEQtzUz3Lb7+hqUvhLu+3VjhXMfbEYoo9TX/lB4Di2kb8a6y6IlWWE2M7
 lgiwJv+kw6PFDGucY8ZxBYEWoGxEzCasPHkP2NBO/IXD2YB9+8hqSnU3CnEDJ3VX1xl3Q0F40
 d6g/+afX2XZp6jHJDcmXDmXOTc2eYAw0+Edhy1M3vrWcAg4Kw23xu/XqR6JIMagB13VQXd4N4
 6oYw5RSGrPnGt8MA2LUSNEUvEO+Pv/xH/ywXtNcxuKShZ7QDAhg/lFcvE9KGG1DV8C7JzjWTN
 4gIdu+7qT6kJewHLppPZ2eKcDAetaA/yuXu47+GDlEynBeX71zZ5YYFOXPQ2fgUrw7+foK+CS
 eT3Vd6rW/j06fgc9XKMVMMQkw6HG6DkMtBlTqjJajnOtb+p7WNMRU9RsSxQ9EB9VNHzZip0lB
 heZIwtjKCsPyaKhtwNVVMlpC3ihHNBR8LiDSV4Gz4gUyLePHSy3Hg3NOBnpckdmWxC99VOeqU
 pyGdiuQKHV3imaoU5L7eZLGFGgvzMr5H1p4Ho1jf4d9UVJxYxz+BO8oMUfSKOB10MzYHjhvl0
 lY3H7CaqM4JzsurLEKDPpOcEnftMXMDJg6k1JY8HkLDvTydblYOr/1/fM1BAw7+tYj+BEqZXC
 +L0B8ir1NCtQXXFRc2pV9FPHs0CCI89cdpiJH6P6MhnUyxLDqB8JK82UPCc5furwUtyFoZvvQ
 tnMTB5GraZN+Gpcwm5MFakqmQF+vEsykSNH9gvl7OWKKAMA0LLHYDBKP70u0AdnzF4rU4ivGO
 h/bdTD7JzNM69/mHp39PJtczEOFfzDX7m7wJ8A0hNUXbbCpPbgVsvoGNO1bcaq/6nC/rNzdM5
 Pnk9HxJnYLnc+ALv6gbuy1wJpTIo8YNUYaOl3QZioLOWkFOls7WYCzUpNTdFAsZ+MZx688/ym
 tM/t0LO8bH8TIRl5rnPfqonr4MU=
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

