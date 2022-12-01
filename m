Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4784B63F0A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiLAMh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiLAMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:37:56 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90238209A9
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:37:54 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4CF0A21AB4;
        Thu,  1 Dec 2022 12:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669898273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S005OX22erO/mDOjRPI+EjExCnxZCxKJnETLoyHOjSg=;
        b=N2ufwnqrpal/oS89/0lBSdASQrasYLh25hDoudr94RUhocSWE6Ku6ASqo+rRqBqNssTcJQ
        MG19UAnNNneVQuAXfMMUUdM95wfLOsvJJaKu3hUYcIkfVw6IPnxsmVc9NaMGVtA7358UL/
        ui/MfAv8l8r+8RHIghtAP1f0TG7RwAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669898273;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S005OX22erO/mDOjRPI+EjExCnxZCxKJnETLoyHOjSg=;
        b=rgV/TDgxjXP22pKo3M5TYgD9NL8+TJjV7Mzh1Liu/teKsQh8uVdCt3iAyicel/Q3VLgJTg
        rugDPDPYuixOUvBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 303E913503;
        Thu,  1 Dec 2022 12:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 6SvsCiGgiGNhdAAAGKfGzw
        (envelope-from <jack@suse.cz>); Thu, 01 Dec 2022 12:37:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8647A06E4; Thu,  1 Dec 2022 13:37:52 +0100 (CET)
Date:   Thu, 1 Dec 2022 13:37:52 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Jan Kara <jack@suse.cz>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Message-ID: <20221201123752.po5z2qpmitafuzhn@quack3>
References: <Y2U+Je+LICO2HkNY@linutronix.de>
 <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <20221109125756.GA24388@willie-the-truck>
 <20221109154023.cx2d4y3e7zqnuo35@quack3>
 <20221111142742.rh677sdwu55aeeno@quack3>
 <20221114124147.GA30263@willie-the-truck>
 <Y4Tapja2qq8HiHBZ@linutronix.de>
 <207c79df-79e8-e6c9-d042-b69dea87a355@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <207c79df-79e8-e6c9-d042-b69dea87a355@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 30-11-22 18:20:27, Pierre Gondois wrote:
> 
> On 11/28/22 16:58, Sebastian Andrzej Siewior wrote:
> > How about this?
> > 
> > - The fast path is easy…
> > 
> > - The slow path first sets the WAITER bits (mark_rt_mutex_waiters()) so
> >    I made that one _acquire so that it is visible by the unlocker forcing
> >    everyone into slow path.
> > 
> > - If the lock is acquired, then the owner is written via
> >    rt_mutex_set_owner(). This happens under wait_lock so it is
> >    serialized and so a WRITE_ONCE() is used to write the final owner. I
> >    replaced it with a cmpxchg_acquire() to have the owner there.
> >    Not sure if I shouldn't make this as you put it:
> > |   e.g. by making use of dependency ordering where it already exists.
> >    The other (locking) CPU needs to see the owner not only the WAITER
> >    bit. I'm not sure if this could be replaced with smp_store_release().
> > 
> > - After the whole operation completes, fixup_rt_mutex_waiters() cleans
> >    the WAITER bit and I kept the _acquire semantic here. Now looking at
> >    it again, I don't think that needs to be done since that shouldn't be
> >    set here.
> > 
> > - There is rtmutex_spin_on_owner() which (as the name implies) spins on
> >    the owner as long as it active. It obtains it via READ_ONCE() and I'm
> >    not sure if any memory barrier is needed. Worst case is that it will
> >    spin while owner isn't set if it observers a stale value.
> > 
> > - The unlock path first clears the waiter bit if there are no waiters
> >    recorded (via simple assignments under the wait_lock (every locker
> >    will fail with the cmpxchg_acquire() and go for the wait_lock)) and
> >    then finally drop it via rt_mutex_cmpxchg_release(,, NULL).
> >    Should there be a wait, it will just store the WAITER bit with
> >    smp_store_release() (setting the owner is NULL but the WAITER bit
> >    forces everyone into the slow path).
> > 
> > - Added rt_mutex_set_owner_pi() which does simple assignment. This is
> >    used from the futex code and here everything happens under a lock.
> > 
> > - I added a smp_load_acquire() to rt_mutex_base_is_locked() since I
> >    *think* want to observe a real waiter and not something stale.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> 
> Hello,
> Just to share some debug attempts, I tried Sebastian's patch and could not
> reproduce the error. While trying to understand the solution, I could not
> reproduce the error if I only took the changes made to
> mark_rt_mutex_waiters(), or to rt_mutex_set_owner_pi(). I am not sure I
> understand why this would be a rt-mutex issue.
> 
> Without Sebastian's patch, to try adding some synchronization around the
> 'i_wb_list', I did the following:
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 443f83382b9b..42ce1f7f8aef 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1271,10 +1271,10 @@ void sb_clear_inode_writeback(struct inode *inode)
>         struct super_block *sb = inode->i_sb;
>         unsigned long flags;
> -       if (!list_empty(&inode->i_wb_list)) {
> +       if (!list_empty_careful(&inode->i_wb_list)) {

In my debug attempts I've actually completely removed this unlocked check
and the corruption still triggered.

>                 spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
> -               if (!list_empty(&inode->i_wb_list)) {
> -                       list_del_init(&inode->i_wb_list);
> +               if (!list_empty_careful(&inode->i_wb_list)) {
> +                       list_del_init_careful(&inode->i_wb_list);

This shouldn't be needed, at least once unlocked checks are removed. Also
even if they stay, the list should never get corrupted because all the
modifications are protected by the spinlock. This is why we eventually
pointed to the rt_mutex as the problem.

It may be possible that your change adds enough memory ordering so that the
missing ordering in rt_mutex does not matter anymore. 

> diff --git a/fs/inode.c b/fs/inode.c
> index b608528efd3a..fbe6b4fe5831 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -621,7 +621,7 @@ void clear_inode(struct inode *inode)
>         BUG_ON(!list_empty(&inode->i_data.private_list));
>         BUG_ON(!(inode->i_state & I_FREEING));
>         BUG_ON(inode->i_state & I_CLEAR);
> -       BUG_ON(!list_empty(&inode->i_wb_list));
> +       BUG_ON(!list_empty_careful(&inode->i_wb_list));
>         /* don't need i_lock here, no concurrent mods to i_state */
>         inode->i_state = I_FREEING | I_CLEAR;
>  }
> 
> I never stepped on the:
>   BUG_ON(!list_empty_careful(&inode->i_wb_list))
> statement again, but got the dump at [2]. I also regularly end-up
> with the following endless logs when trying other things, when rebooting:
> 
> EXT4-fs (nvme0n1p3): sb orphan head is 2840597
> sb_info orphan list:
>   inode nvme0n1p3:3958579 at 00000000b5934dff: mode 100664, nlink 1, next 0
>   inode nvme0n1p3:3958579 at 00000000b5934dff: mode 100664, nlink 1, next 0
>   ...

Looks like another list corruption - in this case ext4 list of inodes that
are undergoing truncate.

> Also, Jan said that the issue was reproducible on 'two different aarch64
> machines', cf [1]. Would it be possible to know which one ?

Both had the same Ampere CPU. Full cpuinfo is here:

https://lore.kernel.org/all/20221107135636.biouna36osqc4rik@quack3/

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
