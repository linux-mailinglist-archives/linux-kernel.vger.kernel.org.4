Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F323960105A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 15:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiJQNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJQNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 09:37:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C996386F;
        Mon, 17 Oct 2022 06:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30E4BB81698;
        Mon, 17 Oct 2022 13:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF916C433D7;
        Mon, 17 Oct 2022 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666013858;
        bh=7PaZ/qmnm7lCaEZHPQ5A551meqALQvJy4m7yAHdja7Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=heBrGh3SKIXqZWcnOgGZtyb1rvAbSqnmVnyPwj3ECFIiF+mtG2SFRdrvU+3+23+d3
         AsK8XWkWCovKNjfQqwSIl7Ac0/aQvJk9ZVbM3mXDwW2eWtQ/FOBxFKzbe2qybMCbUZ
         aO/Y1/MqKqocqq6fdHNZEQmfrdXlGxx05MMIPtcwq+kSZXUJ5iM3aczgmiPAvQBcGt
         C5qwpFLOpdO+xehTXKIHs36S1yln2R5dekQS4wYrPksv6BAIr8yAOv1WNZ9R/xfLi1
         WuzyZz5+dXFPV/f7Tgel405ESJdMzvEDbaft/R1PZQVSzkwIm7n7S63ookDzG2EyTz
         j+ThNDNzGaJcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 707065C08EC; Mon, 17 Oct 2022 06:37:38 -0700 (PDT)
Date:   Mon, 17 Oct 2022 06:37:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [PATCH v9 00/13] rcu: call_rcu() power improvements
Message-ID: <20221017133738.GE5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221016162305.2489629-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016162305.2489629-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 04:22:52PM +0000, Joel Fernandes (Google) wrote:
> v9 version of RCU lazy patches based on rcu/next branch.
>  Only change since v8 is this discussion:
>  https://lore.kernel.org/rcu/20221011180142.2742289-1-joel@joelfernandes.org/T/#m8eff15110477f3430b3b02561b66f7b0d34a73b0
> 
> To facilitate easier merge, I dropped tracing and other patches and just
> implemented the new changes. I will post the tracing patches later along with
> rcutop as I need to add new tracepoints that Frederic suggested.
> 
> Main recent changes:
> 1. rcu_barrier() wake up only for lazy bypass list.
> 2. Make all call_rcu() default-lazy and add call_rcu_flush() API.
> 3. Take care of some callers using call_rcu_flush() API.
> 4. Several refactorings suggested by Paul/Frederic.
> 5. New call_rcu() to call_rcu_flush() conversions by Joel/Vlad/Paul.
> 
> I am seeing good performance and power with these patches on real ChromeOS x86
> asymmetric hardware.
> 
> Earlier cover letter with lots of details is here:
> https://lore.kernel.org/all/20220901221720.1105021-1-joel@joelfernandes.org/
> 
> List of recent changes:
>     
>     [ Frederic Weisbec: Program the lazy timer only if WAKE_NOT, since other
>       deferral levels wake much earlier so for those it is not needed. ]
>     
>     [ Frederic Weisbec: Use flush flags to keep bypass API code clean. ]
>     
>     [ Frederic Weisbec: Make rcu_barrier() wake up only if main list empty. ]
>     
>     [ Frederic Weisbec: Remove extra 'else if' branch in rcu_nocb_try_bypass(). ]
>     
>     [ Joel: Fix issue where I was not resetting lazy_len after moving it to rdp ]
>     
>     [ Paul/Thomas/Joel: Make call_rcu() default lazy so users don't mess up. ]
>     
>     [ Paul/Frederic : Cosmetic changes, split out wakeup of nocb thread. ]
>     
>     [ Vlad/Joel : More call_rcu -> flush conversions ]
> 
>     [ debug code for detecting "wake" in kernel's call_rcu() callbacks. ]
> 
> The following 2 scripts can be used to check if any callbacks in the kernel are
> doing a wake up (it is best effort and may miss some things, but we found
> issues using it)
> 
> 1. Script to search for call_rcu() references and dump the callback list to a file:
> #!/bin/bash
> 
> rm func-list
> touch func-list
> 
> for f in $(find . \( -name "*.c" -o -name "*.h" \) | grep -v rcu); do
> 
> 	funcs=$(perl -0777 -ne 'while(m/call_rcu\([&]?.+,\s?(.+)\).*;/g){print "$1\n";}' $f)
> 
> 	if [ "x$funcs" != "x" ]; then
> 		for func in $funcs; do
> 			echo "$f $func" >> func-list
> 			echo "$f $func"
> 		done
> 	fi
> 
> done
> 
> cat func-list | sort | uniq | tee func-list-sorted
> 
> 2. Script to search "wake" after callback references:
> 
> #!/bin/bash
> 
> while read fl; do
> 	file=$(echo $fl | cut -d " " -f1)
> 	func=$(echo $fl | cut -d " " -f2)
> 
> 	grep -A 30 $func $file | grep wake > /dev/null
> 
> 	if [ $? -eq 0 ]; then
> 		echo "keyword wake found after function reference $func in $file"
> 		echo "Output:"
> 		grep -A 30 $func $file 
> 		echo "==========================================================="
> 	fi
> done < func-list-sorted

Very good, thank you all!

I have pulled these in for further review and testing.

I am holding off on the last one ("rcu/debug: Add wake-up debugging for
lazy callbacks") for the immediate future, but let's see how it goes.

							Thanx, Paul

> Frederic Weisbecker (1):
> rcu: Fix missing nocb gp wake on rcu_barrier()
> 
> Joel Fernandes (Google) (9):
> rcu: Make call_rcu() lazy to save power
> rcu: Refactor code a bit in rcu_nocb_do_flush_bypass()
> rcuscale: Add laziness and kfree tests
> percpu-refcount: Use call_rcu_flush() for atomic switch
> rcu/sync: Use call_rcu_flush() instead of call_rcu
> rcu/rcuscale: Use call_rcu_flush() for async reader test
> rcu/rcutorture: Use call_rcu_flush() where needed
> rxrpc: Use call_rcu_flush() instead of call_rcu()
> rcu/debug: Add wake-up debugging for lazy callbacks
> 
> Uladzislau Rezki (2):
> scsi/scsi_error: Use call_rcu_flush() instead of call_rcu()
> workqueue: Make queue_rcu_work() use call_rcu_flush()
> 
> Vineeth Pillai (1):
> rcu: shrinker for lazy rcu
> 
> drivers/scsi/scsi_error.c |   2 +-
> include/linux/rcupdate.h  |   7 ++
> kernel/rcu/Kconfig        |  15 +++
> kernel/rcu/lazy-debug.h   | 154 +++++++++++++++++++++++++++
> kernel/rcu/rcu.h          |   8 ++
> kernel/rcu/rcuscale.c     |  70 +++++++++++-
> kernel/rcu/rcutorture.c   |  16 +--
> kernel/rcu/sync.c         |   2 +-
> kernel/rcu/tiny.c         |   2 +-
> kernel/rcu/tree.c         | 149 ++++++++++++++++++--------
> kernel/rcu/tree.h         |  12 ++-
> kernel/rcu/tree_exp.h     |   2 +-
> kernel/rcu/tree_nocb.h    | 217 ++++++++++++++++++++++++++++++++------
> kernel/workqueue.c        |   2 +-
> lib/percpu-refcount.c     |   3 +-
> net/rxrpc/conn_object.c   |   2 +-
> 16 files changed, 565 insertions(+), 98 deletions(-)
> create mode 100644 kernel/rcu/lazy-debug.h
> 
> --
> 2.38.0.413.g74048e4d9e-goog
> 
