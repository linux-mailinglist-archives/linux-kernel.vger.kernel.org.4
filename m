Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674BB64371E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbiLEVmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbiLEVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B36F2CDFB;
        Mon,  5 Dec 2022 13:41:48 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMhSepik/XooEqg8QRuWUDLlijXTZPoQ2yr2F7EJias=;
        b=dYjpNqE7d0kwndxp1FHbRIM7ySjW3V9M/IwyERVwah2ZdpGLKswOlZy5w/lvE8W3v6cZXD
        7QFppu8HgH+HTzmS0Rdun/ntyYI4HBgD08bAaSyfLo8oVbRAByBFJEAFnmdC1JYBnKqDXG
        nMk7N3NjNeT717RXHDojMlS4Tl8nTNQVMenjQ24mfrxYFwbTqX+nXwdj3vbwYzJjdNOKvP
        +KTA36O4RYkyXByD2TYZP1FgGy9nFVDEt57nLmgrOsMPgbX6/LZ5qwepFSPOaG7PELtnoS
        /U3CLZB0PWSbDUWwRi3owavgVmRlcQ7blUwKRIHFEbugpC2NZ2njGVbGy0h13g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMhSepik/XooEqg8QRuWUDLlijXTZPoQ2yr2F7EJias=;
        b=FqWn1HTiHZewApXMAazpKff0cH0p4NhsGpWmJq80kqihCc2x3z5sGuGuzqLMtdMLKx1eKz
        GeBu/+jxDUN+vgDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/vt-d: Enable PCI/IMS
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232327.081482253@linutronix.de>
References: <20221124232327.081482253@linutronix.de>
MIME-Version: 1.0
Message-ID: <167027650674.4906.11275867268043900372.tip-bot2@tip-bot2>
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

Commit-ID:     810531a1af5393f010d6508b1cb48e6650fc5e8f
Gitweb:        https://git.kernel.org/tip/810531a1af5393f010d6508b1cb48e6650fc5e8f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:34 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:35 +01:00

iommu/vt-d: Enable PCI/IMS

PCI/IMS works like PCI/MSI-X in the remapping. Just add the feature flag,
but only when on real hardware.

Virtualized IOMMUs need additional support, e.g. for PASID.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232327.081482253@linutronix.de

---
 drivers/iommu/intel/irq_remapping.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 6fab407..a723f53 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -82,7 +82,7 @@ static const struct irq_domain_ops intel_ir_domain_ops;
 
 static void iommu_disable_irq_remapping(struct intel_iommu *iommu);
 static int __init parse_ioapics_under_ir(void);
-static const struct msi_parent_ops dmar_msi_parent_ops;
+static const struct msi_parent_ops dmar_msi_parent_ops, virt_dmar_msi_parent_ops;
 
 static bool ir_pre_enabled(struct intel_iommu *iommu)
 {
@@ -577,7 +577,11 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 
 	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
 	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
+
+	if (cap_caching_mode(iommu->cap))
+		iommu->ir_domain->msi_parent_ops = &virt_dmar_msi_parent_ops;
+	else
+		iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
 
 	ir_table->base = page_address(pages);
 	ir_table->bitmap = bitmap;
@@ -1429,11 +1433,20 @@ static const struct irq_domain_ops intel_ir_domain_ops = {
 };
 
 static const struct msi_parent_ops dmar_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI |
+				  MSI_FLAG_PCI_IMS,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
+static const struct msi_parent_ops virt_dmar_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "vIR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 /*
  * Support of Interrupt Remapping Unit Hotplug
  */
