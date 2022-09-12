Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15DE5B5A90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiILMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiILMyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:54:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608FB3869B;
        Mon, 12 Sep 2022 05:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662987232;
        bh=sW1W68spZdQHzaw9zpfBQ/9ZrMwiIiIAA3+2wSWc8mI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=id3fEoHXUHaIQbQI5THNG/+XlvV15NhAlr/yuLZ5IB2r3G7zJZ2G4L4+V8Gtb2g+M
         fDNT/qq19PEyXUh60LCb6CiASHDWYWF0W6gfsVWp7ilGxXT70eAbwD0GY32kXDJ3u/
         cPZ+gLQ3gGVmQgLgGtcwwgpqjKhr+6OTcefdf85Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N3bSt-1pWfAS3Kdv-010eB5; Mon, 12 Sep 2022 14:53:51 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ACPI: battery: Allow for passing data to battery hooks.
Date:   Mon, 12 Sep 2022 14:53:41 +0200
Message-Id: <20220912125342.7395-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912125342.7395-1-W_Armin@gmx.de>
References: <20220912125342.7395-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qFkj93qtnUCTrPRR2vZjFev3kQ2zRpUqIyEpl3hJW6QjnFgAzWA
 4qFAw4PN2lzM1ZHQ4O4LDHITVqkJRmGjL+MAnBxadebSQuPao3o7B/MoJmpJtNBm/KZDc0H
 psPg9q8pXuYcIsM1XfPn4lwhuSZJyJWqeGLydKI8YK/BrxNVXI5lRrsuB6NvPr5wHKS7dDh
 N9GS73VoubzuJ1Cib4H0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6ka7/eg1V6k=:2PZ8D5dUX4e4W8s/UrhXYj
 QPyQZXq/zCBqx5KiXtvLUKV5uoa0piSMwj8Qx/y6r8lbGyNb+l+7bvzKOtykbb37za7I2r6/d
 9MZ54Li1D13MZeAV+11zp/ENfnxPCxh7ufvmqvswYhRcxAwmUsze6DbQ1bJJwIA64zHp8/YY3
 Mgyq9N5SgZx1Wlm8Zddnr8h4A9wh/QCvT+l3bRHzqI9flTXPSwHUHTh608pyk80Tv7nhQ1uCg
 xNQFGLW1axGX7eRK+ENCGdu0lb8SFxWf/NCNwfbPDSfpedSgZWYLtdGGXoP4YJIhqYX6z1w2D
 qTZ8osRU4jPyCqJNZU0IiT3ZM6lH2S8BtvkZCeoOJ5c9Jjjmc9405VKTj+1XOqQNzNA6vXbuJ
 XACNjK86hVw13NeexZZ/g8Bkf1MIHeJWNGbeoIQpns8RmizBqWa6PbEKRF0f2zD1/OUpZTA/z
 TvA1NUqI+aYrr88xjagDCBGRpj3TqJdFkf1+vb+StIptaNuF19PhlxbGFeE7xppptnkQoiMqC
 lhOKeBN8glFEGgqz7VACby171VAKsjWQuOBCtgtEoAyFYOSd/ycdyUlisU3PRBPEnylHXryEC
 1/KurzGffnIQb/4QPQgAZDz4uU1oLJ/5inm9ZxSjn1SP3C6qoDDoC40PL+6ilBID2Ioizi/DK
 a7fVE5zUi/cJJhjP/N5Ag1tvAMZbzflGH2lku2slti0BjI+pY2FPuIG8LrHmZB6kpUWa2s5MK
 p8mNpNm9n3MueA+JDRcIshuctMbaxhBcf/eJ5MVfKB4HpKBSBkr1FLsgSDnt+FvMWK6EG4TXl
 k4GrnyZbR2OJCjgQERXXJd4gAq9/P1PZtDSGlCnUP8NDgGBa/YwWZ6He20Qduhbyj44TOBvyC
 nt+HQqyBKkXiToGlvh5xnT4Cck5WFCXBmWoPZlbwxmGY/R017J6EI4h2pClp0qXGpaOrgCvv/
 U3+RoqZBxSmaVkCv5bl+SB0pBWiiVHfv7BErxcK+7X+gPQEKJ2arIG4RXHTpLYadWaUdRD9ez
 IwhRQcNF8CrKg5QYp+HcEiEcGQ9Q72RbGYVcjFBuN+xDSWs07NxdTypipO3LqlC5KtHvWtCmN
 q6OjnMtADgxPEAs45e2iMY5ejlFEhVVLnwzGFhs9rtF58icxtYKK8uEL6VN45q6DFg/0j//s4
 ZlE78YQ/vcDY0tdhBZqM+bbWku
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a driver may register multiple instances of a
battery hook, passing data to each instance is
convenient.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c               | 11 ++++++-----
 drivers/platform/x86/asus-wmi.c      |  7 ++++---
 drivers/platform/x86/huawei-wmi.c    |  6 +++---
 drivers/platform/x86/lg-laptop.c     |  6 +++---
 drivers/platform/x86/system76_acpi.c |  6 +++---
 drivers/platform/x86/thinkpad_acpi.c |  6 +++---
 include/acpi/battery.h               |  7 ++++---
 7 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 15bb5d868a56..396a7324216c 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -696,7 +696,7 @@ void battery_hook_unregister(struct acpi_battery_hook =
*hook)
 	mutex_lock(&hook_mutex);

 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		hook->ops->remove_battery(battery->bat);
+		hook->ops->remove_battery(hook->data, battery->bat);
 	}
 	list_del(&hook->list);

@@ -706,7 +706,7 @@ void battery_hook_unregister(struct acpi_battery_hook =
*hook)
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);

-struct acpi_battery_hook *battery_hook_register(const char *name,
+struct acpi_battery_hook *battery_hook_register(const char *name, void *d=
ata,
 						const struct acpi_battery_hook_ops *ops)
 {
 	struct acpi_battery_hook *hook =3D kzalloc(sizeof(*hook), GFP_KERNEL);
@@ -716,6 +716,7 @@ struct acpi_battery_hook *battery_hook_register(const =
char *name,
 		return ERR_PTR(-ENOMEM);

 	hook->name =3D name;
+	hook->data =3D data;
 	hook->ops =3D ops;

 	mutex_lock(&hook_mutex);
@@ -728,7 +729,7 @@ struct acpi_battery_hook *battery_hook_register(const =
char *name,
 	 * its attributes.
 	 */
 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		hook->ops->add_battery(battery->bat);
+		hook->ops->add_battery(hook->data, battery->bat);
 	}
 	pr_info("new extension: %s\n", hook->name);

@@ -758,7 +759,7 @@ static void battery_hook_add_battery(struct acpi_batte=
ry *battery)
 	 * during the battery module initialization.
 	 */
 	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
-		hook_node->ops->add_battery(battery->bat);
+		hook_node->ops->add_battery(hook_node->data, battery->bat);
 	}
 	mutex_unlock(&hook_mutex);
 }
@@ -773,7 +774,7 @@ static void battery_hook_remove_battery(struct acpi_ba=
ttery *battery)
 	 * custom attributes from the battery.
 	 */
 	list_for_each_entry(hook, &battery_hook_list, list) {
-		hook->ops->remove_battery(battery->bat);
+		hook->ops->remove_battery(hook->data, battery->bat);
 	}
 	/* Then, just remove the battery from the list */
 	list_del(&battery->list);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index 37d8649418f4..18afcf38931f 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -882,7 +882,7 @@ static ssize_t charge_control_end_threshold_show(struc=
t device *device,

 static DEVICE_ATTR_RW(charge_control_end_threshold);

-static int asus_wmi_battery_add(struct power_supply *battery)
+static int asus_wmi_battery_add(void *data, struct power_supply *battery)
 {
 	/* The WMI method does not provide a way to specific a battery, so we
 	 * just assume it is the first battery.
@@ -909,7 +909,7 @@ static int asus_wmi_battery_add(struct power_supply *b=
attery)
 	return 0;
 }

-static int asus_wmi_battery_remove(struct power_supply *battery)
+static int asus_wmi_battery_remove(void *data, struct power_supply *batte=
ry)
 {
 	device_remove_file(&battery->dev,
 			   &dev_attr_charge_control_end_threshold);
@@ -924,7 +924,8 @@ static const struct acpi_battery_hook_ops battery_hook=
_ops =3D {
 static void asus_wmi_battery_init(struct asus_wmi *asus)
 {
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_RSOC)) {
-		asus->hook =3D battery_hook_register("ASUS Battery Extension", &battery=
_hook_ops);
+		asus->hook =3D battery_hook_register("ASUS Battery Extension", NULL,
+						   &battery_hook_ops);
 	}
 }

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huaw=
ei-wmi.c
index 6fd02b25a97b..f23806299c1a 100644
=2D-- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -469,7 +469,7 @@ static DEVICE_ATTR_RW(charge_control_start_threshold);
 static DEVICE_ATTR_RW(charge_control_end_threshold);
 static DEVICE_ATTR_RW(charge_control_thresholds);

-static int huawei_wmi_battery_add(struct power_supply *battery)
+static int huawei_wmi_battery_add(void *data, struct power_supply *batter=
y)
 {
 	int err =3D 0;

@@ -484,7 +484,7 @@ static int huawei_wmi_battery_add(struct power_supply =
*battery)
 	return err;
 }

-static int huawei_wmi_battery_remove(struct power_supply *battery)
+static int huawei_wmi_battery_remove(void *data, struct power_supply *bat=
tery)
 {
 	device_remove_file(&battery->dev, &dev_attr_charge_control_start_thresho=
ld);
 	device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold=
);
@@ -507,7 +507,7 @@ static void huawei_wmi_battery_setup(struct device *de=
v)
 		return;
 	}

-	huawei->hook =3D battery_hook_register("Huawei Battery Extension",
+	huawei->hook =3D battery_hook_register("Huawei Battery Extension", NULL,
 					     &huawei_wmi_battery_hook_ops);
 	device_create_file(dev, &dev_attr_charge_control_thresholds);
 }
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index d8a61a07313e..f1abb1924150 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -547,7 +547,7 @@ static DEVICE_ATTR_RW(fn_lock);
 static DEVICE_ATTR_RW(charge_control_end_threshold);
 static DEVICE_ATTR_RW(battery_care_limit);

-static int lg_battery_add(struct power_supply *battery)
+static int lg_battery_add(void *data, struct power_supply *battery)
 {
 	if (device_create_file(&battery->dev,
 			       &dev_attr_charge_control_end_threshold))
@@ -556,7 +556,7 @@ static int lg_battery_add(struct power_supply *battery=
)
 	return 0;
 }

-static int lg_battery_remove(struct power_supply *battery)
+static int lg_battery_remove(void *data, struct power_supply *battery)
 {
 	device_remove_file(&battery->dev,
 			   &dev_attr_charge_control_end_threshold);
@@ -750,7 +750,7 @@ static int acpi_add(struct acpi_device *device)
 	led_classdev_register(&pf_device->dev, &tpad_led);

 	wmi_input_setup();
-	hook =3D battery_hook_register("LG Battery Extension", &battery_hook_ops=
);
+	hook =3D battery_hook_register("LG Battery Extension", NULL, &battery_ho=
ok_ops);

 	return 0;

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/s=
ystem76_acpi.c
index 1ec22db32bd0..9414b9491806 100644
=2D-- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -255,7 +255,7 @@ static struct attribute *system76_battery_attrs[] =3D =
{

 ATTRIBUTE_GROUPS(system76_battery);

-static int system76_battery_add(struct power_supply *battery)
+static int system76_battery_add(void *data, struct power_supply *battery)
 {
 	// System76 EC only supports 1 battery
 	if (strcmp(battery->desc->name, "BAT0") !=3D 0)
@@ -267,7 +267,7 @@ static int system76_battery_add(struct power_supply *b=
attery)
 	return 0;
 }

-static int system76_battery_remove(struct power_supply *battery)
+static int system76_battery_remove(void *data, struct power_supply *batte=
ry)
 {
 	device_remove_groups(&battery->dev, system76_battery_groups);
 	return 0;
@@ -280,7 +280,7 @@ static const struct acpi_battery_hook_ops system76_bat=
tery_hook_ops =3D {

 static void system76_battery_init(struct system76_data *data)
 {
-	data->hook =3D battery_hook_register("System76 Battery Extension",
+	data->hook =3D battery_hook_register("System76 Battery Extension", NULL,
 					   &system76_battery_hook_ops);
 }

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/t=
hinkpad_acpi.c
index 8adafc3c31fa..6008d88e0727 100644
=2D-- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9898,7 +9898,7 @@ ATTRIBUTE_GROUPS(tpacpi_battery);

 /* ACPI battery hooking */

-static int tpacpi_battery_add(struct power_supply *battery)
+static int tpacpi_battery_add(void *data, struct power_supply *battery)
 {
 	int batteryid =3D tpacpi_battery_get_id(battery->desc->name);

@@ -9909,7 +9909,7 @@ static int tpacpi_battery_add(struct power_supply *b=
attery)
 	return 0;
 }

-static int tpacpi_battery_remove(struct power_supply *battery)
+static int tpacpi_battery_remove(void *data, struct power_supply *battery=
)
 {
 	device_remove_groups(&battery->dev, tpacpi_battery_groups);
 	return 0;
@@ -9943,7 +9943,7 @@ static int __init tpacpi_battery_init(struct ibm_ini=
t_struct *ibm)
 					battery_quirk_table,
 					ARRAY_SIZE(battery_quirk_table));

-	battery_info.hook =3D battery_hook_register("ThinkPad Battery Extension"=
,
+	battery_info.hook =3D battery_hook_register("ThinkPad Battery Extension"=
, NULL,
 						  &battery_hook_ops);

 	return 0;
diff --git a/include/acpi/battery.h b/include/acpi/battery.h
index b3c81abada1e..cca401b793b2 100644
=2D-- a/include/acpi/battery.h
+++ b/include/acpi/battery.h
@@ -11,17 +11,18 @@
 #define ACPI_BATTERY_NOTIFY_THRESHOLD   0x82

 struct acpi_battery_hook_ops {
-	int (*add_battery)(struct power_supply *battery);
-	int (*remove_battery)(struct power_supply *battery);
+	int (*add_battery)(void *data, struct power_supply *battery);
+	int (*remove_battery)(void *data, struct power_supply *battery);
 };

 struct acpi_battery_hook {
 	const char *name;
 	const struct acpi_battery_hook_ops *ops;
+	void *data;
 	struct list_head list;
 };

-struct acpi_battery_hook *battery_hook_register(const char *name,
+struct acpi_battery_hook *battery_hook_register(const char *name, void *d=
ata,
 						const struct acpi_battery_hook_ops *hook);
 void battery_hook_unregister(struct acpi_battery_hook *hook);

=2D-
2.30.2

