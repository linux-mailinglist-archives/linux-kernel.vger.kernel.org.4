Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC9465F70B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjAEWvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbjAEWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:51:31 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255E65881D;
        Thu,  5 Jan 2023 14:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672959072; bh=sF0cbtH+Hcn4OuIpkhZqzOz2WGnt+KmjYTWFjzqfdRs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iglgxZKnfF3iYKr6i8FOKuiZNJNuRqmThMiFDclQzHPhPEXZOqu9wRSAPZOjTlFLf
         tBKgHVKwN8hTy+yVmMmJpleDLeBdnNOW/4wDr7oCABqEv8TZCpX/J4d9l+FOyxmaKE
         NzK7ndx9YGZqeSJtt4LTNWIbj9obmz7Vij5awztuQyOilg9741dzbyeX9QiZKeeboU
         Q7zfo0qLm5RMbECUMf7Cut2xjtJjbEFNd4+FzVm3IsePwULxwtT0zqrlH006hX3RI5
         ZdBKe9EXjgXnaog6o8V3Nv3vMP4kg9mpJODzQvfJ0+cDyJwrHjok+2f7OO3cw5/ASj
         gplU9sWrLCmaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MSbx3-1pOGQj21xh-00Sz6u; Thu, 05 Jan 2023 23:51:12 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
Date:   Thu,  5 Jan 2023 23:51:05 +0100
Message-Id: <20230105225107.58308-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105225107.58308-1-W_Armin@gmx.de>
References: <20230105225107.58308-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6qjCMrNiGvw92apmuAVN6D+uC0EY6y87J3abZ1PRfVg3y3JGBLJ
 /Po3zY0VDvcQhwWZaZtggdjEH1FksL3bZ5BRP5ZeiQPl5McK7e3480nBuzwEP323OaY3/Pz
 IFdPiIWo1d/2PfXmDqkEUC9MrMO98+BFeFyu/FXHre8ybEAeOAp1wHpAG/OI6Ax0Z73xQr+
 +/TISIGjaJJ8mKC9ErTPA==
UI-OutboundReport: notjunk:1;M01:P0:49igZ19mFu8=;86YL10wIxz0tUUhD6L1my8moyO0
 IX4UvVMEOIt1bi9fMoHlheOyhdCef2AoA5AOxIkVbJ2EnHM8yu9U5uTj7t8msC3dfA+ZYXvMK
 rjdvChKSuDFxnE6wdBdwqexcgq3JrruxvsPPrE2llAzcTpXbVUatf0hozl+uM5vyontVLp5pq
 bjKiMj3d4nQhqbhEQQGwcYf8/mlYsOP+GWp7TxKGo4DMO/UW3m2ZknoCjbq4tmhNvH4JJ7xUC
 lXFYWxN+Vxn/RJOla7ELeBETMGlik3ef+cNtRwJ2ZaAT9l6b8iCUwmep3sL+0eAIsfff/XS2H
 4Otqk+q6JnlSmizC/93YVFZPjFM0wHjwoO9C/vdQyKM8fLKp/R7lz9Ojk0nfvFknmZfLbIblp
 opRvf+gnGKNNtK9DeklYiEEQFq6Kgxo8skNWzH+GcdcJ634uj8XEnrsQpWRSRHQrW6nhFbCaD
 uxJPqZ6xRYBbTAawowQLT8PVNqHkujPg8lTSHWNHUvt7NbABJhkejZ4HhETL15Y35tpnvhS7I
 GEBbGHJA+qmncMA/ZM0UKjJVN/gh8sp9fX4zV8cK9P3lAo34W1tswLl23TpjWmECYhxu9+5Lg
 FrJjd+ZQCo/JAAc8IOULRsdHzaTIf9BQQDWM4J0t3HK0iLE8A7/bFlHriukDbDOJdQ3MEIrS2
 bZIGX+EtTsJeObMtLHOjELhnkTO/0nRgwgn/pYJKY/FxUH+KydtiWnx4ScvaL+m3PvoazTAcA
 oGvAr6duEEZp5aiEN9GQIQ5fxnSh4M8TWtyd08klzyDQM3pzi8atG6e27WojR6ozdmJyIf0PP
 lGd8DU0ZNdma53/Vo5HcmFUdCeKiH6WkPYYrRlvJULI+M+J8/z0CMYrMN5QhljBGubD3RiEnp
 Jen4GhEum+tcu2OY9l2QCIpnCIdKSUWDY4Q9wBXMFMldFiVtEF7+2404W7FzRfD0W2JjWkBNH
 BMNsYd9YM1UA6O04OtEfTXHO6z4=
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
to reduce module size by ~30%.

Tested on a Fujitsu DS3401-B1.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/ftsteutates.c | 532 ++++++++++++++----------------------
 1 file changed, 204 insertions(+), 328 deletions(-)

diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index e860924f90aa..23dc3a74f84b 100644
=2D-- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -17,7 +17,6 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>

 #define FTS_DEVICE_ID_REG		0x0000
@@ -340,376 +339,255 @@ static int fts_watchdog_init(struct fts_data *data=
)
 	return devm_watchdog_register_device(&data->client->dev, &data->wdd);
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
+static ssize_t fan_source_show(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
 	struct fts_data *data =3D dev_get_drvdata(dev);
 	int index =3D to_sensor_dev_attr(devattr)->index;
-	int value, err;
+	int err;

 	err =3D fts_update_device(data);
 	if (err < 0)
 		return err;

-	value =3D (data->temp_input[index] - 64) * 1000;
-
-	return sprintf(buf, "%d\n", value);
+	return sprintf(buf, "%u\n", data->fan_source[index]);
 }

-static ssize_t temp_fault_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+static SENSOR_DEVICE_ATTR_RO(fan1_source, fan_source, 0);
+static SENSOR_DEVICE_ATTR_RO(fan2_source, fan_source, 1);
+static SENSOR_DEVICE_ATTR_RO(fan3_source, fan_source, 2);
+static SENSOR_DEVICE_ATTR_RO(fan4_source, fan_source, 3);
+static SENSOR_DEVICE_ATTR_RO(fan5_source, fan_source, 4);
+static SENSOR_DEVICE_ATTR_RO(fan6_source, fan_source, 5);
+static SENSOR_DEVICE_ATTR_RO(fan7_source, fan_source, 6);
+static SENSOR_DEVICE_ATTR_RO(fan8_source, fan_source, 7);

-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
+static struct attribute *fts_fan_attrs[] =3D {
+	&sensor_dev_attr_fan1_source.dev_attr.attr,
+	&sensor_dev_attr_fan2_source.dev_attr.attr,
+	&sensor_dev_attr_fan3_source.dev_attr.attr,
+	&sensor_dev_attr_fan4_source.dev_attr.attr,
+	&sensor_dev_attr_fan5_source.dev_attr.attr,
+	&sensor_dev_attr_fan6_source.dev_attr.attr,
+	&sensor_dev_attr_fan7_source.dev_attr.attr,
+	&sensor_dev_attr_fan8_source.dev_attr.attr,
+	NULL
+};

-	/* 00h Temperature =3D Sensor Error */
-	return sprintf(buf, "%d\n", data->temp_input[index] =3D=3D 0);
-}
+static const struct attribute_group fts_attr_group =3D {
+	.attrs =3D fts_fan_attrs
+};

-static ssize_t temp_alarm_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+static const struct attribute_group *fts_attr_groups[] =3D {
+	&fts_attr_group,
+	NULL
+};

-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
+static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_type=
s type, u32 attr,
+			      int channel)
+{
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
+			return 0444;
+		case hwmon_fan_alarm:
+			return 0644;
+		default:
+			break;
+		}
+		break;
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
-
-	value =3D data->fan_input[index] * 60;
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			*val =3D (data->temp_input[channel] - 64) * 1000;

-	return sprintf(buf, "%d\n", value);
-}
+			return 0;
+		case hwmon_temp_alarm:
+			*val =3D !!(data->temp_alarm & BIT(channel));

-static ssize_t fan_source_show(struct device *dev,
-			       struct device_attribute *devattr, char *buf)
-{
-	struct fts_data *data =3D dev_get_drvdata(dev);
-	int index =3D to_sensor_dev_attr(devattr)->index;
-	int err;
+			return 0;
+		case hwmon_temp_fault:
+			/* 00h Temperature =3D Sensor Error */;
+			*val =3D (data->temp_input[channel] =3D=3D 0);

-	err =3D fts_update_device(data);
-	if (err < 0)
-		return err;
+			return 0;
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			*val =3D data->fan_input[channel] * 60;

-	return sprintf(buf, "%u\n", data->fan_source[index]);
-}
+			return 0;
+		case hwmon_fan_alarm:
+			*val =3D !!(data->fan_alarm & BIT(channel));

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
+static const struct hwmon_ops fts_ops =3D {
+	.is_visible =3D fts_is_visible,
+	.read =3D fts_read,
+	.write =3D fts_write,
 };

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
+			   HWMON_F_INPUT | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_ALARM,
+			   HWMON_F_INPUT | HWMON_F_ALARM
+			   ),
+	HWMON_CHANNEL_INFO(in,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT,
+			   HWMON_I_INPUT
+			   ),
 	NULL
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
-	NULL
-};
-
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
@@ -793,10 +671,8 @@ static int fts_probe(struct i2c_client *client)
 		return err;
 	revision =3D err;

-	hwmon_dev =3D devm_hwmon_device_register_with_groups(&client->dev,
-							   "ftsteutates",
-							   data,
-							   fts_attr_groups);
+	hwmon_dev =3D devm_hwmon_device_register_with_info(&client->dev, "ftsteu=
tates", data,
+							 &fts_chip_info, fts_attr_groups);
 	if (IS_ERR(hwmon_dev))
 		return PTR_ERR(hwmon_dev);

=2D-
2.30.2

