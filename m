Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27F7643719
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbiLEVme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiLEVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1E2C65D;
        Mon,  5 Dec 2022 13:41:52 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkvNfJ57lpw3AUe1CmX6D4bMIWUO3dO7szKMEbwpQg4=;
        b=lFtylxneSIEJnyazFEZrOv9Zrsro+1dQRWXRgPQl8w8Jyc0XcwjWTuxcwUrZHz2ogqWSDa
        jKt85PsigYCibcDMGb3QLn37kHDpR1nar3PoklVVJD434hOf6AAlsY7VzxpW8Emq6la5T6
        9TGFML1LFcWLCydhTfhfx97JAuOyo2ZsMjIRIHbN6Int69SBijM/rhv9Dg6FHAAabJ+czo
        Yr8OKxGNPT/X7evSUWHuAKAUSHzTrL8fsLzqsbXyOn66bP/Aq6xhJV5+ofz/AJTq4vsO70
        Xd+DCwIPoG8Lo3VHx5x0X41avHo9nmHw2CXy17nFNuciKqac9rInQwdpALcHmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkvNfJ57lpw3AUe1CmX6D4bMIWUO3dO7szKMEbwpQg4=;
        b=F2/1RzWZVe25DKfWi7qNmXT56eJfLi2l73RMw+BQz8dR5TyVrYsWZtPTIaZy1lcrIUPEEf
        DJJ8r3ZFLyrIPHDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Provide prepare_desc() MSI domain op
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.673658806@linutronix.de>
References: <20221124232326.673658806@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650761.4906.6794069945665694728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     73bd063ca03493f44e0700cc08824093da9741bc
Gitweb:        https://git.kernel.org/tip/73bd063ca03493f44e0700cc08824093da9741bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:34 +01:00

PCI/MSI: Provide prepare_desc() MSI domain op

The setup of MSI descriptors for PCI/MSI-X interrupts depends partially on
the MSI index for which the descriptor is initialized.

Dynamic MSI-X vector allocation post MSI-X enablement allows to allocate
vectors at a given index or at any free index in the available table
range. The latter requires that the descriptor is initialized after the
MSI core has chosen an index.

Implement the prepare_desc() op in the PCI/MSI-X specific msi_domain_ops
which is invoked before the core interrupt descriptor and the associated
Linux interrupt number is allocated.

That callback is also provided for the upcoming PCI/IMS implementations so
the implementation specific interrupt domain can do their domain specific
initialization of the MSI descriptors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.673658806@linutronix.de

---
 drivers/pci/msi/irqdomain.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 4736403..8afaef1 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -202,6 +202,14 @@ static void pci_irq_unmask_msix(struct irq_data *data)
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
 
+static void pci_msix_prepare_desc(struct irq_domain *domain, msi_alloc_info_t *arg,
+				  struct msi_desc *desc)
+{
+	/* Don't fiddle with preallocated MSI descriptors */
+	if (!desc->pci.mask_base)
+		msix_prepare_msi_desc(to_pci_dev(desc->dev), desc);
+}
+
 static const struct msi_domain_template pci_msix_template = {
 	.chip = {
 		.name			= "PCI-MSIX",
@@ -212,6 +220,7 @@ static const struct msi_domain_template pci_msix_template = {
 	},
 
 	.ops = {
+		.prepare_desc		= pci_msix_prepare_desc,
 		.set_desc		= pci_device_domain_set_desc,
 	},
 
