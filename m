Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4140362B2BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 06:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiKPF0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 00:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKPF0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 00:26:39 -0500
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C3B11DF1F;
        Tue, 15 Nov 2022 21:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NmhOh
        Ed2lQ4cWVlPqfBrQSH2YbTj6mqwQTtkBdbx88g=; b=JS0DSjt1k7+VnlABC0SzL
        A0PrLb5qZ8GA81rWgwG07z5mbFoZAVXRRdSUz568UdB435nSFm9NX4CepGp1pjAZ
        smLJgRHPDruyyYkFjNwiyhSm7eRbLg+IBygA+43a76W+XIi8whraaw6xxpzaBkct
        nLrhDmUeqdTX1arZ5q9QDA=
Received: from duke.localdomain (unknown [220.180.239.56])
        by smtp10 (Coremail) with SMTP id DsCowAAHJhxddHRjMf8ENA--.63054S2;
        Wed, 16 Nov 2022 13:25:52 +0800 (CST)
From:   Duke Xin <duke_xinanwen@163.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        jerry.meng@quectel.com, duke.xin@quectel.com,
        Duke Xin <duke_xinanwen@163.com>
Subject: [PATCH]     USB: serial: option: add Quectel EM05-G modem
Date:   Wed, 16 Nov 2022 13:25:37 +0800
Message-Id: <20221116052537.239117-1-duke_xinanwen@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAHJhxddHRjMf8ENA--.63054S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxury5Gw48ArWfKr4rWrW8Xrb_yoWruFy8pw
        48AaySvFyrXF17W3ZIkr1xuFWrKan7Wr47C3ZrZr4fXFZ7Ars3tr1UArZ2qrnF9r4FyF4v
        q398C3yxGFykJFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UQdb8UUUUU=
X-Originating-IP: [220.180.239.56]
X-CM-SenderInfo: 5gxnvsp0lqt0xzhqqiywtou0bp/1tbivgC7e1ZcfbQBbAAAsQ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    The EM05-G modem has 2 USB configurations that are configurable via the AT
    command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
    the following interfaces, respectively:

    "RMNET" : AT + DIAG + NMEA + Modem + QMI
    "MBIM"  : MBIM + AT + DIAG + NMEA + Modem

    The detailed description of the USB configuration for each mode as follows:

    RMNET Mode
    --------------
    T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 21 Spd=480  MxCh= 0
    D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=2c7c ProdID=0311 Rev= 3.18
    S:  Manufacturer=Quectel
    S:  Product=Quectel EM05-G
    C:* #Ifs= 5 Cfg#= 1 Atr=a0 MxPwr=500mA
    I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 6 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
    E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
    E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

    MBIM Mode
    --------------
    T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=480  MxCh= 0
    D:  Ver= 2.00 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
    P:  Vendor=2c7c ProdID=0311 Rev= 3.18
    S:  Manufacturer=Quectel
    S:  Product=Quectel EM05-G
    C:* #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
    A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
    I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
    E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 5 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
    E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
    E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
    E:  Ad=89(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
    I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
    I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
    E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
    E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

Signed-off-by: Duke Xin <duke_xinanwen@163.com>
---
 drivers/usb/serial/option.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 37257a52287d..b740672be0cd 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -253,6 +253,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_BG96			0x0296
 #define QUECTEL_PRODUCT_EP06			0x0306
 #define QUECTEL_PRODUCT_EM05G			0x030a
+#define QUECTEL_PRODUCT_EM05G_SG		0x0311
 #define QUECTEL_PRODUCT_EM060K			0x030b
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
@@ -1151,6 +1152,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06, 0xff, 0, 0) },
 	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G, 0xff),
 	  .driver_info = RSVD(6) | ZLP },
+	{ USB_DEVICE_INTERFACE_CLASS(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM05G_SG, 0xff),/* Quectel EM05G  smart gateway*/
+	  .driver_info = RSVD(6) | ZLP },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM060K, 0xff, 0xff, 0x40) },
-- 
2.34.1

