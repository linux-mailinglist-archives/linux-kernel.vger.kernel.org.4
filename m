Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A7261FAE4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiKGRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKGRM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:12:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CF1FFAE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:12:56 -0800 (PST)
Date:   Mon, 7 Nov 2022 18:12:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667841175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJ4z5vz/SZp2P2GdrW8ObedoYrFcfWUErVhcj97ybgI=;
        b=yjk50vTfE5/rJGMG1gJOiGEscLxL36PbMnp/bSMcAhLwR3QJvKlpnLbon/PsBj/LVi24bZ
        NH6CYp+LqzB/OBz41Cnp97nQ2/a38wwAwMPSd8o+rakBVIklK+3czkfADcaX7AMVgL8ACR
        qd2vMdjo7l/jcM9zhnVLA34avECggqYjhLvVFdjy3Cp/EJzg1BXL/wADhBJjJK1v4YRAy+
        2DyHsDz3FHgqRVbi6XkkE7fGJ4GI2ptY44UmMnVRAyyN6733z/LZD5Wf/7yAPV5CY8d/cn
        6T9J82BKatf17xD6pO+3rIR0j57YGL1WE3gtgVICkbAX3kv0e+jBjpjfffescw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667841175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oJ4z5vz/SZp2P2GdrW8ObedoYrFcfWUErVhcj97ybgI=;
        b=QxdSP3Y5XqS+eLr2dyoScoikpLyN7AeKu/sc8mwzLp7Clyhdz1iY+JtngjxTI9fry2xzJ2
        6Jny/fqZ6TNe5PDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <Y2k8lZNZ4/XuUm8K@linutronix.de>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <20221107163016.cnzhknmdnhajfxdh@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221107163016.cnzhknmdnhajfxdh@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-07 17:30:16 [+0100], Jan Kara wrote:
> On Mon 07-11-22 16:10:34, Sebastian Andrzej Siewior wrote:
> > + locking, arm64
> > 
> > On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > > > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > > > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > > > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > > > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > > > while the actual lock is modified via cmpxchg. 
> > > 
> > > So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> > > stops happening as well. So do you suspect some bug in the CPU itself?
> > 
> > If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> > then it looks very suspicious. 
> 
> Just to confirm, CONFIG_DEBUG_RT_MUTEXES is the only thing I've enabled and
> the list corruption disappeared.

I don't know if this works but:
if you tell task_struct_cachep to be created with SLAB_CACHE_DMA32 then
the pointer should only have the lower 32bit set. With this could make
rt_mutex_base::owner an atomic_t type. You could then replace
try_cmpxchg_acquire() with atomic_try_cmpxchg_acquire() and do the 32bit
cmpxchg. You would then need set the const upper 32bit of the pointer
while returning the pointer.
I have no idea how much sense it makes but you would avoid the 64bit
cmpxchg making those two a little more alike :)

> 								Honza
> 

Sebastian
