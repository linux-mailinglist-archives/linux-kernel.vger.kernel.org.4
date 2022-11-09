Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F1462294E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKIK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiKIKzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:55:44 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F52A97A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:54:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 944C31F6E6;
        Wed,  9 Nov 2022 10:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667991262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6b+H19pII4E8fmpA+3wTFon6VeJwtRQ+7i5z8v4dLt0=;
        b=mvSyfb4aOLUJmyWl6eZwrc5aEItVPnoQIGR3u5iXA36qRlbUgagAmcwo10ijDCXwJK8hf2
        ZJIVO/bJVaben5EKu/2LaOlWgt5lskhsxzvj9nA7CmE7XXyvJTuZ0CXuN16obonZqgX1mP
        FO/qrOemjSpCSsTT0RUkilHgWifAwhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667991262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6b+H19pII4E8fmpA+3wTFon6VeJwtRQ+7i5z8v4dLt0=;
        b=C1/qy0I/QaGIpSgx5veBA/ZfkQGRa6fY9kLcfqcrNSLts0jljDdwsz4Mzv/5RynZk62mSX
        icbK1ufMWJwlAkDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83F521331F;
        Wed,  9 Nov 2022 10:54:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id INoyIN6Ga2PpJgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 09 Nov 2022 10:54:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 12ECCA0704; Wed,  9 Nov 2022 11:54:22 +0100 (CET)
Date:   Wed, 9 Nov 2022 11:54:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Jan Kara <jack@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221109105422.lk3kgdzxwflozndw@quack3>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <Y2o1NAE7d6Tf5ILt@FVFF77S0Q05N.cambridge.arm.com>
 <20221108174529.pp4qqi2mhpzww77p@quack3>
 <Y2t4+6MwVZEhoV5n@FVFF77S0Q05N.cambridge.arm.com>
 <fb95c436-c648-7459-b79e-c38afe11f1b5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb95c436-c648-7459-b79e-c38afe11f1b5@arm.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-11-22 11:11:46, Pierre Gondois wrote:
> On 11/9/22 10:55, Mark Rutland wrote:
> > On Tue, Nov 08, 2022 at 06:45:29PM +0100, Jan Kara wrote:
> > > On Tue 08-11-22 10:53:40, Mark Rutland wrote:
> > > > On Mon, Nov 07, 2022 at 11:49:01AM -0500, Waiman Long wrote:
> > > > > On 11/7/22 10:10, Sebastian Andrzej Siewior wrote:
> > > > > > + locking, arm64
> > > > > > 
> > > > > > On 2022-11-07 14:56:36 [+0100], Jan Kara wrote:
> > > > > > > > spinlock_t and raw_spinlock_t differ slightly in terms of locking.
> > > > > > > > rt_spin_lock() has the fast path via try_cmpxchg_acquire(). If you
> > > > > > > > enable CONFIG_DEBUG_RT_MUTEXES then you would force the slow path which
> > > > > > > > always acquires the rt_mutex_base::wait_lock (which is a raw_spinlock_t)
> > > > > > > > while the actual lock is modified via cmpxchg.
> > > > > > > So I've tried enabling CONFIG_DEBUG_RT_MUTEXES and indeed the corruption
> > > > > > > stops happening as well. So do you suspect some bug in the CPU itself?
> > > > > > If it is only enabling CONFIG_DEBUG_RT_MUTEXES (and not whole lockdep)
> > > > > > then it looks very suspicious.
> > > > > > CONFIG_DEBUG_RT_MUTEXES enables a few additional checks but the main
> > > > > > part is that rt_mutex_cmpxchg_acquire() + rt_mutex_cmpxchg_release()
> > > > > > always fail (and so the slowpath under a raw_spinlock_t is done).
> > > > > > 
> > > > > > So if it is really the fast path (rt_mutex_cmpxchg_acquire()) then it
> > > > > > somehow smells like the CPU is misbehaving.
> > > > > > 
> > > > > > Could someone from the locking/arm64 department check if the locking in
> > > > > > RT-mutex (rtlock_lock()) is correct?
> > > > > > 
> > > > > > rtmutex locking uses try_cmpxchg_acquire(, ptr, ptr) for the fastpath
> > > > > > (and try_cmpxchg_release(, ptr, ptr) for unlock).
> > > > > > Now looking at it again, I don't see much difference compared to what
> > > > > > queued_spin_trylock() does except the latter always operates on 32bit
> > > > > > value instead a pointer.
> > > > > 
> > > > > Both the fast path of queued spinlock and rt_spin_lock are using
> > > > > try_cmpxchg_acquire(), the only difference I saw is the size of the data to
> > > > > be cmpxchg'ed. qspinlock uses 32-bit integer whereas rt_spin_lock uses
> > > > > 64-bit pointer. So I believe it is more on how the arm64 does cmpxchg. I
> > > > > believe there are two different ways of doing it depending on whether LSE
> > > > > atomics is available in the platform. So exactly what arm64 system is being
> > > > > used here and what hardware capability does it have?
> > > > 
> > > >  From the /proc/cpuinfo output earlier, this is a Neoverse N1 system, with the
> > > > LSE atomics. Assuming the kernel was built with support for atomics in-kernel
> > > > (which is selected by default), it'll be using the LSE version.
> > > 
> > > So I was able to reproduce the corruption both with LSE atomics enabled &
> > > disabled in the kernel. It seems the problem takes considerably longer to
> > > reproduce with LSE atomics enabled but it still does happen.
> > > 
> > > BTW, I've tried to reproduced the problem on another aarch64 machine with
> > > CPU from a different vendor:
> > > 
> > > processor       : 0
> > > BogoMIPS        : 200.00
> > > Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm jscvt fcma dcpop asimddp asimdfhm
> > > CPU implementer : 0x48
> > > CPU architecture: 8
> > > CPU variant     : 0x1
> > > CPU part        : 0xd01
> > > CPU revision    : 0
> > > 
> > > And there the problem does not reproduce. So might it be a genuine bug in
> > > the CPU implementation?
> > 
> > Perhaps, though I suspect it's more likely that we have an ordering bug in the
> > kernel code, and it shows up on CPUs with legitimate but more relaxed ordering.
> > We've had a couple of those show up on Apple M1, so it might be worth trying on
> > one of those.
> > 
> > How easy is this to reproduce? What's necessary?
> > 
> > Thanks,
> > Mark.
> 
> It is possible to reproduce it on an Ampere Altra, which has the following cpuinfo:
>   processor       : 0
>   BogoMIPS        : 50.00
>   Features        : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp ssbs
>   CPU implementer : 0x41
>   CPU architecture: 8
>   CPU variant     : 0x3
>   CPU part        : 0xd0c
>   CPU revision    : 1
> 
> Command used:
>   dbench 80 -t 300 --clients-per-process=8
> 
> With the diff [2] applied, I get [1]. So sb_clear_inode_writeback()
> seems to be called on a CPU with a null i_count. Maybe:
> - CPUx deletes the inode via iput().
> - CPUy calls sb_clear_inode_writeback() to update inode->i_wb_list
>   at the same time.

Yes, this is actually expected. inode->i_count can reach 0 while writeback
is in progress. Once i_count reaches 0, we get to iput_final() and either
add the inode to the LRU or decide to remove the inode and go to evict()
where truncate_inode_pages_final() is going to wait for all PageWriteback
bits and thus for all outstanding writeback for the inode.

If you want to independently check whether the inode is not getting freed
while still being under writeback, you can add assertion about your
inode->count being 0 to clear_inode(). In fact in my testing I have added
this assertion and it never triggered despite the list corruption was
happening.

								Honza

> [1]
> [  165.003036] ------------[ cut here ]------------
> [  165.003042] kernel BUG at fs/fs-writeback.c:1294!
> [  165.003047] Internal error: Oops - BUG: 0 [#1] PREEMPT_RT SMP
> [  165.003052] Modules linked in: [...]
> [  165.003131] CPU: 87 PID: 9 Comm: kworker/u320:0 Not tainted 6.0.5-rt14-[...] #92
> [  165.003137] Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
> [  165.003138] Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
> [  165.003148] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  165.003151] pc : sb_clear_inode_writeback (fs/fs-writeback.c:1294 (discriminator 1))
> [  165.003159] lr : sb_clear_inode_writeback (./include/linux/atomic/atomic-instrumented.h:28 fs/fs-writeback.c:1292)
> [...]
> [  165.003219] Call trace:
> [  165.003222] sb_clear_inode_writeback (fs/fs-writeback.c:1294 (discriminator 1))
> [  165.003226] __folio_end_writeback (./include/linux/spinlock_rt.h:123 mm/page-writeback.c:2942)
> [  165.003231] folio_end_writeback (mm/filemap.c:1620)
> [  165.003234] end_page_writeback (mm/folio-compat.c:27)
> [  165.003237] ext4_finish_bio (fs/ext4/page-io.c:145)
> [  165.003240] ext4_release_io_end (fs/ext4/page-io.c:161 (discriminator 3))
> [  165.003243] ext4_end_io_rsv_work (./include/linux/list.h:292 fs/ext4/page-io.c:254 fs/ext4/page-io.c:273)
> [  165.003246] process_one_work (kernel/workqueue.c:2294)
> [  165.003250] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2437)
> [  165.003252] kthread (kernel/kthread.c:376)
> [  165.003255] ret_from_fork (arch/arm64/kernel/entry.S:861)
> [ 165.003260] Code: 54fff8a0 942cf1d4 17ffffc3 d4210000 (d4210000)
> [...]
> [  165.245010] ------------[ cut here ]------------
> 
> 
> [2]
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 443f83382b9b..0edb03eb43a4 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1252,13 +1252,27 @@ void sb_mark_inode_writeback(struct inode *inode)
>  {
>         struct super_block *sb = inode->i_sb;
>         unsigned long flags;
> +       int local_count;
>         if (list_empty(&inode->i_wb_list)) {
>                 spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
> +
> +               local_count = atomic_read(&inode->count) + 1;
> +               BUG_ON(local_count != atomic_inc_return(&inode->count));
> +               BUG_ON(!atomic_read(&inode->i_count));
> +
>                 if (list_empty(&inode->i_wb_list)) {
> +
> +                       BUG_ON(!atomic_read(&inode->i_count));
> +
>                         list_add_tail(&inode->i_wb_list, &sb->s_inodes_wb);
>                         trace_sb_mark_inode_writeback(inode);
>                 }
> +
> +               local_count = atomic_read(&inode->count) + 1;
> +               BUG_ON(local_count != atomic_inc_return(&inode->count));
> +               BUG_ON(!atomic_read(&inode->i_count));
> +
>                 spin_unlock_irqrestore(&sb->s_inode_wblist_lock, flags);
>         }
>  }
> @@ -1270,13 +1284,27 @@ void sb_clear_inode_writeback(struct inode *inode)
>  {
>         struct super_block *sb = inode->i_sb;
>         unsigned long flags;
> +       int local_count;
>         if (!list_empty(&inode->i_wb_list)) {
>                 spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
> +
> +               local_count = atomic_read(&inode->count) - 1;
> +               BUG_ON(local_count != atomic_dec_return(&inode->count));
> +               BUG_ON(!atomic_read(&inode->i_count));
> +
>                 if (!list_empty(&inode->i_wb_list)) {
> +
> +                       BUG_ON(!atomic_read(&inode->i_count));
> +
>                         list_del_init(&inode->i_wb_list);
>                         trace_sb_clear_inode_writeback(inode);
>                 }
> +
> +               local_count = atomic_read(&inode->count) - 1;
> +               BUG_ON(local_count != atomic_dec_return(&inode->count));
> +               BUG_ON(!atomic_read(&inode->i_count));
> +
>                 spin_unlock_irqrestore(&sb->s_inode_wblist_lock, flags);
>         }
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 56a4b4b02477..67027d4973a1 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -658,6 +658,7 @@ struct inode {
>         struct list_head        i_lru;          /* inode LRU list */
>         struct list_head        i_sb_list;
>         struct list_head        i_wb_list;      /* backing dev writeback list */
> +       atomic_t                count;
>         union {
>                 struct hlist_head       i_dentry;
>                 struct rcu_head         i_rcu;
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
