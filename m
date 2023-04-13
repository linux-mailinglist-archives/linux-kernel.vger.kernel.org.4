Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9CF6E09C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDMJIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjDMJIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:08:32 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5372B5;
        Thu, 13 Apr 2023 02:08:13 -0700 (PDT)
X-UUID: b2afe1d6d9da11edb6b9f13eb10bd0fe-20230413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=olRRmiU1/pTF0B/8ckrG+n+5m4jMa0/aKWyzDPOZNvw=;
        b=dUm/YN/hBDyTGRg3yAx8RLV80ynL1F+XOdbgRfBsmoHFpjYdGz7C7/s0q6AtorWI6bJLQ/UY+rO1EdPgIj3oA0JxoQuuYOomH+qBiiYoRXVgzytOYLr8pSA7GwIr6eg7cG8OOYXVivAsQpYhWG607QpR5/+U2BstssrSLaSL5wE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:afd53fbd-ddf6-441d-bfa8-349f7a9e0784,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.22,REQID:afd53fbd-ddf6-441d-bfa8-349f7a9e0784,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:120426c,CLOUDID:48cfef83-cd9c-45f5-8134-710979e3df0e,B
        ulkID:230413170806V7S30LKE,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: b2afe1d6d9da11edb6b9f13eb10bd0fe-20230413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 925928137; Thu, 13 Apr 2023 17:08:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
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
Subject: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce GenieZone hypervisor support
Date:   Thu, 13 Apr 2023 17:07:32 +0800
Message-ID: <20230413090735.4182-4-yi-de.wu@mediatek.com>
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

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. This patch exports a set of
ioctl interfaces for userspace VMM (e.g., crosvm) to operate guest VMs
lifecycle (creation, running, and destroy) on GenieZone.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/include/uapi/asm/gzvm_arch.h       |  79 ++++
 drivers/soc/mediatek/Kconfig                  |   2 +
 drivers/soc/mediatek/Makefile                 |   1 +
 drivers/soc/mediatek/virt/geniezone/Kconfig   |  17 +
 drivers/soc/mediatek/virt/geniezone/Makefile  |   5 +
 drivers/soc/mediatek/virt/geniezone/gzvm.h    | 103 ++++
 .../soc/mediatek/virt/geniezone/gzvm_hyp.h    |  72 +++
 .../soc/mediatek/virt/geniezone/gzvm_main.c   | 233 +++++++++
 .../soc/mediatek/virt/geniezone/gzvm_vcpu.c   | 266 +++++++++++
 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c | 444 ++++++++++++++++++
 include/uapi/linux/gzvm_common.h              | 217 +++++++++
 11 files changed, 1439 insertions(+)
 create mode 100644 arch/arm64/include/uapi/asm/gzvm_arch.h
 create mode 100644 drivers/soc/mediatek/virt/geniezone/Kconfig
 create mode 100644 drivers/soc/mediatek/virt/geniezone/Makefile
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm.h
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_hyp.h
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_main.c
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
 create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
 create mode 100644 include/uapi/linux/gzvm_common.h

diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
new file mode 100644
index 000000000000..3714f96c832b
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZVM_ARCH_H__
+#define __GZVM_ARCH_H__
+
+#include <asm/ptrace.h>
+
+/*
+ * Architecture specific registers are to be defined in arch headers and
+ * ORed with the arch identifier.
+ */
+#define GZVM_REG_ARM		0x4000000000000000ULL
+#define GZVM_REG_ARM64		0x6000000000000000ULL
+
+#define GZVM_REG_SIZE_SHIFT	52
+#define GZVM_REG_SIZE_MASK	0x00f0000000000000ULL
+#define GZVM_REG_SIZE_U8	0x0000000000000000ULL
+#define GZVM_REG_SIZE_U16	0x0010000000000000ULL
+#define GZVM_REG_SIZE_U32	0x0020000000000000ULL
+#define GZVM_REG_SIZE_U64	0x0030000000000000ULL
+#define GZVM_REG_SIZE_U128	0x0040000000000000ULL
+#define GZVM_REG_SIZE_U256	0x0050000000000000ULL
+#define GZVM_REG_SIZE_U512	0x0060000000000000ULL
+#define GZVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define GZVM_REG_SIZE_U2048	0x0080000000000000ULL
+
+#define GZVM_NR_SPSR	5
+struct gzvm_regs {
+	struct user_pt_regs regs;	/* sp = sp_el0 */
+
+	__u64	sp_el1;
+	__u64	elr_el1;
+
+	__u64	spsr[GZVM_NR_SPSR];
+
+	struct user_fpsimd_state fp_regs;
+};
+
+/* If you need to interpret the index values, here is the key: */
+#define GZVM_REG_ARM_COPROC_MASK	0x000000000FFF0000
+#define GZVM_REG_ARM_COPROC_SHIFT	16
+
+/* Normal registers are mapped as coprocessor 16. */
+#define GZVM_REG_ARM_CORE		(0x0010 << GZVM_REG_ARM_COPROC_SHIFT)
+#define GZVM_REG_ARM_CORE_REG(name)	(offsetof(struct gzvm_regs, name) / sizeof(__u32))
+
+/* Some registers need more space to represent values. */
+#define GZVM_REG_ARM_DEMUX		(0x0011 << GZVM_REG_ARM_COPROC_SHIFT)
+#define GZVM_REG_ARM_DEMUX_ID_MASK	0x000000000000FF00
+#define GZVM_REG_ARM_DEMUX_ID_SHIFT	8
+#define GZVM_REG_ARM_DEMUX_ID_CCSIDR	(0x00 << GZVM_REG_ARM_DEMUX_ID_SHIFT)
+#define GZVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
+#define GZVM_REG_ARM_DEMUX_VAL_SHIFT	0
+
+/* AArch64 system registers */
+#define GZVM_REG_ARM64_SYSREG		(0x0013 << GZVM_REG_ARM_COPROC_SHIFT)
+#define GZVM_REG_ARM64_SYSREG_OP0_MASK	0x000000000000c000
+#define GZVM_REG_ARM64_SYSREG_OP0_SHIFT	14
+#define GZVM_REG_ARM64_SYSREG_OP1_MASK	0x0000000000003800
+#define GZVM_REG_ARM64_SYSREG_OP1_SHIFT	11
+#define GZVM_REG_ARM64_SYSREG_CRN_MASK	0x0000000000000780
+#define GZVM_REG_ARM64_SYSREG_CRN_SHIFT	7
+#define GZVM_REG_ARM64_SYSREG_CRM_MASK	0x0000000000000078
+#define GZVM_REG_ARM64_SYSREG_CRM_SHIFT	3
+#define GZVM_REG_ARM64_SYSREG_OP2_MASK	0x0000000000000007
+#define GZVM_REG_ARM64_SYSREG_OP2_SHIFT	0
+
+/* Physical Timer EL0 Registers */
+#define GZVM_REG_ARM_PTIMER_CTL		ARM64_SYS_REG(3, 3, 14, 2, 1)
+#define GZVM_REG_ARM_PTIMER_CVAL	ARM64_SYS_REG(3, 3, 14, 2, 2)
+#define GZVM_REG_ARM_PTIMER_CNT		ARM64_SYS_REG(3, 3, 14, 0, 1)
+
+/* SVE registers */
+#define GZVM_REG_ARM64_SVE		(0x0015 << KVM_REG_ARM_COPROC_SHIFT)
+
+#endif /* __GZVM_ARCH_H__ */
diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index a88cf04fc803..01fad024a1c1 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -91,4 +91,6 @@ config MTK_SVS
 	  chip process corner, temperatures and other factors. Then DVFS
 	  driver could apply SVS bank voltage to PMIC/Buck.
 
+source "drivers/soc/mediatek/virt/geniezone/Kconfig"
+
 endmenu
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 8c0ddacbcde8..e5d7225c1d08 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
 obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
 obj-$(CONFIG_MTK_SVS) += mtk-svs.o
+obj-$(CONFIG_MTK_GZVM) += virt/geniezone/
diff --git a/drivers/soc/mediatek/virt/geniezone/Kconfig b/drivers/soc/mediatek/virt/geniezone/Kconfig
new file mode 100644
index 000000000000..6fad3c30f8d9
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config MTK_GZVM
+	tristate "GenieZone Hypervisor driver for guest VM operation"
+	depends on ARM64
+	depends on KVM
+	help
+	  This driver, gzvm, enables to run guest VMs on MTK GenieZone
+	  hypervisor. It exports kvm-like interfaces for VMM (e.g., crosvm) in
+	  order to operate guest VMs on GenieZone hypervisor.
+
+	  GenieZone hypervisor now only supports MediaTek SoC and arm64
+	  architecture.
+
+	  Select M if you want it be built as a module (gzvm.ko).
+
+	  If unsure, say N.
diff --git a/drivers/soc/mediatek/virt/geniezone/Makefile b/drivers/soc/mediatek/virt/geniezone/Makefile
new file mode 100644
index 000000000000..e1dfbb9c568d
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+gzvm-y := gzvm_main.o gzvm_vm.o gzvm_vcpu.o
+
+obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm.h b/drivers/soc/mediatek/virt/geniezone/gzvm.h
new file mode 100644
index 000000000000..43f215d4b0da
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZVM_H__
+#define __GZVM_H__
+
+#include <linux/srcu.h>
+#include <linux/arm-smccc.h>
+#include <linux/gzvm_common.h>
+#include "gzvm_hyp.h"
+
+#define MODULE_NAME	"gzvm"
+#define GZVM_VCPU_MMAP_SIZE  PAGE_SIZE
+#define INVALID_VM_ID   0xffff
+
+/* VM's memory slot descriptor */
+struct gzvm_memslot {
+	u64 base_gfn;			/* begin of guest page frame */
+	unsigned long npages;		/* number of pages this slot covers */
+	unsigned long userspace_addr;	/* corresponding userspace va */
+	struct vm_area_struct *vma;	/* vma related to this userspace addr */
+	u32 flags;
+	u32 slot_id;
+};
+
+/* pre-declaration for circular reference in struct gzvm */
+struct gzvm_vcpu;
+
+struct gzvm {
+	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
+	struct mm_struct *mm; /* userspace tied to this vm */
+	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
+	struct mutex lock;
+	struct list_head vm_list;
+	struct list_head devices;
+	gzvm_id_t vm_id;
+
+	struct {
+		spinlock_t        lock;
+		struct list_head  items;
+		struct list_head  resampler_list;
+		struct mutex      resampler_lock;
+	} irqfds;
+	struct hlist_head irq_ack_notifier_list;
+	struct srcu_struct irq_srcu;
+	struct mutex irq_lock;
+};
+
+struct gzvm_vcpu {
+	struct gzvm *gzvm;
+	int vcpuid;
+	struct mutex lock;
+	struct gzvm_vcpu_run *run;
+	struct gzvm_vcpu_hwstate *hwstate;
+};
+
+/**
+ * allocate 2 pages for data sharing between driver and gz hypervisor
+ * |- page 0           -|- page 1      -|
+ * |gzvm_vcpu_run|......|hwstate|.......|
+ */
+#define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
+
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
+
+void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu);
+int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
+int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
+
+int gzvm_arm_get_reg(struct gzvm_vcpu *vcpu, const struct gzvm_one_reg *reg);
+int gzvm_arm_set_reg(struct gzvm_vcpu *vcpu, const struct gzvm_one_reg *reg);
+
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
+			 unsigned long a3, unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res);
+
+#define SMC_ENTITY_MTK			59
+#define GZVM_FUNCID_START		(0x1000)
+#define GZVM_HCALL_ID(func)				\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,	\
+			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
+
+#define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
+#define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
+#define MT_HVC_GZVM_CREATE_VCPU		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VCPU)
+#define MT_HVC_GZVM_DESTROY_VCPU	GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VCPU)
+#define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
+#define MT_HVC_GZVM_RUN			GZVM_HCALL_ID(GZVM_FUNC_RUN)
+#define MT_HVC_GZVM_GET_REGS		GZVM_HCALL_ID(GZVM_FUNC_GET_REGS)
+#define MT_HVC_GZVM_SET_REGS		GZVM_HCALL_ID(GZVM_FUNC_SET_REGS)
+#define MT_HVC_GZVM_GET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_GET_ONE_REG)
+#define MT_HVC_GZVM_SET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_SET_ONE_REG)
+#define MT_HVC_GZVM_IRQ_LINE		GZVM_HCALL_ID(GZVM_FUNC_IRQ_LINE)
+#define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
+#define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
+#define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
+
+int gz_err_to_errno(unsigned long err);
+
+#endif /* __GZVM_H__ */
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_hyp.h b/drivers/soc/mediatek/virt/geniezone/gzvm_hyp.h
new file mode 100644
index 000000000000..17dd3de5c285
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_hyp.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZ_ERR_H__
+#define __GZ_ERR_H__
+
+/**
+ * @brief Definitions of APIs between GenieZone hypervisor and driver
+ *
+ * These are not needed to be visible to uapi
+ */
+
+/* We need GenieZone specific error code in order to map to Linux errno */
+#define NO_ERROR                (0)
+#define ERR_NO_MEMORY           (-5)
+#define ERR_NOT_SUPPORTED       (-24)
+#define ERR_NOT_IMPLEMENTED     (-27)
+#define ERR_FAULT               (-40)
+
+static inline unsigned int
+assemble_vm_vcpu_tuple(gzvm_id_t vmid, gzvm_vcpu_id_t vcpuid)
+{
+	return ((unsigned int)vmid << 16 | vcpuid);
+}
+
+static inline gzvm_id_t get_vmid_from_tuple(unsigned int tuple)
+{
+	return (gzvm_id_t)(tuple >> 16);
+}
+
+static inline gzvm_vcpu_id_t get_vcpuid_from_tuple(unsigned int tuple)
+{
+	return (gzvm_vcpu_id_t) (tuple & 0xffff);
+}
+
+static inline void
+disassemble_vm_vcpu_tuple(unsigned int tuple, gzvm_id_t *vmid,
+			  gzvm_vcpu_id_t *vcpuid)
+{
+	*vmid = get_vmid_from_tuple(tuple);
+	*vcpuid = get_vcpuid_from_tuple(tuple);
+}
+
+/*
+ * The following data structures are for data transferring between driver and
+ * hypervisor
+ */
+
+/* align hypervisor definitions */
+#define GZVM_MAX_VCPUS		 8
+#define GZVM_MAX_MEM_REGION	10
+
+/* identical to ffa memory constituent */
+struct mem_region_addr_range {
+	/* The base IPA of the constituent memory region, aligned to 4 kiB */
+	__u64 address;
+	/* The number of 4 kiB pages in the constituent memory region. */
+	__u32 pg_cnt;
+	__u32 reserved;
+};
+
+struct gzvm_memory_region_ranges {
+	__u32 slot;
+	__u32 constituent_cnt;
+	__u64 total_pages;
+	__u64 gpa;
+	struct mem_region_addr_range constituents[];
+};
+
+#endif /* __GZ_ERR_H__ */
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_main.c b/drivers/soc/mediatek/virt/geniezone/gzvm_main.c
new file mode 100644
index 000000000000..1fabe4a579da
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_main.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/kdev_t.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include "gzvm.h"
+
+static void (*invoke_gzvm_fn)(unsigned long, unsigned long, unsigned long,
+			      unsigned long, unsigned long, unsigned long,
+			      unsigned long, unsigned long,
+			      struct arm_smccc_res *);
+
+static void gzvm_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
+		      unsigned long a3, unsigned long a4, unsigned long a5,
+		      unsigned long a6, unsigned long a7,
+		      struct arm_smccc_res *res)
+{
+	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+}
+
+static void gzvm_smc(unsigned long a0, unsigned long a1, unsigned long a2,
+		      unsigned long a3, unsigned long a4, unsigned long a5,
+		      unsigned long a6, unsigned long a7,
+		      struct arm_smccc_res *res)
+{
+	arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
+}
+
+static int gzvm_probe_conduit(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(MT_HVC_GZVM_PROBE, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 == 0) {
+		invoke_gzvm_fn = gzvm_hvc;
+		return 0;
+	}
+
+	arm_smccc_smc(MT_HVC_GZVM_PROBE, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 == 0) {
+		invoke_gzvm_fn = gzvm_smc;
+		return 0;
+	}
+
+	return -ENXIO;
+}
+
+/**
+ * @brief geniezone hypercall wrapper
+ * @return int geniezone's return value will be converted to Linux errno
+ */
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
+			 unsigned long a3, unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res)
+{
+	invoke_gzvm_fn(a0, a1, a2, a3, a4, a5, a6, a7, res);
+	return gz_err_to_errno(res->a0);
+}
+
+/**
+ * @brief Convert geniezone return value to standard errno
+ *
+ * @param err return value from geniezone hypercall (a0)
+ * @return int errno
+ */
+int gz_err_to_errno(unsigned long err)
+{
+	int gz_err = (int) err;
+
+	switch (gz_err) {
+	case 0:
+		return 0;
+	case ERR_NO_MEMORY:
+		return -ENOMEM;
+	case ERR_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	case ERR_NOT_IMPLEMENTED:
+		return -EOPNOTSUPP;
+	case ERR_FAULT:
+		return -EFAULT;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int gzvm_cap_arm_vm_ipa_size(void __user *argp)
+{
+	u64 value = CONFIG_ARM64_PA_BITS;
+
+	if (copy_to_user(argp, &value, sizeof(u64)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * @brief Check if given capability is support or not
+ *
+ * @param args in/out u64 pointer from userspace
+ * @retval 0: support, no error
+ * @retval -EOPNOTSUPP: not support
+ * @retval -EFAULT: failed to get data from userspace
+ */
+long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args)
+{
+	int ret = -EOPNOTSUPP;
+	__u64 cap, success = 1;
+	void __user *argp = (void __user *) args;
+
+	if (copy_from_user(&cap, argp, sizeof(uint64_t)))
+		return -EFAULT;
+
+	switch (cap) {
+	case GZVM_CAP_ARM_PROTECTED_VM:
+		if (copy_to_user(argp, &success, sizeof(uint64_t)))
+			return -EFAULT;
+		ret = 0;
+		break;
+	case GZVM_CAP_ARM_VM_IPA_SIZE:
+		ret = gzvm_cap_arm_vm_ipa_size(argp);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
+			    unsigned long user_args)
+{
+	long ret = -ENOTTY;
+
+	switch (cmd) {
+	case GZVM_CREATE_VM:
+		ret = gzvm_dev_ioctl_create_vm(user_args);
+		break;
+	case GZVM_CHECK_EXTENSION:
+		if (!user_args)
+			return -EINVAL;
+		ret = gzvm_dev_ioctl_check_extension(NULL, user_args);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	return ret;
+}
+
+static const struct file_operations gzvm_chardev_ops = {
+	.unlocked_ioctl = gzvm_dev_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice gzvm_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = MODULE_NAME,
+	.fops = &gzvm_chardev_ops,
+};
+
+static int gzvm_drv_probe(struct platform_device *pdev)
+{
+	if (!of_device_is_available(dev_of_node(&pdev->dev))) {
+		dev_info(&pdev->dev, "GenieZone hypervisor is not available\n");
+		return -ENODEV;
+	}
+
+	if (gzvm_probe_conduit() != 0) {
+		dev_err(&pdev->dev, "Not found available conduit\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int gzvm_drv_remove(struct platform_device *pdev)
+{
+	misc_deregister(&gzvm_dev);
+
+	return 0;
+}
+
+static const struct of_device_id gzvm_of_match[] = {
+	{ .compatible = "mediatek,gzvm", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gzvm_of_match);
+
+static struct platform_driver gzvm_driver = {
+	.probe = gzvm_drv_probe,
+	.remove = gzvm_drv_remove,
+	.driver = {
+			.name = MODULE_NAME,
+			.owner = THIS_MODULE,
+			.of_match_table = gzvm_of_match,
+	},
+};
+
+static int __init gzvm_init(void)
+{
+	int ret = 0;
+
+	ret = platform_driver_register(&gzvm_driver);
+	if (ret)
+		pr_err("Failed to register gzvm driver.\n");
+
+	return ret;
+}
+
+static void __exit gzvm_exit(void)
+{
+	platform_driver_unregister(&gzvm_driver);
+}
+
+module_init(gzvm_init);
+module_exit(gzvm_exit);
+
+MODULE_AUTHOR("MediaTek");
+MODULE_DESCRIPTION("GenieZone interface for VMM");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
new file mode 100644
index 000000000000..726db866dfcf
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <asm/sysreg.h>
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include "gzvm.h"
+
+static int gzvm_vcpu_update_one_reg_hyp(struct gzvm_vcpu *vcpu, __u64 reg_id,
+					bool is_write, __u64 *data)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+	int ret;
+
+	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	if (!is_write) {
+		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_GET_ONE_REG,
+					   a1, reg_id, 0, 0, 0, 0, 0, &res);
+		if (ret == 0)
+			*data = res.a1;
+	} else {
+		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_ONE_REG,
+					   a1, reg_id, *data, 0, 0, 0, 0, &res);
+	}
+
+	return ret;
+}
+
+static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, void * __user argp,
+				     bool is_write)
+{
+	long ret;
+	__u64 reg_size, data = 0;
+	struct gzvm_one_reg reg;
+	void __user *reg_addr;
+
+	if (copy_from_user(&reg, argp, sizeof(reg)))
+		return -EFAULT;
+	reg_addr = (void __user *)reg.addr;
+
+	/* reg id follows KVM's encoding */
+	switch (reg.id & GZVM_REG_ARM_COPROC_MASK) {
+	case GZVM_REG_ARM_CORE:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	reg_size = 1 << ((reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT);
+	if (is_write) {
+		if (copy_from_user(&data, reg_addr, reg_size))
+			return -EFAULT;
+	}
+
+	ret = gzvm_vcpu_update_one_reg_hyp(vcpu, reg.id, is_write, &data);
+
+	if (!is_write && ret == 0) {
+		if (copy_to_user(reg_addr, &data, reg_size))
+			return -EFAULT;
+	}
+
+	return ret;
+}
+
+/**
+ * @brief Handle vcpu run ioctl, entry point to guest and exit point from guest
+ *
+ * @param filp
+ * @param argp pointer to struct gzvm_vcpu_run in userspace
+ * @return long
+ */
+static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
+{
+	unsigned long id_tuple;
+	struct arm_smccc_res res;
+	bool need_userspace = false;
+
+	if (copy_from_user(vcpu->run, argp, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+
+	if (vcpu->run->immediate_exit == 1)
+		return -EINTR;
+
+	id_tuple = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	do {
+		gzvm_hypcall_wrapper(MT_HVC_GZVM_RUN, id_tuple, 0, 0, 0, 0, 0,
+				     0, &res);
+		switch (res.a1) {
+		case GZVM_EXIT_MMIO:
+			need_userspace = true;
+			break;
+		/*
+		 * geniezone's responsibility to fill corresponding data
+		 * structure
+		 */
+		case GZVM_EXIT_HVC:
+		case GZVM_EXIT_EXCEPTION:
+		case GZVM_EXIT_DEBUG:
+		case GZVM_EXIT_FAIL_ENTRY:
+		case GZVM_EXIT_INTERNAL_ERROR:
+		case GZVM_EXIT_SYSTEM_EVENT:
+		case GZVM_EXIT_SHUTDOWN:
+			need_userspace = true;
+			break;
+		case GZVM_EXIT_IRQ:
+			break;
+		case GZVM_EXIT_UNKNOWN:
+		default:
+			pr_err("vcpu unknown exit\n");
+			need_userspace = true;
+			goto out;
+		}
+	} while (!need_userspace);
+
+out:
+	if (copy_to_user(argp, vcpu->run, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+	return 0;
+}
+
+static long gzvm_vcpu_ioctl(struct file *filp, unsigned int ioctl,
+			    unsigned long arg)
+{
+	int ret = -ENOTTY;
+	void __user *argp = (void __user *)arg;
+	struct gzvm_vcpu *vcpu = filp->private_data;
+
+	switch (ioctl) {
+	case GZVM_RUN:
+		ret = gzvm_vcpu_run(vcpu, argp);
+		break;
+	case GZVM_GET_ONE_REG:
+		ret = gzvm_vcpu_update_one_reg(vcpu, argp, false /*is_write*/);
+		break;
+	case GZVM_SET_ONE_REG:
+		ret = gzvm_vcpu_update_one_reg(vcpu, argp, true  /*is_write*/);
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations gzvm_vcpu_fops = {
+	.unlocked_ioctl = gzvm_vcpu_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static int gzvm_destroy_vcpu_hyp(gzvm_id_t vm_id, int vcpuid)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+
+	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VCPU, a1, 0, 0, 0, 0, 0, 0,
+			     &res);
+
+	return 0;
+}
+
+/**
+ * @brief call smc to gz hypervisor to create vcpu
+ *
+ * @param run virtual address of vcpu->run
+ * @return int
+ */
+static int gzvm_create_vcpu_hyp(gzvm_id_t vm_id, int vcpuid, void *run)
+{
+	struct arm_smccc_res res;
+	unsigned long a1, a2;
+	int ret;
+
+	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
+	a2 = (__u64)virt_to_phys(run);
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VCPU, a1, a2, 0, 0, 0, 0,
+				   0, &res);
+
+	return ret;
+}
+
+/* Caller must hold the vm lock */
+void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
+{
+	if (!vcpu)
+		return;
+
+	gzvm_destroy_vcpu_hyp(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	/* clean guest's data */
+	memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
+	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
+	kfree(vcpu);
+}
+
+#define ITOA_MAX_LEN 12 /* Maximum size needed for holding an integer. */
+/**
+ * @brief Allocates an inode for the vcpu.
+ */
+static int create_vcpu_fd(struct gzvm_vcpu *vcpu)
+{
+	/* sizeof("gzvm-vcpu:") + max(strlen(itoa(vcpuid))) + null */
+	char name[10 + ITOA_MAX_LEN + 1];
+
+	snprintf(name, sizeof(name), "gzvm-vcpu:%d", vcpu->vcpuid);
+	return anon_inode_getfd(name, &gzvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
+}
+
+/**
+ * @brief GZVM_CREATE_VCPU
+ *
+ * @param cpuid = arg
+ * @return fd of vcpu, negative errno if error occurs
+ */
+int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
+{
+	struct gzvm_vcpu *vcpu;
+	int ret;
+
+	if (cpuid >= GZVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = kzalloc(sizeof(*vcpu), GFP_KERNEL);
+	if (!vcpu)
+		return -ENOMEM;
+
+	BUILD_BUG_ON((sizeof(*vcpu->run)) > PAGE_SIZE);
+	BUILD_BUG_ON(sizeof(struct gzvm_vcpu_hwstate) > PAGE_SIZE);
+	/**
+	 * allocate 2 pages for data sharing between driver and gz hypervisor
+	 * |- page 0           -|- page 1      -|
+	 * |gzvm_vcpu_run|......|hwstate|.......|
+	 */
+	vcpu->run = alloc_pages_exact(GZVM_VCPU_RUN_MAP_SIZE,
+				      GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!vcpu->run) {
+		ret = -ENOMEM;
+		goto free_vcpu;
+	}
+	vcpu->hwstate = (void *)vcpu->run + PAGE_SIZE;
+	vcpu->vcpuid = cpuid;
+	vcpu->gzvm = gzvm;
+	mutex_init(&vcpu->lock);
+
+	ret = gzvm_create_vcpu_hyp(gzvm->vm_id, vcpu->vcpuid, vcpu->run);
+	if (ret < 0)
+		goto free_vcpu_run;
+
+	ret = create_vcpu_fd(vcpu);
+	if (ret < 0)
+		goto free_vcpu_run;
+	gzvm->vcpus[cpuid] = vcpu;
+
+	return ret;
+
+free_vcpu_run:
+	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
+free_vcpu:
+	kfree(vcpu);
+	return ret;
+}
diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
new file mode 100644
index 000000000000..df4ccdc3b7f0
--- /dev/null
+++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/anon_inodes.h>
+#include <linux/arm-smccc.h>
+#include <linux/file.h>
+#include <linux/kdev_t.h>
+#include <linux/kvm_host.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/version.h>
+#include "gzvm.h"
+
+static DEFINE_MUTEX(gzvm_list_lock);
+static LIST_HEAD(gzvm_list);
+
+
+/**
+ * @brief Translate gfn (guest ipa) to pfn (host pa), result is in @pfn
+ *
+ * Leverage KVM's `gfn_to_pfn_memslot`. Because `gfn_to_pfn_memslot` needs
+ * kvm_memory_slot as parameter, this function populates necessary fileds
+ * for calling `gfn_to_pfn_memslot`.
+ *
+ * @retval 0 succeed
+ * @retval -EFAULT failed to convert
+ */
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
+{
+	hfn_t __pfn;
+	struct kvm_memory_slot kvm_slot = {0};
+
+	kvm_slot.base_gfn = memslot->base_gfn;
+	kvm_slot.npages = memslot->npages;
+	kvm_slot.dirty_bitmap = NULL;
+	kvm_slot.userspace_addr = memslot->userspace_addr;
+	kvm_slot.flags = memslot->flags;
+	kvm_slot.id = memslot->slot_id;
+	kvm_slot.as_id = 0;
+
+	__pfn = gfn_to_pfn_memslot(&kvm_slot, gfn);
+	if (is_error_noslot_pfn(__pfn)) {
+		*pfn = 0;
+		return -EFAULT;
+	}
+
+	*pfn = __pfn;
+	return 0;
+}
+
+/**
+ * @brief Populate pa to buffer until full
+ *
+ * @return int how much pages we've fill in, negative if error
+ */
+static int fill_constituents(struct mem_region_addr_range *consti,
+			     int *consti_cnt, int max_nr_consti, gfn_t gfn,
+			     u32 total_pages, struct gzvm_memslot *slot)
+{
+	int i, nr_pages;
+	hfn_t pfn, prev_pfn;
+	gfn_t gfn_end;
+
+	if (unlikely(total_pages == 0))
+		return -EINVAL;
+	gfn_end = gfn + total_pages;
+
+	/* entry 0 */
+	if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
+		return -EFAULT;
+	consti[0].address = PFN_PHYS(pfn);
+	consti[0].pg_cnt = 1;
+	gfn++;
+	prev_pfn = pfn;
+	i = 0;
+	nr_pages = 1;
+	while (i < max_nr_consti && gfn < gfn_end) {
+		if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
+			return -EFAULT;
+		if (pfn == (prev_pfn + 1)) {
+			consti[i].pg_cnt++;
+		} else {
+			i++;
+			if (i >= max_nr_consti)
+				break;
+			consti[i].address = PFN_PHYS(pfn);
+			consti[i].pg_cnt = 1;
+		}
+		prev_pfn = pfn;
+		gfn++;
+		nr_pages++;
+	}
+	if (i == max_nr_consti)
+		*consti_cnt = i;
+	else
+		*consti_cnt = (i + 1);
+
+	return nr_pages;
+}
+
+/**
+ * @brief Register memory region to GZ
+ *
+ * @param gzvm
+ * @param memslot
+ * @return int
+ */
+static int
+register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
+{
+	struct gzvm_memory_region_ranges *region;
+	u32 buf_size;
+	int max_nr_consti, remain_pages;
+	gfn_t gfn, gfn_end;
+
+	buf_size = PAGE_SIZE * 2;
+	region = alloc_pages_exact(buf_size, GFP_KERNEL);
+	if (!region)
+		return -ENOMEM;
+	max_nr_consti = (buf_size - sizeof(*region)) /
+			sizeof(struct mem_region_addr_range);
+
+	region->slot = memslot->slot_id;
+	remain_pages = memslot->npages;
+	gfn = memslot->base_gfn;
+	gfn_end = gfn + remain_pages;
+	while (gfn < gfn_end) {
+		struct arm_smccc_res res;
+		int nr_pages;
+
+		nr_pages = fill_constituents(region->constituents,
+					     &region->constituent_cnt,
+					     max_nr_consti, gfn,
+					     remain_pages, memslot);
+		region->gpa = PFN_PHYS(gfn);
+		region->total_pages = nr_pages;
+
+		remain_pages -= nr_pages;
+		gfn += nr_pages;
+
+		gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_MEMREGION, gzvm->vm_id,
+			     buf_size, virt_to_phys(region), 0, 0, 0, 0, &res);
+
+		if (res.a0 != 0) {
+			pr_err("Failed to register memregion to hypervisor\n");
+			free_pages_exact(region, buf_size);
+			return -EFAULT;
+		}
+	}
+	free_pages_exact(region, buf_size);
+	return 0;
+}
+
+/**
+ * @brief Set memory region of guest
+ *
+ * @param gzvm struct gzvm
+ * @param mem struct gzvm_userspace_memory_region: input from user
+ * @retval -EXIO memslot is out-of-range
+ * @retval -EFAULT  cannot find corresponding vma
+ * @retval -EINVAL  region size and vma size does not match
+ */
+static int gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
+				struct gzvm_userspace_memory_region *mem)
+{
+	struct vm_area_struct *vma;
+	struct gzvm_memslot *memslot;
+	unsigned long size;
+	__u32 slot;
+
+	slot = mem->slot;
+	if (slot >= GZVM_MAX_MEM_REGION)
+		return -ENXIO;
+	memslot = &gzvm->memslot[slot];
+
+	vma = vma_lookup(gzvm->mm, mem->userspace_addr);
+	if (!vma)
+		return -EFAULT;
+
+	size = vma->vm_end - vma->vm_start;
+	if (size != mem->memory_size)
+		return -EINVAL;
+
+	memslot->base_gfn = __phys_to_pfn(mem->guest_phys_addr);
+	memslot->npages = size >> PAGE_SHIFT;
+	memslot->userspace_addr = mem->userspace_addr;
+	memslot->vma = vma;
+	memslot->flags = mem->flags;
+	memslot->slot_id = mem->slot;
+	return register_memslot_addr_range(gzvm, memslot);
+}
+
+static int gzvm_vm_enable_cap_hyp(struct gzvm *gzvm,
+				  struct gzvm_enable_cap *cap,
+				  struct arm_smccc_res *res)
+{
+	int ret;
+
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, gzvm->vm_id,
+				   cap->cap, cap->args[0], cap->args[1],
+				   cap->args[2], cap->args[3], cap->args[4],
+				   res);
+	return ret;
+}
+
+/**
+ * @brief Get pvmfw size from hypervisor, return in x1, and return to userspace
+ *        in args[1].
+ * @retval 0 succeed
+ * @retval -EINVAL hypervisor return invalid results
+ * @retval -EFAULT fail to copy back to userspace buffer
+ */
+static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
+					struct gzvm_enable_cap *cap,
+					void __user *argp)
+{
+	struct arm_smccc_res res = {0};
+
+	if (gzvm_vm_enable_cap_hyp(gzvm, cap, &res) != 0)
+		return -EINVAL;
+
+	cap->args[1] = res.a1;
+	if (copy_to_user(argp, cap, sizeof(*cap)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/**
+ * @brief Proceed GZVM_CAP_ARM_PROTECTED_VM's subcommands
+ * @retval 0 succeed
+ * @retval -EINVAL invalid subcommand or arguments
+ */
+static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm, struct gzvm_enable_cap *cap,
+				 void __user *argp)
+{
+	int ret = -EINVAL;
+	struct arm_smccc_res res = {0};
+
+	switch (cap->args[0]) {
+	case GZVM_CAP_ARM_PVM_SET_PVMFW_IPA:
+		ret = gzvm_vm_enable_cap_hyp(gzvm, cap, &res);
+		break;
+	case GZVM_CAP_ARM_PVM_GET_PVMFW_SIZE:
+		ret = gzvm_vm_ioctl_get_pvmfw_size(gzvm, cap, argp);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
+				    struct gzvm_enable_cap *cap,
+				    void __user *argp)
+{
+	int ret = -EINVAL;
+
+	switch (cap->cap) {
+	case GZVM_CAP_ARM_PROTECTED_VM:
+		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * @brief ioctl handler of VM FD
+ */
+static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
+			  unsigned long arg)
+{
+	long ret = -ENOTTY;
+	void __user *argp = (void __user *)arg;
+	struct gzvm *gzvm = filp->private_data;
+
+	switch (ioctl) {
+	case GZVM_CHECK_EXTENSION:
+		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
+		break;
+	case GZVM_CREATE_VCPU:
+		ret = gzvm_vm_ioctl_create_vcpu(gzvm, arg);
+		break;
+	case GZVM_SET_USER_MEMORY_REGION: {
+		struct gzvm_userspace_memory_region userspace_mem;
+
+		ret = -EFAULT;
+		if (copy_from_user(&userspace_mem, argp,
+						sizeof(userspace_mem)))
+			goto out;
+		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
+		break;
+	}
+	case GZVM_ENABLE_CAP: {
+		struct gzvm_enable_cap cap;
+
+		ret = -EFAULT;
+		if (copy_from_user(&cap, argp, sizeof(cap)))
+			goto out;
+
+		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
+		break;
+	}
+	default:
+		ret = -ENOTTY;
+	}
+out:
+	return ret;
+}
+
+/**
+ * @brief Destroy all vcpus
+ *
+ * @param gzvm vm struct that owns the vcpus
+ * Caller has to hold the vm lock
+ */
+static void gzvm_destroy_vcpus(struct gzvm *gzvm)
+{
+	int i;
+
+	for (i = 0; i < GZVM_MAX_VCPUS; i++) {
+		gzvm_destroy_vcpu(gzvm->vcpus[i]);
+		gzvm->vcpus[i] = NULL;
+	}
+}
+
+static int gzvm_destroy_vm_hyp(gzvm_id_t vm_id)
+{
+	struct arm_smccc_res res;
+
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VM, vm_id, 0, 0, 0, 0, 0, 0,
+			     &res);
+
+	return 0;
+}
+
+static void gzvm_destroy_vm(struct gzvm *gzvm)
+{
+	pr_info("VM-%u is going to be destroyed\n", gzvm->vm_id);
+
+	mutex_lock(&gzvm->lock);
+
+	gzvm_destroy_vcpus(gzvm);
+	gzvm_destroy_vm_hyp(gzvm->vm_id);
+
+	mutex_lock(&gzvm_list_lock);
+	list_del(&gzvm->vm_list);
+	mutex_unlock(&gzvm_list_lock);
+
+	mutex_unlock(&gzvm->lock);
+
+	kfree(gzvm);
+}
+
+static int gzvm_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gzvm *gzvm = filp->private_data;
+
+	gzvm_destroy_vm(gzvm);
+	return 0;
+}
+
+static const struct file_operations gzvm_vm_fops = {
+	.release        = gzvm_vm_release,
+	.unlocked_ioctl = gzvm_vm_ioctl,
+	.llseek		= noop_llseek,
+};
+
+static int gzvm_create_vm_hyp(void)
+{
+	struct arm_smccc_res res;
+
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VM, 0, 0, 0, 0, 0, 0, 0, &res);
+
+	if (res.a0 != 0)
+		return -EFAULT;
+	return res.a1;
+}
+
+static struct gzvm *gzvm_create_vm(unsigned long vm_type)
+{
+	int ret;
+	struct gzvm *gzvm;
+
+	gzvm = kzalloc(sizeof(struct gzvm), GFP_KERNEL);
+	if (!gzvm)
+		return ERR_PTR(-ENOMEM);
+
+	ret = gzvm_create_vm_hyp();
+	if (ret < 0)
+		goto err;
+
+	gzvm->vm_id = ret;
+	gzvm->mm = current->mm;
+	mutex_init(&gzvm->lock);
+	INIT_LIST_HEAD(&gzvm->devices);
+	mutex_init(&gzvm->irq_lock);
+	pr_info("VM-%u is created\n", gzvm->vm_id);
+
+	mutex_lock(&gzvm_list_lock);
+	list_add(&gzvm->vm_list, &gzvm_list);
+	mutex_unlock(&gzvm_list_lock);
+
+	return gzvm;
+
+err:
+	kfree(gzvm);
+	return ERR_PTR(ret);
+}
+
+/**
+ * @brief create vm fd
+ *
+ * @param vm_type
+ * @return int fd of vm, negative if error
+ */
+int gzvm_dev_ioctl_create_vm(unsigned long vm_type)
+{
+	struct gzvm *gzvm;
+	int ret;
+
+	gzvm = gzvm_create_vm(vm_type);
+	if (IS_ERR(gzvm)) {
+		ret = PTR_ERR(gzvm);
+		goto error;
+	}
+
+	ret = anon_inode_getfd("gzvm-vm", &gzvm_vm_fops, gzvm,
+			       O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto error;
+
+error:
+	return ret;
+}
diff --git a/include/uapi/linux/gzvm_common.h b/include/uapi/linux/gzvm_common.h
new file mode 100644
index 000000000000..aa97438bab8c
--- /dev/null
+++ b/include/uapi/linux/gzvm_common.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZVM_COMMON_H__
+#define __GZVM_COMMON_H__
+
+#include <linux/const.h>
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+/* gzvm only supports aarch64 platform */
+#if defined(__aarch64__)
+#include <asm/gzvm_arch.h>
+#endif
+
+/**
+ * @brief This file declares common data structure shared between userspace,
+ *        kernel space, and GZ.
+ */
+enum {
+	GZVM_FUNC_CREATE_VM = 0,
+	GZVM_FUNC_DESTROY_VM,
+	GZVM_FUNC_CREATE_VCPU,
+	GZVM_FUNC_DESTROY_VCPU,
+	GZVM_FUNC_SET_MEMREGION,
+	GZVM_FUNC_RUN,
+	GZVM_FUNC_GET_REGS,
+	GZVM_FUNC_SET_REGS,
+	GZVM_FUNC_GET_ONE_REG,
+	GZVM_FUNC_SET_ONE_REG,
+	GZVM_FUNC_IRQ_LINE,
+	GZVM_FUNC_CREATE_DEVICE,
+	GZVM_FUNC_PROBE,
+	GZVM_FUNC_ENABLE_CAP,
+	NR_GZVM_FUNC
+};
+
+typedef __u16 gzvm_id_t;
+typedef __u16 gzvm_vcpu_id_t;
+
+/* VM exit reason */
+enum {
+	GZVM_EXIT_UNKNOWN = 0x92920000,
+	GZVM_EXIT_MMIO,
+	GZVM_EXIT_HVC,
+	GZVM_EXIT_IRQ,
+	GZVM_EXIT_EXCEPTION,
+	GZVM_EXIT_DEBUG,
+	GZVM_EXIT_FAIL_ENTRY,
+	GZVM_EXIT_INTERNAL_ERROR,
+	GZVM_EXIT_SYSTEM_EVENT,
+	GZVM_EXIT_SHUTDOWN,
+};
+
+/**
+ * @brief same purpose as kvm_run, this struct is shared between userspace,
+ *	kernel and GZ
+ * Note: keep identical layout between the 3 modules
+ */
+struct gzvm_vcpu_run {
+	/* to userspace */
+	__u32 exit_reason;
+	__u8 immediate_exit;
+	__u8 padding1[3];
+	/* union structure of collection of guest exit reason */
+	union {
+		/* GZVM_EXIT_MMIO */
+		struct {
+			__u64 phys_addr;		/* from FAR_EL2 */
+			__u8 data[8];
+			__u64 size;			/* from ESR_EL2 as */
+			__u32 reg_nr;			/* from ESR_EL2 */
+			__u8 is_write;			/* from ESR_EL2 */
+		} mmio;
+		/* GZVM_EXIT_FAIL_ENTRY */
+		struct {
+			__u64 hardware_entry_failure_reason;
+			__u32 cpu;
+		} fail_entry;
+		/* GZVM_EXIT_EXCEPTION */
+		struct {
+			__u32 exception;
+			__u32 error_code;
+		} exception;
+		/* GZVM_EXIT_HVC */
+		struct {
+			__u64 args[8];	/* in-out */
+		} hvc;
+		/* GZVM_EXIT_INTERNAL_ERROR */
+		struct {
+			__u32 suberror;
+			__u32 ndata;
+			__u64 data[16];
+		} internal;
+		/* GZVM_EXIT_SYSTEM_EVENT */
+		struct {
+#define GZVM_SYSTEM_EVENT_SHUTDOWN       1
+#define GZVM_SYSTEM_EVENT_RESET          2
+#define GZVM_SYSTEM_EVENT_CRASH          3
+#define GZVM_SYSTEM_EVENT_WAKEUP         4
+#define GZVM_SYSTEM_EVENT_SUSPEND        5
+#define GZVM_SYSTEM_EVENT_SEV_TERM       6
+#define GZVM_SYSTEM_EVENT_S2IDLE         7
+			__u32 type;
+			__u32 ndata;
+			__u64 data[16];
+		} system_event;
+		/* Fix the size of the union. */
+		char padding[256];
+	};
+};
+
+#define GIC_V3_NR_LRS		16
+
+struct gzvm_vcpu_hwstate {
+	__u32 nr_lrs;
+	__u64 lr[GIC_V3_NR_LRS];
+};
+
+/* GZVM ioctls */
+#define GZVM_IOC_MAGIC			0x92	/* gz */
+
+/*
+ * ioctls for /dev/gzvm fds:
+ */
+#define GZVM_GET_API_VERSION       _IO(GZVM_IOC_MAGIC,   0x00)
+#define GZVM_CREATE_VM             _IO(GZVM_IOC_MAGIC,   0x01)
+
+#define GZVM_CAP_ARM_VM_IPA_SIZE	165
+#define GZVM_CAP_ARM_PROTECTED_VM	0xffbadab1
+
+#define GZVM_CHECK_EXTENSION       _IO(GZVM_IOC_MAGIC,   0x03)
+
+/*
+ * ioctls for VM fds
+ */
+
+/* for GZVM_SET_MEMORY_REGION */
+struct gzvm_memory_region {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+};
+#define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
+					struct gzvm_memory_region)
+/*
+ * GZVM_CREATE_VCPU receives as a parameter the vcpu slot, and returns
+ * a vcpu fd.
+ */
+#define GZVM_CREATE_VCPU           _IO(GZVM_IOC_MAGIC,   0x41)
+
+/* for GZVM_SET_USER_MEMORY_REGION */
+struct gzvm_userspace_memory_region {
+	__u32 slot;
+	__u32 flags;
+	__u64 guest_phys_addr;
+	__u64 memory_size; /* bytes */
+	__u64 userspace_addr; /* start of the userspace allocated memory */
+};
+#define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
+					struct gzvm_userspace_memory_region)
+
+/* for GZVM_IRQ_LINE */
+/* GZVM_IRQ_LINE irq field index values */
+#define GZVM_IRQ_VCPU2_SHIFT		28
+#define GZVM_IRQ_VCPU2_MASK		0xf
+#define GZVM_IRQ_TYPE_SHIFT		24
+#define GZVM_IRQ_TYPE_MASK		0xf
+#define GZVM_IRQ_VCPU_SHIFT		16
+#define GZVM_IRQ_VCPU_MASK		0xff
+#define GZVM_IRQ_NUM_SHIFT		0
+#define GZVM_IRQ_NUM_MASK		0xffff
+
+/* irq_type field */
+#define GZVM_IRQ_TYPE_CPU		0
+#define GZVM_IRQ_TYPE_SPI		1
+#define GZVM_IRQ_TYPE_PPI		2
+
+/* out-of-kernel GIC cpu interrupt injection irq_number field */
+#define GZVM_IRQ_CPU_IRQ		0
+#define GZVM_IRQ_CPU_FIQ		1
+
+/*
+ * ioctls for vcpu fds
+ */
+#define GZVM_RUN                   _IO(GZVM_IOC_MAGIC,   0x80)
+
+/* sub-commands put in args[0] for GZVM_CAP_ARM_PROTECTED_VM */
+#define GZVM_CAP_ARM_PVM_SET_PVMFW_IPA		0
+#define GZVM_CAP_ARM_PVM_GET_PVMFW_SIZE		1
+
+/* for GZVM_ENABLE_CAP */
+struct gzvm_enable_cap {
+	/* in */
+	__u64 cap;
+	/* we have total 5 (8 - 3) registers can be used for additional args */
+	__u64 args[5];
+};
+#define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
+					struct gzvm_enable_cap)
+
+struct gzvm_one_reg {
+	__u64 id;
+	__u64 addr;
+};
+#define GZVM_GET_ONE_REG	   _IOW(GZVM_IOC_MAGIC,  0xab, \
+					struct gzvm_one_reg)
+#define GZVM_SET_ONE_REG	   _IOW(GZVM_IOC_MAGIC,  0xac, \
+					struct gzvm_one_reg)
+
+#define GZVM_REG_ARCH_MASK	0xff00000000000000ULL
+#define GZVM_REG_GENERIC	0x0000000000000000ULL
+
+#endif /* __GZVM_COMMON_H__ */
-- 
2.18.0

