Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B876A27D0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBYIFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBYIFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:05:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26411ACC0;
        Sat, 25 Feb 2023 00:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677312342; i=w_armin@gmx.de;
        bh=uNkbSijDFzzTJZKTSAPmytRUJkMoQgMb2ySqr5S1jhI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uZEt74xGMuUCKWJj/iMz0Wrx2MDgPmtseo+YcMojPM2+kdRMIGEvmNqQOOauBRBht
         co+a68jvm3+XdgK1kvPG3aUTtXRRGzDiRRCoy/QvBJ4mbyGQ5wQLp1B6v22ZpwpCz/
         BQauuHeKgaaY4EA/vMotWxacyduwI1OUmTz6ChfsxlT74SjaBLvBt5o3aprsxkZUR+
         Kkl0vcbfIlvg5u+MXvHn+k+15q0izf8JKTTaRit4+23aQ1xkT5x/yvJAIc5Puyap7U
         E6rdRI7e0Ikc0Va5YnGGAY/OALnAcAf8FzapbqKtr14JOe9AgEVD7qdrPm/Dk6KNOC
         Od7QW5/9cb8CQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N2E1M-1oVWoN3iQA-013gER; Sat, 25 Feb 2023 09:05:41 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ACPI: EC: Add query notifier support
Date:   Sat, 25 Feb 2023 09:04:55 +0100
Message-Id: <20230225080458.1342359-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225080458.1342359-1-W_Armin@gmx.de>
References: <20230225080458.1342359-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2BYlHgFBzShqWAg74t5pHaYHaQpx5PKzRhy701iI8iKtxomCRRx
 W1jtqO3XCZmULQd7lfvCtxmjaZvka5ekz4VCvcs5S/YeplJGrAKkBwJYLltHMPZ5lP/R2V/
 lkrp5qClZBp84P8Md6uiSBG9c/Lbx2BTCRuEyENn0Zd7THuXAH+d2OHTvBdYzTo+ectD/Lr
 aYp9whDx0zohibWZrzeHw==
UI-OutboundReport: notjunk:1;M01:P0:PJWarSnfWNQ=;vZe/d137UfhVDAkQ4Jq26UOee2H
 mYYkU23xCD+FVRygQgUtkjjJZoTle8VZJ5jylJXXLK+A/kcHnUHf7B/uQkA+3YnzXQVRp0MLI
 3agH0hlyHGq9iIvr1byXqfAdcGZ9buYmfpr1dK1K0LODACgpalBgji2L1rtMGflNaPKCFEepL
 ph/wPOUmwQ5V6/dpEtqzOGoydFFISf0o5Q2frQ/5ZlBRweRkhhGFDbP6qqFgXWC6bngrgwX1B
 cc3hwiMnR1YyZ3gNlFdbVdu8ziLktJ38oWGZDqF/lJVjNamBd20ePlRhzTOcE50L0MO8FSrlF
 6vLP/GHhQb9HVDAQQ9j1MxDpOPrPk/EmG+RfhM/nIokN3gsWn7q2QPDRj1gSos6tTPN1/gC8R
 tEobkjAmMbNYgLsZMuU2S8tkpxWI0LBBxXPQydQbqSq2ANxaDb8swhVzyzjNdysM6m3LorJBH
 rMhe2MqQXD2XW0bhldobuJMS3INhNHsO2Mn4WbPcRTKmf/yuzQq137ta974vm8EI3Qu6o2S25
 dM9P8XxBsQDFZaQDXKC+TbVOY+FYosNEC3tDOoh/ieSnDisa+F+Kasib4RsVLB8UkuboXq9SU
 HeVlW7WXsr2gEIGkU872YJ97L7zZqY9g0Rm9J8Tn0HJpQHb4wkENVyMgRVl/7WZihNl+x+cUe
 wUawiD4Z+796yaZhT6eYBe+0CBSfmCp3/TnfKSucCf3NTOZbTw+/k2fn7+oatylEqSXmapLih
 uYP9h1mr+Ku5kXXVjqCrlkPJj3vry+1RMNZLYWzPAA1hMaJsnHpAGFKg9nZSz3Y3kunc5f4m0
 +dyALoh53ykYdAq/4e9IdFXYc+o2qUEHW1HMMi3fw94RY9ywmvRRB0WPBVttiH+2xe5XblfEK
 hT6Qk3iNXF+J3fMqticiiqtuQxRf6yzZ8nSz5rV5yOHu766Cl5RzlCKgmlDTznehpcliHht5S
 rxkaIkPu4oS6x6loaKgTaLgUakw=
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

