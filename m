Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9919B640714
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiLBMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiLBMrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:47:03 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7AED4AE7
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:47:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NNswG4zGhz9xHYT
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 20:39:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP2 (Coremail) with SMTP id GxC2BwAXSfWj84ljytWyAA--.50887S2;
        Fri, 02 Dec 2022 13:46:38 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Subject: [PATCH v2] tools: memory-model: Make plain accesses carry dependencies
Date:   Fri,  2 Dec 2022 13:51:00 +0100
Message-Id: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GxC2BwAXSfWj84ljytWyAA--.50887S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry8KFWDCw43tF1kCw4fAFb_yoW7XFyDp3
        ykK345KF4ktr9xZF97Gw17WFyfWan7Cr1UJrna9ry09r45ur1Fyry3KryYvFy8ur4kA3WU
        urWYqF40kw1kJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Oberhauser <jonas.oberhauser@huawei.com>

As reported by Viktor, plain accesses in LKMM are weaker than
accesses to registers: the latter carry dependencies but the former
do not. This is exemplified in the following snippet:

  int r = READ_ONCE(*x);
  WRITE_ONCE(*y, r);

Here a data dependency links the READ_ONCE() to the WRITE_ONCE(),
preserving their order, because the model treats r as a register.
If r is turned into a memory location accessed by plain accesses,
however, the link is broken and the order between READ_ONCE() and
WRITE_ONCE() is no longer preserved.

This is too conservative, since any optimizations on plain
accesses that might break dependencies are also possible on
registers; it also contradicts the intuitive notion of "dependency"
as the data stored by the WRITE_ONCE() does depend on the data read
by the READ_ONCE(), independently of whether r is a register or a
memory location.

This is resolved by redefining all dependencies to include
dependencies carried by memory accesses; a dependency is said to be
carried by memory accesses (in the model: carry-dep) from one load
to another load if the initial load is followed by an arbitrarily
long sequence alternating between stores and loads of the same
thread, where the data of each store depends on the previous load,
and is read by the next load.

Any dependency linking the final load in the sequence to another
access also links the initial load in the sequence to that access.

Reported-by: Viktor Vafeiadis <viktor@mpi-sws.org>
Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huawei.com>
Reviewed-by: Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
---
 .../Documentation/explanation.txt             |  9 +++++-
 tools/memory-model/linux-kernel.bell          |  6 ++++
 .../litmus-tests/dep+plain.litmus             | 31 +++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tools/memory-model/litmus-tests/dep+plain.litmus

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index e901b47236c3..8e7085238470 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -2575,7 +2575,7 @@ smp_store_release() -- which is basically how the Linux kernel treats
 them.
 
 Although we said that plain accesses are not linked by the ppo
-relation, they do contribute to it indirectly.  Namely, when there is
+relation, they do contribute to it indirectly.  Firstly, when there is
 an address dependency from a marked load R to a plain store W,
 followed by smp_wmb() and then a marked store W', the LKMM creates a
 ppo link from R to W'.  The reasoning behind this is perhaps a little
@@ -2584,6 +2584,13 @@ for this source code in which W' could execute before R.  Just as with
 pre-bounding by address dependencies, it is possible for the compiler
 to undermine this relation if sufficient care is not taken.
 
+Secondly, plain accesses can carry dependencies: If a data dependency
+links a marked load R to a store W, and the store is read by a load R'
+from the same thread, then the data loaded by R' depends on the data
+loaded originally by R. Thus, if R' is linked to any access X by a
+dependency, R is also linked to access X by the same dependency, even
+if W' or R' (or both!) are plain.
+
 There are a few oddball fences which need special treatment:
 smp_mb__before_atomic(), smp_mb__after_atomic(), and
 smp_mb__after_spinlock().  The LKMM uses fence events with special
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 65c32ca9d5ea..5f0b98c1ab81 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -76,3 +76,9 @@ flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
 		LKR | LKW | UL | LF | RL | RU
 let Plain = M \ Marked
+
+(* Redefine dependencies to include those carried through plain accesses *)
+let carry-dep = (data ; rfi)*
+let addr = carry-dep ; addr
+let ctrl = carry-dep ; ctrl
+let data = carry-dep ; data
diff --git a/tools/memory-model/litmus-tests/dep+plain.litmus b/tools/memory-model/litmus-tests/dep+plain.litmus
new file mode 100644
index 000000000000..ebf84daa9a59
--- /dev/null
+++ b/tools/memory-model/litmus-tests/dep+plain.litmus
@@ -0,0 +1,31 @@
+C dep+plain
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that in LKMM, plain accesses
+ * carry dependencies much like accesses to registers:
+ * The data stored to *z1 and *z2 by P0() originates from P0()'s
+ * READ_ONCE(), and therefore using that data to compute the
+ * conditional of P0()'s if-statement creates a control dependency
+ * from that READ_ONCE() to P0()'s WRITE_ONCE().
+ *)
+
+{}
+
+P0(int *x, int *y, int *z1, int *z2)
+{
+	int a = READ_ONCE(*x);
+	*z1 = a;
+	*z2 = *z1;
+	if (*z2 == 1)
+		WRITE_ONCE(*y, 1);
+}
+
+P1(int *x, int *y)
+{
+	int r = smp_load_acquire(y);
+	smp_store_release(x, r);
+}
+
+exists (x=1 /\ y=1)
-- 
2.17.1

