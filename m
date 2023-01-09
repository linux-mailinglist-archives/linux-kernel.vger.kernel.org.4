Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4042B6625C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbjAIMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjAIMl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:41:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B8215F13;
        Mon,  9 Jan 2023 04:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=uoWLYWZtTN5ZtWcVNElvXtV3FLHQfyD/J4yUz9n0OU4=; b=RQkP46LBZU9Ak6iH97viki6JVO
        qWgje3MyLedr138OMO67cuuHxYhiG03oEEn4np304QhQjzvqdx8kYieVIQRS0IOioLlimzXpPBXtN
        7+n0WJyUiA93kiggn8pkB9Of1AaAtnmxjHxR6U5WlSPOqMZg8AQ+5zEXxYZV7R9MoCGUUbUDQ9wjZ
        u5nR3QcrcInd4ySpKw+RwQOx31pNUiXT5iFV9s7bAC5DBhd6p6x7tAb/QIXSEDZHwtUy18S30dxBU
        wIIKISIcKuQsjAeWmpyd70lYmdrT23D5lNWEa6IH6rmP2pm69Hs8/kbOZpechHv8Onsl1YkckXwYB
        kBkSwfTw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pErSy-002H2w-Kf; Mon, 09 Jan 2023 12:41:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8ECE2300193;
        Mon,  9 Jan 2023 13:41:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66397201ABB81; Mon,  9 Jan 2023 13:41:15 +0100 (CET)
Date:   Mon, 9 Jan 2023 13:41:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     linux-perf-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Beeman Strong <beeman@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Anup Patel <apatel@ventanamicro.com>
Subject: Re: Expected rdpmc behavior during context swtich and a RISC-V
 conundrum
Message-ID: <Y7wLa7I2hlz3rKw/@hirez.programming.kicks-ass.net>
References: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOnJCUKNFNRs6WkPNWV94BuLmT3KSPWK2FYCiD4PxPCxRs76PA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:59:24AM -0800, Atish Patra wrote:
> Hi All,
> There was a recent uabi update[1] for RISC-V that allows the users to
> read cycle and instruction count without any checks.
> We tried to restrict that behavior to address security concerns
> earlier but it resulted in breakage for some user space
> applications[2].
> Thus, previous behavior was restored where a user on RISC-V platforms
> can directly read cycle or instruction count[3].
> 
> Comparison with other ISAs w.r.t user space access of counters:
> ARM64
>   -- Enabled/Disabled via (/proc/sys/kernel/perf_user_access)
>   -- Only for task bound events configured via perf.
> 
> X86
>  --- rdpmc instruction
>  --- Enable/Disable via “/sys/devices/cpu/rdpmc”
> -- Before v4.0
>  -- any process (even without active perf event) rdpmc
> After v4.0
> -- Default behavior changed to support only active events in a
> process’s context.
> -- Configured through perf similar to ARM64
> -- Continue to maintain backward compatibility for unrestricted access
> by writing 2 to “/sys/devices/cpu/rdpmc”
> 
> IMO, RISC-V should only enable user space access through perf similar
> to ARM64 and x86 (post v4.0).
> However, we do have to support the legacy behavior to avoid
> application breakage.
> As per my understanding a direct user space access can lead to the
> following problems:
> 
> 1) There is no context switch support, so counts from other contexts are exposed
> 2) If a perf user is allocated one of these counters, the counter
> value will be written
> 
> Looking at the x86 code as it continues to allow the above behavior,
> rdpmc_always_available_key is enabled in the above case. However,
> during the context switch (cr4_update_pce_mm)
> only dirty counters are cleared. It only prevents leakage from perf
> task to rdpmc task.
> 
> How does the context switch of counters work for users who enable
> unrestricted access by writing 2 to “/sys/devices/cpu/rdpmc” ?
> Otherwise, rdpmc users likely get noise from other applications. Is
> that expected ?
> This can be a security concern also where a rogue rdpmc user
> application can monitor other critical applications to initiate side
> channel attack.
> 
> Am I missing something? Please correct my understanding of the x86
> implementation if it is wrong.

So on x86 we have RDTSC and RDPMC instructions. RDTSC reads the
Time-Stamp-Counter which is a globally synchronized monotonic increasing
counter at some 'random' rate (idealized, don't ask). This thing is used
for time-keeping etc..

And then there's RDPMC which (optionally) allows reading the PMU
counters which are normally disabled and all 0.

Even if RDPMC is unconditionally allowed from userspace (the 2 option
you refer to) userspace will only be able to read these 0s unless
someone also programs the PMU. Linux only supports a single means of
doing so: perf (some people use /dev/msr to poke directly to the MSRs
but they get to keep all pieces).

RDPMC is only useful if you read counters you own on yourself -- IOW
selfmonitoring, using the interface outlined in uapi/linux/perf_events.h
near struct perf_event_mmap_page.

Any other usage -- you get to keep the pieces.

Can you observe random other counters, yes, unavoidably so. The sysfs
control you mention was instituted to restrict this somewhat.

If the RISC-V counters are fundamentally the PMU counters that need to
be reset to trigger events, then you've managed to paint yourself into a
tight spot :/

Either you must dis-allow userspace access to these things (and break
them) or limit the PMU usage -- both options suck.


Now, I'm thinking that esp. something like instruction count is not
synchronized between cores (seems fundamentally impossible) and can only
be reasonably be consumed (and compared) when strictly affine to a
particular CPU, you can argue that applications doing this without also
strictly managing their affinity mask are broken anyway and therefore
your breakage is not in fact a breaking them -- you can't break
something that's already broken.


Anyway, given RISC-V being a very young platform, I would try really
*really* *REALLY* hard to stomp on these applications and get them to
change in order to reclaim the PMU usage.
