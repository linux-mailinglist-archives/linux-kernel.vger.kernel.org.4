Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1596A2962
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjBYLwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBYLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:51:56 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2B6EB66;
        Sat, 25 Feb 2023 03:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677325909; i=w_armin@gmx.de;
        bh=uNkbSijDFzzTJZKTSAPmytRUJkMoQgMb2ySqr5S1jhI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z0Mwqs/1QKrzB00G56YTFOiw15irpwTvDO68WHXEiTlY34aDPhWtgOvoXfaHiyytq
         EAglFYr+CsZzg0T3iTq18Od3qxShMV4dk38ePGRh2Lt2qyKTSCgyFPkW3wONrNXhEx
         i4FrajEoG6OJu2wCPjjRJta4VeH9OPzdEQsp8lriSRmav4/Nu6WtqmnQ0WPJJN7FPu
         iHHoVRzdzf2kr9nK03eqIhXmxjg8GTHL87q55L19tq0s5yg4hLIwkfiCShiO71ECSu
         TYUmvTe67lMazZAJYKGbgbUSZkJM/eUTav8j4PEUfWNsFjcL19LWuOoslkZcgOfdYd
         MDoqzflLqqnlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MWzfl-1oyVIq106D-00XH2d; Sat, 25 Feb 2023 12:51:49 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ACPI: EC: Add query notifier support
Date:   Sat, 25 Feb 2023 12:51:41 +0100
Message-Id: <20230225115144.31212-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225115144.31212-1-W_Armin@gmx.de>
References: <20230225115144.31212-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9qgZ5XlFM1dryjZe2sJc4b7Jw5L9axQsA1h4k3y+Zz7idOC6AjV
 +Yi6jVeciqKezY5I+NJ8gOD3G949OkqtS9X/mjfILfFkBlcALfEEru9YySIK0D5kljYPqoH
 iExcNfLy7BiMrCl5mK2clH0dMri8Vt1KT3iG7Yul/sNnKHA3VxXSo1J48fpCwO4Ok9ayhAR
 SUJaft8Ub5SXn+Sjb36Vg==
UI-OutboundReport: notjunk:1;M01:P0:ydJxzquC0oA=;LaAWoSS1aHtgk6pESX/9Q62um7y
 iVOKgI+IUGy+wUD8bRNFa95biLuSgdO/MYjpLC2JMlk0lpUVoctLShTBV619AGgXjHDF9rHr8
 KjANzzvmCG4NzKMZnqhYnJ6WsZL1YKspUjovPF+914FPhp/B38iDwNrrG5lyRH5HXX6aLF/gM
 Zppuh70gFmBcas+NzlPbY6eMjOGHw4DDVmWhu2Rbnz0R4J+LNTkMM3kwzoteRMRw+5ICzTYlk
 W60GsdzMsMdPOY6dfY8WwK8/7yg8ePV+5CKZlu+D76kk/QrNj8Wr/Htl9+GZzN3Y4N1BJxfv0
 bKorxlt22atlV/m1BRUMMem280815pvTWsStHUAOoZb4EFvhUQrMR8pR9EPjQMoEQBWtVGuDC
 K+NZwN/RGolAypQCo4+wtWtn0J+acnm847/I0PUw2S1puV7rs5qmUcvD5lDaGFCC8YttEUwOT
 GXUR96DeH8UZSvjjsVyv3RJzK+SLBan4MfwV0apH5tVuCOCSLyGKbmCi1OzBZW5cNKpvYULwg
 l77gO7UcTsYuPlZRKRgxFOqciiNCJSrrulCWw5PIyRxS/njJrbMetGKNvYfBw0rLWgqlAJBXe
 d5WBFXMwm5vmP1tUXi/pfoOCuKRRBsKRgsiuhkKJ5fqK2BerucJ/0o19FIp0jB2LrZzmhIsqb
 naajBPqYBGMeFLPX/DhATVRrs8pwpALYEl3gePXQtOrPXFPaSVSs3cgPfSpmMlsVosOIIDgAF
 iPkgcXbY6bg//VtVsXgagKJUOimc8fKGpDUGwtv6Hze2oLRhM9qEW8ZpyoiAaoNIL2wAFFrcM
 ehaFdpTRgiE/TkYB1z7hntBlTdgbn8izw7BUVy7fIv3s4zHy1QEOYJfcEgwNp9Dgs1pSDS8su
 NkgXe4/bbBbyZ0jBOaK2JYOiWmzBBG/2pQDVZjNzJxZ4Tp8Robq+WmYL3tPqCUobwVfaB91Ts
 o5OiVt9MX9yNHDKtQ89sIEnfxwY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow external drivers to register notifiers to act on
query events and possibly override the query handler.
Use the existing notifier infrastructure for this to
ensure correct locking.

Tested on a Acer Travelmate 4002WLMi.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c       | 28 ++++++++++++++++++++++++----
 drivers/acpi/internal.h |  5 +++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 105d2e795afa..dc7860a825a0 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -18,6 +18,7 @@

 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/delay.h>
@@ -184,6 +185,8 @@ static int EC_FLAGS_CORRECT_ECDT; /* Needs ECDT port a=
ddress correction */
 static int EC_FLAGS_TRUST_DSDT_GPE; /* Needs DSDT GPE as correction setti=
ng */
 static int EC_FLAGS_CLEAR_ON_RESUME; /* Needs acpi_ec_clear() on boot/res=
ume */

+static BLOCKING_NOTIFIER_HEAD(acpi_ec_chain_head);
+
 /* ----------------------------------------------------------------------=
----
  *                           Logging/Debugging
  * ----------------------------------------------------------------------=
---- */
@@ -1125,18 +1128,35 @@ void acpi_ec_remove_query_handler(struct acpi_ec *=
ec, u8 query_bit)
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);

+int register_acpi_ec_query_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&acpi_ec_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(register_acpi_ec_query_notifier);
+
+int unregister_acpi_ec_query_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&acpi_ec_chain_head, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_acpi_ec_query_notifier);
+
 static void acpi_ec_event_processor(struct work_struct *work)
 {
 	struct acpi_ec_query *q =3D container_of(work, struct acpi_ec_query, wor=
k);
 	struct acpi_ec_query_handler *handler =3D q->handler;
 	struct acpi_ec *ec =3D q->ec;
+	int ret;

 	ec_dbg_evt("Query(0x%02x) started", handler->query_bit);

-	if (handler->func)
-		handler->func(handler->data);
-	else if (handler->handle)
-		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
+	/* Allow notifier handlers to override query handlers */
+	ret =3D blocking_notifier_call_chain(&acpi_ec_chain_head, handler->query=
_bit, ec);
+	if (ret !=3D NOTIFY_BAD) {
+		if (handler->func)
+			handler->func(handler->data);
+		else if (handler->handle)
+			acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
+	}

 	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);

diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ec584442fb29..6f41d42375ab 100644
=2D-- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -11,6 +11,8 @@

 #include <linux/idr.h>

+struct notifier_block;
+
 int early_acpi_osi_init(void);
 int acpi_osi_init(void);
 acpi_status acpi_os_initialize1(void);
@@ -212,6 +214,9 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 q=
uery_bit,
 			      void *data);
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);

+int register_acpi_ec_query_notifier(struct notifier_block *nb);
+int unregister_acpi_ec_query_notifier(struct notifier_block *nb);
+
 #ifdef CONFIG_PM_SLEEP
 void acpi_ec_flush_work(void);
 bool acpi_ec_dispatch_gpe(void);
=2D-
2.30.2

