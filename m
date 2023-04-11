Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4FB6DE28E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjDKRdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjDKRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:33:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F308659CA;
        Tue, 11 Apr 2023 10:33:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pc4-20020a17090b3b8400b0024676052044so8806362pjb.1;
        Tue, 11 Apr 2023 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681234414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a+Q+pUWAZRzRKnGB5ZHIXezRq0+Nj1ASM//XuOwm3Pg=;
        b=fnquWY97DKT38k4zy5Hy1EW5YRQI5MpB4aKoRFJ4C49qXfB/Fa/eGNZojf/4NbrsOp
         iWZkam6qNF5ako7kX+aK0CHSPsMn4/Erm5ErLa2XvJU7XAn9IJ3UWD+7XMVKyoeCW3xR
         rFWRN/RXSvnAonE0WpUUQr7XGHQHhK7BKP5rtvDZEZ3MSjQREaQzKp/78PnFXVD+Pn4h
         rsf+Xv/Bzz0kHDQ3LmW9wW5QEFsdq1vj09qdpiGwgST6v16MFEWiM0/6otPzVxRAKmws
         Cym27e+/9x/88LHNklSImMKEkfF05CkWIqtKqmFKJOhw4ZSGcBEmc8YCbNXdhtiQQ7oT
         U6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681234414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+Q+pUWAZRzRKnGB5ZHIXezRq0+Nj1ASM//XuOwm3Pg=;
        b=sVKN58hNTTQD1XT/19R5QjJGg5OSqI8jxveYGvBpJiDf3xbYG3JCY/6LtovXsbLy4h
         F2kKfcNUYSSA1vEy8bHeoCTlVVr6SzdcxGlxORfSy8acMBP29AqpkMK2A5/rcHGXup0P
         BlPe4v0IqqyUS3w6D+N3QYqe39aoh6NjCddU2utuz1fq/OimanDiF1BG/XJeagSc/ACq
         OwtPZLocXglrRw4Baj0U77bk0kvS43JLTy9qwAVdNhfusBxVNK17RtGkpbRpwL1I4y/E
         KTL65Q27qTk6cu25V9pf1EbE7KUG+sVs2L/ob/jc3g6xXsAMCDuprZa887R8Tgjsb22X
         5tVg==
X-Gm-Message-State: AAQBX9c/3jK0KMJNpN6fPq+OeDsU1O9OiEw1eoFr2nFLZivTYzE78lur
        cQ7XT33RLdVbNGHXJKez6CSgLXHExDK02p4+
X-Google-Smtp-Source: AKy350ZGGQhbjBhyKG9uz5Q4X6fGuhDZUtJXykO2rWjC+yQADYv8eiTAsFhcpVUp+ivBx2x9CkbBZg==
X-Received: by 2002:a17:902:fb45:b0:1a2:bf79:9da5 with SMTP id lf5-20020a170902fb4500b001a2bf799da5mr13140719plb.59.1681234414228;
        Tue, 11 Apr 2023 10:33:34 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709026ac200b001a4fecf79e4sm9767344plt.49.2023.04.11.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:33:33 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     David Yang <mmyangfl@gmail.com>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: kye: Fix rdesc for kye tablets
Date:   Wed, 12 Apr 2023 01:33:08 +0800
Message-Id: <20230411173308.422756-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forget to add them in previous commit 2dd438cdc2e9
("HID: kye: Add support for all kye tablets").

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/hid/hid-kye.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index b3bde4bb979d..eb9bf2829937 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -209,7 +209,7 @@ static const __u8 pensketch_t609a_control_rdesc[] = {
 	0xC0               /*  End Collection            */
 };
 
-/* Fix indexes in kye_tablet_report_fixup if you change this */
+/* Fix indexes in kye_tablet_fixup if you change this */
 static const __u8 kye_tablet_rdesc[] = {
 	0x06, 0x00, 0xFF,             /*  Usage Page (FF00h),             */
 	0x09, 0x01,                   /*  Usage (01h),                    */
@@ -493,12 +493,19 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		rdesc = kye_consumer_control_fixup(hdev, rdesc, rsize, 83,
 					"Genius Gx Imperator Keyboard");
 		break;
+	case USB_DEVICE_ID_KYE_EASYPEN_M406:
+	case USB_DEVICE_ID_KYE_EASYPEN_M506:
 	case USB_DEVICE_ID_KYE_EASYPEN_I405X:
 	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X:
-	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
+	case USB_DEVICE_ID_KYE_EASYPEN_M406W:
 	case USB_DEVICE_ID_KYE_EASYPEN_M610X:
-	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
+	case USB_DEVICE_ID_KYE_EASYPEN_340:
 	case USB_DEVICE_ID_KYE_PENSKETCH_M912:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_M508WX:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_M508X:
+	case USB_DEVICE_ID_KYE_EASYPEN_M406XE:
+	case USB_DEVICE_ID_KYE_MOUSEPEN_I608X_V2:
+	case USB_DEVICE_ID_KYE_PENSKETCH_T609A:
 		rdesc = kye_tablet_fixup(hdev, rdesc, rsize);
 		break;
 	}
-- 
2.39.2

