Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060AC65F55A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 21:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbjAEUqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 15:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbjAEUqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 15:46:05 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5654C71F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 12:46:00 -0800 (PST)
Date:   Thu, 5 Jan 2023 20:45:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672951558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4b9wTbh87t22aFi+3L9dW176/vHidmEESsgPe8VPi4=;
        b=SJmgLwjvfvfaFKHy4HbjBuzhn3gsxl/+g8469WZ4uM6A5tb1hH1B2ynXfDuasamnqU3Y+x
        O4RUrLGR8EiM1REe4FgsKJFauz0F/KtwiMPNx2w5L3Xqb5k3g8RLSftNxrbTCia6b3Sdca
        7Z83rmv7+PrkSnL91Ls7XfbvlHdb8u4=
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
Subject: Re: [PATCH v5 7/7] KVM: arm64: Normalize cache configuration
Message-ID: <Y7c3AZJhlxKcc7y2@google.com>
References: <20221230095452.181764-1-akihiko.odaki@daynix.com>
 <20221230095452.181764-8-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230095452.181764-8-akihiko.odaki@daynix.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akihiko,

On Fri, Dec 30, 2022 at 06:54:52PM +0900, Akihiko Odaki wrote:

[...]

> @@ -417,6 +418,9 @@ struct kvm_vcpu_arch {
>  		u64 last_steal;
>  		gpa_t base;
>  	} steal;
> +
> +	/* Per-vcpu CCSIDR override or NULL */
> +	u32 *ccsidr;

I don't believe we need to store this per-vCPU. Of course, it is
possible to userspace to observe heterogeneous cache topologies
depending on what core the KVM_GET_ONE_REG ioctl is handled on.

WDYT about keeping track of this per-VM? The value should be whatever
was last written by userspace. To avoid breaking userspace this would
also need to allow mismatched writes (i.e. vCPU0 has a different
configuration than vCPU1).

[...]

> +static u8 get_min_cache_line_size(u32 csselr)

It would be nice to have a comment indicating that it returns
Log2(line_size), not line size outright.

> +{
> +	u64 ctr_el0;
> +	int field;
> +
> +	ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> +	field = csselr & CSSELR_EL1_InD ? CTR_EL0_IminLine_SHIFT : CTR_EL0_DminLine_SHIFT;
> +
> +	return cpuid_feature_extract_unsigned_field(ctr_el0, field) - 2;

This probably deserves a comment describing that CTR_EL0 represents line
size in units of words, not bytes. Furthermore, a subtle reminder on the
log transformation being done here would help also.

> +}
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

I don't believe this is correct. The value of CCSIDR_EL1.LineSize is
actually:

   Log2(Number of bytes in cache line) - 4 (from DDI0487I.a D17.2.26)


With that, I'd expect the following instead:

	line_size = get_min_cache_line_size(csselr);
	return FIELD_PREP(CCSIDR_EL1_LineSize_MASK, line_size - 4);

--
Thanks,
Oliver
