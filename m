Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91B16977B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 08:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjBOH7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 02:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbjBOH7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 02:59:00 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66D35250;
        Tue, 14 Feb 2023 23:58:58 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id b22so6695015pgw.3;
        Tue, 14 Feb 2023 23:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DzUy8nBeM2/HxTKhmW9xBDTTC5LtZg2wpvPwRkChGSI=;
        b=E25+JB/KbkvTpG9deX5W9Z6MKrUa8CJGix3Qddd5qmcf4gHgMiqOopzLs3LyrOkEkF
         x356IjdWfI62e0e7qWvgiKMuG+kU4oh7ZKLRlL5q73LOkyo+tlkT/rYISy4Dzl4lXv/L
         bRrNJOuUu2VOpbIWRCi4Zsmxz/480l7A2wBRITfeYMexNXVPpBoPqEtaAev7nlsL98d+
         wM8RKj8iEcUSiD80Y4Zx1OGG7f3kTHSeixdLwptdbV22A5FMv3eI59O3D5IE4g14dMR7
         fQXliQzZRrY7pR9DHOp2+UpkUQOLtRQYicGa5YEDmU+9fjp1sBhNQ1F8G5W59GGie7Ht
         2+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DzUy8nBeM2/HxTKhmW9xBDTTC5LtZg2wpvPwRkChGSI=;
        b=cylV85IclKIbhQ+WQ2h44CCrsrnhmJ4mF8wqa9B0tjZ2j+siP53dR0ipBQ6IMzevUd
         noyRoMte4wX5godbe/8Ng8uirD8SuDe+I/I/Equ2wdrICz63LtSoZcrkepLs+oiZ6Teh
         HzgUKwehPUhR3oyQfb3ZQvAlGaesADZeZmmMoQvpy6UOhzc2d+73sezYGd/1cJWSQ2Du
         ylbWU38S7hPmJgKprtCLRdKxpgvGHcnCpnrBNzpbhph3QgHH8naM/d+hCbJgPej9rSYL
         uvRfGhA3IVArxwV1DAfv//Rnjvgf7wroGCAP4DSjXZAHMvdCbswPKaeZWgeJeoYDMe76
         j2Gw==
X-Gm-Message-State: AO0yUKXeyZgnS2Vm3JgxtRFx13f/+k600wLf2o5zeKHFqrC3PVOBLySO
        JRwFPGWXkKNv0Fpe4bdDZjv6tzf57dM=
X-Google-Smtp-Source: AK7set8B5MCZkeKQ3VpApJp3EvSY6X/SoL73GUyP39SQU4edTjVRKSO/MFl2aINU6F8FBlrOMmaR6A==
X-Received: by 2002:a62:3205:0:b0:5a8:acd9:765b with SMTP id y5-20020a623205000000b005a8acd9765bmr791123pfy.16.1676447937816;
        Tue, 14 Feb 2023 23:58:57 -0800 (PST)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id i25-20020aa78b59000000b0059428b51220sm11034169pfd.186.2023.02.14.23.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 23:58:57 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From:   AceLan Kao <acelan.kao@canonical.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: xhci: Workaround for runpm issue on AMD xHC
Date:   Wed, 15 Feb 2023 15:58:55 +0800
Message-Id: <20230215075855.46204-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>

When the xHC host is runtime suspended, the device connects to it will be
disconnected while trying to use it.
The quirk in commit 2a632815683d ("usb: xhci: Workaround for S3 issue on
AMD SNPS 3.0 xHC") also works for this issue, so added its ID to the
quirk, too.

05:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:1505] (prog-if 30 [XHCI])
        Subsystem: Dell Device [1028:0c3f]
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 60
        IOMMU group: 21
        Region 0: Memory at c0000000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: <access denied>
        Kernel driver in use: xhci_hcd
        Kernel modules: xhci_pci

[   20.769275] xhci_hcd 0000:05:00.0: xHCI host not responding to stop endpoint command
[   20.771429] xhci_hcd 0000:05:00.0: xHCI host controller not responding, assume dead
[   20.771444] xhci_hcd 0000:05:00.0: HC died; cleaning up
[   20.771733] usb 5-1: USB disconnect, device number 2

Cc: stable@vger.kernel.org #v4.19+
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index fb988e4ea924..b8f6843a8cd1 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -177,7 +177,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
 		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x15e5) {
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+		(pdev->device == 0x15e5 ||
+		 pdev->device == 0x1505)) {
 		xhci->quirks |= XHCI_DISABLE_SPARSE;
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 	}
-- 
2.34.1

