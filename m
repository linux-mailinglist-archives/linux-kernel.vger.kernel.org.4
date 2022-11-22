Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE7C6331C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 02:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiKVBEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 20:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiKVBEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 20:04:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E8D121;
        Mon, 21 Nov 2022 17:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBC0EB818BC;
        Tue, 22 Nov 2022 01:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5E1C433C1;
        Tue, 22 Nov 2022 01:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669079048;
        bh=1WsAEwovNFRqPIrTBB1RlDI1n+nRzJzZkVm03kcczKk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RFBpFGt+aJlV3b9VjxKSIt4mjkPHaRJbVkm/g/gTDZjoVjaTccJHN4czCwAkzzHtt
         Ja3mBNPB4xKScxE41osTksS/+1qSJ94tmcl0LIwmgwbJ8Aw8Vr4hquSi9j73DYPNen
         M21i7THoq9GQxpakzCQul/VEuPkBn0quMheCExoiPTsmkjCC/ST6pNxKonG5WUH0KE
         BssZ4sNe5z4kyn0lFz/zX7sIKG4aYSvtqLWCvpromsvpyAeC/McmZs3Y64xP9h1+HX
         Hrl1DqvrO4gmcKsJ8hU6FR3Q96EyaAxYjbdEHvweW3pJVyqEmcr8H3hQByKiNVxheG
         tBJ7nzSCjGcnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 27AD35C0641; Mon, 21 Nov 2022 17:04:08 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:04:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/16 Lazy call_rcu() updates for v6.2
Message-ID: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

15.	Use call_rcu_flush() for dst_release(), courtesy of "Joel
	Fernandes (Google)".

16.	devinet: Reduce refcount before grace period, courtesy of Eric
	Dumazet.

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
