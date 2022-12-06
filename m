Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE64644A96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLFRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLFRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:47:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D01536C7B;
        Tue,  6 Dec 2022 09:47:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5970B81AF7;
        Tue,  6 Dec 2022 17:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F988C433C1;
        Tue,  6 Dec 2022 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670348849;
        bh=kpThiEp3UAhW6pzLUVd7+M75zxZbydrFxRCxs6or0pE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dLGwzyu6XmzXG/L7DgvYNGWvQ9CokgYuQ3e5dBAMRWxe613GDVfj+rDE5SGfYm1R/
         nKrJvuleNLFbCmMF++/f7pPQ+pxAZJxxC/4xK4fWmxN0PAj6GMwxWUtbso3V0Rj04i
         AJ7pU9+Gdq8Bvsn4G2ftpVQZs9PoSoDXW5gKdVKpVHNfkY4vratV2NcktXcmn3zl6N
         I0KzBVamo3uo0TxBnJ30iJea5++v8gNwkTIyZDKVQJUa6WnF81ykjlGxHimNvc0QoU
         AA6CpGPHcDrDiod2YFpGRvS6WAWgUuV5RCJHem3z5PSFLn0+aAIzUznBSZ+KFNRPiM
         Zxv/88KAO8S8A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2D3EA5C0952; Tue,  6 Dec 2022 09:47:29 -0800 (PST)
Date:   Tue, 6 Dec 2022 09:47:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Dave Chinner <david@fromorbit.com>, frederic@kernel.org,
        quic_neeraju@quicinc.com, Josh Triplett <josh@joshtriplett.org>,
        RCU <rcu@vger.kernel.org>,
        syzbot <syzbot+912776840162c13db1a3@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in xfs_qm_dqfree_one
Message-ID: <20221206174729.GQ4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <000000000000bd587705ef202b08@google.com>
 <20221206033450.GS3600936@dread.disaster.area>
 <CACT4Y+b-DCu=3LT+OMHuy4R1Fkgg_cBBtVT=jGtcyiBn4UcbRA@mail.gmail.com>
 <20221206153211.GN4001@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+ZbmxyKJXM2zrJR6gNGSUS8j2_-Nu2dpC6gBEjcE3ercw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZbmxyKJXM2zrJR6gNGSUS8j2_-Nu2dpC6gBEjcE3ercw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 05:19:10PM +0100, Dmitry Vyukov wrote:
> On Tue, 6 Dec 2022 at 16:32, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Dec 06, 2022 at 12:06:10PM +0100, Dmitry Vyukov wrote:
> > > On Tue, 6 Dec 2022 at 04:34, Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Mon, Dec 05, 2022 at 07:12:15PM -0800, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > > > INFO: rcu detected stall in corrupted
> > > > >
> > > > > rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4122 } 2641 jiffies s: 2877 root: 0x0/T
> > > > > rcu: blocking rcu_node structures (internal RCU debug):
> > > >
> > > > I'm pretty sure this has nothing to do with the reproducer - the
> > > > console log here:
> > > >
> > > > > Tested on:
> > > > >
> > > > > commit:         bce93322 proc: proc_skip_spaces() shouldn't think it i..
> > > > > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1566216b880000
> > > >
> > > > indicates that syzbot is screwing around with bluetooth, HCI,
> > > > netdevsim, bridging, bonding, etc.
> > > >
> > > > There's no evidence that it actually ran the reproducer for the bug
> > > > reported in this thread - there's no record of a single XFS
> > > > filesystem being mounted in the log....
> > > >
> > > > It look slike someone else also tried a private patch to fix this
> > > > problem (which was obviously broken) and it failed with exactly the
> > > > same RCU warnings. That was run from the same commit id as the
> > > > original reproducer, so this looks like either syzbot is broken or
> > > > there's some other completely unrelated problem that syzbot is
> > > > tripping over here.
> > > >
> > > > Over to the syzbot people to debug the syzbot failure....
> > >
> > > Hi Dave,
> > >
> > > It's not uncommon for a single program to trigger multiple bugs.
> > > That's what happens here. The rcu stall issue is reproducible with
> > > this test program.
> > > In such cases you can either submit more test requests, or test manually.
> > >
> > > I think there is an RCU expedited stall detection.
> > > For some reason CONFIG_RCU_EXP_CPU_STALL_TIMEOUT is limited to 21
> > > seconds, and that's not enough for reliable flake-free stress testing.
> > > We bump other timeouts to 100+ seconds.
> > > +RCU maintainers, do you mind removing the overly restrictive limit on
> > > CONFIG_RCU_EXP_CPU_STALL_TIMEOUT?
> > > Or you think there is something to fix in the kernel to not stall? I
> > > see the test writes to
> > > /proc/sys/vm/drop_caches, maybe there is some issue in that code.
> >
> > Like this?
> >
> > If so, I don't see why not.  And in that case, may I please have
> > your Tested-by or similar?
> 
> I've tried with this patch and RCU_EXP_CPU_STALL_TIMEOUT=80000.
> Running the test program I got some kernel BUG in XFS and no RCU
> errors/warnings.
> 
> Tested-by: Dmitry Vyukov <dvyukov@google.com>

Applied, thank you both!

I expect to push this into the v6.3 merge window, that is, not the
one coming up real soon now, but the one after that.

							Thanx, Paul

> Thanks
> 
> > At the same time, I am sure that there are things in the kernel that
> > should be adjusted to avoid stalls, but I recognize that different
> > developers in different situations will have different issues that they
> > choose to focus on.  ;-)
> >
> >                                                         Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index 49da904df6aa6..2984de629f749 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -82,7 +82,7 @@ config RCU_CPU_STALL_TIMEOUT
> >  config RCU_EXP_CPU_STALL_TIMEOUT
> >         int "Expedited RCU CPU stall timeout in milliseconds"
> >         depends on RCU_STALL_COMMON
> > -       range 0 21000
> > +       range 0 300000
> >         default 0
> >         help
> >           If a given expedited RCU grace period extends more than the
