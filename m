Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE5063DBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiK3RUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiK3RUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:20:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 308133B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:20:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B640D6E;
        Wed, 30 Nov 2022 09:20:41 -0800 (PST)
Received: from [10.34.100.128] (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4679C3F73B;
        Wed, 30 Nov 2022 09:20:33 -0800 (PST)
Message-ID: <207c79df-79e8-e6c9-d042-b69dea87a355@arm.com>
Date:   Wed, 30 Nov 2022 18:20:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Crash with PREEMPT_RT on aarch64 machine
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Jan Kara <jack@suse.cz>
Cc:     Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20221103115444.m2rjglbkubydidts@quack3>
 <Y2U+Je+LICO2HkNY@linutronix.de> <20221107135636.biouna36osqc4rik@quack3>
 <Y2kf6tcX47Cl7q0W@linutronix.de>
 <359cc93a-fce0-5af2-0fd5-81999fad186b@redhat.com>
 <20221109125756.GA24388@willie-the-truck>
 <20221109154023.cx2d4y3e7zqnuo35@quack3>
 <20221111142742.rh677sdwu55aeeno@quack3>
 <20221114124147.GA30263@willie-the-truck> <Y4Tapja2qq8HiHBZ@linutronix.de>
From:   Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <Y4Tapja2qq8HiHBZ@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/28/22 16:58, Sebastian Andrzej Siewior wrote:
> How about this?
> 
> - The fast path is easy…
> 
> - The slow path first sets the WAITER bits (mark_rt_mutex_waiters()) so
>    I made that one _acquire so that it is visible by the unlocker forcing
>    everyone into slow path.
> 
> - If the lock is acquired, then the owner is written via
>    rt_mutex_set_owner(). This happens under wait_lock so it is
>    serialized and so a WRITE_ONCE() is used to write the final owner. I
>    replaced it with a cmpxchg_acquire() to have the owner there.
>    Not sure if I shouldn't make this as you put it:
> |   e.g. by making use of dependency ordering where it already exists.
>    The other (locking) CPU needs to see the owner not only the WAITER
>    bit. I'm not sure if this could be replaced with smp_store_release().
> 
> - After the whole operation completes, fixup_rt_mutex_waiters() cleans
>    the WAITER bit and I kept the _acquire semantic here. Now looking at
>    it again, I don't think that needs to be done since that shouldn't be
>    set here.
> 
> - There is rtmutex_spin_on_owner() which (as the name implies) spins on
>    the owner as long as it active. It obtains it via READ_ONCE() and I'm
>    not sure if any memory barrier is needed. Worst case is that it will
>    spin while owner isn't set if it observers a stale value.
> 
> - The unlock path first clears the waiter bit if there are no waiters
>    recorded (via simple assignments under the wait_lock (every locker
>    will fail with the cmpxchg_acquire() and go for the wait_lock)) and
>    then finally drop it via rt_mutex_cmpxchg_release(,, NULL).
>    Should there be a wait, it will just store the WAITER bit with
>    smp_store_release() (setting the owner is NULL but the WAITER bit
>    forces everyone into the slow path).
> 
> - Added rt_mutex_set_owner_pi() which does simple assignment. This is
>    used from the futex code and here everything happens under a lock.
> 
> - I added a smp_load_acquire() to rt_mutex_base_is_locked() since I
>    *think* want to observe a real waiter and not something stale.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>


Hello,
Just to share some debug attempts, I tried Sebastian's patch and could not
reproduce the error. While trying to understand the solution, I could not
reproduce the error if I only took the changes made to
mark_rt_mutex_waiters(), or to rt_mutex_set_owner_pi(). I am not sure I
understand why this would be a rt-mutex issue.

Without Sebastian's patch, to try adding some synchronization around the
'i_wb_list', I did the following:

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 443f83382b9b..42ce1f7f8aef 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1271,10 +1271,10 @@ void sb_clear_inode_writeback(struct inode *inode)
         struct super_block *sb = inode->i_sb;
         unsigned long flags;
  
-       if (!list_empty(&inode->i_wb_list)) {
+       if (!list_empty_careful(&inode->i_wb_list)) {
                 spin_lock_irqsave(&sb->s_inode_wblist_lock, flags);
-               if (!list_empty(&inode->i_wb_list)) {
-                       list_del_init(&inode->i_wb_list);
+               if (!list_empty_careful(&inode->i_wb_list)) {
+                       list_del_init_careful(&inode->i_wb_list);
                         trace_sb_clear_inode_writeback(inode);
                 }
                 spin_unlock_irqrestore(&sb->s_inode_wblist_lock, flags);
diff --git a/fs/inode.c b/fs/inode.c
index b608528efd3a..fbe6b4fe5831 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -621,7 +621,7 @@ void clear_inode(struct inode *inode)
         BUG_ON(!list_empty(&inode->i_data.private_list));
         BUG_ON(!(inode->i_state & I_FREEING));
         BUG_ON(inode->i_state & I_CLEAR);
-       BUG_ON(!list_empty(&inode->i_wb_list));
+       BUG_ON(!list_empty_careful(&inode->i_wb_list));
         /* don't need i_lock here, no concurrent mods to i_state */
         inode->i_state = I_FREEING | I_CLEAR;
  }

I never stepped on the:
   BUG_ON(!list_empty_careful(&inode->i_wb_list))
statement again, but got the dump at [2]. I also regularly end-up
with the following endless logs when trying other things, when rebooting:

EXT4-fs (nvme0n1p3): sb orphan head is 2840597
sb_info orphan list:
   inode nvme0n1p3:3958579 at 00000000b5934dff: mode 100664, nlink 1, next 0
   inode nvme0n1p3:3958579 at 00000000b5934dff: mode 100664, nlink 1, next 0
   ...

Also, Jan said that the issue was reproducible on 'two different aarch64
machines', cf [1]. Would it be possible to know which one ?

Regards,
Pierre

[1]
https://lore.kernel.org/all/20221103115444.m2rjglbkubydidts@quack3/

[2]
EXT4-fs (nvme0n1p3): Inode 2834153 (0000000051c7b29b): orphan list check failed!
0000000051c7b29b: 0000f30a 00000004 00000000 00000000  ................
00000000a0792dde: 00000000 00000000 00000000 00000000  ................
0000000065a25e3d: 00000000 00000000 00000000 00000000  ................
00000000b2085d6d: 00000000 00000000 00000000 002b3fe8  .............?+.
0000000088f2c42f: 00000000 00000000 00000159 00000000  ........Y.......
00000000b9d22813: 00080000 00000040 80000000 00000000  ....@...........
0000000004f93ec7: 00000000 00000000 00000000 00000000  ................
00000000d8e00df6: 00000000 00000000 00000000 00000000  ................
00000000d29047af: ba813320 ffff07ff 0d822240 ffff4001   3......@"...@..
00000000e9708e5a: 0d822250 ffff4001 0d822250 ffff4001  P"...@..P"...@..
000000001f08ff8a: 0d822260 ffff4001 0d822260 ffff4001  `"...@..`"...@..
000000003231aba6: 00000000 00000000 00000000 00000000  ................
00000000df5b63ba: 00000000 00000000 00000000 00000000  ................
00000000367f58f3: 00000000 00000000 00000000 00000000  ................
000000008a1af872: 0d8222a0 ffff4001 0d8222a0 ffff4001  ."...@..."...@..
000000002a8dc95e: 00000000 00000000 00000000 00000000  ................
00000000e4c5bdb4: 00000000 00000000 00000000 00000000  ................
000000004f0a738d: 00000000 00000000 80000000 00000000  ................
0000000082a9e5b2: 00000000 00000000 00000000 00000000  ................
0000000064dce462: 00000000 00000000 00000000 00000000  ................
00000000fe106bb0: 000d8180 000040ab 000040ab 00000000  .....@...@......
00000000946bcd55: 00000000 00000000 00000000 00000000  ................
000000001d64e9fd: c1390a80 ffffdab5 87d6c800 ffff07ff  ..9.............
000000002afa83ff: 0d822488 ffff4001 54d25060 ffff4002  .$...@..`P.T.@..
0000000075bfe8c6: 002b3ee9 00000000 00000000 00000000  .>+.............
00000000580feb22: 00000000 00000000 63877e76 00000000  ........v~.c....
00000000cca606aa: 010d8f0e 00000000 63877e76 00000000  ........v~.c....
00000000d446eaef: 010d8f0e 00000000 63877e76 00000000  ........v~.c....
0000000072243536: 010d8f0e 00000000 00000000 00000000  ................
000000007cbeccb9: 00000000 00000000 00000000 00000000  ................
0000000026d5ad72: 00000000 00000000 000c0000 00000000  ................
00000000e28ac20a: 00000000 00000000 00000060 00000000  ........`.......
0000000076ed32fb: 80000000 00000000 00000000 00000000  ................
00000000cd183175: 00000000 00000000 00000000 00000000  ................
00000000ecafc825: 00000000 00000000 00000000 00000000  ................
00000000408fde6f: 00000000 00000000 00000000 00000000  ................
000000004d7c3704: 00000000 00000000 0d822408 ffff4001  .........$...@..
000000007a24c141: 0d822408 ffff4001 0d822418 ffff4001  .$...@...$...@..
000000007ce51788: 0d822418 ffff4001 0d822428 ffff4001  .$...@..($...@..
00000000efd9c162: 0d822428 ffff4001 0d822438 ffff4001  ($...@..8$...@..
0000000013f0626e: 0d822438 ffff4001 00000000 00000000  8$...@..........
00000000e8fc5904: 00000000 00000000 00000002 00000000  ................
000000006533e04b: 00000000 00000000 00000000 00000000  ................
000000009a33c9d5: 00000000 00000000 c1390b40 ffffdab5  ........@.9.....
00000000b743e93e: 00000000 00000000 0d822300 ffff4001  .........#...@..
0000000041c5a701: 00000000 00000000 00000000 00000000  ................
000000009f872e56: 00000000 00000000 00000000 00000000  ................
00000000f6ca0703: 00000021 00000000 00000000 00000000  !...............
00000000e79eacb9: 80000000 00000000 00000000 00000000  ................
000000003afb3989: 00000000 00000000 00000000 00000000  ................
00000000164436d4: 00000000 00000000 00100cca 00000000  ................
00000000d63a3021: 00000000 00000000 00000000 00000000  ................
00000000e0e1ace3: 80000000 00000000 00000000 00000000  ................
0000000043ac9c19: 00000000 00000000 00000000 00000000  ................
00000000f3870564: 00000000 00000000 00000000 00000000  ................
0000000082c87bf9: 00000000 00000000 c1391310 ffffdab5  ..........9.....
00000000f5524c75: 00000010 00000000 00000000 00000000  ................
00000000dfda4192: 00000000 00000000 00000000 00000000  ................
00000000863650dd: 00000000 00000000 00000000 00000000  ................
00000000b709ac61: 0d822570 ffff4001 0d822570 ffff4001  p%...@..p%...@..
000000009f316d71: 00000000 00000000 0d822588 ffff4001  .........%...@..
00000000f15fb4ed: 0d822588 ffff4001 00000000 00000000  .%...@..........
000000000027077a: 6401ffec 00000000 00000000 00000000  ...d............
00000000c828fe47: 00000000 00000000 00000000 00000000  ................
00000000b5f575af: 00000000 00000000 00000000 00000000  ................
000000001466bf98: 00000000 00000000 00000000 00000000  ................
0000000097025855: 00000000 00000000 00000000 00000000  ................
000000002557bcf0: 63877e76 00000000 010d8f0e 00000000  v~.c............
00000000b128f3c5: 00000000 00000000 0d822608 ffff4001  .........&...@..
000000005b473b40: 0d822608 ffff4001 00000000 00000000  .&...@..........
000000000913f445: 00000000 00000000 00000000 00000000  ................
000000003023853f: 00000000 00000000 00000000 00000000  ................
0000000025fcdffb: 00000000 00000000 80000000 00000000  ................
00000000334c5dc4: 00000000 00000000 00000000 00000000  ................
00000000f1ada795: 00000000 00000000 00000000 00000000  ................
0000000030e27dd3: 00000000 00000000 0d822678 ffff4001  ........x&...@..
0000000033a6a483: 0d822678 ffff4001 00000000 00000000  x&...@..........
00000000eb614a98: 00000000 ffffffff 00000000 00000000  ................
00000000df74e25f: 00000000 00000000 00000020 00000000  ........ .......
00000000efcf717a: 00000000 00000000 00000000 00000000  ................
00000000f84ffeba: 00000000 00000000 00000000 00000000  ................
00000000651071c7: 00000000 00000000 0d8226d8 ffff4001  .........&...@..
00000000a748241c: 0d8226d8 ffff4001 ffffffe0 0000000f  .&...@..........
000000004c1557b3: 0d8226f0 ffff4001 0d8226f0 ffff4001  .&...@...&...@..
00000000dccbb716: c08cf6b0 ffffdab5 00000000 00000000  ................
000000009d2fb057: 00000000 00000000 00000000 00000000  ................
00000000f6f284e6: 00000000 00000000 00000000 00000000  ................
000000003bb74f4c: 00414087 00414087 00000000 00000000  .@A..@A.........
00000000e0601ec8: 00000000 00000000 00000000 00000000  ................
000000006a017bfb: cef69528 00000000                    (.......
CPU: 125 PID: 3898 Comm: dbench Not tainted 6.0.5-rt14-[...]
Hardware name: WIWYNN Mt.Jade Server System B81.03001.0005/Mt.Jade Motherboard, BIOS 1.08.20220218 (SCP: 1.08.20220218) 2022/02/18
Call trace:
  [...]
  ext4_destroy_inode+0xc8/0xd0
  destroy_inode+0x48/0x80
  evict+0x148/0x190
  iput+0x184/0x250
  do_unlinkat+0x1d8/0x290
  __arm64_sys_unlinkat+0x48/0x90
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0x54/0x194
  do_el0_svc+0x38/0xd0
  el0_svc+0x34/0x160
  el0t_64_sync_handler+0xbc/0x13c
  el0t_64_sync+0x1a0/0x1a4
