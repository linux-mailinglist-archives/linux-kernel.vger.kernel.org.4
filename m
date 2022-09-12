Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224AB5B5A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiILMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiILMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:54:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A26438698;
        Mon, 12 Sep 2022 05:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662987228;
        bh=8ihrj8g25HP53F8+Sv7wcMhICOwnoHKS/foAdha3L/k=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XwqIH7AC/JhJY8TfxPD98U/Lt30taTqlqGSp+PW6lgpKFYLFBf9GT9bkiDKOwJP9i
         xPzLPfLnXZxPJ0w3CNGn0YQhnOAmp1hRGuYWg2Gv7p6OF2E9dA6P94BLVMV2J2JBx+
         kUcY+YoA96batW5k2kPn7YGezYmBpQkzb9zIQqJk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MOREi-1oh9Vq349u-00Px5m; Mon, 12 Sep 2022 14:53:48 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ACPI: battery: Simplify battery_hook_unregister()
Date:   Mon, 12 Sep 2022 14:53:39 +0200
Message-Id: <20220912125342.7395-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912125342.7395-1-W_Armin@gmx.de>
References: <20220912125342.7395-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IkLysIw5a5ESft6c54LstqzrkEw9rnzQD6ovCh2OdaLG3RhWnqr
 7MGdkAoiphM/0RCommfQ1LhQRWpZaRMiWKVBjI4ocPuTn7srsBpB2op+GsX36UochwOeNbF
 YGpAUK0Nxn+obfSWfi9+TgzB1+ecADX+/WYTvrqW4Y+h616cp84IxG3Z0gr22Zg2ufyre/D
 /B7pKoHnkMoUQ6iXQz03g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aOfctYAThQc=:1NwPC6V2Krz1yElDCswt+C
 BoXkpkK30ygh8LUILGzI5w6H+DnDgixwAq9PqtPgkzW/oEY9kui8pOS63Cpe7fJHfugjO3t7Q
 aBjJ/XpVFoGSci2aPF5gyoskHmXZRYxiiAbJdaIjmcJVwySn/rjgXiyZPtG7Us3uWoDF3ARTS
 TtlMS0AMkA9CTFJTLBWBAZFFAskVDAaQT3gk3nEB0XtUgZ9zK8Qc9Rxf//recqRsroOhh6/ik
 9XpTZM/2BW3binq0u3Vbxkr7Xi8ZFJrvFPRlz3Kojd0NikDIlf3jjL8npn54w4N3PijwPLrZ+
 B3ywve9XJUUe5V+DZDipMuFUIwhgfp5NISr6L3FAUrNgVY77O8xs3BqJnsuCAYsM+/H2aX/G2
 4FL5j645Q0mhEDg2ApVVh3Of20BTtoWDYU0bBfvh0OewEQV5MFrkrnZxCVTqIH1SfiQX+s0Oz
 Ogr77VXKhVMMCTd2ZyyeCne6BsgQMfJTb6p46Al/yZUo3mtr5d1yeK02LRqC0HfDpVVUFbPL5
 KNWqhdve+2OhNt1KF74WIQLHBnMTQ6krQjpR3qWFnh6D+3cvQwhdpPgEC3kepBCAM02+BitVW
 md5WmI7Jdkg2AODQu7khzr2gtmMgygfMQU/3x7OOSJIZLb4sw12KqGA2KK12c8oq9+Vud+Guz
 ub/baIstL62aTy6nj9Y/YcpWdk7vkVOzNIJPFmeK/6rVOS10d4UIfrZ5jqAoyCS3vyCeVMWw8
 6OFuuLnop/U8G4s9XZCNOmtUqOQAYT5WuY1HyAbMg9Kv3VN2eZnJsM6FPptbvdlAW6zWHssaZ
 XaWXwBDq/JDikTbP6qnpUidHsXMQO1wwc4umlG2W3/Lq5C/g41V8Omtet1K745DEWKzL9In08
 4A1dlrSMzrKPEaisNAEN2Z2L7vi0txu7Ql8qzE8qn8987dzQeEs6/PG/eOewA7P7oe2JETp83
 N/wnY8SDOfQ4fbzi/CJqr/D7NHP+NfcRQhU+RBOlHe8j3KvcyaiPGYVK2C49SD4uPeYDTjyOI
 5saV+Qh6frs9kOXAAlvN9xm5d44g66hZlCjyeddi8hTT2ulHQrA1ExIoLar/lvCcN0qpOPPLG
 OeONDdBH4CLmLlIgaUI7EvrI4If5mDRmu6IvLrmZQMTH4Dv/j1+kN80CDyaA61MoIySqdkj3q
 aoQ9MbD+Vvu/uB4LIFK3Xd6Avv
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since __battery_hook_unregister() is always called
with lock set to 1, remove the unneeded conditionals
and merge it with battery_hook_unregister().

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index e59c261c7c59..4aea65f3d8c3 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -686,27 +686,22 @@ static LIST_HEAD(acpi_battery_list);
 static LIST_HEAD(battery_hook_list);
 static DEFINE_MUTEX(hook_mutex);

-static void __battery_hook_unregister(struct acpi_battery_hook *hook, int=
 lock)
+void battery_hook_unregister(struct acpi_battery_hook *hook)
 {
 	struct acpi_battery *battery;
 	/*
 	 * In order to remove a hook, we first need to
 	 * de-register all the batteries that are registered.
 	 */
-	if (lock)
-		mutex_lock(&hook_mutex);
+	mutex_lock(&hook_mutex);
+
 	list_for_each_entry(battery, &acpi_battery_list, list) {
 		hook->remove_battery(battery->bat);
 	}
 	list_del(&hook->list);
-	if (lock)
-		mutex_unlock(&hook_mutex);
-	pr_info("extension unregistered: %s\n", hook->name);
-}

-void battery_hook_unregister(struct acpi_battery_hook *hook)
-{
-	__battery_hook_unregister(hook, 1);
+	mutex_unlock(&hook_mutex);
+	pr_info("extension unregistered: %s\n", hook->name);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);

@@ -784,7 +779,7 @@ static void __exit battery_hook_exit(void)
 	 * need to remove the hooks.
 	 */
 	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
-		__battery_hook_unregister(hook, 1);
+		battery_hook_unregister(hook);
 	}
 	mutex_destroy(&hook_mutex);
 }
=2D-
2.30.2

