Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13CC645E89
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiLGQRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiLGQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:17:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC7F62EB0;
        Wed,  7 Dec 2022 08:17:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A97B0CE1AFE;
        Wed,  7 Dec 2022 16:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C569FC433C1;
        Wed,  7 Dec 2022 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670429843;
        bh=MvxnN6BYfRwcFGpZLKnETxCa2619sEnvs1dSo1RoeFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRMibxXYH8N/hivYh+EpOLDIMjG7QOqNUh7Kk72UspODOLVezObLy6b0mW5om2dw0
         +G7JGeWxgqW1OF7FcYxpYx1AXqTwpdQjRY1mNdkRQIYpj5QKQ7rGFSsEsS10hYaqyB
         LEboIrp+dNw754jzDaX2PGcjb8RfUkgge2dlw7ZBQFhuutPEo1xO3ThcRtWODVnHGn
         U79yv85OMgrPtPW6e7PLkSt7cQgxADg0+mG0F+fdvEGko6FA9or2v5WcpvvhEVUJuE
         IGg4exxY9wQ4nDNg+Y6zl+Vx62daDlzWZI3VIRY+EbcRq9q9jMar9klR3sgIDJDv7w
         SlAa9lYeY7ltg==
Date:   Wed, 7 Dec 2022 08:17:23 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
Message-ID: <Y5C8k3ef4LqU4v0x@magnolia>
References: <000000000000abbde005ef113644@google.com>
 <0000000000009a423705ef123f9a@google.com>
 <20221205225246.GP3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205225246.GP3600936@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:52:46AM +1100, Dave Chinner wrote:
> On Mon, Dec 05, 2022 at 02:35:39AM -0800, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    0ba09b173387 Revert "mm: align larger anonymous mappings o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15550c47880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=912776840162c13db1a3
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128c9e23880000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/9758ec2c06f4/disk-0ba09b17.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/06781dbfd581/vmlinux-0ba09b17.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/3d44a22d15fa/bzImage-0ba09b17.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/335889b2d730/mount_0.gz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+912776840162c13db1a3@syzkaller.appspotmail.com
> > 
> > XFS (loop1): Quotacheck: Done.
> > syz-executor.1 (4657): drop_caches: 2
> > ==================================================================
> > BUG: KASAN: use-after-free in xfs_dquot_type fs/xfs/xfs_dquot.h:136 [inline]
> > BUG: KASAN: use-after-free in xfs_qm_dqfree_one+0x12f/0x170 fs/xfs/xfs_qm.c:1604
> > Read of size 1 at addr ffff888079a6aa58 by task syz-executor.1/4657
> 
> Looks like we've missed a XFS_DQUOT_FREEING check in
> xfs_qm_shrink_scan(), and the dquot purge run by unmount has raced
> with the shrinker. Patch below should fix it.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 
> xfs: dquot shrinker doesn't check for XFS_DQFLAG_FREEING
> 
> From: Dave Chinner <dchinner@redhat.com>
> 
> Resulting in a UAF if the shrinker races with some other dquot
> freeing mechanism that sets XFS_DQFLAG_FREEING before the dquot is
> removed from the LRU. This can occur if a dquot purge races with
> drop_caches.
> 
> Reported-by: syzbot+912776840162c13db1a3@syzkaller.appspotmail.com
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Please repost this as a toplevel thread so it doesn't get lost in the
depths.  Anyway, this looks correct so:

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_qm.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 18bb4ec4d7c9..ff53d40a2dae 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -422,6 +422,14 @@ xfs_qm_dquot_isolate(
>  	if (!xfs_dqlock_nowait(dqp))
>  		goto out_miss_busy;
>  
> +	/*
> +	 * If something else is freeing this dquot and hasn't yet removed it
> +	 * from the LRU, leave it for the freeing task to complete the freeing
> +	 * process rather than risk it being free from under us here.
> +	 */
> +	if (dqp->q_flags & XFS_DQFLAG_FREEING)
> +		goto out_miss_unlock;
> +
>  	/*
>  	 * This dquot has acquired a reference in the meantime remove it from
>  	 * the freelist and try again.
> @@ -441,10 +449,8 @@ xfs_qm_dquot_isolate(
>  	 * skip it so there is time for the IO to complete before we try to
>  	 * reclaim it again on the next LRU pass.
>  	 */
> -	if (!xfs_dqflock_nowait(dqp)) {
> -		xfs_dqunlock(dqp);
> -		goto out_miss_busy;
> -	}
> +	if (!xfs_dqflock_nowait(dqp))
> +		goto out_miss_unlock;
>  
>  	if (XFS_DQ_IS_DIRTY(dqp)) {
>  		struct xfs_buf	*bp = NULL;
> @@ -478,6 +484,8 @@ xfs_qm_dquot_isolate(
>  	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaims);
>  	return LRU_REMOVED;
>  
> +out_miss_unlock:
> +	xfs_dqunlock(dqp);
>  out_miss_busy:
>  	trace_xfs_dqreclaim_busy(dqp);
>  	XFS_STATS_INC(dqp->q_mount, xs_qm_dqreclaim_misses);
