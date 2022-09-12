Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9345B5B5A93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiILMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiILMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:54:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E6F39B89;
        Mon, 12 Sep 2022 05:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662987234;
        bh=hk5t2e+oj5yO3UwZJOPmpX0A2h5nxw6Irm3GZCkWWjU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HZWjZnyC8mmH39rZ70BLIu0Cim5NB0ZDJxvgLF2XA2+ZjU/HS6umYzThUSSCyUhu2
         CzrGQuaulWf7Cg7ZHPFgfyXfX14qpYhrUPL3q6tBO/0tuVA1NWVXTln5W3OEzRObDB
         LUHCe8EFkba8Cq5SN2fs6ScYdGZbc4MPErYPY8tk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MwQXN-1pNM1s3Em5-00sQDs; Mon, 12 Sep 2022 14:53:53 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
Date:   Mon, 12 Sep 2022 14:53:42 +0200
Message-Id: <20220912125342.7395-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912125342.7395-1-W_Armin@gmx.de>
References: <20220912125342.7395-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KaVfppH25SNtBQGGAmEyAtS0NiHFH55eBR6zzMvq90fkEtS/DPR
 GOPZeJ8Sgpddz82XlGlApc+1btIcF6tZCxiXFlq/+W2ScyIDPmzYtX2OqqNccNGnr20z9Ir
 oGXVXh++sR3sN0MKOjnGY1HF4JNpZdareqocfjMZ8U9pPY/Gu3fB3aQ4UOKWXMYz2l9E21+
 yJ69fKP0PxGjbuIIX6dgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RzHAru8r6rI=:JdiMj+2Ur3Qi89yC8XarXY
 P28XAeVcDLdAVGc+WXot5FlgU4sQNjm1uPnJ6m/8pgS5R792MZtVmpJe+Ox17msIE2ASxsSWW
 A/+TYktsBlOiz4b/AJ8EGpwDM1opE5kvi2/l/y+dbUWjAruc6YpzDXVNVjzE3LbxrYwocmi0g
 JYhN1o/uSjFfJChFq38X8HLY5jGaAzQnnC1t9iUsC78lgW1DwbO7iMHZLB7g7N+cN66G/d7Cb
 sJZUQ8qTPkIj5gW+Cya4BdVR4GaOuHdAnHzhgSyHbUsY7R4QZlEdXvd5zn39gLAPA9ezjRZoE
 Eg/XQ7RiR61NeMPvQbxEkPq2Y37VD3v7RYqNlAX3Mda2D1Kb0d1VohqtD8DCvc90rZ3iQxTL9
 nYKGEHzcrkye8auHZpzguiYU+Bnl8aLRg7WLO9F2fei6MFCpYgES3ncmsEHv4b9pQBgz6vL19
 vj6gckoiYgvGhWQkuZE5/ARb6PbzerHLK85aHxFluVnnTnbdnaE9su5KxzxsHrNwmD6JFE3kN
 Mv+49KQIYRkkpzPrp4rG2Cvd9ZpKR5yb+tfup6+0bpmrplOxXDDitTkE/HDhfpK11+Cs7aw96
 7MC8OGs+avPUBJLoOLriRNrXro8BY57IISIjex9DWBRIyeAT39ShAyi80foHHeM4USJ/EoJkd
 Zz9VuewbsWoWdJIjMe5PaIDjbTjyOVqMsecseBbDY2mPe7n0VAT/dqXmwnKShwcOCsc/gSabl
 R0JHD4i3+6ttotCIshOxuslYmQt/MdDPYk2Y0omQ5L+vKprk5bIfrhq21WdNNRrmWQaTdVkn4
 aIEu1TRiZKaIB9pM3JXQu09wBFV8Ql3mmba09Y5H3NslLKALyzfPZLZZoIfeEIqD/J/nqP6MG
 wcL/jwll7Rcj7LL0tR5weRqCe3MdHMiFv/zTLH0CHAGOGI0MlLEkU5YrtM2fDI+hiAEDOaDTd
 m3RPY+IB2zZUgM2dkkM5ECfS8du1duYwAva00aMzSnBL2q+BY6knqbm9zsJ1XspngWjTHEglA
 i4kJe1aO4ujL4h0SMEYVDTuola7RDhVILiKv/x5FM9lGJ/RJvB1C4e0WtEy7yIbsjj/Pj/qip
 WyoxpOBOtTf10EMFqob715c+Vxz22UdiuOK/sDEwvUkzWxlmOoZ+624s6p0ZZQm2BTexTALij
 APYx4XIjfdIYTHoX8QIC+1MasJ
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dell-wmi-ddv driver adds support for reading
the current temperature and ePPID of ACPI batteries
on supported Dell machines.

Since the WMI interface used by this driver does not
do any input validation and thus cannot be used for probing,
the driver depends on the ACPI battery extension machanism
to discover batteries.

The driver also supports a debugfs interface for retrieving
buffers containing fan and thermal sensor information.
Since the meaing of the content of those buffers is currently
unknown, the interface is meant for reverse-engineering and
will likely be replaced with an hwmon interface once the
meaning has been understood.

The driver was tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../ABI/testing/debugfs-dell-wmi-ddv          |  21 +
 .../ABI/testing/sysfs-platform-dell-wmi-ddv   |  16 +
 MAINTAINERS                                   |   7 +
 drivers/platform/x86/dell/Kconfig             |  13 +
 drivers/platform/x86/dell/Makefile            |   1 +
 drivers/platform/x86/dell/dell-wmi-ddv.c      | 365 ++++++++++++++++++
 drivers/platform/x86/wmi.c                    |   1 +
 7 files changed, 424 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-dell-wmi-ddv
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
 create mode 100644 drivers/platform/x86/dell/dell-wmi-ddv.c

diff --git a/Documentation/ABI/testing/debugfs-dell-wmi-ddv b/Documentatio=
n/ABI/testing/debugfs-dell-wmi-ddv
new file mode 100644
index 000000000000..fbcc5d6f7388
=2D-- /dev/null
+++ b/Documentation/ABI/testing/debugfs-dell-wmi-ddv
@@ -0,0 +1,21 @@
+What:		/sys/kernel/debug/dell-wmi-ddv-<wmi_device_name>/fan_sensor_inform=
ation
+Date:		September 2022
+KernelVersion:	6.1
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		This file contains the contents of the fan sensor information buffer,
+		which contains fan sensor entries and a terminating character (0xFF).
+
+		Each fan sensor entry consists of three bytes with an unknown meaning,
+		interested people may use this file for reverse-engineering.
+
+What:		/sys/kernel/debug/dell-wmi-ddv-<wmi_device_name>/thermal_sensor_in=
formation
+Date:		September 2022
+KernelVersion:	6.1
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		This file contains the contents of the thermal sensor information buffe=
r,
+		which contains thermal sensor entries and a terminating character (0xFF=
).
+
+		Each thermal sensor entry consists of five bytes with an unknown meanin=
g,
+		interested people may use this file for reverse-engineering.
diff --git a/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv b/Docum=
entation/ABI/testing/sysfs-platform-dell-wmi-ddv
new file mode 100644
index 000000000000..98e0b8399d13
=2D-- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
@@ -0,0 +1,16 @@
+What:		/sys/class/power_supply/<battery_name>/temp
+Date:		September 2022
+KernelVersion:	6.1
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		Reports the current ACPI battery temperature on supported Dell machines=
.
+
+		Values are represented in 1/10 Degrees Celsius.
+
+What:		/sys/class/power_supply/<battery_name>/eppid
+Date:		September 2022
+KernelVersion:	6.1
+Contact:	Armin Wolf <W_Armin@gmx.de>
+Description:
+		Reports the Dell ePPID (electronic Dell Piece Part Identification)
+		of the ACPI battery.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6bb894ea4a77..d9fd4c9eebbc 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5821,6 +5821,13 @@ L:	Dell.Client.Kernel@dell.com
 S:	Maintained
 F:	drivers/platform/x86/dell/dell-wmi-descriptor.c

+DELL WMI DDV DRIVER
+M:	Armin Wolf <W_Armin@gmx.de>
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-dell-wmi-ddv
+F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
+F:	drivers/platform/x86/dell/dell-wmi-ddv.c
+
 DELL WMI SYSMAN DRIVER
 M:	Divya Bharathi <divya.bharathi@dell.com>
 M:	Prasanth Ksr <prasanth.ksr@dell.com>
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell=
/Kconfig
index 25421e061c47..209e63e347e2 100644
=2D-- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
 	default n
 	depends on ACPI_WMI

+config DELL_WMI_DDV
+	tristate "Dell WMI sensors Support"
+	default m
+	depends on ACPI_BATTERY
+	depends on ACPI_WMI
+	help
+	  This option adds support for WMI-based sensors like
+	  battery temperature sensors found on some Dell notebooks.
+	  It also supports reading of the batteries ePPID.
+
+	  To compile this drivers as a module, choose M here: the module will
+	  be called dell-wmi-ddv.
+
 config DELL_WMI_LED
 	tristate "External LED on Dell Business Netbooks"
 	default m
diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/del=
l/Makefile
index ddba1df71e80..1b8942426622 100644
=2D-- a/drivers/platform/x86/dell/Makefile
+++ b/drivers/platform/x86/dell/Makefile
@@ -19,5 +19,6 @@ dell-wmi-objs				:=3D dell-wmi-base.o
 dell-wmi-$(CONFIG_DELL_WMI_PRIVACY)	+=3D dell-wmi-privacy.o
 obj-$(CONFIG_DELL_WMI_AIO)		+=3D dell-wmi-aio.o
 obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+=3D dell-wmi-descriptor.o
+obj-$(CONFIG_DELL_WMI_DDV)		+=3D dell-wmi-ddv.o
 obj-$(CONFIG_DELL_WMI_LED)		+=3D dell-wmi-led.o
 obj-$(CONFIG_DELL_WMI_SYSMAN)		+=3D dell-wmi-sysman/
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
new file mode 100644
index 000000000000..6eef298f13eb
=2D-- /dev/null
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell note=
books.
+ *
+ * Copyright (C) 2022 Armin Wolf <W_Armin@gmx.de>
+ */
+
+#define pr_format(fmt) KBUILD_MODNAME ": " fmt
+
+#include <acpi/battery.h>
+#include <linux/acpi.h>
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/limits.h>
+#include <linux/power_supply.h>
+#include <linux/seq_file.h>
+#include <linux/sysfs.h>
+#include <linux/wmi.h>
+
+#define DRIVER_NAME	"dell-wmi-ddv"
+
+#define DELL_DDV_SUPPORTED_INTERFACE 2
+#define DELL_DDV_GUID	"8A42EA14-4F2A-FD45-6422-0087F7A7E608"
+
+enum dell_ddv_method {
+	DELL_DDV_BATTERY_DESIGN_CAPACITY	=3D 0x01,
+	DELL_DDV_BATTERY_FULL_CHARGE_CAPACITY	=3D 0x02,
+	DELL_DDV_BATTERY_MANUFACTURE_NAME	=3D 0x03,
+	DELL_DDV_BATTERY_MANUFACTURE_DATE	=3D 0x04,
+	DELL_DDV_BATTERY_SERIAL_NUMBER		=3D 0x05,
+	DELL_DDV_BATTERY_CHEMISTRY_VALUE	=3D 0x06,
+	DELL_DDV_BATTERY_TEMPERATURE		=3D 0x07,
+	DELL_DDV_BATTERY_CURRENT		=3D 0x08,
+	DELL_DDV_BATTERY_VOLTAGE		=3D 0x09,
+	DELL_DDV_BATTERY_MANUFACTURER_ACCESS	=3D 0x0A,
+	DELL_DDV_BATTERY_RELATIVE_CHARGE_STATE	=3D 0x0B,
+	DELL_DDV_BATTERY_CYCLE_COUNT		=3D 0x0C,
+	DELL_DDV_BATTERY_EPPID			=3D 0x0D,
+	DELL_DDV_BATTERY_RAW_ANALYTICS_START	=3D 0x0E,
+	DELL_DDV_BATTERY_RAW_ANALYTICS		=3D 0x0F,
+	DELL_DDV_BATTERY_DESIGN_VOLTAGE		=3D 0x10,
+
+	DELL_DDV_INTERFACE_VERSION		=3D 0x12,
+
+	DELL_DDV_FAN_SENSOR_INFORMATION		=3D 0x20,
+	DELL_DDV_THERMAL_SENSOR_INFORMATION	=3D 0x22,
+};
+
+struct dell_wmi_ddv_data {
+	struct device_attribute temp_attr, eppid_attr;
+	struct wmi_device *wdev;
+};
+
+static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv=
_method method, u32 arg,
+				   union acpi_object **result, acpi_object_type type)
+{
+	struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	const struct acpi_buffer in =3D {
+		.length =3D sizeof(arg),
+		.pointer =3D &arg,
+	};
+	union acpi_object *obj;
+	acpi_status ret;
+
+	ret =3D wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
+	if (ACPI_FAILURE(ret))
+		return -EIO;
+
+	obj =3D out.pointer;
+	if (!obj)
+		return -ENODATA;
+
+	if (obj->type !=3D type) {
+		kfree(obj);
+		return -EIO;
+	}
+
+	*result =3D obj;
+
+	return 0;
+}
+
+static int dell_wmi_ddv_query_integer(struct wmi_device *wdev, enum dell_=
ddv_method method,
+				      u32 arg, u32 *res)
+{
+	union acpi_object *obj;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_type(wdev, method, arg, &obj, ACPI_TYPE_INTEG=
ER);
+	if (ret < 0)
+		return ret;
+
+	if (obj->integer.value <=3D U32_MAX)
+		*res =3D (u32)obj->integer.value;
+	else
+		ret =3D -ERANGE;
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_query_buffer(struct wmi_device *wdev, enum dell_d=
dv_method method,
+				     u32 arg, union acpi_object **result)
+{
+	union acpi_object *obj;
+	u64 buffer_size;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_type(wdev, method, arg, &obj, ACPI_TYPE_PACKA=
GE);
+	if (ret < 0)
+		return ret;
+
+	if (obj->package.count !=3D 2)
+		goto err_free;
+
+	if (obj->package.elements[0].type !=3D ACPI_TYPE_INTEGER)
+		goto err_free;
+
+	buffer_size =3D obj->package.elements[0].integer.value;
+
+	if (obj->package.elements[1].type !=3D ACPI_TYPE_BUFFER)
+		goto err_free;
+
+	if (buffer_size !=3D obj->package.elements[1].buffer.length) {
+		dev_warn(&wdev->dev,
+			 FW_WARN "ACPI buffer size (%llu) does not match WMI buffer size (%d)\=
n",
+			 buffer_size, obj->package.elements[1].buffer.length);
+
+		goto err_free;
+	}
+
+	*result =3D obj;
+
+	return 0;
+
+err_free:
+	kfree(obj);
+
+	return -EIO;
+}
+
+static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_d=
dv_method method,
+				     u32 arg, union acpi_object **result)
+{
+	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRI=
NG);
+}
+
+static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *=
index)
+{
+	const char *uid_str =3D acpi_device_uid(acpi_dev);
+
+	if (!uid_str)
+		return -ENODEV;
+
+	return kstrtou32(uid_str, 10, index);
+}
+
+static ssize_t temp_show(struct device *dev, struct device_attribute *att=
r, char *buf)
+{
+	struct dell_wmi_ddv_data *data =3D container_of(attr, struct dell_wmi_dd=
v_data, temp_attr);
+	u32 index, value;
+	int ret;
+
+	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
+	if (ret < 0)
+		return ret;
+
+	ret =3D dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_TEMPERAT=
URE, index, &value);
+	if (ret < 0)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", DIV_ROUND_CLOSEST(value, 10));
+}
+
+static ssize_t eppid_show(struct device *dev, struct device_attribute *at=
tr, char *buf)
+{
+	struct dell_wmi_ddv_data *data =3D container_of(attr, struct dell_wmi_dd=
v_data, eppid_attr);
+	union acpi_object *obj;
+	u32 index;
+	int ret;
+
+	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
+	if (ret < 0)
+		return ret;
+
+	ret =3D dell_wmi_ddv_query_string(data->wdev, DELL_DDV_BATTERY_EPPID, in=
dex, &obj);
+	if (ret < 0)
+		return ret;
+
+	ret =3D sysfs_emit(buf, "%s\n", obj->string.pointer);
+
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_add_battery(void *drvdata, struct power_supply *b=
attery)
+{
+	struct dell_wmi_ddv_data *data =3D drvdata;
+	u32 index;
+	int ret;
+
+	ret =3D dell_wmi_ddv_battery_index(to_acpi_device(battery->dev.parent), =
&index);
+	if (ret < 0)
+		return ret;
+
+	ret =3D device_create_file(&battery->dev, &data->temp_attr);
+	if (ret < 0)
+		return ret;
+
+	ret =3D device_create_file(&battery->dev, &data->eppid_attr);
+	if (ret < 0) {
+		device_remove_file(&battery->dev, &data->temp_attr);
+
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dell_wmi_ddv_remove_battery(void *drvdata, struct power_supply=
 *battery)
+{
+	struct dell_wmi_ddv_data *data =3D drvdata;
+
+	device_remove_file(&battery->dev, &data->temp_attr);
+	device_remove_file(&battery->dev, &data->eppid_attr);
+
+	return 0;
+}
+
+static const struct acpi_battery_hook_ops dell_wmi_ddv_battery_hook_ops =
=3D {
+	.add_battery =3D dell_wmi_ddv_add_battery,
+	.remove_battery =3D dell_wmi_ddv_remove_battery,
+};
+
+static void dell_wmi_ddv_battery_remove(void *data)
+{
+	struct acpi_battery_hook *hook =3D data;
+
+	battery_hook_unregister(hook);
+}
+
+static int dell_wmi_ddv_battery_add(struct dell_wmi_ddv_data *data)
+{
+	struct acpi_battery_hook *hook;
+
+	sysfs_attr_init(&data->temp_attr.attr);
+	data->temp_attr.attr.name =3D "temp";
+	data->temp_attr.attr.mode =3D 0444;
+	data->temp_attr.show =3D temp_show;
+
+	sysfs_attr_init(&data->eppid_attr.attr);
+	data->eppid_attr.attr.name =3D "eppid";
+	data->eppid_attr.attr.mode =3D 0444;
+	data->eppid_attr.show =3D eppid_show;
+
+	hook =3D battery_hook_register("DELL Battery Extension", data,
+				     &dell_wmi_ddv_battery_hook_ops);
+	if (IS_ERR(hook))
+		return PTR_ERR(hook);
+
+	return devm_add_action_or_reset(&data->wdev->dev, dell_wmi_ddv_battery_r=
emove, hook);
+}
+
+static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_m=
ethod method)
+{
+	struct device *dev =3D seq->private;
+	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
+	union acpi_object *obj;
+	union acpi_object buf;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
+	if (ret < 0)
+		return ret;
+
+	buf =3D obj->package.elements[1];
+	ret =3D seq_write(seq, buf.buffer.pointer, buf.buffer.length);
+	kfree(obj);
+
+	return ret;
+}
+
+static int dell_wmi_ddv_fan_read(struct seq_file *seq, void *offset)
+{
+	return dell_wmi_ddv_buffer_read(seq, DELL_DDV_FAN_SENSOR_INFORMATION);
+}
+
+static int dell_wmi_ddv_temp_read(struct seq_file *seq, void *offset)
+{
+	return dell_wmi_ddv_buffer_read(seq, DELL_DDV_THERMAL_SENSOR_INFORMATION=
);
+}
+
+static void dell_wmi_ddv_debugfs_remove(void *data)
+{
+	struct dentry *entry =3D data;
+
+	debugfs_remove(entry);
+}
+
+static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
+{
+	struct dentry *entry;
+	char name[64];
+
+	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->=
dev));
+	entry =3D debugfs_create_dir(name, NULL);
+
+	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
+				    dell_wmi_ddv_fan_read);
+	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", en=
try,
+				    dell_wmi_ddv_temp_read);
+
+	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry)=
;
+}
+
+static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *contex=
t)
+{
+	struct dell_wmi_ddv_data *data;
+	u32 version;
+	int ret;
+
+	ret =3D dell_wmi_ddv_query_integer(wdev, DELL_DDV_INTERFACE_VERSION, 0, =
&version);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(&wdev->dev, "WMI interface version: %d\n", version);
+	if (version !=3D DELL_DDV_SUPPORTED_INTERFACE)
+		return -ENODEV;
+
+	data =3D devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	dev_set_drvdata(&wdev->dev, data);
+	data->wdev =3D wdev;
+
+	dell_wmi_ddv_debugfs_init(wdev);
+
+	return dell_wmi_ddv_battery_add(data);
+}
+
+static const struct wmi_device_id dell_wmi_ddv_id_table[] =3D {
+	{ DELL_DDV_GUID, NULL },
+	{ }
+};
+MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
+
+static struct wmi_driver dell_wmi_ddv_driver =3D {
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+	},
+	.id_table =3D dell_wmi_ddv_id_table,
+	.probe =3D dell_wmi_ddv_probe,
+};
+module_wmi_driver(dell_wmi_ddv_driver);
+
+MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
+MODULE_DESCRIPTION("Dell WMI sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index aff23309b5d3..f307d8c5c6c3 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -108,6 +108,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
 /* allow duplicate GUIDs as these device drivers use struct wmi_driver */
 static const char * const allow_duplicates[] =3D {
 	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
+	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
 	NULL
 };

=2D-
2.30.2

