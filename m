Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C153745C9F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGCMyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjGCMym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:54:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF90ECA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j5605/HWWoZE2IJD3BgWA3YWDn60kUKqmLhhUjb+mvQ=; b=SL3MzBk5uEUX0XouFD3vJ+uhkV
        2vZCfSpm/+/o6yr1siThpsYg0Y1fYD8k9rJULWenmNi0RaOcRcLwB/YU5ksLW8WQnczCpqdJUV+Ma
        //aiO/iXrftt+9vwhzWjyDpcQ23hdMkxKS7TSXZ3JJoYUWHU+mjUjFTJKMpVbnDVEr1q9E+zbaqW9
        UdvPC+KIix8Vau7Lq0mj2XLXmtSPrB0V4rAGoHJZyCZK5dGWl+lifJDuQoR+8OJPhfVqg8euVjfEg
        3gWxnuV3Fru8FeB1+6l5AUfJ2XDTziLFVUBvOh79/igC7llNMR8OU6ioPVCoxLalLo3AFMqiyYBo4
        40+ZFJ4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qGJ4N-008FUT-Mx; Mon, 03 Jul 2023 12:54:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44AA230057E;
        Mon,  3 Jul 2023 14:54:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2CB48202A2A17; Mon,  3 Jul 2023 14:54:19 +0200 (CEST)
Date:   Mon, 3 Jul 2023 14:54:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/barrier: Do not serialize MSR accesses on AMD
Message-ID: <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
References: <20230622095212.20940-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622095212.20940-1-bp@alien8.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:52:12AM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> AMD does not have the requirement for a synchronization barrier when
> acccessing a certain group of MSRs. Do not incur that unnecessary
> penalty there.

So you're saying that AMD tsc_deadline and x2apic MSRs *do* imply
ordering constraints unlike the Intel ones?

Can we pls haz a document link for that, also a comment?

> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/barrier.h   | 18 ------------------
>  arch/x86/include/asm/processor.h | 19 +++++++++++++++++++
>  2 files changed, 19 insertions(+), 18 deletions(-)

Moving this code while changing it meant I had to look at it _3_ times
before I spotted you changed it :/

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index b216ac80ebcc..983406342484 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -735,4 +735,23 @@ bool arch_is_platform_page(u64 paddr);
>  #define arch_is_platform_page arch_is_platform_page
>  #endif
>  
> +/*
> + * Make previous memory operations globally visible before
> + * a WRMSR.
> + *
> + * MFENCE makes writes visible, but only affects load/store
> + * instructions.  WRMSR is unfortunately not a load/store
> + * instruction and is unaffected by MFENCE.  The LFENCE ensures
> + * that the WRMSR is not reordered.
> + *
> + * Most WRMSRs are full serializing instructions themselves and
> + * do not require this barrier.  This is only required for the
> + * IA32_TSC_DEADLINE and X2APIC MSRs.
> + */
> +static inline void weak_wrmsr_fence(void)
> +{
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		asm volatile("mfence; lfence" : : : "memory");

Both instructions are 3 bytes, a 6 byte nop would be better, no?

	asm volatile (ALTERNATIVE("mfence; lfence;", "", X86_FEATURE_AMD));

or something ?

> +}
> +
>  #endif /* _ASM_X86_PROCESSOR_H */
> -- 
> 2.35.1
> 
