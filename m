Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E282C5B9215
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIOBUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiIOBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:20:01 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53E9715732
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 18:19:57 -0700 (PDT)
Received: from [10.180.13.185] (unknown [10.180.13.185])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWu1fSJj0p0ZAA--.37731S3;
        Thu, 15 Sep 2022 09:19:49 +0800 (CST)
Subject: Re: [PATCH] mm/vmscan: don't scan adjust too much if current is not
 kswapd
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20220914023318.549118-1-zhanghongchen@loongson.cn>
 <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
From:   Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <6bcb4883-03d0-88eb-4c42-84fff0a9a141@loongson.cn>
Date:   Thu, 15 Sep 2022 09:19:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20220914155142.bf388515a39fb45bae987231@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8BxXWu1fSJj0p0ZAA--.37731S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1fXr43WF1rCF4fCr4kWFg_yoW7KF17pF
        15KF47GF48GrWDta1UAw18tw18Zr4DCa4UCr97Gr1xuF1UWw1UJ34xJr4YgFn8Gw4UJa47
        Xr98tw18tF1jgaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        bOoGdUUUUU=
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 2022/9/15 am 6:51, Andrew Morton wrote:
> On Wed, 14 Sep 2022 10:33:18 +0800 Hongchen Zhang <zhanghongchen@loongson.cn> wrote:
> 
>> when a process falls into page fault and there is not enough free
>> memory,it will do direct reclaim. At the same time,it is holding
>> mmap_lock.So in case of multi-thread,it should exit from page fault
>> ASAP.
>> When reclaim memory,we do scan adjust between anon and file lru which
>> may cost too much time and trigger hung task for other thread.So for a
>> process which is not kswapd,it should just do a little scan adjust.
> 
> Well, that's a pretty nasty bug.  Before diving into a possible fix,
> can you please tell us more about how this happens?  What sort of
> machine, what sort of workload.  Can you suggest why others are not
> experiencing this?
>We got a hung task panic originally by doing ltpstress on a Loongarch 
3A5000+71000 machine.Then, we found the same problem on a X86 machine as 
following:
[ 3748.453561] INFO: task float_bessel:77920 blocked for more than 120 
seconds.
[ 3748.460839]       Not tainted 5.15.0-46-generic #49-Ubuntu
[ 3748.466490] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 3748.474618] task:float_bessel    state:D stack:    0 pid:77920 ppid: 
77327 flags:0x00004002
[ 3748.483358] Call Trace:
[ 3748.485964]  <TASK>
[ 3748.488150]  __schedule+0x23d/0x590
[ 3748.491804]  schedule+0x4e/0xc0
[ 3748.495038]  rwsem_down_read_slowpath+0x336/0x390
[ 3748.499886]  ? copy_user_enhanced_fast_string+0xe/0x40
[ 3748.505181]  down_read+0x43/0xa0
[ 3748.508518]  do_user_addr_fault+0x41c/0x670
[ 3748.512799]  exc_page_fault+0x77/0x170
[ 3748.516673]  asm_exc_page_fault+0x26/0x30
[ 3748.520824] RIP: 0010:copy_user_enhanced_fast_string+0xe/0x40
[ 3748.526764] Code: 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 
0f 01 ca c3 cc cc cc cc 0f 1f 00 0f 01 cb 83 fa 40 0f 82 70 ff ff ff 89 
d1 <f3> a4 31 c0 0f 01 ca c3 cc cc cc cc 66 08
[ 3748.546120] RSP: 0018:ffffaa9248fffb90 EFLAGS: 00050206
[ 3748.551495] RAX: 00007f99faa1a010 RBX: ffffaa9248fffd88 RCX: 
0000000000000010
[ 3748.558828] RDX: 0000000000001000 RSI: ffff9db397ab8ff0 RDI: 
00007f99faa1a000
[ 3748.566160] RBP: ffffaa9248fffbf0 R08: ffffcc2fc2965d80 R09: 
0000000000000014
[ 3748.573492] R10: 0000000000000000 R11: 0000000000000014 R12: 
0000000000001000
[ 3748.580858] R13: 0000000000001000 R14: 0000000000000000 R15: 
ffffaa9248fffd98
[ 3748.588196]  ? copy_page_to_iter+0x10e/0x400
[ 3748.592614]  filemap_read+0x174/0x3e0
[ 3748.596354]  ? ima_file_check+0x6a/0xa0
[ 3748.600301]  generic_file_read_iter+0xe5/0x150
[ 3748.604884]  ext4_file_read_iter+0x5b/0x190
[ 3748.609164]  ? aa_file_perm+0x102/0x250
[ 3748.613125]  new_sync_read+0x10d/0x1a0
[ 3748.617009]  vfs_read+0x103/0x1a0
[ 3748.620423]  ksys_read+0x67/0xf0
[ 3748.623743]  __x64_sys_read+0x19/0x20
[ 3748.627511]  do_syscall_64+0x59/0xc0
[ 3748.631203]  ? syscall_exit_to_user_mode+0x27/0x50
[ 3748.636144]  ? do_syscall_64+0x69/0xc0
[ 3748.639992]  ? exit_to_user_mode_prepare+0x96/0xb0
[ 3748.644931]  ? irqentry_exit_to_user_mode+0x9/0x20
[ 3748.649872]  ? irqentry_exit+0x1d/0x30
[ 3748.653737]  ? exc_page_fault+0x89/0x170
[ 3748.657795]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[ 3748.663030] RIP: 0033:0x7f9a852989cc
[ 3748.666713] RSP: 002b:00007f9a8497dc90 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[ 3748.674487] RAX: ffffffffffffffda RBX: 00007f9a8497f5c0 RCX: 
00007f9a852989cc
[ 3748.681817] RDX: 0000000000027100 RSI: 00007f99faa18010 RDI: 
0000000000000061
[ 3748.689150] RBP: 00007f9a8497dd60 R08: 0000000000000000 R09: 
00007f99faa18010
[ 3748.696493] R10: 0000000000000000 R11: 0000000000000246 R12: 
00007f99faa18010
[ 3748.703841] R13: 00005605e11c406f R14: 0000000000000001 R15: 
0000000000027100
[ 3748.711199]  </TASK>
...
...
[ 3750.943278] Kernel panic - not syncing: hung_task: blocked tasks
[ 3750.949399] CPU: 1 PID: 39 Comm: khungtaskd Not tainted 
5.15.0-46-generic #49-Ubuntu
[ 3750.957305] Hardware name: LENOVO 90DWCTO1WW/30D9, BIOS M05KT70A 
03/09/2017
[ 3750.964410] Call Trace:
[ 3750.966897]  <TASK>
[ 3750.969031]  show_stack+0x52/0x5c
[ 3750.972409]  dump_stack_lvl+0x4a/0x63
[ 3750.976129]  dump_stack+0x10/0x16
[ 3750.979491]  panic+0x149/0x321
[ 3750.982612]  check_hung_uninterruptible_tasks.cold+0x34/0x48
[ 3750.988383]  watchdog+0xad/0xb0
[ 3750.991562]  ? check_hung_uninterruptible_tasks+0x300/0x300
[ 3750.997285]  kthread+0x127/0x150
[ 3751.000587]  ? set_kthread_struct+0x50/0x50
[ 3751.004878]  ret_from_fork+0x1f/0x30
[ 3751.008527]  </TASK>
[ 3751.010794] Kernel Offset: 0x34600000 from 0xffffffff81000000 
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 3751.034481] ---[ end Kernel panic - not syncing: hung_task: blocked 
tasks ]---
The difference with normal ltpstress test is we use a very large swap 
partition,so the swap pressure is bigger than normal,and this problem 
becomes more likely to occur.

>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -3042,11 +3042,17 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>>   		nr[lru] = targets[lru] * (100 - percentage) / 100;
>>   		nr[lru] -= min(nr[lru], nr_scanned);
>>   
>> +		if (!current_is_kswapd())
>> +			nr[lru] = min(nr[lru], nr_to_reclaim);
>> +
>>   		lru += LRU_ACTIVE;
>>   		nr_scanned = targets[lru] - nr[lru];
>>   		nr[lru] = targets[lru] * (100 - percentage) / 100;
>>   		nr[lru] -= min(nr[lru], nr_scanned);
>>   
>> +		if (!current_is_kswapd())
>> +			nr[lru] = min(nr[lru], nr_to_reclaim);
>> +
>>   		scan_adjusted = true;
>>   	}
>>   	blk_finish_plug(&plug);
> 
> It would be better if these additions had code comments explaining why
> they're there.  But let's more fully understand the problem before
> altering your patch.
Thanks,
Hongchen Zhang

