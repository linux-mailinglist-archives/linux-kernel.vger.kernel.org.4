Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF566E169B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjDMVoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDMVob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 17:44:31 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6144C40E8;
        Thu, 13 Apr 2023 14:44:28 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33DLiNDE012174;
        Thu, 13 Apr 2023 16:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681422263;
        bh=+KwEykf/fDBcG6usYlndFSM6e9C6z2Bqai8vh0oE75o=;
        h=From:To:CC:Subject:Date;
        b=RzGr2fm2eelmrGrFPIcllmEkdj7Y1ym4DOBYMiLOFhlcbAvEdzLLE4Oi4ePttW7M9
         vXcOXRWcmTKnmZ3153cJekntLBdkyElMOoN4k89zIcoXb9fn3jgOjgONxXG729766X
         3UcgfnkiRSZZk9008rqIW2Y6+6UkC3ZEHfixne30=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33DLiNC8086957
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Apr 2023 16:44:23 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 13
 Apr 2023 16:44:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 13 Apr 2023 16:44:22 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33DLiMHB125333;
        Thu, 13 Apr 2023 16:44:22 -0500
From:   Andrew Davis <afd@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] serial: 8250_exar: Use PCI_DEVICE_DATA macro directly
Date:   Thu, 13 Apr 2023 16:44:20 -0500
Message-ID: <20230413214421.6251-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
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

The EXAR_DEVICE macro was converted to use PCI_DEVICE_DATA, having
this macro at doesn't add much, remove it.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/tty/serial/8250/8250_exar.c | 65 +++++++++++++++--------------
 1 file changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 64770c62bbec5..878d87f4202bd 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -818,8 +818,6 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 		(kernel_ulong_t)&bd					\
 	}
 
-#define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) }
-
 #define IBM_DEVICE(devid, sdevid, bd) {			\
 	PCI_DEVICE_SUB(					\
 		PCI_VENDOR_ID_EXAR,			\
@@ -830,13 +828,14 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
 	}
 
 static const struct pci_device_id exar_pci_tbl[] = {
-	EXAR_DEVICE(ACCESSIO, COM_2S, pbn_exar_XR17C15x),
-	EXAR_DEVICE(ACCESSIO, COM_4S, pbn_exar_XR17C15x),
-	EXAR_DEVICE(ACCESSIO, COM_8S, pbn_exar_XR17C15x),
-	EXAR_DEVICE(ACCESSIO, COM232_8, pbn_exar_XR17C15x),
-	EXAR_DEVICE(ACCESSIO, COM_2SM, pbn_exar_XR17C15x),
-	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
-	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),
+	/* ACCES I/O Products */
+	{ PCI_DEVICE_DATA(ACCESSIO, COM_2S, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(ACCESSIO, COM_4S, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(ACCESSIO, COM_8S, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(ACCESSIO, COM232_8, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(ACCESSIO, COM_2SM, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(ACCESSIO, COM_4SM, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(ACCESSIO, COM_8SM, &pbn_exar_XR17C15x) },
 
 	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
 	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
@@ -854,30 +853,34 @@ static const struct pci_device_id exar_pci_tbl[] = {
 	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
 
 	/* Exar Corp. XR17C15[248] Dual/Quad/Octal UART */
-	EXAR_DEVICE(EXAR, XR17C152, pbn_exar_XR17C15x),
-	EXAR_DEVICE(EXAR, XR17C154, pbn_exar_XR17C15x),
-	EXAR_DEVICE(EXAR, XR17C158, pbn_exar_XR17C15x),
+	{ PCI_DEVICE_DATA(EXAR, XR17C152, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(EXAR, XR17C154, &pbn_exar_XR17C15x) },
+	{ PCI_DEVICE_DATA(EXAR, XR17C158, &pbn_exar_XR17C15x) },
 
 	/* Exar Corp. XR17V[48]35[248] Dual/Quad/Octal/Hexa PCIe UARTs */
-	EXAR_DEVICE(EXAR, XR17V352, pbn_exar_XR17V35x),
-	EXAR_DEVICE(EXAR, XR17V354, pbn_exar_XR17V35x),
-	EXAR_DEVICE(EXAR, XR17V358, pbn_exar_XR17V35x),
-	EXAR_DEVICE(EXAR, XR17V4358, pbn_exar_XR17V4358),
-	EXAR_DEVICE(EXAR, XR17V8358, pbn_exar_XR17V8358),
-	EXAR_DEVICE(COMMTECH, 4222PCIE, pbn_fastcom35x_2),
-	EXAR_DEVICE(COMMTECH, 4224PCIE, pbn_fastcom35x_4),
-	EXAR_DEVICE(COMMTECH, 4228PCIE, pbn_fastcom35x_8),
-
-	EXAR_DEVICE(COMMTECH, 4222PCI335, pbn_fastcom335_2),
-	EXAR_DEVICE(COMMTECH, 4224PCI335, pbn_fastcom335_4),
-	EXAR_DEVICE(COMMTECH, 2324PCI335, pbn_fastcom335_4),
-	EXAR_DEVICE(COMMTECH, 2328PCI335, pbn_fastcom335_8),
-
-	EXAR_DEVICE(SEALEVEL, 710xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 720xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 740xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 780xC, pbn_exar_XR17V35x),
-	EXAR_DEVICE(SEALEVEL, 716xC, pbn_exar_XR17V35x),
+	{ PCI_DEVICE_DATA(EXAR, XR17V352, &pbn_exar_XR17V35x) },
+	{ PCI_DEVICE_DATA(EXAR, XR17V354, &pbn_exar_XR17V35x) },
+	{ PCI_DEVICE_DATA(EXAR, XR17V358, &pbn_exar_XR17V35x) },
+	{ PCI_DEVICE_DATA(EXAR, XR17V4358, &pbn_exar_XR17V4358) },
+	{ PCI_DEVICE_DATA(EXAR, XR17V8358, &pbn_exar_XR17V8358) },
+
+	/* Commtech PCIe cards */
+	{ PCI_DEVICE_DATA(COMMTECH, 4222PCIE, &pbn_fastcom35x_2) },
+	{ PCI_DEVICE_DATA(COMMTECH, 4224PCIE, &pbn_fastcom35x_4) },
+	{ PCI_DEVICE_DATA(COMMTECH, 4228PCIE, &pbn_fastcom35x_8) },
+
+	/* Commtech PCI cards */
+	{ PCI_DEVICE_DATA(COMMTECH, 4222PCI335, &pbn_fastcom335_2) },
+	{ PCI_DEVICE_DATA(COMMTECH, 4224PCI335, &pbn_fastcom335_4) },
+	{ PCI_DEVICE_DATA(COMMTECH, 2324PCI335, &pbn_fastcom335_4) },
+	{ PCI_DEVICE_DATA(COMMTECH, 2328PCI335, &pbn_fastcom335_8) },
+
+	/* Sealevel 7xxxC serial cards */
+	{ PCI_DEVICE_DATA(SEALEVEL, 710xC, &pbn_exar_XR17V35x) },
+	{ PCI_DEVICE_DATA(SEALEVEL, 720xC, &pbn_exar_XR17V35x) },
+	{ PCI_DEVICE_DATA(SEALEVEL, 740xC, &pbn_exar_XR17V35x) },
+	{ PCI_DEVICE_DATA(SEALEVEL, 780xC, &pbn_exar_XR17V35x) },
+	{ PCI_DEVICE_DATA(SEALEVEL, 716xC, &pbn_exar_XR17V35x) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, exar_pci_tbl);
-- 
2.39.2

