Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C20661A41
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 22:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjAHV52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 16:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjAHV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 16:57:12 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF78AA1BC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 13:57:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m3so5014472wmq.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 13:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEK//qA/GZwTCDOY0eW42xYLYPIkWYZxLksmuivpZXk=;
        b=F1uYIMvUXqlXjYHYdlqjvSq2PKF3puT4Gs2mATnDRkGPAzqM8m0JMXxSTP00qsn6NL
         rokXciK+a+DVRmPrXcgRH4BWBQbejyowtonWDRIKVV+50t9cCmgrvaRheW9QQjRND7NZ
         IMmr3xDC3+5qR0/FPRuCUwjCF0VU12HDXlPAvyMNTiurz+p4MDisN3+xYN/laVB/TwbW
         QVsISgPw0EC70yaeA+N18hePfN6oL0cpB2pPC+taz/+hkyiNmAoEM8QnW+dm9qJAWAgR
         z38a82dzSpezFwUzebfEPd0pZKQXrxcEzGhOiU+twsEZ/zNjrNFCSJfh2E8R/swVTDjG
         nh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEK//qA/GZwTCDOY0eW42xYLYPIkWYZxLksmuivpZXk=;
        b=OVNFdNg771DsTZSvbMdzfa0smL9mdzAF94N1CxxN8j7KwuKKsU+zzM1B70IFEqfGU7
         SZWa+ABD8SiguoYEEX5aNvNeYHFWvqrERTdlwRTxATov6t3Y4+VvPibZ26b3xyZeRtcf
         BbFuB9+Yb3p3peziJnhot1tf61GHo1NKOYaM4AGThm9UqOHzCDc82uis6xoLNZBCDKhd
         Amf2sQIswkwT5PBndFoYtAqJIUqF/8bOasi3hB4+nqkjWYlexqRgSIgvgG6ALkImYqWi
         ruIPLUWL5rkxqIN2DMkzbWZ8hhHceQFl6AFxK69xKM8CfnOWfxwhCL/0eTLpPhVEm7C6
         tNEA==
X-Gm-Message-State: AFqh2ko+L6fDUqIXoSgqNVq0+U/+swqAwgpwDWOAA3mTfaP2JgZ47u78
        zjJROrZjEwUCLVEqzlS1Qg8=
X-Google-Smtp-Source: AMrXdXsFSaRjOoTmr0QJW4gHvXwFU2dO20uirtS7l8Eur+nNQdwjoWMdb14a2qpHymfy6XsBlxKP5w==
X-Received: by 2002:a05:600c:34d0:b0:3d6:b691:b80d with SMTP id d16-20020a05600c34d000b003d6b691b80dmr44121475wmq.21.1673215029241;
        Sun, 08 Jan 2023 13:57:09 -0800 (PST)
Received: from localhost.localdomain ([2a10:d582:3bb:0:63f8:f640:f53e:dd47])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm14654071wmo.24.2023.01.08.13.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 13:57:08 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 6/7] parport_pc: Set up mode and ECR masks for Oxford Semiconductor devices
Date:   Sun,  8 Jan 2023 21:56:55 +0000
Message-Id: <20230108215656.6433-6-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
References: <20230108215656.6433-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej W. Rozycki" <macro@orcam.me.uk>

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
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/parport_pc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index d7e64f6dfe90..9b4fe9a2b549 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
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
-- 
2.30.2

