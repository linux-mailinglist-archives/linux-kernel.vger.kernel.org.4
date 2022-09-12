Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3455B5A89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiILMyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiILMyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:54:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD89C3869B;
        Mon, 12 Sep 2022 05:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662987227;
        bh=XSwCs2/nfGyrdpEwoz6uFQ7g22hV+iNYaBeDGLIB9X4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XuVJ05IMBrXvd5LjEfyIBcFmMsgz4URHCk6HBpo29p4xr0Yd8V5wISfxB140FFMqN
         V/7M7C8mwYOhgK9Wcud3s6CxYg3FpV+tvw/YIHFY5DPHf5VGTDDGn8WArx4VJyJ9E+
         5CP6C2q58I5hgCqpyxyoLvYTW+7R+iVpejsT7wF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MuUj2-1pOAq83BRa-00rc7V; Mon, 12 Sep 2022 14:53:46 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ACPI: battery: Do not unload battery hooks on single error
Date:   Mon, 12 Sep 2022 14:53:38 +0200
Message-Id: <20220912125342.7395-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220912125342.7395-1-W_Armin@gmx.de>
References: <20220912125342.7395-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:opYKxNI6ldvV9CMPDs23nnkFLRX2RWCXenJp0Fy2cZzTkhBpHHL
 nYOJxT1/52Em+UtIES3UHRQJ2AOYeJc0+p16gvrPwNtsMt4fy2xMfYGtzz4miyINI963nV8
 2vWpg8tfTlD1sLCUYlmrgKgh0G/U4iUzDnNgd0hVpIwBcbZYJPaI71L0BXmwWNmr2S0UF70
 KNqsTvrMTRRgMwNz5Lg8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tRQ/ZT6ufDs=:9m9mqRTMKP/EHSjOI97MZG
 Ohw2vJbWzO8pVNOOjbB4dENDZgkEMGiPHy9E4F4ovG9czf5tK8NXR6D55GBQXdBb1Pg+K/EFF
 RlCtOPvcqMtuUS2VHlT9rTT6Ej9ioDqkamYVcaI00Z/Bri1yUGUSyUZA0n41aPI4Z1m5kCORX
 kpP8y1J8FvQsbVVylNWuAJ+o9LswQiUciHl/2w8TaJ6XJMxN6UwkfjXdORH6/nB2bonE/IF47
 vW57FaESEUE600YOlkwONY3yUMZ8COhH7m5+1skvmTWmYpatPfEsMf9htT3Ix7/TzfRncY/Uh
 Rdfu/WIw6Hznm4WdpVlC21+04TaVYe6aftTmhcSgZ9rdNag15C3NkBaIsbGji0sLl1b6UE6jg
 9f9uibxmj2XDXfDx2vcMQjhqyPFBElmdOkmSVHY2Ul6rv5SEhGulZzSXWZJTFZ/ykUmyZVsg1
 /2aPLYi9wUGRzik3Cxzem8L3JVHp2szmF8q1kb3isdI/ktQ+Nkq6z1V0q10s27VJNbX5VtqeL
 J49nura+LmfNae16eC3tHtECTYmijmme7LbIH9SV/EnQN2Lh9rjWMX2yiNatvM01wk7A9DZUK
 e9oVJbLlCqS4vNRZAgIF2JSz/fdrETSwxWO7x1iP5OxdLFTvnz1uxNWtMES6/DedsN1hhf53F
 6IUi9gixSIjIvTWZjtOYP5la3TUesZde7lzx8iILOIG3tECApBhr/okwzBa5W1S/9Po55VeiF
 xxiL3PGJUokUFVlesWoa5ltWDtPvEKe6+FXyuFC9qhOnkhnIga1oSEra2vzqgwkSh/IxUPz3O
 onjrkXIxLh88u/0v3qtRpurqTxdNz3liNA9YFadem33OknOaOj+2Yu0TrGGizlrf5J/bQqQ5K
 xXLWNnyp+qhES4D+xEuyE7jDJuWkZKww11kNimUbSAue0kPfiQG8UollzSI5kizJZGyEm6WlY
 C5sqzxaq56YLu6+AkKvID+RYUJD7TsFF8sohPG0dFs2yZdqK6Vn0aM3qRLZfBjHAXh3dbd9PL
 3mytR6shGdcgupE4njkt21NfsEt3AeaJbo8zMOFv9DGqP3jE0eJHW15oUEluqfGMkUSfLyOu8
 guUdqPnmF5rg5yJdL2dIHGr26M7hNdPzV2CtEgp32N7WGqrWuRd6pR92sxr88vQP4Sk4P1byu
 n6Utp9PcbF7TiR5Vybg52f60eT
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, battery hooks are being unloaded if they return
an error when adding a single battery.
This however also causes the removal of successfully added
hooks if they return -ENODEV for a single unsupported
battery.

Do not unload battery hooks in such cases since the hook
handles any cleanup actions.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 306513fec1e1..e59c261c7c59 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -724,20 +724,10 @@ void battery_hook_register(struct acpi_battery_hook =
*hook)
 	 * its attributes.
 	 */
 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		if (hook->add_battery(battery->bat)) {
-			/*
-			 * If a add-battery returns non-zero,
-			 * the registration of the extension has failed,
-			 * and we will not add it to the list of loaded
-			 * hooks.
-			 */
-			pr_err("extension failed to load: %s", hook->name);
-			__battery_hook_unregister(hook, 0);
-			goto end;
-		}
+		hook->add_battery(battery->bat);
 	}
 	pr_info("new extension: %s\n", hook->name);
-end:
+
 	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_register);
@@ -762,15 +752,7 @@ static void battery_hook_add_battery(struct acpi_batt=
ery *battery)
 	 * during the battery module initialization.
 	 */
 	list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list) {
-		if (hook_node->add_battery(battery->bat)) {
-			/*
-			 * The notification of the extensions has failed, to
-			 * prevent further errors we will unload the extension.
-			 */
-			pr_err("error in extension, unloading: %s",
-					hook_node->name);
-			__battery_hook_unregister(hook_node, 0);
-		}
+		hook_node->add_battery(battery->bat);
 	}
 	mutex_unlock(&hook_mutex);
 }
=2D-
2.30.2

