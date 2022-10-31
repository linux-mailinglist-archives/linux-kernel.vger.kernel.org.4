Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233AF61373E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:00:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiJaM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbiJaM7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:59:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257A810054;
        Mon, 31 Oct 2022 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=whKJ1+jTdjkfTPi9/UqNVxlVWEqXURH+0YN9x5LMeN4=; b=XH5PUk+MgLC8XktuDTO7lgb8ks
        8FopcTqNMY8jh1rhMBoTErSWTUQg9UzwyxjF7T86+1X8xb9AbLw3LXKjvJLlc3sY5ewhP9pMU1M2C
        lTW48APP/BxX4Yorqg8HOv4Cjd2+hMcUEgad8D9PlI9qxHWPj5/T3RfDpLDekUVZOR92llGIin+x+
        UGDGnTtWvnohCpiuzfSCQBpfPqy9sQq5s5S0McOQJRGGl98UGkUmCL+lwDBslxDClZ4cGS3sraxZQ
        JRYVBxpI+15+5LwR2FjZ5nDMuWGtARYAZ3sXZBniZCxky4VqZGRDluatLJjMxZGIKB06WCf6wsgmW
        JjiUcAFw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opUOE-007sEW-IF; Mon, 31 Oct 2022 12:59:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 27A02300282;
        Mon, 31 Oct 2022 13:59:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FBFE2C74DFA4; Mon, 31 Oct 2022 13:59:42 +0100 (CET)
Date:   Mon, 31 Oct 2022 13:59:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Liang Yan <lyan@digitalocean.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/x86/events/amd/core.c: Return -ENODEV when CPU does
 not have PERFCTL_CORE bit
Message-ID: <Y1/Gvs0xkk/W0Nro@hirez.programming.kicks-ass.net>
References: <20221027133511.161922-1-lyan@digtalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027133511.161922-1-lyan@digtalocean.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 09:35:11AM -0400, Liang Yan wrote:
> After disabling cpu.perfctr_core in qemu, I noticed that the guest kernel
> still loads the pmu driver while the cpuid does not have perfctl_core.
> 
> The test is running on an EPYC Rome machine.
> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# lscpu | grep perfctl
> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~#
> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
> [    0.732097] Performance Events: AMD PMU driver.
> 
> By further looking,
> 
> ==> init_hw_perf_events
>     ==> amd_pmu_init
>         ==> amd_core_pmu_init
>             ==>
>                 if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> 			return 0;
> 
> With returning 0, it will bypass amd_pmu_init and return 0 to
> init_hw_perf_events, and continue the initialization.
> 
> I am not a perf expert and not sure if it is expected for AMD PMU,
> otherwise, it would be nice to return -ENODEV instead.
> 
> New output after the change:
> root@ubuntu-s-4vcpu-8gb-amd-nyc1-01:~# dmesg | grep PMU
> [    0.531609] Performance Events: no PMU driver, software events only.
> 
> Signed-off-by: Liang Yan <lyan@digtalocean.com>

Looks about right, Ravi?

> ---
>  arch/x86/events/amd/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 8b70237c33f7..34d3d2944020 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1335,7 +1335,7 @@ static int __init amd_core_pmu_init(void)
>  	int i;
>  
>  	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> -		return 0;
> +		return -ENODEV;
>  
>  	/* Avoid calculating the value each time in the NMI handler */
>  	perf_nmi_window = msecs_to_jiffies(100);
> -- 
> 2.34.1
> 
