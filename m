Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8ED645C6D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiLGOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLGOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8011C36
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670423084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TmWV6JJXX2IbwOxPwXg6rSo3yOZsgsIg/Im1bYjsqiQ=;
        b=F9RTEVrKM2NK8sY81D7NC70ibe44kmKRFjYeb3eR+GztzbPmUVUybjh/PGq2YN760CErXh
        OocQIs5wEjPpS3g3ZlWrYm0nRpywau4+RjUbDD9ih+AnGSbXalTeZe4s8m59AAVkH47xXk
        Ypn9UFf5Azu58ygLbQTkky5niSAo5qY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-195Ayh0-O2SviCiQ6OnBhQ-1; Wed, 07 Dec 2022 09:24:41 -0500
X-MC-Unique: 195Ayh0-O2SviCiQ6OnBhQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6147E1C0A58E;
        Wed,  7 Dec 2022 14:24:40 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0ECC42027061;
        Wed,  7 Dec 2022 14:24:38 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bastien Nocera <hadess@hadess.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 1/2] Revert "HID: logitech-hidpp: Remove special-casing of Bluetooth devices"
Date:   Wed,  7 Dec 2022 15:24:32 +0100
Message-Id: <20221207142433.1158329-2-benjamin.tissoires@redhat.com>
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

This reverts commit 8544c812e43ab7bdf40458411b83987b8cba924d.

We need to revert commit 532223c8ac57 ("HID: logitech-hidpp: Enable HID++
for all the Logitech Bluetooth devices") because that commit might make
hid-logitech-hidpp bind on mice that are not well enough supported by
hid-logitech-hidpp, and the end result is that the probe of those mice
is now returning -ENODEV, leaving the end user with a dead mouse.

Given that commit 8544c812e43a ("HID: logitech-hidpp: Remove special-casing
of Bluetooth devices") is a direct dependency of 532223c8ac57, revert it
too.

Note that this also adapt according to commit 908d325e1665 ("HID:
logitech-hidpp: Detect hi-res scrolling support") to re-add support of
the devices that were removed from that commit too.

I have locally an MX Master and I tested this device with that revert,
ensuring we still have high-res scrolling.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 9afbc68bf063..f11890f65c06 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4367,6 +4367,15 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
+	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
+	{ /* MX Master mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012) },
+	{ /* MX Ergo trackball over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01d) },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e) },
+	{ /* MX Master 3 mouse over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb023) },
 
 	{ /* And try to enable HID++ for all the Logitech Bluetooth devices */
 	  HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_ANY, USB_VENDOR_ID_LOGITECH, HID_ANY_ID) },
-- 
2.38.1

