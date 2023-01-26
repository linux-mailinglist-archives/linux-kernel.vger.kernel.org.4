Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83E667D589
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjAZTlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjAZTk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:40:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E919F1E;
        Thu, 26 Jan 2023 11:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674762035; bh=YdjYt1hNkKObM0Ir4G1v9+RZ9f+OGA4OgCN1VC6gvV4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T+IFB2FfvYzRv1fKEdc+2ZsV0LecOaCxwY9keMu6+w7IIVXVGx9FooWbHWVSdJI5h
         we2PK8ssigdZFlaAHx7Q4+co1UK/jtGZ3ieMPVRVH/crbjreAIUscuuHnlX3mYvBvO
         b+8RcQ4p6dBKxwCO+BJUJI71oU/DocJ4y3ys5T8Rxu3CXUdUNOkFLxPhSuqPJUmTBi
         OnepSDmGXFzm2wnHjOwKHNm+tjsVXDpgpLZiTbd9CfW5T/Q02ERYT+1O+b1FAPnDwv
         uIehPxxlYb/cS/zsxk4maeUlbkk8zFNpcFg1kpOcgERJdrvu+5+isXh216+kMxZkfc
         w+U0Hvuo0fKSA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MC34X-1pXXdX3JOf-00CRnZ; Thu, 26 Jan 2023 20:40:34 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] platform/x86: dell-ddv: Add "force" module param
Date:   Thu, 26 Jan 2023 20:40:20 +0100
Message-Id: <20230126194021.381092-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126194021.381092-1-W_Armin@gmx.de>
References: <20230126194021.381092-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eTK8nJcBuZ63uhcSzfBS3cLU0NjgY3Wzp9l/NVLM+qvDcz6m6cy
 hAlUJtWguiDTODwnm8chbdA/U/C6LjGjo43zVjIRJgZqYb7Lltq33+WkK6cdomutWm+B8xO
 kieIGn/fM8ifOptJ6hj7GigmqpCv0UOMhw2l0dVnLIYlbaN/kklNE0YzjeqvDbutm/f96EN
 P2cRoGD121AUyZzLgSsfw==
UI-OutboundReport: notjunk:1;M01:P0:CcRpqVwyz7k=;85JdvKVLhlzdNJsKc8PI5Nx6fu6
 eOz9QjCbZ07+cAx67ZtpHq5M+givHKU1mMeo/DoBIC9v94QFvgJrs+5tuuyvlSGlBm+G5ax5b
 J/Rvq1EYOcD/j1S/Xdsm95htf+4vTetPv1eJnwbAzWvD4WT469JGXA7HRTlYC6Of/ylDOAXEa
 cDKt2RVVOpmC9QsmF3+oKnOUm+g2sYHtDE+BEWM8uzVstSu7bY/qxcZjfhNAIlHz8gbSXS0IW
 kTO0hVA+0LUzYcDz3QMbfF+nIX+NxC5Y2v3TVgIMeOYrpITmAt2t0VDeuBGP6GjSv5cNQUHrV
 8ebL0oIRoNhnw4cwkLCBJtXjv5vpbmtCMBhMB4MRQ3zXrLETu8qHTC4EvwOPt5841iSNhsOqD
 bT66RYXtsmsH9XhCRp+hDQ5sJ+3KLaBUotfpOVg2Q4t62wlZQMAFwr33EO+sOHM8LCPKPS8uB
 AQ9MfcU8E1BKeHeM9t0oyW9pCW+KD5Zrkfmk9cghu9EPI2nSEqohx2MX/E+vBmX6P/vS/Ajse
 Z1jI0K6aMlP3g6l176uBowwkOH2T0HSooUYs9Nd/KcdnQXZw/v1ZWLh+zDu48SZ06Mqx+sPDq
 4B7jNOKaQgyO7L5oTS/R5SNVtVD2mL94w5a6bkzTxOA6LROXUmhhPy2jCCFSup7oJBJLbuF5q
 G4bbQF77LfB7IR+yL/oFNrAjnbjPlKtZ/Iez0oPHEUwmsNf44LEl8NNaYjX9NzTvq1sYH6lyo
 sY+o75JkrHGblZeu3IqLrhKdt0cEgdy6ybnCvcuF1Y4Bbt1gZ03fp96BuNW27vL10FAEM03lo
 TP+BXJE4sZJfhex5J/Iu0kqScrrPxdfd3Buo4pDI9lNGzbckCwk8cXcSBuaWhTJn0E7Q7oJa+
 d8P5jZTCnas7kjjMH2dmwFOogkAlwJV+bpAOCuEVWbIESPIVKNQyYB5lwvaH7NVmAcblrg5DK
 D5JYR4lXNjZuNAoD8udJcR3U6kk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, the dell-wmi-ddv driver needs to be manually
patched and compiled to test compatibility with unknown
DDV WMI interface versions.
Add a module param to allow users to force loading even
when a unknown interface version was detected. Since this
might cause various unwanted side effects, the module param
is marked as unsafe.
Also update kernel-parameters.txt.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 drivers/platform/x86/dell/dell-wmi-ddv.c        | 13 +++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentati=
on/admin-guide/kernel-parameters.txt
index 6cfa6e3996cf..9bbff5113427 100644
=2D-- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1024,6 +1024,9 @@
 	dell_smm_hwmon.fan_max=3D
 			[HW] Maximum configurable fan speed.

+	dell_wmi_ddv.force=3D
+			[HW] Do not check for supported WMI interface versions.
+
 	dfltcc=3D		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 58fadb74e86a..9695bf493ea6 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -34,6 +34,10 @@
 #define DELL_EPPID_LENGTH	20
 #define DELL_EPPID_EXT_LENGTH	23

+static bool force;
+module_param_unsafe(force, bool, 0);
+MODULE_PARM_DESC(force, "Force loading without checking for supported WMI=
 interface versions");
+
 enum dell_ddv_method {
 	DELL_DDV_BATTERY_DESIGN_CAPACITY	=3D 0x01,
 	DELL_DDV_BATTERY_FULL_CHARGE_CAPACITY	=3D 0x02,
@@ -349,8 +353,13 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev=
, const void *context)
 		return ret;

 	dev_dbg(&wdev->dev, "WMI interface version: %d\n", version);
-	if (version < DELL_DDV_SUPPORTED_VERSION_MIN || version > DELL_DDV_SUPPO=
RTED_VERSION_MAX)
-		return -ENODEV;
+	if (version < DELL_DDV_SUPPORTED_VERSION_MIN || version > DELL_DDV_SUPPO=
RTED_VERSION_MAX) {
+		if (!force)
+			return -ENODEV;
+
+		dev_warn(&wdev->dev, "Loading despite unsupported WMI interface version=
 (%u)\n",
+			 version);
+	}

 	data =3D devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
=2D-
2.30.2

