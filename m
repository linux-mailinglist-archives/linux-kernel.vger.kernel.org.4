Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7FA69B9E1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBRLxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRLxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:53:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0147713D5F;
        Sat, 18 Feb 2023 03:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1676721204; i=w_armin@gmx.de;
        bh=/fmzoCaMhnWReJYZfoH3jC5r2/1L4ZtHhXop0SMK+UE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=AjnaHu7B/QYyUWn++aMX2z2PDtT2WQv0dRmm4KrGTRWpbYkdk0QCyX10FupKRt6mL
         J269UD2U5ug5T7Ma3WajNoCsQdTMaRokHFO/s1J/9HBkeJZ7eSpt7dw+4wnsYnq1Dq
         Inzzk9OreeokGPdY6nL9hjQ5Owmp9eqQPBzyrFKY11VkpycF4Qc00gpoECi2UdFACV
         P0c0Bevx1EatxFtTbG4RIkJxKC8KWg5B51O2tGr5KWpmGGx6z9W/CMY6TY5i6+mG2a
         G9yKLu/TAvGEp2bnSfd7ao0v7LEBNtxu++Y1ApYhxxiutzyhEq8lwdofzYJ3DjMNU7
         eWiXcVGLO4CzQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MTRMi-1p6H0x3WjU-00TiXJ; Sat, 18 Feb 2023 12:53:23 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] platform/x86: dell-ddv: Fix cache invalidation on resume
Date:   Sat, 18 Feb 2023 12:53:17 +0100
Message-Id: <20230218115318.20662-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:77WJU57lj8Qu0dhg8UbEVrImGjypha5gHmE/E8whmJk1OnA42YP
 hmBKmg+cvSG1eC+eRXw22V+3TXrYDpc0pHU12QmcR2Y8nzj/FQSuWor1zJycIyZZ3hIPBZr
 yatAY3kB+3b+/QJUyQ0dm7U5Vt+j+/2NPVPdJRFk7f7Kk7/sSkENLnUNzo/Dim7WB586+FG
 NBoVmaH4ygN5cbxVWgi4A==
UI-OutboundReport: notjunk:1;M01:P0:um7DH0aAbPI=;+ijOefp3GJ7g5xSDUG9+wwLyAPu
 r8ZVSN+Re8wvpGxBTwboOnm6d4ycJ50uHMOmCG4S97/skXJBzkE3MuB484L5roaSuKL7Kd+dB
 0rL2EgMBh3jafMnUH+rQqpQM/t0ZuUaVYrip7wEMnU0/4zIjFwDXn3goZ2IFOZwc398Fdw6Zj
 yc4JtYDWb/C8HUD1/sNdcehbMGTMn3Frt105sP+ha3WZDR77nxeNvgAYycLwWmIi+I0Blu6QM
 gp0i+itop1/1MifnfG9K5cm22o6ZRKu4JGOyZfFmtcaKdPvp5kYRsCoEQsuR2ObgebCai1dWU
 6/Cx7XEt4yI42SDHA+qy9b0i8HoAwyVYDDi1sQQYn2OWMjHLRNXeT9pJVdxWWElKsJS+REBR3
 DlRx9J1X0R7Ng1wycLSe5djG1oaocD8qTdg4/Rww3Ltf0RUJEt+/R9krJs+yRFxmJTpc2X97y
 gIRIC0QhW2uuv+eHr6ZlUK/OUUxWBB4Xf77x7Q0XGJPaAfOhywTN27zoE/BKOPDrpFFiZQoej
 rObsGtzNz8/nHgRIRuLBUdYqZeUrMB8saLfcjkxqF5wliauDuQ8DgQGAVbLTVlZk6zSzft9SP
 DY+nfXiXSuUgbzCF5ZV4ugYsdZdhy2kN/opOTW4JuwDQbsIIIdltPg+qgbKQq0v3o4qYh7VY7
 BHXial3maN2ogOF9Y3tfXIXEYFGNAD38srimI9xwcUEJSjO9kgxD8+uupOYroNuHWJmt4ODHH
 i7O+1WQHZxSLG+32kbh5XYhAW80PE52Ry7+kJdojwBjdzj4Wt+T9492KzeugxnRFuKPrXEGx5
 Q/Cjm7eqNmHu+3WQUt2gF/0oxFbu9B/bL2E2+T7nTeJnO3+bl5vakMXgbKSuwmywN0TVCIfge
 zRsA654Rl3YTCOQ2ne2QJKbvvCLdXw3S+0hKOdSH+YrILxg36GwLRtgWHVHLbzZhL4WVAfnh2
 07p/+FfC3A5okUWWcXgiVgp1n1w=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If one or both sensor buffers could not be initialized, either
due to missing hardware support or due to some error during probing,
the resume handler will encounter undefined behaviour when
attempting to lock buffers then protected by an uninitialized or
destroyed mutex.
Fix this by introducing a "active" flag which is set during probe,
and only invalidate buffers which where flaged as "active".

Tested on a Dell Inspiron 3505.

Fixes: 3b7eeff93d29 ("platform/x86: dell-ddv: Add hwmon support")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- move checking of the "active" flag inside
  dell_wmi_ddv_hwmon_cache_invalidate()
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index d547c9d09725..eff4e9649faf 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -96,6 +96,7 @@ struct combined_chip_info {
 };

 struct dell_wmi_ddv_sensors {
+	bool active;
 	struct mutex lock;	/* protect caching */
 	unsigned long timestamp;
 	union acpi_object *obj;
@@ -520,6 +521,9 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel=
_create(struct device *dev

 static void dell_wmi_ddv_hwmon_cache_invalidate(struct dell_wmi_ddv_senso=
rs *sensors)
 {
+	if (!sensors->active)
+		return;
+
 	mutex_lock(&sensors->lock);
 	kfree(sensors->obj);
 	sensors->obj =3D NULL;
@@ -530,6 +534,7 @@ static void dell_wmi_ddv_hwmon_cache_destroy(void *dat=
a)
 {
 	struct dell_wmi_ddv_sensors *sensors =3D data;

+	sensors->active =3D false;
 	mutex_destroy(&sensors->lock);
 	kfree(sensors->obj);
 }
@@ -549,6 +554,7 @@ static struct hwmon_channel_info *dell_wmi_ddv_channel=
_init(struct wmi_device *w
 		return ERR_PTR(ret);

 	mutex_init(&sensors->lock);
+	sensors->active =3D true;

 	ret =3D devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_hwmon_cache_de=
stroy, sensors);
 	if (ret < 0)
@@ -852,7 +858,7 @@ static int dell_wmi_ddv_resume(struct device *dev)
 {
 	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);

-	/* Force re-reading of all sensors */
+	/* Force re-reading of all active sensors */
 	dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
 	dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);

=2D-
2.30.2

