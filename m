Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC3A6742A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 20:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjASTVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 14:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjASTUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 14:20:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0584E5B581
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 11:19:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5E561BF3;
        Thu, 19 Jan 2023 11:19:30 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39BD23F67D;
        Thu, 19 Jan 2023 11:18:48 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     hch@lst.de, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6/8] iommu: Retire bus ops
Date:   Thu, 19 Jan 2023 19:18:24 +0000
Message-Id: <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.36.1.dirty
In-Reply-To: <cover.1673978700.git.robin.murphy@arm.com>
References: <cover.1673978700.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the rest of the API internals converted, it's time to finally
tackle probe_device and how we bootstrap the per-device ops association
to begin with. This ends up being disappointingly straightforward, since
fwspec users are already doing it in order to find their of_xlate
callback, and it works out that we can easily do the equivalent for
other drivers too. Then shuffle the remaining awareness of iommu_ops
into the couple of core headers that still need it, and breathe a sigh
of relief...

Ding dong the bus ops are gone!

CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c       | 27 ++++++++++++++++-----------
 include/acpi/acpi_bus.h     |  2 ++
 include/linux/device.h      |  1 -
 include/linux/device/bus.h  |  5 -----
 include/linux/dma-map-ops.h |  1 +
 5 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1a31d94adff5..8997b8f2e79f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -218,13 +218,6 @@ int iommu_device_register(struct iommu_device *iommu,
 	/* We need to be able to take module references appropriately */
 	if (WARN_ON(is_module_address((unsigned long)ops) && !ops->owner))
 		return -EINVAL;
-	/*
-	 * Temporarily enforce global restriction to a single driver. This was
-	 * already the de-facto behaviour, since any possible combination of
-	 * existing drivers would compete for at least the PCI or platform bus.
-	 */
-	if (iommu_buses[0]->iommu_ops && iommu_buses[0]->iommu_ops != ops)
-		return -EBUSY;
 
 	iommu->ops = ops;
 	if (hwdev)
@@ -234,10 +227,8 @@ int iommu_device_register(struct iommu_device *iommu,
 	list_add_tail(&iommu->list, &iommu_device_list);
 	spin_unlock(&iommu_device_lock);
 
-	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++) {
-		iommu_buses[i]->iommu_ops = ops;
+	for (int i = 0; i < ARRAY_SIZE(iommu_buses) && !err; i++)
 		err = bus_iommu_probe(iommu_buses[i]);
-	}
 	if (err)
 		iommu_device_unregister(iommu);
 	return err;
@@ -303,12 +294,26 @@ static u32 dev_iommu_get_max_pasids(struct device *dev)
 
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	const struct iommu_ops *ops;
 	struct iommu_device *iommu_dev;
+	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
 	static DEFINE_MUTEX(iommu_probe_device_lock);
 	int ret;
 
+	/*
+	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
+	 * instances with non-NULL fwnodes, and client devices should have been
+	 * identified with a fwspec by this point. For Intel/AMD/s390/PAMU we
+	 * can assume a single active driver with global ops, and so grab those
+	 * from any registered instance, cheekily co-opting the same mechanism.
+	 */
+	fwspec = dev_iommu_fwspec_get(dev);
+	if (fwspec && fwspec->ops)
+		ops = fwspec->ops;
+	else
+		ops = iommu_ops_from_fwnode(NULL);
+
 	if (!ops)
 		return -ENODEV;
 	/*
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cd3b75e08ec3..067dde9291c9 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -614,6 +614,8 @@ struct acpi_pci_root {
 
 /* helper */
 
+struct iommu_ops;
+
 bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
diff --git a/include/linux/device.h b/include/linux/device.h
index 44e3acae7b36..f7a7ecafedd3 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -41,7 +41,6 @@ struct class;
 struct subsys_private;
 struct device_node;
 struct fwnode_handle;
-struct iommu_ops;
 struct iommu_group;
 struct dev_pin_info;
 struct dev_iommu;
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index d8b29ccd07e5..4ece3470112f 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -63,9 +63,6 @@ struct fwnode_handle;
  *			this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
- * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
- *              driver implementations to a bus and allow the driver to do
- *              bus-specific setup
  * @p:		The private data of the driver core, only the driver core can
  *		touch this.
  * @lock_key:	Lock class key for use by the lock validator
@@ -109,8 +106,6 @@ struct bus_type {
 
 	const struct dev_pm_ops *pm;
 
-	const struct iommu_ops *iommu_ops;
-
 	struct subsys_private *p;
 	struct lock_class_key lock_key;
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index d678afeb8a13..e8ebf0bf611b 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -10,6 +10,7 @@
 #include <linux/pgtable.h>
 
 struct cma;
+struct iommu_ops;
 
 /*
  * Values for struct dma_map_ops.flags:
-- 
2.36.1.dirty

