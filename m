Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C357E67CC75
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjAZNml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjAZNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:42:34 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4FE6DFC3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:42:17 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P2hWN2TYMz9v7cJ
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:34:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP2 (Coremail) with SMTP id GxC2BwBnOWAOg9JjSrPJAA--.522S3;
        Thu, 26 Jan 2023 14:41:53 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH v2 1/2] tools/memory-model: Unify UNLOCK+LOCK pairings to po-unlock-lock-po
Date:   Thu, 26 Jan 2023 14:46:03 +0100
Message-Id: <20230126134604.2160-2-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
X-CM-TRANSID: GxC2BwBnOWAOg9JjSrPJAA--.522S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr47ZrW7Xw4DWr1rtryDAwb_yoWrZrW8pr
        Wqgw45Kr4qyr1ku3Z7Ww45ZF4fCa1fGryrArsrZwn8Aa45Xr4xur1UKrWYq3srGrn7uFWq
        vF4jvas8Cr1kAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSYLPUUUUU
        =
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKMM uses two relations for talking about UNLOCK+LOCK pairings:

	1) po-unlock-lock-po, which handles UNLOCK+LOCK pairings
	   on the same CPU or immediate lock handovers on the same
	   lock variable

	2) po;[UL];(co|po);[LKW];po, which handles UNLOCK+LOCK pairs
	   literally as described in rcupdate.h#L1002, i.e., even
	   after a sequence of handovers on the same lock variable.

The latter relation is used only once, to provide the guarantee
defined in rcupdate.h#L1002 by smp_mb__after_unlock_lock(), which
makes any UNLOCK+LOCK pair followed by the fence behave like a full
barrier.

This patch drops this use in favor of using po-unlock-lock-po
everywhere, which unifies the way the model talks about UNLOCK+LOCK
pairings.  At first glance this seems to weaken the guarantee given
by LKMM: When considering a long sequence of lock handovers
such as below, where P0 hands the lock to P1, which hands it to P2,
which finally executes such an after_unlock_lock fence, the mb
relation currently links any stores in the critical section of P0
to instructions P2 executes after its fence, but not so after the
patch.

P0(int *x, int *y, spinlock_t *mylock)
{
        spin_lock(mylock);
        WRITE_ONCE(*x, 2);
        spin_unlock(mylock);
        WRITE_ONCE(*y, 1);
}

P1(int *y, int *z, spinlock_t *mylock)
{
        int r0 = READ_ONCE(*y); // reads 1
        spin_lock(mylock);
        spin_unlock(mylock);
        WRITE_ONCE(*z,1);
}

P2(int *z, int *d, spinlock_t *mylock)
{
        int r1 = READ_ONCE(*z); // reads 1
        spin_lock(mylock);
        spin_unlock(mylock);
        smp_mb__after_unlock_lock();
        WRITE_ONCE(*d,1);
}

P3(int *x, int *d)
{
        WRITE_ONCE(*d,2);
        smp_mb();
        WRITE_ONCE(*x,1);
}

exists (1:r0=1 /\ 2:r1=1 /\ x=2 /\ d=2)

Nevertheless, the ordering guarantee given in rcupdate.h is actually
not weakened.  This is because the unlock operations along the
sequence of handovers are A-cumulative fences.  They ensure that any
stores that propagate to the CPU performing the first unlock
operation in the sequence must also propagate to every CPU that
performs a subsequent lock operation in the sequence.  Therefore any
such stores will also be ordered correctly by the fence even if only
the final handover is considered a full barrier.

Indeed this patch does not affect the behaviors allowed by LKMM at
all.  The mb relation is used to define ordering through:
1) mb/.../ppo/hb, where the ordering is subsumed by hb+ where the
   lock-release, rfe, and unlock-acquire orderings each provide hb
2) mb/strong-fence/cumul-fence/prop, where the rfe and A-cumulative
   lock-release orderings simply add more fine-grained cumul-fence
   edges to substitute a single strong-fence edge provided by a long
   lock handover sequence
3) mb/strong-fence/pb and various similar uses in the definition of
   data races, where as discussed above any long handover sequence
   can be turned into a sequence of cumul-fence edges that provide
   the same ordering.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.cat | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 07f884f9b2bf..6e531457bb73 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -37,8 +37,19 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
 	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
-	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
-		fencerel(After-unlock-lock) ; [M])
+(*
+ * Note: The po-unlock-lock-po relation only passes the lock to the direct
+ * successor, perhaps giving the impression that the ordering of the
+ * smp_mb__after_unlock_lock() fence only affects a single lock handover.
+ * However, in a longer sequence of lock handovers, the implicit
+ * A-cumulative release fences of lock-release ensure that any stores that
+ * propagate to one of the involved CPUs before it hands over the lock to
+ * the next CPU will also propagate to the final CPU handing over the lock
+ * to the CPU that executes the fence.  Therefore, all those stores are
+ * also affected by the fence.
+ *)
+	([M] ; po-unlock-lock-po ;
+		[After-unlock-lock] ; po ; [M])
 let gp = po ; [Sync-rcu | Sync-srcu] ; po?
 let strong-fence = mb | gp
 
-- 
2.17.1

