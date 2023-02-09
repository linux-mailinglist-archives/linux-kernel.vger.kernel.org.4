Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD214691286
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 22:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjBIVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 16:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjBIVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 16:15:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A55777E;
        Thu,  9 Feb 2023 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675977320; bh=Uh5RIMNU60mWcaditU9sALzJk63hb5rbJhhp4Sndz7E=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=My54Ye3S6lZwzlGKqHvfN78JsrV4+iDjsgNaxF1PVUhBQYfrMIbIgGFU1FJv3wXJ7
         x6HRcf9hwNh+00X+fihbB/RPyIz9yT/WWoRRtdunfHIL4EISpI1eMszk0vvJi3hvl4
         GyJHPHaLVWlBjo6qQ3OkAJOoz/4ZdscZxssRBrHYj3KhWh7dI7ACawkqMMdI7LsO1M
         5oAcybRRCkMjV+js7wlf79egJaLcVjyJQa8QnDlBlvYBzQT4n0KXInbqaUp2Kll5ir
         ZvxaT7WGZuoBV9qD1JGIbTNcoKtz0QLUvtqNlc5qDh2D1cdCurcBsXurkvHTIQc9gC
         RlQzsH16HWcJA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N33Ed-1oRVSU3L2r-013Jgd; Thu, 09 Feb 2023 22:15:19 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] platform/x86: dell-ddv: Prefer asynchronous probing
Date:   Thu,  9 Feb 2023 22:15:03 +0100
Message-Id: <20230209211503.2739-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230209211503.2739-1-W_Armin@gmx.de>
References: <20230209211503.2739-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qL+iwF8GTblNMRbnwYaDj8zDBobMGfK0qdsc8QVEoGD1dpKlD/7
 C9Cxxr6EcEOSC0+1AfXpvxMWrxi5AelnMkHjL+V7T5GUR6ZA3U+oCWD195j5rN8b5AWgefq
 Qcp5OtfYtwVE0bo4bk3yW1VfFjYr3q4SbifAwJoZM1FwRoSKeYgkmejNBvNFy0jjLvl0vRD
 NWmQmad6kxs1jtEd+2YWw==
UI-OutboundReport: notjunk:1;M01:P0:532347kHmx0=;oOKJTev7VB7Bp+Mx+ZTQm9Dv7KQ
 JgECFeY2jvPJP8C9VtI0KORLF++WKcxki8UyJwZmAP5Wvc0KqixYUh0x0w1BOAToMeB6LHZsj
 auHp7SLNmg9nyPLwXvhphgZziz0AoeqioSvC3jIYqCHv+HwvBUcbPES1q5uUW0j6Fs0Fs05qK
 itb7mAkgfLaKy4k7MtqEMl4f+335MUajgDjJ8A4gC5crx33aRsAQrYCp3tEKryS6s5sM0LCha
 ivmzsjVGgDKfh/ADprko44sswwx7fAL3UwXMh0PSDpyxv00Mafgr+ricOlCp3GMvMKVr1egB1
 +tJtjUiypOv/wEWVvhGS61JqZHLwNMfQXA9ObyzYdr7dfncgn4PZx/dbo1+AJ+m3DQfXxMTtp
 cvd4tRqhPsnbSoThqiSC5O4s+2ugcRFPM4KK9cY81IzANTkO436cgjYkKEliPOBP5t/t8R6It
 hvaoq+PkxuY/f+v/2JIxFZ14pi5918LiyfnVu7THZfRC7irnL2pJjoLMu3N3B1ifljOj0UhjO
 BgNASR8WaLgyWLEGSwrL0CfDYj7YEuxbsJkIm78Em42mVtkkiCs6O4MT5yKmiK5DdHEDNs90G
 7Irst69/9B2uFpCM7isMMqXdOIjl5Vl+4z1diB490LWfBrgBuOEWOLpXUIZBXpSs3NmXWVoIH
 awc+SzuaNNq6us9SlKA2XZ7F76VtJhAV14SEzS/bCpAHf/n5yz/wEbybzuZ5FkLjWtDzyXiQs
 9F7webXNJNdzYDi15KS7WOm4RuhpfPpr91au9nvWYAlnXJGfiEWUvKrVhc1ussJIeCSiNtQ7z
 U8mlFp/8ZMQ31ZoAZ255Wo3zMXb7e8ORNkFakF77MdcSeSd2U2XinYJ06SApiNQ/KXLwTg5AG
 QEZ6L8shuJJP4I6NHoMuMcgxuXn+HJ193xoO6PB6sYSUxpZGdlz5hjwbuoHsmNRKNqoufDZ4B
 WBwiXBehlCuNOhYFO0KRkIlSumA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During probe, both sensor buffers need to be queried to
initialize the hwmon channels. This might be slow on some
machines, causing a unnecessary delay during boot.
Mark the driver with PROBE_PREFER_ASYNCHRONOUS so that it
can be probed asynchronously.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index d81dc4dd93e3..d547c9d09725 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
+#include <linux/device/driver.h>
 #include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/kconfig.h>
@@ -869,6 +870,7 @@ MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
 static struct wmi_driver dell_wmi_ddv_driver =3D {
 	.driver =3D {
 		.name =3D DRIVER_NAME,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 		.pm =3D pm_sleep_ptr(&dell_wmi_ddv_dev_pm_ops),
 	},
 	.id_table =3D dell_wmi_ddv_id_table,
=2D-
2.30.2

