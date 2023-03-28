Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CED16CB349
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 03:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjC1Bnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 21:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjC1Bnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 21:43:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09C92100;
        Mon, 27 Mar 2023 18:43:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FE6CB80DB2;
        Tue, 28 Mar 2023 01:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0562BC433EF;
        Tue, 28 Mar 2023 01:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679967809;
        bh=WJQVDtVRtClI1EOWzffUHCX7Dj+qAn+CBW+YgstA7z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g4PviIVvWQq9OkjQeUhlFOmCvwZV06TsFhecByaE1hd6nY3D3F8MLtDVokDVxEs2R
         Ziu97OTkeTNqTBISjf8PRXlCfXYhGjCcMbVoX9/LjrBAWNJl7VrCZocq/kUZcNgKuQ
         avuVy+Yi6FBqrQzxhA2c6Crr83n2FSnyTMEWlbS3hnmn/9ifX/AxSuVlMSDc18md33
         zEqVhFF1jYM6FJFqsrIK22vPJv7KzyJ0DVVMNO5W2yXdlu5UmQ2D/hf82vofTprJ6h
         28z0EpPfusljFaDuMvQtcNDUchnQwnbCHkhQeTJ/emWF6KTSD5NzSKvC1P8feoRH+N
         XCuyEpxow0Wag==
Date:   Mon, 27 Mar 2023 18:43:28 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] xfs: fix BUG_ON in xfs_getbmap()
Message-ID: <20230328014328.GG16180@frogsfrogsfrogs>
References: <20230327140218.4154709-1-yebin@huaweicloud.com>
 <20230327151524.GC16180@frogsfrogsfrogs>
 <64224406.5090106@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64224406.5090106@huawei.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:33:58AM +0800, yebin (H) wrote:
> 
> 
> On 2023/3/27 23:15, Darrick J. Wong wrote:
> > [add Christoph to cc since he added/last touched this assert, I think]
> > 
> > On Mon, Mar 27, 2023 at 10:02:18PM +0800, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > There's issue as follows:
> > > XFS: Assertion failed: (bmv->bmv_iflags & BMV_IF_DELALLOC) != 0, file: fs/xfs/xfs_bmap_util.c, line: 329
> > Why not get rid of the assertion?  It's not like it changes the course
> > of the code flow -- userspace still gets told there's a delalloc extent.
> Thank you for your reply.
> I think it's incorrect to return the delalloc extent to the user in this
> case. Because
> users expect to obtain none delalloc  extent information. If there is a
> delalloc  extent
> found at this time, there is a problem with the functionality. I even think
> that here
> we should return an error to the userspace instead of return an incorrect
> result to
> the userspace .

<shrug> Seeing as the data fork mappings can change the instant the
ILOCK drops, I'm not /that/ worried about users seeing a delalloc
mapping even if the user requested a flush.  The results are already
obsolete when they get to userspace, unless the application software has
found another means to lock out access to the file.

And even then, BMAP doesn't consult the page cache, so it still doesn't
provide a full picture of where all the nonzero data can be found.

--D

> > Or, if the assert does serve some purpose, then do we need to take
> > the mmaplock for cow fork reporting too?
> Let me analyze whether it is necessary to take the mmaplock for cow fork
> reporting.
> > --D
> > 
> > > ------------[ cut here ]------------
> > > kernel BUG at fs/xfs/xfs_message.c:102!
> > > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > CPU: 1 PID: 14612 Comm: xfs_io Not tainted 6.3.0-rc2-next-20230315-00006-g2729d23ddb3b-dirty #422
> > > RIP: 0010:assfail+0x96/0xa0
> > > RSP: 0018:ffffc9000fa178c0 EFLAGS: 00010246
> > > RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff888179a18000
> > > RDX: 0000000000000000 RSI: ffff888179a18000 RDI: 0000000000000002
> > > RBP: 0000000000000000 R08: ffffffff8321aab6 R09: 0000000000000000
> > > R10: 0000000000000001 R11: ffffed1105f85139 R12: ffffffff8aacc4c0
> > > R13: 0000000000000149 R14: ffff888269f58000 R15: 000000000000000c
> > > FS:  00007f42f27a4740(0000) GS:ffff88882fc00000(0000) knlGS:0000000000000000
> > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > CR2: 0000000000b92388 CR3: 000000024f006000 CR4: 00000000000006e0
> > > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > Call Trace:
> > >   <TASK>
> > >   xfs_getbmap+0x1a5b/0x1e40
> > >   xfs_ioc_getbmap+0x1fd/0x5b0
> > >   xfs_file_ioctl+0x2cb/0x1d50
> > >   __x64_sys_ioctl+0x197/0x210
> > >   do_syscall_64+0x39/0xb0
> > >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > 
> > > Above issue may happen as follows:
> > >           ThreadA                       ThreadB
> > > do_shared_fault
> > >   __do_fault
> > >    xfs_filemap_fault
> > >     __xfs_filemap_fault
> > >      filemap_fault
> > >                               xfs_ioc_getbmap -> Without BMV_IF_DELALLOC flag
> > > 			      xfs_getbmap
> > > 			       xfs_ilock(ip, XFS_IOLOCK_SHARED);
> > > 			       filemap_write_and_wait
> > >   do_page_mkwrite
> > >    xfs_filemap_page_mkwrite
> > >     __xfs_filemap_fault
> > >      xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> > >      iomap_page_mkwrite
> > >       ...
> > >       xfs_buffered_write_iomap_begin
> > >        xfs_bmapi_reserve_delalloc -> Allocate delay extent
> > >                                xfs_ilock_data_map_shared(ip)
> > > 	                      xfs_getbmap_report_one
> > > 			       ASSERT((bmv->bmv_iflags & BMV_IF_DELALLOC) != 0)
> > > 	                        -> trigger BUG_ON
> > > 
> > > As xfs_filemap_page_mkwrite() only hold XFS_MMAPLOCK_SHARED lock, there's
> > > small window mkwrite can produce delay extent after file write in xfs_getbmap().
> > > To solve above issue, hold XFS_MMAPLOCK_EXCL lock when do xfs_getbmap(),
> > > to prevent write operations by do_page_mkwrite().
> > > During doing __xfs_filemap_fault() we can't hold IOLOCK lock, as it's may lead
> > > to ABBA dealock with xfs_file_write_iter().It's very easy to reproduce when
> > > do fsstress, lockdep will detect deadlock.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >   fs/xfs/xfs_bmap_util.c | 6 ++++--
> > >   1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > > index a09dd2606479..f23771a0cc8d 100644
> > > --- a/fs/xfs/xfs_bmap_util.c
> > > +++ b/fs/xfs/xfs_bmap_util.c
> > > @@ -463,11 +463,13 @@ xfs_getbmap(
> > >   			max_len = XFS_ISIZE(ip);
> > >   		break;
> > >   	case XFS_DATA_FORK:
> > > +		lock = XFS_MMAPLOCK_EXCL;
> > > +		xfs_ilock(ip, lock);
> > >   		if (!(iflags & BMV_IF_DELALLOC) &&
> > >   		    (ip->i_delayed_blks || XFS_ISIZE(ip) > ip->i_disk_size)) {
> > >   			error = filemap_write_and_wait(VFS_I(ip)->i_mapping);
> > >   			if (error)
> > > -				goto out_unlock_iolock;
> > > +				goto out_unlock_ilock;
> > >   			/*
> > >   			 * Even after flushing the inode, there can still be
> > > @@ -486,7 +488,7 @@ xfs_getbmap(
> > >   		else
> > >   			max_len = XFS_ISIZE(ip);
> > > -		lock = xfs_ilock_data_map_shared(ip);
> > > +		lock |= xfs_ilock_data_map_shared(ip);
> > >   		break;
> > >   	}
> > > -- 
> > > 2.31.1
> > > 
> > .
> > 
> 
