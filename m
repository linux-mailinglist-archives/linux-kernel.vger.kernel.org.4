Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2B6F7811
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 23:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjEDV24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 17:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjEDV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 17:28:48 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA290150F7;
        Thu,  4 May 2023 14:28:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64115e652eeso15590340b3a.0;
        Thu, 04 May 2023 14:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683235712; x=1685827712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKzf5mgdxK8ZWZ/hO2d3mis74L5K1plt3kebtBa9TF4=;
        b=qYGPgaiZ97JRmhW72uxcBIC5sglElbqAHmTiISeGp0hKdNK/vt6h2mOAdg3eeACBhW
         Hcd0cfClqrlvnG1IkC1VCDRPds0wteOy7D24xRfLdi7NmtHfrYNwQw+hqOAMBqtCn0iu
         3nxSGZ9PqD8GCXwypfGeF3F9fUyDV67yMVnJG4cn2Q6hRjnG5bdmBIky2zD+eYZ7ST3U
         ptvvax4FI7hdqUqvT1v79Xf2hRbpqQi2EQgU6CCgglrCD0xh9vLYy6NJxcU7AUCl3Ft4
         ZlMaonNbF0chuJeO2ngh1ejAC4Eduq4K1LHvP8nI6DUrI2NrJ0INiQgtnQDGj343KTrG
         Cw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683235712; x=1685827712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKzf5mgdxK8ZWZ/hO2d3mis74L5K1plt3kebtBa9TF4=;
        b=MRxy5YeCeacDWgZWYj34fqkPfinGr/fBuOLGIbv/OaX0JuP3oJFNQeZTeE1KQy3eJP
         2oQ3TAVeN0pd+NftdEamE5iz+eotHj8DwVfsNQlA/eu0xw+I1p2FOLRGHEF87bNXqnA9
         sg9qYPA4Bg1MbO+Drn6TxQ30APxCWeG28Nw9F1T+UeP8BGc0wETUDDbMEjEeC4Vhqo16
         /aJ1vK0X0Wt2GpI4hX2cVpcbnOyssj5Cst5CXetSrcPFT5gjRSRD4Br0AuYIxC6xZFuG
         GbQGe51iwZYRPaQT+AwEdCz4yrY/yyQzknRBqO2UnIP7vny7FMFQaL4aKBFsRnUJirEc
         X5CA==
X-Gm-Message-State: AC+VfDxmhjvKOL/V7CPXYJfjQ0K/QEsHGeqYyKIP/I+88qtWvwT7D5WT
        0W0J2gavgjsy91Z+BjAI4jwZG0CU0QioFQ==
X-Google-Smtp-Source: ACHHUZ4ZCy/oVjaXBYMXNbkwXWL87CqFddmbdotuPwc/JDDT221Rxmgpp0qqHi6svhFL4T1wfyDweQ==
X-Received: by 2002:a17:902:d483:b0:19a:96ea:3850 with SMTP id c3-20020a170902d48300b0019a96ea3850mr5861490plg.17.1683235712591;
        Thu, 04 May 2023 14:28:32 -0700 (PDT)
Received: from localhost.localdomain ([2600:8801:9701:6a00:daec:5eff:fea8:3a31])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001ab1bb0126fsm1039pls.102.2023.05.04.14.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:28:31 -0700 (PDT)
From:   Dan Gora <dan.gora@gmail.com>
Cc:     Dan Gora <dan.gora@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: btusb: Add device 6655:8771 to device tables.
Date:   Thu,  4 May 2023 14:27:53 -0700
Message-Id: <20230504212752.16179-1-dan.gora@gmail.com>
X-Mailer: git-send-email 2.35.1.102.g2b9c120970
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

