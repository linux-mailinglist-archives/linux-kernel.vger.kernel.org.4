Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFACE6A27D5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 09:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBYIGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 03:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjBYIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 03:05:51 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3905F1ACC2;
        Sat, 25 Feb 2023 00:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1677312344; i=w_armin@gmx.de;
        bh=ARMhndNiVUL09RLJuOzxVFQztlSRTxeVHCef2qBjh7k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CeQzxpBOXS/xuEapDfaDuWvvS6qvXo1jFFIgxpEKXI5JgkAgPVgGU5Yo7Y3JPWP0o
         inHIZ6yZM2eWmsoIvi9CRK9TMUz8Qq9AAcXy2a5htdv39mgSkGqyFJnZKsstMuOPeh
         gbxfhpQ3hosTjhInA2lACmG25N9iRJmHjepIMjuZiRte3xn+jKdE4kbuhrsfYm9mdZ
         1YKfqMdxTKIcVeF5HiJ3B6E/NwXXVHLoN/P5N4oH6Mt3d946kQKPamEH1iksV2f7Et
         06sXbUeTmNNB5w35dPxquoP3t3gD8uHOz5ipQLziF15osdTEplGoPXA4kS+1HwPmzg
         s9z020V58kl+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mn2aD-1op6xr26hr-00k57M; Sat, 25 Feb 2023 09:05:44 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] ACPI: EC: Make query handlers private
Date:   Sat, 25 Feb 2023 09:04:57 +0100
Message-Id: <20230225080458.1342359-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230225080458.1342359-1-W_Armin@gmx.de>
References: <20230225080458.1342359-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B6xNyHRHfUEAzQcQf9iOtDJ5MrT9ujygwl8OcXBxhIr4Uir3pzf
 UGjyujfJB6HlU06SKyvmFbm7KznlbRDsPgLwOkzuX/+2Q/g0Y3SkqEmfXjW+VLV410uQvFn
 F3i8hrKRIpuQQ1/ZekBwXuyyhqScJcDaGZ8430iEenETVAs6wtsQ+GjtTb/tEb9CwKuD9Le
 IJFDRhorgXR5a8bz5HsRw==
UI-OutboundReport: notjunk:1;M01:P0:MdLcHQniR9s=;essg5JBcoHq7bK6i0lgGV0v5D6B
 NXGHJhNZrMOx7KhIqYm7Wb0EAWgConUGg9GcWqGTMjDBpNJJe3KoD+9TLqJk0iJLlOgbe4XKV
 +cVYfPWiDiLbmNTZzVa2MsRYf6rSgkYhGqFKjTq2We/yJLiW3EdaWvqxuU6AxjdsZ242RY954
 1DnP3Shw/KuatEYF4H6/fskn9a/G14Xss7znScs2FpL2fRn2+KE+015021gv704b7l1EJ7xWa
 8gdYrHwDMtyWbO10sE7AdQJsz7fBDtYqsoeeVaPZ0nWDcbARGLprY9iz49uXP/EVR+nUAOgk3
 rRQsIvwNrX/4++tY3NIEMz6Nzcc/LeaoKBAm9ZyhTCmbIbWefrjs+PnmQeWT804yBZb4tlIxl
 spIihIuSfb2Eb/h9UFh3wh8oAsfX8hc1h8w3C9ewdywtw1tFND8FzUPW1O8P+H2B7w2KMU3su
 i9Ek/cdgt9hKVBtej+3CTO4+uV2uXkqvEqJRyAToUswEtp5LfdX5aZb3e01zynpwoFxFG9RPt
 JBhnXvebri7pxKSHCuhrYVa0pZ9icOEIyvfGui1WJehhI5dgsZLckE5u1k/Q7sjmfKhj+BwvX
 zzFtekaep3q4cnUz7rvFuwhsL4r+xmOOUUy+NUbATym1lS6yb1OhHnvNntMSQDLGYEZ6L+f3G
 oO+DSZKaXOd5PIVLBRjDQSiHNEob4cVk9ilMhKK+rh3cEeXtmksRuJ9Fgkuw1+9Nx6wH+T7c0
 Swmm358EHAnpRMOECNWzYVa7/d9GdHCXSNB06BcmrnxU7FkzeA03e0sSJ9dU9FyQKdWX2SEWu
 5DFoVtLZqdvAELQ6Vep8eXKeEPalsu8/2vCVImwJaz6Fq266QB7amOvYreKOukK1eQOWXo8Bz
 Ew6QIomtN9h4Q5GunnZ2CucAj341TKzutpMFFHfX0IgIaVCKF6Us0ArkMHiFnmQvPJ/Prk3UZ
 N1cDEFUz9eDOnoIkwTIiwVxsx9c=
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
index dc7860a825a0..94391a62a44c 100644
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
+int acpi_ec_add_query_handler(struct acpi_ec *ec, u8 query_bit, acpi_hand=
le handle)
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

