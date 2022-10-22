Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4ED608C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJVLBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJVLBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:01:08 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9119011803
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 03:19:26 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 29MAJ98D025819;
        Sat, 22 Oct 2022 19:19:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Sat, 22 Oct 2022 19:19:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 29MAJ9D5025816
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 22 Oct 2022 19:19:09 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e24b949d-3596-b634-9332-35fa2bd8c50e@I-love.SAKURA.ne.jp>
Date:   Sat, 22 Oct 2022 19:19:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in
 break_ksm
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        syzbot <syzbot+78a0878b3076f71313b3@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
References: <0000000000000f3fec05eb76e68f@google.com>
 <c2cf3416-f762-3949-d97c-47dbbc2c6689@redhat.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <c2cf3416-f762-3949-d97c-47dbbc2c6689@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/20 22:40, David Hildenbrand wrote:
> This might be due a missing page table lock unlock:
> 
> https://lkml.kernel.org/r/8c86678a-3bfb-3854-b1a9-ae5969e730b8@redhat.com
> 

Yes. Already fixed by commit b232a629b70cccb65d0c in linux-next-20221021.

#syz fix: mm/ksm: convert break_ksm() to use walk_page_range_vma()

[   72.213837] BUG: sleeping function called from invalid context at mm/ksm.c:500
[   72.216580] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 874, name: a.out
[   72.218083] preempt_count: 1, expected: 0
[   72.219161] RCU nest depth: 0, expected: 0
[   72.220245] Preemption disabled at:
[   72.220253] [<ffffffff95804158>] break_ksm_pmd_entry+0xf8/0x290
[   72.223460] 
[   72.223619] ============================================
[   72.224514] WARNING: possible recursive locking detected
[   72.225491] 6.1.0-rc1-next-20221021+ #2 Tainted: G        W         
[   72.226750] --------------------------------------------
[   72.227724] a.out/874 is trying to acquire lock:
[   72.228588] ffff94fdc6756888 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: break_ksm_pmd_entry+0xf8/0x290
[   72.230229] 
[   72.230229] but task is already holding lock:
[   72.231321] ffff94fdc6756888 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: break_ksm_pmd_entry+0xf8/0x290
[   72.232975] 
[   72.232975] other info that might help us debug this:
[   72.234233]  Possible unsafe locking scenario:
[   72.234233] 
[   72.235256]        CPU0
[   72.235758]        ----
[   72.236231]   lock(ptlock_ptr(page)#2);
[   72.237118]   lock(ptlock_ptr(page)#2);
[   72.237808] 
[   72.237808]  *** DEADLOCK ***
[   72.237808] 
[   72.239045]  May be due to missing lock nesting notation
[   72.239045] 
[   72.241781] 6 locks held by a.out/874:
[   72.243135]  #0: ffff94fdc6345490 (sb_writers#6){.+.+}-{0:0}, at: ksys_write+0x70/0x100
[   72.245232]  #1: ffff94fdc5f75c90 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x11e/0x230
[   72.247591]  #2: ffff94fdc0c6bdc8 (kn->active#83){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x126/0x230
[   72.250739]  #3: ffffffff96ec7d10 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0x59/0x390
[   72.253067]  #4: ffff94fdc47f8ff0 (&mm->mmap_lock#2){++++}-{3:3}, at: run_store+0x142/0x390
[   72.255283]  #5: ffff94fdc6756888 (ptlock_ptr(page)#2){+.+.}-{2:2}, at: break_ksm_pmd_entry+0xf8/0x290
[   72.258262] 
[   72.258262] stack backtrace:
[   72.260362] CPU: 2 PID: 874 Comm: a.out Tainted: G        W          6.1.0-rc1-next-20221021+ #2
[   72.262633] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[   72.264773] Call Trace:
[   72.265911]  <TASK>
[   72.267006]  dump_stack_lvl+0x5a/0x88
[   72.268401]  find_cpio_data.cold-0x6/0x5b
[   72.269836]  __lock_acquire.cold+0xae/0x2dc
[   72.271327]  ? lock_is_held_type+0xf3/0x160
[   72.272764]  lock_acquire+0xd6/0x320
[   72.274075]  ? break_ksm_pmd_entry+0xf8/0x290
[   72.275619]  ? __wake_up_klogd.part.0+0x64/0xb0
[   72.277104]  ? vprintk_emit+0xd0/0x360
[   72.278437]  ? __memcpy-0xd/0x30
[   72.279646]  _raw_spin_lock+0x39/0x90
[   72.280894]  ? break_ksm_pmd_entry+0xf8/0x290
[   72.282329]  break_ksm_pmd_entry+0xf8/0x290
[   72.283761]  walk_pgd_range+0x623/0xa90
[   72.285092]  ? lockdep_hardirqs_on+0x86/0x120
[   72.286563]  __walk_page_range+0x17b/0x190
[   72.287985]  ? lock_is_held_type+0xf3/0x160
[   72.289336]  walk_page_range_vma+0xae/0xf0
[   72.290643]  break_ksm.part.0+0x7d/0xe0
[   72.292001]  unmerge_ksm_pages+0x77/0xd0
[   72.293321]  run_store+0x187/0x390
[   72.294540]  kobj_attr_store+0x12/0x40
[   72.295817]  sysfs_kf_write+0x4b/0x80
[   72.297035]  kernfs_fop_write_iter+0x171/0x230
[   72.298373]  vfs_write+0x357/0x530
[   72.299616]  ksys_write+0x70/0x100
[   72.300758]  __x64_sys_write+0x19/0x30
[   72.301947]  do_syscall_64+0x5c/0xa0
[   72.303155]  ? syscall_exit_to_user_mode+0x37/0x60
[   72.304590]  ? do_syscall_64+0x69/0xa0
[   72.305721]  ? irqentry_exit+0x6b/0xa0
[   72.306877]  ? __memcpy-0xd/0x30
[   72.307919]  ? lockdep_hardirqs_on+0x86/0x120
[   72.309143]  ? irqentry_exit_to_user_mode+0x25/0x40
[   72.310548]  ? irqentry_exit+0x6b/0xa0
[   72.311637]  ? exc_page_fault+0xa8/0x310
[   72.312755]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   72.314108] RIP: 0033:0x7fe2ca91ea3d
[   72.315121] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 a3 0f 00 f7 d8 64 89 01 48
[   72.319924] RSP: 002b:00007ffdb4131158 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   72.321870] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe2ca91ea3d
[   72.323727] RDX: 0000000000000002 RSI: 0000000020000000 RDI: 0000000000000003
[   72.325523] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[   72.327431] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdb4131278
[   72.329256] R13: 00005648601cc060 R14: 00005648601cedc0 R15: 00007fe2cab74040
[   72.331140]  </TASK>

