Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99B7312F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbjFOJDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244919AbjFOJDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:03:04 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D562711
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fe+VRkanewCfNokcW8tgDEMFQdyBOvcUG3s+qHI7UXQ=; b=grlx5SxBMAMtMYQbj4GkCyTFtf
        aXxZwNduRAcpDhHvVfqWLl0586dPYgosMlkU64G0R5WEUJNfmkMPOLvvSKjhhmNwFeep/W28h3Dsk
        KgnxcbAgaxMx2EOBQgr5VGWdh5Jja9CvmTc8r9dy2Q8OFb/7GPoazsw881YpenCMeTUABzbxM1LA+
        kmfqzeDl6NNybMrpNhC43N4/6b/nKPb5sXajJVuckGyX7HOflISiyPlvOE0327J/cvmOjIT2nwnD+
        3HALsli5hGvErqEs6c8/zcTrzdukuKDFmsY+KE4WqsXtehsl3KSpVRz8N0OJD++Lw/Ynh+wCCtI1W
        UbO91sLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9isV-00Bl4G-0T;
        Thu, 15 Jun 2023 09:02:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E01C13002A9;
        Thu, 15 Jun 2023 11:02:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C729F265FBBD4; Thu, 15 Jun 2023 11:02:49 +0200 (CEST)
Date:   Thu, 15 Jun 2023 11:02:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Battersby <tonyb@cybernetics.com>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 4/8] x86/smp: Acquire stopping_cpu unconditionally
Message-ID: <20230615090249.GD1683497@hirez.programming.kicks-ass.net>
References: <20230613115353.599087484@linutronix.de>
 <20230613121615.820042015@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613121615.820042015@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:17:59PM +0200, Thomas Gleixner wrote:
> There is no reason to acquire the stopping_cpu atomic_t only when there is
> more than one online CPU.
> 
> Make it unconditional to prepare for fixing the kexec() problem when there
> are present but "offline" CPUs which play dead in mwait_play_dead().
> 
> They need to be brought out of mwait before kexec() as kexec() can
> overwrite text, pagetables, stacks and the monitored cacheline of the
> original kernel. The latter causes mwait to resume execution which
> obviously causes havoc on the kexec kernel which results usually in triple
> faults.
> 
> Move the acquire out of the num_online_cpus() > 1 condition so the upcoming
> 'kick mwait' fixup is properly protected.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/kernel/smp.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -153,6 +153,12 @@ static void native_stop_other_cpus(int w
>  	if (reboot_force)
>  		return;
>  
> +	/* Only proceed if this is the first CPU to reach this code */
> +	if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
> +		return;
> +
> +	atomic_set(&stop_cpus_count, num_online_cpus() - 1);
> +

	if (({ int old = -1; !atomic_try_cmpxchg(&stopping_cpu, &old, safe_smp_processor_id()); }))
		return;

Doesn't really roll of the tongue, does it :/

Also, I don't think anybody cares about performance at this point, so
ignore I wrote this email.

/me presses send anyway.
