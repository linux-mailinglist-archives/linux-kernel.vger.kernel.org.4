Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8F63F08A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 13:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiLAMax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 07:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiLAMaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 07:30:52 -0500
X-Greylist: delayed 999 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 01 Dec 2022 04:30:48 PST
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17702BA098
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 04:30:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NNFDq1F6Gz9y0N0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 20:07:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP1 (Coremail) with SMTP id LxC2BwCHcG1umohj02GvAA--.49126S2;
        Thu, 01 Dec 2022 13:13:45 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Subject: [PATCH] tools: memory-model: Make plain accesses carry dependencies
Date:   Thu,  1 Dec 2022 13:18:08 +0100
Message-Id: <20221201121808.20785-1-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: LxC2BwCHcG1umohj02GvAA--.49126S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry8KFWDCw43tF1kCw4fAFb_yoW7XFy5p3
        97K345KF4Dtr9xZF92gw17WFyfWan3Cr1UJrna9ry0vF45ur1Fyry3KryYvFy8Ar4kAa4U
        urWYqF48Cw1kJaDanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628v
        n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWr
        Zr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
        BIdaVFxhVjvjDU0xZFpf9x07UCJPiUUUUU=
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
---
 .../Documentation/explanation.txt             |  9 ++++-
 tools/memory-model/linux-kernel.bell          |  7 ++++
 .../litmus-tests/dep+plain.litmus             | 34 +++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tools/memory-model/litmus-tests/dep+plain.litmus

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index ee819a402b69..41f75dff0791 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -2544,7 +2544,7 @@ smp_store_release() -- which is basically how the Linux kernel treats
 them.
 
 Although we said that plain accesses are not linked by the ppo
-relation, they do contribute to it indirectly.  Namely, when there is
+relation, they do contribute to it indirectly.  Firstly, when there is
 an address dependency from a marked load R to a plain store W,
 followed by smp_wmb() and then a marked store W', the LKMM creates a
 ppo link from R to W'.  The reasoning behind this is perhaps a little
@@ -2553,6 +2553,13 @@ for this source code in which W' could execute before R.  Just as with
 pre-bounding by address dependencies, it is possible for the compiler
 to undermine this relation if sufficient care is not taken.
 
+Secondly, plain accesses can carry dependencies: if a data dependency
+links a marked load R to a store W, and the store is read by a load R'
+from the same thread, then the data loaded by R' depends on the data
+loaded originally by R; thus if R' is linked to any access X by a
+dependency, R is also linked to access X by the same dependency,
+in particular even if any of W' or R' are plain.
+
 There are a few oddball fences which need special treatment:
 smp_mb__before_atomic(), smp_mb__after_atomic(), and
 smp_mb__after_spinlock().  The LKMM uses fence events with special
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 5be86b1025e8..f8ec21dd6b7b 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -82,3 +82,10 @@ flag ~empty different-values(srcu-rscs) as srcu-bad-nesting
 let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
 		LKR | LKW | UL | LF | RL | RU
 let Plain = M \ Marked
+
+(* Redefine dependencies to include dependencies carried
+ * through unmarked accesses *)
+let carry-dep = (data ; rfi)*
+let addr = carry-dep ; addr
+let ctrl = carry-dep ; ctrl
+let data = carry-dep ; data
diff --git a/tools/memory-model/litmus-tests/dep+plain.litmus b/tools/memory-model/litmus-tests/dep+plain.litmus
new file mode 100644
index 000000000000..c4f974b935c5
--- /dev/null
+++ b/tools/memory-model/litmus-tests/dep+plain.litmus
@@ -0,0 +1,34 @@
+C dep+plain
+
+(*
+ * Result: Never
+ *
+ * This litmus test demonstrates that in LKMM, plain accesses
+ * carry dependencies much like accesses to registers:
+ * the data stored to *z1 and *z2 by P0() originates from P0()'s
+ * READ_ONCE(), and therefore using that data to compute the
+ * conditional of P0()'s if-statement creates a control dependency
+ * from that READ_ONCE() to P0()'s WRITE_ONCE() which is inside
+ * the if-statement.
+ *
+ *)
+
+{}
+
+P0(int *x, int *y, int *z1, int *z2)
+{
+	int a = READ_ONCE(*x);
+	*z1 = a;
+	*z2 = *z1;
+	if (*z2 == 1){
+		WRITE_ONCE(*y, 1);
+	}
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

