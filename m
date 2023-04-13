Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCEF6E09C7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjDMJIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDMJIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:08:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0C81734;
        Thu, 13 Apr 2023 02:08:12 -0700 (PDT)
X-UUID: b317ae92d9da11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rYwysHzjyxeU89yIXfyyaxHSc4b5rh92IDLtel9ASgo=;
        b=LAkbKbrnLSV3Br6/csuQZfRHG/7B2Fe5fC/nKIcbZtMzxQDLbkzHi1gqS3jBScQEx0oqnzz5NTTtErWXBSsePLWwFsfjjdZFfu6xuYcHfok0dq7NCDspY58sdwtn4MdwrRzpadgXJdvEqZiknMrzbuLW9WEDOV2FFszIGgFqW5c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:03c0bd10-3f8e-4d0b-a4e4-e80269e0b957,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:03c0bd10-3f8e-4d0b-a4e4-e80269e0b957,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:3bcfef83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:2304131708069FYIZSXQ,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b317ae92d9da11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1862041784; Thu, 13 Apr 2023 17:08:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Apr 2023 17:08:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 13 Apr 2023 17:08:03 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Jades Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>
Subject: [PATCH v1 4/6] soc: mediatek: virt: geniezone: Introduce irqchip for virtual interrupt injection
Date:   Thu, 13 Apr 2023 17:07:33 +0800
Message-ID: <20230413090735.4182-5-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230413090735.4182-1-yi-de.wu@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

Enable GenieZone to handle virtual interrupt injection request.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 drivers/soc/mediatek/virt/geniezone/Makefile  |  2 +-
 drivers/soc/mediatek/virt/geniezone/gzvm.h    |  5 +
 .../mediatek/virt/geniezone/gzvm_irqchip.c    | 94 +++++++++++++++++++
 .../soc/mediatek/virt/geniezone/gzvm_vcpu.c   |  6 ++
 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c | 77 +++++++++++++++
 include/uapi/linux/gzvm_common.h              | 32 +++++++
 6 files changed, 215 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c

diff --git a/drivers/soc/mediatek/virt/geniezone/Makefile b/drivers/soc/mediatek/virt/geniezone/Makefile
index e1dfbb9c568d..d2302a3a93fc 100644
--- a/drivers/soc/mediatek/virt/geniezone/Makefile
+++ b/drivers/soc/mediatek/virt/geniezone/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-gzvm-y := gzvm_main.o gzvm_vm.o gzvm_vcpu.o
+gzvm-y := gzvm_main.o gzvm_vm.o gzvm_vcpu.o gzvm_irqchip.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm.h b/drivers/soc/mediatek/virt/geniezone/gzvm.h
index 43f215d4b0da..89cea5441a2d 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm.h
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm.h
@@ -98,6 +98,11 @@ int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 
+void gzvm_sync_vgic_state(struct gzvm_vcpu *vcpu);
+int gzvm_vgic_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+			 u32 irq, bool level);
+int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 spi_irq, bool level);
 int gz_err_to_errno(unsigned long err);
 
 #endif /* __GZVM_H__ */
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c b/drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c
new file mode 100644
index 000000000000..7aa5868a221c
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_irqchip.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/irqchip/arm-gic-v3.h>
+#include <kvm/arm_vgic.h>
+
+#include "gzvm.h"
+
+/**
+ * @brief check all LRs synced from gz hypervisor
+ * Traverse all LRs, see if any EOIed vint, notify_acked_irq if any.
+ * GZ does not fold/unfold everytime KVM_RUN, so we have to traverse all saved
+ * LRs. It will not takes much more time comparing to fold/unfold everytime
+ * GZVM_RUN, because there are only few LRs.
+ */
+void gzvm_sync_vgic_state(struct gzvm_vcpu *vcpu)
+{
+	int i;
+
+	for (i = 0; i < vcpu->hwstate->nr_lrs; i++) {
+		uint64_t lr_val = vcpu->hwstate->lr[i];
+		/* 0 means unused */
+		if (!lr_val)
+			continue;
+	}
+}
+
+/**
+ * @brief Check the irq number and irq_type are matched
+ */
+static bool is_irq_valid(u32 irq, u32 irq_type)
+{
+	switch (irq_type) {
+	case GZVM_IRQ_TYPE_CPU:	/*  0 ~ 15: SGI */
+		if (likely(irq <= GZVM_IRQ_CPU_FIQ))
+			return true;
+		break;
+	case GZVM_IRQ_TYPE_PPI:	/* 16 ~ 31: PPI */
+		if (likely(irq >= VGIC_NR_SGIS && irq < VGIC_NR_PRIVATE_IRQS))
+			return true;
+		break;
+	case GZVM_IRQ_TYPE_SPI:	/* 32 ~ : SPT */
+		if (likely(irq >= VGIC_NR_PRIVATE_IRQS))
+			return true;
+		break;
+	default:
+		return false;
+	}
+	return false;
+}
+
+/**
+ * @brief Inject virtual interrupt to a VM
+ *
+ * @param gzvm
+ * @param vcpu_idx: vcpu index, only valid if PPI
+ * @param irq: irq number
+ * @param irq_type
+ * @param level, true: 1; false: 0
+ */
+int gzvm_vgic_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+			 u32 irq, bool level)
+{
+	unsigned long a1 = assemble_vm_vcpu_tuple(gzvm->vm_id, vcpu_idx);
+	struct arm_smccc_res res;
+
+	if (!unlikely(is_irq_valid(irq, irq_type)))
+		return -EINVAL;
+
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_IRQ_LINE, a1, irq, level,
+			     0, 0, 0, 0, &res);
+	if (res.a0) {
+		pr_err("Failed to set IRQ level (%d) to irq#%u on vcpu %d with ret=%d\n",
+		       level, irq, vcpu_idx, (int)res.a0);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/**
+ * @brief Inject virtual spi interrupt
+ *
+ * @param spi_irq This is spi interrupt number (starts from 0 instead of 32)
+ * @return 0 succeed, other negative values are error
+ */
+int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 spi_irq, bool level)
+{
+	return gzvm_vgic_inject_irq(gzvm, 0, GZVM_IRQ_TYPE_SPI,
+				    spi_irq + VGIC_NR_PRIVATE_IRQS, level);
+}
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
index 726db866dfcf..5f2e24d13c41 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
@@ -67,6 +67,11 @@ static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, void * __user argp,
 	return ret;
 }
 
+static void gzvm_sync_hwstate(struct gzvm_vcpu *vcpu)
+{
+	gzvm_sync_vgic_state(vcpu);
+}
+
 /**
  * @brief Handle vcpu run ioctl, entry point to guest and exit point from guest
  *
@@ -115,6 +120,7 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 			need_userspace = true;
 			goto out;
 		}
+		gzvm_sync_hwstate(vcpu);
 	} while (!need_userspace);
 
 out:
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
index df4ccdc3b7f0..7895f40b23eb 100644
--- a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
@@ -193,6 +193,69 @@ static int gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
+static int gzvm_vm_ioctl_irq_line(struct gzvm *gzvm,
+				  struct gzvm_irq_level *irq_level)
+{
+	u32 irq = irq_level->irq;
+	unsigned int irq_type, vcpu_idx, irq_num;
+	bool level = irq_level->level;
+
+	irq_type = (irq >> GZVM_IRQ_TYPE_SHIFT) & GZVM_IRQ_TYPE_MASK;
+	vcpu_idx = (irq >> GZVM_IRQ_VCPU_SHIFT) & GZVM_IRQ_VCPU_MASK;
+	vcpu_idx += ((irq >> GZVM_IRQ_VCPU2_SHIFT) & GZVM_IRQ_VCPU2_MASK) *
+		(GZVM_IRQ_VCPU_MASK + 1);
+	irq_num = (irq >> GZVM_IRQ_NUM_SHIFT) & GZVM_IRQ_NUM_MASK;
+
+	return gzvm_vgic_inject_irq(gzvm, vcpu_idx, irq_num, irq_type, level);
+}
+
+static int gzvm_vm_ioctl_create_device(struct gzvm *gzvm, void __user *argp)
+{
+	struct gzvm_create_device *gzvm_dev;
+	void *dev_data = NULL;
+	struct arm_smccc_res res = {0};
+	int ret;
+
+	gzvm_dev = (struct gzvm_create_device *)alloc_pages_exact(PAGE_SIZE,
+								  GFP_KERNEL);
+	if (!gzvm_dev)
+		return -ENOMEM;
+	if (copy_from_user(gzvm_dev, argp, sizeof(*gzvm_dev))) {
+		ret = -EFAULT;
+		goto err_free_dev;
+	}
+
+	if (gzvm_dev->attr_addr != 0 && gzvm_dev->attr_size != 0) {
+		size_t attr_size = gzvm_dev->attr_size;
+		void __user *attr_addr = (void __user *)gzvm_dev->attr_addr;
+
+		/* Size of device specific data should not be over a page. */
+		if (attr_size > PAGE_SIZE)
+			return -EINVAL;
+
+		dev_data = alloc_pages_exact(attr_size, GFP_KERNEL);
+		if (!dev_data) {
+			ret = -ENOMEM;
+			goto err_free_dev;
+		}
+
+		if (copy_from_user(dev_data, attr_addr, attr_size)) {
+			ret = -EFAULT;
+			goto err_free_dev_data;
+		}
+		gzvm_dev->attr_addr = virt_to_phys(dev_data);
+	}
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_DEVICE, gzvm->vm_id,
+				   virt_to_phys(gzvm_dev), 0, 0, 0, 0, 0, &res);
+err_free_dev_data:
+	if (dev_data)
+		free_pages_exact(dev_data, 0);
+err_free_dev:
+	free_pages_exact(gzvm_dev, 0);
+	return ret;
+}
+
 static int gzvm_vm_enable_cap_hyp(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  struct arm_smccc_res *res)
@@ -300,6 +363,20 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
 		break;
 	}
+	case GZVM_IRQ_LINE: {
+		struct gzvm_irq_level irq_event;
+
+		ret = -EFAULT;
+		if (copy_from_user(&irq_event, argp, sizeof(irq_event)))
+			goto out;
+
+		ret = gzvm_vm_ioctl_irq_line(gzvm, &irq_event);
+		break;
+	}
+	case GZVM_CREATE_DEVICE: {
+		ret = gzvm_vm_ioctl_create_device(gzvm, argp);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
diff --git a/include/uapi/linux/gzvm_common.h b/include/uapi/linux/gzvm_common.h
index aa97438bab8c..6808cfe59450 100644
--- a/include/uapi/linux/gzvm_common.h
+++ b/include/uapi/linux/gzvm_common.h
@@ -183,6 +183,38 @@ struct gzvm_userspace_memory_region {
 #define GZVM_IRQ_CPU_IRQ		0
 #define GZVM_IRQ_CPU_FIQ		1
 
+struct gzvm_irq_level {
+	union {
+		__u32 irq;
+		__s32 status;
+	};
+	__u32 level;
+};
+#define GZVM_IRQ_LINE              _IOW(GZVM_IOC_MAGIC,  0x61, \
+					struct gzvm_irq_level)
+
+enum gzvm_device_type {
+	GZVM_DEV_TYPE_ARM_VGIC_V3_DIST,
+	GZVM_DEV_TYPE_ARM_VGIC_V3_REDIST,
+	GZVM_DEV_TYPE_MAX,
+};
+
+struct gzvm_create_device {
+	__u32 dev_type;			/* device type */
+	__u32 id;			/* out: device id */
+	__u64 flags;			/* device specific flags */
+	__u64 dev_addr;			/* device ipa address in VM's view */
+	__u64 dev_reg_size;		/* device register range size */
+	/*
+	 * If user -> kernel, this is user virtual address of device specific
+	 * attributes (if needed). If kernel->hypervisor, this is ipa.
+	 */
+	__u64 attr_addr;
+	__u64 attr_size;		/* size of device specific attributes */
+};
+#define GZVM_CREATE_DEVICE	   _IOWR(GZVM_IOC_MAGIC,  0xe0, \
+					struct gzvm_create_device)
+
 /*
  * ioctls for vcpu fds
  */
-- 
2.18.0

