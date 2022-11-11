Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A273625C38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiKKOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbiKKOBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:01:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DEF391D2;
        Fri, 11 Nov 2022 05:56:55 -0800 (PST)
Message-ID: <20221111132706.612934166@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZAg32d9i/2td2oqLXP4twAnBQvJWwD8NcSLXlUrJbYg=;
        b=wTMg281eWp6mj4p8XCRYsGLuKaE18bBJPfh2mwDMgfgBIRGhzgaW5KoLmNiJ9Yi2sfgHvE
        J9n2fQpOecsWGH9hD1tiP8fayfvIJKg4xn8ck9M1HOXvrP/NN2Su3SNaOBENX/5yU2h6DE
        QkG5EqNjZEmxgyeRQTiXfXRjJl4fevozjBLTZgNFFnpC1GPgoZrU9Y+uY/sHFI5Esc4GXW
        coxMdGZzk7LurScp8P/AAJ4zDZduFW1awQQk3UUky5HbjaBUVGBTPa3VTS6hDJSQz0hAj/
        7jpr2mLZROQn7FP2LQxeF+nYEyn1uJB2K9oLB1HSxynXrmaJSr83/2clZ+pLsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ZAg32d9i/2td2oqLXP4twAnBQvJWwD8NcSLXlUrJbYg=;
        b=Snso0XSvIOhypHm6eejQQUk8CRZleoczwyIEvsFyEbzA9VmrArOSf7KE5UJ8Izdy89gkuy
        MiuJ5SHtSSSlczCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 10/20] genirq/msi: Rename msi_add_msi_desc() to msi_insert_msi_desc()
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:53 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reflects the functionality better. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c            |    4 ++--
 drivers/soc/ti/ti_sci_inta_msi.c |    4 ++--
 include/linux/msi.h              |    2 +-
 kernel/irq/msi.c                 |    6 ++++--
 4 files changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -308,7 +308,7 @@ static int msi_setup_msi_desc(struct pci
 	if (desc.pci.msi_attrib.can_mask)
 		pci_read_config_dword(dev, desc.pci.mask_pos, &desc.pci.msi_mask);
 
-	return msi_add_msi_desc(&dev->dev, &desc);
+	return msi_insert_msi_desc(&dev->dev, &desc);
 }
 
 static int msi_verify_entries(struct pci_dev *dev)
@@ -591,7 +591,7 @@ static int msix_setup_msi_descs(struct p
 			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 		}
 
-		ret = msi_add_msi_desc(&dev->dev, &desc);
+		ret = msi_insert_msi_desc(&dev->dev, &desc);
 		if (ret)
 			break;
 	}
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -73,13 +73,13 @@ static int ti_sci_inta_msi_alloc_descs(s
 	for (set = 0; set < res->sets; set++) {
 		for (i = 0; i < res->desc[set].num; i++, count++) {
 			msi_desc.msi_index = res->desc[set].start + i;
-			if (msi_add_msi_desc(dev, &msi_desc))
+			if (msi_insert_msi_desc(dev, &msi_desc))
 				goto fail;
 		}
 
 		for (i = 0; i < res->desc[set].num_sec; i++, count++) {
 			msi_desc.msi_index = res->desc[set].start_sec + i;
-			if (msi_add_msi_desc(dev, &msi_desc))
+			if (msi_insert_msi_desc(dev, &msi_desc))
 				goto fail;
 		}
 	}
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -274,7 +274,7 @@ static inline void msi_desc_set_iommu_co
 }
 #endif
 
-int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
+int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc);
 void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -100,13 +100,15 @@ static int msi_insert_desc(struct msi_de
 }
 
 /**
- * msi_add_msi_desc - Allocate and initialize a MSI descriptor
+ * msi_insert_msi_desc - Allocate and initialize a MSI descriptor and
+ *			 insert it at @init_desc->msi_index
+ *
  * @dev:	Pointer to the device for which the descriptor is allocated
  * @init_desc:	Pointer to an MSI descriptor to initialize the new descriptor
  *
  * Return: 0 on success or an appropriate failure code.
  */
-int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc)
+int msi_insert_msi_desc(struct device *dev, struct msi_desc *init_desc)
 {
 	struct msi_desc *desc;
 

