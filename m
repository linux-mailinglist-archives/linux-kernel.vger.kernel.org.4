Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D234A6EFC7B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbjDZV3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbjDZV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:29:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5243ABD;
        Wed, 26 Apr 2023 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682544539; i=w_armin@gmx.de;
        bh=w0oARY4CbAc6zKzf6JtPUqR+03JXON4Kw0RqkAkLgZI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=d9hJlwlLij5eF36umbIBVFK1ufeo6ydGXvSRfiW9vjLWfbFReHH0jCwDhoQwwDvGK
         pMBytG46itblNlVvH3+58y5xaM0MHrGYva3Qu3ZSxxMielMa0A9nNYiChTwDWaOiNY
         tNn5+TpVEhayv8D4AhC06Ibjsctg6InLVrTrqrhVb4vji8nHV0f4HoaypXuVSBsGj/
         bh6RruEPeGaGqNPPBLUJN5jXQRcNjwf0xYMnn4VZFtwht08nN2HvWV0cGBlEMcwC9b
         RNas4EDYqupdX6DL234VQt/f/TD5HNAP9UCzEtBi9ORaIJ0C/8jhADFsR7n0/ZDGLz
         M40As4pDXb1rA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MDywu-1q1iKV2b6i-009ybF; Wed, 26 Apr 2023 23:28:59 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 2/2] platform/x86: dell-sysman: Improve instance detection
Date:   Wed, 26 Apr 2023 23:28:48 +0200
Message-Id: <20230426212848.108562-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230426212848.108562-1-W_Armin@gmx.de>
References: <20230426212848.108562-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4q9pu12CWhdJrKzj8Vw67SJGG5tca+ZIz+j1qkuxE64mtysyVX5
 5Z+eFZJwSU2ykCfhbkR4+fj+vzfNeG2UHZT8hboT90E3kDFbP7vF3o5RhpRm8ynzk2ZEJwz
 tXmtS+iGXLu3jymruvti4OD6zrLWjMtH3ex+FocJVgkSO4QqQSZr02+h2TVb9TOi69afEWG
 SANl1F3i5rCjktmF6Wx5Q==
UI-OutboundReport: notjunk:1;M01:P0:4WrzT+kCZLc=;Zm4Bc+b3jJ7UNVRFioct9plRVwW
 AYTxMsls5fv6z3TZtoXb1KxsT2tNgbfmomBM1/URerzpJyeXakKPIp/CSaVPv73Lhk/qQyhlK
 sCwa4PZSCgXcIG0RNRjUyEotzMmSMiCcIoA8xGK1x6ohO98iTZdPLECA4PCx8vDVjC2esxFuC
 RHmpyslZ1dzPNAt792vZNFoj6veo6rBjXHNuPCnMON5tSqbjIh5yi+rgHObZqZsB249WzCmSN
 SWbidxPpCrUTcI/MdEIShmm48HZ3VGyx0ZxGh/yT6sbwoRUn/OK/OF8bWbVay4KIAkrTz8GsU
 V/TBRzNYUyjN9NGIImdWJ2kPi5rZ8QjZi/lTuPpC/I1g1ZJmxSrvek0FySXQC5WeUQXqjFi1G
 ZZr1MU3e0YPnQBxVRhAukhQ1seDytMLmFfZ/sXZreH6B3ivnwS+LCCN7ryqmo0bigZ7OL1tMo
 4eCn/N7icV3StPkbRcWyiW7DLuOmqP3hf4znkXA2v/ibskZU0WictMtQEb3jd5nKln9yUQkkd
 1vb0oN7ZWUFcKW8NMPvp+gMa6SC79tH/oaKtVsO5TtyClhtfTbWPKS5AkKt2eAfwOlHqFu08k
 KFUOcuuNWg6PewDfvOgNvsvJssK/QI0juLQIjU5DC9+WzU2fub0nVy9pjxGxxoOpDBA7a5Rxc
 /aLAWgdkRvcFmcbnPFCGVqx6bOh171Tmx5Nxkn5lLP7m0GcQ6wfi2mxMg8//9xz9mAg3OpX/l
 shAqeuxnso7LUW3Z9zbQrR6V0zxButViQBawlDjDJ8IyLFByNdAfDRWeudHEiTQui0FFgn/Dl
 CundCw+74NpR0eGOeuMSzlrPOYEGGDmD62Fn+au3gGslRMkilDNKhxdgoi2TWbXd4oNb1xbXC
 eyr3OecMk2ciGFRvi0P0t7W/4wUf2Sx0wPIDP/Zb2lJYyr+MpmDzwRXhKzoJfoOFqwpaILheP
 +m/pOPgVkBLzOoCiu6QA2PF5ueM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI driver core already knows how many WMI object instances
are available, use this information instead of probing the WMI object
manually.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 .../platform/x86/dell/dell-wmi-sysman/sysman.c    | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/=
platform/x86/dell/dell-wmi-sysman/sysman.c
index 0285b47d99d1..526d60b510bb 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -7,6 +7,7 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/acpi.h>
 #include <linux/fs.h>
 #include <linux/dmi.h>
 #include <linux/module.h>
@@ -303,16 +304,14 @@ union acpi_object *get_wmiobj_pointer(int instance_i=
d, const char *guid_string)
  */
 int get_instance_count(const char *guid_string)
 {
-	union acpi_object *wmi_obj =3D NULL;
-	int i =3D 0;
+	acpi_status status;
+	u8 instance_count;

-	do {
-		kfree(wmi_obj);
-		wmi_obj =3D get_wmiobj_pointer(i, guid_string);
-		i++;
-	} while (wmi_obj);
+	status =3D wmi_instance_count(guid_string, &instance_count);
+	if (ACPI_FAILURE(status))
+		return 0;

-	return (i-1);
+	return instance_count;
 }

 /**
=2D-
2.30.2

