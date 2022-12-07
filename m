Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F4B645C79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLGO0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiLGOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:25:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECD1147F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670423083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9NVnDQLtbjn77YDKLnB8ntVnNNT30a6KgFCsUYPTGIE=;
        b=fJSsYcnHqCqYAdlfUbFNDgqxgSTyDDNisUfxOir31Gzl2SMeBWDwFnyKBTGL8BGI1F7pWl
        H9edR9BNCt4YmYvB7xt/F259hVPxQ1S0bhr6oUMa3DmSUGKjef8Q/WrEAX30+yBM+L7sBN
        kZf2bZT9uItqIPpww/BpWND68BpfVDI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-oEbsQfYbN1WcYW-T-XkgdQ-1; Wed, 07 Dec 2022 09:24:42 -0500
X-MC-Unique: oEbsQfYbN1WcYW-T-XkgdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFEB83C10EC8;
        Wed,  7 Dec 2022 14:24:41 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A29F22027061;
        Wed,  7 Dec 2022 14:24:40 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bastien Nocera <hadess@hadess.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 2/2] Revert "HID: logitech-hidpp: Enable HID++ for all the Logitech Bluetooth devices"
Date:   Wed,  7 Dec 2022 15:24:33 +0100
Message-Id: <20221207142433.1158329-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20221207142433.1158329-1-benjamin.tissoires@redhat.com>
References: <20221207142433.1158329-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 532223c8ac57605a10e46dc0ab23dcf01c9acb43.

As reported in [0], hid-logitech-hidpp now binds on all bluetooth mice,
but there are corner cases where hid-logitech-hidpp just gives up on
the mouse. This leads the end user with a dead mouse.

Given that we are at -rc8, we are definitively too late to find a proper
fix. We already identified 2 issues less than 24 hours after the bug
report. One in that ->match() was never designed to be used anywhere else
than in hid-generic, and the other that hid-logitech-hidpp has corner
cases where it gives up on devices it is not supposed to.

So we have no choice but postpone this patch to the next kernel release.

[0] https://lore.kernel.org/linux-input/CAJZ5v0g-_o4AqMgNwihCb0jrwrcJZfRrX=jv8aH54WNKO7QB8A@mail.gmail.com/

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f11890f65c06..c6e4a96e882e 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4269,21 +4269,6 @@ static void hidpp_remove(struct hid_device *hdev)
 	mutex_destroy(&hidpp->send_mutex);
 }
 
-static const struct hid_device_id unhandled_hidpp_devices[] = {
-	/* Logitech Harmony Adapter for PS3, handled in hid-sony */
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_HARMONY_PS3) },
-	/* Handled in hid-generic */
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_DINOVO_EDGE_KBD) },
-	{}
-};
-
-static bool hidpp_match(struct hid_device *hdev,
-			bool ignore_special_driver)
-{
-	/* Refuse to handle devices handled by other HID drivers */
-	return !hid_match_id(hdev, unhandled_hidpp_devices);
-}
-
 #define LDJ_DEVICE(product) \
 	HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE, \
 		   USB_VENDOR_ID_LOGITECH, (product))
@@ -4376,9 +4361,6 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e) },
 	{ /* MX Master 3 mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
-
-	{ /* And try to enable HID++ for all the Logitech Bluetooth devices */
-	  HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_ANY, USB_VENDOR_ID_LOGITECH, HID_ANY_ID) },
 	{}
 };
 
@@ -4392,7 +4374,6 @@ static const struct hid_usage_id hidpp_usages[] = {
 static struct hid_driver hidpp_driver = {
 	.name = "logitech-hidpp-device",
 	.id_table = hidpp_devices,
-	.match = hidpp_match,
 	.report_fixup = hidpp_report_fixup,
 	.probe = hidpp_probe,
 	.remove = hidpp_remove,
-- 
2.38.1

