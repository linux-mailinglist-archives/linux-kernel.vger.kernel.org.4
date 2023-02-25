Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5786A2966
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjBYLwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBYLv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:51:57 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225DEB56;
        Sat, 25 Feb 2023 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677325910; i=w_armin@gmx.de;
        bh=9r+ibg9eKkn9LExgzAaFAAWxIQXWfKeAQOOzxQ4bOco=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=suEfYPFINR/U/BcFNv/JmDGwoghohvyQEZAP8M89uDhziNaD7UHoPw0Msc9n3fE79
         U8XNWMUEv3CQXo6fF92lSWr/lmG//Q3bfXOLa5z+U8zOY2weAx6zilSUYWMy2XrxFY
         KryXXt9yq5yco8vCd8FUyyPlKhZWM0lfFlxhaId/QoUx5t+Q2Nqylgu1pb4MfRmVUh
         d+N99etPwPErwqfbCuXmrQ3k2agfhcbg8myOfy8418FYF5gqkq1NygcGO67O8m7eV6
         ThTbv1y6VRLfaIg6rP7/wgwE+wisMXuz/yekZTe1t0ra5C6lDLVN84KJT4lZXW1Vc/
         T1Usum1C8c/ZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Ml6mE-1omciw2sWa-00lR83; Sat, 25 Feb 2023 12:51:50 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] ACPI: sbshc: Use ec query notifier call chain
Date:   Sat, 25 Feb 2023 12:51:42 +0100
Message-Id: <20230225115144.31212-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225115144.31212-1-W_Armin@gmx.de>
References: <20230225115144.31212-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:97y7HOV9TVYZthxibjFFCPaN/VhpTWBWew6Ay/XiBe1eLrtT4jU
 Fw7QnixGQ+kddXPMRCfPm+sCmGWIpAiCtFO77dDa3Ch0PSVr4hMVctzHWpIfaXHslgfZG0c
 PJ7PPyzdYR2u98MAL7rWUCdi+bRrBCgFvU6y7D76zaapP65gCd2obDYrwb4pEymtj+9EtBD
 EYsqKPTYqQANHFWJm5Mdg==
UI-OutboundReport: notjunk:1;M01:P0:vAzVw2yu2HA=;MiXpS3/tw8r/Yfje2i/WqqIDtp7
 iHaRRPBz8EYzStKtlluD1ePm7TuWvXkbzJM/ElzrZv97eAk9rGU2ty1oV9Jl2MtuGh0QJ2A/B
 i5KMFfjkUU7H+97HNjrVHj4ubTJLrjhPBqQAZwPZ6hE2nFExjoBsq44mad/jLaBPMKDwT+LEw
 zhBa3aydp6ZmgELlnnmZDUrH/BsMzpAgxzpgwgQM0ky6MPPCUfWbLcnUBvDL5M8Je+T+kN5n8
 U95xVMZqixfPgY8otFl98CSfXXbX7BwHgD3cwc1YPTlQyepj/9wyOTzsXfQfwsVcWWbXPGYIk
 6jdU06pLdQ0z4+vHDV7nXz/yF/GJhleRQ27UK6wBTlsx/mjnc7DdThP/sCUux/uNN/HFoi/8L
 SMiTC7Ppu14UByRDJhhLFLvSGOMICWgRxWaFso/871yCTcjRPUBaJ0yk8HvAYZn3D9jGtH0dz
 R4j1pbTmNEeyANrckKrLirR+NfHVcAN236IF+obSeI41qP/auvipSHGAxEB3iKAEkoOiZViII
 WOP76AURq0+MXEex5+CZ8ORgYGJcKHCvmfeFlNDm+BaB0fN0aCeSWdVIwrFOxIdx9vRExtjmE
 va5TNRr9ptnYDONfmJFvp4Lvpr4Rn/iKE7oiINb52NOD5SsPWunnengA/2rfN6l+fsq2/bif5
 ded8GX2m7bKgpEr5qx9Xxv8d6KTbvOkAXUK1vGoVyENtzSippq3UncJg/SZX31U5Jt+JDGOxF
 yLfZ2BDOYavfP45LMOrhBtKBjSKFqNan6BSM7r1aA6uq/eiGftvGg+WD0oIZ228+3xRkKOYjW
 H3vRQ7UdRuqD9yA0VpSrQlhNvCznt3ONY2UlkXgiVrKS6Q8QTdn9wt5KXwhhcc8SgmYvILzmL
 BhrJWGzL8B1OqwuWS4Qs1w/R+UWpt65DzsSkAc5pjT601mR0CVvu98QVSTNV3SO6ssXJV/zUm
 OCT9BiQqDoEuFL4hx3pchgdpiMg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using acpi_ec_add_query_handler(), a kernel oops
can occur when unloading the sbshc module, since the
handler callback might still be used by a work item
inside the ec workqueue.
Use the new ec query notifier call chain to register
the handler in a safe way. Return NOTIFY_BAD to override
the existing _Qxx handler in case the query was meant
for the EC SMBus controller.

Tested on a Acer Travelmate 4002WLMi.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/sbshc.c | 45 ++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 16f2daaa2c45..e3280f646eb5 100644
=2D-- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -8,11 +8,14 @@
 #define pr_fmt(fmt) "ACPI: " fmt

 #include <linux/acpi.h>
+#include <linux/notifier.h>
 #include <linux/wait.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+
+#include "internal.h"
 #include "sbshc.h"

 #define ACPI_SMB_HC_CLASS	"smbus_host_ctl"
@@ -20,6 +23,7 @@

 struct acpi_smb_hc {
 	struct acpi_ec *ec;
+	struct notifier_block nb;
 	struct mutex lock;
 	wait_queue_head_t wait;
 	u8 offset;
@@ -194,6 +198,7 @@ int acpi_smbus_unregister_callback(struct acpi_smb_hc =
*hc)
 	hc->context =3D NULL;
 	mutex_unlock(&hc->lock);
 	acpi_os_wait_events_complete();
+
 	return 0;
 }

@@ -206,20 +211,28 @@ static inline void acpi_smbus_callback(void *context=
)
 		hc->callback(hc->context);
 }

-static int smbus_alarm(void *context)
+static int acpi_smbus_hc_notify(struct notifier_block *block, unsigned lo=
ng action, void *data)
 {
-	struct acpi_smb_hc *hc =3D context;
+	struct acpi_smb_hc *hc =3D container_of(block, struct acpi_smb_hc, nb);
 	union acpi_smb_status status;
+	struct acpi_ec *ec =3D data;
 	u8 address;
+
+	if (ec !=3D hc->ec || action !=3D hc->query_bit)
+		return NOTIFY_DONE;
+
 	if (smb_hc_read(hc, ACPI_SMB_STATUS, &status.raw))
-		return 0;
+		return NOTIFY_OK;
+
 	/* Check if it is only a completion notify */
 	if (status.fields.done && status.fields.status =3D=3D SMBUS_OK) {
 		hc->done =3D true;
 		wake_up(&hc->wait);
 	}
+
 	if (!status.fields.alarm)
-		return 0;
+		return NOTIFY_BAD;
+
 	mutex_lock(&hc->lock);
 	smb_hc_read(hc, ACPI_SMB_ALARM_ADDRESS, &address);
 	status.fields.alarm =3D 0;
@@ -233,20 +246,16 @@ static int smbus_alarm(void *context)
 					acpi_smbus_callback, hc);
 	}
 	mutex_unlock(&hc->lock);
-	return 0;
-}

-typedef int (*acpi_ec_query_func) (void *data);
-
-extern int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
-			      acpi_handle handle, acpi_ec_query_func func,
-			      void *data);
+	/* We may need to override existing _Qxx handlers */
+	return NOTIFY_BAD;
+}

 static int acpi_smbus_hc_add(struct acpi_device *device)
 {
-	int status;
 	unsigned long long val;
 	struct acpi_smb_hc *hc;
+	int status, ret;

 	if (!device)
 		return -EINVAL;
@@ -271,15 +280,19 @@ static int acpi_smbus_hc_add(struct acpi_device *dev=
ice)
 	hc->query_bit =3D val & 0xff;
 	device->driver_data =3D hc;

-	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
+	hc->nb.notifier_call =3D acpi_smbus_hc_notify;
+	ret =3D register_acpi_ec_query_notifier(&hc->nb);
+	if (ret < 0) {
+		kfree(hc);
+		return ret;
+	}
+
 	dev_info(&device->dev, "SBS HC: offset =3D 0x%0x, query_bit =3D 0x%0x\n"=
,
 		 hc->offset, hc->query_bit);

 	return 0;
 }

-extern void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit=
);
-
 static void acpi_smbus_hc_remove(struct acpi_device *device)
 {
 	struct acpi_smb_hc *hc;
@@ -288,7 +301,7 @@ static void acpi_smbus_hc_remove(struct acpi_device *d=
evice)
 		return;

 	hc =3D acpi_driver_data(device);
-	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
+	unregister_acpi_ec_query_notifier(&hc->nb);
 	acpi_os_wait_events_complete();
 	kfree(hc);
 	device->driver_data =3D NULL;
=2D-
2.30.2

