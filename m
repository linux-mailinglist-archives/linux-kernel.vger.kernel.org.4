Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD495F8B82
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJINDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiJINCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:02:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67D2EF0C
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PsOry09GZpQ+6uYDAshz2kpY/U/wY9EiXATiooccfso=; b=dz/gdTxmOqAkFs6iLZAtKiyY3i
        a/zk8RQVOz+vqJvIj1aTPljVsb4AkXahS7kEeB20/iKClf8/AzQouIyT/JTJ1mUfBvw5O0t043Vlq
        CRR4lLr2ZYLBir1yw7DkwVcJKPpLCgdzdF/wLbs7d7etb7/JdL4LCJs4Pyp4Q4xcZqlWqXXbgesnF
        q12GgXXq8pyzXiLSNzYkXw/4x54bK4ZfjmwMimcWmw0irjji4iqWBG1xTDTPy6BGl4BrEZbzPuXBO
        nMpQJ+nJmwGNS19eILiy1D2cZVHDvl4r1Mdcq2YNZolUDC9pQFO4tNeX2I9QWWfO5qVNAq33GMlp0
        M3PsXhfw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohVw1-003QPV-Ke; Sun, 09 Oct 2022 13:01:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 92D3630075A;
        Sun,  9 Oct 2022 15:01:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C19E2BEB68A2; Sun,  9 Oct 2022 15:01:32 +0200 (CEST)
Date:   Sun, 9 Oct 2022 15:01:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        tim.c.chen@intel.com, Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>
Subject: Re: [PATCH] x86/tsc: Extend the watchdog check exemption to 4S/8S
 machine
Message-ID: <Y0LGLGW7RSlklKyl@hirez.programming.kicks-ass.net>
References: <20221009051209.393377-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009051209.393377-1-feng.tang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 01:12:09PM +0800, Feng Tang wrote:
> There is report again that the tsc clocksource on a 4 sockets x86
> Skylake server was wrongly judged as 'unstable' by 'jiffies' watchdog,
> and disabled [1]. Also we got silimar reports on 8 sockets platform
> from internal test.
> 
> Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC
> on qualified platorms") was introduce to deal with these false
> alarms of tsc unstable issues, covering qualified platforms for 2
> sockets or smaller ones.
> 
> Extend the exemption also to 4/8 sockets to fix the issue.
> 
> Rui also proposed another way to disable 'jiffies' as clocksource
> watchdog [2], which can also solve this specific problem in an
> architecture independent way, with one limitation that some tsc false
> alarms are reported by other watchdogs like HPET in post-boot time,
> while 'jiffies' is mostly used in boot phase before hardware
> clocksources are initialized.
> 
> [1]. https://lore.kernel.org/all/9d3bf570-3108-0336-9c52-9bee15767d29@huawei.com/
> [2]. https://lore.kernel.org/all/bd5b97f89ab2887543fc262348d1c7cafcaae536.camel@intel.com/
> 
> Reported-by: Yu Liao <liaoyu15@huawei.com>
> Tested-by: Yu Liao <liaoyu15@huawei.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
>  arch/x86/kernel/tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index cafacb2e58cc..b4ea79cb1d1a 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -1217,7 +1217,7 @@ static void __init check_system_tsc_reliable(void)
>  	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
>  	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> -	    nr_online_nodes <= 2)
> +	    nr_online_nodes <= 8)

So you're saying all 8 socket systems since Broadwell (?) are TSC
sync'ed ?

AFAIK there is no architectural guarantee for >4 sockets to have a sane
TSC. If there is one, the above should be limited to architectures that
conform.
