Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B467D1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjAZQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjAZQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:41:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4B4DCE5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:41:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bk15so6591545ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 08:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XzndCoNPZGmxqAXThcLcvm/cCjhhxuAGbOgNnyFPrt0=;
        b=Jzg9NSOZEBC+2StwEiVJdLLsZwcVLG3n2Oef07YTj+tJv41XyN/a6wGdREZLnzbXcW
         qZjdSF07eEnXYYdDGd222LwsAM1hxqtAEyLJcxAU8UDro6ORNVmtWo0QTMdj4Zyk3f8j
         eMe7rp2rvQV5Uzj9ucToSaq5xrt5iXsqns/RalG3Q4UVEB2iuxoyYu0QJ3enARifnbAE
         p4e+cyJk+koBt7zp049laeFy5ku5HsJPHSI9D8ZLaw8/kNdAYgxhWqpWn/N9wRWNQphn
         H8VqKU0ofJ4OSfhg6JvYqpt/Zsny+JLrP1Es4wjkWbx8Vx53ssVfm2bOo6Baw0WoE5mJ
         V+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzndCoNPZGmxqAXThcLcvm/cCjhhxuAGbOgNnyFPrt0=;
        b=ri2vh9k1I+jA1N4gJ/zbn0qy+WZc5ofR2MoGGG6cudGtsUFNgnnHSdIj8hLf3WXPqn
         +IqklxJHIussTm9IrGh0YAvjKbRc0lfUdT2I40qeCruhMWHmVxumiPgA4nztDiwxbfY9
         EXnZuI7B0C/hiexb1bXWaN3wcC+aTy9YgA4PCpB7ssH6NkDWxYrSDE+oS0rnkhMXRtJ2
         WmSjTRduUSNv9zo9nhXVTQQo897du4AkrNEWnrNhOGvrrdDX806VaOelUH9R0+EGkA+H
         MlgTI0ZUoCClo4q+3WdhQa59G/LsMxaI6ywFEXhaCqP5859ICsS+71+iP2FboFqx2Y7x
         Y0MQ==
X-Gm-Message-State: AFqh2koTO1qV3YEc3MQEcAF3NiaGwTtMmCkTJhrQtprSEUEYQv++wy/l
        +DstHgjvq2onZvdMuyxwxX4LoQ==
X-Google-Smtp-Source: AMrXdXtTkuQQaIwPIRmMAUxLfmy1DemYQzFnaq218g3j8jatJUvWSCVoLQePf5+NxnCQ8H5R+KgQVA==
X-Received: by 2002:a17:906:4a8f:b0:84d:3403:f4f4 with SMTP id x15-20020a1709064a8f00b0084d3403f4f4mr38433381eju.64.1674751290142;
        Thu, 26 Jan 2023 08:41:30 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709063bc400b0084c2065b388sm812050ejf.128.2023.01.26.08.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:41:29 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:41:28 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] RISC-V: KVM: Initial skeletal support for AIA
Message-ID: <20230126164128.p3blvlwegizmh2ca@orel>
References: <20230112140304.1830648-1-apatel@ventanamicro.com>
 <20230112140304.1830648-5-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112140304.1830648-5-apatel@ventanamicro.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 07:33:01PM +0530, Anup Patel wrote:
> To incrementally implement AIA support, we first add minimal skeletal
> support which only compiles and detects AIA hardware support at the
> boot-time but does not provide any functionality.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_aia.h  | 109 ++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/kvm_host.h |   7 ++
>  arch/riscv/kvm/Makefile           |   1 +
>  arch/riscv/kvm/aia.c              |  66 ++++++++++++++++++
>  arch/riscv/kvm/main.c             |  13 ++++
>  arch/riscv/kvm/vcpu.c             |  40 ++++++++++-
>  arch/riscv/kvm/vcpu_insn.c        |   4 +-
>  arch/riscv/kvm/vm.c               |   4 ++
>  8 files changed, 240 insertions(+), 4 deletions(-)
>  create mode 100644 arch/riscv/include/asm/kvm_aia.h
>  create mode 100644 arch/riscv/kvm/aia.c
> 
> diff --git a/arch/riscv/include/asm/kvm_aia.h b/arch/riscv/include/asm/kvm_aia.h
> new file mode 100644
> index 000000000000..52b5e8aefb30
> --- /dev/null
> +++ b/arch/riscv/include/asm/kvm_aia.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + *
> + * Authors:
> + *	Anup Patel <apatel@ventanamicro.com>
> + */
> +
> +#ifndef __KVM_RISCV_AIA_H
> +#define __KVM_RISCV_AIA_H
> +
> +#include <linux/jump_label.h>
> +#include <linux/kvm_types.h>
> +
> +struct kvm_aia {
> +	/* In-kernel irqchip created */
> +	bool		in_kernel;
> +
> +	/* In-kernel irqchip initialized */
> +	bool		initialized;
> +};
> +
> +struct kvm_vcpu_aia {
> +};
> +
> +#define kvm_riscv_aia_initialized(k)	(!!((k)->arch.aia.initialized))
> +
> +#define irqchip_in_kernel(k)		(!!((k)->arch.aia.in_kernel))

No need for the '!!' operator in the above two defines since in both
cases the type it's operating on is bool.

> +
> +DECLARE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
> +#define kvm_riscv_aia_available() \
> +	static_branch_unlikely(&kvm_riscv_aia_available)
> +
> +static inline void kvm_riscv_vcpu_aia_flush_interrupts(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +static inline void kvm_riscv_vcpu_aia_sync_interrupts(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +static inline bool kvm_riscv_vcpu_aia_has_interrupts(struct kvm_vcpu *vcpu,
> +						     u64 mask)
> +{
> +	return false;
> +}
> +
> +static inline void kvm_riscv_vcpu_aia_update_hvip(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +static inline void kvm_riscv_vcpu_aia_load(struct kvm_vcpu *vcpu, int cpu)
> +{
> +}
> +
> +static inline void kvm_riscv_vcpu_aia_put(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +static inline int kvm_riscv_vcpu_aia_get_csr(struct kvm_vcpu *vcpu,
> +					     unsigned long reg_num,
> +					     unsigned long *out_val)
> +{
> +	*out_val = 0;
> +	return 0;
> +}
> +
> +static inline int kvm_riscv_vcpu_aia_set_csr(struct kvm_vcpu *vcpu,
> +					     unsigned long reg_num,
> +					     unsigned long val)
> +{
> +	return 0;
> +}
> +
> +#define KVM_RISCV_VCPU_AIA_CSR_FUNCS
> +
> +static inline int kvm_riscv_vcpu_aia_update(struct kvm_vcpu *vcpu)
> +{
> +	return 1;
> +}
> +
> +static inline void kvm_riscv_vcpu_aia_reset(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +static inline int kvm_riscv_vcpu_aia_init(struct kvm_vcpu *vcpu)
> +{
> +	return 0;
> +}
> +
> +static inline void kvm_riscv_vcpu_aia_deinit(struct kvm_vcpu *vcpu)
> +{
> +}
> +
> +static inline void kvm_riscv_aia_init_vm(struct kvm *kvm)
> +{
> +}
> +
> +static inline void kvm_riscv_aia_destroy_vm(struct kvm *kvm)
> +{
> +}
> +
> +void kvm_riscv_aia_enable(void);
> +void kvm_riscv_aia_disable(void);
> +int kvm_riscv_aia_init(void);
> +void kvm_riscv_aia_exit(void);
> +
> +#endif
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 93f43a3e7886..b71f0e639b39 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -14,6 +14,7 @@
>  #include <linux/kvm_types.h>
>  #include <linux/spinlock.h>
>  #include <asm/hwcap.h>
> +#include <asm/kvm_aia.h>
>  #include <asm/kvm_vcpu_fp.h>
>  #include <asm/kvm_vcpu_insn.h>
>  #include <asm/kvm_vcpu_sbi.h>
> @@ -93,6 +94,9 @@ struct kvm_arch {
>  
>  	/* Guest Timer */
>  	struct kvm_guest_timer timer;
> +
> +	/* AIA Guest/VM context */
> +	struct kvm_aia aia;
>  };
>  
>  struct kvm_cpu_trap {
> @@ -220,6 +224,9 @@ struct kvm_vcpu_arch {
>  	/* SBI context */
>  	struct kvm_vcpu_sbi_context sbi_context;
>  
> +	/* AIA VCPU context */
> +	struct kvm_vcpu_aia aia;

Maybe name this one vcpu_aia?

> +
>  	/* Cache pages needed to program page tables with spinlock held */
>  	struct kvm_mmu_memory_cache mmu_page_cache;
>  
> diff --git a/arch/riscv/kvm/Makefile b/arch/riscv/kvm/Makefile
> index 019df9208bdd..adbc85a94364 100644
> --- a/arch/riscv/kvm/Makefile
> +++ b/arch/riscv/kvm/Makefile
> @@ -25,3 +25,4 @@ kvm-y += vcpu_sbi_base.o
>  kvm-y += vcpu_sbi_replace.o
>  kvm-y += vcpu_sbi_hsm.o
>  kvm-y += vcpu_timer.o
> +kvm-y += aia.o

Shouldn't the compilation of aia.c depend on the same config(s) as the
rest of the kernel's AIA support?

> diff --git a/arch/riscv/kvm/aia.c b/arch/riscv/kvm/aia.c
> new file mode 100644
> index 000000000000..e7fa4e014d08
> --- /dev/null
> +++ b/arch/riscv/kvm/aia.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Western Digital Corporation or its affiliates.
> + * Copyright (C) 2022 Ventana Micro Systems Inc.
> + *
> + * Authors:
> + *	Anup Patel <apatel@ventanamicro.com>
> + */
> +
> +#include <linux/kvm_host.h>
> +#include <asm/hwcap.h>
> +
> +DEFINE_STATIC_KEY_FALSE(kvm_riscv_aia_available);
> +
> +static inline void aia_set_hvictl(bool ext_irq_pending)

I'd drop the 'inline' from functions in .c files and let the compiler
fully decide.

> +{
> +	unsigned long hvictl;
> +
> +	/*
> +	 * HVICTL.IID == 9 and HVICTL.IPRIO == 0 represents
> +	 * no interrupt in HVICTL.
> +	 */
> +
> +	hvictl = (IRQ_S_EXT << HVICTL_IID_SHIFT) & HVICTL_IID;
> +	hvictl |= (ext_irq_pending) ? 1 : 0;

ext_irq_pending is bool, so this can just be 'hvictl |= ext_irq_pending'.

> +	csr_write(CSR_HVICTL, hvictl);
> +}
> +
> +void kvm_riscv_aia_enable(void)
> +{
> +	if (!kvm_riscv_aia_available())
> +		return;
> +
> +	aia_set_hvictl(false);
> +	csr_write(CSR_HVIPRIO1, 0x0);
> +	csr_write(CSR_HVIPRIO2, 0x0);
> +#ifdef CONFIG_32BIT
> +	csr_write(CSR_HVIPH, 0x0);
> +	csr_write(CSR_HIDELEGH, 0x0);
> +	csr_write(CSR_HVIPRIO1H, 0x0);
> +	csr_write(CSR_HVIPRIO2H, 0x0);
> +#endif
> +}
> +
> +void kvm_riscv_aia_disable(void)
> +{
> +	if (!kvm_riscv_aia_available())
> +		return;
> +
> +	aia_set_hvictl(false);
> +}
> +
> +int kvm_riscv_aia_init(void)
> +{
> +	if (!riscv_isa_extension_available(NULL, SxAIA))
> +		return -ENODEV;
> +
> +	/* Enable KVM AIA support */
> +	static_branch_enable(&kvm_riscv_aia_available);
> +
> +	return 0;
> +}
> +
> +void kvm_riscv_aia_exit(void)
> +{
> +}
> diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
> index 58c5489d3031..d8ff44eb04ca 100644
> --- a/arch/riscv/kvm/main.c
> +++ b/arch/riscv/kvm/main.c
> @@ -53,11 +53,15 @@ int kvm_arch_hardware_enable(void)
>  
>  	csr_write(CSR_HVIP, 0);
>  
> +	kvm_riscv_aia_enable();
> +
>  	return 0;
>  }
>  
>  void kvm_arch_hardware_disable(void)
>  {
> +	kvm_riscv_aia_disable();
> +
>  	/*
>  	 * After clearing the hideleg CSR, the host kernel will receive
>  	 * spurious interrupts if hvip CSR has pending interrupts and the
> @@ -72,6 +76,7 @@ void kvm_arch_hardware_disable(void)
>  
>  int kvm_arch_init(void *opaque)
>  {
> +	int rc;
>  	const char *str;
>  
>  	if (!riscv_isa_extension_available(NULL, h)) {
> @@ -93,6 +98,10 @@ int kvm_arch_init(void *opaque)
>  
>  	kvm_riscv_gstage_vmid_detect();
>  
> +	rc = kvm_riscv_aia_init();
> +	if (rc && rc != -ENODEV)
> +		return rc;
> +
>  	kvm_info("hypervisor extension available\n");
>  
>  	switch (kvm_riscv_gstage_mode()) {
> @@ -115,11 +124,15 @@ int kvm_arch_init(void *opaque)
>  
>  	kvm_info("VMID %ld bits available\n", kvm_riscv_gstage_vmid_bits());
>  
> +	if (kvm_riscv_aia_available())
> +		kvm_info("AIA available\n");
> +
>  	return 0;
>  }
>  
>  void kvm_arch_exit(void)
>  {
> +	kvm_riscv_aia_exit();
>  }
>  
>  static int __init riscv_kvm_init(void)
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 2260adaf2de8..3cf50eadc8ce 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -135,6 +135,8 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>  
>  	kvm_riscv_vcpu_timer_reset(vcpu);
>  
> +	kvm_riscv_vcpu_aia_reset(vcpu);
> +
>  	WRITE_ONCE(vcpu->arch.irqs_pending, 0);
>  	WRITE_ONCE(vcpu->arch.irqs_pending_mask, 0);
>  
> @@ -155,6 +157,7 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
>  
>  int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  {
> +	int rc;
>  	struct kvm_cpu_context *cntx;
>  	struct kvm_vcpu_csr *reset_csr = &vcpu->arch.guest_reset_csr;
>  	unsigned long host_isa, i;
> @@ -194,6 +197,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	/* Setup VCPU timer */
>  	kvm_riscv_vcpu_timer_init(vcpu);
>  
> +	/* Setup VCPU AIA */
> +	rc = kvm_riscv_vcpu_aia_init(vcpu);
> +	if (rc)
> +		return rc;
> +
>  	/* Reset VCPU */
>  	kvm_riscv_reset_vcpu(vcpu);
>  
> @@ -213,6 +221,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  
>  void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>  {
> +	/* Cleanup VCPU AIA context */
> +	kvm_riscv_vcpu_aia_deinit(vcpu);
> +
>  	/* Cleanup VCPU timer */
>  	kvm_riscv_vcpu_timer_deinit(vcpu);
>  
> @@ -730,6 +741,9 @@ void kvm_riscv_vcpu_flush_interrupts(struct kvm_vcpu *vcpu)
>  		csr->hvip &= ~mask;
>  		csr->hvip |= val;
>  	}
> +
> +	/* Flush AIA high interrupts */
> +	kvm_riscv_vcpu_aia_flush_interrupts(vcpu);
>  }
>  
>  void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
> @@ -755,6 +769,9 @@ void kvm_riscv_vcpu_sync_interrupts(struct kvm_vcpu *vcpu)
>  		}
>  	}
>  
> +	/* Sync-up AIA high interrupts */
> +	kvm_riscv_vcpu_aia_sync_interrupts(vcpu);
> +
>  	/* Sync-up timer CSRs */
>  	kvm_riscv_vcpu_timer_sync(vcpu);
>  }
> @@ -791,10 +808,15 @@ int kvm_riscv_vcpu_unset_interrupt(struct kvm_vcpu *vcpu, unsigned int irq)
>  
>  bool kvm_riscv_vcpu_has_interrupts(struct kvm_vcpu *vcpu, unsigned long mask)
>  {
> -	unsigned long ie = ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
> -			    << VSIP_TO_HVIP_SHIFT) & mask;
> +	unsigned long ie;
> +
> +	ie = ((vcpu->arch.guest_csr.vsie & VSIP_VALID_MASK)
> +		<< VSIP_TO_HVIP_SHIFT) & mask;
> +	if (READ_ONCE(vcpu->arch.irqs_pending) & ie)
> +		return true;
>  
> -	return (READ_ONCE(vcpu->arch.irqs_pending) & ie) ? true : false;
> +	/* Check AIA high interrupts */
> +	return kvm_riscv_vcpu_aia_has_interrupts(vcpu, mask);
>  }
>  
>  void kvm_riscv_vcpu_power_off(struct kvm_vcpu *vcpu)
> @@ -890,6 +912,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	kvm_riscv_vcpu_guest_fp_restore(&vcpu->arch.guest_context,
>  					vcpu->arch.isa);
>  
> +	kvm_riscv_vcpu_aia_load(vcpu, cpu);
> +
>  	vcpu->cpu = cpu;
>  }
>  
> @@ -899,6 +923,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>  
>  	vcpu->cpu = -1;
>  
> +	kvm_riscv_vcpu_aia_put(vcpu);
> +
>  	kvm_riscv_vcpu_guest_fp_save(&vcpu->arch.guest_context,
>  				     vcpu->arch.isa);
>  	kvm_riscv_vcpu_host_fp_restore(&vcpu->arch.host_context);
> @@ -966,6 +992,7 @@ static void kvm_riscv_update_hvip(struct kvm_vcpu *vcpu)
>  	struct kvm_vcpu_csr *csr = &vcpu->arch.guest_csr;
>  
>  	csr_write(CSR_HVIP, csr->hvip);
> +	kvm_riscv_vcpu_aia_update_hvip(vcpu);
>  }
>  
>  /*
> @@ -1040,6 +1067,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  
>  		local_irq_disable();
>  
> +		/* Update AIA HW state before entering guest */
> +		ret = kvm_riscv_vcpu_aia_update(vcpu);
> +		if (ret <= 0) {
> +			local_irq_enable();
> +			continue;
> +		}
> +
>  		/*
>  		 * Ensure we set mode to IN_GUEST_MODE after we disable
>  		 * interrupts and before the final VCPU requests check.
> diff --git a/arch/riscv/kvm/vcpu_insn.c b/arch/riscv/kvm/vcpu_insn.c
> index 0bb52761a3f7..07e8c121922b 100644
> --- a/arch/riscv/kvm/vcpu_insn.c
> +++ b/arch/riscv/kvm/vcpu_insn.c
> @@ -213,7 +213,9 @@ struct csr_func {
>  		    unsigned long wr_mask);
>  };
>  
> -static const struct csr_func csr_funcs[] = { };
> +static const struct csr_func csr_funcs[] = {
> +	KVM_RISCV_VCPU_AIA_CSR_FUNCS
> +};
>  
>  /**
>   * kvm_riscv_vcpu_csr_return -- Handle CSR read/write after user space
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 65a964d7e70d..bc03d2ddcb51 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -41,6 +41,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  		return r;
>  	}
>  
> +	kvm_riscv_aia_init_vm(kvm);
> +
>  	kvm_riscv_guest_timer_init(kvm);
>  
>  	return 0;
> @@ -49,6 +51,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
>  	kvm_destroy_vcpus(kvm);
> +
> +	kvm_riscv_aia_destroy_vm(kvm);
>  }
>  
>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
> -- 
> 2.34.1
>

Thanks,
drew
