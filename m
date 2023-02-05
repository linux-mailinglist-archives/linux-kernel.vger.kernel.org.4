Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04D68B1B9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 21:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBEUzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 15:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEUza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 15:55:30 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A241A977;
        Sun,  5 Feb 2023 12:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1675630507; bh=/T9/qsH+wQ6sC2+if7MuLmWQRgJz/xhs+XDj6+bYSB0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aRyZPOufPLa7cUz5uQeygdoBIHQ8xiVi3MUmImMf3OUMGDZNZOAS+Hlfhq6nlteu7
         5O+vZy25DClU4kwjvnslxfIGpu2BX5Upxg9/+h1wJ0EznbHMC+EGyUYxE+K1eOpUI0
         aDcqKDHTwIX3+2n5wyUchDe0mCo4sYQ6wyCf2Eo1RjG1y8tqkZh0kMEOSRxQcmz57F
         WmEl0o6B+VvAJVJrOYz0YEs/nLADCgOCQJgIbNANrOKD7ePdyxk0lFwfoAlqoMnXiP
         4S+aFkm9bRrBkmPv/v0OCkr1pepkg+qtW5H9Z/F/z750mDsS3moKzY+N9lu4nm4V+O
         2EIdDESf7tkGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MZTmY-1p4VMS3kSE-00WSvv; Sun, 05 Feb 2023 21:55:06 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: dell-ddv: Prefer asynchronous probing
Date:   Sun,  5 Feb 2023 21:54:56 +0100
Message-Id: <20230205205456.2364-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230205205456.2364-1-W_Armin@gmx.de>
References: <20230205205456.2364-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NVV20JzFLnxYL1XOdNp19JGeQIG7PnYj7KJj/lUvzlx/krCzBAI
 FOODJLa6AkxfI3w2+F5x9Vj64HI4iLYyspWnbg2Pd3hUW/Jlh+fzpXQ6FwR6IpRRbEkB8nW
 3mRAyNb48J0tTHbBun13eEvOuXXXnVlZd/FwktjBDBoemWh8eVtTbBooob5IyRspdRlR9wW
 f/bF6H/SeEP3Mmw2X+hdQ==
UI-OutboundReport: notjunk:1;M01:P0:+9KlAknJDkU=;JmXkShS+x/Qr8jacRo3HI86YRWe
 YDRtXsYWZIW6O/T1vqGqw0ExDv03dwKsi84ny1zuJIKUjnhTdIVFsHRQKe8Dct04TEA+azqjH
 oZTaKq1oecLh0hZHt9jO/K6a6I53MtMUqaSsyrbPuk1SshBKvvv4sp9dQvBCZol3tI5o6MvA7
 gKNU50xqf0I+afu04vEDFOHGMBmycf9/PkVeUGP1YOtWex/ezNwJgAqgg4aLseudxGhWb/Gw+
 QnPUeF2M6h4nXoOFbRftBgIfzTgWmOxmSJ5qV4uaBNT8j+IStdhLNV4C6SdNy6I007i71K1QC
 WW8GWnexFwMDJrv8ljlIkSVAHlgA1feTdy1G3zUo3avsjrhWNAlk1rlwg+qsgHyNMuJYF2ALt
 qZVtbqj5Z0jT0ltaHPTmHL985qiPaSKJW2wenhGPpZuAcIZfHV6YK9HPNL1netYlQSUEJE25V
 bOpNjtIqdjB0ov33HoF4Zph4MtAcDNqEhN/YDE70quYVKdOhTXcx0DviWH/Jc/NoZUhpSHd/C
 Z6DaIjupxB+gC8bmCO2h1CUjjBe/ji59kaGrGiY4dBL0ZqqxnFKtcaGRLnX/dCYAITQBDIET7
 n6eJwFnLG2A0aCWgIFBAqqVsG9yA9cjLj6yu2UfVeen6zRpEx1ABrGu31AJd3AZ1TxwzROzvp
 qenuT23sncAKy93zKWIpb+V5JS/ZBx0FzG0IEM+wF5cbfRqejrTk0ni4iYvoDZfkcjKxC+HBP
 DEDdCcIrgqplA6murcYQUbTmWOK+DJPbziQy9UiF6umgIk1RJaA8vg4fkEh6yJJu+elRJ9ruK
 ItTeYR3VcoUhyRLW+cjVqKtXUj8bOBzcJxoTp4FFRokeimDgC/gDotmEC8+Vb2DxADh4EZvlT
 PW2/4m2ZOuMDaO6PFxLVuBPJBtOcdfZbStST3ivc87GSHta2RvlKhY5lJ3sFuz5aQSIltwvrm
 qN1snpJQS1Dhyf1Y1TY8CXIGLtk=
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
index b7ac483eff12..cffbba5e2d9a 100644
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
@@ -872,6 +873,7 @@ MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
 static struct wmi_driver dell_wmi_ddv_driver =3D {
 	.driver =3D {
 		.name =3D DRIVER_NAME,
+		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.id_table =3D dell_wmi_ddv_id_table,
 	.probe =3D dell_wmi_ddv_probe,
=2D-
2.30.2

