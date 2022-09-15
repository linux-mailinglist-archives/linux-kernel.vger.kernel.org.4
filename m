Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2905B95E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiIOIDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiIOICx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:02:53 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14BFD844D1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:02:51 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxT+Ah3CJjZO0ZAA--.35413S3;
        Thu, 15 Sep 2022 16:02:41 +0800 (CST)
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
 <6bcb4883-03d0-88eb-4c42-84fff0a9a141@loongson.cn>
 <YyLUGnqtZXn4MjJF@casper.infradead.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <54813a74-cc0e-e470-c632-78437a0d0ad4@loongson.cn>
Date:   Thu, 15 Sep 2022 16:02:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YyLUGnqtZXn4MjJF@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxT+Ah3CJjZO0ZAA--.35413S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4ftw1kXw4xAFyUJr18Xwb_yoWrZF1DpF
        17tFsxGFs5JrWjvr47Kr4Fqr1UuF4DC3W5uFy8Gr17uF1UZwn5J3y8Jr45KF13Jr13u34a
        qry5Xw10yr1UWaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        PpnJUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,
On 2022/9/15 pm 3:28, Matthew Wilcox wrote:
> On Thu, Sep 15, 2022 at 09:19:48AM +0800, Hongchen Zhang wrote:
>> [ 3748.453561] INFO: task float_bessel:77920 blocked for more than 120
>> seconds.
>> [ 3748.460839]       Not tainted 5.15.0-46-generic #49-Ubuntu
>> [ 3748.466490] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>> this message.
>> [ 3748.474618] task:float_bessel    state:D stack:    0 pid:77920 ppid:
>> 77327 flags:0x00004002
>> [ 3748.483358] Call Trace:
>> [ 3748.485964]  <TASK>
>> [ 3748.488150]  __schedule+0x23d/0x590
>> [ 3748.491804]  schedule+0x4e/0xc0
>> [ 3748.495038]  rwsem_down_read_slowpath+0x336/0x390
>> [ 3748.499886]  ? copy_user_enhanced_fast_string+0xe/0x40
>> [ 3748.505181]  down_read+0x43/0xa0
>> [ 3748.508518]  do_user_addr_fault+0x41c/0x670
>> [ 3748.512799]  exc_page_fault+0x77/0x170
>> [ 3748.516673]  asm_exc_page_fault+0x26/0x30
>> [ 3748.520824] RIP: 0010:copy_user_enhanced_fast_string+0xe/0x40
>> [ 3748.526764] Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f
>> 01 ca c3 cc cc cc cc 0f 1f 00 0f 01 cb 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3>
>> a4 31 c0 0f 01 ca c3 cc cc cc cc 66 08
>> [ 3748.546120] RSP: 0018:ffffaa9248fffb90 EFLAGS: 00050206
>> [ 3748.551495] RAX: 00007f99faa1a010 RBX: ffffaa9248fffd88 RCX:
>> 0000000000000010
>> [ 3748.558828] RDX: 0000000000001000 RSI: ffff9db397ab8ff0 RDI:
>> 00007f99faa1a000
>> [ 3748.566160] RBP: ffffaa9248fffbf0 R08: ffffcc2fc2965d80 R09:
>> 0000000000000014
>> [ 3748.573492] R10: 0000000000000000 R11: 0000000000000014 R12:
>> 0000000000001000
>> [ 3748.580858] R13: 0000000000001000 R14: 0000000000000000 R15:
>> ffffaa9248fffd98
>> [ 3748.588196]  ? copy_page_to_iter+0x10e/0x400
>> [ 3748.592614]  filemap_read+0x174/0x3e0
> 
> Interesting; it wasn't the process itself which triggered the page
> fault; the process called read() and the kernel took the page fault to
> satisfy the read() call.
> 
>> [ 3748.596354]  ? ima_file_check+0x6a/0xa0
>> [ 3748.600301]  generic_file_read_iter+0xe5/0x150
>> [ 3748.604884]  ext4_file_read_iter+0x5b/0x190
>> [ 3748.609164]  ? aa_file_perm+0x102/0x250
>> [ 3748.613125]  new_sync_read+0x10d/0x1a0
>> [ 3748.617009]  vfs_read+0x103/0x1a0
>> [ 3748.620423]  ksys_read+0x67/0xf0
>> [ 3748.623743]  __x64_sys_read+0x19/0x20
>> [ 3748.627511]  do_syscall_64+0x59/0xc0
>> [ 3748.631203]  ? syscall_exit_to_user_mode+0x27/0x50
>> [ 3748.636144]  ? do_syscall_64+0x69/0xc0
>> [ 3748.639992]  ? exit_to_user_mode_prepare+0x96/0xb0
>> [ 3748.644931]  ? irqentry_exit_to_user_mode+0x9/0x20
>> [ 3748.649872]  ? irqentry_exit+0x1d/0x30
>> [ 3748.653737]  ? exc_page_fault+0x89/0x170
>> [ 3748.657795]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
>> [ 3748.663030] RIP: 0033:0x7f9a852989cc
>> [ 3748.666713] RSP: 002b:00007f9a8497dc90 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000000
>> [ 3748.674487] RAX: ffffffffffffffda RBX: 00007f9a8497f5c0 RCX:
>> 00007f9a852989cc
>> [ 3748.681817] RDX: 0000000000027100 RSI: 00007f99faa18010 RDI:
>> 0000000000000061
>> [ 3748.689150] RBP: 00007f9a8497dd60 R08: 0000000000000000 R09:
>> 00007f99faa18010
>> [ 3748.696493] R10: 0000000000000000 R11: 0000000000000246 R12:
>> 00007f99faa18010
>> [ 3748.703841] R13: 00005605e11c406f R14: 0000000000000001 R15:
>> 0000000000027100
> 
> ORIG_RAX is 0, which matches sys_read.
> RDI is file descriptor 0x61
> RSI is plausibly a userspace pointer, 0x7f99faa18010
> RDX is the length, 0x27100 or 160kB.
> 
> That all seems reasonable.
> 
> What I really want to know is who is _holding_ the lock.  We stash
> a pointer to the task_struct in 'owner', so we could clearly find this
> out in the 'blocked for too long' report, and print their stack trace.
> 
As described in the comment for __rwsem_set_reader_owned,it is hard to 
track read owners.So we could not clearly find out who blocked the 
process,it was caused by multiple tasks.
> You must have done something like this already in order to deduce that
> it was the direct reclaim path that was the problem?
> 
The method we used is to track the direct reclaim using the 
trace_mm_vmscan_direct_reclaim_{begin,end} interface.When the problem 
occurred,we could get a very large "nr_reclaimed" which is not a 
desirable value for process except kswapd.

Thanks
Hongchen Zhang

