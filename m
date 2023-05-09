Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E346FCEB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 21:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjEITry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjEITrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 15:47:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED20C30D1;
        Tue,  9 May 2023 12:47:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-24dfc3c662eso4375526a91.3;
        Tue, 09 May 2023 12:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683661670; x=1686253670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKzf5mgdxK8ZWZ/hO2d3mis74L5K1plt3kebtBa9TF4=;
        b=ekd0u3Fr0m0HR7sZSmxEetLOwjAjzsUEojdiWOM+/VPseNPPmAXG0AUmFDb/SdsmgD
         CiKmYVdlh5ZJrPv3MzD5SrPdI6avcpy0K5XysvIb2R6vwhFGv26vMZa+pjbTgQlxwQM/
         yxFKlVk8U2JxiDtNK0qIQv8odd6YJCReiS58hHa0fB4yL5zQi3secrN6YgR55CWN+2h0
         Y9ay7k678T86Skl3vJiFO6YL6tySYA/vVjS82D1sYp99AUaPjJTengHwUQNqDXsCiYIU
         f1fWwR51mv1S7IwkJC10ge3kOH3RzxnuNmhzXhRpfaNwsCRQSCjEDJR0rzYg+iWIKT+O
         uVjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683661670; x=1686253670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fKzf5mgdxK8ZWZ/hO2d3mis74L5K1plt3kebtBa9TF4=;
        b=gxytdp0GRaJwJCcRGlrLcJFXxm1oiMV4NuwsPJh2/U8gtpZADDvOU4ny9dFRmTX/30
         Rgg72qjOREpxVqrgX5ZMtmYPnrK5YpT7LEL2T249368SsahQLFKBOpN/CH3JyW5pEvrz
         g3g0gfCYobCAKw39/w9DheYDsUJ4/g6GGuHasv1XVMvppnf5qOxbyINN2Eu2CJQ7eqSD
         NJVwDMeXF9e2g0BE/QvuoDzAKgxKWBZyUXEs9M5WJelWMMc13dqH2v79xD08i3DArmmk
         mNXuJs4PnK8M5Eekq1it5L0lAgOpivHTOlNFduGb6oIff2CV/qSCzipu8ThjGtYeCGC1
         nO/A==
X-Gm-Message-State: AC+VfDzcLW+Mm+DQe/RTl6G6QReDp92wLtPt4dw+7rJQo25+s6jG/ZBJ
        CIlHJQoOzyj1FuP3xju23XxLF4qeb3TD2w==
X-Google-Smtp-Source: ACHHUZ7KIV3SyQK+VdPAYMMmngEEL//oQSdRSG2h8o5g6WRhet+hcdlt4P44jaQNbD2qohQwqZn9ng==
X-Received: by 2002:a17:90b:3e82:b0:23f:1165:b49f with SMTP id rj2-20020a17090b3e8200b0023f1165b49fmr14266043pjb.38.1683661670233;
        Tue, 09 May 2023 12:47:50 -0700 (PDT)
Received: from localhost.localdomain (ip70-179-44-160.sd.sd.cox.net. [70.179.44.160])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090a1c0100b0024e11f31012sm12704346pjs.5.2023.05.09.12.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:47:49 -0700 (PDT)
From:   Dan Gora <dan.gora@gmail.com>
Cc:     Dan Gora <dan.gora@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] Bluetooth: btusb: Add device 6655:8771 to device tables
Date:   Tue,  9 May 2023 12:45:24 -0700
Message-Id: <20230509194524.9361-1-dan.gora@gmail.com>
X-Mailer: git-send-email 2.35.1.102.g2b9c120970
In-Reply-To: <20230504212843.18519-1-dan.gora@gmail.com>
References: <20230504212843.18519-1-dan.gora@gmail.com>
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

This device is an Inspire branded BT 5.1 USB dongle with a
Realtek RTL8761BU chip using the "Best Buy China" vendor ID.

The device table is as follows:

T:  Bus=01 Lev=01 Prnt=02 Port=09 Cnt=01 Dev#=  7 Spd=12   MxCh= 0
D:  Ver= 1.10 Cls=e0(wlcon) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=6655 ProdID=8771 Rev=02.00
S:  Manufacturer=Realtek
S:  Product=Bluetooth Radio
S:  SerialNumber=00E04C239987
C:  #Ifs= 2 Cfg#= 1 Atr=e0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(wlcon) Sub=01 Prot=01 Driver=btusb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms

Signed-off-by: Dan Gora <dan.gora@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a8e2bb038f5..0b0a02cf0d4a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -655,6 +655,8 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0bda, 0x8771), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x6655, 0x8771), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x7392, 0xc611), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x2b89, 0x8761), .driver_info = BTUSB_REALTEK |
-- 
2.35.1.102.g2b9c120970

