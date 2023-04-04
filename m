Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA996D64CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjDDOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjDDOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:09:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5551524E;
        Tue,  4 Apr 2023 07:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2874D6349F;
        Tue,  4 Apr 2023 14:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8332EC43442;
        Tue,  4 Apr 2023 14:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680617380;
        bh=2qmUVGBHpXV9MsvqvLE8IDaWzvHLiJOY3/mdy7bAYIM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JgHrkCGF0Qob5JaJOiXZfRV0N1N02iWzkW16jibmKdf7WVCaZr5BhRYkXdg/fyFTH
         upfFJyIEg27UgFQeBc8IXSz6O90wffLA0VJ/oJffhwmY+oNDmOwpE9bRVZd4ZmAIyY
         xnx/SxTQdKB12Xbp0rv1qRlrvMFUvEyX7eg+wdwvbsAsy6PRi/fBOmoH5yOReWpLUd
         uzH9cjihfiGO0HoeXbL7lWgP7CJRnac8xqsScRLcX8teVwOGmr9i/8rZTNchpwt9k+
         yfVovWj0GRYATuDS8/1vBigXkHyPxpf+lrb6sVMbOOVBdmx+2SDlekpZzO594s6MID
         wPL1/IDIKiACg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0E46815404B4; Tue,  4 Apr 2023 07:09:40 -0700 (PDT)
Date:   Tue, 4 Apr 2023 07:09:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, hch@lst.de
Subject: Re: [PATCH rcu 0/20] Further shrink srcu_struct to promote cache
 locality
Message-ID: <f2ae6531-1443-47e0-8897-0a47ca61ffec@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
 <20230404135741.GB471948@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404135741.GB471948@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 01:57:41PM +0000, Joel Fernandes wrote:
> On Thu, Mar 30, 2023 at 03:47:02PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This post-RFC series shrinks the srcu_struct structure to the bare minimum
> > required to support SRCU readers, relegating the remaining fields to a new
> > srcu_usage structure.  Statically allocated srcu_struct structures created
> > by DEFINE_SRCU() and DEFINE_STATIC_SRCU() have statically allocated
> > srcu_usage structures, but those required for dynamically allocated
> > srcu_struct structures that are initialized using init_srcu_struct()
> > are dynamically allocated.
> > 
> > The results is a reduction in the size of an srcu_struct structure from
> > a couple hundred bytes to just 24 bytes on x86_64 systems.  This can be
> > helpful when SRCU readers are used in a fastpath for which the srcu_struct
> > structure must be embedded in another structure, and especially where
> > that fastpath also needs to access fields both before and after the
> > srcu_struct structure.
> > 
> > This series takes baby steps, in part because breaking SRCU means that
> > you get absolutely no console output.  Yes, I did learn this the hard way.
> > Why do you ask?  ;-)
> > 
> > Here are those baby steps:
> > 
> > 1.	rcu-tasks: Fix warning for unused tasks_rcu_exit_srcu.
> > 
> > 2.	Add whitespace to __SRCU_STRUCT_INIT() & __DEFINE_SRCU().
> > 
> > 3.	Use static init for statically allocated in-module srcu_struct.
> > 
> > 4.	Begin offloading srcu_struct fields to srcu_update.
> > 
> > 5.	Move ->level from srcu_struct to srcu_usage.
> > 
> > 6.	Move ->srcu_size_state from srcu_struct to srcu_usage.
> > 
> > 7.	Move ->srcu_cb_mutex from srcu_struct to srcu_usage.
> > 
> > 8.	Move ->lock initialization after srcu_usage allocation.
> > 
> > 9.	Move ->lock from srcu_struct to srcu_usage.
> > 
> > 10.	Move ->srcu_gp_mutex from srcu_struct to srcu_usage.
> > 
> > 11.	Move grace-period fields from srcu_struct to srcu_usage.
> > 
> > 12.	Move heuristics fields from srcu_struct to srcu_usage.
> > 
> > 13.	Move ->sda_is_static from srcu_struct to srcu_usage.
> > 
> > 14.	Move srcu_barrier() fields from srcu_struct to srcu_usage.
> > 
> > 15.	Move work-scheduling fields from srcu_struct to srcu_usage.
> > 
> > 16.	Check for readers at module-exit time.
> > 
> > 17.	Fix long lines in srcu_get_delay().
> > 
> > 18.	Fix long lines in cleanup_srcu_struct().
> > 
> > 19.	Fix long lines in srcu_gp_end().
> > 
> > 20.	Fix long lines in srcu_funnel_gp_start().
> > 
> > Changes since the RFC series:
> > https://lore.kernel.org/all/3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop/
> > 
> > 1.	Add checks for readers of in-module statically allocated
> > 	srcu_struct structures persisting past module unload.
> > 
> > 2.	Apply Tested-by tags.
> > 
> > 3.	Apply feedback from "Zhang, Qiang1" and kernel test robot,
> > 	perhaps most notably getting rid of memory leaks and improving
> > 	the handling of statically allocated srcu_struct structures
> > 	defined within modules.
> > 
> > 4.	Drop the commit removing extraneous parentheses given the desire
> > 	to push this into the v6.4 merge window, the fact that this
> > 	commit generates conflicts with other v6.4 RCU commits, and the
> > 	low value of this commit.  It therefore remains in the v6.5 pile.
> > 
> > 						Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> >  b/include/linux/notifier.h |    5 
> >  b/include/linux/srcutiny.h |    6 
> >  b/include/linux/srcutree.h |   28 +-
> >  b/kernel/rcu/rcu.h         |    6 
> >  b/kernel/rcu/srcutree.c    |   19 +
> >  b/kernel/rcu/tasks.h       |    2 
> >  include/linux/srcutree.h   |  123 ++++++-----
> >  kernel/rcu/srcutree.c      |  495 +++++++++++++++++++++++----------------------
> >  8 files changed, 370 insertions(+), 314 deletions(-)
> 
> It looks good on my ARM64 board:
> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Thank you!  I will apply on my rebase later today.

> Output of run:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2h --configs SRCU-P SRCU-N SRCU-T SRCU-U --trust-make
> SRCU-N ------- 204135 GPs (28.3521/s) [srcu: g1765408 f0x0 total-gps=1765408] n_max_cbs: 150000
> :CONFIG_HYPERVISOR_GUEST=y: improperly set
> :CONFIG_KVM_GUEST=y: improperly set
> SRCU-P ------- 105511 GPs (14.6543/s) [srcud: g884128 f0x0 total-gps=884128] n_max_cbs: 150000
> :CONFIG_HYPERVISOR_GUEST=y: improperly set
> :CONFIG_KVM_GUEST=y: improperly set
> SRCU-T ------- 334055 GPs (46.3965/s) [srcu: g2638072 f0x0 total-gps=2638072] n_max_cbs: 50000
> :CONFIG_HYPERVISOR_GUEST=y: improperly set
> :CONFIG_KVM_GUEST=y: improperly set
> :CONFIG_SMP: improperly set
> :CONFIG_TINY_SRCU=y: improperly set
> SRCU-U ------- 292738 GPs (40.6581/s) [srcud: g2349416 f0x0 total-gps=2349416] n_max_cbs: 50000
> :CONFIG_HYPERVISOR_GUEST=y: improperly set
> :CONFIG_KVM_GUEST=y: improperly set
> :CONFIG_SMP: improperly set
> :CONFIG_TINY_SRCU=y: improperly set
> 1 runs with build errors.
> 
> That "build error" is actually perl doing this:
> 
> perl: warning: Please check that your locale settings:
> perl: warning: Falling back to the standard locale ("C").
> 
> I think its harmless and the test did fine. It is just that my chroot is
> missing some packages (I have run into this warning before).

Frederic ran into some similar messages where the scripts implicitly
assumed en_us locale, but his warnings were specific to rcutorture.

> The "improperly set" thingies are perhaps Kconfig on ARM64 setting some KVM
> options slightly differently. I have seen that before as well on this board.

Agreed, and one of the things on the long list is to allow arch-specific
settings for those options.

The CONFIG_SMP warnings are interesting, though.  Does arm64 disallow
!SMP builds?  ;-)

							Thanx, Paul
