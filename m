Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35FC74A3D0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGFSb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGFSby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:31:54 -0400
X-Greylist: delayed 84 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 11:31:02 PDT
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8790D1BFF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1688668261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i6byuPgD0BdV+edMY+7xoBI+stlHVgHroGrstvZaliE=;
        b=NYNIXWBKf74CNt9iQqkDQygusfeSVV6ed3w9/9TJQQU32OvJ6Oxa77utJQD8LTNDTbe1uK
        bgnRq4q4OloFLYdGWbV9Wv3iggYnh9JsWkSW3VZbPcRpyLg1Dw33OvcGSDD2CqDST5oizA
        kcZF5WOwsQu8WtP9RJd4rlDphYLYhqY=
Received: from g1t6220.austin.hp.com (g1t6220.austin.hp.com [15.73.96.84])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-YG3C5vQoPEWLGQiUhrdSxA-1; Thu, 06 Jul 2023 14:29:35 -0400
X-MC-Unique: YG3C5vQoPEWLGQiUhrdSxA-1
Received: from g1t6217.austin.hpicorp.net (g1t6217.austin.hpicorp.net [15.67.1.144])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g1t6220.austin.hp.com (Postfix) with ESMTPS id C072C23B;
        Thu,  6 Jul 2023 18:29:33 +0000 (UTC)
Received: from jam-buntu.lan (unknown [15.74.50.248])
        by g1t6217.austin.hpicorp.net (Postfix) with ESMTP id 516B189;
        Thu,  6 Jul 2023 18:29:32 +0000 (UTC)
From:   Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To:     linux-usb@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, hayeswang@realtek.com, jflf_kernel@gmx.com,
        bjorn@mork.no, svenva@chromium.org, linux-kernel@vger.kernel.org,
        eniac-xw.zhang@hp.com,
        Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
        stable@vger.kernel.org
Subject: [PATCH] r8152: Suspend USB device before shutdown when WoL is enabled
Date:   Thu,  6 Jul 2023 18:28:58 +0000
Message-Id: <20230706182858.761311-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
in U3 state. If it is not, and the host "disappears", the chip will
no longer respond to WoL triggers.

To resolve this, add a notifier block and register it as a reboot
notifier. When WoL is enabled, work through the usb_device struct to
get to the suspend function. Calling this function puts the link in
the correct state for WoL to function.

Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/net/usb/r8152.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0999a58ca9d2..5623ca5c9142 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -20,6 +20,7 @@
 #include <net/ip6_checksum.h>
 #include <uapi/linux/mdio.h>
 #include <linux/mdio.h>
+#include <linux/reboot.h>
 #include <linux/usb/cdc.h>
 #include <linux/suspend.h>
 #include <linux/atomic.h>
@@ -875,6 +876,7 @@ struct r8152 {
 =09struct delayed_work schedule, hw_phy_work;
 =09struct mii_if_info mii;
 =09struct mutex control;=09/* use for hw setting */
+=09struct notifier_block reboot_notifier;
 #ifdef CONFIG_PM_SLEEP
 =09struct notifier_block pm_notifier;
 #endif
@@ -9609,6 +9611,25 @@ static bool rtl8152_supports_lenovo_macpassthru(stru=
ct usb_device *udev)
 =09return 0;
 }
=20
+/* Suspend realtek chip before system shutdown
+ *
+ * For Wake-on-LAN to work from S5, the USB link must be put in U3 state. =
If
+ * the host otherwise "disappears", the chip will not respond to WoL trigg=
ers.
+ */
+static int rtl8152_notify(struct notifier_block *nb, unsigned long code,
+=09=09=09  void *unused)
+{
+=09struct r8152 *tp =3D container_of(nb, struct r8152, reboot_notifier);
+=09struct device *dev =3D &tp->udev->dev;
+
+=09if (code =3D=3D SYS_POWER_OFF) {
+=09=09if (tp->saved_wolopts && dev->type->pm->suspend)
+=09=09=09dev->type->pm->suspend(dev);
+=09}
+
+=09return NOTIFY_DONE;
+}
+
 static int rtl8152_probe(struct usb_interface *intf,
 =09=09=09 const struct usb_device_id *id)
 {
@@ -9791,6 +9812,9 @@ static int rtl8152_probe(struct usb_interface *intf,
 =09else
 =09=09device_set_wakeup_enable(&udev->dev, false);
=20
+=09tp->reboot_notifier.notifier_call =3D rtl8152_notify;
+=09register_reboot_notifier(&tp->reboot_notifier);
+
 =09netif_info(tp, probe, netdev, "%s\n", DRIVER_VERSION);
=20
 =09return 0;
@@ -9811,6 +9835,7 @@ static void rtl8152_disconnect(struct usb_interface *=
intf)
 =09if (tp) {
 =09=09rtl_set_unplug(tp);
=20
+=09=09unregister_reboot_notifier(&tp->reboot_notifier);
 =09=09unregister_netdev(tp->netdev);
 =09=09tasklet_kill(&tp->tx_tl);
 =09=09cancel_delayed_work_sync(&tp->hw_phy_work);
--=20
2.39.1

