Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2212D643039
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbiLES00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiLESZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6938620BF7;
        Mon,  5 Dec 2022 10:25:13 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mgf4JvdnOFzcR7R3UFa7yHDMzmvH+qWgLoSbvKm7xNQ=;
        b=VyGb8V0YuIo9ES34NDkRfTvZsRJ6KrvTxZvzKmQ5EJ4pWeVtZWH4yj4PZt3U2lB+r8WXeP
        edRYQDzkifVQeRRJG2lDO/BeTCQwVN1Q/+Z8BEWv42k1XiexAlJlhffSOPqatmcfpfPSQt
        ChvHN4Nch3JFJgV2UrltG48pldP1YhEZSP6B9JGX5rIoMqwWKeP4FxJHo7ADbp7J1UfWCv
        woCxwo0aaWwuly95Or/8r9cvsECbBmTXhRMJ7O2oKrd2qExTKTsZlZ5e0X2+Yg20T+NLsp
        S01zHoQpfWtx6hHVRW8BgsPmYBbPL4F0aybY8lsaLxhqefTe++P58bNW0MD6Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264711;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mgf4JvdnOFzcR7R3UFa7yHDMzmvH+qWgLoSbvKm7xNQ=;
        b=G8sBXSH/atzb0tp92cEAlZihWpbAlb4zMAuO8BQdInkuSKRmaVA5AuDbHugdk+rrMAeikA
        1ICNZ8ABHeHoqMAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Provide IMS (Interrupt Message Store) support
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124232326.904316841@linutronix.de>
References: <20221124232326.904316841@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026471107.4906.3551467956394390048.tip-bot2@tip-bot2>
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

Commit-ID:     4c528684eaf6bf5aa9b4a481ae569729af772bfd
Gitweb:        https://git.kernel.org/tip/4c528684eaf6bf5aa9b4a481ae569729af772bfd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:26:29 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:21:04 +01:00

PCI/MSI: Provide IMS (Interrupt Message Store) support

IMS (Interrupt Message Store) is a new specification which allows
implementation specific storage of MSI messages contrary to the
strict standard specified MSI and MSI-X message stores.

This requires new device specific interrupt domains to handle the
implementation defined storage which can be an array in device memory or
host/guest memory which is shared with hardware queues.

Add a function to create IMS domains for PCI devices. IMS domains are using
the new per device domain mechanism and are configured by the device driver
via a template. IMS domains are created as secondary device domains so they
work side on side with MSI[-X] on the same device.

The IMS domains have a few constraints:

  - The index space is managed by the core code.

    Device memory based IMS provides a storage array with a fixed size
    which obviously requires an index. But there is no association between
    index and functionality so the core can randomly allocate an index in
    the array.

    System memory based IMS does not have the concept of an index as the
    storage is somewhere in memory. In that case the index is purely
    software based to keep track of the allocations.

  - There is no requirement for consecutive index ranges

    This is currently a limitation of the MSI core and can be implemented
    if there is a justified use case by changing the internal storage from
    xarray to maple_tree. For now it's single vector allocation.

  - The interrupt chip must provide the following callbacks:

  	- irq_mask()
	- irq_unmask()
	- irq_write_msi_msg()

   - The interrupt chip must provide the following optional callbacks
     when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
     cannot operate directly on hardware, e.g. in the case that the
     interrupt message store is in queue memory:

     	- irq_bus_lock()
	- irq_bus_unlock()

     These callbacks are invoked from preemptible task context and are
     allowed to sleep. In this case the mandatory callbacks above just
     store the information. The irq_bus_unlock() callback is supposed to
     make the change effective before returning.

   - Interrupt affinity setting is handled by the underlying parent
     interrupt domain and communicated to the IMS domain via
     irq_write_msi_msg(). IMS domains cannot have a irq_set_affinity()
     callback. That's a reasonable restriction similar to the PCI/MSI
     device domain implementations.

The domain is automatically destroyed when the PCI device is removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124232326.904316841@linutronix.de

---
 drivers/pci/msi/irqdomain.c | 59 ++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h         |  5 +++-
 2 files changed, 64 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index deb1930..e33bcc8 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -355,6 +355,65 @@ bool pci_msi_domain_supports(struct pci_dev *pdev, unsigned int feature_mask,
 	return (supported & feature_mask) == feature_mask;
 }
 
+/**
+ * pci_create_ims_domain - Create a secondary IMS domain for a PCI device
+ * @pdev:	The PCI device to operate on
+ * @template:	The MSI info template which describes the domain
+ * @hwsize:	The size of the hardware entry table or 0 if the domain
+ *		is purely software managed
+ * @data:	Optional pointer to domain specific data to be stored
+ *		in msi_domain_info::data
+ *
+ * Return: True on success, false otherwise
+ *
+ * An IMS domain is expected to have the following constraints:
+ *	- The index space is managed by the core code
+ *
+ *	- There is no requirement for consecutive index ranges
+ *
+ *	- The interrupt chip must provide the following callbacks:
+ *		- irq_mask()
+ *		- irq_unmask()
+ *		- irq_write_msi_msg()
+ *
+ *	- The interrupt chip must provide the following optional callbacks
+ *	  when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
+ *	  cannot operate directly on hardware, e.g. in the case that the
+ *	  interrupt message store is in queue memory:
+ *		- irq_bus_lock()
+ *		- irq_bus_unlock()
+ *
+ *	  These callbacks are invoked from preemptible task context and are
+ *	  allowed to sleep. In this case the mandatory callbacks above just
+ *	  store the information. The irq_bus_unlock() callback is supposed
+ *	  to make the change effective before returning.
+ *
+ *	- Interrupt affinity setting is handled by the underlying parent
+ *	  interrupt domain and communicated to the IMS domain via
+ *	  irq_write_msi_msg().
+ *
+ * The domain is automatically destroyed when the PCI device is removed.
+ */
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
+			   unsigned int hwsize, void *data)
+{
+	struct irq_domain *domain = dev_get_msi_domain(&pdev->dev);
+
+	if (!domain || !irq_domain_is_msi_parent(domain))
+		return false;
+
+	if (template->info.bus_token != DOMAIN_BUS_PCI_DEVICE_IMS ||
+	    !(template->info.flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS) ||
+	    !(template->info.flags & MSI_FLAG_FREE_MSI_DESCS) ||
+	    !template->chip.irq_mask || !template->chip.irq_unmask ||
+	    !template->chip.irq_write_msi_msg || template->chip.irq_set_affinity)
+		return false;
+
+	return msi_create_device_irq_domain(&pdev->dev, MSI_SECONDARY_DOMAIN, template,
+					    hwsize, data, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_create_ims_domain);
+
 /*
  * Users of the generic MSI infrastructure expect a device to have a single ID,
  * so with DMA aliases we have to pick the least-worst compromise. Devices with
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 68b14ba..1592b63 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2487,6 +2487,11 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+struct msi_domain_template;
+
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
+			   unsigned int hwsize, void *data);
+
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \
