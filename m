Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD476EFC77
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbjDZV3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239843AbjDZV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:29:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77943AB3;
        Wed, 26 Apr 2023 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682544537; i=w_armin@gmx.de;
        bh=/NvD9oCO/r0GrFnR01vAe+1hQd5sbYS115i1sHjdYVU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c+jhaqnQYsjNniJayHeKrbysCjrX6izuZRB7X9qDmVdBKK9hpSqjEFA7rtMXwo0Wt
         pAqYg9mBuGr1WTvKZUGZVHu22FhInlnnyUpDC/46yQJ7iWFCewruJaovn1fXBNkzpp
         Vvhn4q6a4kJ9Xs/ZIuUiBCT7b1XKcyGWEYxCYMY0z7ts26Clwb7MBJBGIXg4Sr3w/w
         j1jOWPnfGJdfkkJ/MPjpYr4DvikFiYdxaft8Osn9IcPImU/4uZki6lYLEbowqr6wKc
         OUuEI9COjPM0xzlLiTB/e9MEEN72vXsEQQ6BZNP6JYApj94hAMwJSezYrNu9UgjHIi
         hznPILmWgMRTQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MAfUe-1pyQXR1NzE-00B300; Wed, 26 Apr 2023 23:28:57 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 1/2] platform/x86: wmi: Allow retrieving the number of WMI object instances
Date:   Wed, 26 Apr 2023 23:28:47 +0200
Message-Id: <20230426212848.108562-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230426212848.108562-1-W_Armin@gmx.de>
References: <20230426212848.108562-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wg2Q3rOcpLLziRjKpSU4Fquh6no2b2+fC594Er1V0xDb7k5rbuj
 mYlKRfhm8IkOUiLhuH6e1R3FgMSWpAVrjIgVSQc+5kTKgRVrUn3TMPj/qjbMHtB1vwNjlcx
 RSPDICvalGcNtRfC1EnuN98VTrfQVNajOaGGruktwHEYCX40EzQLplYXPoeqBcfn/uKavKo
 4b0EwFBIz5kdq8J/oex2Q==
UI-OutboundReport: notjunk:1;M01:P0:cbF/7xERkYo=;RR+7kF4mAqVLc4S8JUBV928cxmO
 jnOm57TuDfEcdT9cqNwdV/e2Qm1fMFg9u79C4pHM+UIqETLQdcyqSugXybiHuGNANsE84WYRT
 XCThlj0w0oq/AJlnZoMWK17esHgPppdTuCmMFUVHJb5Pmwynsj67EYVGCWLs21E6b6wJB8fny
 mFCJFxRkomudtVMWsS3Y9ZPNEnQSqxvgppnpySBAApqUZ0/ZNxnVSX6RtUWS7huPbRHqeec5W
 PUTuAlPGehhBVaCCtLHoCx1K+jnECI/wOObpub11oXgtqOMBJihJBvMC8RlrQ3y6axvp30Wd2
 FnVYRfqZGgS3ZBYFDYZxDgIjMGtKa+RvzksMz8ny83sAl7Tdv+bykA0ueyAWh+QDhNXJjki8E
 jAD5To0RHOA9Oj6VL6DVdGPH8+Wf22bI2HlYBREWJ5koA7YbwA97EXaU0GgBv5/3W4E3v5PYz
 Wcd3jhn/pJXqaDkbLQEgNqARTnPS2Hkc+O7WdnhAYoRItZ1MISY2EFkkaQx3lbVkMP5UVa4J0
 tt4QywW5mnEGlJmiI6Cy7kRnEMPHRCQMKXK5vKNshMLOr8WjJW+mOtBee0U4AAkE1NAWfSXTh
 sLHylac+B6xTIcCgl5BoD6mTb6wkO3aepgFx0w4oyPCgtS3/ikuMyIiOYiTsDA6x+VXH0VXUH
 4GhbVEFb7we3YucdIG9sX9E0GSXavBvuold1YA8GzLCUv+5GZ0o6auhosLGyTENbASytSx8Ka
 X226qLP4gbrOylXiZ9Zpk40GLw/1nT3+mD7F5KYF84DpAtJT+C0oErXH08ZfbRkrBq/cU/swp
 fcC6icx1JqLTgUbzLKWM6g37hk4HjJawLTfiVJoGBocKb/TdcxBIcg/NIeYFtLWLMhezOgRjA
 WVeOHwUgSQvBqAGuUYSz8dHQPRyRnGXJePm2AIqCQuUBPq3jLnyUYFZ55l6h41mlcuwaMwkAO
 uEGMVvA65cQQbvsZMVFccwYOXIQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the WMI driver core knows how many instances of a given
WMI object exist, but WMI drivers cannot access this information.
At the same time, some current and upcoming WMI drivers want to
have access to this information. Add wmi_instance_count() and
wmidev_instance_count() to allow WMI drivers to get the number of
WMI object instances.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 40 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h       |  2 ++
 include/linux/wmi.h        |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c226dd4163a1..7c1a904dec5f 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -263,6 +263,46 @@ int set_required_buffer_size(struct wmi_device *wdev,=
 u64 length)
 }
 EXPORT_SYMBOL_GPL(set_required_buffer_size);

+/**
+ * wmi_instance_count - Get number of WMI object instances
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
+ * @instance_count: variable to hold the instance count
+ *
+ * Get the number of WMI object instances.
+ *
+ * Returns: acpi_status signaling success or error.
+ */
+acpi_status wmi_instance_count(const char *guid_string, u8 *instance_coun=
t)
+{
+	struct wmi_block *wblock;
+	acpi_status status;
+
+	status =3D find_guid(guid_string, &wblock);
+	if (ACPI_FAILURE(status))
+		return status;
+
+	*instance_count =3D wmidev_instance_count(&wblock->dev);
+
+	return AE_OK;
+}
+EXPORT_SYMBOL_GPL(wmi_instance_count);
+
+/**
+ * wmidev_instance_count - Get number of WMI object instances
+ * @wdev: A wmi bus device from a driver
+ *
+ * Get the number of WMI object instances.
+ *
+ * Returns: Number of WMI object instances.
+ */
+u8 wmidev_instance_count(struct wmi_device *wdev)
+{
+	struct wmi_block *wblock =3D container_of(wdev, struct wmi_block, dev);
+
+	return wblock->gblock.instance_count;
+}
+EXPORT_SYMBOL_GPL(wmidev_instance_count);
+
 /**
  * wmi_evaluate_method - Evaluate a WMI method (deprecated)
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index efff750f326d..ab2a4b23e7a3 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -412,6 +412,8 @@ extern bool acpi_is_pnp_device(struct acpi_device *);

 typedef void (*wmi_notify_handler) (u32 value, void *context);

+acpi_status wmi_instance_count(const char *guid, u8 *instance_count);
+
 extern acpi_status wmi_evaluate_method(const char *guid, u8 instance,
 					u32 method_id,
 					const struct acpi_buffer *in,
diff --git a/include/linux/wmi.h b/include/linux/wmi.h
index c1a3bd4e4838..763bd382cf2d 100644
=2D-- a/include/linux/wmi.h
+++ b/include/linux/wmi.h
@@ -35,6 +35,8 @@ extern acpi_status wmidev_evaluate_method(struct wmi_dev=
ice *wdev,
 extern union acpi_object *wmidev_block_query(struct wmi_device *wdev,
 					     u8 instance);

+u8 wmidev_instance_count(struct wmi_device *wdev);
+
 extern int set_required_buffer_size(struct wmi_device *wdev, u64 length);

 /**
=2D-
2.30.2

