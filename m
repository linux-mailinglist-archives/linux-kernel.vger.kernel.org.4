Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BB7676E10
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 16:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjAVPGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 10:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjAVPGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 10:06:38 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC6A1814A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 07:06:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P0GZk1VtBz9yfJb
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 22:58:38 +0800 (CST)
Received: from [10.48.133.163] (unknown [10.48.133.163])
        by APP2 (Coremail) with SMTP id GxC2BwDHmmHUUM1jwHa4AA--.9325S2;
        Sun, 22 Jan 2023 16:06:09 +0100 (CET)
Message-ID: <30f2ce62-c5c8-6506-d488-26f83933e1f7@huaweicloud.com>
Date:   Sun, 22 Jan 2023 16:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
From:   Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc:     Diogo Behrens <diogo.behrens@huawei.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] Potential unnecessary barrier in slow path of rt_mutex
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, akpm@osdl.org,
        arjan@linux.intel.com, tglx@linutronix.de, joel@joelfernandes.org,
        paulmck@kernel.org, stern@rowland.harvard.edu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDHmmHUUM1jwHa4AA--.9325S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary7Ar1xtw47ZrWrZryrJFb_yoW7Ar1xpF
        WUKayDJrZ8tr1jy3ykGr4jy34rAa95A3yUJwnagrWUuFnxGF4rKr48GFy09FyUCrn5Za18
        Za1jkas2kF4DCaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: xkhu0tnqos00pfhgvzhhrqqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

We have been trying to verify that the rt_mutex patch 
https://lkml.org/lkml/2022/12/2/279 guarantees the intended acquire 
semantics and that there are no other potential problems with it. For 
that, we are using a verification tool as discussed in 
https://lkml.org/lkml/2022/8/26/597.

The tool reported a data race for which I already submitted a patch in 
https://lkml.org/lkml/2023/1/20/702.

During the discussion of the rt_mutex patch, Will proposed replacing the 
explicit barrier in 'mark_rt_mutex_waiters' with 
'smp_acquire__after_ctrl_dep()'. We wanted to check if it would be 
possible to get rid of the barrier instead of weakening it.

While according to LKMM /tools/memory-model/linux-kernel.cat, mutual 
exclusion is violated if we do this, the verification tool reported that 
this violation is not possible according to the formal memory models of 
aarch64, riscv and power. Interestingly, if the data race from above is 
fixed, mutual exclusion is guaranteed by LKMM even if we fully remove 
the barrier. The reason for this is that marking the racy access 
introduces more ordering guarantees.

Another possibility is to keep the barrier, but revert the change 
WRITE_ONCE() -> xchg_acquire() in 'rt_mutex_set_owner'. Boqun suggested 
this one might be better because it's weird using xchg_acquire() to get 
an acquire store.

Either the barrier or the acquire store are needed for the correctness 
of the algorithm. If we relax both, the tool reports a violation.

I would like to get some feedback about the following.

(1) Since the barriers are in the slow path of the algorithm, is it 
worth it to try to play it smart or should we play it safe (at the cost 
of potentially having an extra barrier)?

(2) In which cases were the acquiring semantics missing before the 
rt_mutex patch? This is not clear for me from the patch and the 
corresponding discussion. Once I understand this, I might be able to use 
the rules from LKMM to give a more formal argument of why one of the 
barriers is not needed (or find an example that shows that indeed both 
barriers are necessary).

(3) If we agree that one barrier might not necessary, but we still keep 
both to be safe, would it make sense to add some comment in the code 
along the lines "Of these N barriers, you can probably get away with the 
following subset of them, but we leave all in place to be safe"?

The following litmus test (I hope comments are enough to trace back to 
the real implementation) shows all the above issues in detail and how 
the changes I propose impact them. It can be run using the herd7 tool 
http://diy.inria.fr/www/?record=linux#.
The final query asks if P0 can release the lock via the fast path even 
if P1 set the wait bit. The expected result is "No".

C rt_mutex

{
   atomic_t owner = ATOMIC_INIT(0);
}

P0(int *owner, int *x) {
   int r0 = 2;                                     // current task
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);    // rtlock acquire
   int r2 = READ_ONCE(*x);                         // critical section;
   WRITE_ONCE(*x, r2 + 1);                         // marked to avoid 
data races
   int r3 = atomic_cmpxchg_release(owner,r0,0);    // rtlock release 
succeeds
}

P1(int *owner, int *x) {
   int r0 = 4;                                     // current task
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);    // rtlock acquire failed
   int r2 = *owner;                                // mark waiters
   int r3 = atomic_cmpxchg_relaxed(owner,r2,r2|1); // mark waiters succeeds
   smp_mb();                                       // mark waiters
   int r4 = xchg_acquire(owner,r0);                // set owner
   int r5 = READ_ONCE(*x);                         // critical section
}

// 0:r1 = 0:    rtlock acquire succeeds
// 0:r3 = 2:    rtlock release succeeds
// 1:r1 = 2:    rtlock acquire failed
// 1:r3 = 1:r2: mark waiters succeeds
// 1:r5 = 0:    critical section violated
exists (0:r1 = 0 /\ 0:r3 = 2 /\ 1:r1 = 2 /\ 1:r3 = 1:r2 /\ 1:r5 = 0)

herd7 reports a race related to 'mark waiters'. Below is the fix I 
proposed in https://lkml.org/lkml/2023/1/20/702.

P0(int *owner, int *x) {
   int r0 = 2;
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);
   int r2 = READ_ONCE(*x);
   WRITE_ONCE(*x, r2 + 1);
   int r3 = atomic_cmpxchg_release(owner,r0,0);
}

P1(int *owner, int *x) {
   int r0 = 4;
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);
   int r2 = READ_ONCE(*owner);
   int r3 = atomic_cmpxchg_relaxed(owner,r2,r2|1);
   smp_mb();
   int r4 = xchg_acquire(owner,r0);
   int r5 = READ_ONCE(*x);
}

This code is correct (result is "No") and there are no races, but it has 
an unnecessary barrier. smp_mb() can be removed without affecting the 
result.

P0(int *owner, int *x) {
   int r0 = 2;
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);
   int r2 = READ_ONCE(*x);
   WRITE_ONCE(*x, r2 + 1);
   int r3 = atomic_cmpxchg_release(owner,r0,0);
}

P1(int *owner, int *x) {
   int r0 = 4;
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);
   int r2 = READ_ONCE(*owner);
   int r3 = atomic_cmpxchg_relaxed(owner,r2,r2|1);
   int r4 = xchg_acquire(owner,r0);
   int r5 = READ_ONCE(*x);
}

The other possibility is to keep the barrier, but relax the acquire store.

P0(int *owner, int *x) {
   int r0 = 2;
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);
   int r2 = READ_ONCE(*x);
   WRITE_ONCE(*x, r2 + 1);
   int r3 = atomic_cmpxchg_release(owner,r0,0);
}

P1(int *owner, int *x) {
   int r0 = 4;
   int r1 = atomic_cmpxchg_acquire(owner,0,r0);
   int r2 = READ_ONCE(*owner);
   int r3 = atomic_cmpxchg_relaxed(owner,r2,r2|1);
   smp_mb();
   WRITE_ONCE(*owner,r0);
   int r5 = READ_ONCE(*x);
}

Once again the result is "No".

Regards,
Hernan

