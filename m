Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A41068E353
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjBGWRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:17:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBGWR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:17:28 -0500
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A84223336
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:17:25 -0800 (PST)
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 317MHNiv001394;
        Wed, 8 Feb 2023 07:17:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Wed, 08 Feb 2023 07:17:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 317MHNQl001391
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 8 Feb 2023 07:17:23 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a67e24eb-b68f-2abc-50af-ae4c2d4cdd95@I-love.SAKURA.ne.jp>
Date:   Wed, 8 Feb 2023 07:17:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Converting dev->mutex into dev->spinlock ?
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>
References: <Y957GSFVAQz8v3Xo@rowland.harvard.edu>
 <cf56ebc3-187a-6ee4-26bc-2d180272b5cf@I-love.SAKURA.ne.jp>
 <Y96HiYcreb8jZIHi@rowland.harvard.edu>
 <917e1e3b-094f-e594-c1a2-8b97fb5195fd@I-love.SAKURA.ne.jp>
 <Y965qEg0Re2QoQ7Q@rowland.harvard.edu>
 <CAHk-=wjoy=hObTmyRb9ttApjndt0LfqAfv71Cz+hEGrT0cLN+A@mail.gmail.com>
 <Y98FLlr7jkiFlV0k@rowland.harvard.edu>
 <827177aa-bb64-87a9-e1af-dfe070744045@I-love.SAKURA.ne.jp>
 <Y+Egr4MmqlE6G+mr@rowland.harvard.edu>
 <a7d0e143-1e68-5531-5c2e-1f853d794bc0@I-love.SAKURA.ne.jp>
 <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <Y+KOeJlvQMYAaheZ@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/02/08 2:46, Alan Stern wrote:
> The real question is what will happen in your syzbot test scenarios.  
> Lockdep certainly ought to be able to detect a real deadlock when one 
> occurs.  It will be more interesting to find out if it can warn about 
> potential deadlocks _without_ them occurring.

For example, https://syzkaller.appspot.com/x/repro.c?x=15556074480000 generates
below warning, but I don't have syzbot environment. Please propose an updated
patch (which won't hit WARN_ON_ONCE()) for allowing people to try it in syzbot
environment.

----------
[  122.946483][ T3692] 
[  122.979855][ T3692] ======================================================
[  122.984206][ T3692] WARNING: possible circular locking dependency detected
[  122.986920][ T3692] 6.2.0-rc7-00011-g05ecb680708a-dirty #943 Tainted: G        W         
[  122.989918][ T3692] ------------------------------------------------------
[  122.993357][ T3692] a.out/3692 is trying to acquire lock:
[  122.995732][ T3692] ffff888128168900 (&dev->mutex_key#165){+.+.}-{3:3}, at: nfc_dev_down+0x26/0x120
[  123.008266][ T3692] 
[  123.008266][ T3692] but task is already holding lock:
[  123.010995][ T3692] ffffffff85a09040 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x10e/0x360
[  123.020389][ T3692] 
[  123.020389][ T3692] which lock already depends on the new lock.
[  123.020389][ T3692] 
[  123.029714][ T3692] 
[  123.029714][ T3692] the existing dependency chain (in reverse order) is:
[  123.033255][ T3692] 
[  123.033255][ T3692] -> #1 (rfkill_global_mutex){+.+.}-{3:3}:
[  123.037794][ T3692]        __mutex_lock_common+0xe6/0xea0
[  123.040845][ T3692]        mutex_lock_nested+0x1b/0x20
[  123.043990][ T3692]        rfkill_register+0x25/0x3d0
[  123.046100][ T3692]        nfc_register_device+0xd9/0x200
[  123.048369][ T3692]        nfcsim_device_new+0x146/0x2c0
[  123.077246][ T3692]        nfcsim_init+0x71/0x130
[  123.079456][ T3692]        do_one_initcall+0xab/0x200
[  123.081584][ T3692]        do_initcall_level+0xd7/0x1c0
[  123.084613][ T3692]        do_initcalls+0x3f/0x80
[  123.087020][ T3692]        kernel_init_freeable+0x230/0x2e0
[  123.089388][ T3692]        kernel_init+0x1b/0x290
[  123.091567][ T3692]        ret_from_fork+0x1f/0x30
[  123.094393][ T3692] 
[  123.094393][ T3692] -> #0 (&dev->mutex_key#165){+.+.}-{3:3}:
[  123.097522][ T3692]        __lock_acquire+0x170d/0x33c0
[  123.100739][ T3692]        lock_acquire+0xd3/0x200
[  123.103840][ T3692]        __mutex_lock_common+0xe6/0xea0
[  123.106366][ T3692]        mutex_lock_nested+0x1b/0x20
[  123.108942][ T3692]        nfc_dev_down+0x26/0x120
[  123.111542][ T3692]        nfc_rfkill_set_block+0x26/0x80
[  123.114113][ T3692]        rfkill_set_block+0xa1/0x1e0
[  123.116739][ T3692]        rfkill_fop_write+0x2e9/0x360
[  123.148674][ T3692]        vfs_write+0x187/0x4d0
[  123.151862][ T3692]        ksys_write+0xc6/0x170
[  123.156763][ T3692]        do_syscall_64+0x41/0x90
[  123.161519][ T3692]        entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  123.171373][ T3692] 
[  123.171373][ T3692] other info that might help us debug this:
[  123.171373][ T3692] 
[  123.179398][ T3692]  Possible unsafe locking scenario:
[  123.179398][ T3692] 
[  123.183031][ T3692]        CPU0                    CPU1
[  123.188115][ T3692]        ----                    ----
[  123.190123][ T3692]   lock(rfkill_global_mutex);
[  123.192104][ T3692]                                lock(&dev->mutex_key#165);
[  123.200840][ T3692]                                lock(rfkill_global_mutex);
[  123.207386][ T3692]   lock(&dev->mutex_key#165);
[  123.241397][ T3692] 
[  123.241397][ T3692]  *** DEADLOCK ***
[  123.241397][ T3692] 
[  123.245893][ T3692] 1 lock held by a.out/3692:
[  123.250422][ T3692]  #0: ffffffff85a09040 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x10e/0x360
[  123.256266][ T3692] 
[  123.256266][ T3692] stack backtrace:
[  123.258802][ T3692] CPU: 0 PID: 3692 Comm: a.out Tainted: G        W          6.2.0-rc7-00011-g05ecb680708a-dirty #943
[  123.276931][ T3692] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  123.280352][ T3692] Call Trace:
[  123.310882][ T3692]  <TASK>
[  123.312232][ T3692]  dump_stack_lvl+0xfe/0x190
[  123.314278][ T3692]  check_noncircular+0x12e/0x140
[  123.317038][ T3692]  __lock_acquire+0x170d/0x33c0
[  123.320079][ T3692]  ? __lock_acquire+0x65f/0x33c0
[  123.321887][ T3692]  ? __lock_acquire+0x65f/0x33c0
[  123.325643][ T3692]  lock_acquire+0xd3/0x200
[  123.327611][ T3692]  ? nfc_dev_down+0x26/0x120
[  123.331732][ T3692]  ? nfc_dev_down+0x26/0x120
[  123.335510][ T3692]  ? nfc_dev_down+0x26/0x120
[  123.337961][ T3692]  __mutex_lock_common+0xe6/0xea0
[  123.340214][ T3692]  ? nfc_dev_down+0x26/0x120
[  123.347330][ T3692]  ? nfc_dev_down+0x26/0x120
[  123.352194][ T3692]  mutex_lock_nested+0x1b/0x20
[  123.356877][ T3692]  nfc_dev_down+0x26/0x120
[  123.361856][ T3692]  nfc_rfkill_set_block+0x26/0x80
[  123.378236][ T3692]  rfkill_set_block+0xa1/0x1e0
[  123.379954][ T3692]  rfkill_fop_write+0x2e9/0x360
[  123.381693][ T3692]  ? rfkill_fop_read+0x2a0/0x2a0
[  123.406421][ T3692]  vfs_write+0x187/0x4d0
[  123.408119][ T3692]  ? do_user_addr_fault+0x6e1/0x9c0
[  123.410174][ T3692]  ksys_write+0xc6/0x170
[  123.411856][ T3692]  do_syscall_64+0x41/0x90
[  123.426593][ T3692]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[  123.429725][ T3692] RIP: 0033:0x7fbea991ea3d
[  123.431577][ T3692] Code: 5b 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c3 a3 0f 00 f7 d8 64 89 01 48
[  123.461942][ T3692] RSP: 002b:00007ffc8e2f63a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  123.468363][ T3692] RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007fbea991ea3d
[  123.480268][ T3692] RDX: 0000000000000008 RSI: 0000000020000080 RDI: 0000000000000004
[  123.487754][ T3692] RBP: 0000000000000000 R08: 0000000000000060 R09: 0000000000000060
[  123.491003][ T3692] R10: 0000000000000060 R11: 0000000000000246 R12: 00007ffc8e2f6538
[  123.550555][ T3692] R13: 000055cea974c2e0 R14: 00007ffc8e2f63d0 R15: 00007ffc8e2f63c0
[  123.555519][ T3692]  </TASK>
----------

