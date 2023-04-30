Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A756F2AA4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjD3Uc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjD3UcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:32:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89870E65;
        Sun, 30 Apr 2023 13:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682886721; i=w_armin@gmx.de;
        bh=EDo2jyGRTWwJyIb6T+IdrYD2Dz8qhCqNBIDZC2iaYVA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=U33PiAca2JeFTgN/u/vb5rZINcXOpDlaWODV6mwUxBp3Bghm46CUkJIzz549t68Zc
         2X4LxGE1841PwxFs7/Audbqa7Lre8/PQUQ6REiY5R92TgrqSV7rj6CQmV75BFh21k0
         6rXWpcPItLQF1mKwsM39WbVZgTZ+Gm/fbrylVPQzSaqFesUrQEHDINURcqWBrAlHEE
         c+FJPtf4PZICB7LnmnD+Wh9FvFkPZpgDUxnNpV5Hq0n2mP7hjp8TQuOIVFky3g/XQu
         xMEeMEJ13fb+3uu2BS4WVIAaYSRKA2njj3WaXYpjpUZd/Yw+89EJoRE+q7VSaqN6Vx
         X+HoyxqQBn29A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mr9Bu-1qdr0x0mnO-00oEk4; Sun, 30 Apr 2023 22:32:01 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     Mario.Limonciello@amd.com, prasanth.ksr@dell.com,
        jorgealtxwork@gmail.com, james@equiv.tech,
        Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: dell-sysman: Improve instance detection
Date:   Sun, 30 Apr 2023 22:31:53 +0200
Message-Id: <20230430203153.5587-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230430203153.5587-1-W_Armin@gmx.de>
References: <20230430203153.5587-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xDqp28RbQ9gdl4+mJCz5HykoBlx+oHBru64jsoI2K989qzfUX6u
 TVZuwVGgu8V9Gf/2OJFqfm2qenYVplNYJHsk99o/1JwE/ghBU+7YcaU66GkD426iwau1sVV
 xZJX425K1HlmbMlj8c0kmhWWYRC44ETCQ6XjlhR6olzCjgx9U2cOmYZkbUmx3FOrXE9sSzm
 hJ2LO4ypu0goV/vIzCjxA==
UI-OutboundReport: notjunk:1;M01:P0:flWVw255Rho=;ocnIOdG05yZ4JIgUC1FC1PPaiIi
 yDNshtyeph1fXo3vCfA1VO0BLLlsypYWdYgrYPlNUtR+x3kl1dIiU2zgCy3WFjJk2vBW355o7
 /lD4ZMrOIl/Tj9N5w538Un06g375fk89Wsi23i02zDCaJ02EdChe87OzSVPFr1ER9D4+bmgc1
 oUV3HTTSHTEuJwrmBKUCTyyZ7hmAtehRqOtLJG/1nE8OeqblpUdRiczM52utVK+GSgVkaeqMX
 Kyy52k+6sChGjldbztS2t80DYCfPrNbDzSAX9F6k5PaPWO3ThXQF3CRKZ2aAPm45oZRe78nfq
 2mriSfVm2RnkQrAo284DsBN7Q+BIu8swgPPqpBT2CDTk+0uQBrMS0ZqIuGJP42h3Mh4+hp5hb
 vR5BkdVVySZZh/C8g8JiEZRKhFK+K2xJkFqKeCCoBByKUx+GzJxZ940zkrhFuUWejepgj3VGI
 JNWEvM0bpDAneMfSWEAALmEwszjcOECUgC/7MjnnA3OSJ0HGhi+3gsZnIYYoi9Cde/TlDVNN9
 YxBPRCcBVXbONRIbuCxyyw0Mxknz+RR4P3JA2hvKblW0hR1nbiFmTy/aCO0i92nT1Kq0DN5K3
 8MPr2oQ72C3szHUf06bVFIfxDHP3xsogJSIQ3DvxfBvRXokwLNpMrWU5YJ7z2peWuohsuwhKK
 IuePyb3bAo1Ae2sT6dGiJlL7nawfoZ2Y3aMPpRJ8frjQDRWJfPk0LsJEytBmV8KKJvsXbQ3Fb
 ZqF31h/lpERyNzlBgbAq9gP511Iw0cw14+NBeT+k/cXqbZtrEsbw0cf6OWfbl91Lbf0+5A+z2
 zovcX9pO4pjxhaY8gkrA4HtcvhDF5gSis/F8BN28Y3GHPoGh0y/C+pjeibs0hfomBRSI1SE/6
 gFqENXFT5Atcp9u34n/duA0FlhEHoMV0N3XbqRE/bAR1zlC7fCgR2kMbygYNseaVuBgWJzQcO
 hF6HZp/uwoR+6jGLzgFnQsTt3MM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/=
platform/x86/dell/dell-wmi-sysman/sysman.c
index 0285b47d99d1..b68dd11cb892 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -303,16 +303,13 @@ union acpi_object *get_wmiobj_pointer(int instance_i=
d, const char *guid_string)
  */
 int get_instance_count(const char *guid_string)
 {
-	union acpi_object *wmi_obj =3D NULL;
-	int i =3D 0;
+	int ret;

-	do {
-		kfree(wmi_obj);
-		wmi_obj =3D get_wmiobj_pointer(i, guid_string);
-		i++;
-	} while (wmi_obj);
+	ret =3D wmi_instance_count(guid_string);
+	if (ret < 0)
+		return 0;

-	return (i-1);
+	return ret;
 }

 /**
=2D-
2.30.2

