Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01CA65EE9B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAEOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjAEOTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:19:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E2758304;
        Thu,  5 Jan 2023 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672928360; bh=sF0cbtH+Hcn4OuIpkhZqzOz2WGnt+KmjYTWFjzqfdRs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ggYfmxDM03lw7Ry05tptwEBwMNfaLjJmWiZFeC8KAnq/p9ai4pW+Z5j8qlXi8dNrJ
         x1xkQ10C0hCDtQ6bmJMWcb61TLWkvW67YdpiXuwlVbIiGkNruVwz+DRrBOzxMWHxgB
         +Wn4KHUUHqcxpR76S9GpN5VWJBtSzQmF/9JThzbFy8VtArLsuZF0HJ4utHAo3tbbCB
         29+8bye5G/eUaudpGVLjryWnuitX/x5PJQvcYyCVDkGY8S+8/GM5fGA/rrvcF1KiN/
         Pj3sOnEbaWWfuUGd2zne72wwIgCHRzOVoh3dnJMIxw+C5j32P6BaDvWBVldOEXmfop
         q+02o2dE9kdPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MD9X9-1p4wlF0eQr-009C2T; Thu, 05 Jan 2023 15:19:20 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] hwmon: (ftsteutates) Convert to devm_hwmon_device_register_with_info()
Date:   Thu,  5 Jan 2023 15:19:09 +0100
Message-Id: <20230105141911.8040-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105141911.8040-1-W_Armin@gmx.de>
References: <20230105141911.8040-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5zTmEGuu8GHGoD61c4NVRlPS50VVc/c2KL1Y1sLq39drIJ0cC9p
 8pgv2hg9MJSscXrMMSYWmJ24PzQfnhEPmL8zRMmqlO2K3M4ghVi4c37J5OJ9HHy5pKd3swY
 xr9qUyKAiYEqChDBk11KDTKENYHq766d5m2naCxiBMF1q3GVcxA4D5hOe5NXydTG1vHSa6g
 EyvJ1ncB75CieCHL/oOnw==
UI-OutboundReport: notjunk:1;M01:P0:xUONJrSDZ+0=;N++cnMc5sTVA1EWPZpMAz0kxOLj
 SF2rqz6BT+eQcEnZnYDYwbCQmXu/eDjDOiBpTOLiIO3MJ3LXWq6/QsS13IJqZsMm5BbRTeqNz
 /zXxjXpLMjB+8Zo9DsJtPi5NOa74k0SzEV/563eFC4ipKATBWxes4l5qJFscGR1bfOEJQuR7d
 4V31OiPwco4b2XhXm9xn19fN7mhGbBz/dXM/D794EdIBID2tCEsMgRLuQqiCF2NzWGzUNvfyH
 ww80AbhbTYX/owLDPL3jXCSRcD+wkMTFepzJAOMejQ3tz1md4CQXr4ObEQLOf8AUSusv2+74B
 9nsbEOw7I8zRZqsuhyoHGVtilw3462CVmNMyJTREPM3YfrpmNopU/gJWqc4vtOjvF7+EpoCik
 YWVuB75k7M8REIvQxkyzfaJqF6GVFrYzUutzQEhmLTyHMlyxGv/MfJoEf9hLdBsn98vcU6Udg
 FNdKRjmN9+cJT56aJNjCFCGxYJ5MP4gXfzWuT7OzvcKsxVPbCa09vroJ39LJv+5CuZBHOX2Z5
 1F7DWgBODt7gfYLjDfcD36ZGfRlqszzexiIYQ8C/JuG5aAoYhhSCoAwJkwdRRdoa9dZKFsdgw
 OAGZ4F6SccMdIdEfoI3psjHdnad806DepsK5ZMtBddy71dvRxpcmt7IHCHCatLFXEZQBwLelk
 r35s/y9ASr8SofQfjT/OvqSTujxX1MIh9HU7uvDwEjuJfXHVuR6AVepxLrwbJxLfbSDKRgN9R
 RQ/mxfh7ag1nbWLkT4xy1OH/MTnl+40qUd5RKG5zu8E0G6H3uSBNmbLKHut73vNyk6frlpG93
 /vM4rUMkosmDqewo3FyI4S4RKjXFUBglwVfFkb8Fa6PVA+4IrWIlBzqxX6TaLHGXDN7rMkbc6
 GeARyf+c5fAFhAA4+pxFvNuazq1hl4AzcKeR42hybLXyGRkUKXAZulFJKogkSXrmAJs0fynRC
 MlnXZq/gQNvBiNfdyIGBOn/6S/M=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

