Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA8619D4E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiKDQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiKDQbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:31:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602464AF05
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 09:30:32 -0700 (PDT)
Date:   Fri, 4 Nov 2022 17:30:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667579431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IWWRcr61poV2wfMEb6SdyyrYEqCB+EqRkP5X35iB6k=;
        b=EUPx6j0ozuXuQT9/w0dh85/ZqRpVDqpYDpkgqyIr4Hjuhi7nUlToPvT36QCi00Byyku8WP
        XY28FWwOm4ktjqh3CM4xrcqZfBTRGIJDx1nQkYTwNDHDUOxfKj7cPgCwEAAT9DiSw47tNZ
        4lgrxJzK1bg0QnnuR7gQ9cGixio5HyY3GLr5lhbl9FeOCYdCBZAfXn183tjMEauGrgx3Uz
        SCRlhvUgvWGVk7pGaVP/Lrui5M2cl0aIiXivcFtaYSAZhxix2kW8yVY5uf2q93FWeaDV7t
        ahCmM15PTDVrevdXvufJK4Snxh+gori21UmwadpCrb6Vi4Q3iBlXNu7PgUS8iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667579431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3IWWRcr61poV2wfMEb6SdyyrYEqCB+EqRkP5X35iB6k=;
        b=8CIaXqt4KIJKMD9QblwV+T8f00Pw15nvhOBI0vbJP/HStrkYCKyphAcD+eLGgsE7CFN7C7
        WvGhVADWrmeqTbCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jan Kara <jack@suse.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <Y2U+Je+LICO2HkNY@linutronix.de>
References: <20221103115444.m2rjglbkubydidts@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221103115444.m2rjglbkubydidts@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-03 12:54:44 [+0100], Jan Kara wrote:
> Hello,
Hi,

> I was tracking down the following crash with 6.0 kernel with
> patch-6.0.5-rt14.patch applied:
> 
> [ T6611] ------------[ cut here ]------------
> [ T6611] kernel BUG at fs/inode.c:625!

seems like an off-by-one ;)

> The machine is aarch64 architecture, kernel config is attached. I have seen
> the crashes also with 5.14-rt kernel so it is not a new thing. The crash is
> triggered relatively reliably (on two different aarch64 machines) by our
> performance testing framework when running dbench benchmark against an XFS
> filesystem.

different aarch64 machines as in different SoC? Or the same CPU twice.
And no trouble on x86-64 I guess?

> Now originally I thought this is some problem with XFS or writeback code
> but after debugging this for some time I don't think that anymore.
> clear_inode() complains about inode->i_wb_list being non-empty. In fact
> looking at the list_head, I can see it is corrupted. In all the occurences
> of the problem ->prev points back to the list_head itself but ->next points
> to some list_head that used to be part of the sb->s_inodes_wb list (or
> actually that list spliced in wait_sb_inodes() because I've seen a pointer to
> the stack as ->next pointer as well).

so you assume a delete and add operation in parallel?

> This is not just some memory ordering issue with the check in
> clear_inode(). If I add sb->s_inode_wblist_lock locking around the check in
> clear_inode(), the problem still reproduces.

What about dropping the list_empty() check in sb_mark_inode_writeback()
and sb_clear_inode_writeback() so that the check operation always
happens within the locked section? Either way, missing an add/delete
should result in consistent pointers.

> If I enable CONFIG_DEBUG_LIST or if I convert sb->s_inode_wblist_lock to
> raw_spinlock_t, the problem disappears.
> 
> Finally, I'd note that the list is modified from three places which makes
> audit relatively simple. sb_mark_inode_writeback(),
> sb_clear_inode_writeback(), and wait_sb_inodes(). All these places hold
> sb->s_inode_wblist_lock when modifying the list. So at this point I'm at
> loss what could be causing this. As unlikely as it seems to me I've started
> wondering whether it is not some subtle issue with RT spinlocks on aarch64
> possibly in combination with interrupts (because sb_clear_inode_writeback()
> may be called from an interrupt).

This should be modified from a threaded interrupt so interrupts and
preemption should be enabled at this point.
If preemption and or interrupts are disabled at some point then
CONFIG_DEBUG_ATOMIC_SLEEP should complain about it.

spinlock_t and raw_spinlock_t differ slightly in terms of locking.
rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
while the actual lock is modified via cmpxchg. 

> Any ideas?
> 
> 								Honza

Sebastian
