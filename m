Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81CB628706
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiKNR0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiKNR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:26:38 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C384D2E9FC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:26:24 -0800 (PST)
Received: (qmail 139870 invoked by uid 1000); 14 Nov 2022 12:26:23 -0500
Date:   Mon, 14 Nov 2022 12:26:23 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        jonas.oberhauser@huawei.com,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools: memory-model: Add rmw-sequences to the LKMM
Message-ID: <Y3J6P3jCNmrj3tue@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonas has pointed out a weakness in the Linux Kernel Memory Model.
Namely, the memory ordering properties of atomic operations are not
monotonic: An atomic op with full-barrier semantics does not always
provide ordering as strong as one with release-barrier semantics.

The following litmus test illustrates the problem:

--------------------------------------------------
C atomics-not-monotonic

{}

P0(int *x, atomic_t *y)
{
	WRITE_ONCE(*x, 1);
	smp_wmb();
	atomic_set(y, 1);
}

P1(atomic_t *y)
{
	int r1;

	r1 = atomic_inc_return(y);
}

P2(int *x, atomic_t *y)
{
	int r2;
	int r3;

	r2 = atomic_read(y);
	smp_rmb();
	r3 = READ_ONCE(*x);
}

exists (2:r2=2 /\ 2:r3=0)
--------------------------------------------------

The litmus test is allowed as shown with atomic_inc_return(), which
has full-barrier semantics.  But if the operation is changed to
atomic_inc_return_release(), which only has release-barrier semantics,
the litmus test is forbidden.  Clearly this violates monotonicity.

The reason is because the LKMM treats full-barrier atomic ops as if
they were written:

	mb();
	load();
	store();
	mb();

(where the load() and store() are the two parts of an atomic RMW op),
whereas it treats release-barrier atomic ops as if they were written:

	load();
	release_barrier();
	store();

The difference is that here the release barrier orders the load part
of the atomic op before the store part with A-cumulativity, whereas
the mb()'s above do not.  This means that release-barrier atomics can
effectively extend the cumul-fence relation but full-barrier atomics
cannot.

To resolve this problem we introduce the rmw-sequence relation,
representing an arbitrarily long sequence of atomic RMW operations in
which each operation reads from the previous one, and explicitly allow
it to extend cumul-fence.  This modification of the memory model is
sound; it holds for PPC because of B-cumulativity, it holds for TSO
and ARM64 because of other-multicopy atomicity, and we can assume that
atomic ops on all other architectures will be implemented so as to
make it hold for them.

For similar reasons we also allow rmw-sequence to extend the
w-post-bounded relation, which is analogous to cumul-fence in some
ways.

Suggested-by: Jonas Oberhauser <jonas.oberhauser@huawei.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 tools/memory-model/Documentation/explanation.txt |   28 +++++++++++++++++++++++
 tools/memory-model/linux-kernel.cat              |    5 ++--
 2 files changed, 31 insertions(+), 2 deletions(-)

Index: usb-devel/tools/memory-model/linux-kernel.cat
===================================================================
--- usb-devel.orig/tools/memory-model/linux-kernel.cat
+++ usb-devel/tools/memory-model/linux-kernel.cat
@@ -74,8 +74,9 @@ let ppo = to-r | to-w | fence | (po-unlo
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = (rfe ; [Marked])? ; r
+let rmw-sequence = (rf ; rmw)*
 let cumul-fence = [Marked] ; (A-cumul(strong-fence | po-rel) | wmb |
-	po-unlock-lock-po) ; [Marked]
+	po-unlock-lock-po) ; [Marked] ; rmw-sequence
 let prop = [Marked] ; (overwrite & ext)? ; cumul-fence* ;
 	[Marked] ; rfe? ; [Marked]
 
@@ -174,7 +175,7 @@ let vis = cumul-fence* ; rfe? ; [Marked]
 let w-pre-bounded = [Marked] ; (addr | fence)?
 let r-pre-bounded = [Marked] ; (addr | nonrw-fence |
 	([R4rmb] ; fencerel(Rmb) ; [~Noreturn]))?
-let w-post-bounded = fence? ; [Marked]
+let w-post-bounded = fence? ; [Marked] ; rmw-sequence
 let r-post-bounded = (nonrw-fence | ([~Noreturn] ; fencerel(Rmb) ; [R4rmb]))? ;
 	[Marked]
 
Index: usb-devel/tools/memory-model/Documentation/explanation.txt
===================================================================
--- usb-devel.orig/tools/memory-model/Documentation/explanation.txt
+++ usb-devel/tools/memory-model/Documentation/explanation.txt
@@ -1006,6 +1006,34 @@ order.  Equivalently,
 where the rmw relation links the read and write events making up each
 atomic update.  This is what the LKMM's "atomic" axiom says.
 
+Atomic rmw updates play one more role in the LKMM: They can form "rmw
+sequences".  An rmw sequence is simply a bunch of atomic updates where
+each update reads from the previous one.  Written using events, it
+looks like this:
+
+	Z0 ->rf Y1 ->rmw Z1 ->rf ... ->rf Yn ->rmw Zn,
+
+where Z0 is some store event and n can be any number (even 0, in the
+degenerate case).  We write this relation as: Z0 ->rmw-sequence Zn.
+Note that this implies Z0 and Zn are stores to the same variable.
+
+Rmw sequences have a special property in the LKMM: They can extend the
+cumul-fence relation.  That is, if we have:
+
+	U ->cumul-fence X -> rmw-sequence Y
+
+then also U ->cumul-fence Y.  Thinking about this in terms of the
+operational model, U ->cumul-fence X says that the store U propagates
+to each CPU before the store X does.  Then the fact that X and Y are
+linked by an rmw sequence means that U also propagates to each CPU
+before Y does.
+
+(The notion of rmw sequences in the LKMM is similar to, but not quite
+the same as, that of release sequences in the C11 memory model.  They
+were added to the LKMM to fix an obscure bug; without them, atomic
+updates with full-barrier semantics did not always guarantee ordering
+at least as strong as atomic updates with release-barrier semantics.)
+
 
 THE PRESERVED PROGRAM ORDER RELATION: ppo
 -----------------------------------------

