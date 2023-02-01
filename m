Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A34568644E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjBAKc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBAKcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:32:24 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5C91ADF7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:32:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P6J1T4g30z9xGn5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:24:13 +0800 (CST)
Received: from [10.81.213.150] (unknown [10.81.213.150])
        by APP1 (Coremail) with SMTP id LxC2BwDnaweTP9pjHOPkAA--.12981S2;
        Wed, 01 Feb 2023 11:31:58 +0100 (CET)
Message-ID: <83456878-aadd-81af-1743-cac3252950c7@huaweicloud.com>
Date:   Wed, 1 Feb 2023 11:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [Patch 2/2] tools/memory-model: Provide exact SRCU semantics
To:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
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
References: <Y9GO3xEYkIQq/qSl@rowland.harvard.edu>
 <Y9GPI/g23YWx+0Ce@rowland.harvard.edu> <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
In-Reply-To: <Y9GPVnK6lQbY6vCK@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDnaweTP9pjHOPkAA--.12981S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGF1fCFy7Zry3JryrCw4UArb_yoWDur48pr
        9xtFyfGr4DXryxZw17ur17Gry8A345XF4UJr1kJ3y8ZFyxZrn8Gr47JF1rXry5Wry7Ar4D
        Jr1jqr1DJw1UJ3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 9:21 PM, Alan Stern wrote:
> LKMM has long provided only approximate handling of SRCU read-side
> critical sections.  This has not been a pressing problem because LKMM's
> traditional handling is correct for the common cases of non-overlapping
> and properly nested critical sections.  However, LKMM's traditional
> handling of partially overlapping critical sections incorrectly fuses
> them into one large critical section.
>
> For example, consider the following litmus test:
>
> ------------------------------------------------------------------------
>
> C C-srcu-nest-5
>
> (*
>   * Result: Sometimes
>   *
>   * This demonstrates non-nested overlapping of SRCU read-side critical
>   * sections.  Unlike RCU, SRCU critical sections do not unconditionally
>   * nest.
>   *)
>
> {}
>
> P0(int *x, int *y, struct srcu_struct *s1)
> {
>          int r1;
>          int r2;
>          int r3;
>          int r4;
>
>          r3 = srcu_read_lock(s1);
>          r2 = READ_ONCE(*y);
>          r4 = srcu_read_lock(s1);
>          srcu_read_unlock(s1, r3);
>          r1 = READ_ONCE(*x);
>          srcu_read_unlock(s1, r4);
> }
>
> P1(int *x, int *y, struct srcu_struct *s1)
> {
>          WRITE_ONCE(*y, 1);
>          synchronize_srcu(s1);
>          WRITE_ONCE(*x, 1);
> }
>
> locations [0:r1]
> exists (0:r1=1 /\ 0:r2=0)
>
> ------------------------------------------------------------------------
>
> Current mainline incorrectly flattens the two critical sections into
> one larger critical section, giving "Never" instead of the correct
> "Sometimes":
>
> ------------------------------------------------------------------------
>
> $ herd7 -conf linux-kernel.cfg C-srcu-nest-5.litmus
> Test C-srcu-nest-5 Allowed
> States 3
> 0:r1=0; 0:r2=0;
> 0:r1=0; 0:r2=1;
> 0:r1=1; 0:r2=1;
> No
> Witnesses
> Positive: 0 Negative: 3
> Flag srcu-bad-nesting
> Condition exists (0:r1=1 /\ 0:r2=0)
> Observation C-srcu-nest-5 Never 0 3
> Time C-srcu-nest-5 0.01
> Hash=e692c106cf3e84e20f12991dc438ff1b
>
> ------------------------------------------------------------------------
>
> To its credit, it does complain about bad nesting.  But with this
> commit we get the following result, which has the virtue of being
> correct:
>
> ------------------------------------------------------------------------
>
> $ herd7 -conf linux-kernel.cfg C-srcu-nest-5.litmus
> Test C-srcu-nest-5 Allowed
> States 4
> 0:r1=0; 0:r2=0;
> 0:r1=0; 0:r2=1;
> 0:r1=1; 0:r2=0;
> 0:r1=1; 0:r2=1;
> Ok
> Witnesses
> Positive: 1 Negative: 3
> Condition exists (0:r1=1 /\ 0:r2=0)
> Observation C-srcu-nest-5 Sometimes 1 3
> Time C-srcu-nest-5 0.05
> Hash=e692c106cf3e84e20f12991dc438ff1b
>
> ------------------------------------------------------------------------
>
> In addition, there are new srcu_down_read() and srcu_up_read()
> functions on their way to mainline.  Roughly speaking, these are to
> srcu_read_lock() and srcu_read_unlock() as down() and up() are to
> mutex_lock() and mutex_unlock().  The key point is that
> srcu_down_read() can execute in one process and the matching
> srcu_up_read() in another, as shown in this litmus test:
>
> ------------------------------------------------------------------------
>
> C C-srcu-nest-6
>
> (*
>   * Result: Never
>   *
>   * This would be valid for srcu_down_read() and srcu_up_read().
>   *)
>
> {}
>
> P0(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
> {
>          int r2;
>          int r3;
>
>          r3 = srcu_down_read(s1);
>          WRITE_ONCE(*idx, r3);
>          r2 = READ_ONCE(*y);
>          smp_store_release(f, 1);
> }
>
> P1(int *x, int *y, struct srcu_struct *s1, int *idx, int *f)
> {
>          int r1;
>          int r3;
>          int r4;
>
>          r4 = smp_load_acquire(f);
>          r1 = READ_ONCE(*x);
>          r3 = READ_ONCE(*idx);
>          srcu_up_read(s1, r3);
> }
>
> P2(int *x, int *y, struct srcu_struct *s1)
> {
>          WRITE_ONCE(*y, 1);
>          synchronize_srcu(s1);
>          WRITE_ONCE(*x, 1);
> }
>
> locations [0:r1]
> filter (1:r4=1)
> exists (1:r1=1 /\ 0:r2=0)
>
> ------------------------------------------------------------------------
>
> When run on current mainline, this litmus test gets a complaint about
> an unknown macro srcu_down_read().  With this commit:
>
> ------------------------------------------------------------------------
>
> herd7 -conf linux-kernel.cfg C-srcu-nest-6.litmus
> Test C-srcu-nest-6 Allowed
> States 3
> 0:r1=0; 0:r2=0; 1:r1=0;
> 0:r1=0; 0:r2=1; 1:r1=0;
> 0:r1=0; 0:r2=1; 1:r1=1;
> No
> Witnesses
> Positive: 0 Negative: 3
> Condition exists (1:r1=1 /\ 0:r2=0)
> Observation C-srcu-nest-6 Never 0 3
> Time C-srcu-nest-6 0.02
> Hash=c1f20257d052ca5e899be508bedcb2a1
>
> ------------------------------------------------------------------------
>
> Note that the user must supply the flag "f" and the "filter" clause,
> similar to what must be done to emulate call_rcu().
>
> The commit works by treating srcu_read_lock()/srcu_down_read() as
> loads and srcu_read_unlock()/srcu_up_read() as stores.  This allows us
> to determine which unlock matches which lock by looking for a data
> dependency between them.  In order for this to work properly, the data
> dependencies have to be tracked through stores to intermediate
> variables such as "idx" in the litmus test above; this is handled by
> the new carry-srcu-data relation.  But it's important here (and in the
> existing carry-dep relation) to avoid tracking the dependencies
> through SRCU unlock stores.  Otherwise, in situations resembling:
>
> 	A: r1 = srcu_read_lock(s);
> 	B: srcu_read_unlock(s, r1);
> 	C: r2 = srcu_read_lock(s);
> 	D: srcu_read_unlock(s, r2);
>
> it would look as if D was dependent on both A and C, because "s" would
> appear to be an intermediate variable written by B and read by C.
> This explains the complications in the definitions of carry-srcu-dep
> and carry-dep.
>
> As a debugging aid, the commit adds a check for errors in which the
> value returned by one call to srcu_read_lock()/srcu_down_read() is
> passed to more than one instance of srcu_read_unlock()/srcu_up_read().
>
> Finally, since these SRCU-related primitives are now treated as
> ordinary reads and writes, we have to add them into the lists of
> marked accesses (i.e., not subject to data races) and lock-related
> accesses (i.e., one shouldn't try to access an srcu_struct with a
> non-lock-related primitive such as READ_ONCE() or a plain write).
>
> [ paulmck: Fix space-before-tab whitespace nit. ]
>
> TBD-contributions-from: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

Reviewed-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>

>
> ---
>
>   tools/memory-model/linux-kernel.bell |   17 +++++------------
>   tools/memory-model/linux-kernel.def  |    6 ++++--
>   tools/memory-model/lock.cat          |    6 +++---
>   3 files changed, 12 insertions(+), 17 deletions(-)
>
> Index: usb-devel/tools/memory-model/linux-kernel.bell
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.bell
> +++ usb-devel/tools/memory-model/linux-kernel.bell
> @@ -57,20 +57,13 @@ flag ~empty Rcu-lock \ domain(rcu-rscs)
>   flag ~empty Rcu-unlock \ range(rcu-rscs) as unmatched-rcu-unlock
>   
>   (* Compute matching pairs of nested Srcu-lock and Srcu-unlock *)
> -let srcu-rscs = let rec
> -	    unmatched-locks = Srcu-lock \ domain(matched)
> -	and unmatched-unlocks = Srcu-unlock \ range(matched)
> -	and unmatched = unmatched-locks | unmatched-unlocks
> -	and unmatched-po = ([unmatched] ; po ; [unmatched]) & loc
> -	and unmatched-locks-to-unlocks =
> -		([unmatched-locks] ; po ; [unmatched-unlocks]) & loc
> -	and matched = matched | (unmatched-locks-to-unlocks \
> -		(unmatched-po ; unmatched-po))
> -	in matched
> +let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
> +let srcu-rscs = ([Srcu-lock] ; carry-srcu-data ; data ; [Srcu-unlock]) & loc
>   
>   (* Validate nesting *)
>   flag ~empty Srcu-lock \ domain(srcu-rscs) as unmatched-srcu-lock
>   flag ~empty Srcu-unlock \ range(srcu-rscs) as unmatched-srcu-unlock
> +flag ~empty (srcu-rscs^-1 ; srcu-rscs) \ id as multiple-srcu-matches
>   
>   (* Check for use of synchronize_srcu() inside an RCU critical section *)
>   flag ~empty rcu-rscs & (po ; [Sync-srcu] ; po) as invalid-sleep
> @@ -80,11 +73,11 @@ flag ~empty different-values(srcu-rscs)
>   
>   (* Compute marked and plain memory accesses *)
>   let Marked = (~M) | IW | Once | Release | Acquire | domain(rmw) | range(rmw) |
> -		LKR | LKW | UL | LF | RL | RU
> +		LKR | LKW | UL | LF | RL | RU | Srcu-lock | Srcu-unlock
>   let Plain = M \ Marked
>   
>   (* Redefine dependencies to include those carried through plain accesses *)
> -let carry-dep = (data ; rfi)*
> +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
>   let addr = carry-dep ; addr
>   let ctrl = carry-dep ; ctrl
>   let data = carry-dep ; data
> Index: usb-devel/tools/memory-model/linux-kernel.def
> ===================================================================
> --- usb-devel.orig/tools/memory-model/linux-kernel.def
> +++ usb-devel/tools/memory-model/linux-kernel.def
> @@ -49,8 +49,10 @@ synchronize_rcu() { __fence{sync-rcu}; }
>   synchronize_rcu_expedited() { __fence{sync-rcu}; }
>   
>   // SRCU
> -srcu_read_lock(X)  __srcu{srcu-lock}(X)
> -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> +srcu_read_lock(X) __load{srcu-lock}(*X)
> +srcu_read_unlock(X,Y) { __store{srcu-unlock}(*X,Y); }
> +srcu_down_read(X) __load{srcu-lock}(*X)
> +srcu_up_read(X,Y) { __store{srcu-unlock}(*X,Y); }
>   synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
>   synchronize_srcu_expedited(X)  { __srcu{sync-srcu}(X); }
>   
> Index: usb-devel/tools/memory-model/lock.cat
> ===================================================================
> --- usb-devel.orig/tools/memory-model/lock.cat
> +++ usb-devel/tools/memory-model/lock.cat
> @@ -36,9 +36,9 @@ let RU = try RU with emptyset
>   (* Treat RL as a kind of LF: a read with no ordering properties *)
>   let LF = LF | RL
>   
> -(* There should be no ordinary R or W accesses to spinlocks *)
> -let ALL-LOCKS = LKR | LKW | UL | LF | RU
> -flag ~empty [M \ IW] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
> +(* There should be no ordinary R or W accesses to spinlocks or SRCU structs *)
> +let ALL-LOCKS = LKR | LKW | UL | LF | RU | Srcu-lock | Srcu-unlock | Sync-srcu
> +flag ~empty [M \ IW \ ALL-LOCKS] ; loc ; [ALL-LOCKS] as mixed-lock-accesses
>   
>   (* Link Lock-Reads to their RMW-partner Lock-Writes *)
>   let lk-rmw = ([LKR] ; po-loc ; [LKW]) \ (po ; po)

