Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994786662BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbjAKSZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjAKSZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:25:39 -0500
Received: from out-37.mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2182AD6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:25:37 -0800 (PST)
Date:   Wed, 11 Jan 2023 18:25:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1673461535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hAs7LUynKbLq5T1v0UqKm3yOvkRnDNP7tzZTR0H+taQ=;
        b=NqZq6497DO/W7iQJ4P2g+Cej/89CLOjShG4+NPInRAducOx5h40SVY6Ov197WHklT/QLkf
        wUNl+HcsZI6LVTdimfaZalC6esS6PEbunmMtMh/w60PMFbeWdWt5krHHDD1CJyeMrRvswK
        mu5Y4S3E+NA6l/NWYLilEoNVTDDqS+k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Akihiko Odaki <akihiko.odaki@daynix.com>
Cc:     Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v6 7/7] KVM: arm64: Normalize cache configuration
Message-ID: <Y77/Gi+193u+YvwX@google.com>
References: <20230107094629.181236-1-akihiko.odaki@daynix.com>
 <20230107094629.181236-8-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107094629.181236-8-akihiko.odaki@daynix.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 06:46:29PM +0900, Akihiko Odaki wrote:
> Before this change, the cache configuration of the physical CPU was
> exposed to vcpus. This is problematic because the cache configuration a
> vcpu sees varies when it migrates between vcpus with different cache
> configurations.
> 
> Fabricate cache configuration from the sanitized value, which holds the
> CTR_EL0 value the userspace sees regardless of which physical CPU it
> resides on.
> 
> CLIDR_EL1 and CCSIDR_EL1 are now writable from the userspace so that
> the VMM can restore the values saved with the old kernel.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/arm64/include/asm/cache.h    |   3 +
>  arch/arm64/include/asm/kvm_host.h |   4 +
>  arch/arm64/kvm/reset.c            |   1 +
>  arch/arm64/kvm/sys_regs.c         | 252 ++++++++++++++++++------------
>  4 files changed, 164 insertions(+), 96 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
> index ab7133654a72..a51e6e8f3171 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -22,6 +22,9 @@
>  #define CLIDR_CTYPE(clidr, level)	\
>  	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
>  
> +/* Ttypen, bits [2(n - 1) + 34 : 2(n - 1) + 33], for n = 1 to 7 */
> +#define CLIDR_TTYPE_SHIFT(level)	(2 * ((level) - 1) + CLIDR_EL1_Ttypen_SHIFT)
> +
>  /*
>   * Memory returned by kmalloc() may be used for DMA, so we must make
>   * sure that all such allocations are cache aligned. Otherwise,
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 374390a9212e..496602e0b299 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -252,6 +252,7 @@ struct kvm_vcpu_fault_info {
>  enum vcpu_sysreg {
>  	__INVALID_SYSREG__,   /* 0 is reserved as an invalid value */
>  	MPIDR_EL1,	/* MultiProcessor Affinity Register */
> +	CLIDR_EL1,	/* Cache Level ID Register */
>  	CSSELR_EL1,	/* Cache Size Selection Register */
>  	SCTLR_EL1,	/* System Control Register */
>  	ACTLR_EL1,	/* Auxiliary Control Register */
> @@ -501,6 +502,9 @@ struct kvm_vcpu_arch {
>  		u64 last_steal;
>  		gpa_t base;
>  	} steal;
> +
> +	/* Per-vcpu CCSIDR override or NULL */
> +	u32 *ccsidr;
>  };
>  
>  /*
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index e0267f672b8a..dc235ddc6172 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -157,6 +157,7 @@ void kvm_arm_vcpu_destroy(struct kvm_vcpu *vcpu)
>  	if (sve_state)
>  		kvm_unshare_hyp(sve_state, sve_state + vcpu_sve_state_size(vcpu));
>  	kfree(sve_state);
> +	kfree(vcpu->arch.ccsidr);
>  }
>  
>  static void kvm_vcpu_reset_sve(struct kvm_vcpu *vcpu)
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 5617de916c80..e789f9dea277 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -11,6 +11,7 @@
>  
>  #include <linux/bitfield.h>
>  #include <linux/bsearch.h>
> +#include <linux/cacheinfo.h>
>  #include <linux/kvm_host.h>
>  #include <linux/mm.h>
>  #include <linux/printk.h>
> @@ -81,25 +82,85 @@ void vcpu_write_sys_reg(struct kvm_vcpu *vcpu, u64 val, int reg)
>  	 __vcpu_sys_reg(vcpu, reg) = val;
>  }
>  
> -/* 3 bits per cache level, as per CLIDR, but non-existent caches always 0 */
> -static u32 cache_levels;
> -
>  /* CSSELR values; used to index KVM_REG_ARM_DEMUX_ID_CCSIDR */
>  #define CSSELR_MAX 14
>  
> +static u8 get_min_cache_line_size(u32 csselr)
> +{
> +	u64 ctr_el0;
> +	int field;
> +
> +	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	field = csselr & CSSELR_EL1_InD ? CTR_EL0_IminLine_SHIFT : CTR_EL0_DminLine_SHIFT;
> +
> +	/*
> +	 * Determine Log2(Number of bytes) - 4, which is the encoding of cache
> +	 * line size in CCSIDR_EL0. In CTR_EL0, the cache line size is
> +	 * represented with:
> +	 * Log2(Number of words) = Log2((Number of bytes) / 4)
> +	 *                       = Log2(Number of bytes) - 2
> +	 */
> +	return cpuid_feature_extract_unsigned_field(ctr_el0, field) - 2;
> +}

So I definitely got my math wrong when I was reading this the first
time, apologies.

Nonetheless, I still find the return value confusing here. It would be
better to just return Log2(bytes) outright (i.e. no offset) and document
that. I worry that the next user of this function will miss that detail.

While at it we should probably convert to the new sysreg field helpers
too.

  /*
   * Returns the minimum line size for the selected cache, expressed as
   * Log2(bytes).
   */
  static u8 get_min_cache_line_size(bool icache)
  {
  	u64 ctr = read_sanitised_ftr_reg(SYS_CTR_EL0);
	u8 field;

	if (icache)
		field = SYS_FIELD_GET(CTR_EL0, IminSize, ctr);
	else
		field = SYS_FIELD_GET(CTR_EL0, DminSize, ctr);

	/*
	 * Cache line size is represented as Log2(words) in CTR_EL0.
	 * Log2(bytes) can be derived with the following:
	 *
	 * Log2(words) + 2 = Log2(bytes / 4) + 2
	 * 		   = Log2(bytes) - 2 + 2
	 * 		   = Log2(bytes)
	 */
	return field + 2;
  }

> +
>  /* Which cache CCSIDR represents depends on CSSELR value. */
> -static u32 get_ccsidr(u32 csselr)
> +static u32 get_ccsidr(struct kvm_vcpu *vcpu, u32 csselr)
>  {
> -	u32 ccsidr;
> +	if (vcpu->arch.ccsidr)
> +		return vcpu->arch.ccsidr[csselr];
>  
> -	/* Make sure noone else changes CSSELR during this! */
> -	local_irq_disable();
> -	write_sysreg(csselr, csselr_el1);
> -	isb();
> -	ccsidr = read_sysreg(ccsidr_el1);
> -	local_irq_enable();
> +	/*
> +	 * Fabricate a CCSIDR value as the overriding value does not exist.
> +	 * The real CCSIDR value will not be used as it can vary by the
> +	 * physical CPU which the vcpu currently resides in.
> +	 *
> +	 * The line size is determined with get_min_cache_line_size(), which
> +	 * should be valid for all CPUs even if they have different cache
> +	 * configuration.
> +	 *
> +	 * The associativity bits are cleared, meaning the geometry of all data
> +	 * and unified caches (which are guaranteed to be PIPT and thus
> +	 * non-aliasing) are 1 set and 1 way.
> +	 * Guests should not be doing cache operations by set/way at all, and
> +	 * for this reason, we trap them and attempt to infer the intent, so
> +	 * that we can flush the entire guest's address space at the appropriate
> +	 * time. The exposed geometry minimizes the number of the traps.
> +	 * [If guests should attempt to infer aliasing properties from the
> +	 * geometry (which is not permitted by the architecture), they would
> +	 * only do so for virtually indexed caches.]
> +	 *
> +	 * We don't check if the cache level exists as it is allowed to return
> +	 * an UNKNOWN value if not.
> +	 */
> +	return get_min_cache_line_size(csselr) << CCSIDR_EL1_LineSize_SHIFT;

So with the above change, this would become:

	u8 line_size = get_min_cache_line_size(csselr & CSSELR_EL1_InD);

	return SYS_FIELD_PREP(CSSELR_EL1, LineSize, line_size - 4);

Which I find slightly more readable because it moves the -4 offset to
where the relevant field is initialized. Adding an extra bit of
information to your comment explaining the offset is likely worthwhile
too.

--
Thanks,
Oliver
