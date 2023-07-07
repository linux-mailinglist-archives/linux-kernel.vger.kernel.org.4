Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29774A853
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 03:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGGBEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 21:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGGBEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 21:04:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD5D172B;
        Thu,  6 Jul 2023 18:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688691815; x=1689296615; i=w_armin@gmx.de;
 bh=5882YwYHfG/JJxzZayJ8NZBGgsdnPI/wsZ7JwnWwUvo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=rKFY3UKreNqlHVa9m7ibtqNC4hZyCTYpmbcYEHkBBdgfcDuZvmV5pHSSYxMiLHqTvPcMzQq
 w050oaxBvvb431Qlba9cSX8TVc41l06we5Yl00QmSAEivuGBQLTfSflZ3FWbbfbxabhBc5e9d
 c2i6NE4zBUc2uAgu5qkYSzH8LRf6YiUKdOvLnlCLpl3IdAVVQDucKl7U8/Tr/iftiQWywuLsL
 0kijFXMPs1W0VFsOMgk+8UcvWuYi7tGormMLiFK20qS5QlQSVQf21rGKKX9Ch06OEdTgM6oUN
 kclJWM04Zf4O+vn1IE6LUKm/JVbYG/mC5Hy1qPESdKTWuKexBMjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N5G9n-1pppsg0TQb-0117WS; Fri, 07 Jul 2023 03:03:35 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: dell-ddv: Improve error handling
Date:   Fri,  7 Jul 2023 03:03:32 +0200
Message-Id: <20230707010333.12954-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GciWBDV2OMvqV9LClnMebCWS3o42rBZCi9eifhwPnqwUFyXawaR
 jVsJB9Owq9G0gj0A6o9TerEqF4bMYPC/XIuXXxpgA2ki+XA37WBrK/VwV23RODWXrj4gLbC
 73PQZW+8CusSo5Y1NZidx4XwTZ1F/dFNXHn6S12d+sXYT9D8dlvdtHliw3HDqgsJhdnnFDK
 Y2YHtk5VwIdg/2L0jEcQQ==
UI-OutboundReport: notjunk:1;M01:P0:rL4xnUL/AgA=;5oAYG5vEAbGqd6twCiNcj2IXbhu
 wBCWN7evla+ZTLJW/l+5ws3RvsHvJ8TVv68aoyPWU3WS/aLEzej7WKmy7x0Aw3zG0TxO8ajI/
 n/K/Nl85g8oslZkmW4uwTXyJK7+nSstwHMSAOZg4GxjtiT/tbPFvZZhSRI2ikYtuni8Wqp8s0
 JgFrkWugiHgKifjyGQgZ3hyHIMK5s7II6+1hlkRoJw3kjBGwgFxvUHqFkW1FtfXjYGRh+0JGw
 7fXI1lWonziK08fggqf5LCj6R2zkwXGUzX0rePZ0H4SSclA2V8kYeuhOvJw4ef+MjPI/N6jSY
 yiPKVDEzgoNtTqJJsgHgPFUQHREsnunziosgdIDdf7nj1sex1Xg0u0MoLxUFgJVOdg03TPy3d
 FbKip5j/F8qVwdFWUOgSEY3haTtvJoxycEXRA9Rvma1QpgI2hsvfgpKuUNuYbFUmTPvN9eiFN
 DDwR8ItD4lK6qZdcFHc71y2OJq4rIt1H29lmxQssy9zaEOAh2wgcgjzz/yQyCDnGJ11M22oPy
 JVOwy3C35ye9SOkNPL+Dv0mxokEmxrMwoNX1/zqrJNvVsoS/l2j0ybDpvcbu0sI/4ln1r+KxT
 gmcGQiLO1nQ/0C9dnoemPnPDZYVjZ4ZTbGGANIyCiRI3SIIyafmmKs4XoRQuJsHn6Ms5WGHfu
 Dd5FS7DV7q/kCWuG4CmIJEUda9Fj/b6BKDDAcXO21BKxnhqA/It+HCAiZQrdTiOjecqI0jcQy
 oIn75cwnSTYvwjBuquKuNO7qZAx7OHKwBcYSVocF3NR8mWUeGvoTzR6plo4e/g+ybXxuSAKQL
 iMxizB4pD5Jf4qBCk5esdiBEVb8ZHe6Who1Nf7/ER2S8bC36MbAFqrVL1vxOnVK8C3LbRS4r9
 ZyKWUejeW2rNHJOeyiimmazXViEE+IF12E/hEhDbBhkkOGNxRlpo7NBOb7shjjBr0JDap/JNQ
 DABP8/wyoW4qFg5VFrgPA7s1aBU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If for some reason a external function returns -ENODEV,
no error message is being displayed because the driver
assumes that -ENODEV can only be returned internally if
no sensors, etc where found.
Fix this by explicitly returning 0 in such a case since
missing hardware is no error. Also remove the now obsolete
check for -ENODEV.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 2750dee99c3e..db1e9240dd02 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -616,7 +616,8 @@ static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_=
data *data)
 	}

 	if (index < 2) {
-		ret =3D -ENODEV;
+		/* Finding no available sensors is not an error */
+		ret =3D 0;

 		goto err_release;
 	}
@@ -841,13 +842,13 @@ static int dell_wmi_ddv_probe(struct wmi_device *wde=
v, const void *context)

 	if (IS_REACHABLE(CONFIG_ACPI_BATTERY)) {
 		ret =3D dell_wmi_ddv_battery_add(data);
-		if (ret < 0 && ret !=3D -ENODEV)
+		if (ret < 0)
 			dev_warn(&wdev->dev, "Unable to register ACPI battery hook: %d\n", ret=
);
 	}

 	if (IS_REACHABLE(CONFIG_HWMON)) {
 		ret =3D dell_wmi_ddv_hwmon_add(data);
-		if (ret < 0 && ret !=3D -ENODEV)
+		if (ret < 0)
 			dev_warn(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
 	}

=2D-
2.30.2

