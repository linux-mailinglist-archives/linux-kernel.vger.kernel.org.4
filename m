Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265BB6DE99F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 04:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDLCtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 22:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLCtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 22:49:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C644B9;
        Tue, 11 Apr 2023 19:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E669B60F09;
        Wed, 12 Apr 2023 02:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB1CC433D2;
        Wed, 12 Apr 2023 02:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681267748;
        bh=6l6tJnxICA2ULe0XUVOrqNYppyqjamZONneAk26XYdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAfru8hHTUV2Ervx+gdTXaaK+iMaAHmnfaWx9ZoI9cG6dwvsPMSVbdWL3sU7/w8Hi
         Ckfk+/HIAlWQhEeUrjWcgnux1uGgnSKFx33Kb40Ebg1O42e0HPaNxixGWpD8Qnbain
         0nt4UXLwa9LGe33mWx3Sf2wBWpaIgK6F1ZqzigXM3LPSvW+kQVVhjXHBGw/irgm+CA
         Hjg+KnRGDL9Yb5QgONaqFBkReXcaKB6HeHHBcp9VWcWxiRf77r5S1CPbRJN6ayOQUh
         U2KhaQqxpJ2DfhtwUk8TKzIn2J0qKZ1eryk+2Ry0bIlA4+ImpbDBlhrEm4yBvIffXw
         6mSVTUr0v31ZA==
Date:   Tue, 11 Apr 2023 19:49:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        yebin10@huawei.com
Subject: Re: [PATCH v3] xfs: fix BUG_ON in xfs_getbmap()
Message-ID: <20230412024907.GP360889@frogsfrogsfrogs>
References: <20230329025258.1074860-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329025258.1074860-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:52:58AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> XFS: Assertion failed: (bmv->bmv_iflags & BMV_IF_DELALLOC) != 0, file: fs/xfs/xfs_bmap_util.c, line: 329
> ------------[ cut here ]------------
> kernel BUG at fs/xfs/xfs_message.c:102!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 14612 Comm: xfs_io Not tainted 6.3.0-rc2-next-20230315-00006-g2729d23ddb3b-dirty #422
> RIP: 0010:assfail+0x96/0xa0
> RSP: 0018:ffffc9000fa178c0 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff888179a18000
> RDX: 0000000000000000 RSI: ffff888179a18000 RDI: 0000000000000002
> RBP: 0000000000000000 R08: ffffffff8321aab6 R09: 0000000000000000
> R10: 0000000000000001 R11: ffffed1105f85139 R12: ffffffff8aacc4c0
> R13: 0000000000000149 R14: ffff888269f58000 R15: 000000000000000c
> FS:  00007f42f27a4740(0000) GS:ffff88882fc00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000b92388 CR3: 000000024f006000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  xfs_getbmap+0x1a5b/0x1e40
>  xfs_ioc_getbmap+0x1fd/0x5b0
>  xfs_file_ioctl+0x2cb/0x1d50
>  __x64_sys_ioctl+0x197/0x210
>  do_syscall_64+0x39/0xb0
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Above issue may happen as follows:
>          ThreadA                       ThreadB
> do_shared_fault
>  __do_fault
>   xfs_filemap_fault
>    __xfs_filemap_fault
>     filemap_fault
>                              xfs_ioc_getbmap -> Without BMV_IF_DELALLOC flag
> 			      xfs_getbmap
> 			       xfs_ilock(ip, XFS_IOLOCK_SHARED);
> 			       filemap_write_and_wait
>  do_page_mkwrite
>   xfs_filemap_page_mkwrite
>    __xfs_filemap_fault
>     xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
>     iomap_page_mkwrite
>      ...
>      xfs_buffered_write_iomap_begin
>       xfs_bmapi_reserve_delalloc -> Allocate delay extent
>                               xfs_ilock_data_map_shared(ip)
> 	                      xfs_getbmap_report_one
> 			       ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0)
> 	                        -> trigger BUG_ON
> 
> As xfs_filemap_page_mkwrite() only hold XFS_MMAPLOCK_SHARED lock, there's
> small window mkwrite can produce delay extent after file write in xfs_getbmap().
> To solve above issue, just skip delalloc extents.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/xfs/xfs_bmap_util.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index a09dd2606479..f032d3a4b727 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -314,15 +314,13 @@ xfs_getbmap_report_one(
>  	if (isnullstartblock(got->br_startblock) ||
>  	    got->br_startblock == DELAYSTARTBLOCK) {
>  		/*
> -		 * Delalloc extents that start beyond EOF can occur due to
> -		 * speculative EOF allocation when the delalloc extent is larger
> -		 * than the largest freespace extent at conversion time.  These
> -		 * extents cannot be converted by data writeback, so can exist
> -		 * here even if we are not supposed to be finding delalloc
> -		 * extents.
> +		 * Take the flush completion as being a point-in-time snapshot
> +		 * where there are no delalloc extents, and if any new ones
> +		 * have been created racily, just skip them as being 'after'
> +		 * the flush and so don't get reported.
>  		 */
> -		if (got->br_startoff < XFS_B_TO_FSB(ip->i_mount, XFS_ISIZE(ip)))
> -			ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0);
> +		if (!(bmv->bmv_iflags & BMV_IF_DELALLOC))
> +			return 0;

I think I'm ok with this...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  		p->bmv_oflags |= BMV_OF_DELALLOC;
>  		p->bmv_block = -2;
> -- 
> 2.31.1
> 
