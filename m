Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC376209BB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiKHGts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 01:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKHGtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:49:46 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E621A21F;
        Mon,  7 Nov 2022 22:49:44 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N5zGz41Bjz15MRl;
        Tue,  8 Nov 2022 14:49:31 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 14:49:42 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 14:49:42 +0800
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in
 nilfs_segctor_prepare_write()
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com>
Date:   Tue, 8 Nov 2022 14:49:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/8 12:41, Ryusuke Konishi wrote:
> Hi Liu Shixin,
>
> On Tue, Nov 8, 2022 at 10:41 AM Liu Shixin wrote:
>> Syzbot reported a NULL pointer dereference:
>>
>>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000168
>>  Mem abort info:
>>    ESR = 0x0000000096000004
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x04: level 0 translation fault
>>  Data abort info:
>>    ISV = 0, ISS = 0x00000004
>>    CM = 0, WnR = 0
>>  user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108bcf000
>>  [0000000000000168] pgd=0000000000000000, p4d=0000000000000000
>>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>  Modules linked in:
>>  CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
>>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
>>  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>  pc : _compound_head include/linux/page-flags.h:253 [inline]
>>  pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
>>  lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
>>  sp : ffff80001290bc00
>>  x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
>>  x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
>>  x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
>>  x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
>>  x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
>>  x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
>>  x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
>>  x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
>>  x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
>>  x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
>>  Call trace:
>>   lock_page+0x28/0x1e0 include/linux/pagemap.h:956
>>   nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
>>   nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
>>   nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
>>   nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
>>   nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
>>   kthread+0x12c/0x158 kernel/kthread.c:376
>>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>>
>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construction(),
>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, we will
>> add a bh in two segbuf->sb_segsum_buffers. And finally cause list error.
>>
>> Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  fs/nilfs2/segment.c | 1 +
>>  fs/nilfs2/sufile.c  | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
>> index b4cebad21b48..7be632c15f91 100644
>> --- a/fs/nilfs2/segment.c
>> +++ b/fs/nilfs2/segment.c
>> @@ -1371,6 +1371,7 @@ static int nilfs_segctor_extend_segments(struct nilfs_sc_info *sci,
>>                 sci->sc_segbuf_nblocks += segbuf->sb_rest_blocks;
>>
>>                 /* allocate the next next full segment */
>> +               nextnextnum = segbuf->sb_segnum;
>>                 err = nilfs_sufile_alloc(sufile, &nextnextnum);
>>                 if (unlikely(err))
>>                         goto failed_segbuf;
>> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
>> index 77ff8e95421f..853a8212114f 100644
>> --- a/fs/nilfs2/sufile.c
>> +++ b/fs/nilfs2/sufile.c
>> @@ -317,7 +317,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
>>                 goto out_sem;
>>         kaddr = kmap_atomic(header_bh->b_page);
>>         header = kaddr + bh_offset(header_bh);
>> -       last_alloc = le64_to_cpu(header->sh_last_alloc);
>> +       last_alloc = max(le64_to_cpu(header->sh_last_alloc), *segnump);
>>         kunmap_atomic(kaddr);
>>
>>         nsegments = nilfs_sufile_get_nsegments(sufile);
>> --
>> 2.25.1
> Thank you for your help.   I have a few questions, so I'll ask them below.
>
>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construction(),
>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, we will
>> add a bh in two segbuf->sb_segsum_buffers.
> If nilfs_sufile_alloc() succeeds to allocate a segment, sh_last_alloc
> is updated.
> all segment allocation must be done through nilfs_sufile_alloc().
> And, the allocated segment is marked dirty on the sufile not to be
> reallocated until it's freed.
>
> So, why is it happening that the same segment is allocated twice in a log ?
> Is it hard to fix the problem by correcting the calling sequence of
> nilfs_sufile_alloc()/free()/etc without touching nilfs_sufile_alloc()
> ?
The problem happened when we call nilfs_segctor_begin_construction() and satisfied
condition nilfs->ns_segnum != nilfs->ns_nextnum. In such scenario, nilfs_sufile_alloc()
will be skipped, but we call nilfs_segbuf_map() and nilfs_segbuf_set_next_segnum()
all the time, so last_alloc is not updated.
Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->sb_nextnum directly,
and calculate next sb_segnum by nilfs_sufile_alloc(), since last_alloc is not updated,
we will get sb_segnum again.

By the way, I still don't understand why skip nilfs_sufile_alloc() in some cases and why
nilfs->ns_segnum != nilfs->ns_nextnum. Do you have any ideas?
>
> I haven't looked closely at this patch yet, but I'm concerned about
> the impact on other places as well.
> nilfs_sufile_alloc() is also used in
> nilfs_segctor_begin_construction() and
> nilfs_prepare_segment_for_recovery().  Are there any side effects?
>
> This patch turns an output-only argument into both input and output,
> and that input value is always used in the calculation of
> "last_alloc".
> So, this change requires all callers to pass a meaningful initial
> value (at least a valid value) to *segnump.
>
> Another question, will this work near the end of the segments ?
> Since segments are used cyclically, wouldn't comparison with the max
> function break down there?
> (I mean it seems that sh_last_alloc may be chosen unintentionally at the end.)
Thanks for the heads-up，I need to look at it again. This patch can only prevent this problem,
and seems to need improvement. Maybe there is a more reasonable solution.

Thanks,
>
> Regards,
> Ryusuke Konishi
> .
>

