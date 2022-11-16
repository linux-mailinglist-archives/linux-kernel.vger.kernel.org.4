Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0714862CCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiKPVgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiKPVgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:36:17 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B3E9EE0D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:36:16 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8A90392009D; Wed, 16 Nov 2022 22:36:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 8610A92009C;
        Wed, 16 Nov 2022 21:36:15 +0000 (GMT)
Date:   Wed, 16 Nov 2022 21:36:15 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] parport_pc: Set up mode and ECR masks for Oxford
 Semiconductor devices
In-Reply-To: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2211160018240.54611@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2211152336240.54611@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No Oxford Semiconductor PCI or PCIe parallel port device supports the 
Parallel Port FIFO mode.  All support the PS/2 Parallel Port mode and 
the Enhanced Parallel Port mode via the ECR register.  The original 5V 
PCI OX16PCI954 device does not support the Extended Capabilities Port 
mode, the Test mode or the Configuration mode, but all the other OxSemi 
devices do, including in particular the 3.3V PCI OXmPCI954 device and 
the universal voltage PCI OXuPCI954 device.  All the unsupported modes 
are marked reserved in the relevant datasheets.

Accordingly enable the `base_hi' BAR for the 954 devices to enable PS2 
and EPP mode support via the ECR register, however mask the COMPAT mode 
and, until we have a way to determine what chip variant it is that we 
poke at, also the ECP mode, and mask the COMPAT mode only for all the 
remaining OxSemi devices, fixing errors like:

parport0: FIFO is stuck
FIFO write timed out

and a non-functional port when the Parallel Port FIFO mode is selected.

Complementing the fix apply an ECR mask for all these devices, which are 
documented to only permit writing to the mode field of the ECR register 
with a bit pattern of 00001 required to be written to bits 4:0 on mode 
field writes.  No nFault or service interrupts are implemented, which 
will therefore never have to be enabled, though bit 2 does report the 
FIFO threshold status to be polled for in the ECP mode where supported.

We have a documented case of writing 1 to bit 2 causing a lock-up with 
at least one OX12PCI840 device (from old drivers/parport/ChangeLog):

2001-10-10  Tim Waugh  <twaugh@redhat.com>

	* parport_pc.c: Support for OX12PCI840 PCI card (reported by
	mk@daveg.com).  Lock-ups diagnosed by Ronnie Arosa (and now we
	just don't trust its ECR).

which commit adbd321a17cc ("parport_pc: add base_hi BAR for oxsemi_840") 
must have broken and by applying an ECR mask here we prevent the lock-up 
from triggering.  This could have been the reason for requiring 00001 to 
be written to bits 4:0 of ECR.

Update the inline comment accordingly; it has come from Linux 2.4.12 
back in 2001 and predates the introduction of OXmPCI954 and OXuPCI954 
devices that do support ECP.

References:

[1] "OX16PCI954 Integrated Quad UART and PCI interface", Oxford 
    Semiconductor Ltd., Data Sheet Revision 1.3, Feb. 1999, Chapter 9 
    "Bidirectional Parallel Port", pp. 53-55

[2] "OX16PCI952 Data Sheet, Integrated High Performance Dual UARTs,
    Parallel Port and 5.0v PCI interface", Oxford Semiconductor Ltd., 
    DS_B008A_00, Datasheet rev 1.1, June 2001, Chapter 8 "Bi-directional 
    Parallel Port", pp. 52-56

[3] "OXmPCI954 DATA SHEET Integrated High Performance Quad UARTs, 8-bit 
    Local Bus/Parallel Port. 3.3v PCI/miniPCI interface.", Oxford 
    Semiconductor Ltd., DS-0019, June 2005, Chapter 10 "Bidirectional 
    Parallel Port", pp. 86-90

[4] "OXmPCI952 Data Sheet, Integrated High Performance Dual UARTs, 8-bit 
    Local Bus/Parallel Port. 3.3v PCI/miniPCI interface.", Oxford 
    Semiconductor Ltd., DS-0020, June 2005, Chapter 8 "Bidirectional 
    Parallel Port", pp. 73-77

[5] "OX12PCI840 Integrated Parallel Port and PCI interface", Oxford
    Semiconductor Ltd., DS-0021, Jun 2005, Chapter 5 "Bi-directional
    Parallel Port", pp. 18-21

[6] "OXPCIe952 PCI Express Bridge to Dual Serial & Parallel Port",
    Oxford Semiconductor, Inc., DS-0046, Mar 06 08, Chapter "Parallel
    Port Function", pp. 59-62

[7] "OXPCIe840 PCI Express Bridge to Parallel Port", Oxford 
    Semiconductor, Inc., DS-0049, Mar 06 08, Chapter "Parallel Port 
    Function", pp. 15-18

[8] "OXuPCI954 Data Sheet, Integrated High Performance Quad UARTs, 8-bit 
    Local Bus/Parallel Port, 3.3 V and 5 V (Universal Voltage) PCI 
    Interface.", Oxford Semiconductor, Inc., DS-0058, 26 Jan 2009, 
    Chapter 8 "Bidirectional Parallel Port", pp. 62-65

[9] "OXuPCI952 Data Sheet, Integrated High Performance Dual UARTs, 8-bit 
    Local Bus/Parallel Port, 3.3 V and 5.0 V Universal Voltage PCI 
    Interface.", Oxford Semiconductor, Inc., DS-0059, Sep 2007, Chapter 
    8 "Bidirectional Parallel Port", pp. 61-64

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
 drivers/parport/parport_pc.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

linux-parport-pc-pci-oxsemi-modes.diff
Index: linux-macro/drivers/parport/parport_pc.c
===================================================================
--- linux-macro.orig/drivers/parport/parport_pc.c
+++ linux-macro/drivers/parport/parport_pc.c
@@ -2696,12 +2696,19 @@ static struct parport_pc_pci {
 	/* titan_010l */		{ 1, { { 3, -1 }, } },
 	/* avlab_1p		*/	{ 1, { { 0, 1}, } },
 	/* avlab_2p		*/	{ 2, { { 0, 1}, { 2, 3 },} },
-	/* The Oxford Semi cards are unusual: 954 doesn't support ECP,
-	 * and 840 locks up if you write 1 to bit 2! */
-	/* oxsemi_952 */		{ 1, { { 0, 1 }, } },
-	/* oxsemi_954 */		{ 1, { { 0, -1 }, } },
-	/* oxsemi_840 */		{ 1, { { 0, 1 }, } },
-	/* oxsemi_pcie_pport */		{ 1, { { 0, 1 }, } },
+	/* The Oxford Semi cards are unusual: older variants of 954 don't
+	 * support ECP, and 840 locks up if you write 1 to bit 2!  None
+	 * implement nFault or service interrupts and all require 00001
+	 * bit pattern to be used for bits 4:0 with ECR writes. */
+	/* oxsemi_952 */		{ 1, { { 0, 1 }, },
+					  PARPORT_MODE_COMPAT, ECR_MODE_MASK },
+	/* oxsemi_954 */		{ 1, { { 0, 1 }, },
+					  PARPORT_MODE_ECP |
+					  PARPORT_MODE_COMPAT, ECR_MODE_MASK },
+	/* oxsemi_840 */		{ 1, { { 0, 1 }, },
+					  PARPORT_MODE_COMPAT, ECR_MODE_MASK },
+	/* oxsemi_pcie_pport */		{ 1, { { 0, 1 }, },
+					  PARPORT_MODE_COMPAT, ECR_MODE_MASK },
 	/* aks_0100 */                  { 1, { { 0, -1 }, } },
 	/* mobility_pp */		{ 1, { { 0, 1 }, } },
 	/* netmos_9900 */		{ 1, { { 0, -1 }, } },
