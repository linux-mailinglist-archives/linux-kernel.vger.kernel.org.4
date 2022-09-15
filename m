Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00E55B9771
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiIOJbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIOJbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:31:02 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B82768E466
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 02:30:59 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx32vN8CJjxAEaAA--.28680S3;
        Thu, 15 Sep 2022 17:30:53 +0800 (CST)
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
 <6bcb4883-03d0-88eb-4c42-84fff0a9a141@loongson.cn>
 <YyLUGnqtZXn4MjJF@casper.infradead.org>
 <54813a74-cc0e-e470-c632-78437a0d0ad4@loongson.cn>
 <YyLpls9/t6LKQefS@casper.infradead.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <8a2f1b2f-baa3-173d-ace1-5c3c9539015b@loongson.cn>
Date:   Thu, 15 Sep 2022 17:30:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <YyLpls9/t6LKQefS@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8Bx32vN8CJjxAEaAA--.28680S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF4UKF45KrW5Kw1UGw4Uurg_yoW7CFWxpF
        1UtFsrKF4kJr4jyr47Kw4vqr109F1DC3W5WFyrGrnruF1jvwn8J3y8Gr4Yk3W3Jr1Uurya
        qrW5Xw12vr17JaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        PpnJUUUUU==
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 2022/9/15 am 5:00, Matthew Wilcox wrote:
> On Thu, Sep 15, 2022 at 04:02:41PM +0800, Hongchen Zhang wrote:
>> Hi Matthew,
>> On 2022/9/15 pm 3:28, Matthew Wilcox wrote:
>>> On Thu, Sep 15, 2022 at 09:19:48AM +0800, Hongchen Zhang wrote:
>>>> [ 3748.453561] INFO: task float_bessel:77920 blocked for more than 120
>>>> seconds.
>>>> [ 3748.460839]       Not tainted 5.15.0-46-generic #49-Ubuntu
>>>> [ 3748.466490] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
>>>> this message.
>>>> [ 3748.474618] task:float_bessel    state:D stack:    0 pid:77920 ppid:
>>>> 77327 flags:0x00004002
>>>> [ 3748.483358] Call Trace:
>>>> [ 3748.485964]  <TASK>
>>>> [ 3748.488150]  __schedule+0x23d/0x590
>>>> [ 3748.491804]  schedule+0x4e/0xc0
>>>> [ 3748.495038]  rwsem_down_read_slowpath+0x336/0x390
>>>> [ 3748.499886]  ? copy_user_enhanced_fast_string+0xe/0x40
>>>> [ 3748.505181]  down_read+0x43/0xa0
>>>> [ 3748.508518]  do_user_addr_fault+0x41c/0x670
>>>> [ 3748.512799]  exc_page_fault+0x77/0x170
>>>> [ 3748.516673]  asm_exc_page_fault+0x26/0x30
>>>> [ 3748.520824] RIP: 0010:copy_user_enhanced_fast_string+0xe/0x40
>>>> [ 3748.526764] Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f
>>>> 01 ca c3 cc cc cc cc 0f 1f 00 0f 01 cb 83 fa 40 0f 82 70 ff ff ff 89 d1 <f3>
>>>> a4 31 c0 0f 01 ca c3 cc cc cc cc 66 08
>>>> [ 3748.546120] RSP: 0018:ffffaa9248fffb90 EFLAGS: 00050206
>>>> [ 3748.551495] RAX: 00007f99faa1a010 RBX: ffffaa9248fffd88 RCX:
>>>> 0000000000000010
>>>> [ 3748.558828] RDX: 0000000000001000 RSI: ffff9db397ab8ff0 RDI:
>>>> 00007f99faa1a000
>>>> [ 3748.566160] RBP: ffffaa9248fffbf0 R08: ffffcc2fc2965d80 R09:
>>>> 0000000000000014
>>>> [ 3748.573492] R10: 0000000000000000 R11: 0000000000000014 R12:
>>>> 0000000000001000
>>>> [ 3748.580858] R13: 0000000000001000 R14: 0000000000000000 R15:
>>>> ffffaa9248fffd98
>>>> [ 3748.588196]  ? copy_page_to_iter+0x10e/0x400
>>>> [ 3748.592614]  filemap_read+0x174/0x3e0
>>>
>>> Interesting; it wasn't the process itself which triggered the page
>>> fault; the process called read() and the kernel took the page fault to
>>> satisfy the read() call.
>>>
>>>> [ 3748.596354]  ? ima_file_check+0x6a/0xa0
>>>> [ 3748.600301]  generic_file_read_iter+0xe5/0x150
>>>> [ 3748.604884]  ext4_file_read_iter+0x5b/0x190
>>>> [ 3748.609164]  ? aa_file_perm+0x102/0x250
>>>> [ 3748.613125]  new_sync_read+0x10d/0x1a0
>>>> [ 3748.617009]  vfs_read+0x103/0x1a0
>>>> [ 3748.620423]  ksys_read+0x67/0xf0
>>>> [ 3748.623743]  __x64_sys_read+0x19/0x20
>>>> [ 3748.627511]  do_syscall_64+0x59/0xc0
>>>> [ 3748.631203]  ? syscall_exit_to_user_mode+0x27/0x50
>>>> [ 3748.636144]  ? do_syscall_64+0x69/0xc0
>>>> [ 3748.639992]  ? exit_to_user_mode_prepare+0x96/0xb0
>>>> [ 3748.644931]  ? irqentry_exit_to_user_mode+0x9/0x20
>>>> [ 3748.649872]  ? irqentry_exit+0x1d/0x30
>>>> [ 3748.653737]  ? exc_page_fault+0x89/0x170
>>>> [ 3748.657795]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
>>>> [ 3748.663030] RIP: 0033:0x7f9a852989cc
>>>> [ 3748.666713] RSP: 002b:00007f9a8497dc90 EFLAGS: 00000246 ORIG_RAX:
>>>> 0000000000000000
>>>> [ 3748.674487] RAX: ffffffffffffffda RBX: 00007f9a8497f5c0 RCX:
>>>> 00007f9a852989cc
>>>> [ 3748.681817] RDX: 0000000000027100 RSI: 00007f99faa18010 RDI:
>>>> 0000000000000061
>>>> [ 3748.689150] RBP: 00007f9a8497dd60 R08: 0000000000000000 R09:
>>>> 00007f99faa18010
>>>> [ 3748.696493] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>> 00007f99faa18010
>>>> [ 3748.703841] R13: 00005605e11c406f R14: 0000000000000001 R15:
>>>> 0000000000027100
>>>
>>> ORIG_RAX is 0, which matches sys_read.
>>> RDI is file descriptor 0x61
>>> RSI is plausibly a userspace pointer, 0x7f99faa18010
>>> RDX is the length, 0x27100 or 160kB.
>>>
>>> That all seems reasonable.
>>>
>>> What I really want to know is who is _holding_ the lock.  We stash
>>> a pointer to the task_struct in 'owner', so we could clearly find this
>>> out in the 'blocked for too long' report, and print their stack trace.
>>>
>> As described in the comment for __rwsem_set_reader_owned,it is hard to track
>> read owners.So we could not clearly find out who blocked the process,it was
>> caused by multiple tasks.
> 
> Readers don't block readers.  You have a reader here, so it's being
> blocked by a writer.  And that writer's task_struct is stashed in
> rwsem->owner.  It would be nice if we dumped that information
> automatically ... but we don't do that today.  Perhaps you could
> grab that information from a crash dump if you have one.
> 
>>> You must have done something like this already in order to deduce that
>>> it was the direct reclaim path that was the problem?
>>>
>> The method we used is to track the direct reclaim using the
>> trace_mm_vmscan_direct_reclaim_{begin,end} interface.When the problem
>> occurred,we could get a very large "nr_reclaimed" which is not a desirable
>> value for process except kswapd.
> 
> I disagree.  If a process needs to allocate memory then it should be
> paying the cost of reclaiming that memory itself.  kswapd is a last
> resort to reclaim memory when we have a workload (eg a network router)
> that does its memory allocation primarily in interrupt context.
> 
Yes,the process would reclaim required memory itself.But it should not 
do scan adjust too much,scan adjust is not its primary work.The scan 
adjust should be done by kswapd.

Thanks
Hongchen Zhang

