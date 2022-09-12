Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDD25B5A92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiILMy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiILMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:54:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865D4386B3;
        Mon, 12 Sep 2022 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662987230;
        bh=k9YDAppcKkq2ArgBg9pY+g/nuPhYMJY6cXdn4yJClEs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=k0YKkh5qU1cs2dy+vXJddPmszGCj1TIYZCm78r6murV3spf/j6Dw5yuX4jtqydr/t
         ceFNVpasD4hluSzzBYG5B5TxbRK1DrkYJubcXA+MwLkTPA7DjGfGR5iP4ARaPPnvfj
         a2CiHbuqDa6f1RYo8ij6deAONRjC2hfTQnm01WgI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1McpNo-1p6VSu1BYY-00Zx13; Mon, 12 Sep 2022 14:53:50 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ACPI: battery: Allow battery hooks to be registered multiple times.
Date:   Mon, 12 Sep 2022 14:53:40 +0200
Message-Id: <20220912125342.7395-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912125342.7395-1-W_Armin@gmx.de>
References: <20220912125342.7395-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vntFRVjmTWKgpdc0xf7mZru17K6B4tMLwPKwGfWCecrzly2Ef6j
 ubroTEusCDQx2KHwGyP+UuPMXYJLtJKswDIWC8QxoKP+n3DHTSpXq0+XIAfHqE6jtjT1WPR
 sA3E4Xjmc7OBD5lHIjOv9fDxgggc703TMpPxeXvr6R9pOUdG38+CV61yKmJsaSYW/5qCwV+
 LEDoDehU6DbOyscriA0dw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ow+eob142Wg=:RlZ6EFXhSuGcO2A23A/Bcj
 MVzgdRpmUfdjVvzsdLDKncPqI5KwDx2es51R2bCMfijXA8VlyEX7MCMX9nSacYZ3wxzns8O8p
 pg3reMDc8EEKiT2hHEu+0QuYyNDRRBSgfILGBNcDRpdh9HrF6oovYagJGov4z9xJyi/EZZv6k
 +Y0b/AYgz3KNqCD3SCIj/aIO5d0pmIi1K+MGYJTb+E45zMaCqcNt1KF1ZmPmQsUi3+m4jpG1m
 dFhdKK3jF4t+kOd6uQshIbZMv3V7BmSnKadC8uAZNWCek03Vpv8qMJU3Ljix7NbwjJCPa9M0V
 hJe9fU1HqtvY2jWQFgStSFx6q/pQSvSKQuVFhTVNeAz0J8mMoSLx0VWJn1oUaDNUaADEEL2Mn
 oBAG1CUwZhtvPtmflf20pBPI1r4XxRbRTtn6cW9NBNsX8q73Xo5wPYpws8FJRMFU4Hsj7RYJD
 zu+flPfrqTqwYXZ0J9vrweow8jhUNezcpyzgV5Iy1YaCiAgWC4+G7Al81GFBOwess7UiInCSQ
 iYW1jycrg2AbXQJ5DbaUaVYGS3ndt5JJ7gKXLRNtAS983Fj2DaVJ/aosOyWCin0Kq5PSNqh60
 0gNHwpn1zui8gbgPmGuo11DG+WSHjNS3entRBC3HgiS1qNQuqNEGNBydvjiaS2CuBAjq8KZny
 8ysB/LO9A+7n2Bu+VpS+GZOZ9+gZCapN2Z47JU9Aa6NhKh4cRUJdmV8oo5Pidtx+6WrkB72qn
 OOm3jK/of/pd4CwU/tuL2/MVMf24NtJ3ACs80YfIKQITfGS3UuYf+oFzOLfIsXj01M2b1h6so
 vyOA2hDHa9srX2C0Ds3ynDZ4b7NOf9zKHrGmC0bV2bqKWoVCz6ITODeemM8tBsFo1LZGjN0Wx
 vgb8/GE3+u5raEstzESx6OgT3LynzUh+L18q5JM0K2UEQUqGGWQb0+eHKZeXbFO8vxM9C2WCV
 zybfMYT3SIAmdKDVGg2ANf1DXgF37RmYRY7UX0u/EPKBuvo0sebEdio8ZB1v9Om1O6+XTy25/
 C/qiP1PAP0CjEPChkYeEOPqlhcVGC8kmJ0oFWF371EfyPWPpYrzmIDcVAdBB6Djshqam23ayX
 r4kh9/L+pqG9YkfFDEU/dtiF4GpD5OYbPo4Tt00GZjpEBggskKzRbbKOEToNAYpHuvGGE/ksZ
 +aWqW08DykR0B6QRIAZoYQBTkT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registering multiple instances of a battery hook is beneficial
for drivers which can be instantiated multiple times. Until now,
this would mean that such a driver would have to implement some
logic to manage battery hooks.

Extend the battery hook handling instead.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c               | 21 ++++++++++++++++-----
 drivers/platform/x86/asus-wmi.c      | 15 ++++++---------
 drivers/platform/x86/huawei-wmi.c    | 11 +++++++----
 drivers/platform/x86/lg-laptop.c     | 10 ++++++----
 drivers/platform/x86/system76_acpi.c | 18 ++++++++++--------
 drivers/platform/x86/thinkpad_acpi.c | 11 +++++++----
 include/acpi/battery.h               | 11 ++++++++---
 7 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4aea65f3d8c3..15bb5d868a56 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -696,19 +696,28 @@ void battery_hook_unregister(struct acpi_battery_hoo=
k *hook)
 	mutex_lock(&hook_mutex);

 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		hook->remove_battery(battery->bat);
+		hook->ops->remove_battery(battery->bat);
 	}
 	list_del(&hook->list);

 	mutex_unlock(&hook_mutex);
 	pr_info("extension unregistered: %s\n", hook->name);
+	kfree(hook);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);

-void battery_hook_register(struct acpi_battery_hook *hook)
+struct acpi_battery_hook *battery_hook_register(const char *name,
+						const struct acpi_battery_hook_ops *ops)
 {
+	struct acpi_battery_hook *hook =3D kzalloc(sizeof(*hook), GFP_KERNEL);
 	struct acpi_battery *battery;

+	if (!hook)
+		return ERR_PTR(-ENOMEM);
+
+	hook->name =3D name;
+	hook->ops =3D ops;
+
 	mutex_lock(&hook_mutex);
 	INIT_LIST_HEAD(&hook->list);
 	list_add(&hook->list, &battery_hook_list);
@@ -719,11 +728,13 @@ void battery_hook_register(struct acpi_battery_hook =
*hook)
 	 * its attributes.
 	 */
 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		hook->add_battery(battery->bat);
+		hook->ops->add_battery(battery->bat);
 	}
 	pr_info("new extension: %s\n", hook->name);

 	mutex_unlock(&hook_mutex);
+
+	return hook;
 }
 EXPORT_SYMBOL_GPL(battery_hook_register);

@@ -747,7 +758,7 @@ static void battery_hook_add_battery(struct acpi_batte=
ry *battery)
 	 * during the battery module initialization.
 	 */
 	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
-		hook_node->add_battery(battery->bat);
+		hook_node->ops->add_battery(battery->bat);
 	}
 	mutex_unlock(&hook_mutex);
 }
@@ -762,7 +773,7 @@ static void battery_hook_remove_battery(struct acpi_ba=
ttery *battery)
 	 * custom attributes from the battery.
 	 */
 	list_for_each_entry(hook, &battery_hook_list, list) {
-		hook->remove_battery(battery->bat);
+		hook->ops->remove_battery(battery->bat);
 	}
 	/* Then, just remove the battery from the list */
 	list_del(&battery->list);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index d95170b7dba0..37d8649418f4 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -252,8 +252,8 @@ struct asus_wmi {
 	struct platform_profile_handler platform_profile_handler;
 	bool platform_profile_support;

-	// The RSOC controls the maximum charging percentage.
-	bool battery_rsoc_available;
+	// The RSOC battery hook controls the maximum charging percentage.
+	struct acpi_battery_hook *hook;

 	bool panel_overdrive_available;

@@ -916,25 +916,22 @@ static int asus_wmi_battery_remove(struct power_supp=
ly *battery)
 	return 0;
 }

-static struct acpi_battery_hook battery_hook =3D {
+static const struct acpi_battery_hook_ops battery_hook_ops =3D {
 	.add_battery =3D asus_wmi_battery_add,
 	.remove_battery =3D asus_wmi_battery_remove,
-	.name =3D "ASUS Battery Extension",
 };

 static void asus_wmi_battery_init(struct asus_wmi *asus)
 {
-	asus->battery_rsoc_available =3D false;
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
-		asus->battery_rsoc_available =3D true;
-		battery_hook_register(&battery_hook);
+		asus->hook =3D battery_hook_register("ASUS Battery Extension", &battery=
_hook_ops);
 	}
 }

 static void asus_wmi_battery_exit(struct asus_wmi *asus)
 {
-	if (asus->battery_rsoc_available)
-		battery_hook_unregister(&battery_hook);
+	if (!IS_ERR_OR_NULL(asus->hook))
+		battery_hook_unregister(asus->hook);
 }

 /* LEDs *****************************************************************=
******/
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huaw=
ei-wmi.c
index eac3e6b4ea11..6fd02b25a97b 100644
=2D-- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -62,6 +62,7 @@ struct huawei_wmi {
 	bool battery_available;
 	bool fn_lock_available;

+	struct acpi_battery_hook *hook;
 	struct huawei_wmi_debug debug;
 	struct input_dev *idev[2];
 	struct led_classdev cdev;
@@ -491,10 +492,9 @@ static int huawei_wmi_battery_remove(struct power_sup=
ply *battery)
 	return 0;
 }

-static struct acpi_battery_hook huawei_wmi_battery_hook =3D {
+static const struct acpi_battery_hook_ops huawei_wmi_battery_hook_ops =3D=
 {
 	.add_battery =3D huawei_wmi_battery_add,
 	.remove_battery =3D huawei_wmi_battery_remove,
-	.name =3D "Huawei Battery Extension"
 };

 static void huawei_wmi_battery_setup(struct device *dev)
@@ -507,7 +507,8 @@ static void huawei_wmi_battery_setup(struct device *de=
v)
 		return;
 	}

-	battery_hook_register(&huawei_wmi_battery_hook);
+	huawei->hook =3D battery_hook_register("Huawei Battery Extension",
+					     &huawei_wmi_battery_hook_ops);
 	device_create_file(dev, &dev_attr_charge_control_thresholds);
 }

@@ -516,7 +517,9 @@ static void huawei_wmi_battery_exit(struct device *dev=
)
 	struct huawei_wmi *huawei =3D dev_get_drvdata(dev);

 	if (huawei->battery_available) {
-		battery_hook_unregister(&huawei_wmi_battery_hook);
+		if (!IS_ERR(huawei->hook))
+			battery_hook_unregister(huawei->hook);
+
 		device_remove_file(dev, &dev_attr_charge_control_thresholds);
 	}
 }
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index 332868b140ed..d8a61a07313e 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -73,6 +73,7 @@ static u32 inited;
 #define INIT_SPARSE_KEYMAP      0x80

 static int battery_limit_use_wmbb;
+static struct acpi_battery_hook *hook;
 static struct led_classdev kbd_backlight;
 static enum led_brightness get_kbd_backlight_level(void);

@@ -562,10 +563,9 @@ static int lg_battery_remove(struct power_supply *bat=
tery)
 	return 0;
 }

-static struct acpi_battery_hook battery_hook =3D {
+static const struct acpi_battery_hook_ops battery_hook_ops =3D {
 	.add_battery =3D lg_battery_add,
 	.remove_battery =3D lg_battery_remove,
-	.name =3D "LG Battery Extension",
 };

 static struct attribute *dev_attributes[] =3D {
@@ -750,7 +750,7 @@ static int acpi_add(struct acpi_device *device)
 	led_classdev_register(&pf_device->dev, &tpad_led);

 	wmi_input_setup();
-	battery_hook_register(&battery_hook);
+	hook =3D battery_hook_register("LG Battery Extension", &battery_hook_ops=
);

 	return 0;

@@ -768,7 +768,9 @@ static int acpi_remove(struct acpi_device *device)
 	led_classdev_unregister(&tpad_led);
 	led_classdev_unregister(&kbd_backlight);

-	battery_hook_unregister(&battery_hook);
+	if (!IS_ERR(hook))
+		battery_hook_unregister(hook);
+
 	wmi_input_destroy();
 	platform_device_unregister(pf_device);
 	pf_device =3D NULL;
diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/s=
ystem76_acpi.c
index 958df41ad509..1ec22db32bd0 100644
=2D-- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -26,6 +26,7 @@

 struct system76_data {
 	struct acpi_device *acpi_dev;
+	struct acpi_battery_hook *hook;
 	struct led_classdev ap_led;
 	struct led_classdev kb_led;
 	enum led_brightness kb_brightness;
@@ -272,20 +273,21 @@ static int system76_battery_remove(struct power_supp=
ly *battery)
 	return 0;
 }

-static struct acpi_battery_hook system76_battery_hook =3D {
+static const struct acpi_battery_hook_ops system76_battery_hook_ops =3D {
 	.add_battery =3D system76_battery_add,
 	.remove_battery =3D system76_battery_remove,
-	.name =3D "System76 Battery Extension",
 };

-static void system76_battery_init(void)
+static void system76_battery_init(struct system76_data *data)
 {
-	battery_hook_register(&system76_battery_hook);
+	data->hook =3D battery_hook_register("System76 Battery Extension",
+					   &system76_battery_hook_ops);
 }

-static void system76_battery_exit(void)
+static void system76_battery_exit(struct system76_data *data)
 {
-	battery_hook_unregister(&system76_battery_hook);
+	if (!IS_ERR(data->hook))
+		battery_hook_unregister(data->hook);
 }

 // Get the airplane mode LED brightness
@@ -730,7 +732,7 @@ static int system76_add(struct acpi_device *acpi_dev)
 		if (err)
 			goto error;

-		system76_battery_init();
+		system76_battery_init(data);
 	}

 	return 0;
@@ -751,7 +753,7 @@ static int system76_remove(struct acpi_device *acpi_de=
v)
 	data =3D acpi_driver_data(acpi_dev);

 	if (data->has_open_ec) {
-		system76_battery_exit();
+		system76_battery_exit(data);
 		kfree(data->nfan);
 		kfree(data->ntmp);
 	}
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/t=
hinkpad_acpi.c
index 8fbe21ebcc52..8adafc3c31fa 100644
=2D-- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9407,6 +9407,7 @@ struct tpacpi_battery_data {

 struct tpacpi_battery_driver_data {
 	struct tpacpi_battery_data batteries[3];
+	struct acpi_battery_hook *hook;
 	int individual_addressing;
 };

@@ -9914,10 +9915,9 @@ static int tpacpi_battery_remove(struct power_suppl=
y *battery)
 	return 0;
 }

-static struct acpi_battery_hook battery_hook =3D {
+static const struct acpi_battery_hook_ops battery_hook_ops =3D {
 	.add_battery =3D tpacpi_battery_add,
 	.remove_battery =3D tpacpi_battery_remove,
-	.name =3D "ThinkPad Battery Extension",
 };

 /* Subdriver init/exit */
@@ -9943,13 +9943,16 @@ static int __init tpacpi_battery_init(struct ibm_i=
nit_struct *ibm)
 					battery_quirk_table,
 					ARRAY_SIZE(battery_quirk_table));

-	battery_hook_register(&battery_hook);
+	battery_info.hook =3D battery_hook_register("ThinkPad Battery Extension"=
,
+						  &battery_hook_ops);
+
 	return 0;
 }

 static void tpacpi_battery_exit(void)
 {
-	battery_hook_unregister(&battery_hook);
+	if (!IS_ERR(battery_info.hook))
+		battery_hook_unregister(battery_info.hook);
 }

 static struct ibm_struct battery_driver_data =3D {
diff --git a/include/acpi/battery.h b/include/acpi/battery.h
index b8d56b702c7a..b3c81abada1e 100644
=2D-- a/include/acpi/battery.h
+++ b/include/acpi/battery.h
@@ -10,14 +10,19 @@
 #define ACPI_BATTERY_NOTIFY_INFO	0x81
 #define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82

-struct acpi_battery_hook {
-	const char *name;
+struct acpi_battery_hook_ops {
 	int (*add_battery)(struct power_supply *battery);
 	int (*remove_battery)(struct power_supply *battery);
+};
+
+struct acpi_battery_hook {
+	const char *name;
+	const struct acpi_battery_hook_ops *ops;
 	struct list_head list;
 };

-void battery_hook_register(struct acpi_battery_hook *hook);
+struct acpi_battery_hook *battery_hook_register(const char *name,
+						const struct acpi_battery_hook_ops *hook);
 void battery_hook_unregister(struct acpi_battery_hook *hook);

 #endif
=2D-
2.30.2

