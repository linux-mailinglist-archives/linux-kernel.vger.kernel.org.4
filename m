Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1C561F4AD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiKGN4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKGN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:56:39 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DADA1CFE1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:56:38 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3BBEF2188B;
        Mon,  7 Nov 2022 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667829397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gWp5fTuXs5+ojEKRJQFBE3iJHRHJas7GscfWLZRmHaQ=;
        b=Lo7PaQ8V+8Fqsn5S0cBgTjSVzizidFiWpjtFbkPLu36BXsUG0SAJkXt9RnQW7pj9dEJhWV
        8Xj3Jc68A//ba7PMr5OtGnN7pZlELAMDofBQTTer/ULwKH133Z6QkbtfqqXOYknnbN6nJ+
        9ck1QLU7lyPuXRtJDvGeqyU1jpIOOik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667829397;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gWp5fTuXs5+ojEKRJQFBE3iJHRHJas7GscfWLZRmHaQ=;
        b=3H7uSATVGNF1yLvWrxhDxgL9JENEWT0bYnaUrnN2uDXoHlIcMsjak4N62c1xjBDz/ELzrf
        EmKm+0ZPz200TwCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F8FF13494;
        Mon,  7 Nov 2022 13:56:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EEi3C5UOaWP9agAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 13:56:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A0FB7A0704; Mon,  7 Nov 2022 14:56:36 +0100 (CET)
Date:   Mon, 7 Nov 2022 14:56:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221107135636.biouna36osqc4rik@quack3>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2U+Je+LICO2HkNY@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 04-11-22 17:30:29, Sebastian Andrzej Siewior wrote:
> On 2022-11-03 12:54:44 [+0100], Jan Kara wrote:
> > Hello,
> Hi,
> 
> > I was tracking down the following crash with 6.0 kernel with
> > patch-6.0.5-rt14.patch applied:
> > 
> > [ T6611] ------------[ cut here ]------------
> > [ T6611] kernel BUG at fs/inode.c:625!
> 
> seems like an off-by-one ;)
> 
> > The machine is aarch64 architecture, kernel config is attached. I have seen
> > the crashes also with 5.14-rt kernel so it is not a new thing. The crash is
> > triggered relatively reliably (on two different aarch64 machines) by our
> > performance testing framework when running dbench benchmark against an XFS
> > filesystem.
> 
> different aarch64 machines as in different SoC? Or the same CPU twice.
> And no trouble on x86-64 I guess?

The same CPU it appears, just different machines. The problem never
happened on x86-64, that is correct. /proc/cpuinfo from the two machines
is:

processor	: 0
BogoMIPS	: 50.00
Features	: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp ssbs
CPU implementer	: 0x41
CPU architecture: 8
CPU variant	: 0x3
CPU part	: 0xd0c
CPU revision	: 1

...

there are 80 cpus in total in the machine.


> > Now originally I thought this is some problem with XFS or writeback code
> > but after debugging this for some time I don't think that anymore.
> > clear_inode() complains about inode->i_wb_list being non-empty. In fact
> > looking at the list_head, I can see it is corrupted. In all the occurences
> > of the problem ->prev points back to the list_head itself but ->next points
> > to some list_head that used to be part of the sb->s_inodes_wb list (or
> > actually that list spliced in wait_sb_inodes() because I've seen a pointer to
> > the stack as ->next pointer as well).
> 
> so you assume a delete and add operation in parallel?

Yes, I assume sb_clear_inode_writeback() was deleting inode from the list
while wait_sb_inodes() was doing list_move_tail() operation on the same list.

> > This is not just some memory ordering issue with the check in
> > clear_inode(). If I add sb->s_inode_wblist_lock locking around the check in
> > clear_inode(), the problem still reproduces.
> 
> What about dropping the list_empty() check in sb_mark_inode_writeback()
> and sb_clear_inode_writeback() so that the check operation always
> happens within the locked section? Either way, missing an add/delete
> should result in consistent pointers.

I've tested removing the list_empty() checks from sb_mark_inode_writeback()
and sb_clear_inode_writeback() but it didn't change a bit. The corruption
still happened.

> > If I enable CONFIG_DEBUG_LIST or if I convert sb->s_inode_wblist_lock to
> > raw_spinlock_t, the problem disappears.
> > 
> > Finally, I'd note that the list is modified from three places which makes
> > audit relatively simple. sb_mark_inode_writeback(),
> > sb_clear_inode_writeback(), and wait_sb_inodes(). All these places hold
> > sb->s_inode_wblist_lock when modifying the list. So at this point I'm at
> > loss what could be causing this. As unlikely as it seems to me I've started
> > wondering whether it is not some subtle issue with RT spinlocks on aarch64
> > possibly in combination with interrupts (because sb_clear_inode_writeback()
> > may be called from an interrupt).
> 
> This should be modified from a threaded interrupt so interrupts and
> preemption should be enabled at this point.
> If preemption and or interrupts are disabled at some point then
> CONFIG_DEBUG_ATOMIC_SLEEP should complain about it.

I see.

> spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> while the actual lock is modified via cmpxchg. 

So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
stops happening as well. So do you suspect some bug in the CPU itself?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
