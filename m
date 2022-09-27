Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805B35ECEE2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiI0Upy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiI0Upq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:45:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EE572FDC;
        Tue, 27 Sep 2022 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1664311527;
        bh=/SX6Itfe956cQHBuREIX2bQWe53jniUVaVFpuVsRRzQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=M6gdcd9Dt3nK83sVaE8VkYBwLR21DP78olZXbSEVoEl7kCzurWG1f2pmBbYQVcK8A
         vzxUMI1NWof5j7TbdZDGamTN0HgBas6jFG1ibr569JDtKvgDKXicty0O7l5KMNenE2
         Dt+nh3DSLwN1dhzvPnKZJiet7lslnaKm1xr5el4c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MUXtS-1olybO45IG-00QV1y; Tue, 27 Sep 2022 22:45:27 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, mario.limonciello@amd.com,
        pobrn@protonmail.com, coproscefalo@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ACPI: battery: Pass battery hook pointer to hook callbacks
Date:   Tue, 27 Sep 2022 22:45:20 +0200
Message-Id: <20220927204521.601887-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927204521.601887-1-W_Armin@gmx.de>
References: <20220927204521.601887-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rVigeiPzjmZrxqycybkalfTOJ7+raJLwpKF4shbsLG3Ga9N+PXE
 px1RplMzYVovOWpucS8W7iCIGuKptc+mKgt2g1NRE9T3Ff9N+ZzakZvSXjD7HWiRBkKQ+XG
 yZ27Y261Yym6FnFkoH32f2zX/hz7fU+eIKIqSuSslVuIeStPVPkJUJch2MzhrRGwaSMXfqZ
 ajeKiKaanGmj16xkl4nMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2pr/9gGwuGY=:Eowgf4KZ6NWnd1otXcUQfW
 VWOlkMkz9g9bulHPh3tIUWFvpRdwLYTNXrtpcB1rO2mZ+tOpqsrLthp7W9dRQG/TzxfkXuIb2
 cvSJk85HWzl/EGxCiFdg2tHhBPFFD4GTi2HCP7tFOG6XN1z1PG/ChhXMYETr8PXledv23ldBt
 QtMQBx3dmGC/7oEyxl39ihbxsNLYdpFlRqjh4fPRW/XPD9DByIqUTBxiQvdB81MUV7xn5kP1o
 /9rRf6Oubq6cAuES1SMULhM/kagnR2ohc/cPsGjbaR4kDjUWSh89VCOfTBHOES6N5m6IJcGgc
 CA1oDWGlMaDDrZc6XeN8Y2E1rbe1EWmQ4kpkumutodA/O5nI/xFKr6AIliIJ7ooXGqwh2yZOr
 jM+OG+CkLC4SjTJBk+tx60WyfVTYYJweRNz21VWEizd2jqVsvWymxRoLcWeBarb03tl4pUx0w
 qkIWL7EUC3OOcRjMYjyK56f/nhHz6qsU/tPRt87ploZDmH33isQcJebO9SzudRz9tqCKXdfVy
 08bDA8tr+OxsyiSy4WAiXaPgHMGemnkmx+gBvoXf18gTvK7edZcBcPgPT6AScTu9jyoKPqM68
 QmKhcOGkIBQ7mT32b1XTy2VY6tSkowK2X2i0EA5uSD+AJZqBIa/aJM06dtLxTW4q9U2pIAwnL
 stV09m0AspiB4X5OTU54kl9QAuRR6+kDnFOpSNE0u+DtmgTB/0XQNykytG8Cp6efcZAxS7mbR
 QH6zKl0PltJhkB2KtFVZ8IHpZwYCSzJ3DQMQyva+tqX/mWrt2vQpp4XQ5Ivg+hZcxeiuqGghg
 qcrSgSK8LHYiQB4zDtwcazvMgrMhLdY/O1j2l9wT3vtdebm6VGaX1o8PU/lurppCVVaZlgK+Q
 MMM+Mxgmc7vS0O4l8cmXPxSLIPeWNhSk3lxbsP4/0PgKFW9EbOETBLb0TOJBiH4NrfSXeDa85
 GjekejTm/dAt2DLjnSM8WU2450t5BM4Po0N1Sv2hv6VIETGqSXmfJOoIOkPgu08h+jwZcwD1C
 Yf5d7HXNHNviDmGOgPyDPoXorD+EfSUf7ZeK8lXa5nvaTVt69GaP99mkHz1cuMbTDlpcWDsZd
 FUrss6RWAsSwJPMt/MEkITQU4GDlMKOTIkTJNMI8JBnGIZIf9Fw7HDUsOcBX+knJi7H+E9JRX
 jONgJyodGmwYGBcyKr+hmkuJ3A
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_BL,
        RCVD_IN_MSPIKE_ZBI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, is impossible for battery hook callbacks
to access instance-specific data, forcing most drivers
to provide some sort of global state. This however is
difficult for drivers which can be instantiated multiple
times and/or are hotplug-capable.

Pass a pointer to the batetry hook to those callbacks
for usage with container_of().

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c               | 8 ++++----
 drivers/platform/x86/asus-wmi.c      | 4 ++--
 drivers/platform/x86/huawei-wmi.c    | 4 ++--
 drivers/platform/x86/lg-laptop.c     | 4 ++--
 drivers/platform/x86/system76_acpi.c | 4 ++--
 drivers/platform/x86/thinkpad_acpi.c | 4 ++--
 drivers/platform/x86/toshiba_acpi.c  | 4 ++--
 include/acpi/battery.h               | 4 ++--
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 306513fec1e1..9482b0b6eadc 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -696,7 +696,7 @@ static void __battery_hook_unregister(struct acpi_batt=
ery_hook *hook, int lock)
 	if (lock)
 		mutex_lock(&hook_mutex);
 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		hook->remove_battery(battery->bat);
+		hook->remove_battery(battery->bat, hook);
 	}
 	list_del(&hook->list);
 	if (lock)
@@ -724,7 +724,7 @@ void battery_hook_register(struct acpi_battery_hook *h=
ook)
 	 * its attributes.
 	 */
 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		if (hook->add_battery(battery->bat)) {
+		if (hook->add_battery(battery->bat, hook)) {
 			/*
 			 * If a add-battery returns non-zero,
 			 * the registration of the extension has failed,
@@ -762,7 +762,7 @@ static void battery_hook_add_battery(struct acpi_batte=
ry *battery)
 	 * during the battery module initialization.
 	 */
 	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
-		if (hook_node->add_battery(battery->bat)) {
+		if (hook_node->add_battery(battery->bat, hook_node)) {
 			/*
 			 * The notification of the extensions has failed, to
 			 * prevent further errors we will unload the extension.
@@ -785,7 +785,7 @@ static void battery_hook_remove_battery(struct acpi_ba=
ttery *battery)
 	 * custom attributes from the battery.
 	 */
 	list_for_each_entry(hook, &battery_hook_list, list) {
-		hook->remove_battery(battery->bat);
+		hook->remove_battery(battery->bat, hook);
 	}
 	/* Then, just remove the battery from the list */
 	list_del(&battery->list);
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-w=
mi.c
index ae46af731de9..446669d11095 100644
=2D-- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -882,7 +882,7 @@ static ssize_t charge_control_end_threshold_show(struc=
t device *device,

 static DEVICE_ATTR_RW(charge_control_end_threshold);

-static int asus_wmi_battery_add(struct power_supply *battery)
+static int asus_wmi_battery_add(struct power_supply *battery, struct acpi=
_battery_hook *hook)
 {
 	/* The WMI method does not provide a way to specific a battery, so we
 	 * just assume it is the first battery.
@@ -909,7 +909,7 @@ static int asus_wmi_battery_add(struct power_supply *b=
attery)
 	return 0;
 }

-static int asus_wmi_battery_remove(struct power_supply *battery)
+static int asus_wmi_battery_remove(struct power_supply *battery, struct a=
cpi_battery_hook *hook)
 {
 	device_remove_file(&battery->dev,
 			   &dev_attr_charge_control_end_threshold);
diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huaw=
ei-wmi.c
index eac3e6b4ea11..1dec4427053a 100644
=2D-- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -468,7 +468,7 @@ static DEVICE_ATTR_RW(charge_control_start_threshold);
 static DEVICE_ATTR_RW(charge_control_end_threshold);
 static DEVICE_ATTR_RW(charge_control_thresholds);

-static int huawei_wmi_battery_add(struct power_supply *battery)
+static int huawei_wmi_battery_add(struct power_supply *battery, struct ac=
pi_battery_hook *hook)
 {
 	int err =3D 0;

@@ -483,7 +483,7 @@ static int huawei_wmi_battery_add(struct power_supply =
*battery)
 	return err;
 }

-static int huawei_wmi_battery_remove(struct power_supply *battery)
+static int huawei_wmi_battery_remove(struct power_supply *battery, struct=
 acpi_battery_hook *hook)
 {
 	device_remove_file(&battery->dev, &dev_attr_charge_control_start_thresho=
ld);
 	device_remove_file(&battery->dev, &dev_attr_charge_control_end_threshold=
);
diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index 332868b140ed..d662b64b0ba9 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -546,7 +546,7 @@ static DEVICE_ATTR_RW(fn_lock);
 static DEVICE_ATTR_RW(charge_control_end_threshold);
 static DEVICE_ATTR_RW(battery_care_limit);

-static int lg_battery_add(struct power_supply *battery)
+static int lg_battery_add(struct power_supply *battery, struct acpi_batte=
ry_hook *hook)
 {
 	if (device_create_file(&battery->dev,
 			       &dev_attr_charge_control_end_threshold))
@@ -555,7 +555,7 @@ static int lg_battery_add(struct power_supply *battery=
)
 	return 0;
 }

-static int lg_battery_remove(struct power_supply *battery)
+static int lg_battery_remove(struct power_supply *battery, struct acpi_ba=
ttery_hook *hook)
 {
 	device_remove_file(&battery->dev,
 			   &dev_attr_charge_control_end_threshold);
diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/s=
ystem76_acpi.c
index 958df41ad509..9031bd53253f 100644
=2D-- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -254,7 +254,7 @@ static struct attribute *system76_battery_attrs[] =3D =
{

 ATTRIBUTE_GROUPS(system76_battery);

-static int system76_battery_add(struct power_supply *battery)
+static int system76_battery_add(struct power_supply *battery, struct acpi=
_battery_hook *hook)
 {
 	// System76 EC only supports 1 battery
 	if (strcmp(battery->desc->name, "BAT0") !=3D 0)
@@ -266,7 +266,7 @@ static int system76_battery_add(struct power_supply *b=
attery)
 	return 0;
 }

-static int system76_battery_remove(struct power_supply *battery)
+static int system76_battery_remove(struct power_supply *battery, struct a=
cpi_battery_hook *hook)
 {
 	device_remove_groups(&battery->dev, system76_battery_groups);
 	return 0;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/t=
hinkpad_acpi.c
index 8fbe21ebcc52..75ba9e61264e 100644
=2D-- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9897,7 +9897,7 @@ ATTRIBUTE_GROUPS(tpacpi_battery);

 /* ACPI battery hooking */

-static int tpacpi_battery_add(struct power_supply *battery)
+static int tpacpi_battery_add(struct power_supply *battery, struct acpi_b=
attery_hook *hook)
 {
 	int batteryid =3D tpacpi_battery_get_id(battery->desc->name);

@@ -9908,7 +9908,7 @@ static int tpacpi_battery_add(struct power_supply *b=
attery)
 	return 0;
 }

-static int tpacpi_battery_remove(struct power_supply *battery)
+static int tpacpi_battery_remove(struct power_supply *battery, struct acp=
i_battery_hook *hook)
 {
 	device_remove_groups(&battery->dev, tpacpi_battery_groups);
 	return 0;
diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/to=
shiba_acpi.c
index 43cc25351aea..c8f01f8f435d 100644
=2D-- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3113,7 +3113,7 @@ static struct attribute *toshiba_acpi_battery_attrs[=
] =3D {

 ATTRIBUTE_GROUPS(toshiba_acpi_battery);

-static int toshiba_acpi_battery_add(struct power_supply *battery)
+static int toshiba_acpi_battery_add(struct power_supply *battery, struct =
acpi_battery_hook *hook)
 {
 	if (toshiba_acpi =3D=3D NULL) {
 		pr_err("Init order issue\n");
@@ -3126,7 +3126,7 @@ static int toshiba_acpi_battery_add(struct power_sup=
ply *battery)
 	return 0;
 }

-static int toshiba_acpi_battery_remove(struct power_supply *battery)
+static int toshiba_acpi_battery_remove(struct power_supply *battery, stru=
ct acpi_battery_hook *hook)
 {
 	device_remove_groups(&battery->dev, toshiba_acpi_battery_groups);
 	return 0;
diff --git a/include/acpi/battery.h b/include/acpi/battery.h
index b8d56b702c7a..611a2561a014 100644
=2D-- a/include/acpi/battery.h
+++ b/include/acpi/battery.h
@@ -12,8 +12,8 @@

 struct acpi_battery_hook {
 	const char *name;
-	int (*add_battery)(struct power_supply *battery);
-	int (*remove_battery)(struct power_supply *battery);
+	int (*add_battery)(struct power_supply *battery, struct acpi_battery_hoo=
k *hook);
+	int (*remove_battery)(struct power_supply *battery, struct acpi_battery_=
hook *hook);
 	struct list_head list;
 };

=2D-
2.30.2

