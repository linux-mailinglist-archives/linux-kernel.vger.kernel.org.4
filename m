Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07CD7164B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjE3OqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjE3OqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:46:20 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50959C;
        Tue, 30 May 2023 07:46:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so4640418f8f.1;
        Tue, 30 May 2023 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685457974; x=1688049974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3y1medTyj/hZKdN9AO+Oz7IaxQHqeigKWyUw6axzy28=;
        b=TlWu7lDHzDInHB21R9hoHJEBNVqOQIuiRjEGKteI1jepyktLsKA7yEmkRvOuNBQ/x6
         V8W4WqSkHhMamOx3/y3MaXMdbfNYyVeeAVedLX9yleyjlPAnRzduRd+9svCu68L+GiNR
         qcvmuvn/RMiJPmtTTrS6mKBWw+PJYJFNQ4op+uKruKCmZ+rOFNQ0BjmfexCW7qN5GsI6
         8WfDv0cD7PUPhVFheBpdCY/IyzPLPvZTrIkOvX92pjl28ivoIx6yMBoKe/ayxjssRndy
         iQSHVdBEkMdXQESy3iEvAtmlgdCJJixP3FHf7nu7d52FO9a2y5IBwBe+8heDO5qr3M8Y
         dWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685457974; x=1688049974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3y1medTyj/hZKdN9AO+Oz7IaxQHqeigKWyUw6axzy28=;
        b=EId4/zbtP78oQCIap6EgA5sygN1ZLZXr0CBIEvk+25WYpI0t+FzUGWIhdmaaHWnPEV
         8IC4JA3HCD6bwVoOeL3nIz/ZmwtwURrPjLEbj+pXqzpvV3eCvyF5fPDytnF/noMfgF3B
         +5BXFMrzm/x3TrPwstLhxk9tfybA3z15SQT7GnugUrpplQST7PSJxyBbv0YGEyZIoX/L
         HhszWYaYzPTGaRjKQdDpFl21kljMRNURnMIoQFdO+xeHZ/mEJ27Qwq0GdgqY/25wgoWH
         e+HTneQ7sO/yTVPXykk9qE6Z0WKPxYknmCyi3ZCw/MKkNn5tqwibL2hfDkf9GmY03zNn
         8VEg==
X-Gm-Message-State: AC+VfDxmmb9Q+MQMP5UtKlEhsQxN6X8xcAcC9Ui8VE/vF9U5wA+QKHFU
        Lg+lRh3gESeZJ000DVbtMKc=
X-Google-Smtp-Source: ACHHUZ4kUtwOKbIB/YZ19q9WmcPWqc/0MZVoBTLQm/OPDHomYVxgUd6RIkcLDTCHdbaEfL7fQootCQ==
X-Received: by 2002:a5d:4d02:0:b0:30a:e369:5acb with SMTP id z2-20020a5d4d02000000b0030ae3695acbmr1661065wrt.68.1685457974073;
        Tue, 30 May 2023 07:46:14 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id d1-20020adfe881000000b0030631a599a0sm3573136wrm.24.2023.05.30.07.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:46:13 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
Cc:     stuarthayhurst <stuart.a.hayhurst@gmail.com>, jikos@kernel.org,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH v2] HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard
Date:   Tue, 30 May 2023 15:44:28 +0100
Message-ID: <20230530144427.24732-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: stuarthayhurst <stuart.a.hayhurst@gmail.com>

Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard, for device detection
For this device, this provides battery reporting on top of hid-generic

Reviewed-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b2cd7527de19..28761272afe5 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4403,6 +4403,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC086) },
 	{ /* Logitech G903 Hero Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC091) },
+	{ /* Logitech G915 TKL Keyboard over USB */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC343) },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
@@ -4418,6 +4420,8 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* MX5500 keyboard over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
 	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
+	{ /* Logitech G915 TKL keyboard over Bluetooth */
+	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb35f) },
 	{ /* M-RCQ142 V470 Cordless Laser Mouse over Bluetooth */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb008) },
 	{ /* MX Master mouse over Bluetooth */
-- 
2.40.1.521.gf1e218fcd8

