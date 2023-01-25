Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C61567BC71
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 21:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbjAYUUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 15:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjAYUUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 15:20:53 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4A1D758972
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 12:20:52 -0800 (PST)
Received: (qmail 225322 invoked by uid 1000); 25 Jan 2023 15:20:51 -0500
Date:   Wed, 25 Jan 2023 15:20:51 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: [Patch 1/2] tools/memory-model: Update some warning labels
Message-ID: <Y9GPI/g23YWx+0Ce@rowland.harvard.edu>
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the warning labels used in the LKMM are unfortunately
ambiguous.  In particular, the same warning is used for both an
unmatched rcu_read_lock() call and for an unmatched rcu_read_unlock()
call.  Likewise for the srcu_* equivalents.  Also, the warning about
passing a wrong value to srcu_read_unlock() -- i.e., a value different
from the one returned by the matching srcu_read_lock() -- talks about
bad nesting rather than non-matching values.

Let's update the warning labels to make their meanings more clear.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 tools/memory-model/linux-kernel.bell |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: usb-devel/tools/memory-model/linux-kernel.bell
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.bell
+++ usb-devel/tools/memory-model/linux-kernel.bell
@@ -53,8 +53,8 @@ let rcu-rscs = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Rcu-lock \ domain(rcu-rscs) as unbalanced-rcu-locking
-flag ~empty Rcu-unlock \ range(rcu-rscs) as unbalanced-rcu-locking
+flag ~empty Rcu-lock \ domain(rcu-rscs) as unmatched-rcu-lock
+flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
 
 (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
 let srcu-rscs = let rec
@@ -69,14 +69,14 @@ let srcu-rscs = let rec
 	in matched
 
 (* Validate nesting *)
-flag ~empty Srcu-lock \ domain(srcu-rscs) as unbalanced-srcu-locking
-flag ~empty Srcu-unlock \ range(srcu-rscs) as unbalanced-srcu-locking
+flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
+flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
 
 (* Check for use of synchronize_srcu() inside an RCU critical section *)
 flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
 
 (* Validate SRCU dynamic match *)
-flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
+flag ~empty different-values(srcu-rscs) as srcu-bad-value-match
 
 (* Compute marked and plain memory accesses *)
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
