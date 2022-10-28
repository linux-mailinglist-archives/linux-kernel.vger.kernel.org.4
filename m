Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58A61090B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiJ1Dwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235160AbiJ1Dw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1787C9A2B3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 20:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6A57625F9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E314FC433D7;
        Fri, 28 Oct 2022 03:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666929144;
        bh=Q4DKoNPvzRhivZtxPB5oSRX7qfhQN5vPphiIGt2Sbuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deKWpJoNIwRPY/rWiyncXn4p2qpH65gQekVrdd0OjnWmpki2ajmeCeELRZY+4w4UL
         LhSS8qjjXOa10zaJ8HRr0pU8ZSt9jDyMa6hNKbgdyXOKiNGrL4s0XuTBzU4xirXOUs
         eseJnIgEHw95AAoIQxFOMcXMbI7O8gNoh0VEVKsLp5ghZoX0hjfOWQGaCvpZ5/cleZ
         kyqP4IRvMVdwTekpRzD/3W5dEHSEVxi5fEadiUAxtPKid0csTfSdUbDAqI1J4pytk5
         wT0iiRGezCSNLx7b1r1DxIuYIIvRa+JEAqGLF/5Ad+KnPHlvzxE843K6XYbhd+PgyY
         7EZrCJn2j2DOw==
Date:   Thu, 27 Oct 2022 20:52:22 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] f2fs: introducr gc_urgent_idle_remaining sysfs
 node and mark gc_urgent_high_remaining node deprecated
Message-ID: <Y1tR9ofJS5qFA4Y/@google.com>
References: <20221025065025.35017-1-frank.li@vivo.com>
 <20221025065025.35017-2-frank.li@vivo.com>
 <cd6d15e3-b692-d3c1-0f01-33e632f5f94c@kernel.org>
 <Y1tLEVYQjj2qC3I7@google.com>
 <5128189c-a90c-717e-45e1-9c05f51e50a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5128189c-a90c-717e-45e1-9c05f51e50a6@kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28, Chao Yu wrote:
> On 2022/10/28 11:22, Jaegeuk Kim wrote:
> > On 10/28, Chao Yu wrote:
> > > On 2022/10/25 14:50, Yangtao Li wrote:
> > > > Added a new sysfs node called gc_urgent_idle_remaining.
> > > > The user can set the trial count limit for GC urgent and
> > > > idle mode with this value. If GC thread gets to the limit,
> > > > the mode will turn back to GC normal mode finally.
> > > > 
> > > > This method is not only applicable to gc_urgent_high,
> > > > but applicable to all gc modes. Also mark
> > > > gc_urgent_high_remaining as deprecated, so that the node
> > > > can be removed in the future.
> > > > 
> > > > Signed-off-by: Yangtao Li <frank.li@vivo.com>
> > > > ---
> > > >    Documentation/ABI/testing/sysfs-fs-f2fs |  8 ++++++++
> > > >    fs/f2fs/f2fs.h                          |  6 ++++--
> > > >    fs/f2fs/gc.c                            | 12 ++++++------
> > > >    fs/f2fs/super.c                         |  2 +-
> > > >    fs/f2fs/sysfs.c                         | 14 ++++++++++----
> > > >    5 files changed, 29 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > index 483639fb727b..859c4e53a846 100644
> > > > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > > @@ -598,6 +598,14 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
> > > >    Description:	You can set the trial count limit for GC urgent high mode with this value.
> > > >    		If GC thread gets to the limit, the mode will turn back to GC normal mode.
> > > >    		By default, the value is zero, which means there is no limit like before.
> > > > +		<deprecated>
> > > > +
> > > > +What:		/sys/fs/f2fs/<disk>/gc_urgent_idle_remaining
> > > > +Date:		October 2022
> > > > +Contact:	"Yangtao Li" <frank.li@vivo.com>
> > > > +Description:	You can set the trial count limit for GC urgent and idle mode with this value.
> > > > +		If GC thread gets to the limit, the mode will turn back to GC normal mode.
> > > > +		By default, the value is zero, which means there is no limit like before.
> > > >    What:		/sys/fs/f2fs/<disk>/max_roll_forward_node_blocks
> > > >    Date:		January 2022
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > index e6355a5683b7..2bad69cf9fd9 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -1734,8 +1734,10 @@ struct f2fs_sb_info {
> > > >    	unsigned int cur_victim_sec;		/* current victim section num */
> > > >    	unsigned int gc_mode;			/* current GC state */
> > > >    	unsigned int next_victim_seg[2];	/* next segment in victim section */
> > > > -	spinlock_t gc_urgent_high_lock;
> > > > -	unsigned int gc_urgent_high_remaining;	/* remaining trial count for GC_URGENT_HIGH */
> > > > +	spinlock_t gc_urgent_idle_lock;
> > > > +	/* remaining trial count for GC_URGENT_* and GC_IDLE_* */
> > > > +	unsigned int gc_urgent_idle_remaining;
> > > > +	unsigned int gc_urgent_high_remaining;	/* deprecated */
> > > >    	/* for skip statistic */
> > > >    	unsigned long long skipped_gc_rwsem;		/* FG_GC only */
> > > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > > index e0ff99c7e3f2..0ed5b3c5922c 100644
> > > > --- a/fs/f2fs/gc.c
> > > > +++ b/fs/f2fs/gc.c
> > > > @@ -152,14 +152,14 @@ static int gc_thread_func(void *data)
> > > >    		/* balancing f2fs's metadata periodically */
> > > >    		f2fs_balance_fs_bg(sbi, true);
> > > >    next:
> > > > -		if (sbi->gc_mode == GC_URGENT_HIGH) {
> > > > -			spin_lock(&sbi->gc_urgent_high_lock);
> > > > -			if (sbi->gc_urgent_high_remaining) {
> > > > -				sbi->gc_urgent_high_remaining--;
> > > > -				if (!sbi->gc_urgent_high_remaining)
> > > > +		if (sbi->gc_mode != GC_NORMAL) {
> > > > +			spin_lock(&sbi->gc_urgent_idle_lock);
> > > > +			if (sbi->gc_urgent_idle_remaining) {
> > > > +				sbi->gc_urgent_idle_remaining--;
> > > > +				if (!sbi->gc_urgent_idle_remaining)
> > > >    					sbi->gc_mode = GC_NORMAL;
> > > >    			}
> > > > -			spin_unlock(&sbi->gc_urgent_high_lock);
> > > > +			spin_unlock(&sbi->gc_urgent_idle_lock);
> > > >    		}
> > > >    		sb_end_write(sbi->sb);
> > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > index 3834ead04620..f90a8c0a53ec 100644
> > > > --- a/fs/f2fs/super.c
> > > > +++ b/fs/f2fs/super.c
> > > > @@ -3616,7 +3616,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
> > > >    	sbi->seq_file_ra_mul = MIN_RA_MUL;
> > > >    	sbi->max_fragment_chunk = DEF_FRAGMENT_SIZE;
> > > >    	sbi->max_fragment_hole = DEF_FRAGMENT_SIZE;
> > > > -	spin_lock_init(&sbi->gc_urgent_high_lock);
> > > > +	spin_lock_init(&sbi->gc_urgent_idle_lock);
> > > >    	atomic64_set(&sbi->current_atomic_write, 0);
> > > >    	sbi->dir_level = DEF_DIR_LEVEL;
> > > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > > index df27afd71ef4..2b1c653b37cf 100644
> > > > --- a/fs/f2fs/sysfs.c
> > > > +++ b/fs/f2fs/sysfs.c
> > > > @@ -531,10 +531,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> > > >    		return count;
> > > >    	}
> > > > -	if (!strcmp(a->attr.name, "gc_urgent_high_remaining")) {
> > > > -		spin_lock(&sbi->gc_urgent_high_lock);
> > > > -		sbi->gc_urgent_high_remaining = t;
> > > > -		spin_unlock(&sbi->gc_urgent_high_lock);
> > > > +	/* deprecated */
> > > > +	if (!strcmp(a->attr.name, "gc_urgent_high_remaining"))
> > > > +		return -EINVAL;
> > > 
> > > How about those users who has already used these interface... it breaks
> > > the usage.
> > > 
> > > It needs to keep old interface and tag as deprecated, and recommend user
> > > to use new interface you introduced.
> > 
> > I feel that this is not a super critical node, so how about just removing it?
> 
> Only Android is using this inferface, right?
> 
> Any plan to adjust related code from Android side?

There's no place to use this yet, but just need to modify internal tests.

> 
> Thanks,
> 
> > 
> > > 
> > > e.g.:
> > > 
> > > What:           /sys/fs/f2fs/<disk>/features
> > > Date:           July 2017
> > > Contact:        "Jaegeuk Kim" <jaegeuk@kernel.org>
> > > Description:    <deprecated: should use /sys/fs/f2fs/<disk>/feature_list/
> > >                  Shows all enabled features in current device.
> > >                  Supported features:
> > >                  encryption, blkzoned, extra_attr, projquota, inode_checksum,
> > >                  flexible_inline_xattr, quota_ino, inode_crtime, lost_found,
> > >                  verity, sb_checksum, casefold, readonly, compression, pin_file.
> > > 
> > > Thanks,
> > > 
> > > > +
> > > > +	if (!strcmp(a->attr.name, "gc_urgent_idle_remaining")) {
> > > > +		spin_lock(&sbi->gc_urgent_idle_lock);
> > > > +		sbi->gc_urgent_idle_remaining = t;
> > > > +		spin_unlock(&sbi->gc_urgent_idle_lock);
> > > >    		return count;
> > > >    	}
> > > > @@ -826,6 +830,7 @@ F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
> > > >    F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, data_io_flag, data_io_flag);
> > > >    F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, node_io_flag, node_io_flag);
> > > >    F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_high_remaining, gc_urgent_high_remaining);
> > > > +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_urgent_idle_remaining, gc_urgent_idle_remaining);
> > > >    F2FS_RW_ATTR(CPRC_INFO, ckpt_req_control, ckpt_thread_ioprio, ckpt_thread_ioprio);
> > > >    F2FS_GENERAL_RO_ATTR(dirty_segments);
> > > >    F2FS_GENERAL_RO_ATTR(free_segments);
> > > > @@ -953,6 +958,7 @@ static struct attribute *f2fs_attrs[] = {
> > > >    	ATTR_LIST(data_io_flag),
> > > >    	ATTR_LIST(node_io_flag),
> > > >    	ATTR_LIST(gc_urgent_high_remaining),
> > > > +	ATTR_LIST(gc_urgent_idle_remaining),
> > > >    	ATTR_LIST(ckpt_thread_ioprio),
> > > >    	ATTR_LIST(dirty_segments),
> > > >    	ATTR_LIST(free_segments),
