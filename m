Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF96E65CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjDRN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjDRNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:25:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BCB13849
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VXVwCF3qDAX9JRVHi0Xw+lXVAZHRP7LJdDTLBBlym0Q=; b=n2Gb2VsKjNZ/UyVWsoy/uKfyNI
        iHIiBw2cByDbgkEu8tpZcaaK37PBbv0T+3gzftCKWdEB7J9zUjzAhs2/oMR3NUJFO3VHPclvIMfL0
        Z9JSfo6uu4Z9xU5mICP+tfhvMx8Qt32VnXf3GOfQ0HVuwzWLerqLUPxcWWT2HGk4KegFc7efmxS0Q
        DTZl+GsHvm7+UbHZD7Thn3W74OSpXexqpjcdEGH7+qzOrd44U4WZ1FJYHMXi1/7gUWFiUmdNchA4R
        rm//rdMIkeFOaSH6WhulADU6Z4WwoMpphDlqHSitJmOri8l7H10SmS/V7NtQgcnyklOFf7bgT/MZW
        Y2yQBF7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1polKy-00CK52-Gu; Tue, 18 Apr 2023 13:25:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CB04300237;
        Tue, 18 Apr 2023 15:25:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C85D420182A6E; Tue, 18 Apr 2023 15:25:33 +0200 (CEST)
Date:   Tue, 18 Apr 2023 15:25:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH RFC] preempt: Put preempt_enable() within an
 instrumentation*() section.
Message-ID: <20230418132533.GA4253@hirez.programming.kicks-ass.net>
References: <20230309072724.3F6zRkvw@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309072724.3F6zRkvw@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 08:27:24AM +0100, Sebastian Andrzej Siewior wrote:
> Callers of preempt_enable() can be within an noinstr section leading to:
> | vmlinux.o: warning: objtool: native_sched_clock+0x97: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: kvm_clock_read+0x22: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: local_clock+0xb4: call to preempt_schedule_notrace_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: enter_from_user_mode+0xea: call to preempt_schedule_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: syscall_enter_from_user_mode+0x140: call to preempt_schedule_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare+0xf2: call to preempt_schedule_thunk() leaves .noinstr.text section
> | vmlinux.o: warning: objtool: irqentry_enter_from_user_mode+0xea: call to preempt_schedule_thunk() leaves .noinstr.text section
> 
> This only happens on CONFIG_PREEMPT+ due to the conditional call into the scheduler.

I think I see; but I can't reproduce. I use:

  defconfig + CONFIG_PREEMPT + CONFIG_DEBUG_ENTRY

let me try and figure out wtf to do about this :/
