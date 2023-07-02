Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102CF74526C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 23:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGBVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGBVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 17:01:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0C6E50;
        Sun,  2 Jul 2023 14:01:49 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso59676531fa.0;
        Sun, 02 Jul 2023 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688331708; x=1690923708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPrwKD2vC5NS8xYzadC5R8793tIJJPfKOj8ZgAaE1/8=;
        b=fcEdYIVFqtV3ksnfrhdmkh8b5pYRZIeLox+CAPwKYwhOa8E4xx1oT8Q8G6uB/2Zqwl
         yZ09vfF0DZPP1VlkBnQaHwqIoSjU8HLnAc+yif5GoJHtJFGsbXT5YAGMwWc1U2dW3jnP
         b6qDyabpl0zgvJuN5bscvMMhEKop6dESTw7m5UrqCxTDjXJoXfjx0pGDsFKhHhH4hdrh
         KVSekeYvFV1P7v6gpFDW13eW/oLfg7WpIr5fOYrV1BUb4kruYk8H9K0aY7+GZM7/Y4/x
         ZYbMATfTuUes7b+1UEPNJrQfE4/FD1iuPR+KA1XPynRy/sImQD23y+/UO4Ks52ykd0K3
         2+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688331708; x=1690923708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPrwKD2vC5NS8xYzadC5R8793tIJJPfKOj8ZgAaE1/8=;
        b=E4rt3HxgUrjFgIo6yw0377bSG8hBXXCp3EvM03KFR3HGaISbOwQXdTMFe8QGqhvw4C
         jqlgAq465n2OXJnFKFikNqtsv6ulaEwfSSuWkGuqdaINUDF8WlXLv/lDDSOfXqylQVj4
         VZx72/n4dTJSJqN3AtkndQSJxRh+tNKFp+g1Eep9nbaQo8oBpjxX2/ojQYeba3bJk9S7
         4eNvLga0pqn6yEyWEGVRdLae5L8NBX96qkJfGQ+8AG1a8juSzpXGsavYOO9ho/WsP9kZ
         W+08gvE7nVhDoQsQm8l82eiyA3yPXH0KNRf2308bXgAgqx0peZokhjdWc80kP8BX0EWo
         sFKA==
X-Gm-Message-State: ABy/qLbrwlbUFHqfq4gKMrJUATICCd/GLz0IPGibak7ciPC4niz+9bld
        TXy+CV/y1JdhX28Q8k/TmCCxdT1QXGOxL2Zn
X-Google-Smtp-Source: APBJJlF/l24lgW6oXkxIU6vVYWv/TCFoLr2NIpLZXKneI0vSTz7FRtG87gjBS1C1VYnU8uBED4fsnw==
X-Received: by 2002:a19:ca42:0:b0:4f8:54f3:a6c0 with SMTP id h2-20020a19ca42000000b004f854f3a6c0mr4329909lfj.11.1688331707744;
        Sun, 02 Jul 2023 14:01:47 -0700 (PDT)
Received: from valmont.froyen.eu ([2a01:799:ba5:6500::80f])
        by smtp.gmail.com with ESMTPSA id w5-20020a05651204c500b004fbae51d1a5sm776018lfq.295.2023.07.02.14.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 14:01:47 -0700 (PDT)
From:   Valentin David <valentin.david@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        valentin.david@gmail.com
Subject: [PATCH] Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
Date:   Sun,  2 Jul 2023 23:01:38 +0200
Message-ID: <20230702210138.226929-1-valentin.david@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Asus ROG Ally gaming computer has a MediaTek MT7922 chip that uses USB id
0489:e0f5 and needs to be added to the table. Without this, the device is
not usable and gives the following error:

Bluetooth: hci0: Opcode 0x c03 failed: -110

Output from /sys/kernel/debug/usb/devices:

T:  Bus=01 Lev=01 Prnt=01 Port=03 Cnt=03 Dev#=  4 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0489 ProdID=e0f5 Rev= 1.00
S:  Manufacturer=MediaTek Inc.
S:  Product=Wireless_Device
S:  SerialNumber=000000000
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=100mA
A:  FirstIf#= 0 IfCount= 3 Cls=e0(wlcon) Sub=01 Prot=01
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=125us
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 1 Alt= 6 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  63 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  63 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS=  64 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS=  64 Ivl=125us
I:  If#= 2 Alt= 1 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=(none)
E:  Ad=8a(I) Atr=03(Int.) MxPS= 512 Ivl=125us
E:  Ad=0a(O) Atr=03(Int.) MxPS= 512 Ivl=125us
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a8e2bb038f5..b36967205de6 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -625,6 +625,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0f2), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 
 	/* Additional Realtek 8723AE Bluetooth devices */
 	{ USB_DEVICE(0x0930, 0x021d), .driver_info = BTUSB_REALTEK },
-- 
2.41.0

