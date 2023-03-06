Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C176ABEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCFMB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCFMBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:01:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C591F915
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ic3DZ0sZlZGVPgvKXhJ/FaiYe4dpwzrLhdBXuxj9WKM=; b=uyrdBCZ19E2q9MpH/HJNfz2aSB
        MkATUkp3Bj+lwLbwF81PaZY/FQ1W3UadG++tGheEPBgHc7Ou+jYSFV87/gXJjemBrg+9rnN+IZVhb
        XvFTG1a2fcHxcuJagXl2ETvrGpPCxfGvAQH8gmld8Jz1+Spe3tjuADdgDZnJj+/3lP4mNoQcY8ztE
        JUJ9Ne2vCUZtgSEcK8CulmrduCf+zEkb0/ByFZmbTRHMWB/aGF/v5wxiAjmlWV89UhYPUi+tV7GWf
        H509S1I7ruY+Hq5QI4aA+7Y691rfYgRVQlU9gdk8VdPQsV2dXkIMQDgVYFFRbwcEKt/IGr1aaRfQP
        OLQq/5yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ9Wd-005JbG-Ah; Mon, 06 Mar 2023 12:01:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 676E1300328;
        Mon,  6 Mar 2023 13:01:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4A0DD23B586C3; Mon,  6 Mar 2023 13:01:06 +0100 (CET)
Date:   Mon, 6 Mar 2023 13:01:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, tony.luck@intel.com,
        reinette.chatre@intel.com, fenghua.yu@intel.com,
        peternewman@google.com, bp@suse.de, james.morse@arm.com,
        babu.moger@amd.com, ananth.narayan@amd.com, vschneid@redhat.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] x86/resctrl: avoid compiler optimization in
 __resctrl_sched_in
Message-ID: <20230306120106.GE1267364@hirez.programming.kicks-ass.net>
References: <20230303231133.1486085-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303231133.1486085-1-eranian@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 03:11:33PM -0800, Stephane Eranian wrote:

> The problem is located in the __resctrl_sched_in() routine which rewrites
> the active closid via the PQR_ASSOC register. Because this is an expensive
> operation, the kernel only does it when the context switch involves tasks
> with different CLOSID. And to check that, it needs to access the current
> task's closid field using current->closid. current is actually a macro
> that reads the per-cpu variable pcpu_hot.current_task.
> 
> After an investigation by compiler experts, the problem has been tracked down
> to the usage of the get_current() macro in the __resctrl_sched_in() code and
> in particular the per-cpu macro:
> 
> static __always_inline struct task_struct *get_current(void)
> {
>         return this_cpu_read_stable(pcpu_hot.current_task);
> }
> 
> And as per percpu.h:
> 
> /*
>  * this_cpu_read() makes gcc load the percpu variable every time it is
>  * accessed while this_cpu_read_stable() allows the value to be cached.
>  * this_cpu_read_stable() is more efficient and can be used if its value
>  * is guaranteed to be valid across cpus.  The current users include
>  * get_current() and get_thread_info() both of which are actually
>  * per-thread variables implemented as per-cpu variables and thus
>  * stable for the duration of the respective task.
>  */
> 
> The _stable version of the macro allows the value to be cached, meaning it
> does not force a reload.

Right, so afaict the difference between this_cpu_read() and
this_cpu_read_stable() is the volatile qualifier.

this_cpu_read() is asm volatile(), while this_cpu_read_stable() and
raw_cpu_read() are both an unqualified asm().

Now, afaiu we're inlining all of this into __switch_to(), which has
raw_cpu_write(pcpu_hot.current_task, next_p).

And I suppose what the compiler is doing is lifting the 'current' load
over that store, but how is it allowed that? I thought C was supposed to
have PO consistency, That raw_cpu_write() should be seen as a store to
to pcpu_hot.current_task, why can it lift a load over the store?

Specifically, percpu_to_op() has a "+m" output constaint while
percpu_stable_op() has a "p" input constraint on the same address.

Compiler folks help?
