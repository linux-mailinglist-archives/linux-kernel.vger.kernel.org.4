Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65556F2AA2
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjD3UcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjD3UcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:32:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE38E66;
        Sun, 30 Apr 2023 13:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682886718; i=w_armin@gmx.de;
        bh=l+0GCKeRezQc9Ws6Rvy4yCiDFaJROwJiUsltiicCshI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ot5VIA3e51ahXhG/JA7GtZHVBY4qL03lZjHt2kUKH8LOYHMGVuJXZnt7FYVhQ8cA9
         HGPxPxv+l5VcptOBp7j/jM3zP1Cs6RMyefD9cqEEQ8NqOmdcS/ZxiS3Di0EMbJScIj
         GXDnJ+BCMRcn83JMBgy1tZ2ZWVUpmf5oG+Na7DkdUo48wcSOGST6DLYjaCGbk2ZAeO
         0yFGc6fv7CpJUb89K49mH4jm7TUQmBgJcfA87zKTLYP6DK2XslI5wcNTsGgnsV54/d
         kPl9y0unZO1hy5pmoj5CAdBHnwkiw9nGJfbW1eIVrMRpfXW6NhRO2mAa+C0Vzyg11H
         O5IKua3mbo/oQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MK3Rs-1pXia02pZO-00LSM3; Sun, 30 Apr 2023 22:31:58 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: wmi: Allow retrieving the number of WMI object instances
Date:   Sun, 30 Apr 2023 22:31:52 +0200
Message-Id: <20230430203153.5587-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230430203153.5587-1-W_Armin@gmx.de>
References: <20230430203153.5587-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AwcIKrVVrreL86dR0hx2hTjHbeTrBLyyjSg2gzhh4/7Vo+rpogQ
 JyRxm+Bq/vfXVZy2ljyT2FKofSxdFZnct1XtTgmCcgs7YAgCzcKM5C7jJe/n4LEbha79YwG
 79wOUIhC1BiMTizVZyTkmFHt9WZ0Eo/jVOFOLamwQ71SM2vsTU1V3GZN7xq9YKwXeZm+Ugn
 oD7xoB0/gCmjS5fPPsZmQ==
UI-OutboundReport: notjunk:1;M01:P0:/l2yjb/EBL4=;qJ0RQ6tlfkJXHORn0kU6joV4cSa
 QSNT1CbNDCZOnlgSoeffOg+Vu3ZChits8cV8YuDryTclZfqVoT2VMN32Pt7c6vK3a1FJ604PY
 W7b6YNTCUWB6rOAThK1LNkQYvxZBWfLZkAR9Xg3ReVbwYISBUSswk5OEsK+j5LCHLL71aE2/s
 NQMF22OtP96xQ9YEBA8ylSM/ZUGISGWW0Eu/q9UDOeSQKuXrAQDUE8h6GsDFfrbgfarSqGAXc
 7tavvI0n0IUxFY4XBNE+fBV4K/Hcf/+MA0e6Ew40oZKheuDyBy2CPA2/MLYrRhsqZqTvRT3nI
 H3ik6sifOkZmv6P5S6sFhIlqWNUqg3EIB+m7lXWb0iWnHBDC1U7z+WOgm6VDLDHQvOaqgnXLU
 7RxuUMboJ55X0BKqZU9aMtDanQU+dTwg41yAMfH4JOglAxZ35QwLil2gjTkQ12BpAaDvcxnDw
 QaHcKP4p1M9Zzjzdi5id38Kt8C+HeZiWCpvVSrDhMgpKLoiMJnvne/FVoWmHl7SB9/9WKTwRK
 kKhm82mG5/2R+q9fN7Ib548sB0cFR5Rp0r4Lf3owBxUlY0nlwN5PwJLAQybsDQOXY1CrUGj6E
 pIOt7QOwOOiw97nfm7ka2l8N99MUA3smOMBTWk/KQgKbaVssSYflC/HwX4aF0TH987fYAN4Sh
 g5gQ95qcchD0Uz74HlH0akY4GAERlPMQID0L6kW7VNTeabQuUbnvQNWDvwoKdlICAZyqFskAo
 KLl3dB6mgvIGAWfmpra70oUomyRnVadk+1lzWUoHBkx9t2vk1QVaSOAgZcqPPVlJyaaqIN1as
 FVspd9wduL842uQd1zrISx3hTOlv9pGtj/Fgh4IrmvjG0/HfN0sFH/8QCX814E+kgub79rDjZ
 swHNnBzkeGABk2S0DVYC1JbEHH7HWAHr3NS+xHrzn26E/Ph+iNDFdAwFG3jBmQ7e8M82syGy4
 hDwy9LcYmSA2BKTjOgnP0/vtsSg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/platform/x86/wmi.c | 41 ++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h       |  2 ++
 include/linux/wmi.h        |  2 ++
 3 files changed, 45 insertions(+)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c226dd4163a1..5b95d7aa5c2f 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -263,6 +263,47 @@ int set_required_buffer_size(struct wmi_device *wdev,=
 u64 length)
 }
 EXPORT_SYMBOL_GPL(set_required_buffer_size);

+/**
+ * wmi_instance_count - Get number of WMI object instances
+ * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
+ *
+ * Get the number of WMI object instances.
+ *
+ * Returns: Number of WMI object instances or negative error code.
+ */
+int wmi_instance_count(const char *guid_string)
+{
+	struct wmi_block *wblock;
+	acpi_status status;
+
+	status =3D find_guid(guid_string, &wblock);
+	if (ACPI_FAILURE(status)) {
+		if (status =3D=3D AE_BAD_PARAMETER)
+			return -EINVAL;
+
+		return -ENODEV;
+	}
+
+	return wmidev_instance_count(&wblock->dev);
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
index efff750f326d..e52bf2742eaf 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -412,6 +412,8 @@ extern bool acpi_is_pnp_device(struct acpi_device *);

 typedef void (*wmi_notify_handler) (u32 value, void *context);

+int wmi_instance_count(const char *guid);
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

