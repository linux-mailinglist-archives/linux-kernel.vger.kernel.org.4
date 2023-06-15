Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E87312E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbjFOJAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbjFOJAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:00:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD521FCC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0MN/5b29jWXDxiDwyt3AOfbJjNfxk4ZF1WmdtESE9lU=; b=lXVPsvUyKJ0NSRqdBz47nM4zMY
        B68CamOx9wmcVQMNRC97zxaphk7FE1IX0Nh5BRfFDDmf7p9raqM5D3kGIWJXubpAil6xXv4ucIhVU
        QU524VCgeK/OIp12aZl7WjFiKYyg+kOZAfxWk3PY+wufBitQqoGFiam9PLrUy7bjrP4gF58EpXMWf
        v6j88Mlh3BwdttPMCzLVdeh9SdHHgLeVJACOTK9Cn5Jc8PKXfoI3BR82oW9I4nkbImiXeDaxSQR9p
        tzBpTPNUb2y5URvqW5gZiv0CvXAcKmhOjp8FBMHCIXo/vHlXfQrdyGvdtYC9AbePnLiKtuUaZPb3n
        kyobITxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9ioH-00Bl0w-2s;
        Thu, 15 Jun 2023 09:00:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F3976300188;
        Thu, 15 Jun 2023 10:58:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA79C2456F421; Thu, 15 Jun 2023 10:58:28 +0200 (CEST)
Date:   Thu, 15 Jun 2023 10:58:28 +0200
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
Subject: Re: [patch V2 3/8] x86/smp: Remove pointless wmb() from
 native_stop_other_cpus()
Message-ID: <20230615085828.GC1683497@hirez.programming.kicks-ass.net>
References: <20230613115353.599087484@linutronix.de>
 <20230613121615.762734722@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613121615.762734722@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 02:17:58PM +0200, Thomas Gleixner wrote:
> The wmb() after the successfull atomic_cmpxchg() is complete voodoo along
> with the comment stating "sync above data before sending IRQ".
> 
> There is no "above" data except for the atomic_t stopping_cpu which has
> just been acquired. The reboot IPI handler does not check any data and
> unconditionally disables the CPU.
> 
> Remove this cargo cult barrier.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Ashok Raj <ashok.raj@intel.com>
> ---
>  arch/x86/kernel/smp.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -174,9 +174,6 @@ static void native_stop_other_cpus(int w
>  
>  		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
>  
> -		/* sync above data before sending IRQ */
> -		wmb();
> -
>  		apic_send_IPI_allbutself(REBOOT_VECTOR);

There's a second one a little below. That too should go.

More to the point, the apic_send_*() functions should be the ones that
ensure this if required etc.. See for example weak_wrmsr_fence() for
x2apic.
