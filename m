Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D355EB979
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiI0FOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiI0FOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:14:25 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C188DF2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:14:23 -0700 (PDT)
Date:   Mon, 26 Sep 2022 22:14:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1664255661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eH+VuXJJsoJWLeWaROUlRT9kenzgYUQcCEUpJ+UCSK0=;
        b=FKLeb5fYYaj32kR1A37I5KarLKkz2M0Xs0w+IpBxfTbenu4MhkYNbEAZCabO+kzZv/VbhZ
        H24iue6F09gM+T869cyU+h/kh2wWEuxIDuki3hyVAAfKfnTiSQsr1VxgPxdR2cQBGOjD6x
        4OabwzjMfNkDNVl8eOh2gfaexq+Tt/U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Cleanup the __get_fault_info() to take out
 the code that validates HPFAR
Message-ID: <YzKGqLzjv0I/gkMi@google.com>
References: <20220927002715.2142353-1-mizhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927002715.2142353-1-mizhang@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mingwei,

On Tue, Sep 27, 2022 at 12:27:15AM +0000, Mingwei Zhang wrote:
> Cleanup __get_fault_info() to take out the code that checks HPFAR. The
> conditions in __get_fault_info() that checks if HPFAR contains a valid IPA
> is slightly messy in that several conditions are written within one IF
> statement acrossing multiple lines and are connected with different logical
> operators. Among them, some conditions come from ARM Spec, while others
						   ^~~~~~~~

Call it the ARM ARM or Arm ARM, depending on what stylization you
subscribe to :)

> come from CPU erratum. This makes the code hard to read and
> difficult to extend.

I'd recommend you avoid alluding to future changes unless they're posted
on the mailing list.

> So, cleanup the function to improve the readability. In particular,
> explicitly specify each condition separately within a newly created inline
> function.
> 
> No functional changes are intended.
> 
> Suggested-by: Oliver Upton <oupton@google.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>

Sorry to nitpick, but maybe reword the changelog like so:

  KVM: arm64: Extract conditions for HPFAR_EL2 validity into helper

  __get_fault_info() open-codes checks for several conditions for the
  validity of HPFAR_EL2 based on the architecture as well as CPU errata
  workarounds. As these conditions are concatenated into a single if
  statement the result is somewhat difficult for the reader to parse.

  Improve the readability by extracting the conditional logic into a
  helper function. While at it, expand the predicates for the validity
  of HPFAR_EL2 into individual conditions.

  No functional change intended.

> ---
>  arch/arm64/kvm/hyp/include/hyp/fault.h | 36 ++++++++++++++++----------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hyp/include/hyp/fault.h b/arch/arm64/kvm/hyp/include/hyp/fault.h
> index 1b8a2dcd712f..4575500d26ff 100644
> --- a/arch/arm64/kvm/hyp/include/hyp/fault.h
> +++ b/arch/arm64/kvm/hyp/include/hyp/fault.h
> @@ -41,12 +41,6 @@ static inline bool __translate_far_to_hpfar(u64 far, u64 *hpfar)
>  	return true;
>  }
>  
> -static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
> -{
> -	u64 hpfar, far;
> -
> -	far = read_sysreg_el2(SYS_FAR);
> -
>  	/*
>  	 * The HPFAR can be invalid if the stage 2 fault did not
>  	 * happen during a stage 1 page table walk (the ESR_EL2.S1PTW
> @@ -58,14 +52,30 @@ static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
>  	 * permission fault or the errata workaround is enabled, we
>  	 * resolve the IPA using the AT instruction.
>  	 */

This leaves the comment at a very odd indentation. Perhaps it'd be best
to interleave the comment with the below conditions? IMO it would do a
better job of documenting the code that way.

> +static inline bool __hpfar_is_valid(u64 esr)
> +{
> +	if (esr & ESR_ELx_S1PTW)
> +		return true;
> +
> +	if ((esr & ESR_ELx_FSC_TYPE) == FSC_PERM)
> +		return false;
> +
> +	if (cpus_have_final_cap(ARM64_WORKAROUND_834220))
> +		return false;
> +
> +	return true;
> +}
> +
> +static inline bool __get_fault_info(u64 esr, struct kvm_vcpu_fault_info *fault)
> +{
> +	u64 hpfar, far;
> +
> +	far = read_sysreg_el2(SYS_FAR);
> +
> +	if (!__hpfar_is_valid(esr) && !__translate_far_to_hpfar(far, &hpfar))
> +		return false;
> +	else

nit: rewrite to make the logic a bit more direct:

	if (__hpfar_is_valid(esr))
		hpfar = read_sysreg(hpfar_el2);
	else if (!__translate_far_to_hpfar(far, &hpfar))
		return false;

--
Thanks,
Oliver
