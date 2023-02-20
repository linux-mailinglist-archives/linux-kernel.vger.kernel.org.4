Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBDF69C9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjBTLXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjBTLXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:23:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C55961A5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k/F6jHj9dGb4FP0SDDGOBoJmF3CEJjTDFmT6ghn0D34=; b=gjzTzA31fWyJaNXWu6g8dQ7Al1
        u7HDHBGEKBix9cuEl4rMqCAwkZ3+fFhXEXrWRPHI7tJHZCmTwEfEG5XgUphI9gitPSRXjNRQKXbRT
        Ghg7HtyteiwF7hatI3aPxe4VQj0cTz5NCeF4EbiGiLqSRgl9IRx5vw20sMV8o0KEusZ0D3wx+0err
        aYofv25D/C9Bh03gc3LGAFOPAcupeBRrkazMikNV1fH/HdniZ/yccPjVBrkpPPYj09P71pJ3KiyvU
        0n/yzdhhkWm8Q++5AUPoBANESjWs+CnPWWj6NFDlovpmHk3D9tNLl395QMo11V6TXokR2lWPu9e5z
        CRfUmCfQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pU4Fx-00Bn4D-1i;
        Mon, 20 Feb 2023 11:22:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B953A30020B;
        Mon, 20 Feb 2023 12:22:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F2112135FAB8; Mon, 20 Feb 2023 12:22:51 +0100 (CET)
Date:   Mon, 20 Feb 2023 12:22:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, zhang.jia@linux.alibaba.com,
        len.brown@intel.com
Subject: Re: [PATCH V2 1/1] x86/topology: fix erroneous smp_num_siblings on
 Intel Hybrid platform
Message-ID: <Y/NYC+hjcU0NWC6p@hirez.programming.kicks-ass.net>
References: <20230220032856.661884-1-rui.zhang@intel.com>
 <20230220032856.661884-2-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220032856.661884-2-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 11:28:56AM +0800, Zhang Rui wrote:
> The SMT siblings value returned by CPUID.1F SMT level EBX differs
> among CPUs on Intel Hybrid platforms like AlderLake and MeteorLake.
> It returns 2 for Pcore CPUs which have SMT siblings and returns 1 for
> Ecore CPUs which do not have SMT siblings.
> 
> Today, the CPU boot code sets the global variable smp_num_siblings when
> every CPU thread is brought up. The last thread to boot will overwrite
> it with the number of siblings of *that* thread. That last thread to
> boot will "win". If the thread is a Pcore, smp_num_siblings == 2.  If it
> is an Ecore, smp_num_siblings == 1.
> 
> smp_num_siblings describes if the *system* supports SMT.  It should
> specify the maximum number of SMT threads among all cores.
> 
> Ensure that smp_num_siblings represents the system-wide maximum number
> of siblings by always increasing its value. Never allow it to decrease.
> 
> On MeteorLake-P platform, this fixes a problem that the Ecore CPUs are
> not updated in any cpu sibling map because the system is treated as an
> UP system when probing Ecore CPUs.
> 
> Below shows part of the CPU topology information before and after the
> fix, for both Pcore and Ecore CPU (cpu0 is Pcore, cpu 12 is Ecore).
> ...
> -/sys/devices/system/cpu/cpu0/topology/package_cpus:000fff
> -/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-11
> +/sys/devices/system/cpu/cpu0/topology/package_cpus:3fffff
> +/sys/devices/system/cpu/cpu0/topology/package_cpus_list:0-21
> ...
> -/sys/devices/system/cpu/cpu12/topology/package_cpus:001000
> -/sys/devices/system/cpu/cpu12/topology/package_cpus_list:12
> +/sys/devices/system/cpu/cpu12/topology/package_cpus:3fffff
> +/sys/devices/system/cpu/cpu12/topology/package_cpus_list:0-21
> 
> And this also breaks userspace tools like lscpu
> -Core(s) per socket:  1
> -Socket(s):           11
> +Core(s) per socket:  16
> +Socket(s):           1
> 
> CC: stable@kernel.org
> Suggested-by: Len Brown <len.brown@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  arch/x86/kernel/cpu/topology.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 5e868b62a7c4..0270925fe013 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -79,7 +79,7 @@ int detect_extended_topology_early(struct cpuinfo_x86 *c)
>  	 * initial apic id, which also represents 32-bit extended x2apic id.
>  	 */
>  	c->initial_apicid = edx;
> -	smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
>  #endif
>  	return 0;
>  }
> @@ -109,7 +109,8 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
>  	 */
>  	cpuid_count(leaf, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
>  	c->initial_apicid = edx;
> -	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	core_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
> +	smp_num_siblings = max_t(int, smp_num_siblings, LEVEL_MAX_SIBLINGS(ebx));
>  	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
>  	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
>  	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);

Seems ok, but perhaps you can stick an 'int' cast in
LEVEL_MAX_SIGLINGS instead and write a simpler max() -- and/or convert
smt_num_siblings to unsigned int.

Regardless,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
