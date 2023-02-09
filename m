Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C7D691285
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjBIVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjBIVPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:15:43 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E22E582BC;
        Thu,  9 Feb 2023 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675977318; bh=GNxykkxGAhySVeYly7uHb9QEH3yNQiiCepBYLqD22mg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q/MVvIN2rOuPNSmh10xJfvP2FFqZH5tK/PJq/9mE+4oVKRQwhikfHlw38OjyOd7kt
         agmQU+ZwDBUINugZH0RAsr4CQdUAv+fay0fPL5J0vdDkRFs/uzgYCitdwIDyor9FCK
         hAeUGKCk01au/uC8g5ys5fmUTBFGLzevyrudOrHYvJApTN6/qPU+DiXLr4Vb+Kf8GC
         hXkfpEMt1C43TsbEVym8JRULefveIV0s9BaXkZZsmyU5n5wdAvVVTZ6sGn16sbbggI
         1/WS11oGwNBBg4PQndj4VAdYGhiGQ4kPc+U1jFwMV7BihnMaeK6bPxIjsFKttaFa99
         rPGlpWshdDZkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MSKyI-1p1w4c02tE-00Semp; Thu, 09 Feb 2023 22:15:18 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] platform/x86: dell-ddv: Add hwmon support
Date:   Thu,  9 Feb 2023 22:15:02 +0100
Message-Id: <20230209211503.2739-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230209211503.2739-1-W_Armin@gmx.de>
References: <20230209211503.2739-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8e7c4GPu4QCyNzdd51l6V1d56lA8mtym4nnXoRsCNYhTLubKaY4
 Nyw0LcUiW3IAlPsLGbJc+1CRqIjR0ohzCPOIz3D9w7YRxzJmYT1aIOPESV9ZgDXn6xhaLbm
 j3HNstYLNk11fugDsqnZikmQ3E/Z50Mjo0U7yYnkZ626nEr9xLA1PVxtBtxTSS24taqVge3
 FbdqWtvl5Ws9eyatMG6Bg==
UI-OutboundReport: notjunk:1;M01:P0:kzw1LQeoswg=;WknbIb4+gyL07g29JtYjUzQGZP2
 jExowRq4yGn6pxzYZV22/l4VEAULE0oAUswTcGYbu0+2m81+g1mjLQJhDSD3Yaj/6g5sKVyrO
 R41LT7N9xpMybhhbF0WZAe1YyvId4cnuUXiIdV2fv5S03ZjUOefUQoSfjRkznFfLf6FTECjqL
 gLbEi8spKx0mYCkobY/stsj76eXLo8UBFb/vBLHNv2+joDomiB+UbnkVM9TdsK0m7lblxWt6B
 6oExXGsYH+JaIxkGHT9I3acQfBkt87J1a7v7KA9c7oKFrqzL93BkmMKymLHXlB6lIlS9PjvcU
 kTX4IjI830ageJOItS7Am57acJhdphv74SPjFyxstMezbifF1cU3CQyyRyEXzyHtBvmioAvqL
 tJ+Jrbki58KIFM9H22rpTbsBCfH6HjFI634PyyKv+2O17k1jWVU4rcBwBgcNjFyElgk2M06Qf
 8PaRm6VSVTEPyokj+O3hxSHWY8GWaEjoYIWJajPwLI1IgSrzx2oS64j3yDJR4lj9/BWnOQ1vo
 ep4t6AFkPQIU5bk6zz0sI+xka7u99aJkyzOxUsDacqHSFpUB+tCS8G64TxQ300jJxjixU83K/
 5+T+tk6dY9B0RRMliF45sI6R8XQV37q/gUek07GEajqFC/3eeCHEhJbEyA7j5DyhpDxnJHPKu
 7hI7Yc2g2lJuS5XT/O0Rm+oJFtODQR2+leI/0FrvCoJ90t47xAK+Ww5J+U/eO3DLGevelfBxU
 01H5mckHcTCQaO8YyZNYKZZQDQesNGEkePochGnUNK/mwxGJEeRuyoFdhYtcHw/sYGREPagnq
 BZITwIevee2LRMpMp8yjCHPetXjZgnL8Vmh2fgpwXF9ahZlKNq4wCKZ/F589Ivz4c96xhCTKP
 IWPKlgtSH97U36vAGUeg3+e/po+yShN8oXzXzAIhxLvf16SUEMhlDAmw00TH2z3biHnCW1piV
 YuWvIuMDi/BU74Pn/w8xRgjWTkE=
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
sensor values. Since the WMI interface can be quite slow
on some machines, the sensor buffers are cached for 1 second
to lessen the performance impact.
The debugfs interface remains in place to aid in reverse-engineering
of unknown sensor types and the thermal buffer.

Tested-by: Anton=C3=ADn Skala <skala.antonin@gmail.com>
Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/Kconfig        |   8 +-
 drivers/platform/x86/dell/dell-wmi-ddv.c | 490 ++++++++++++++++++++++-
 2 files changed, 493 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell=
/Kconfig
index d319de8f2132..bdd78076b1d7 100644
=2D-- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -192,12 +192,12 @@ config DELL_WMI_DESCRIPTOR
 config DELL_WMI_DDV
 	tristate "Dell WMI sensors Support"
 	default m
-	depends on ACPI_BATTERY
 	depends on ACPI_WMI
+	depends on ACPI_BATTERY || HWMON
 	help
-	  This option adds support for WMI-based sensors like
-	  battery temperature sensors found on some Dell notebooks.
-	  It also supports reading of the battery ePPID.
+	  This option adds support for WMI-based fan and thermal sensors
+	  found on some Dell notebooks. It also supports various WMI-based batte=
ry
+	  extras like reading of the battery temperature and ePPID.

 	  To compile this drivers as a module, choose M here: the module will
 	  be called dell-wmi-ddv.
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 9695bf493ea6..d81dc4dd93e3 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -12,19 +12,27 @@
 #include <linux/device.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
+#include <linux/kconfig.h>
 #include <linux/kernel.h>
+#include <linux/hwmon.h>
 #include <linux/kstrtox.h>
 #include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/limits.h>
+#include <linux/pm.h>
 #include <linux/power_supply.h>
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
@@ -63,13 +71,63 @@ enum dell_ddv_method {
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
+struct dell_wmi_ddv_sensors {
+	struct mutex lock;	/* protect caching */
+	unsigned long timestamp;
+	union acpi_object *obj;
+	u64 entries;
+};
+
 struct dell_wmi_ddv_data {
 	struct acpi_battery_hook hook;
 	struct device_attribute temp_attr;
 	struct device_attribute eppid_attr;
+	struct dell_wmi_ddv_sensors fans;
+	struct dell_wmi_ddv_sensors temps;
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
@@ -171,6 +229,410 @@ static int dell_wmi_ddv_query_string(struct wmi_devi=
ce *wdev, enum dell_ddv_meth
 	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRI=
NG);
 }

+/*
+ * Needs to be called with lock held, except during initialization.
+ */
+static int dell_wmi_ddv_update_sensors(struct wmi_device *wdev, enum dell=
_ddv_method method,
+				       struct dell_wmi_ddv_sensors *sensors, size_t entry_size)
+{
+	u64 buffer_size, rem, entries;
+	union acpi_object *obj;
+	u8 *buffer;
+	int ret;
+
+	if (sensors->obj) {
+		if (time_before(jiffies, sensors->timestamp + HZ))
+			return 0;
+
+		kfree(sensors->obj);
+		sensors->obj =3D NULL;
+	}
+
+	ret =3D dell_wmi_ddv_query_buffer(wdev, method, 0, &obj);
+	if (ret < 0)
+		return ret;
+
+	/* buffer format sanity check */
+	buffer_size =3D obj->package.elements[0].integer.value;
+	buffer =3D obj->package.elements[1].buffer.pointer;
+	entries =3D div64_u64_rem(buffer_size, entry_size, &rem);
+	if (rem !=3D 1 || buffer[buffer_size - 1] !=3D 0xff) {
+		ret =3D -ENOMSG;
+		goto err_free;
+	}
+
+	if (!entries) {
+		ret =3D -ENODATA;
+		goto err_free;
+	}
+
+	sensors->obj =3D obj;
+	sensors->entries =3D entries;
+	sensors->timestamp =3D jiffies;
+
+	return 0;
+
+err_free:
+	kfree(obj);
+
+	return ret;
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
+	int ret;
+
+	ret =3D dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFO=
RMATION,
+					  &data->fans, sizeof(*entry));
+	if (ret < 0)
+		return ret;
+
+	if (channel >=3D data->fans.entries)
+		return -ENXIO;
+
+	entry =3D (struct fan_sensor_entry *)data->fans.obj->package.elements[1]=
.buffer.pointer;
+	switch (attr) {
+	case hwmon_fan_input:
+		*val =3D get_unaligned_le16(&entry[channel].rpm);
+		return 0;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int dell_wmi_ddv_temp_read_channel(struct dell_wmi_ddv_data *data,=
 u32 attr, int channel,
+					  long *val)
+{
+	struct thermal_sensor_entry *entry;
+	int ret;
+
+	ret =3D dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_=
INFORMATION,
+					  &data->temps, sizeof(*entry));
+	if (ret < 0)
+		return ret;
+
+	if (channel >=3D data->temps.entries)
+		return -ENXIO;
+
+	entry =3D (struct thermal_sensor_entry *)data->temps.obj->package.elemen=
ts[1].buffer.pointer;
+	switch (attr) {
+	case hwmon_temp_input:
+		*val =3D entry[channel].now * 1000;
+		return 0;
+	case hwmon_temp_min:
+		*val =3D entry[channel].min * 1000;
+		return 0;
+	case hwmon_temp_max:
+		*val =3D entry[channel].max * 1000;
+		return 0;
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_types =
type, u32 attr,
+			     int channel, long *val)
+{
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		mutex_lock(&data->fans.lock);
+		ret =3D dell_wmi_ddv_fan_read_channel(data, attr, channel, val);
+		mutex_unlock(&data->fans.lock);
+		return ret;
+	case hwmon_temp:
+		mutex_lock(&data->temps.lock);
+		ret =3D dell_wmi_ddv_temp_read_channel(data, attr, channel, val);
+		mutex_unlock(&data->temps.lock);
+		return ret;
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
+	int ret;
+	u8 type;
+
+	ret =3D dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFO=
RMATION,
+					  &data->fans, sizeof(*entry));
+	if (ret < 0)
+		return ret;
+
+	if (channel >=3D data->fans.entries)
+		return -ENXIO;
+
+	entry =3D (struct fan_sensor_entry *)data->fans.obj->package.elements[1]=
.buffer.pointer;
+	type =3D entry[channel].type;
+	switch (type) {
+	case 0x00 ... 0x07:
+		*str =3D fan_labels[type];
+		break;
+	case 0x11 ... 0x14:
+		*str =3D fan_dock_labels[type - 0x11];
+		break;
+	default:
+		*str =3D "Unknown Fan";
+		break;
+	}
+
+	return 0;
+}
+
+static int dell_wmi_ddv_temp_read_string(struct dell_wmi_ddv_data *data, =
int channel,
+					 const char **str)
+{
+	struct thermal_sensor_entry *entry;
+	int ret;
+
+	ret =3D dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_=
INFORMATION,
+					  &data->temps, sizeof(*entry));
+	if (ret < 0)
+		return ret;
+
+	if (channel >=3D data->temps.entries)
+		return -ENXIO;
+
+	entry =3D (struct thermal_sensor_entry *)data->temps.obj->package.elemen=
ts[1].buffer.pointer;
+	switch (entry[channel].type) {
+	case 0x00:
+		*str =3D "CPU";
+		break;
+	case 0x11:
+		*str =3D "Video";
+		break;
+	case 0x22:
+		*str =3D "Memory"; /* sometimes called DIMM */
+		break;
+	case 0x33:
+		*str =3D "Other";
+		break;
+	case 0x44:
+		*str =3D "Ambient"; /* sometimes called SKIN */
+		break;
+	case 0x52:
+		*str =3D "SODIMM";
+		break;
+	case 0x55:
+		*str =3D "HDD";
+		break;
+	case 0x62:
+		*str =3D "SODIMM 2";
+		break;
+	case 0x73:
+		*str =3D "NB";
+		break;
+	case 0x83:
+		*str =3D "Charger";
+		break;
+	case 0xbb:
+		*str =3D "Memory 3";
+		break;
+	default:
+		*str =3D "Unknown";
+		break;
+	}
+
+	return 0;
+}
+
+static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sensor=
_types type, u32 attr,
+				    int channel, const char **str)
+{
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+	int ret;
+
+	switch (type) {
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_label:
+			mutex_lock(&data->fans.lock);
+			ret =3D dell_wmi_ddv_fan_read_string(data, channel, str);
+			mutex_unlock(&data->fans.lock);
+			return ret;
+		default:
+			break;
+		}
+		break;
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_label:
+			mutex_lock(&data->temps.lock);
+			ret =3D dell_wmi_ddv_temp_read_string(data, channel, str);
+			mutex_unlock(&data->temps.lock);
+			return ret;
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
+static void dell_wmi_ddv_hwmon_cache_invalidate(struct dell_wmi_ddv_senso=
rs *sensors)
+{
+	mutex_lock(&sensors->lock);
+	kfree(sensors->obj);
+	sensors->obj =3D NULL;
+	mutex_unlock(&sensors->lock);
+}
+
+static void dell_wmi_ddv_hwmon_cache_destroy(void *data)
+{
+	struct dell_wmi_ddv_sensors *sensors =3D data;
+
+	mutex_destroy(&sensors->lock);
+	kfree(sensors->obj);
+}
+
+static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_de=
vice *wdev,
+							    enum dell_ddv_method method,
+							    struct dell_wmi_ddv_sensors *sensors,
+							    size_t entry_size,
+							    enum hwmon_sensor_types type,
+							    u32 config)
+{
+	struct hwmon_channel_info *info;
+	int ret;
+
+	ret =3D dell_wmi_ddv_update_sensors(wdev, method, sensors, entry_size);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	mutex_init(&sensors->lock);
+
+	ret =3D devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_hwmon_cache_de=
stroy, sensors);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	info =3D dell_wmi_ddv_channel_create(&wdev->dev, sensors->entries, type,=
 config);
+	if (IS_ERR(info))
+		devm_release_action(&wdev->dev, dell_wmi_ddv_hwmon_cache_destroy, senso=
rs);
+
+	return info;
+}
+
+static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
+{
+	struct wmi_device *wdev =3D data->wdev;
+	struct combined_chip_info *cinfo;
+	struct hwmon_channel_info *info;
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
+	info =3D dell_wmi_ddv_channel_create(&wdev->dev, 1, hwmon_chip, HWMON_C_=
REGISTER_TZ);
+	if (IS_ERR(info)) {
+		ret =3D PTR_ERR(info);
+
+		goto err_release;
+	}
+
+	cinfo->info[index] =3D info;
+	index++;
+
+	info =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_SENSOR_INFORMATION=
, &data->fans,
+					 sizeof(struct fan_sensor_entry), hwmon_fan,
+					 (HWMON_F_INPUT | HWMON_F_LABEL));
+	if (!IS_ERR(info)) {
+		cinfo->info[index] =3D info;
+		index++;
+	}
+
+	info =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERMAL_SENSOR_INFORMA=
TION, &data->temps,
+					 sizeof(struct thermal_sensor_entry), hwmon_temp,
+					 (HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
+					 HWMON_T_LABEL));
+	if (!IS_ERR(info)) {
+		cinfo->info[index] =3D info;
+		index++;
+	}
+
+	if (index < 2) {
+		ret =3D -ENODEV;
+
+		goto err_release;
+	}
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
@@ -370,9 +832,34 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev=
, const void *context)

 	dell_wmi_ddv_debugfs_init(wdev);

-	return dell_wmi_ddv_battery_add(data);
+	if (IS_REACHABLE(CONFIG_ACPI_BATTERY)) {
+		ret =3D dell_wmi_ddv_battery_add(data);
+		if (ret < 0 && ret !=3D -ENODEV)
+			dev_warn(&wdev->dev, "Unable to register ACPI battery hook: %d\n", ret=
);
+	}
+
+	if (IS_REACHABLE(CONFIG_HWMON)) {
+		ret =3D dell_wmi_ddv_hwmon_add(data);
+		if (ret < 0 && ret !=3D -ENODEV)
+			dev_warn(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
+	}
+
+	return 0;
 }

+static int dell_wmi_ddv_resume(struct device *dev)
+{
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+
+	/* Force re-reading of all sensors */
+	dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
+	dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(dell_wmi_ddv_dev_pm_ops, NULL, dell_wmi_d=
dv_resume);
+
 static const struct wmi_device_id dell_wmi_ddv_id_table[] =3D {
 	{ DELL_DDV_GUID, NULL },
 	{ }
@@ -382,6 +869,7 @@ MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
 static struct wmi_driver dell_wmi_ddv_driver =3D {
 	.driver =3D {
 		.name =3D DRIVER_NAME,
+		.pm =3D pm_sleep_ptr(&dell_wmi_ddv_dev_pm_ops),
 	},
 	.id_table =3D dell_wmi_ddv_id_table,
 	.probe =3D dell_wmi_ddv_probe,
=2D-
2.30.2

