Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3FC0642FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiLESZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbiLESZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2A3209AE;
        Mon,  5 Dec 2022 10:25:12 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5wGbLfHqr1nnSCyA5sXrLPy2oxdZCa8YH5qCdyQ1sc=;
        b=VsdEpw7QEubc634gEgU0QzWxeJmvPBUV375L406qrO7OWthTQ/YnBXNjcEAihLP7rY/4So
        BjRvZeFxLoyIv7npkE+DXBIqixz1tzqI1qFFrnn03JSg9mUlp0SYxLJihRca3igPnTWDlN
        gQe0JhqH5+Pm6Fro3hC84kVpJdyvpRBNZQr+o9Jdg3rMbhFvVksrB3edIMcWdQuT4HbB2e
        sdaoTV+a2K97G0ir6CHohca5oG1tCFfizFe5Ux/vHlVVQJUB3mFdseAyh1dBfiOq6EKSIV
        T2R2REWMYmeETzN2oHW/aIrmCa233hSoeEVyfd8uL6lp1gZH3YiJcIUaV2e9vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264710;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k5wGbLfHqr1nnSCyA5sXrLPy2oxdZCa8YH5qCdyQ1sc=;
        b=ab8V/6eVP68gBrnF+0SPtujoPk0eijMcrVYUPkd1rBy7Rw/P2gwmQmWPnN+0mqi4TC2T9v
        VvrREKCFM4tnEPCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] iommu/amd: Enable PCI/IMS
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232327.140571546@linutronix.de>
References: <20221124232327.140571546@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471013.4906.1375739872985314530.tip-bot2@tip-bot2>
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

Commit-ID:     73c658f384d7a48e0e18ef0bc5458c8c6ea80574
Gitweb:        https://git.kernel.org/tip/73c658f384d7a48e0e18ef0bc5458c8c6ea80574
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:05 +01:00

iommu/amd: Enable PCI/IMS

PCI/IMS works like PCI/MSI-X in the remapping. Just add the feature flag,
but only when on real hardware.

Virtualized IOMMUs need additional support.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232327.140571546@linutronix.de

---
 drivers/iommu/amd/iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7caccd8..4d28967 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3649,11 +3649,20 @@ static struct irq_chip amd_ir_chip = {
 };
 
 static const struct msi_parent_ops amdvi_msi_parent_ops = {
-	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI |
+				  MSI_FLAG_PCI_IMS,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
 
+static const struct msi_parent_ops virt_amdvi_msi_parent_ops = {
+	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
+				  MSI_FLAG_MULTI_PCI_MSI,
+	.prefix			= "vIR-",
+	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
+};
+
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
 	struct fwnode_handle *fn;
@@ -3670,7 +3679,11 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 
 	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_AMDVI);
 	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
+
+	if (amd_iommu_np_cache)
+		iommu->ir_domain->msi_parent_ops = &virt_amdvi_msi_parent_ops;
+	else
+		iommu->ir_domain->msi_parent_ops = &amdvi_msi_parent_ops;
 
 	return 0;
 }
