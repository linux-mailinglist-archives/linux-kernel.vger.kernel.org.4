Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BEE6BA57D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjCODGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCODGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830205D46E;
        Tue, 14 Mar 2023 20:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B3C76198E;
        Wed, 15 Mar 2023 03:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62786C433EF;
        Wed, 15 Mar 2023 03:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678849601;
        bh=HJEvpw/ETUl/MIv+XGdx2eTFUfpYueNHiCDUAT1UDBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdtf2Ux0Q3joM/oeXLqBnAJR7b5RJZxL8VxRoiFaD8qgikpZ26Q1TGICIUX4+c2o8
         I5KbhdIxJ2PGiaHzTaaFdBAO7Us8Mww5AN2qN6qkRCOTA2iS8YUbML7iJDLwq481mx
         VsKp69z6tQuHzI1LsLQRwTNrRNq4QikAcOufuW9DiiH8EYwlHdf5C4pG+dSQl55grt
         Qao96PVYxUHxWGdIeVX8v3qy+7yaxQ54NG9jQ+DvrB/dq2udFjwl3LlMzWkyETmPxm
         XBwvA45Z1PFmpsVdBZRUjEdUZPZVEUEzi6SjEJe6so/iYQNPMVufKTG/Ze9UTKy5VP
         IaVWyefWiWIVA==
Date:   Tue, 14 Mar 2023 20:06:40 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH] xfs: fix possible assert failed in xfs_fs_put_super()
 when do cpu offline
Message-ID: <20230315030640.GF11376@frogsfrogsfrogs>
References: <20230314090649.326642-1-yebin@huaweicloud.com>
 <20230314163100.GC11376@frogsfrogsfrogs>
 <20230314221305.GR360264@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314221305.GR360264@dread.disaster.area>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[add lfsdevel to cc to spread the, um, love]

TLDR: percpu_counter_sum doesn't add in the values from CPUs in the
dying mask.  As a result, the summation can race with cpu hotunplug
and return the wrong values.

On Wed, Mar 15, 2023 at 09:13:05AM +1100, Dave Chinner wrote:
> On Tue, Mar 14, 2023 at 09:31:00AM -0700, Darrick J. Wong wrote:
> > On Tue, Mar 14, 2023 at 05:06:49PM +0800, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > There's a issue when do cpu offline test:
> > > CPU: 48 PID: 1168152 Comm: umount Kdump: loaded Tainted: G L
> > > pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
> > > pc : assfail+0x8c/0xb4
> > > lr : assfail+0x38/0xb4
> > > sp : ffffa00033ce7c40
> > > x29: ffffa00033ce7c40 x28: ffffa00014794f30
> > > x27: ffffa00014f6ca20 x26: 1fffe0120b2e2030
> > > x25: ffff009059710188 x24: ffff00886c0a4650
> > > x23: 1fffe0110d8148ca x22: ffff009059710180
> > > x21: ffffa00015155680 x20: ffff00886c0a4000
> > > x19: 0000000000000001 x18: 0000000000000000
> > > x17: 0000000000000000 x16: 0000000000000000
> > > x15: 0000000000000007 x14: 1fffe00304cef265
> > > x13: ffff00182642b200 x12: ffff8012d37757bf
> > > x11: 1fffe012d37757be x10: ffff8012d37757be
> > > x9 : ffffa00010603a0c x8 : 0000000041b58ab3
> > > x7 : ffff94000679cf44 x6 : 00000000ffffffc0
> > > x5 : 0000000000000021 x4 : 00000000ffffffca
> > > x3 : 1ffff40002a27ee1 x2 : 0000000000000004
> > > x1 : 0000000000000000 x0 : ffffa0001513f000
> > > Call trace:
> > >  assfail+0x8c/0xb4
> > >  xfs_destroy_percpu_counters+0x98/0xa4
> > >  xfs_fs_put_super+0x1a0/0x2a4
> > >  generic_shutdown_super+0x104/0x2c0
> > >  kill_block_super+0x8c/0xf4
> > >  deactivate_locked_super+0xa4/0x164
> > >  deactivate_super+0xb0/0xdc
> > >  cleanup_mnt+0x29c/0x3ec
> > >  __cleanup_mnt+0x1c/0x30
> > >  task_work_run+0xe0/0x200
> > >  do_notify_resume+0x244/0x320
> > >  work_pending+0xc/0xa0
> > > 
> > > We analyzed the data in vmcore is correct. But triggered above issue.
> > > As f689054aace2 ("percpu_counter: add percpu_counter_sum_all interface")
> > > commit describes there is a small race window between the online CPUs traversal
> > > of percpu_counter_sum and the CPU offline callback. This means percpu_counter_sum()
> > > may return incorrect result during cpu offline.
> > > To solve above issue use percpu_counter_sum_all() interface to make sure
> > > result is correct to prevent false triggering of assertions.
> > 
> > How about the other percpu_counter_sum callsites inside XFS?  Some of
> > them are involved in writing ondisk metadata (xfs_log_sb) or doing
> > correctness checks (fs/xfs/scrub/*); shouldn't those also be using the
> > _all variant?
> 
> Ugh. I kinda wish that the percpu_counter_sum_all() patch had been
> cc'd to lists for subsystems that use percpu_counter_sum()
> extensively, or just to people who have modified that code in the
> past.
> 
> The problem is that it uses cpu_possible_mask, which means it
> walks all possible CPUs that can be added to the system even if the
> CPUs aren't physically present. That can be a lot in the case of
> systems that can have cpu-capable nodes hotplugged into them, and
> that makes percpu_counter_sum_all() excitingly expensive for no good
> reason.
> 
> AFAICT, if we are trying to close a race condition between iterating
> online CPUs not summing dying CPUs and the cpu dead notification
> updating the sum, then shouldn't we be using
> cpu_mask_or(cpu_online_mask, cpu_dying_mask) for summing iteration
> rather than just cpu_online_mask?
> 
> i.e. when a CPU is being taken down, it gets added to the
> cpu_dying_mask, then removed from the cpu_online_mask, then the
> offline notifications are run (i.e. the percpu counter dead
> callback), and when the CPU reaches the CPUHP_TEARDOWN_CPU state,
> it is removed from the cpu_dying_mask because it is now dead and all
> the "cpu dying" callbacks have been run.
> 
> Except when a hotplug event is being processed, cpu_dying_mask will
> be empty, hence there is little change in summing overhead. But it
> will close the summing race condition when a CPU is being
> offlined...
> 
> That, I think, is the solution we want for XFS. Having the percpu
> counters just do the right thing is far better than always having to
> wonder if summation interface we are using is correct in the face of
> CPU hotplug. I'll put a patchset together to do:
> 
> 1. fix percpu_counter_sum() to include the dying mask in it's
> iteration. This should fix the XFS issue.

I took a quick look at ext4 and btrfs usage of percpu_counter_sum.  I
/think/ they're less impacted because most of the usage seems to be for
things like statfs which are inherently racy.  That said, mixing in the
dying mask sounds like a cheap fix.

> 2. change the only user of percpu_counter_sum_all() to only use
> percpu_counter_sum() because percpu_counter_sum_all() is now
> redundant.
> 3. remove percpu_counter_sum_all() because it is unused.

Sounds reasonable to /me. :)

--D

> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
