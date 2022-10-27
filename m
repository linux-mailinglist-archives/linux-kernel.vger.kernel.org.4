Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB460FCFB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiJ0QXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiJ0QWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:22:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E111A8505;
        Thu, 27 Oct 2022 09:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6167CB826FC;
        Thu, 27 Oct 2022 16:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5497C433D6;
        Thu, 27 Oct 2022 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666887647;
        bh=TOUqKmgEkAaTeK7T8K0JzVzaY6XgBGR/nI/YoSk8f8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JiCaQQHRv2vDjm0fmPDW615OPN0zDbLG7r5aetEdobj4aEP9ci8Bc0pvOREce2oSZ
         zZHWrVNgzAPTRP7c9z8GCOq+ZbSHQm7ecyoW52jJFWHm1UxZeDIAIxOHQGjf2euFZF
         aymc3x8q+qGFbOkfjKW+hf8SnOW7J8luy8UwvXUBBlC7LVJ9mvhwr9Xk9LeQe3VCed
         g/FgQuUZF02td0BPmGB1lv07foEGH4IeW4nb/C75aNFxnebrsn97fBZaFZ/58bAjsU
         7NVnXrWUH/lCsX3TACuWOo0Ags7/t7Jj0+Yuxkbx/iwBQIYAKt3kRRyDF8zjfkcTkL
         xEHxoIS/ipaWQ==
Date:   Thu, 27 Oct 2022 09:20:46 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yujie Liu <yujie.liu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        fengwei.yin@intel.com, ying.huang@intel.com,
        fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [tip:x86/core] [kallsyms] f138918162:
 WARNING:CPU:#PID:#at_fs/xfs/xfs_message.c:#xfs_buf_alert_ratelimited.cold-#[xfs]
Message-ID: <Y1qv3ku6ULHy8hOF@magnolia>
References: <202210241614.2ae4c1f5-yujie.liu@intel.com>
 <Y1kDEmLeRA2UGeF8@hirez.programming.kicks-ass.net>
 <Y1kiuTIYobR4nexS@hirez.programming.kicks-ass.net>
 <Y1nobODPLUjcteJ0@yujie-X299>
 <2543dfb1-d9dc-0888-dbea-e420a19d732c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2543dfb1-d9dc-0888-dbea-e420a19d732c@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 10:24:51AM +0800, Yujie Liu wrote:
> On 10/27/2022 10:09, Yujie Liu wrote:
> > On Wed, Oct 26, 2022 at 02:06:17PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 26, 2022 at 11:51:14AM +0200, Peter Zijlstra wrote:
> > > > On Wed, Oct 26, 2022 at 05:10:28PM +0800, kernel test robot wrote:
> > > > > Hi Peter,
> > > > > 
> > > > > For below patch, we couldn't find any connection between the code
> > > > > change of kallsyms and xfstests testcase, but we got very stable test
> > > > > results. We tested commit f1389181622a and its parent commit
> > > > > 7825451fa4dc for 12 runs each, parent was 100% good while this commit
> > > > > was 100% bad, so we still send out this report FYI though we don't have
> > > > > clear clue of the root cause. Please check the details below if
> > > > > interested in further investigation. Thanks.
> > > > 
> > > > *groan* I'll go have a poke.
> > > > 
> > > > Also; I've had these patches in my queue.git for over a month now and
> > > > this is the first report, how comes?
> > 
> > Hi Peter,
> > 
> > Sorry about late report. We did catch this problem on
> > call-depth-tracking branch of queue.git in Semtember, but we used to
> > think it may be a false alarm since we cannot connect the code change
> > with xfstests, so didn't report at that time. After merged to x86 tip,
> > we did more tests and reviewed this problem with more developers, and
> > sent out the report finally.
> > 
> > > dmesg starts at 42 seconds, you don't happen to have a complete one?
> > 
> > Sorry for the incomplete dmesg. Please check if attached kmsg.xz helps?
> > The time may vary a little since it is captured from another run.
> > Thanks.
> > 
> > Not sure if this has anything to do with xfs or testcases, so add
> > xfs folks to consult.
> > 
> > Hi xfs folks,
> > 
> > Could you please help check the original report at
> > https://lore.kernel.org/r/202210241508.2e203c3d-yujie.liu@intel.com
> > to see if can find any clue for the problem? Thanks.
> 
> Sorry, wrong link. Should be:
> 
> https://lore.kernel.org/all/202210241614.2ae4c1f5-yujie.liu@intel.com/

xfs/439 corrupts the log and checks that log recovery will notice the
corruption and abort the mount.

Excerpted dmesg from the link above:

[   75.708690][ T3668] ------------[ cut here ]------------
[   75.714041][ T3668] WARNING: CPU: 1 PID: 3668 at fs/xfs/xfs_message.c:104 xfs_buf_alert_ratelimited.cold-0x7/0x45 [xfs]
[   75.779828][ T3668] CPU: 1 PID: 3668 Comm: mount Not tainted 6.1.0-rc1-00053-gf1389181622a #1
[   75.788389][ T3668] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
[   75.796864][ T3668] RIP: 0010:xfs_buf_alert_ratelimited.cold-0x7/0x45 [xfs]
[ 75.898077][ T3668] xlog_find_verify_log_record (fs/xfs/xfs_log_recover.c:431) xfs
[ 75.910856][ T3668] xlog_find_head (fs/xfs/xfs_log_recover.c:705) xfs
[ 75.925847][ T3668] xlog_find_tail (fs/xfs/xfs_log_recover.c:1256) xfs
[ 75.951249][ T3668] xlog_recover (fs/xfs/xfs_log_recover.c:3355) xfs
[ 75.961324][ T3668] xfs_log_mount (fs/xfs/xfs_log.c:739) xfs
[ 75.966486][ T3668] xfs_mountfs (fs/xfs/xfs_mount.c:805 (discriminator 4)) xfs
[ 75.998070][ T3668] xfs_fs_fill_super (fs/xfs/xfs_super.c:1666) xfs

So yes, this is xlog_find_verify_log_record behaving as intended:

		if (i < start_blk) {
			/* valid log record not found */
			xfs_warn(log->l_mp,
		"Log inconsistent (didn't find previous header)");
			ASSERT(0);  <------------------ here
			error = -EFSCORRUPTED;
			goto out;
		}

However, I noticed that the callsite in the WARNING: message has changed
from the usual 'asswarn' (which is the caller of WARN_ON) to
'xfs_buf_alert_ratelimited', which seems totally wrong since XFS log
recovery doesn't touch xfs_buf objects at all.

The reason this turned into a fstests regression is that xfs/439 uses
_filter_assert_dmesg to check for warnings in dmesg that are not the
result of an ASSERT failing (common/rc in fstests):

	# We generate assert related WARNINGs on purpose and make sure
	# test doesn't fail because of these warnings. This is a helper
	# for _check_dmesg() to filter out them.
	_filter_assert_dmesg()
	{
		local warn1="WARNING:.*fs/xfs/xfs_message\.c:.*asswarn.*"
		local warn2="WARNING:.*fs/xfs/xfs_message\.c:.*assfail.*"
		sed -e "s#$warn1#Intentional warnings in asswarn#" \
		    -e "s#$warn2#Intentional warnings in assfail#"
	}

As for why that commit reports the wrong caller ... I don't know.  The
function name and line number are correct.

--D

> 
> --
> Best Regards,
> Yujie
