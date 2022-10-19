Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E547C605369
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 00:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJSWvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 18:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJSWvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 18:51:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F71F0347;
        Wed, 19 Oct 2022 15:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8702B8260A;
        Wed, 19 Oct 2022 22:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6945FC433D6;
        Wed, 19 Oct 2022 22:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666219898;
        bh=UST9akqGgKijeYQNO4FdueU2YnDxTO/0ttUDn2X6T0k=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=XRA5wehRbgkjjZI0HyFSLboyDaeS0AORi+2YzUGqE7fbtosJpSNcrFqZNLw4KImbc
         0Ifjf/GfKGGvoTjr1SK+0cZ3UWtIqOWWhGnnjq3g+mc+19QKlREXdXjk0IFRT6GceS
         COGATVhSXmn0XowNFSYqQZNVSmnTmgnf4ydLNQLEMqyQLCvDsOyZQlWgebK+pb1WSr
         R50BkbxU1lJU6s95lKy751zOuKkr/dK8K/JEcsc4kcnylzLQaMPnAdACNnX+WLnMzT
         j/b/AoQ85gY/xNhEjMMStHDLYF7qyOcDUlns3N8TPnwzmEu0y2he7ApD+n6IJlZBbA
         Ruca7DChvaLBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0ABE15C06B4; Wed, 19 Oct 2022 15:51:38 -0700 (PDT)
Date:   Wed, 19 Oct 2022 15:51:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/14] Lazy call_rcu() updates for v6.2
Message-ID: <20221019225138.GA2499943@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

8.	percpu-refcount: Use call_rcu_flush() for atomic switch, courtesy
	of "Joel Fernandes (Google)".

9.	Use call_rcu_flush() instead of call_rcu, courtesy of "Joel
	Fernandes (Google)".

10.	Use call_rcu_flush() for async reader test, courtesy of "Joel
	Fernandes (Google)".

11.	Use call_rcu_flush() where needed, courtesy of "Joel Fernandes
	(Google)".

12.	scsi/scsi_error: Use call_rcu_flush() instead of call_rcu(),
	courtesy of Uladzislau Rezki.

13.	Make queue_rcu_work() use call_rcu_flush(), courtesy of Uladzislau
	Rezki.

14.	Use call_rcu_flush() instead of call_rcu(), courtesy of "Joel
	Fernandes (Google)".

						Thanx, Paul

------------------------------------------------------------------------

 b/drivers/scsi/scsi_error.c |    2 
 b/include/linux/rcupdate.h  |    9 +
 b/kernel/rcu/Kconfig        |    8 +
 b/kernel/rcu/rcu.h          |    8 +
 b/kernel/rcu/rcuscale.c     |   68 +++++++++++-
 b/kernel/rcu/rcutorture.c   |   16 +-
 b/kernel/rcu/sync.c         |    2 
 b/kernel/rcu/tiny.c         |    2 
 b/kernel/rcu/tree.c         |   11 +
 b/kernel/rcu/tree.h         |    1 
 b/kernel/rcu/tree_exp.h     |    2 
 b/kernel/rcu/tree_nocb.h    |   34 +-----
 b/kernel/workqueue.c        |    2 
 b/lib/percpu-refcount.c     |    3 
 b/net/rxrpc/conn_object.c   |    2 
 kernel/rcu/rcuscale.c       |    2 
 kernel/rcu/tree.c           |  129 +++++++++++++++--------
 kernel/rcu/tree.h           |   11 +
 kernel/rcu/tree_nocb.h      |  243 ++++++++++++++++++++++++++++++++++++--------
 19 files changed, 424 insertions(+), 131 deletions(-)
