Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DCE6EFC1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239971AbjDZVEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239869AbjDZVEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:04:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC392118;
        Wed, 26 Apr 2023 14:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682543036; i=w_armin@gmx.de;
        bh=/NvD9oCO/r0GrFnR01vAe+1hQd5sbYS115i1sHjdYVU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bTmI/9f4BZxjfDmLTJ2FL8gFdxZuVkBIZZa/2ZDoZZA2z6A0dUzRKxVWoF+Ui7ZjN
         LlqBT8AOiCR7D4PO063jKlFa0cU+QDvTqnnenTsfwLXxIZvg8WryAW9UjUJOccIhpw
         YocFZfXBqakl7OIEklDOyFvudY1omh0lnYRFNeqiHKbo+1mKOIPlIWSR1et7FlRkTP
         7MvwPW0Gd7Q+d02g5n8YGHU0dZJ1rAElWStcYkqWPS64nkP2dHCaYk52LMkIsPXUMr
         ZxJfyyUlwgP0ygMkdUyEWTMfV5crilMOXxk/wHl004Zs+5IQi+nVHmTrw/MIvLvYUb
         faZ8SoQJ9O/uA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MZTqW-1pp7Xx43Ms-00WUCY; Wed, 26 Apr 2023 23:03:56 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] platform/x86: wmi: Allow retrieving the number of WMI object instances
Date:   Wed, 26 Apr 2023 23:03:49 +0200
Message-Id: <20230426210349.100838-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cLFnNxImVvmhI5yLyiv2KbsyIDd1PiGN5UijaXwnLIS1WQPRbYb
 vpphjWlTXSvktpdJ3MBk1e7r7uqeAWBDga00p/g8a/B9z7qdjewEUer2Av6ET8MNKEDtPox
 My4RD8lgVOvqITog/25dDbVp4o+E89MDfoBHcU3SuQAaioiUAMh0/JOkjdDdmH87iDVDaIF
 TQLo5o826ty7Hs5nGKLeg==
UI-OutboundReport: notjunk:1;M01:P0:jdhdDSfD7jc=;lk6ccJ3vHPmJIKqakPPBVcjwzXB
 NwxtyT9RpJeww2CJ2PRBrM59yFqSGIbuHxYPrr684pl02/QSHQsWeVD68MS62qbQ+8uU2gITi
 PLzycBXN14D9bZNUDlsKpzs9LycbFbepqT0EhnaA+cx0EV2V6jYMDPDnJ1fSWUeRfQ4TXVk7/
 kIQx8OLi3OgfI2mmQ5vsjyBoZghhZav0DcV1s2wXRqhJaOReerzXhNExuQMGiPrilufThzO8W
 nLNYJzZY7sDnR677oHoHThzNnFuPu+r2gWaK7z9//xGNPgMhGUQv5F26bNnJv1k2uv12colem
 BIzco0KWcbVsTtC36p7Up2AQyuPC59sXaAcBKrxUdjjnuNhEYQ7Ob4giWxHprcDdT2kDWKdNk
 X7tCfeI14fPCjtjlaZk0NIPD0asGJpeMX3hTllJ06beIhGQq7Ug+lcVEtaEDo0u+jJktbDusV
 IjGoC7FKo/F2tftJ1naW+OxQeUS2Ysa24pHmDo+AoG2yx2HcfC99DMo0WP4+gb4LNKKGn2yK3
 PufUo+JaJ2ensow+J/xhWDGB1IIwt4rIAiuu2wr8+stm8Xog753nVfca/I2pZsXEqdRs1QeI8
 /+vReBpMSqMPz9QfHVcCZBMkCMw2VwHB1V6fBkwCg9VrtxPjhRwAPEwL57i1ExyrRXuboAlPh
 JMNff5oD2GFMONRJ/IaZhEbOVyWGFw+8N32ik+9isYy4bmsY5A1nb8nzIWXaEcT08q0Emo0bc
 EMG8L40oK71AfuxBbiFALpuq5yDxM+n3QdJarSVsknrzA2YbHnAizI3tvCqoo4uEaEwL+Mrij
 PI/dDEe1VInst5aM3I2xQkByx9N0JJMAjO1bgIQa/pDLhwumBFQN/K3jnfa++P6fdqsvMQzxK
 lZLHEVf6XNr7hRmzyqcrB/nC3Viut6B3keq+LU8SZkicyPC59Th70r/r9wnuF06l5Fe+C/khj
 DQp7dizspiuacNiygViux0zcYtI=
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

