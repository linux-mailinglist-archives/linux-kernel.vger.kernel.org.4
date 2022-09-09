Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0597A5B3403
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiIIJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiIIJad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:30:33 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E04B713D7A4;
        Fri,  9 Sep 2022 02:28:35 -0700 (PDT)
Received: from loongson-pc.loongson.cn (unknown [10.20.42.105])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxBOIrBxtjH04VAA--.19971S3;
        Fri, 09 Sep 2022 17:28:16 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     lpieralisi@kernel.org, robin.murphy@arm.com, chenhuacai@loongson.cn
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        loongarch@lists.linux.dev
Subject: [PATCH V4 1/2] ACPI / scan: Support multiple dma windows with different offsets
Date:   Fri,  9 Sep 2022 17:28:10 +0800
Message-Id: <20220909092811.22627-2-lvjianmin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220909092811.22627-1-lvjianmin@loongson.cn>
References: <20220909092811.22627-1-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxBOIrBxtjH04VAA--.19971S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWkKFyktryfGrW3AFyUtrb_yoW3ur1kp3
        Za9FyfGr47KrsrWr4kZr4rZ3W5Z3sY93yxXrWxG3sakr909r1UJFsrA340ka4rAFyqkF4x
        ZF4DtFyrCF1UZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU921xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r10
        6r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxE
        wVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4
        IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
        MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
        WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
        6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x0JUZa9-UUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For DT, of_dma_get_range returns bus_dma_region typed dma regions,
which makes multiple dma windows with different offset available
for translation between dma address and cpu address.

But for ACPI, acpi_dma_get_range doesn't return similar dma regions,
causing no path for setting dev->dma_range_map conveniently. So the
patch changes acpi_dma_get_range and returns bus_dma_region typed
dma regions according to of_dma_get_range.

After changing acpi_dma_get_range, acpi_arch_dma_setup is changed for
ARM64, where original dma_addr and size are removed as these
arguments are now redundant, and pass 0 and U64_MAX for dma_base
and size of arch_setup_dma_ops, so this is a simplification consistent
with what other ACPI architectures also pass to iommu_setup_dma_ops().

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 drivers/acpi/arm64/dma.c | 29 +++++++++++++---------
 drivers/acpi/scan.c      | 53 +++++++++++++++++-----------------------
 include/acpi/acpi_bus.h  |  3 +--
 include/linux/acpi.h     |  7 +++---
 4 files changed, 45 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/arm64/dma.c b/drivers/acpi/arm64/dma.c
index f16739ad3cc0..1ef8e7ded4cd 100644
--- a/drivers/acpi/arm64/dma.c
+++ b/drivers/acpi/arm64/dma.c
@@ -4,11 +4,12 @@
 #include <linux/device.h>
 #include <linux/dma-direct.h>
 
-void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
+void acpi_arch_dma_setup(struct device *dev)
 {
 	int ret;
 	u64 end, mask;
-	u64 dmaaddr = 0, size = 0, offset = 0;
+	u64 size = 0;
+	const struct bus_dma_region *map = NULL;
 
 	/*
 	 * If @dev is expected to be DMA-capable then the bus code that created
@@ -26,25 +27,31 @@ void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
 	else
 		size = 1ULL << 32;
 
-	ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
+	ret = acpi_dma_get_range(dev, &map);
+	if (!ret && map) {
+		const struct bus_dma_region *r = map;
+
+		for (end = 0; r->size; r++) {
+			if (r->dma_start + r->size - 1 > end)
+				end = r->dma_start + r->size - 1;
+		}
+
+		size = end + 1;
+		dev->dma_range_map = map;
+	}
+
 	if (ret == -ENODEV)
 		ret = iort_dma_get_ranges(dev, &size);
+
 	if (!ret) {
 		/*
 		 * Limit coherent and dma mask based on size retrieved from
 		 * firmware.
 		 */
-		end = dmaaddr + size - 1;
+		end = size - 1;
 		mask = DMA_BIT_MASK(ilog2(end) + 1);
 		dev->bus_dma_limit = end;
 		dev->coherent_dma_mask = min(dev->coherent_dma_mask, mask);
 		*dev->dma_mask = min(*dev->dma_mask, mask);
 	}
-
-	*dma_addr = dmaaddr;
-	*dma_size = size;
-
-	ret = dma_direct_set_offset(dev, dmaaddr + offset, dmaaddr, size);
-
-	dev_dbg(dev, "dma_offset(%#08llx)%s\n", offset, ret ? " failed!" : "");
 }
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 42cec8120f18..b4505ec467fe 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -20,6 +20,7 @@
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
 #include <linux/crc32.h>
+#include <linux/dma-direct.h>
 
 #include "internal.h"
 
@@ -1467,25 +1468,21 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
  * acpi_dma_get_range() - Get device DMA parameters.
  *
  * @dev: device to configure
- * @dma_addr: pointer device DMA address result
- * @offset: pointer to the DMA offset result
- * @size: pointer to DMA range size result
+ * @map: pointer to DMA ranges result
  *
- * Evaluate DMA regions and return respectively DMA region start, offset
- * and size in dma_addr, offset and size on parsing success; it does not
- * update the passed in values on failure.
+ * Evaluate DMA regions and return pointer to DMA regions on
+ * parsing success; it does not update the passed in values on failure.
  *
  * Return 0 on success, < 0 on failure.
  */
-int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
-		       u64 *size)
+int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 {
 	struct acpi_device *adev;
 	LIST_HEAD(list);
 	struct resource_entry *rentry;
 	int ret;
 	struct device *dma_dev = dev;
-	u64 len, dma_start = U64_MAX, dma_end = 0, dma_offset = 0;
+	struct bus_dma_region *r;
 
 	/*
 	 * Walk the device tree chasing an ACPI companion with a _DMA
@@ -1510,31 +1507,28 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 
 	ret = acpi_dev_get_dma_resources(adev, &list);
 	if (ret > 0) {
+		r = kcalloc(ret + 1, sizeof(*r), GFP_KERNEL);
+		if (!r) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		*map = r;
+
 		list_for_each_entry(rentry, &list, node) {
-			if (dma_offset && rentry->offset != dma_offset) {
+			if (rentry->res->start >= rentry->res->end) {
 				ret = -EINVAL;
-				dev_warn(dma_dev, "Can't handle multiple windows with different offsets\n");
+				dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
 				goto out;
 			}
-			dma_offset = rentry->offset;
 
-			/* Take lower and upper limits */
-			if (rentry->res->start < dma_start)
-				dma_start = rentry->res->start;
-			if (rentry->res->end > dma_end)
-				dma_end = rentry->res->end;
-		}
-
-		if (dma_start >= dma_end) {
-			ret = -EINVAL;
-			dev_dbg(dma_dev, "Invalid DMA regions configuration\n");
-			goto out;
+			r->cpu_start = rentry->res->start;
+			r->dma_start = rentry->res->start - rentry->offset;
+			r->size = resource_size(rentry->res);
+			r->offset = rentry->offset;
+			r++;
 		}
 
-		*dma_addr = dma_start - dma_offset;
-		len = dma_end - dma_start;
-		*size = max(len, len + 1);
-		*offset = dma_offset;
 	}
  out:
 	acpi_dev_free_resource_list(&list);
@@ -1624,20 +1618,19 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			  const u32 *input_id)
 {
 	const struct iommu_ops *iommu;
-	u64 dma_addr = 0, size = 0;
 
 	if (attr == DEV_DMA_NOT_SUPPORTED) {
 		set_dma_ops(dev, &dma_dummy_ops);
 		return 0;
 	}
 
-	acpi_arch_dma_setup(dev, &dma_addr, &size);
+	acpi_arch_dma_setup(dev);
 
 	iommu = acpi_iommu_configure_id(dev, input_id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-	arch_setup_dma_ops(dev, dma_addr, size,
+	arch_setup_dma_ops(dev, 0, U64_MAX,
 				iommu, attr == DEV_DMA_COHERENT);
 
 	return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index e7d27373ff71..73ac4a1d6947 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -613,8 +613,7 @@ enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 			   struct fwnode_handle *fwnode,
 			   const struct iommu_ops *ops);
-int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
-		       u64 *size);
+int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
 static inline int acpi_dma_configure(struct device *dev,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc54..bb41623dab77 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -281,12 +281,12 @@ void acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa);
 
 #ifdef CONFIG_ARM64
 void acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa);
-void acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size);
+void acpi_arch_dma_setup(struct device *dev);
 #else
 static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
 static inline void
-acpi_arch_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size) { }
+acpi_arch_dma_setup(struct device *dev) { }
 #endif
 
 int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
@@ -977,8 +977,7 @@ static inline enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev)
 	return DEV_DMA_NOT_SUPPORTED;
 }
 
-static inline int acpi_dma_get_range(struct device *dev, u64 *dma_addr,
-				     u64 *offset, u64 *size)
+static inline int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 {
 	return -ENODEV;
 }
-- 
2.31.1

