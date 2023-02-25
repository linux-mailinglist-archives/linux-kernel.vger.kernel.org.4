Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6546A27D4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBYIGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBYIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:05:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAEC1ABC6;
        Sat, 25 Feb 2023 00:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677312343; i=w_armin@gmx.de;
        bh=9r+ibg9eKkn9LExgzAaFAAWxIQXWfKeAQOOzxQ4bOco=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ly+q8gux9JOzt7C5k/JdiChEfPehPk3l/8Dn9ABkzKzik4y1d+F2y5Vg4/jXxVQkt
         12j5zMYwP/Y3N3Hz3y5OQDpUSvSf+i8wqPdYYBIZkTt65xUqa+rUvDTYMmKNx35l6e
         TFSn8FbFZPA+YVl4sdmHtXD8bHpsQOhPoAwsbsBrnnB5FRdJk5yVYbhUywjZVBvt/H
         DW0tBgU7qKDtVozJlrkkg3JpKcg3wqTsVugxs57Wym3/pZkf3EJlLvKjRvmvUPWPNo
         M2LIV7GByba9rn4cyPRET9OgEiWujbiNHW7ox//BLsvFCpfSs9YLabErbULvkNt79f
         Jv8Bfajl/jFKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MTiTt-1p42DS1Ik9-00Tzdq; Sat, 25 Feb 2023 09:05:43 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ACPI: sbshc: Use ec query notifier call chain
Date:   Sat, 25 Feb 2023 09:04:56 +0100
Message-Id: <20230225080458.1342359-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225080458.1342359-1-W_Armin@gmx.de>
References: <20230225080458.1342359-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/QJk2JY0PRTEasYkeEf2FULmHkSNE/mMBkzvwv67jMa7uh3umD+
 vny1ZCe4cN6VaarxatggGjrQt/0E/FRI5x8MHF1gjSZh3kpp0hjn76IExfr8fl7i0YSdJDK
 My1rKdEQZBDCtB0J2RqrgBj2SV3dLPvWisYQARgb/Cn4WADy667lvlo595QDilybk9g6cmb
 yDv8CYiDXdjCGybAaQXhA==
UI-OutboundReport: notjunk:1;M01:P0:mXH8Cqbp6vg=;V0EDYoQ0YPtE4yjcApMHYeF5gtw
 W1OdvtsMDkAg9jpZhAOF2OFmxZUUGNJEhaN8ZrTuhRoGbL+VBgZBO58db2HKufZNOsP0trhCu
 hykS59a5Oq7ddYEc+nD0VajfHk3iK1CLlCd9T2hvM8wY1Bv0Y2oaXKHk30/t6bnydWbbnTBUN
 0y+Pnmyw/LIDV4wu0+rjdbSvI8gqJlL52QjDlvFeJcynPEYOFqCrTmyoroaaec5Weq85bYGvR
 rdv7m8jVJLX+KQYBtosDj0rhyNnb+7FQEK/011QXgQbBDw1DVJVgtxArtfUBa7CKBiWAwaCLY
 RtIJ/Uqfhoj3YNXPvLzZhrh/66ud0wDgoZhvl3g33AEhwzI5ByucQQL0glzSsHTyqI6Aj6pMb
 vmQ6BF7DsOTgF3r5j/nM2QLCtPBEOIbczGLMSRnHy5dd2OZhEZcNeInM9iJD7lglf2NfBCnhA
 JC+0y/CZe5sfPi6pyoM5UUwsfPQDexn9MV+fzbp0oSRdF35VoJ8TpLCSWC+An2mHIOdTJn1qh
 rOqSTkou2O6DZKrnSek30Bv7tKjIir9uqLjkSIrZgqqUWSVfsU0HsnnzflH/SdA/LhqMp3mXb
 cAMtkUI3g7+/yZCNqI/zow5QQNbxHMa7MRVLW2GS/+6NQNP+j00gCpBXAFCzfllb732si9q+D
 4Vw01MtYs1ppbAlbbXaXgF70oT9ubsbdqHVnrQvbDqViE1DUDsvLtXAhaG9bSxgr/scZs2vCo
 hYfZk+UskrBGmdszb/N3HIG1aZd7kl0LkTkDL084Z6N9GuFI06nEZI0ae31w8K8YeZuV4UMgh
 pvuWxP0T/eo9N1re4l/pmslgf/+BL3XUNzlsrhVr0mkdcBm/Z8Eqhc/24mPQUtRmo74UK7lL3
 XJHffnJR3QC6pwFOfdtsMR150DltiT/lCu+Tqwo4srGn8lizEHxsDq1HN52gIoqD+7RRMDjTY
 zKZQqUIoo8+NravqPzMgYJ/qPMU=
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

