Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CE6D9445
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbjDFKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 06:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDFKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 06:38:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE2D658B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1wHLLFE2QFwDBIfIUAqICmklIECQ19tL+sJ9zzq91lA=; b=tH5KuBJV78ov6Xi73+RWhMOcRz
        4EGlzTXvfyoyxDK1TwpZK1t3IoxYWxMZAcMMkZGRBh0bKN//l/JNZc2kQKH1f/W8HrA0pNGF/1hxF
        gwOGyysfs22+Upo8UF6Cjq5Ik/SxitLCwizhhEnUmW9R6v6NfY2cv3r4CUpkYjbl8+UZ3Ol+GFmQ4
        TvvCbeUEzB8y9Ly+nWbTQ1NU7ix4CEjjF5U1AN/TbBn5oQQvuFuhCQpEMrcgO5XIE8IahISPQtbg1
        D9GISnO8ao5xixzqwv1joHd7E5FKXsX3hk3AcCelUkrM2/FNqgMvn7bjZr5t12aCaNtb0OdnyTWur
        CwgUGZWA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkN0t-00HKfj-8f; Thu, 06 Apr 2023 10:38:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 887D730008D;
        Thu,  6 Apr 2023 12:38:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6816920B6A7D6; Thu,  6 Apr 2023 12:38:41 +0200 (CEST)
Date:   Thu, 6 Apr 2023 12:38:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     tglx@linutronix.de, bsegall@google.com,
        linux-kernel@vger.kernel.org, pjt@google.com, posk@posk.io,
        joshdon@google.com
Subject: Re: UMCG - how should we proceed? Should we?
Message-ID: <20230406103841.GJ386572@hirez.programming.kicks-ass.net>
References: <20230328210754.2745989-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328210754.2745989-1-posk@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 02:07:54PM -0700, Peter Oskolkov wrote:
> Hi Peter!
> 
> TL;DR: which approach, if any, should a UMCG implementation in the mainline kernel use?
> 
> Details:
> 
> We are rolling out internally a UMCG implementation copied below (with some
> boilerplate omitted), so I would like to restart our discussion on the topic.
> 
> The implementation below is different from what we had earlier
> (https://lore.kernel.org/lkml/20220120155517.066795336@infradead.org/)
> in that it keeps UMCG state in the kernel rather than TLS.
> 
> While having UMCG state in TLS is _much_ better, as it makes state synchronization
> between the userspace and the kernel much simpler, the whole page pinning
> machinery in the link above looked very scary, honestly.
> 
> So if we are going to ever have something like UMCG in the mainline kernel, we need
> to figure out the approach to use: the TLS-based one, something similar
> to what we have now internally (details below), or something else. Or none at all...
> 
> While I would very much prefer to have it done your way (state in TLS), the page pinning
> business was too much for me. If you can figure out a way to do it cleanly and reliably, great!

A few quick notes without having looked at the patch...

> The main differences between what you had in the TLS patchset and what is below:

(note that in the end the per-task UMCG info thing didn't *need* to be
TLS, although it is a logical place to put it)

> - per worker/server state not in TLS but in task_struct
> - we keep a list of idle workers and a list of idle servers in mm

How much of a scalability fail is that? Mathieu and me are currently
poking at a rseq/cid regression due to large multi thread contention on
mm data.

But yeah, I think this was one of the open issues we still had; with the
other implementation -- I seem to have a half finished patch for an
idle_server list.

> - worker wake events are delivered not to servers which ran the workers earlier,
>   but to idle servers from the idle server list

Provided there is one I take it; very easy to run out of idle things.
Also, what if you want to explicitly manage placement, can you still
direct the wakeup?

> - worker preemption happens not via a syscall (umcg_kick) but by hooking
>   into sched_tick

sched_tick would render it somewhat unsuitable for RT
workloads/schedulers where you might need more immediate preemption.

> None of the differences above are deal breakers; again, if the TLS/page pinning
> approach is viable, we will gladly use it.

Urgh, so yeah.. I meant to go look at the whole UMCG thing again with an
eye specifically at inter-process support.

I'm hoping inter-process UMCG can be used to implement custom libpthread
that would allow running most of userspace under a custom UMCG scheduler
and obviate the need for this horrible piece of shit eBPF sched thing.

But I keep getting side-tracked with other stuff :/ I'll try and bump
this stuff up the todo list.
