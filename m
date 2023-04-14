Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FFB6E22AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjDNLxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjDNLx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:53:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4C130FA;
        Fri, 14 Apr 2023 04:53:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDB966603009;
        Fri, 14 Apr 2023 12:53:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681473202;
        bh=Cf7EzpApAehslzo/7OvMEv+4AKA/zVBFA15q8Ga0kD0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Vv5Iwpc9C4kTs0amsJb1UAjcSxVHA9WLkiubTpOYEnz5rH5vFYinwajdDfIzk6XHg
         Jc3+XTfRGzfx0U2iPvCVOd5Br29tJbdYWRvnyfER5h+lWH4IJ976CQYl4EtvWDCDTu
         G7CETRBn7IKy1TgcTZaVtlE4aJTQfpQ9OqJyJiYa++MjLEy29pwn5SjHXm5iJY0+Km
         +4eA6b8lvnrH1p9qV8EbJ7X/1bkUsuzfpwyoviMQIxthk5Y30gMR3gHRP+4JToYQqr
         TcZoiL7eNsF2IFusphQzcACdsz58lIjw3P5MDAdxuPGbb7TLpRjFnPWcsPS11xDwO4
         23BGmEq/Phtlg==
Message-ID: <ab588466-abdb-42bd-d81b-f7c16c17ef01@collabora.com>
Date:   Fri, 14 Apr 2023 13:53:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Content-Language: en-US
To:     Yi-De Wu <yi-de.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jades Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
 <20230413090735.4182-4-yi-de.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230413090735.4182-4-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 11:07, Yi-De Wu ha scritto:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
> 
> GenieZone is MediaTek proprietary hypervisor solution, and it is running
> in EL2 stand alone as a type-I hypervisor. This patch exports a set of
> ioctl interfaces for userspace VMM (e.g., crosvm) to operate guest VMs
> lifecycle (creation, running, and destroy) on GenieZone.
> 
> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> ---
>   arch/arm64/include/uapi/asm/gzvm_arch.h       |  79 ++++
>   drivers/soc/mediatek/Kconfig                  |   2 +
>   drivers/soc/mediatek/Makefile                 |   1 +
>   drivers/soc/mediatek/virt/geniezone/Kconfig   |  17 +
>   drivers/soc/mediatek/virt/geniezone/Makefile  |   5 +
>   drivers/soc/mediatek/virt/geniezone/gzvm.h    | 103 ++++
>   .../soc/mediatek/virt/geniezone/gzvm_hyp.h    |  72 +++
>   .../soc/mediatek/virt/geniezone/gzvm_main.c   | 233 +++++++++
>   .../soc/mediatek/virt/geniezone/gzvm_vcpu.c   | 266 +++++++++++
>   drivers/soc/mediatek/virt/geniezone/gzvm_vm.c | 444 ++++++++++++++++++
>   include/uapi/linux/gzvm_common.h              | 217 +++++++++
>   11 files changed, 1439 insertions(+)
>   create mode 100644 arch/arm64/include/uapi/asm/gzvm_arch.h
>   create mode 100644 drivers/soc/mediatek/virt/geniezone/Kconfig
>   create mode 100644 drivers/soc/mediatek/virt/geniezone/Makefile
>   create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm.h
>   create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_hyp.h
>   create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_main.c
>   create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
>   create mode 100644 drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
>   create mode 100644 include/uapi/linux/gzvm_common.h
> 
> diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
> new file mode 100644
> index 000000000000..3714f96c832b
> --- /dev/null
> +++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZVM_ARCH_H__
> +#define __GZVM_ARCH_H__
> +
> +#include <asm/ptrace.h>
> +
> +/*
> + * Architecture specific registers are to be defined in arch headers and
> + * ORed with the arch identifier.
> + */
> +#define GZVM_REG_ARM		0x4000000000000000ULL
> +#define GZVM_REG_ARM64		0x6000000000000000ULL
> +
> +#define GZVM_REG_SIZE_SHIFT	52
> +#define GZVM_REG_SIZE_MASK	0x00f0000000000000ULL
> +#define GZVM_REG_SIZE_U8	0x0000000000000000ULL
> +#define GZVM_REG_SIZE_U16	0x0010000000000000ULL
> +#define GZVM_REG_SIZE_U32	0x0020000000000000ULL
> +#define GZVM_REG_SIZE_U64	0x0030000000000000ULL
> +#define GZVM_REG_SIZE_U128	0x0040000000000000ULL
> +#define GZVM_REG_SIZE_U256	0x0050000000000000ULL
> +#define GZVM_REG_SIZE_U512	0x0060000000000000ULL
> +#define GZVM_REG_SIZE_U1024	0x0070000000000000ULL
> +#define GZVM_REG_SIZE_U2048	0x0080000000000000ULL
> +
> +#define GZVM_NR_SPSR	5
> +struct gzvm_regs {
> +	struct user_pt_regs regs;	/* sp = sp_el0 */
> +
> +	__u64	sp_el1;
> +	__u64	elr_el1;
> +
> +	__u64	spsr[GZVM_NR_SPSR];
> +
> +	struct user_fpsimd_state fp_regs;
> +};
> +
> +/* If you need to interpret the index values, here is the key: */
> +#define GZVM_REG_ARM_COPROC_MASK	0x000000000FFF0000
> +#define GZVM_REG_ARM_COPROC_SHIFT	16
> +
> +/* Normal registers are mapped as coprocessor 16. */
> +#define GZVM_REG_ARM_CORE		(0x0010 << GZVM_REG_ARM_COPROC_SHIFT)
> +#define GZVM_REG_ARM_CORE_REG(name)	(offsetof(struct gzvm_regs, name) / sizeof(__u32))
> +
> +/* Some registers need more space to represent values. */
> +#define GZVM_REG_ARM_DEMUX		(0x0011 << GZVM_REG_ARM_COPROC_SHIFT)
> +#define GZVM_REG_ARM_DEMUX_ID_MASK	0x000000000000FF00
> +#define GZVM_REG_ARM_DEMUX_ID_SHIFT	8
> +#define GZVM_REG_ARM_DEMUX_ID_CCSIDR	(0x00 << GZVM_REG_ARM_DEMUX_ID_SHIFT)
> +#define GZVM_REG_ARM_DEMUX_VAL_MASK	0x00000000000000FF
> +#define GZVM_REG_ARM_DEMUX_VAL_SHIFT	0
> +
> +/* AArch64 system registers */
> +#define GZVM_REG_ARM64_SYSREG		(0x0013 << GZVM_REG_ARM_COPROC_SHIFT)
> +#define GZVM_REG_ARM64_SYSREG_OP0_MASK	0x000000000000c000
> +#define GZVM_REG_ARM64_SYSREG_OP0_SHIFT	14
> +#define GZVM_REG_ARM64_SYSREG_OP1_MASK	0x0000000000003800
> +#define GZVM_REG_ARM64_SYSREG_OP1_SHIFT	11
> +#define GZVM_REG_ARM64_SYSREG_CRN_MASK	0x0000000000000780
> +#define GZVM_REG_ARM64_SYSREG_CRN_SHIFT	7
> +#define GZVM_REG_ARM64_SYSREG_CRM_MASK	0x0000000000000078
> +#define GZVM_REG_ARM64_SYSREG_CRM_SHIFT	3
> +#define GZVM_REG_ARM64_SYSREG_OP2_MASK	0x0000000000000007
> +#define GZVM_REG_ARM64_SYSREG_OP2_SHIFT	0
> +
> +/* Physical Timer EL0 Registers */
> +#define GZVM_REG_ARM_PTIMER_CTL		ARM64_SYS_REG(3, 3, 14, 2, 1)
> +#define GZVM_REG_ARM_PTIMER_CVAL	ARM64_SYS_REG(3, 3, 14, 2, 2)
> +#define GZVM_REG_ARM_PTIMER_CNT		ARM64_SYS_REG(3, 3, 14, 0, 1)
> +
> +/* SVE registers */
> +#define GZVM_REG_ARM64_SVE		(0x0015 << KVM_REG_ARM_COPROC_SHIFT)
> +
> +#endif /* __GZVM_ARCH_H__ */
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index a88cf04fc803..01fad024a1c1 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -91,4 +91,6 @@ config MTK_SVS
>   	  chip process corner, temperatures and other factors. Then DVFS
>   	  driver could apply SVS bank voltage to PMIC/Buck.
>   
> +source "drivers/soc/mediatek/virt/geniezone/Kconfig"
> +
>   endmenu
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 8c0ddacbcde8..e5d7225c1d08 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
>   obj-$(CONFIG_MTK_SVS) += mtk-svs.o
> +obj-$(CONFIG_MTK_GZVM) += virt/geniezone/
> diff --git a/drivers/soc/mediatek/virt/geniezone/Kconfig b/drivers/soc/mediatek/virt/geniezone/Kconfig
> new file mode 100644
> index 000000000000..6fad3c30f8d9
> --- /dev/null
> +++ b/drivers/soc/mediatek/virt/geniezone/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config MTK_GZVM
> +	tristate "GenieZone Hypervisor driver for guest VM operation"
> +	depends on ARM64
> +	depends on KVM
> +	help
> +	  This driver, gzvm, enables to run guest VMs on MTK GenieZone
> +	  hypervisor. It exports kvm-like interfaces for VMM (e.g., crosvm) in
> +	  order to operate guest VMs on GenieZone hypervisor.
> +
> +	  GenieZone hypervisor now only supports MediaTek SoC and arm64
> +	  architecture.
> +
> +	  Select M if you want it be built as a module (gzvm.ko).
> +
> +	  If unsure, say N.
> diff --git a/drivers/soc/mediatek/virt/geniezone/Makefile b/drivers/soc/mediatek/virt/geniezone/Makefile
> new file mode 100644
> index 000000000000..e1dfbb9c568d
> --- /dev/null
> +++ b/drivers/soc/mediatek/virt/geniezone/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +gzvm-y := gzvm_main.o gzvm_vm.o gzvm_vcpu.o
> +
> +obj-$(CONFIG_MTK_GZVM) += gzvm.o
> diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm.h b/drivers/soc/mediatek/virt/geniezone/gzvm.h
> new file mode 100644
> index 000000000000..43f215d4b0da
> --- /dev/null
> +++ b/drivers/soc/mediatek/virt/geniezone/gzvm.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#ifndef __GZVM_H__
> +#define __GZVM_H__
> +
> +#include <linux/srcu.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/gzvm_common.h>
> +#include "gzvm_hyp.h"
> +
> +#define MODULE_NAME	"gzvm"
> +#define GZVM_VCPU_MMAP_SIZE  PAGE_SIZE
> +#define INVALID_VM_ID   0xffff
> +
> +/* VM's memory slot descriptor */

You've documented almost all of the members of this struct ... can you please
change that to kerneldoc?

/**
  * struct gzvm_memslot - VM memory slot descriptor
  * @base_qfn:       Base of guest page frame
  * @npages:         Number of pages this slot covers
  * @userspace_addr: Corresponding user-space VA
  * .....other members
  */

> +struct gzvm_memslot {
> +	u64 base_gfn;			/* begin of guest page frame */
> +	unsigned long npages;		/* number of pages this slot covers */
> +	unsigned long userspace_addr;	/* corresponding userspace va */
> +	struct vm_area_struct *vma;	/* vma related to this userspace addr */
> +	u32 flags;
> +	u32 slot_id;
> +};
> +
> +/* pre-declaration for circular reference in struct gzvm */
> +struct gzvm_vcpu;
> +

Same here, if you could add kerneldoc description to this struct, that would
be highly appreciated, as it would greatly increase human readability.

> +struct gzvm {
> +	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
> +	struct mm_struct *mm; /* userspace tied to this vm */
> +	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
> +	struct mutex lock;
> +	struct list_head vm_list;
> +	struct list_head devices;
> +	gzvm_id_t vm_id;
> +
> +	struct {
> +		spinlock_t        lock;
> +		struct list_head  items;
> +		struct list_head  resampler_list;
> +		struct mutex      resampler_lock;
> +	} irqfds;
> +	struct hlist_head irq_ack_notifier_list;
> +	struct srcu_struct irq_srcu;
> +	struct mutex irq_lock;
> +};
> +
> +struct gzvm_vcpu {
> +	struct gzvm *gzvm;
> +	int vcpuid;
> +	struct mutex lock;
> +	struct gzvm_vcpu_run *run;
> +	struct gzvm_vcpu_hwstate *hwstate;
> +};
> +
> +/**
> + * allocate 2 pages for data sharing between driver and gz hypervisor
> + * |- page 0           -|- page 1      -|
> + * |gzvm_vcpu_run|......|hwstate|.......|
> + */
> +#define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
> +
> +long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
> +
> +void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu);
> +int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
> +int gzvm_dev_ioctl_create_vm(unsigned long vm_type);
> +
> +int gzvm_arm_get_reg(struct gzvm_vcpu *vcpu, const struct gzvm_one_reg *reg);
> +int gzvm_arm_set_reg(struct gzvm_vcpu *vcpu, const struct gzvm_one_reg *reg);
> +
> +int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
> +			 unsigned long a3, unsigned long a4, unsigned long a5,
> +			 unsigned long a6, unsigned long a7,
> +			 struct arm_smccc_res *res);

Could you please keep function signatures after *all* definitions?

> +
> +#define SMC_ENTITY_MTK			59
> +#define GZVM_FUNCID_START		(0x1000)
> +#define GZVM_HCALL_ID(func)				\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32,	\
> +			   SMC_ENTITY_MTK, (GZVM_FUNCID_START + (func)))
> +
> +#define MT_HVC_GZVM_CREATE_VM		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VM)
> +#define MT_HVC_GZVM_DESTROY_VM		GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VM)
> +#define MT_HVC_GZVM_CREATE_VCPU		GZVM_HCALL_ID(GZVM_FUNC_CREATE_VCPU)
> +#define MT_HVC_GZVM_DESTROY_VCPU	GZVM_HCALL_ID(GZVM_FUNC_DESTROY_VCPU)
> +#define MT_HVC_GZVM_SET_MEMREGION	GZVM_HCALL_ID(GZVM_FUNC_SET_MEMREGION)
> +#define MT_HVC_GZVM_RUN			GZVM_HCALL_ID(GZVM_FUNC_RUN)
> +#define MT_HVC_GZVM_GET_REGS		GZVM_HCALL_ID(GZVM_FUNC_GET_REGS)
> +#define MT_HVC_GZVM_SET_REGS		GZVM_HCALL_ID(GZVM_FUNC_SET_REGS)
> +#define MT_HVC_GZVM_GET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_GET_ONE_REG)
> +#define MT_HVC_GZVM_SET_ONE_REG		GZVM_HCALL_ID(GZVM_FUNC_SET_ONE_REG)
> +#define MT_HVC_GZVM_IRQ_LINE		GZVM_HCALL_ID(GZVM_FUNC_IRQ_LINE)
> +#define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
> +#define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
> +#define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
> +

(move them all here)

> +int gz_err_to_errno(unsigned long err);
> +
> +#endif /* __GZVM_H__ */

..snip..

> diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_main.c b/drivers/soc/mediatek/virt/geniezone/gzvm_main.c
> new file mode 100644
> index 000000000000..1fabe4a579da
> --- /dev/null
> +++ b/drivers/soc/mediatek/virt/geniezone/gzvm_main.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/device.h>
> +#include <linux/file.h>
> +#include <linux/kdev_t.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include "gzvm.h"
> +
> +static void (*invoke_gzvm_fn)(unsigned long, unsigned long, unsigned long,
> +			      unsigned long, unsigned long, unsigned long,
> +			      unsigned long, unsigned long,
> +			      struct arm_smccc_res *);
> +
> +static void gzvm_hvc(unsigned long a0, unsigned long a1, unsigned long a2,
> +		      unsigned long a3, unsigned long a4, unsigned long a5,
> +		      unsigned long a6, unsigned long a7,
> +		      struct arm_smccc_res *res)
> +{
> +	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> +}
> +
> +static void gzvm_smc(unsigned long a0, unsigned long a1, unsigned long a2,
> +		      unsigned long a3, unsigned long a4, unsigned long a5,
> +		      unsigned long a6, unsigned long a7,
> +		      struct arm_smccc_res *res)
> +{
> +	arm_smccc_smc(a0, a1, a2, a3, a4, a5, a6, a7, res);
> +}

Why are you wrapping HVC and SMC functions? You're not doing anything special,
so you can simply call arm_amccc_{hvc,smc}() instead of specifying new wrappers.

Or are you worried about that changing signature all of a sudden?
This is not downstream, you don't have to worry about that. :-)

> +
> +static int gzvm_probe_conduit(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_hvc(MT_HVC_GZVM_PROBE, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0 == 0) {
> +		invoke_gzvm_fn = gzvm_hvc;

invoke_gzvm_fn = arm_smccc_hvc;

> +		return 0;
> +	}
> +
> +	arm_smccc_smc(MT_HVC_GZVM_PROBE, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (res.a0 == 0) {
> +		invoke_gzvm_fn = gzvm_smc;

invoke_gzvm_fn = arm_smccc_smc;

> +		return 0;
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +/**
> + * @brief geniezone hypercall wrapper
> + * @return int geniezone's return value will be converted to Linux errno
> + */

Kerneldoc please:

/**
  * gzvm_hypcall_wrapper() - GenieZone HyperCall wrapper
  * @a0: ...
  * @a1: ....
  * ......
  * Return: Zero for success, or a negative error number.
  *
  * The GenieZone return values are different from Linux error codes, hence
  * in case of error value, it is converted to a Linux negative error number.
  */

> +int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
> +			 unsigned long a3, unsigned long a4, unsigned long a5,
> +			 unsigned long a6, unsigned long a7,
> +			 struct arm_smccc_res *res)
> +{
> +	invoke_gzvm_fn(a0, a1, a2, a3, a4, a5, a6, a7, res);
> +	return gz_err_to_errno(res->a0);
> +}
> +
> +/**
> + * @brief Convert geniezone return value to standard errno
> + *
> + * @param err return value from geniezone hypercall (a0)
> + * @return int errno
> + */
> +int gz_err_to_errno(unsigned long err)
> +{
> +	int gz_err = (int) err;
> +
> +	switch (gz_err) {
> +	case 0:
> +		return 0;
> +	case ERR_NO_MEMORY:
> +		return -ENOMEM;
> +	case ERR_NOT_SUPPORTED:
> +		return -EOPNOTSUPP;
> +	case ERR_NOT_IMPLEMENTED:
> +		return -EOPNOTSUPP;
> +	case ERR_FAULT:
> +		return -EFAULT;
> +	default:

	default:
		break;
	}

	return -EINVAL;
};



> +
> +static int gzvm_cap_arm_vm_ipa_size(void __user *argp)
> +{
> +	u64 value = CONFIG_ARM64_PA_BITS;
> +
> +	if (copy_to_user(argp, &value, sizeof(u64)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/**
> + * @brief Check if given capability is support or not
> + *
> + * @param args in/out u64 pointer from userspace
> + * @retval 0: support, no error
> + * @retval -EOPNOTSUPP: not support
> + * @retval -EFAULT: failed to get data from userspace
> + */

kerneldoc again, please.

> +long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args)
> +{
> +	int ret = -EOPNOTSUPP;
> +	__u64 cap, success = 1;
> +	void __user *argp = (void __user *) args;
> +
> +	if (copy_from_user(&cap, argp, sizeof(uint64_t)))
> +		return -EFAULT;
> +
> +	switch (cap) {
> +	case GZVM_CAP_ARM_PROTECTED_VM:
> +		if (copy_to_user(argp, &success, sizeof(uint64_t)))
> +			return -EFAULT;
> +		ret = 0;
> +		break;
> +	case GZVM_CAP_ARM_VM_IPA_SIZE:
> +		ret = gzvm_cap_arm_vm_ipa_size(argp);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +	}
> +
> +	return ret;
> +}
> + > +static long gzvm_dev_ioctl(struct file *filp, unsigned int cmd,
> +			    unsigned long user_args)
> +{
> +	long ret = -ENOTTY;
> +
> +	switch (cmd) {
> +	case GZVM_CREATE_VM:
> +		ret = gzvm_dev_ioctl_create_vm(user_args);
> +		break;
> +	case GZVM_CHECK_EXTENSION:
> +		if (!user_args)
> +			return -EINVAL;
> +		ret = gzvm_dev_ioctl_check_extension(NULL, user_args);
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations gzvm_chardev_ops = {
> +	.unlocked_ioctl = gzvm_dev_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static struct miscdevice gzvm_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = MODULE_NAME,
> +	.fops = &gzvm_chardev_ops,
> +};
> +
> +static int gzvm_drv_probe(struct platform_device *pdev)
> +{
> +	if (!of_device_is_available(dev_of_node(&pdev->dev))) {

Uhm, is there something I don't get here?
This call looks odd; you're probing GZVM in this function....

> +		dev_info(&pdev->dev, "GenieZone hypervisor is not available\n");
> +		return -ENODEV;
> +	}
> +
> +	if (gzvm_probe_conduit() != 0) {
> +		dev_err(&pdev->dev, "Not found available conduit\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int gzvm_drv_remove(struct platform_device *pdev)
> +{
> +	misc_deregister(&gzvm_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id gzvm_of_match[] = {
> +	{ .compatible = "mediatek,gzvm", },

	{ .compatible = "mediatek,geniezone-hyp" },
or
	{ .compatible = "mediatek,geniezone" },

..makes it a bit more descriptive and human readable.

> +	{},

^^^ always end with { /* sentinel */ },

> +};
> +MODULE_DEVICE_TABLE(of, gzvm_of_match);
> +
> +static struct platform_driver gzvm_driver = {
> +	.probe = gzvm_drv_probe,
> +	.remove = gzvm_drv_remove,
> +	.driver = {
> +			.name = MODULE_NAME,
> +			.owner = THIS_MODULE,
> +			.of_match_table = gzvm_of_match,

Fix indentation please.

> +	},
> +};
> +
> +static int __init gzvm_init(void)

You don't need this at all, as all you're doing here is registering your platform
driver; and that's even a module_init(), so you can simply do

module_platform_driver(gzvm_driver);

...without open coding init/exit functions.

> +{
> +	int ret = 0;
> +
> +	ret = platform_driver_register(&gzvm_driver);
> +	if (ret)
> +		pr_err("Failed to register gzvm driver.\n");
> +
> +	return ret;
> +}
> +
> +static void __exit gzvm_exit(void)
> +{
> +	platform_driver_unregister(&gzvm_driver);
> +}
> +
> +module_init(gzvm_init);
> +module_exit(gzvm_exit);
> +
> +MODULE_AUTHOR("MediaTek");
> +MODULE_DESCRIPTION("GenieZone interface for VMM");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
> new file mode 100644
> index 000000000000..726db866dfcf
> --- /dev/null
> +++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vcpu.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <asm/sysreg.h>
> +#include <linux/anon_inodes.h>
> +#include <linux/file.h>
> +#include <linux/mm.h>
> +#include <linux/slab.h>
> +#include "gzvm.h"
> +
> +static int gzvm_vcpu_update_one_reg_hyp(struct gzvm_vcpu *vcpu, __u64 reg_id,
> +					bool is_write, __u64 *data)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long a1;
> +	int ret;
> +
> +	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
> +	if (!is_write) {
> +		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_GET_ONE_REG,
> +					   a1, reg_id, 0, 0, 0, 0, 0, &res);
> +		if (ret == 0)
> +			*data = res.a1;
> +	} else {
> +		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_ONE_REG,
> +					   a1, reg_id, *data, 0, 0, 0, 0, &res);
> +	}
> +
> +	return ret;
> +}
> +
> +static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, void * __user argp,
> +				     bool is_write)
> +{
> +	long ret;
> +	__u64 reg_size, data = 0;
> +	struct gzvm_one_reg reg;
> +	void __user *reg_addr;

Please reorder those variables.

	struct gzvm_one_reg reg;
	void __user *reg_addr;
	u64 data = 0;
	u64 reg_sz;
	long ret;

> +
> +	if (copy_from_user(&reg, argp, sizeof(reg)))
> +		return -EFAULT;
> +	reg_addr = (void __user *)reg.addr;
> +
> +	/* reg id follows KVM's encoding */
> +	switch (reg.id & GZVM_REG_ARM_COPROC_MASK) {
> +	case GZVM_REG_ARM_CORE:
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +

Make it more readable please...

	reg_size = (reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT;
	reg_size = BIT(reg_size);

...or, even better, you can use bitfield macros, such as FIELD_PREP(), which
would simplify that even more.

> +	reg_size = 1 << ((reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT);
> +	if (is_write) {
> +		if (copy_from_user(&data, reg_addr, reg_size))
> +			return -EFAULT;
> +	}
> +
> +	ret = gzvm_vcpu_update_one_reg_hyp(vcpu, reg.id, is_write, &data);
> +

	if (ret)
		return ret;

	if (!is_write) {
		if (copy_to_user.....)
			return -EFAULT;
	}

	return 0;

> +	if (!is_write && ret == 0) {
> +		if (copy_to_user(reg_addr, &data, reg_size))
> +			return -EFAULT;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * @brief Handle vcpu run ioctl, entry point to guest and exit point from guest
> + *
> + * @param filp
> + * @param argp pointer to struct gzvm_vcpu_run in userspace
> + * @return long
> + */
> +static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
> +{
> +	unsigned long id_tuple;
> +	struct arm_smccc_res res;
> +	bool need_userspace = false;
> +
> +	if (copy_from_user(vcpu->run, argp, sizeof(struct gzvm_vcpu_run)))
> +		return -EFAULT;
> +
> +	if (vcpu->run->immediate_exit == 1)
> +		return -EINTR;
> +
> +	id_tuple = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
> +	do {
> +		gzvm_hypcall_wrapper(MT_HVC_GZVM_RUN, id_tuple, 0, 0, 0, 0, 0,
> +				     0, &res);
> +		switch (res.a1) {
> +		case GZVM_EXIT_MMIO:
> +			need_userspace = true;
> +			break;
> +		/*
> +		 * geniezone's responsibility to fill corresponding data
> +		 * structure
> +		 */
> +		case GZVM_EXIT_HVC:

			/* fallthrough */

> +		case GZVM_EXIT_EXCEPTION:

			/* fallthrough */

> +		case GZVM_EXIT_DEBUG:

			/* fallthrough */

> +		case GZVM_EXIT_FAIL_ENTRY:

			/* fallthrough */

> +		case GZVM_EXIT_INTERNAL_ERROR:

			/* fallthrough */

> +		case GZVM_EXIT_SYSTEM_EVENT:

			/* fallthrough */

> +		case GZVM_EXIT_SHUTDOWN:
> +			need_userspace = true;
> +			break;
> +		case GZVM_EXIT_IRQ:
> +			break;
> +		case GZVM_EXIT_UNKNOWN:

			/* fallthrough */

> +		default:
> +			pr_err("vcpu unknown exit\n");

Also, please use dev_err() when possible.

> +			need_userspace = true;
> +			goto out;
> +		}
> +	} while (!need_userspace);
> +
> +out:
> +	if (copy_to_user(argp, vcpu->run, sizeof(struct gzvm_vcpu_run)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +static long gzvm_vcpu_ioctl(struct file *filp, unsigned int ioctl,
> +			    unsigned long arg)
> +{
> +	int ret = -ENOTTY;
> +	void __user *argp = (void __user *)arg;
> +	struct gzvm_vcpu *vcpu = filp->private_data;
> +
> +	switch (ioctl) {
> +	case GZVM_RUN:
> +		ret = gzvm_vcpu_run(vcpu, argp);
> +		break;
> +	case GZVM_GET_ONE_REG:
> +		ret = gzvm_vcpu_update_one_reg(vcpu, argp, false /*is_write*/);
> +		break;
> +	case GZVM_SET_ONE_REG:
> +		ret = gzvm_vcpu_update_one_reg(vcpu, argp, true  /*is_write*/);
> +		break;
> +	default:
> +		ret = -ENOTTY;

instead of initializing `ret`, you can just....

		return -ENOTTY;

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations gzvm_vcpu_fops = {
> +	.unlocked_ioctl = gzvm_vcpu_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static int gzvm_destroy_vcpu_hyp(gzvm_id_t vm_id, int vcpuid)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long a1;
> +
> +	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
> +	gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VCPU, a1, 0, 0, 0, 0, 0, 0,
> +			     &res);
> +
> +	return 0;
> +}
> +
> +/**
> + * @brief call smc to gz hypervisor to create vcpu
> + *
> + * @param run virtual address of vcpu->run
> + * @return int
> + */

kerneldoc please

> +static int gzvm_create_vcpu_hyp(gzvm_id_t vm_id, int vcpuid, void *run)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long a1, a2;
> +	int ret;
> +
> +	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
> +	a2 = (__u64)virt_to_phys(run);
> +	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VCPU, a1, a2, 0, 0, 0, 0,
> +				   0, &res);
> +
> +	return ret;
> +}
> +
> +/* Caller must hold the vm lock */
> +void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
> +{
> +	if (!vcpu)
> +		return;
> +
> +	gzvm_destroy_vcpu_hyp(vcpu->gzvm->vm_id, vcpu->vcpuid);
> +	/* clean guest's data */
> +	memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
> +	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
> +	kfree(vcpu);
> +}
> +
> +#define ITOA_MAX_LEN 12 /* Maximum size needed for holding an integer. */

Move definitions at the beginning of the file, please.

> +/**
> + * @brief Allocates an inode for the vcpu.
> + */

Kerneldoc!

> +static int create_vcpu_fd(struct gzvm_vcpu *vcpu)
> +{
> +	/* sizeof("gzvm-vcpu:") + max(strlen(itoa(vcpuid))) + null */
> +	char name[10 + ITOA_MAX_LEN + 1];
> +
> +	snprintf(name, sizeof(name), "gzvm-vcpu:%d", vcpu->vcpuid);
> +	return anon_inode_getfd(name, &gzvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
> +}
> +
> +/**
> + * @brief GZVM_CREATE_VCPU
> + *
> + * @param cpuid = arg
> + * @return fd of vcpu, negative errno if error occurs
> + */

kerneldoc!!!! :-)

> +int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
> +{
> +	struct gzvm_vcpu *vcpu;
> +	int ret;
> +
> +	if (cpuid >= GZVM_MAX_VCPUS)
> +		return -EINVAL;
> +
> +	vcpu = kzalloc(sizeof(*vcpu), GFP_KERNEL);
> +	if (!vcpu)
> +		return -ENOMEM;
> +
> +	BUILD_BUG_ON((sizeof(*vcpu->run)) > PAGE_SIZE);
> +	BUILD_BUG_ON(sizeof(struct gzvm_vcpu_hwstate) > PAGE_SIZE);

Do you really need to crash the kernel?!

You must have a very, very good reason to do that, please justify that carefully
and also write that as a comment in this function.

> +	/**
> +	 * allocate 2 pages for data sharing between driver and gz hypervisor
> +	 * |- page 0           -|- page 1      -|
> +	 * |gzvm_vcpu_run|......|hwstate|.......|
> +	 */
> +	vcpu->run = alloc_pages_exact(GZVM_VCPU_RUN_MAP_SIZE,
> +				      GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	if (!vcpu->run) {
> +		ret = -ENOMEM;
> +		goto free_vcpu;
> +	}
> +	vcpu->hwstate = (void *)vcpu->run + PAGE_SIZE;
> +	vcpu->vcpuid = cpuid;
> +	vcpu->gzvm = gzvm;
> +	mutex_init(&vcpu->lock);
> +
> +	ret = gzvm_create_vcpu_hyp(gzvm->vm_id, vcpu->vcpuid, vcpu->run);
> +	if (ret < 0)
> +		goto free_vcpu_run;
> +
> +	ret = create_vcpu_fd(vcpu);
> +	if (ret < 0)
> +		goto free_vcpu_run;
> +	gzvm->vcpus[cpuid] = vcpu;
> +
> +	return ret;
> +
> +free_vcpu_run:
> +	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
> +free_vcpu:
> +	kfree(vcpu);
> +	return ret;
> +}
> diff --git a/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
> new file mode 100644
> index 000000000000..df4ccdc3b7f0
> --- /dev/null
> +++ b/drivers/soc/mediatek/virt/geniezone/gzvm_vm.c
> @@ -0,0 +1,444 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 MediaTek Inc.
> + */
> +
> +#include <linux/anon_inodes.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/file.h>
> +#include <linux/kdev_t.h>
> +#include <linux/kvm_host.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/version.h>
> +#include "gzvm.h"
> +
> +static DEFINE_MUTEX(gzvm_list_lock);
> +static LIST_HEAD(gzvm_list);
> +
> +
> +/**
> + * @brief Translate gfn (guest ipa) to pfn (host pa), result is in @pfn
> + *
> + * Leverage KVM's `gfn_to_pfn_memslot`. Because `gfn_to_pfn_memslot` needs
> + * kvm_memory_slot as parameter, this function populates necessary fileds
> + * for calling `gfn_to_pfn_memslot`.
> + *
> + * @retval 0 succeed
> + * @retval -EFAULT failed to convert
> + */

kerneldoc please

> +int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
> +{
> +	hfn_t __pfn;
> +	struct kvm_memory_slot kvm_slot = {0};
> +
> +	kvm_slot.base_gfn = memslot->base_gfn;
> +	kvm_slot.npages = memslot->npages;
> +	kvm_slot.dirty_bitmap = NULL;
> +	kvm_slot.userspace_addr = memslot->userspace_addr;
> +	kvm_slot.flags = memslot->flags;
> +	kvm_slot.id = memslot->slot_id;
> +	kvm_slot.as_id = 0;
> +
> +	__pfn = gfn_to_pfn_memslot(&kvm_slot, gfn);
> +	if (is_error_noslot_pfn(__pfn)) {
> +		*pfn = 0;
> +		return -EFAULT;
> +	}
> +
> +	*pfn = __pfn;
> +	return 0;
> +}
> +
> +/**
> + * @brief Populate pa to buffer until full
> + *
> + * @return int how much pages we've fill in, negative if error
> + */

kerneldoc

> +static int fill_constituents(struct mem_region_addr_range *consti,
> +			     int *consti_cnt, int max_nr_consti, gfn_t gfn,
> +			     u32 total_pages, struct gzvm_memslot *slot)
> +{
> +	int i, nr_pages;
> +	hfn_t pfn, prev_pfn;
> +	gfn_t gfn_end;

	hfn_t pfn, prev_pfn;
	gfn_t gfn_end;
	int nr_pages = 1;
	int i = 0;

> +
> +	if (unlikely(total_pages == 0))
> +		return -EINVAL;
> +	gfn_end = gfn + total_pages;
> +
> +	/* entry 0 */
> +	if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
> +		return -EFAULT;
> +	consti[0].address = PFN_PHYS(pfn);
> +	consti[0].pg_cnt = 1;
> +	gfn++;
> +	prev_pfn = pfn;


> +	i = 0;
> +	nr_pages = 1;
stack initialized, remove...

> +	while (i < max_nr_consti && gfn < gfn_end) {
> +		if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
> +			return -EFAULT;
> +		if (pfn == (prev_pfn + 1)) {
> +			consti[i].pg_cnt++;
> +		} else {
> +			i++;
> +			if (i >= max_nr_consti)
> +				break;
> +			consti[i].address = PFN_PHYS(pfn);
> +			consti[i].pg_cnt = 1;
> +		}
> +		prev_pfn = pfn;
> +		gfn++;
> +		nr_pages++;
> +	}

	if (i == max_nr_consti)
		i++;

	*consti_cnt = i;

> +	if (i == max_nr_consti)
> +		*consti_cnt = i;
> +	else
> +		*consti_cnt = (i + 1);
> +
> +	return nr_pages;
> +}
> +
> +/**
> + * @brief Register memory region to GZ
> + *
> + * @param gzvm
> + * @param memslot
> + * @return int
> + */

kerneldoc

> +static int
> +register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
> +{
> +	struct gzvm_memory_region_ranges *region;
> +	u32 buf_size;
> +	int max_nr_consti, remain_pages;
> +	gfn_t gfn, gfn_end;

	struct gzvm_memory_region_ranges *region;
	gfn_t gfn, gfn_end;
	int max_nr_consti, remain_pages;
	u32 buf_size;

> +
> +	buf_size = PAGE_SIZE * 2;
> +	region = alloc_pages_exact(buf_size, GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +	max_nr_consti = (buf_size - sizeof(*region)) /
> +			sizeof(struct mem_region_addr_range);
> +
> +	region->slot = memslot->slot_id;
> +	remain_pages = memslot->npages;
> +	gfn = memslot->base_gfn;
> +	gfn_end = gfn + remain_pages;
> +	while (gfn < gfn_end) {
> +		struct arm_smccc_res res;
> +		int nr_pages;
> +
> +		nr_pages = fill_constituents(region->constituents,
> +					     &region->constituent_cnt,
> +					     max_nr_consti, gfn,
> +					     remain_pages, memslot);
> +		region->gpa = PFN_PHYS(gfn);
> +		region->total_pages = nr_pages;
> +
> +		remain_pages -= nr_pages;
> +		gfn += nr_pages;
> +
> +		gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_MEMREGION, gzvm->vm_id,
> +			     buf_size, virt_to_phys(region), 0, 0, 0, 0, &res);
> +
> +		if (res.a0 != 0) {
> +			pr_err("Failed to register memregion to hypervisor\n");

dev_err() please

> +			free_pages_exact(region, buf_size);
> +			return -EFAULT;
> +		}
> +	}
> +	free_pages_exact(region, buf_size);
> +	return 0;
> +}
> +
> +/**
> + * @brief Set memory region of guest
> + *
> + * @param gzvm struct gzvm
> + * @param mem struct gzvm_userspace_memory_region: input from user
> + * @retval -EXIO memslot is out-of-range
> + * @retval -EFAULT  cannot find corresponding vma
> + * @retval -EINVAL  region size and vma size does not match
> + */

kerneldoc

> +static int gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
> +				struct gzvm_userspace_memory_region *mem)
> +{
> +	struct vm_area_struct *vma;
> +	struct gzvm_memslot *memslot;
> +	unsigned long size;
> +	__u32 slot;
> +
> +	slot = mem->slot;
> +	if (slot >= GZVM_MAX_MEM_REGION)
> +		return -ENXIO;
> +	memslot = &gzvm->memslot[slot];
> +
> +	vma = vma_lookup(gzvm->mm, mem->userspace_addr);
> +	if (!vma)
> +		return -EFAULT;
> +
> +	size = vma->vm_end - vma->vm_start;
> +	if (size != mem->memory_size)
> +		return -EINVAL;
> +
> +	memslot->base_gfn = __phys_to_pfn(mem->guest_phys_addr);
> +	memslot->npages = size >> PAGE_SHIFT;
> +	memslot->userspace_addr = mem->userspace_addr;
> +	memslot->vma = vma;
> +	memslot->flags = mem->flags;
> +	memslot->slot_id = mem->slot;
> +	return register_memslot_addr_range(gzvm, memslot);
> +}
> +
> +static int gzvm_vm_enable_cap_hyp(struct gzvm *gzvm,
> +				  struct gzvm_enable_cap *cap,
> +				  struct arm_smccc_res *res)

Please don't introduce new functions doing just one call.

> +{
> +	int ret;
> +
> +	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_ENABLE_CAP, gzvm->vm_id,
> +				   cap->cap, cap->args[0], cap->args[1],
> +				   cap->args[2], cap->args[3], cap->args[4],
> +				   res); > +	return ret;
> +}
> +
> +/**
> + * @brief Get pvmfw size from hypervisor, return in x1, and return to userspace
> + *        in args[1].
> + * @retval 0 succeed
> + * @retval -EINVAL hypervisor return invalid results
> + * @retval -EFAULT fail to copy back to userspace buffer
> + */

kerneldoc ..... here and everywhere else, I will stop saying that every time.

> +static int gzvm_vm_ioctl_get_pvmfw_size(struct gzvm *gzvm,
> +					struct gzvm_enable_cap *cap,
> +					void __user *argp)
> +{
> +	struct arm_smccc_res res = {0};
> +
> +	if (gzvm_vm_enable_cap_hyp(gzvm, cap, &res) != 0)
> +		return -EINVAL;
> +
> +	cap->args[1] = res.a1;
> +	if (copy_to_user(argp, cap, sizeof(*cap)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +/**
> + * @brief Proceed GZVM_CAP_ARM_PROTECTED_VM's subcommands
> + * @retval 0 succeed
> + * @retval -EINVAL invalid subcommand or arguments
> + */
> +static int gzvm_vm_ioctl_cap_pvm(struct gzvm *gzvm, struct gzvm_enable_cap *cap,
> +				 void __user *argp)
> +{
> +	int ret = -EINVAL;
> +	struct arm_smccc_res res = {0};
> +
> +	switch (cap->args[0]) {
> +	case GZVM_CAP_ARM_PVM_SET_PVMFW_IPA:
> +		ret = gzvm_vm_enable_cap_hyp(gzvm, cap, &res);
> +		break;
> +	case GZVM_CAP_ARM_PVM_GET_PVMFW_SIZE:
> +		ret = gzvm_vm_ioctl_get_pvmfw_size(gzvm, cap, argp);
> +		break;
> +	default:
> +		ret = -EINVAL;

		return -EINVAL;

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
> +				    struct gzvm_enable_cap *cap,
> +				    void __user *argp)
> +{
> +	int ret = -EINVAL;
> +
> +	switch (cap->cap) {
> +	case GZVM_CAP_ARM_PROTECTED_VM:
> +		ret = gzvm_vm_ioctl_cap_pvm(gzvm, cap, argp);
> +		break;
> +	default:
> +		ret = -EINVAL;

		return -EINVAL;

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * @brief ioctl handler of VM FD
> + */
> +static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
> +			  unsigned long arg)
> +{
> +	long ret = -ENOTTY;
> +	void __user *argp = (void __user *)arg;
> +	struct gzvm *gzvm = filp->private_data;
> +
> +	switch (ioctl) {
> +	case GZVM_CHECK_EXTENSION:
> +		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
> +		break;
> +	case GZVM_CREATE_VCPU:
> +		ret = gzvm_vm_ioctl_create_vcpu(gzvm, arg);
> +		break;
> +	case GZVM_SET_USER_MEMORY_REGION: {
> +		struct gzvm_userspace_memory_region userspace_mem;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&userspace_mem, argp,
> +						sizeof(userspace_mem)))
> +			goto out;
> +		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
> +		break;
> +	}
> +	case GZVM_ENABLE_CAP: {
> +		struct gzvm_enable_cap cap;
> +
> +		ret = -EFAULT;
> +		if (copy_from_user(&cap, argp, sizeof(cap)))
> +			goto out;
> +
> +		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
> +		break;
> +	}
> +	default:
> +		ret = -ENOTTY;

		return -ENOTTY;

> +	}
> +out:
> +	return ret;
> +}
> +

..snip..

> +
> +static void gzvm_destroy_vm(struct gzvm *gzvm)
> +{ > +	pr_info("VM-%u is going to be destroyed\n", gzvm->vm_id);

	dev_info() please.

> +
> +	mutex_lock(&gzvm->lock);
> +
> +	gzvm_destroy_vcpus(gzvm);
> +	gzvm_destroy_vm_hyp(gzvm->vm_id);
> +
> +	mutex_lock(&gzvm_list_lock);
> +	list_del(&gzvm->vm_list);
> +	mutex_unlock(&gzvm_list_lock);
> +
> +	mutex_unlock(&gzvm->lock);
> +
> +	kfree(gzvm);
> +}
> +
> +static int gzvm_vm_release(struct inode *inode, struct file *filp)
> +{
> +	struct gzvm *gzvm = filp->private_data;
> +
> +	gzvm_destroy_vm(gzvm);
> +	return 0;
> +}
> +
> +static const struct file_operations gzvm_vm_fops = {
> +	.release        = gzvm_vm_release,
> +	.unlocked_ioctl = gzvm_vm_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static int gzvm_create_vm_hyp(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VM, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +	if (res.a0 != 0)
> +		return -EFAULT;
> +	return res.a1;
> +}
> +
> +static struct gzvm *gzvm_create_vm(unsigned long vm_type)
> +{
> +	int ret;
> +	struct gzvm *gzvm;
> +
> +	gzvm = kzalloc(sizeof(struct gzvm), GFP_KERNEL);
> +	if (!gzvm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = gzvm_create_vm_hyp();
> +	if (ret < 0)
> +		goto err;

You're doing that only once in this function, so you don't need a label.

	if (ret) {
		kfree(gzvm);
		return ERR_PTR(ret);
	}

> +
> +	gzvm->vm_id = ret;
> +	gzvm->mm = current->mm;
> +	mutex_init(&gzvm->lock);
> +	INIT_LIST_HEAD(&gzvm->devices);
> +	mutex_init(&gzvm->irq_lock);
> +	pr_info("VM-%u is created\n", gzvm->vm_id);
> +
> +	mutex_lock(&gzvm_list_lock);
> +	list_add(&gzvm->vm_list, &gzvm_list);
> +	mutex_unlock(&gzvm_list_lock);
> +
> +	return gzvm;
> +
> +err:
> +	kfree(gzvm);
> +	return ERR_PTR(ret);
> +}
> +
> +/**
> + * @brief create vm fd
> + *
> + * @param vm_type
> + * @return int fd of vm, negative if error
> + */
> +int gzvm_dev_ioctl_create_vm(unsigned long vm_type)
> +{
> +	struct gzvm *gzvm;
> +	int ret;
> +
> +	gzvm = gzvm_create_vm(vm_type);
	if (IS_ERR(gzvm))
		return PTR_ERR(gzvm);

> +	if (IS_ERR(gzvm)) {
> +		ret = PTR_ERR(gzvm);
> +		goto error;
> +	}
> +
> +	ret = anon_inode_getfd("gzvm-vm", &gzvm_vm_fops, gzvm,
> +			       O_RDWR | O_CLOEXEC);
	if (ret)
		return ret;

	return 0;
}


> +	if (ret < 0)
> +		goto error;
> +
> +error:
> +	return ret;
> +}

...but anyway, all of this must go to drivers/virt/.

Regards,
Angelo

