Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6625B7F1E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiINC4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 22:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiINCzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 22:55:55 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0AC6581D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 19:55:54 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D8C102C03F8;
        Wed, 14 Sep 2022 02:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1663124149;
        bh=ZdCf/uEINP4sMWRX8cydklOxtePbiaCgIXoI0pFMD18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtVKPux1e8HtIQGCayE69cyk3pPMQR9vUQTErY/kavCeUd00s/mNoTQefNz5YSRWn
         UiiuqE4+l/DcSJyVR5lxNKj4w30WyREp2lbfBFXsJ4xdhVUvWQTfaKw8hMcbe1Srva
         czM2N2CyzZy0/YZbhkdi3T5M5/YhrFKKJsoXl1quXGTOnnVNIqqO+GD0umr81290tl
         0zAc4wATmR3p+Afbf3do9ZusL0BuwLZaEroT1kYe7sF4VjQyYli4U/l2RqdPhfKlHp
         wB6L9LgDR6/QH8tuC3FRqCgjrmvh703XA8uUoo4s3K8wiG08LvaASmBtkVOLvKJFX+
         kjnqLaEGFmBVA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B632142b50001>; Wed, 14 Sep 2022 14:55:49 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id B978913ECD2;
        Wed, 14 Sep 2022 14:55:49 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id B765F2A00E3; Wed, 14 Sep 2022 14:55:49 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     hyamamo@allied-telesis.co.jp, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] USB: serial: option: add support for NetIndex UX302NC
Date:   Wed, 14 Sep 2022 14:55:40 +1200
Message-Id: <20220914025541.1018233-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
References: <20220914025541.1018233-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=eJVtc0h1 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=xOM3xZuef0cA:10 a=03SyitcPeJqX8Ewl_NEA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the following USB Modem

usb 1-1: new high-speed USB device number 3 using xhci-hcd
usb 1-1: New USB device found, idVendor=3D11f6, idProduct=3D1034
usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=3D3
usb 1-1: Product: NCXX UX302NC
usb 1-1: Manufacturer: NCXX Inc.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index a5e8374a8d71..2065f0fb2fa0 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -580,6 +580,9 @@ static void option_instat_callback(struct urb *urb);
 #define OPPO_VENDOR_ID				0x22d9
 #define OPPO_PRODUCT_R11			0x276c
=20
+/* NetIndex */
+#define NETINDEX_VENDOR_ID			0x11f6
+#define NETINDEX_PRODUCT_UX302NC		0x1034
=20
 /* Device flags */
=20
@@ -2170,6 +2173,7 @@ static const struct usb_device_id option_ids[] =3D =
{
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM50=
0 MBIM */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1406, 0xff) },			/* GosunCn GM50=
0 ECM/NCM */
 	{ USB_DEVICE_AND_INTERFACE_INFO(OPPO_VENDOR_ID, OPPO_PRODUCT_R11, 0xff,=
 0xff, 0x30) },
+	{ USB_DEVICE(NETINDEX_VENDOR_ID, NETINDEX_PRODUCT_UX302NC) }, /* NCXX U=
X302NC */
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
--=20
2.37.3

