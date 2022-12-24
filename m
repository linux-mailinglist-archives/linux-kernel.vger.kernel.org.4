Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C951565585E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 05:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiLXETi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 23:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbiLXETW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 23:19:22 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD8A1CB2B;
        Fri, 23 Dec 2022 20:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671855542; bh=/tRXz9aYe4Pmn1vdD0AQ+oz0FQUg69o7dSHZfY9/rik=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Hv8plgAk0JwpLfsXSOW2NtFXA8z/rYCtd8XN62Eun/tDEltuGP74En0oRNDA1D9Kg
         1kMjb4pruo74R1FMNmkLDHjTO5m9UGoZES9CkczB8QPYTrc9dO2zcxHm98vp/LPwjr
         UVpojsnfL+xAdYPU1JRJ3T/RBt2ywq1d5EU52UfDoUeIj4HTrwxnNDzJvIclcMsyGj
         Trj/G5trhcejc2xo4ZwI+d+w44XLng2r8/NZUJfulj//7UV3grrMbcE3O6AenakPxh
         XF1aPZRQa1atylH1yHFUU4JBmtrJmiM6viYwTlapnDAM51VibEBaLbebIyFgBMWi8v
         p3Rh63QCGyjdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MryXN-1oUal11PHx-00o0BO; Sat, 24 Dec 2022 05:19:02 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
Date:   Sat, 24 Dec 2022 05:18:54 +0100
Message-Id: <20221224041855.83981-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221224041855.83981-1-W_Armin@gmx.de>
References: <20221224041855.83981-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aO1HGWIBKGYX5ppdudRLihuwS5LJeS2CB60HwmTHFJews99cphG
 2HY1X9pLjYgrH/xEfIY9M2bvgpG4FG486fb5aAJKbQXjZp16nsYQy1Dk3rLS5iJl8mc93jr
 DyFM+9eNxT8o4A00P6sMI0mJ8+6BowNPhC/ttnzq6W0HsYfy7ibI+fJi0lJRoBJ8HVPLQRa
 En7Of6bx3Y1VrJFhhcBeQ==
UI-OutboundReport: notjunk:1;M01:P0:N1vhtfM+GeA=;pDqDe9Nrh45t0cRZkrFwcBHm+yZ
 3NM/r+rFREehr85YTNNZWnfGe0ppDriXBStK49ZPqJjtRfEOu+veTj4vrRaK6h7BH01pe5ObE
 JwPFh9BCJYmq1jmBfuhK3kAPvplsHC6Nd2ZOS2apAfqbdBlhNsf00YK6uatIU8LmjeX0WRU1x
 SnvAeSc0p6jh2+WwbmruYSsEQCVD6mLeud7IWdF6uZxNg+1X7j7gGxQvp2onDCzdotLb71d/C
 pegLOMZzGB4GFtvIjpIVJcVNHRpT0sPte0VWG/FUhFb3pzQIm7MUNrz8fx48WBYY1cO/i5m5Y
 0yuiUIg5a0sMkNP1h9E4oSxhV/WAI7QZaxHF2mPDe7DBme3mW6ymE4oF8X5b/3Z9R9VBX/yae
 nESuiZipN5JI+ijyUk6AYzzppwTKvVqTwmqJT+UwNRTtjPEL6Wf/3R4sDBKJJa0sZHZs51NQp
 GXhiL3Fkray5Q4UY+QSsHrO/+X1ufANcOm5o6oXLWVzDQGrg5mjP8gXMRoKpV3ZasAaV6WSY+
 nq1keei0LpmnkmeN++kvDEKHTGYfagY1uC/aCz1YZ6x6MKBW76IMTbve8r2IPHue1Vbi96Apw
 MqO4hwqJ3uck0tUhFaDVPv3GOWflaniLOkSYay7vnZuYpHvw8bIO18o3sfbl2Amj+t+TXrpQ4
 X+QEMheUAjWIyH0tcRY48mrG2PYYq2HRzJDPOMcto69r0ZlsG4Iua+wiIC3s9JN0M9j7zuLsK
 pP8WrpL/WuB2SW1DN9tqNCHeqHiddE5Twpl6CO/XzyE1ZD9ntVPbPsU+EaWV5cD0ZIm6MA2LJ
 zMXpgHrLADpq02zmhQwwnpHibtwA9B5mNXOlFgH07UM/XB3NcEmH9hkohsrJYgEDdMJNW2Z8d
 nzHhiMBXeIlKsGxaqN0LT8P5XrHEe6kf4QP75WQcamrj3oT52SD3jkBnALFEWewmJ4h0t943t
 +AHfRXeTjvJ2FIbXOA8bSXR8mO0=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert driver to use devm_hwmon_device_register_with_info()
to reduce module size by 40%. The non-standard fan_source
attribute is replaced with the standard pwmX_auto_channels_temp
attribute and its special behaviour being documented.
Also export fan present status as fanX_fault.

Tested on a Fujitsu DS3401-B1.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/hwmon/ftsteutates.rst |   5 +
 drivers/hwmon/ftsteutates.c         | 546 ++++++++++------------------
 2 files changed, 207 insertions(+), 344 deletions(-)

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
index ffa0bb364877..66ff8d69a0de 100644
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
@@ -16,8 +14,6 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>

 #define FTS_DEVICE_ID_REG		0x0000
@@ -340,376 +336,240 @@ static int fts_watchdog_init(struct fts_data *data=
)
 	return watchdog_register_device(&data->wdd);
 }

-/************************************************************************=
*****/
-/* SysFS handler functions						     */
-/************************************************************************=
*****/
-static ssize_t in_value_show(struct device *dev,
-			     struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int value, err;
-
-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
-
-	value =3D DIV_ROUND_CLOSEST(data->volt[index] * 3300, 255);
-
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t temp_value_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int value, err;
-
-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
-
-	value =3D (data->temp_input[index] - 64) * 1000;
-
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t temp_fault_show(struct device *dev,
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
-	/* 00h Temperature =3D Sensor Error */
-	return sprintf(buf, "%d\n", data->temp_input[index] =3D=3D 0);
-}
-
-static ssize_t temp_alarm_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
+static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_type=
s type, u32 attr,
+			      int channel)
 {
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
-
-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+		case hwmon_temp_fault:
+			return 0444;
+		case hwmon_temp_alarm:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+		case hwmon_fan_fault:
+			return 0444;
+		case hwmon_fan_alarm:
+			return 0644;
+		default:
+			break;
+		}
+		break;
+	case hwmon_pwm:
+	case hwmon_in:
+		return 0444;
+	default:
+		break;
+	}

-	return sprintf(buf, "%u\n", !!(data->temp_alarm & BIT(index)));
+	return 0;
 }

-static ssize_t
-temp_alarm_store(struct device *dev, struct device_attribute *devattr,
-		 const char *buf, size_t count)
+static int fts_read(struct device *dev, enum hwmon_sensor_types type, u32=
 attr, int channel,
+		    long *val)
 {
 	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	long ret;
+	int ret =3D fts_update_device(data);

-	ret =3D fts_update_device(data);
 	if (ret < 0)
 		return ret;

-	if (kstrtoul(buf, 10, &ret) || ret !=3D 0)
-		return -EINVAL;
-
-	mutex_lock(&data->update_lock);
-	ret =3D fts_read_byte(data->client, FTS_REG_TEMP_CONTROL(index));
-	if (ret < 0)
-		goto error;
-
-	ret =3D fts_write_byte(data->client, FTS_REG_TEMP_CONTROL(index),
-			     ret | 0x1);
-	if (ret < 0)
-		goto error;
-
-	data->valid =3D false;
-	ret =3D count;
-error:
-	mutex_unlock(&data->update_lock);
-	return ret;
-}
-
-static ssize_t fan_value_show(struct device *dev,
-			      struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int value, err;
-
-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			*val =3D (data->temp_input[channel] - 64) * 1000;

-	value =3D data->fan_input[index] * 60;
+			return 0;
+		case hwmon_temp_alarm:
+			*val =3D !!(data->temp_alarm & BIT(channel));

-	return sprintf(buf, "%d\n", value);
-}
+			return 0;
+		case hwmon_temp_fault:
+			/* 00h Temperature =3D Sensor Error */;
+			*val =3D (data->temp_input[channel] =3D=3D 0);

-static ssize_t fan_source_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			*val =3D data->fan_input[channel] * 60;

-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
+			return 0;
+		case hwmon_fan_alarm:
+			*val =3D !!(data->fan_alarm & BIT(channel));

-	return sprintf(buf, "%u\n", data->fan_source[index]);
-}
+			return 0;
+		case hwmon_fan_fault:
+			*val =3D !(data->fan_present & BIT(channel));

-static ssize_t fan_alarm_show(struct device *dev,
-			      struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_auto_channels_temp:
+			if (data->fan_source[channel] =3D=3D 0xff)
+				*val =3D 0;
+			else
+				*val =3D BIT(data->fan_source[channel]);
+
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_input:
+			*val =3D DIV_ROUND_CLOSEST(data->volt[channel] * 3300, 255);

-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}

-	return sprintf(buf, "%d\n", !!(data->fan_alarm & BIT(index)));
+	return -EOPNOTSUPP;
 }

-static ssize_t
-fan_alarm_store(struct device *dev, struct device_attribute *devattr,
-		const char *buf, size_t count)
+static int fts_write(struct device *dev, enum hwmon_sensor_types type, u3=
2 attr, int channel,
+		     long val)
 {
 	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	long ret;
+	int ret =3D fts_update_device(data);

-	ret =3D fts_update_device(data);
 	if (ret < 0)
 		return ret;

-	if (kstrtoul(buf, 10, &ret) || ret !=3D 0)
-		return -EINVAL;
-
-	mutex_lock(&data->update_lock);
-	ret =3D fts_read_byte(data->client, FTS_REG_FAN_CONTROL(index));
-	if (ret < 0)
-		goto error;
-
-	ret =3D fts_write_byte(data->client, FTS_REG_FAN_CONTROL(index),
-			     ret | 0x1);
-	if (ret < 0)
-		goto error;
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_alarm:
+			if (val)
+				return -EINVAL;
+
+			mutex_lock(&data->update_lock);
+			ret =3D fts_read_byte(data->client, FTS_REG_TEMP_CONTROL(channel));
+			if (ret >=3D 0)
+				ret =3D fts_write_byte(data->client, FTS_REG_TEMP_CONTROL(channel),
+						     ret | 0x1);
+			if (ret >=3D 0)
+				data->valid =3D false;
+
+			mutex_unlock(&data->update_lock);
+			if (ret < 0)
+				return ret;
+
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_alarm:
+			if (val)
+				return -EINVAL;
+
+			mutex_lock(&data->update_lock);
+			ret =3D fts_read_byte(data->client, FTS_REG_FAN_CONTROL(channel));
+			if (ret >=3D 0)
+				ret =3D fts_write_byte(data->client, FTS_REG_FAN_CONTROL(channel),
+						     ret | 0x1);
+			if (ret >=3D 0)
+				data->valid =3D false;
+
+			mutex_unlock(&data->update_lock);
+			if (ret < 0)
+				return ret;
+
+			return 0;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}

-	data->valid =3D false;
-	ret =3D count;
-error:
-	mutex_unlock(&data->update_lock);
-	return ret;
+	return -EOPNOTSUPP;
 }

-/************************************************************************=
*****/
-/* SysFS structs							     */
-/************************************************************************=
*****/
-
-/* Temperature sensors */
-static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_value, 0);
-static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_value, 1);
-static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_value, 2);
-static SENSOR_DEVICE_ATTR_RO(temp4_input, temp_value, 3);
-static SENSOR_DEVICE_ATTR_RO(temp5_input, temp_value, 4);
-static SENSOR_DEVICE_ATTR_RO(temp6_input, temp_value, 5);
-static SENSOR_DEVICE_ATTR_RO(temp7_input, temp_value, 6);
-static SENSOR_DEVICE_ATTR_RO(temp8_input, temp_value, 7);
-static SENSOR_DEVICE_ATTR_RO(temp9_input, temp_value, 8);
-static SENSOR_DEVICE_ATTR_RO(temp10_input, temp_value, 9);
-static SENSOR_DEVICE_ATTR_RO(temp11_input, temp_value, 10);
-static SENSOR_DEVICE_ATTR_RO(temp12_input, temp_value, 11);
-static SENSOR_DEVICE_ATTR_RO(temp13_input, temp_value, 12);
-static SENSOR_DEVICE_ATTR_RO(temp14_input, temp_value, 13);
-static SENSOR_DEVICE_ATTR_RO(temp15_input, temp_value, 14);
-static SENSOR_DEVICE_ATTR_RO(temp16_input, temp_value, 15);
-
-static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
-static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
-static SENSOR_DEVICE_ATTR_RO(temp3_fault, temp_fault, 2);
-static SENSOR_DEVICE_ATTR_RO(temp4_fault, temp_fault, 3);
-static SENSOR_DEVICE_ATTR_RO(temp5_fault, temp_fault, 4);
-static SENSOR_DEVICE_ATTR_RO(temp6_fault, temp_fault, 5);
-static SENSOR_DEVICE_ATTR_RO(temp7_fault, temp_fault, 6);
-static SENSOR_DEVICE_ATTR_RO(temp8_fault, temp_fault, 7);
-static SENSOR_DEVICE_ATTR_RO(temp9_fault, temp_fault, 8);
-static SENSOR_DEVICE_ATTR_RO(temp10_fault, temp_fault, 9);
-static SENSOR_DEVICE_ATTR_RO(temp11_fault, temp_fault, 10);
-static SENSOR_DEVICE_ATTR_RO(temp12_fault, temp_fault, 11);
-static SENSOR_DEVICE_ATTR_RO(temp13_fault, temp_fault, 12);
-static SENSOR_DEVICE_ATTR_RO(temp14_fault, temp_fault, 13);
-static SENSOR_DEVICE_ATTR_RO(temp15_fault, temp_fault, 14);
-static SENSOR_DEVICE_ATTR_RO(temp16_fault, temp_fault, 15);
-
-static SENSOR_DEVICE_ATTR_RW(temp1_alarm, temp_alarm, 0);
-static SENSOR_DEVICE_ATTR_RW(temp2_alarm, temp_alarm, 1);
-static SENSOR_DEVICE_ATTR_RW(temp3_alarm, temp_alarm, 2);
-static SENSOR_DEVICE_ATTR_RW(temp4_alarm, temp_alarm, 3);
-static SENSOR_DEVICE_ATTR_RW(temp5_alarm, temp_alarm, 4);
-static SENSOR_DEVICE_ATTR_RW(temp6_alarm, temp_alarm, 5);
-static SENSOR_DEVICE_ATTR_RW(temp7_alarm, temp_alarm, 6);
-static SENSOR_DEVICE_ATTR_RW(temp8_alarm, temp_alarm, 7);
-static SENSOR_DEVICE_ATTR_RW(temp9_alarm, temp_alarm, 8);
-static SENSOR_DEVICE_ATTR_RW(temp10_alarm, temp_alarm, 9);
-static SENSOR_DEVICE_ATTR_RW(temp11_alarm, temp_alarm, 10);
-static SENSOR_DEVICE_ATTR_RW(temp12_alarm, temp_alarm, 11);
-static SENSOR_DEVICE_ATTR_RW(temp13_alarm, temp_alarm, 12);
-static SENSOR_DEVICE_ATTR_RW(temp14_alarm, temp_alarm, 13);
-static SENSOR_DEVICE_ATTR_RW(temp15_alarm, temp_alarm, 14);
-static SENSOR_DEVICE_ATTR_RW(temp16_alarm, temp_alarm, 15);
-
-static struct attribute *fts_temp_attrs[] =3D {
-	&sensor_dev_attr_temp1_input.dev_attr.attr,
-	&sensor_dev_attr_temp2_input.dev_attr.attr,
-	&sensor_dev_attr_temp3_input.dev_attr.attr,
-	&sensor_dev_attr_temp4_input.dev_attr.attr,
-	&sensor_dev_attr_temp5_input.dev_attr.attr,
-	&sensor_dev_attr_temp6_input.dev_attr.attr,
-	&sensor_dev_attr_temp7_input.dev_attr.attr,
-	&sensor_dev_attr_temp8_input.dev_attr.attr,
-	&sensor_dev_attr_temp9_input.dev_attr.attr,
-	&sensor_dev_attr_temp10_input.dev_attr.attr,
-	&sensor_dev_attr_temp11_input.dev_attr.attr,
-	&sensor_dev_attr_temp12_input.dev_attr.attr,
-	&sensor_dev_attr_temp13_input.dev_attr.attr,
-	&sensor_dev_attr_temp14_input.dev_attr.attr,
-	&sensor_dev_attr_temp15_input.dev_attr.attr,
-	&sensor_dev_attr_temp16_input.dev_attr.attr,
-
-	&sensor_dev_attr_temp1_fault.dev_attr.attr,
-	&sensor_dev_attr_temp2_fault.dev_attr.attr,
-	&sensor_dev_attr_temp3_fault.dev_attr.attr,
-	&sensor_dev_attr_temp4_fault.dev_attr.attr,
-	&sensor_dev_attr_temp5_fault.dev_attr.attr,
-	&sensor_dev_attr_temp6_fault.dev_attr.attr,
-	&sensor_dev_attr_temp7_fault.dev_attr.attr,
-	&sensor_dev_attr_temp8_fault.dev_attr.attr,
-	&sensor_dev_attr_temp9_fault.dev_attr.attr,
-	&sensor_dev_attr_temp10_fault.dev_attr.attr,
-	&sensor_dev_attr_temp11_fault.dev_attr.attr,
-	&sensor_dev_attr_temp12_fault.dev_attr.attr,
-	&sensor_dev_attr_temp13_fault.dev_attr.attr,
-	&sensor_dev_attr_temp14_fault.dev_attr.attr,
-	&sensor_dev_attr_temp15_fault.dev_attr.attr,
-	&sensor_dev_attr_temp16_fault.dev_attr.attr,
-
-	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp4_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp5_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp6_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp7_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp8_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp9_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp10_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp11_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp12_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp13_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp14_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp15_alarm.dev_attr.attr,
-	&sensor_dev_attr_temp16_alarm.dev_attr.attr,
-	NULL
-};
-
-/* Fans */
-static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_value, 0);
-static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_value, 1);
-static SENSOR_DEVICE_ATTR_RO(fan3_input, fan_value, 2);
-static SENSOR_DEVICE_ATTR_RO(fan4_input, fan_value, 3);
-static SENSOR_DEVICE_ATTR_RO(fan5_input, fan_value, 4);
-static SENSOR_DEVICE_ATTR_RO(fan6_input, fan_value, 5);
-static SENSOR_DEVICE_ATTR_RO(fan7_input, fan_value, 6);
-static SENSOR_DEVICE_ATTR_RO(fan8_input, fan_value, 7);
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
-static SENSOR_DEVICE_ATTR_RW(fan1_alarm, fan_alarm, 0);
-static SENSOR_DEVICE_ATTR_RW(fan2_alarm, fan_alarm, 1);
-static SENSOR_DEVICE_ATTR_RW(fan3_alarm, fan_alarm, 2);
-static SENSOR_DEVICE_ATTR_RW(fan4_alarm, fan_alarm, 3);
-static SENSOR_DEVICE_ATTR_RW(fan5_alarm, fan_alarm, 4);
-static SENSOR_DEVICE_ATTR_RW(fan6_alarm, fan_alarm, 5);
-static SENSOR_DEVICE_ATTR_RW(fan7_alarm, fan_alarm, 6);
-static SENSOR_DEVICE_ATTR_RW(fan8_alarm, fan_alarm, 7);
-
-static struct attribute *fts_fan_attrs[] =3D {
-	&sensor_dev_attr_fan1_input.dev_attr.attr,
-	&sensor_dev_attr_fan2_input.dev_attr.attr,
-	&sensor_dev_attr_fan3_input.dev_attr.attr,
-	&sensor_dev_attr_fan4_input.dev_attr.attr,
-	&sensor_dev_attr_fan5_input.dev_attr.attr,
-	&sensor_dev_attr_fan6_input.dev_attr.attr,
-	&sensor_dev_attr_fan7_input.dev_attr.attr,
-	&sensor_dev_attr_fan8_input.dev_attr.attr,
-
-	&sensor_dev_attr_fan1_source.dev_attr.attr,
-	&sensor_dev_attr_fan2_source.dev_attr.attr,
-	&sensor_dev_attr_fan3_source.dev_attr.attr,
-	&sensor_dev_attr_fan4_source.dev_attr.attr,
-	&sensor_dev_attr_fan5_source.dev_attr.attr,
-	&sensor_dev_attr_fan6_source.dev_attr.attr,
-	&sensor_dev_attr_fan7_source.dev_attr.attr,
-	&sensor_dev_attr_fan8_source.dev_attr.attr,
-
-	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan6_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan7_alarm.dev_attr.attr,
-	&sensor_dev_attr_fan8_alarm.dev_attr.attr,
-	NULL
+static const struct hwmon_ops fts_ops =3D {
+	.is_visible =3D fts_is_visible,
+	.read =3D fts_read,
+	.write =3D fts_write,
 };

-/* Voltages */
-static SENSOR_DEVICE_ATTR_RO(in1_input, in_value, 0);
-static SENSOR_DEVICE_ATTR_RO(in2_input, in_value, 1);
-static SENSOR_DEVICE_ATTR_RO(in3_input, in_value, 2);
-static SENSOR_DEVICE_ATTR_RO(in4_input, in_value, 3);
-static struct attribute *fts_voltage_attrs[] =3D {
-	&sensor_dev_attr_in1_input.dev_attr.attr,
-	&sensor_dev_attr_in2_input.dev_attr.attr,
-	&sensor_dev_attr_in3_input.dev_attr.attr,
-	&sensor_dev_attr_in4_input.dev_attr.attr,
+static const struct hwmon_channel_info *fts_info[] =3D {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
+			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT
+			   ),
+	HWMON_CHANNEL_INFO(fan,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT
+			   ),
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
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT
+			   ),
 	NULL
 };

-static const struct attribute_group fts_voltage_attr_group =3D {
-	.attrs =3D fts_voltage_attrs
-};
-
-static const struct attribute_group fts_temp_attr_group =3D {
-	.attrs =3D fts_temp_attrs
-};
-
-static const struct attribute_group fts_fan_attr_group =3D {
-	.attrs =3D fts_fan_attrs
-};
-
-static const struct attribute_group *fts_attr_groups[] =3D {
-	&fts_voltage_attr_group,
-	&fts_temp_attr_group,
-	&fts_fan_attr_group,
-	NULL
+static const struct hwmon_chip_info fts_chip_info =3D {
+	.ops =3D &fts_ops,
+	.info =3D fts_info,
 };

 /************************************************************************=
*****/
@@ -800,10 +660,8 @@ static int fts_probe(struct i2c_client *client)
 		return err;
 	revision =3D err;

-	hwmon_dev =3D devm_hwmon_device_register_with_groups(&client->dev,
-							   "ftsteutates",
-							   data,
-							   fts_attr_groups);
+	hwmon_dev =3D devm_hwmon_device_register_with_info(&client->dev, "ftsteu=
tates", data,
+							 &fts_chip_info, NULL);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);

=2D-
2.30.2

