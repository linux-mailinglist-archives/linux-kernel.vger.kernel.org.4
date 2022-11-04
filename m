Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4484061970F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiKDNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiKDNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:06:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4E2F01C;
        Fri,  4 Nov 2022 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LtHz5uPmwMnRA8pug11cAIugKhPmlVYnrt/fWjr2UQs=; b=D5/B7gyRf31MPbDuHBPq7nvyyP
        OTMpHwhz789CRYrPf6cXtunXceOPmlcI5l0W/zyMT9U1hHrx7YB6IOQM4eLHQ1m4yK0WRcnBq1IdR
        L29PkD26HOPr8vgV26Zu9iapv55p6bN/SK/2btYjPvlFEvLiAZzqN2KnRwz6nY5pP4Q7cu3/rHzL6
        WBqNB/LXdcckZpuY6+wGUiQg0IobaaH6X00iku04xOleQnkrumlpOwma57rnIYkbG+ljIdTTpoCBN
        XYDx3t6k1GphY4K9w/vYM20SjDlBfLLq7WnOuqjxBDctQIwxaA0s69ct73ND0eOLeS6jhcLlhGnSR
        yS0GrHeQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqwOh-008yeU-UO; Fri, 04 Nov 2022 13:06:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9E8E300282;
        Fri,  4 Nov 2022 14:06:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A07F201E232E; Fri,  4 Nov 2022 14:06:10 +0100 (CET)
Date:   Fri, 4 Nov 2022 14:06:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, anand.gore@broadcom.com,
        william.zhang@broadcom.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf: Fix perf_event_{init,exit}_cpu stubs
Message-ID: <Y2UOQpniaV12E0P9@hirez.programming.kicks-ass.net>
References: <20221103224303.3910486-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103224303.3910486-1-f.fainelli@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 03:43:03PM -0700, Florian Fainelli wrote:
> The original commit that introduced those stubs was already at fault,
> but in the absence of a caller of perf_event_{init,exit}_cpu outside of
> code that is compiled regardless of CONFIG_PERF_EVENTS, the build
> failure cannot be observed. This was observed with the Android kernel to
> produce a build failure similar to this:
> 
>     In file included from ./include/uapi/linux/posix_types.h:5,
>                      from ./include/uapi/linux/types.h:14,
>                      from ./include/linux/types.h:6,
>                      from ./include/linux/limits.h:6,
>                      from ./include/linux/kernel.h:7,
>                      from ./include/linux/sched/mm.h:5,
>                      from kernel/cpu.c:6:
>     kernel/cpu.c: In function 'random_and_perf_prepare_fusion':
>     ./include/linux/stddef.h:8:14: error: called object is not a function or function pointer
>      #define NULL ((void *)0)
>                   ^
>     ./include/linux/perf_event.h:1607:29: note: in expansion of macro 'NULL'
>      #define perf_event_init_cpu NULL
>                                  ^~~~
>     kernel/cpu.c:1686:2: note: in expansion of macro 'perf_event_init_cpu'
>       perf_event_init_cpu(cpu);
>       ^~~~~~~~~~~~~~~~~~~

What is the actual problem reported here? Did you see all the other NULL
assignments in cpuhp_hp_states ?

> 
> Fixes: 00e16c3d68fc ("perf/core: Convert to hotplug state machine")
> Reported-by: Anand Gore <anand.gore@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/linux/perf_event.h | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0031f7b4d9ab..592040e2398c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1678,8 +1678,15 @@ static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
>  int perf_event_init_cpu(unsigned int cpu);
>  int perf_event_exit_cpu(unsigned int cpu);
>  #else
> -#define perf_event_init_cpu	NULL
> -#define perf_event_exit_cpu	NULL
> +static inline int perf_event_init_cpu(unsigned int cpu)
> +{
> +	return 0;
> +}
> +
> +static inline int perf_event_exit_cpu(unsigned int cpu)
> +{
> +	return 0;
> +}
>  #endif
>  
>  extern void __weak arch_perf_update_userpage(struct perf_event *event,
> -- 
> 2.25.1
> 
