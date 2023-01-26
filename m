Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D2F67D58C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjAZTlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjAZTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:41:03 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFE19F14;
        Thu, 26 Jan 2023 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674762036; bh=QdrZXwtINisoF2jUYT+sA8JZU9N6BJ1lzZkFgrjz8cY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=qOp7HRU/vAqhLkrLsmJoaDwWHxmbbRqY1/+CHXl2RxHuPA89rDePQYvSK+6Le6NgY
         yN0fa52HegC1B/ubGxkMM+7A8uagUZ4npPObbqfL7mbayTqXpTzf4BAGTt4zigiWI/
         Yhq9VqaSzxEdrKdqcjucXW+o5YZf8CybOjrXwvv0qr3HcdwjckRUTr/oMDzPjrkXA6
         UWTogorIsx5iVdvC3DzKwEtMslOy6ajzF4Cfkna+mxVDkucsQHTWYz75N+sqopRlZK
         2eP9Yi+NL27YC2iIYxSmGWLnPjPN1nsF5YTLhVkmp5+dq8Y0G2zMtHXd1FoyHr0eUS
         TC3iHn9DDf+cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mz9Ux-1oPQsp0pCV-00wEI0; Thu, 26 Jan 2023 20:40:36 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] platform/x86: dell-ddv: Add hwmon support
Date:   Thu, 26 Jan 2023 20:40:21 +0100
Message-Id: <20230126194021.381092-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126194021.381092-1-W_Armin@gmx.de>
References: <20230126194021.381092-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XjjZNtVzX+dAeBXDZMsentlZWpFivTubs9rDFG1eKW6EHqIEYF5
 0gAubAgTWWzv2fgKCqXy6n2KvPjCYkv/jGClWguDwAhhfPBmayo28ma5vFyUB1cttB3Agl8
 fcrStXujlRpnAm1fw3pJGR1PBoU8uW7G0db74VOBU0UbVsKQXDGU/wHuIPeVBmgqHITZumq
 R2PmkG2CZfkIn+9ByqxCA==
UI-OutboundReport: notjunk:1;M01:P0:VI7xKuTrcvw=;FFeZkxKuFjnaF5Z0nToY0v5yMb7
 q8jRm9pXERPeTh09eI2Ci+8FiIQKTKF0HvOsTiG9PWlt5Eye6LL/J5gvVdNxrV1jZNKLM0h/C
 hF5udUsczr80b7LFUu8L94Yd8cchI9hOf8wi/SEYUWr3Fz/gpSSMYJ0a+b7tH8mxzGGUuLYPc
 V1Yv8S/L3wwA2heeaErcCb0Qt9KV0TSKG5+4bfX5ZzoIRTChuf9GVlfhL8/a7H2ynskZS+jD8
 I+e5i1PlIlK7oxKzFC0JIHtX2wr4a6bAVHNKIDomkbJS476VDAK20LcuOdU8BwzVVUASoujUF
 JiiQNOMiEXJpJla+9pIe5V4WFo+Yn43wk4AKp0SkYrZR3AqTM/xcQWuwEf3o9wNrPAnVmlflg
 qL0R/dAkVIe4SQYoW3JrX8TGtao2fJyM6FnT1gda4w6JCwFbcSQjRjkVimj8yxdkWbzgcMSeo
 5I8mS8dx3y3Uo3H2UWV8jvd/TM60U0ciZGp+RlffCSDP7mWxcXXykARnZbc7tSRZr7m4zE6o3
 vo8WnxfQiMyUKXmpi+KmTPzHsEbnvBToL5pULObWwhpEEDTdDF214z6JOR8SjvgWR+xtCX7ZE
 Hv4tFb2uiACC1gB8jPNGikJWs3B0rA8eLu+vpCBmkwxyuwmmbZBwpaiz9KBuR4CYZopigZ58R
 VnXxAxRBE6axDRalXdoUl+FklnOUC2azzPjNBKLikcb7dyJ6aKaDjNVPkA0LGDWtiKL387TBe
 97OuFlNvoc73UbYGshxioXBJ6d1ULgmdWiJExq60kL23YeJKm0U7Jz9kBOPyIlYcWvJ0jIj3U
 EqSx4OS91eSjpSuGflpAe47+w52/1Gf4MIYodGRNbRA+RV2psy7x1gedgwNQxe9YaofEXbAfD
 ZWxa2p5w4woW3OMZ4tQS0vhiSa8kMNs+wjd8UESrc4Js/VH6OaaEaZNE3R7HH3msi2O+j82/r
 qfrgJSZaOVU7zTRI6P0Px0ewGSY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to bugreport 216655 on bugzilla triggered by the
dell-smm-hwmon driver, the contents of the sensor buffers
could be almost completely decoded.
Add an hwmon interface for exposing the fan and thermal
sensor values. The debugfs interface remains in place to
aid in reverse-engineering of unknown sensor types
and the thermal buffer.

Tested-by: Anton=C3=ADn Skala <skala.antonin@gmail.com>
Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/Kconfig        |   1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c | 435 ++++++++++++++++++++++-
 2 files changed, 435 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell=
/Kconfig
index d319de8f2132..21a74b63d9b1 100644
=2D-- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -194,6 +194,7 @@ config DELL_WMI_DDV
 	default m
 	depends on ACPI_BATTERY
 	depends on ACPI_WMI
+	depends on HWMON
 	help
 	  This option adds support for WMI-based sensors like
 	  battery temperature sensors found on some Dell notebooks.
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 9695bf493ea6..5b30bb85199e 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -13,6 +13,7 @@
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
+#include <linux/hwmon.h>
 #include <linux/kstrtox.h>
 #include <linux/math.h>
 #include <linux/module.h>
@@ -21,10 +22,13 @@
 #include <linux/printk.h>
 #include <linux/seq_file.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 #include <linux/wmi.h>

 #include <acpi/battery.h>

+#include <asm/unaligned.h>
+
 #define DRIVER_NAME	"dell-wmi-ddv"

 #define DELL_DDV_SUPPORTED_VERSION_MIN	2
@@ -63,6 +67,29 @@ enum dell_ddv_method {
 	DELL_DDV_THERMAL_SENSOR_INFORMATION	=3D 0x22,
 };

+struct fan_sensor_entry {
+	u8 type;
+	__le16 rpm;
+} __packed;
+
+struct thermal_sensor_entry {
+	u8 type;
+	s8 now;
+	s8 min;
+	s8 max;
+	u8 unknown;
+} __packed;
+
+struct combined_channel_info {
+	struct hwmon_channel_info info;
+	u32 config[];
+};
+
+struct combined_chip_info {
+	struct hwmon_chip_info chip;
+	const struct hwmon_channel_info *info[];
+};
+
 struct dell_wmi_ddv_data {
 	struct acpi_battery_hook hook;
 	struct device_attribute temp_attr;
@@ -70,6 +97,24 @@ struct dell_wmi_ddv_data {
 	struct wmi_device *wdev;
 };

+static const char * const fan_labels[] =3D {
+	"CPU Fan",
+	"Chassis Motherboard Fan",
+	"Video Fan",
+	"Power Supply Fan",
+	"Chipset Fan",
+	"Memory Fan",
+	"PCI Fan",
+	"HDD Fan",
+};
+
+static const char * const fan_dock_labels[] =3D {
+	"Docking Chassis/Motherboard Fan",
+	"Docking Video Fan",
+	"Docking Power Supply Fan",
+	"Docking Chipset Fan",
+};
+
 static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv=
_method method, u32 arg,
 				   union acpi_object **result, acpi_object_type type)
 {
@@ -171,6 +216,386 @@ static int dell_wmi_ddv_query_string(struct wmi_devi=
ce *wdev, enum dell_ddv_meth
 	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRI=
NG);
 }

+static int dell_wmi_ddv_query_sensors(struct wmi_device *wdev, enum dell_=
ddv_method method,
+				      size_t entry_size, union acpi_object **result, u64 *count)
+{
+	union acpi_object *obj;
+	u64 buffer_size;
+	u8 *buffer;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_buffer(wdev, method, 0, &obj);
+	if (ret < 0)
+		return ret;
+
+	buffer_size =3D obj->package.elements[0].integer.value;
+	buffer =3D obj->package.elements[1].buffer.pointer;
+	if (buffer_size % entry_size !=3D 1 || buffer[buffer_size - 1] !=3D 0xff=
) {
+		kfree(obj);
+
+		return -ENOMSG;
+	}
+
+	*count =3D (buffer_size - 1) / entry_size;
+	*result =3D obj;
+
+	return 0;
+}
+
+static umode_t dell_wmi_ddv_is_visible(const void *drvdata, enum hwmon_se=
nsor_types type, u32 attr,
+				       int channel)
+{
+	return 0444;
+}
+
+static int dell_wmi_ddv_fan_read_channel(struct dell_wmi_ddv_data *data, =
u32 attr, int channel,
+					 long *val)
+{
+	struct fan_sensor_entry *entry;
+	union acpi_object *obj;
+	u64 count;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFOR=
MATION,
+					 sizeof(*entry), &obj, &count);
+	if (ret < 0)
+		return ret;
+
+	entry =3D (struct fan_sensor_entry *)obj->package.elements[1].buffer.poi=
nter;
+	if (count > channel) {
+		switch (attr) {
+		case hwmon_fan_input:
+			*val =3D get_unaligned_le16(&entry[channel].rpm);
+
+			break;
+		default:
+			ret =3D -EOPNOTSUPP;
+		}
+	} else {
+		ret =3D -ENXIO;
+	}
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_temp_read_channel(struct dell_wmi_ddv_data *data,=
 u32 attr, int channel,
+					  long *val)
+{
+	struct thermal_sensor_entry *entry;
+	union acpi_object *obj;
+	u64 count;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_I=
NFORMATION,
+					 sizeof(*entry), &obj, &count);
+	if (ret < 0)
+		return ret;
+
+	entry =3D (struct thermal_sensor_entry *)obj->package.elements[1].buffer=
.pointer;
+	if (count > channel) {
+		switch (attr) {
+		case hwmon_temp_input:
+			*val =3D entry[channel].now * 1000;
+
+			break;
+		case hwmon_temp_min:
+			*val =3D entry[channel].min * 1000;
+
+			break;
+		case hwmon_temp_max:
+			*val =3D entry[channel].max * 1000;
+
+			break;
+		default:
+			ret =3D -EOPNOTSUPP;
+		}
+	} else {
+		ret =3D -ENXIO;
+	}
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_types =
type, u32 attr,
+			     int channel, long *val)
+{
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_fan:
+		return dell_wmi_ddv_fan_read_channel(data, attr, channel, val);
+	case hwmon_temp:
+		return dell_wmi_ddv_temp_read_channel(data, attr, channel, val);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int dell_wmi_ddv_fan_read_string(struct dell_wmi_ddv_data *data, i=
nt channel,
+					const char **str)
+{
+	struct fan_sensor_entry *entry;
+	union acpi_object *obj;
+	u64 count;
+	u8 type;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFOR=
MATION,
+					 sizeof(*entry), &obj, &count);
+	if (ret < 0)
+		return ret;
+
+	entry =3D (struct fan_sensor_entry *)obj->package.elements[1].buffer.poi=
nter;
+	if (count > channel) {
+		type =3D entry[channel].type;
+
+		switch (type) {
+		case 0x00 ... 0x07:
+			*str =3D fan_labels[type];
+
+			break;
+		case 0x11 ... 0x14:
+			*str =3D fan_dock_labels[type - 0x11];
+
+			break;
+		default:
+			*str =3D "Unknown Fan";
+		}
+	} else {
+		ret =3D -ENXIO;
+	}
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_temp_read_string(struct dell_wmi_ddv_data *data, =
int channel,
+					 const char **str)
+{
+	struct thermal_sensor_entry *entry;
+	union acpi_object *obj;
+	u64 count;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_I=
NFORMATION,
+					 sizeof(*entry), &obj, &count);
+	if (ret < 0)
+		return ret;
+
+	entry =3D (struct thermal_sensor_entry *)obj->package.elements[1].buffer=
.pointer;
+	if (count > channel) {
+		switch (entry[channel].type) {
+		case 0x00:
+			*str =3D "CPU";
+
+			break;
+		case 0x11:
+			*str =3D "Video";
+
+			break;
+		case 0x22:
+			*str =3D "Memory"; // sometimes called DIMM
+
+			break;
+		case 0x33:
+			*str =3D "Other";
+
+			break;
+		case 0x44:
+			*str =3D "Ambient"; // sometimes called SKIN
+
+			break;
+		case 0x52:
+			*str =3D "SODIMM";
+
+			break;
+		case 0x55:
+			*str =3D "HDD";
+
+			break;
+		case 0x62:
+			*str =3D "SODIMM 2";
+
+			break;
+		case 0x73:
+			*str =3D "NB";
+
+			break;
+		case 0x83:
+			*str =3D "Charger";
+
+			break;
+		case 0xbb:
+			*str =3D "Memory 3";
+
+			break;
+		default:
+			*str =3D "Unknown";
+		}
+	} else {
+		ret =3D -ENXIO;
+	}
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sensor=
_types type, u32 attr,
+				    int channel, const char **str)
+{
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_label:
+			return dell_wmi_ddv_fan_read_string(data, channel, str);
+		default:
+			break;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_label:
+			return dell_wmi_ddv_temp_read_string(data, channel, str);
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static const struct hwmon_ops dell_wmi_ddv_ops =3D {
+	.is_visible =3D dell_wmi_ddv_is_visible,
+	.read =3D dell_wmi_ddv_read,
+	.read_string =3D dell_wmi_ddv_read_string,
+};
+
+static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct devi=
ce *dev, u64 count,
+							      enum hwmon_sensor_types type,
+							      u32 config)
+{
+	struct combined_channel_info *cinfo;
+	int i;
+
+	cinfo =3D devm_kzalloc(dev, struct_size(cinfo, config, count + 1), GFP_K=
ERNEL);
+	if (!cinfo)
+		return ERR_PTR(-ENOMEM);
+
+	cinfo->info.type =3D type;
+	cinfo->info.config =3D cinfo->config;
+
+	for (i =3D 0; i < count; i++)
+		cinfo->config[i] =3D config;
+
+	return &cinfo->info;
+}
+
+static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_de=
vice *wdev,
+							    enum dell_ddv_method method,
+							    size_t entry_size,
+							    enum hwmon_sensor_types type,
+							    u32 config)
+{
+	union acpi_object *obj;
+	u64 count;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_sensors(wdev, method, entry_size, &obj, &coun=
t);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	kfree(obj);
+
+	if (!count)
+		return ERR_PTR(-ENODEV);
+
+	return dell_wmi_ddv_channel_create(&wdev->dev, count, type, config);
+}
+
+static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
+{
+	struct wmi_device *wdev =3D data->wdev;
+	struct combined_chip_info *cinfo;
+	struct device *hdev;
+	int index =3D 0;
+	int ret;
+
+	if (!devres_open_group(&wdev->dev, dell_wmi_ddv_hwmon_add, GFP_KERNEL))
+		return -ENOMEM;
+
+	cinfo =3D devm_kzalloc(&wdev->dev, struct_size(cinfo, info, 4), GFP_KERN=
EL);
+	if (!cinfo) {
+		ret =3D -ENOMEM;
+
+		goto err_release;
+	}
+
+	cinfo->chip.ops =3D &dell_wmi_ddv_ops;
+	cinfo->chip.info =3D cinfo->info;
+
+	cinfo->info[index] =3D dell_wmi_ddv_channel_create(&wdev->dev, 1, hwmon_=
chip,
+							 HWMON_C_REGISTER_TZ);
+
+	if (IS_ERR(cinfo->info[index])) {
+		ret =3D PTR_ERR(cinfo->info[index]);
+
+		goto err_release;
+	}
+
+	index++;
+
+	cinfo->info[index] =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_SENS=
OR_INFORMATION,
+						       sizeof(struct fan_sensor_entry), hwmon_fan,
+						       (HWMON_F_INPUT | HWMON_F_LABEL));
+	if (!IS_ERR(cinfo->info[index]))
+		index++;
+
+	cinfo->info[index] =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERMAL_=
SENSOR_INFORMATION,
+						       sizeof(struct thermal_sensor_entry),
+						       hwmon_temp, (HWMON_T_INPUT | HWMON_T_MIN |
+						       HWMON_T_MAX | HWMON_T_LABEL));
+	if (!IS_ERR(cinfo->info[index]))
+		index++;
+
+	if (!index) {
+		ret =3D -ENODEV;
+
+		goto err_release;
+	}
+
+	cinfo->info[index] =3D NULL;
+
+	hdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "dell_ddv", da=
ta, &cinfo->chip,
+						    NULL);
+	if (IS_ERR(hdev)) {
+		ret =3D PTR_ERR(hdev);
+
+		goto err_release;
+	}
+
+	devres_close_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
+
+	return 0;
+
+err_release:
+	devres_release_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
+
+	return ret;
+}
+
 static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *=
index)
 {
 	const char *uid_str;
@@ -370,7 +795,15 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev=
, const void *context)

 	dell_wmi_ddv_debugfs_init(wdev);

-	return dell_wmi_ddv_battery_add(data);
+	ret =3D dell_wmi_ddv_hwmon_add(data);
+	if (ret < 0)
+		dev_dbg(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
+
+	ret =3D dell_wmi_ddv_battery_add(data);
+	if (ret < 0)
+		dev_dbg(&wdev->dev, "Unable to register acpi battery hook: %d\n", ret);
+
+	return 0;
 }

 static const struct wmi_device_id dell_wmi_ddv_id_table[] =3D {
=2D-
2.30.2

