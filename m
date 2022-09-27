Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136655EC350
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiI0Mxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiI0Mxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:53:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A5B6D56
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aloRj8yOFal8+2rRTL0YzwFMaENdV4F/Ynk/LWIEuhI=; b=G9gO0yugVGRa+9tV2jeoEaKQjx
        NAMzKQmscCu+sgLPh8bWSFrJubYL95VyYZJAnVfMYTKOmXmgHCZ6XD/t75Vfqct3YKYMHO8fF5pyj
        DJDrzgK1DVkrb3WToQb4hBau+nptFn/mob2uvDok9TjItqAa46ke8eBRB9sl57cdHhHIO/RqeBmT9
        2BIcKhpIVTx9ZxeKutyCccW/i7ajSLUwvyDugbhK9AZBF2mw0gsNrNLRrKNoBzRdtvvCTCrYlvBPT
        qUsh+rYHL1OMDjlod2Z9YVtq/ft2FSVpMEmLuNwGTWbESZywp2tN+jfVD0CjaxkG9zFGCjQJ+6DRG
        9lT3QJQA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odA5a-00GHsz-LL; Tue, 27 Sep 2022 12:53:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D37B9300205;
        Tue, 27 Sep 2022 14:53:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C365C20424F6E; Tue, 27 Sep 2022 14:53:29 +0200 (CEST)
Date:   Tue, 27 Sep 2022 14:53:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH 23/23] x86/process: Reset hardware history in context
 switch
Message-ID: <YzLySV4545F0MKSl@hirez.programming.kicks-ass.net>
References: <20220909231205.14009-1-ricardo.neri-calderon@linux.intel.com>
 <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909231205.14009-24-ricardo.neri-calderon@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:12:05PM -0700, Ricardo Neri wrote:
> Reset the classification history of the current task when switching to
> the next task. Hardware will start anew the classification of the next
> running task.

Please quantify the cost of this HRESET instruction.

> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index 2f314b170c9f..74d8ad83e0b3 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -52,6 +52,7 @@
>  #include <asm/switch_to.h>
>  #include <asm/vm86.h>
>  #include <asm/resctrl.h>
> +#include <asm/hreset.h>
>  #include <asm/proto.h>
>  
>  #include "process.h"
> @@ -214,6 +215,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in();
>  
> +	reset_hardware_history();
> +
>  	return prev_p;
>  }
>  
> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> index 1962008fe743..0b175f30f359 100644
> --- a/arch/x86/kernel/process_64.c
> +++ b/arch/x86/kernel/process_64.c
> @@ -53,6 +53,7 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/vdso.h>
>  #include <asm/resctrl.h>
> +#include <asm/hreset.h>
>  #include <asm/unistd.h>
>  #include <asm/fsgsbase.h>
>  #ifdef CONFIG_IA32_EMULATION
> @@ -657,6 +658,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	/* Load the Intel cache allocation PQR MSR. */
>  	resctrl_sched_in();
>  
> +	reset_hardware_history();
> +
>  	return prev_p;
>  }
>  
> -- 
> 2.25.1
> 
