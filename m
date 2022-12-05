Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82EE64300C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbiLESZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbiLESZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F0D20BD2;
        Mon,  5 Dec 2022 10:25:15 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpCdO9FRNd4C/C92Gqyt7WAp0J4mSYopV4Hm0MGrgoo=;
        b=DhATBISCsw7QKP2FQPEOfaMkle/6b7cCUotOpy1wIRGuu0bfq7gRVSE7vLRCHdomYU0DhK
        DV2Soo9/TJbYG/y/Z7BdQyo9V+2urbRswIQ6LisRXSiGrfEbYGmH6XH2koezFOXe2mvE2l
        1g0wMljHrYsxWn58sWXb47nlIG3yh9IdXnoymZOTUWyYAZdSs1N8COE+18ZbgnoutYuLwt
        dBinsB0YoIZRKZBP5R75WF0mk/Rr/mS7ZjZ+MOO8/bGADGe8cuuSkFarSM230Mds3EKKzM
        PZ6+ufon0Zo16X4hH35mJBCEuXDod2G5eOwPyLAfkDKfTwlAYShmXoWP5WRd1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QpCdO9FRNd4C/C92Gqyt7WAp0J4mSYopV4Hm0MGrgoo=;
        b=ELKW/XRRhUWM0vSlMDajJJKW+gO81rAy1NR7shRYH38Zgua+BA/8IhxWeVY/oYa27HkxRv
        JTqys2gUecRCmYCg==
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
Message-ID: <167026471199.4906.4942492414600624989.tip-bot2@tip-bot2>
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

Commit-ID:     d9abbfee95e4a80dfbdf7030d0541a315ee2879b
Gitweb:        https://git.kernel.org/tip/d9abbfee95e4a80dfbdf7030d0541a315ee2879b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:04 +01:00

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
 
