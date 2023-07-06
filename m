Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC174A43B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbjGFTKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGFTKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:10:52 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0D41BDB;
        Thu,  6 Jul 2023 12:10:50 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b703a0453fso16480101fa.3;
        Thu, 06 Jul 2023 12:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688670648; x=1691262648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaYfKa6Jro6TyMSU8O8QMq0cvfghUSw2v0aXm5AsGyI=;
        b=Zb5tqU20H7U7WHqC2bsIR6kB6jwW9Xe7+FOAfpNI7vdm2mOjMUvwKFXT+7k5JoKPWi
         hFQBLekuMv76Kh1qNltsjxj5h2B75mEx4VDlV9vRHHWwYirUDhgBQBAv8AJrsnO1EGsN
         XIQT3gfo0jc3/nX5JWVvlGKOChHHDauTDS6GRm5gIHEhDDPYNUCcKb5syn0p4xLmf/Uo
         No7djShnoGOaQiQnxH5BnEhvt2Pu4zWlAZGAY3zqqxjAco+dlAKaFAoU9Xu4h75RCpPQ
         V7TvhwyxDaJRizIFofH4XUdODPtZR0ybIlYzSM6WWxYYyKIZuOQsN7kMms8+i4CaUC2E
         6fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670648; x=1691262648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaYfKa6Jro6TyMSU8O8QMq0cvfghUSw2v0aXm5AsGyI=;
        b=OPAXryl8WDf3iaOI4dFaym6argHUOVuXQ3hawX+gvkszt1/pFwMi43m0Aj5W7Ptzwo
         sqkVXFvkeUtH59EhyWDw0MwP03KCkBpvXmSnZUwltHV5RU7552xJcrFhN76wHduaTpEe
         wA9F2JSzSl28NDhLSvbNGF2D73KSIaKfPhvefJzrrwzzZFx+I0aXNyjG/fBtu9ExvvX0
         ZboS3WWiJ4kml0o1uzfix4/lUia0j6unhOGASpdzJlbl8gfCAc2ZAmZnQ2nWatb4Z4+m
         kReajloaoIfVjPqaxBOeUJoX9mSaURbdE0kiFo8BgqE1C6bxDfwlxrkIqS4Ww4rz/08f
         uHKA==
X-Gm-Message-State: ABy/qLZ2MtHigXRB91OzsW+KATT7lzmNsut0d0KvmvPqihKMotSMQkcc
        1Fz3wna45WHKdCdghzYmIbc=
X-Google-Smtp-Source: APBJJlH4o9qgApaB3xb6gLdGi0pqv8JAUlkH3nnofKAb4ErX5/bvZOfRIwYIUpqRlSXYIgnjr4MV5Q==
X-Received: by 2002:a2e:b045:0:b0:2b6:e618:b597 with SMTP id d5-20020a2eb045000000b002b6e618b597mr2647318ljl.28.1688670648002;
        Thu, 06 Jul 2023 12:10:48 -0700 (PDT)
Received: from valmont.froyen.eu ([2a01:799:ba5:6500::80f])
        by smtp.gmail.com with ESMTPSA id p15-20020a2e804f000000b002b6a32e21casm441611ljg.40.2023.07.06.12.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:10:47 -0700 (PDT)
From:   Valentin David <valentin.david@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Valentin David <valentin.david@gmail.com>
Subject: [PATCH v2] Bluetooth: btusb: Add device 0489:e0f5 as MT7922 device
Date:   Thu,  6 Jul 2023 21:10:18 +0200
Message-ID: <20230706191035.736632-1-valentin.david@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702210138.226929-1-valentin.david@gmail.com>
References: <20230702210138.226929-1-valentin.david@gmail.com>
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

Signed-off-by: Valentin David <valentin.david@gmail.com>
---
v2: Add the missing sign-off in commit message
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

