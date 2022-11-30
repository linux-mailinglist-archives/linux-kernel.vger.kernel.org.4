Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C863DCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiK3SNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiK3SNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973922A717;
        Wed, 30 Nov 2022 10:13:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54695B81C9C;
        Wed, 30 Nov 2022 18:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12907C433C1;
        Wed, 30 Nov 2022 18:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669831997;
        bh=jEXYy2sRGOMTywAVi6nSyBZ4IPniFAdcqehMf/7xaAA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=KoBp+JJFP9XX5vMmouLEgYef2BeT9hv2NqucWpaDWpTSiioISbDM++dWYySNUo8hB
         fRw2iYavo5MoxOiP6JKZ220PJ196ad070E6/5UDjCGHFiE4AqVCPahzxvgqXzIpCdC
         HN3Z/V4/JgNb3mEFChv/XK/H9n70ZpvPlUbX9xRk4OawQIkVoQGxsDMP3wr2Jq4xLT
         mwDpZY5IBnVWFTx4SJXpJvUnBcc7mnEIOkIAqZM8CVDkpkDZT32GMct2GwtEAUOU3y
         HcTSeLUib4HXLAwfsc9HUe8HJ1j3Ygg82cyCEkkJmIrxFTxO5JLRmo36RedW429lvk
         r7HI/YlKG9DZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B268F5C051C; Wed, 30 Nov 2022 10:13:16 -0800 (PST)
Date:   Wed, 30 Nov 2022 10:13:16 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH v3 rcu 0/16] Lazy call_rcu() updates for v6.2
Message-ID: <20221130181316.GA1012431@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides energy efficiency for nearly-idle systems by making
call_rcu() more lazy.  Several NOCB changes come along for the ride:

1.	Simplify rcu_init_nohz() cpumask handling, courtesy of Zhen Lei.

2.	Fix late wakeup when flush of bypass cblist happens, courtesy of
	"Joel Fernandes (Google)".

3.	Fix missing nocb gp wake on rcu_barrier(), courtesy of Frederic
	Weisbecker.

4.	Make call_rcu() lazy to save power, courtesy of "Joel Fernandes
	(Google)".

5.	Refactor code a bit in rcu_nocb_do_flush_bypass(), courtesy of
	"Joel Fernandes (Google)".

6.	Shrinker for lazy rcu, courtesy of Vineeth Pillai.

7.	Add laziness and kfree tests, courtesy of "Joel Fernandes
	(Google)".

8.	Use call_rcu_hurry() instead of call_rcu, courtesy of "Joel
	Fernandes (Google)".

9.	Use call_rcu_hurry() for async reader test, courtesy of "Joel
	Fernandes (Google)".

10.	Use call_rcu_hurry() where needed, courtesy of "Joel Fernandes
	(Google)".

11.	scsi/scsi_error: Use call_rcu_hurry() instead of call_rcu(),
	courtesy of Uladzislau Rezki.

12.	percpu-refcount: Use call_rcu_hurry() for atomic switch, courtesy
	of "Joel Fernandes (Google)".

13.	Make queue_rcu_work() use call_rcu_hurry(), courtesy of Uladzislau
	Rezki.

14.	Use call_rcu_hurry() instead of call_rcu(), courtesy of "Joel
	Fernandes (Google)".

15.	Use call_rcu_hurry() for dst_release(), courtesy of "Joel
	Fernandes (Google)".

16.	devinet: Reduce refcount before grace period, courtesy of Eric
	Dumazet.

Changes since v2:

o	Rename call_rcu_flush() to call_rcu_hurry() to avoid naming
	conflicts in workqueues as suggested by Tejun Heo.

o	Apply acks and reviews.

https://lore.kernel.org/all/20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1/

Changes since v1:

o	Add more adjustments to avoid excessive laziness (#15 and
	#16 above).

o	Get appropriate Cc lines onto non-RCU patches.

https://lore.kernel.org/all/20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1/

						Thanx, Paul

------------------------------------------------------------------------

 b/drivers/scsi/scsi_error.c |    2 
 b/include/linux/rcupdate.h  |    9 +
 b/kernel/rcu/Kconfig        |    8 +
 b/kernel/rcu/rcu.h          |    8 +
 b/kernel/rcu/rcuscale.c     |   67 +++++++++++-
 b/kernel/rcu/rcutorture.c   |   16 +-
 b/kernel/rcu/sync.c         |    2 
 b/kernel/rcu/tiny.c         |    2 
 b/kernel/rcu/tree.c         |   11 +
 b/kernel/rcu/tree.h         |    1 
 b/kernel/rcu/tree_exp.h     |    2 
 b/kernel/rcu/tree_nocb.h    |   34 +-----
 b/kernel/workqueue.c        |    2 
 b/lib/percpu-refcount.c     |    3 
 b/net/core/dst.c            |    2 
 b/net/ipv4/devinet.c        |   19 +--
 b/net/rxrpc/conn_object.c   |    2 
 kernel/rcu/rcuscale.c       |    2 
 kernel/rcu/tree.c           |  129 +++++++++++++++--------
 kernel/rcu/tree.h           |   11 +
 kernel/rcu/tree_nocb.h      |  243 ++++++++++++++++++++++++++++++++++++--------
 21 files changed, 434 insertions(+), 141 deletions(-)
