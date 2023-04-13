Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BB96E169D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDMVoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjDMVog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:44:36 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD53A5ED;
        Thu, 13 Apr 2023 14:44:34 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33DLiNq2101018;
        Thu, 13 Apr 2023 16:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681422263;
        bh=QMLoHs3s4zc8lSfEi22hkRinZpYk4eyS952mdBTg8eY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kX4cg9zDIFP0kRugv1VJwo4UuJnY3AGydYrVFQ0CDWU4donMOzJwwSFvFpiczC2Ux
         qcVLoI6ocAkRommn5xRxQUIkpXXE4vj5Eb2BLNuuQIxuC+iWgMZOuHK6Sf1i5tuK1T
         QBMpkxZZk/P07/d3sDrzqW7H96BWujmdqJk3mJNU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33DLiNeQ023452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Apr 2023 16:44:23 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 13
 Apr 2023 16:44:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 13 Apr 2023 16:44:23 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33DLiMHC125333;
        Thu, 13 Apr 2023 16:44:22 -0500
From:   Andrew Davis <afd@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 2/2] serial: 8250_exar: Add support for USR298x PCI Modems
Date:   Thu, 13 Apr 2023 16:44:21 -0500
Message-ID: <20230413214421.6251-2-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413214421.6251-1-afd@ti.com>
References: <20230413214421.6251-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Possibly the last PCI controller-based (i.e. not a soft/winmodem)
dial-up modem one can still buy.

Looks to have a stock XR17C154 PCI UART chip for communication, but for
some reason when provisioning the PCI IDs they swapped the vendor and
subvendor IDs. Otherwise this card would have worked out of the box.

Searching online, some folks seem to not have this issue and others do,
so it is possible only some batches of cards have this error.

Create a new macro to handle the switched IDs and add support here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/tty/serial/8250/8250_exar.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 878d87f4202bd..9792db550f8cb 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -40,9 +40,13 @@
 #define PCI_DEVICE_ID_COMMTECH_4224PCIE		0x0020
 #define PCI_DEVICE_ID_COMMTECH_4228PCIE		0x0021
 #define PCI_DEVICE_ID_COMMTECH_4222PCIE		0x0022
+
 #define PCI_DEVICE_ID_EXAR_XR17V4358		0x4358
 #define PCI_DEVICE_ID_EXAR_XR17V8358		0x8358
 
+#define PCI_SUBDEVICE_ID_USR_2980		0x0128
+#define PCI_SUBDEVICE_ID_USR_2981		0x0129
+
 #define PCI_DEVICE_ID_SEALEVEL_710xC		0x1001
 #define PCI_DEVICE_ID_SEALEVEL_720xC		0x1002
 #define PCI_DEVICE_ID_SEALEVEL_740xC		0x1004
@@ -827,6 +831,15 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd			\
 	}
 
+#define USR_DEVICE(devid, sdevid, bd) {			\
+	PCI_DEVICE_SUB(					\
+		PCI_VENDOR_ID_USR,			\
+		PCI_DEVICE_ID_EXAR_##devid,		\
+		PCI_VENDOR_ID_EXAR,			\
+		PCI_SUBDEVICE_ID_USR_##sdevid), 0, 0,	\
+		(kernel_ulong_t)&bd			\
+	}
+
 static const struct pci_device_id exar_pci_tbl[] = {
 	/* ACCES I/O Products */
 	{ PCI_DEVICE_DATA(ACCESSIO, COM_2S, &pbn_exar_XR17C15x) },
@@ -852,6 +865,10 @@ static const struct pci_device_id exar_pci_tbl[] = {
 
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
 
+	/* USRobotics USR298x-OEM PCI Modems */
+	USR_DEVICE(XR17C152, 2980, pbn_exar_XR17C15x),
+	USR_DEVICE(XR17C152, 2981, pbn_exar_XR17C15x),
+
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
 	{ PCI_DEVICE_DATA(EXAR, XR17C152, &pbn_exar_XR17C15x) },
 	{ PCI_DEVICE_DATA(EXAR, XR17C154, &pbn_exar_XR17C15x) },
-- 
2.39.2

