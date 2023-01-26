Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38667CC77
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjAZNmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjAZNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:42:40 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07506DFF0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:42:26 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P2hWf2L9wz9v7gZ
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 21:34:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.206.133.88])
        by APP2 (Coremail) with SMTP id GxC2BwBnOWAOg9JjSrPJAA--.522S4;
        Thu, 26 Jan 2023 14:42:02 +0100 (CET)
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
To:     paulmck@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
Date:   Thu, 26 Jan 2023 14:46:04 +0100
Message-Id: <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
X-CM-TRANSID: GxC2BwBnOWAOg9JjSrPJAA--.522S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF48GrWDJryktw1UKr4kJFb_yoW5JrW3pr
        y0k343KF4UtrsY93ZrW3ZxuF1UCa1xKw18GF4DAw1rAw13WFZFvF18trs8Wa4aqrZ7GFWD
        Zr1Yvrn2yayDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
        kIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
        xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
        kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v2
        6F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
        1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1489tUU
        UUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As stated in the documentation and implied by its name, the ppo
(preserved program order) relation is intended to link po-earlier
to po-later instructions under certain conditions.  However, a
corner case currently allows instructions to be linked by ppo that
are not executed by the same thread, i.e., instructions are being
linked that have no po relation.

This happens due to the mb/strong-fence relations, which (as one
case) provide order when locks are passed between threads followed
by an smp_mb__after_unlock_lock() fence.  This is illustrated in
the following litmus test (as can be seen when using herd7 with
`doshow ppo`):

P0(int *x, int *y)
{
    spin_lock(x);
    spin_unlock(x);
}

P1(int *x, int *y)
{
    spin_lock(x);
    smp_mb__after_unlock_lock();
    *y = 1;
}

The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
P0 passes a lock to P1 which then uses this fence.

The patch makes ppo a subrelation of po by eliminating this possibility
from mb (but not strong-fence) and relying explicitly on mb|gp instead
of strong-fence when defining ppo.

Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
---
 tools/memory-model/linux-kernel.cat | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index 6e531457bb73..815fdafacaef 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -36,7 +36,9 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
 	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
 	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
+let gp = po ; [Sync-rcu | Sync-srcu] ; po?
+let strong-fence = mb | gp |
 (*
  * Note: The po-unlock-lock-po relation only passes the lock to the direct
  * successor, perhaps giving the impression that the ordering of the
@@ -50,10 +52,9 @@ let mb = ([M] ; fencerel(Mb) ; [M]) |
  *)
 	([M] ; po-unlock-lock-po ;
 		[After-unlock-lock] ; po ; [M])
-let gp = po ; [Sync-rcu | Sync-srcu] ; po?
-let strong-fence = mb | gp
 
-let nonrw-fence = strong-fence | po-rel | acq-po
+
+let nonrw-fence = mb | gp | po-rel | acq-po
 let fence = nonrw-fence | wmb | rmb
 let barrier = fencerel(Barrier | Rmb | Wmb | Mb | Sync-rcu | Sync-srcu |
 		Before-atomic | After-atomic | Acquire | Release |
-- 
2.17.1

