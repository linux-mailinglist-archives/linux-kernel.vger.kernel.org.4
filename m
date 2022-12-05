Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E486F64370E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbiLEVmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiLEVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:41:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0B22CCB9;
        Mon,  5 Dec 2022 13:41:48 -0800 (PST)
Date:   Mon, 05 Dec 2022 21:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xemZrY8VvbFDpZkx2nsw8iOahizDN/r13dIQFo1Gd6U=;
        b=CAESZvzAL9MGvdiksyituk+t0hCiqz/8WBtSOGRECjSDmj+7d7m314OowR0/XivJUNnNIl
        ZhvisdldFhlcseBPLsO0YFAzC7UazuzB3WjPfpINcjRcY4Pqo+gf0kyJdHuM9w1lpw0HYu
        DuwALM6/3Ax39/9sy8fLooW7E5XC/XCb5JWTneVMtuWyixyUaWPTDq+GyX62W+9SCJWW+x
        9ArZzkNOF+0JkalUGetA+7AKQ3j64A8HvM2JnovZZ61OpX3aKaCVnOmnewaUaHAnKBD1Nx
        nThkw25aGixM6I95ZoFX4mxIkSe642nhLr92wx7nUbre7BxCCCjSe+sqtZLKPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670276507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xemZrY8VvbFDpZkx2nsw8iOahizDN/r13dIQFo1Gd6U=;
        b=f5BJ8aTA/AWv0szLeqDz5VC/uP8KTjlwhps2Pxpic8llgfVO7ned44ap5r7PKelXZ8wB+y
        CKBBtRgAo9gUjrDQ==
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
Message-ID: <167027650647.4906.4169983710196863807.tip-bot2@tip-bot2>
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

Commit-ID:     fa5745aca1dc819aee6463a2475b5c277f7cf8f6
Gitweb:        https://git.kernel.org/tip/fa5745aca1dc819aee6463a2475b5c277f7cf8f6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 22:22:35 +01:00

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
