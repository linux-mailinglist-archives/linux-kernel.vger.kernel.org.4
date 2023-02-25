Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC26A2967
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBYLwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBYLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:51:59 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91230EC78;
        Sat, 25 Feb 2023 03:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677325912; i=w_armin@gmx.de;
        bh=aFx93Bs3vYD/A1ztGnO44q1Pozj+Rsgp1DXI8DNLUVM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SsJIX2Njz3jsKKh5Lhjm7mgnEedGtKoTZeJsl9W/wW+MDKmveRzdE8fxOf9PeM8CR
         6pcgMX3WLkAbZG5jMupEf8lck5Nm8m1HY8iZcGq/iFjZOr+ScgO3k+2jXglqQWaVfz
         iqJ2CxEskcAj6co4hYrg5NxYHsZEqyK6CouP+tpMy+upC+MDsuaGYv6p7S8f2Wdy2x
         1q41sB7CXUGE4uqiHhL4xPWssRW0Xo+iF3Ioav0uVeqQilVkP7D0Bja7eIUmzYLS3d
         v3Bzw4l69GPEcogDZg/Ym1/lewtmtsUT+NZUObSQQUQ60oG4ymPmDPDtld3KZS24oy
         JwAbgqL3xgIKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYNNo-1p1W6f3XKk-00VQAL; Sat, 25 Feb 2023 12:51:51 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ACPI: EC: Make query handlers private
Date:   Sat, 25 Feb 2023 12:51:43 +0100
Message-Id: <20230225115144.31212-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225115144.31212-1-W_Armin@gmx.de>
References: <20230225115144.31212-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T1zgduE095Lm7fr46vit2+r1mQQBRoLtysiBLIe5Di/dtntRgX/
 SGZw+ZrC0mRUw+JqhLkxeO/dQ/rfdg0vhlEXaupE2L3f2ZIfh1mPuaOHJHE+uFQLMlaHXQO
 3YWlp3Be9d56uWZJv0W7nzZmtbsXNW0ned8fE9wq1auIWMUm9lieIf6E7UG15EyirimnRkj
 91/pZzMKbA3mzkdTCaCEw==
UI-OutboundReport: notjunk:1;M01:P0:2GkJ2W75xrA=;bJ9/Q6+fTsu/4GD2mYpVsCqek00
 hlQCHZWut9//8qLl9Byamr+z8jNdel2St0RoFPq6YfgOow6PGiGfw41479Cm7e0bhsoqnjx+4
 9h+/BdYCVLoN+YQCEzUOuCWtm1UXrUKgmAhwfrBaMPIQ5hlxvYZlCt4l47P/GezgcjHdWW92d
 EiRHxn5hgGoEZQsyqWSjcewZaMi8LLGP3CEtOn44vcx5Mr6et2uCiXOXFav+TePiqYgPYeuI/
 N7+mCPObWfVdalrvsGJwhtp7fzt7Uwkfw9oH0S4oS6m/Koggo0I7kqp5lrj9zgmV8foLEXMJy
 uVLcPvoYNTYDreGz0YRoMd6K/KM2mzYv20g8subpDgmS1BEY8wchoGelomVi1V2pQm8dgeGec
 MauwYr4CoClrQhpwQ3SDVNnz/QFsLV8/N+KGQOxDEC5lZct2ZE3hGZvSQ5D7i2byddUEWKQgU
 VLodB7ejfBgAbw/bYR6bkXrJxZ2xpqINpLhz2JjuGMtI4+qOpyuj357/YnIjPWFsunJngJipP
 psjAx/yDFflf3Leciai2qdQAeTOsEF9ShWhU8+mIfb0m9HKjcoB1ULOm99zwCmTCZj4F210kT
 TfNjxjD9JRx/M+11L+KeFlR2CoQZ4R4PGeqjnJUwVn8WenTfqwpvvp1K0DhGCgcLkOPrsJzuM
 X73b+HokU17kAenKcLFleTdW1T0n8M1DXeretzJoysP1bNEaqK8bcIDxbhcRwy57CfKpZjQxg
 3AhdhorpiAy2pBO5RdahBW8zCw8OgifgIvr/txEjcwLP+RdUlzuCFLIuF9JRUR77M9ujB63tP
 mVxP9iapVbRJXkVRI+1bHRCcduAwo5HJYOX1S+A/5AGWdY2IW55+etqYoJj7Q5DP9f0vIR/Fa
 KZJHyvLMKRXQ6aYveF262Q0qZ73kBf9mmfkdGQ87iqMD2OnbOvH3GvA6W5VZIPBaPsHfEfEDZ
 UB3hiEtq83wdADHQaNtQo1izfQM=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ability for external modules to register query handlers
was broken for a long time due to having only a single user.
With the only user (sbshc) having been converted to use the
more robust query notifier call chain, the query handler
functionality can be made private. This also allows for some
cleanups.

Tested on a Acer Travelmate 4000WLMi.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c       | 36 ++++++++----------------------------
 drivers/acpi/internal.h |  5 -----
 2 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index dc7860a825a0..825493d38a4f 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -143,9 +143,7 @@ MODULE_PARM_DESC(ec_no_wakeup, "Do not wake up from su=
spend-to-idle");

 struct acpi_ec_query_handler {
 	struct list_head node;
-	acpi_ec_query_func func;
 	acpi_handle handle;
-	void *data;
 	u8 query_bit;
 	struct kref kref;
 };
@@ -1082,9 +1080,7 @@ static void acpi_ec_put_query_handler(struct acpi_ec=
_query_handler *handler)
 	kref_put(&handler->kref, acpi_ec_query_handler_release);
 }

-int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
-			      acpi_handle handle, acpi_ec_query_func func,
-			      void *data)
+static int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit, ac=
pi_handle handle)
 {
 	struct acpi_ec_query_handler *handler =3D
 	    kzalloc(sizeof(struct acpi_ec_query_handler), GFP_KERNEL);
@@ -1094,40 +1090,28 @@ int acpi_ec_add_query_handler(struct acpi_ec *ec, =
u8 query_bit,

 	handler->query_bit =3D query_bit;
 	handler->handle =3D handle;
-	handler->func =3D func;
-	handler->data =3D data;
 	mutex_lock(&ec->mutex);
 	kref_init(&handler->kref);
 	list_add(&handler->node, &ec->list);
 	mutex_unlock(&ec->mutex);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(acpi_ec_add_query_handler);

-static void acpi_ec_remove_query_handlers(struct acpi_ec *ec,
-					  bool remove_all, u8 query_bit)
+static void acpi_ec_remove_query_handlers(struct acpi_ec *ec)
 {
 	struct acpi_ec_query_handler *handler, *tmp;
 	LIST_HEAD(free_list);

 	mutex_lock(&ec->mutex);
 	list_for_each_entry_safe(handler, tmp, &ec->list, node) {
-		if (remove_all || query_bit =3D=3D handler->query_bit) {
-			list_del_init(&handler->node);
-			list_add(&handler->node, &free_list);
-		}
+		list_del_init(&handler->node);
+		list_add(&handler->node, &free_list);
 	}
 	mutex_unlock(&ec->mutex);
 	list_for_each_entry_safe(handler, tmp, &free_list, node)
 		acpi_ec_put_query_handler(handler);
 }

-void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
-{
-	acpi_ec_remove_query_handlers(ec, false, query_bit);
-}
-EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);
-
 int register_acpi_ec_query_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&acpi_ec_chain_head, nb);
@@ -1151,12 +1135,8 @@ static void acpi_ec_event_processor(struct work_str=
uct *work)

 	/* Allow notifier handlers to override query handlers */
 	ret =3D blocking_notifier_call_chain(&acpi_ec_chain_head, handler->query=
_bit, ec);
-	if (ret !=3D NOTIFY_BAD) {
-		if (handler->func)
-			handler->func(handler->data);
-		else if (handler->handle)
-			acpi_evaluate_object(handler->handle, NULL, NULL, NULL);
-	}
+	if (ret !=3D NOTIFY_BAD && handler->handle)
+		acpi_evaluate_object(handler->handle, NULL, NULL, NULL);

 	ec_dbg_evt("Query(0x%02x) stopped", handler->query_bit);

@@ -1402,7 +1382,7 @@ acpi_ec_register_query_methods(acpi_handle handle, u=
32 level,
 	status =3D acpi_get_name(handle, ACPI_SINGLE_NAME, &buffer);

 	if (ACPI_SUCCESS(status) && sscanf(node_name, "_Q%x", &value) =3D=3D 1)
-		acpi_ec_add_query_handler(ec, value, handle, NULL, NULL);
+		acpi_ec_add_query_handler(ec, value, handle);
 	return AE_OK;
 }

@@ -1587,7 +1567,7 @@ static void ec_remove_handlers(struct acpi_ec *ec)
 		clear_bit(EC_FLAGS_EVENT_HANDLER_INSTALLED, &ec->flags);
 	}
 	if (test_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags)) {
-		acpi_ec_remove_query_handlers(ec, true, 0);
+		acpi_ec_remove_query_handlers(ec);
 		clear_bit(EC_FLAGS_QUERY_METHODS_INSTALLED, &ec->flags);
 	}
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 6f41d42375ab..72ce5a9ba57f 100644
=2D-- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -202,17 +202,12 @@ extern struct acpi_ec *first_ec;

 /* If we find an EC via the ECDT, we need to keep a ptr to its context */
 /* External interfaces use first EC only, so remember */
-typedef int (*acpi_ec_query_func) (void *data);

 void acpi_ec_init(void);
 void acpi_ec_ecdt_probe(void);
 void acpi_ec_dsdt_probe(void);
 void acpi_ec_block_transactions(void);
 void acpi_ec_unblock_transactions(void);
-int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit,
-			      acpi_handle handle, acpi_ec_query_func func,
-			      void *data);
-void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit);

 int register_acpi_ec_query_notifier(struct notifier_block *nb);
 int unregister_acpi_ec_query_notifier(struct notifier_block *nb);
=2D-
2.30.2

