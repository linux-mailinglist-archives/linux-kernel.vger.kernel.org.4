Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1687163C9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbjE3OUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbjE3OTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:19:43 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F8E59;
        Tue, 30 May 2023 07:18:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso28677565e9.3;
        Tue, 30 May 2023 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685456300; x=1688048300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVlZv4IjpPagcS+VHOYSJtQKJ9NE7q5BSElLM0HACv0=;
        b=oFzeUk+o8LI4KfFOcfOUKZbbNjemEJafLUaRbDlRkMhaAuHrAkrcZ4CiGOE52leCcj
         WYVN3xq1hOH55Yj7Sbc6ngnuJBWefXzDjg+fpCF/LaaHAjLiIpqTjPCmVnn3u7/E4Kvs
         9l7PmY9FyqH9Pwud1zB57sQLmhlAEYemhaxhUTF3JBR79wooqE75ckjDrlo89Q9MZ15s
         XIcSWj2TPu+1rF42bHAYTfRCiYh8eDgYPrR7FbSUXN/famGXl5VxyRSDnhrCK0h/6E2y
         ha5ZxW5mhua19RvwTL8NKAcu1euPBNN2lcGBEGpnW4toYFsdBZCvJ1mkunWzbKLb+Wcp
         nsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456300; x=1688048300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVlZv4IjpPagcS+VHOYSJtQKJ9NE7q5BSElLM0HACv0=;
        b=BkaxD5BTkeZtNs0CEeYKzV8j4IxWhawbTbQTNHYpLq0zP2IUa2Ymd3uFBOoWyJCnb2
         bh23ByRsDOiorkD8HzbbsAjzMWrixEra0V9yTh7ZWFvL6xG5MgzIyuPGaqKtEGqHtXOw
         Rrns/WpocERp0XRzV5r8m2E6jFkeyFmBEBi0Jsf0R0I4jYPK2cC4ICCcolz4mlljuEc/
         rgh66OxKBvrCqKHx+Q/WBRMSuu2yDv2HzlhhbxfMscaODFVP9X/1m1Cn87io09nityGf
         hRC4OWDlY2yTjqJiTxgdHmiMYH2gIW1OZ0TZLOgST1NWWFUqYANKfg+fFBk9hm4sMGA9
         gyqA==
X-Gm-Message-State: AC+VfDze4/Mbu1Itfgg3OD1nVdKGHCLEsOh8FeKcOJnLSV4ARV4k8CWQ
        MLjq+AIlK0jYW+hwLnyOMiU=
X-Google-Smtp-Source: ACHHUZ7fbWofkLr8DR+0tiiebQDTwMVAH7kGC0nnOcANKAyFWvcTIqbopYQuf7XnmxEPzNUCD6jQMw==
X-Received: by 2002:a7b:ce95:0:b0:3f6:fb2:add4 with SMTP id q21-20020a7bce95000000b003f60fb2add4mr1722676wmj.33.1685456299592;
        Tue, 30 May 2023 07:18:19 -0700 (PDT)
Received: from localhost.localdomain (cpc157791-rdng31-2-0-cust585.15-3.cable.virginm.net. [86.24.214.74])
        by smtp.gmail.com with ESMTPSA id x11-20020a1c7c0b000000b003f50876905dsm17573347wmc.6.2023.05.30.07.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 07:18:19 -0700 (PDT)
From:   Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, jikos@kernel.org,
        Filipe =?ISO-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] HID: logitech-hidpp: Add USB and Bluetooth IDs for the Logitech G915 TKL Keyboard
Date:   Tue, 30 May 2023 15:16:29 +0100
Message-ID: <20230530141628.21290-1-stuart.a.hayhurst@gmail.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8
In-Reply-To: <f395a434756b7f35336b541cdbdb61ef5b6fe0b1.camel@hadess.net>
References: <f395a434756b7f35336b541cdbdb61ef5b6fe0b1.camel@hadess.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard, for device detection
For this device, this provides battery reporting on top of hid-generic

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

