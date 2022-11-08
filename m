Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB01620F91
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKHLxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiKHLxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:53:38 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F47411A07;
        Tue,  8 Nov 2022 03:53:37 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N661g6b2mzRp5R;
        Tue,  8 Nov 2022 19:53:27 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:53:35 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 19:53:35 +0800
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in
 nilfs_segctor_prepare_write()
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
References: <20221108022928.497746-1-liushixin2@huawei.com>
 <CAKFNMo=n8_NkHzvxOBuiU4XahdRnWNbwmZKu4pw0KZ7bfWuVhg@mail.gmail.com>
 <5c8dd545-2190-162e-a9de-2323fcad716f@huawei.com>
 <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-nilfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <781fc98e-351c-58b0-b0e7-e5080a193d31@huawei.com>
Date:   Tue, 8 Nov 2022 19:53:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAKFNMokcSj9YSLeXm=S4rY5nMx6DjQvRHXVaLVu2CbNEia7-2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2022/11/8 18:33, Ryusuke Konishi wrote:
> On Tue, Nov 8, 2022 at 3:49 PM Liu Shixin wrote:
>>
>>
>> On 2022/11/8 12:41, Ryusuke Konishi wrote:
>>> Hi Liu Shixin,
>>>
>>> On Tue, Nov 8, 2022 at 10:41 AM Liu Shixin wrote:
>>>> Syzbot reported a NULL pointer dereference:
>>>>
>>>>  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000168
>>>>  Mem abort info:
>>>>    ESR = 0x0000000096000004
>>>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>>>    SET = 0, FnV = 0
>>>>    EA = 0, S1PTW = 0
>>>>    FSC = 0x04: level 0 translation fault
>>>>  Data abort info:
>>>>    ISV = 0, ISS = 0x00000004
>>>>    CM = 0, WnR = 0
>>>>  user pgtable: 4k pages, 48-bit VAs, pgdp=0000000108bcf000
>>>>  [0000000000000168] pgd=0000000000000000, p4d=0000000000000000
>>>>  Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
>>>>  Modules linked in:
>>>>  CPU: 1 PID: 3032 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
>>>>  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
>>>>  pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>  pc : _compound_head include/linux/page-flags.h:253 [inline]
>>>>  pc : lock_page+0x28/0x1e0 include/linux/pagemap.h:958
>>>>  lr : lock_page+0x28/0x1e0 include/linux/pagemap.h:956
>>>>  sp : ffff80001290bc00
>>>>  x29: ffff80001290bc00 x28: ffff80001290bde0 x27: 000000000000001b
>>>>  x26: fffffc000330d7c0 x25: ffff0000caa56d68 x24: ffff0000ca9fb1c0
>>>>  x23: 0000000000000080 x22: ffff0000ca9fb130 x21: 0000000000000160
>>>>  x20: ffff0000c91e10b8 x19: 0000000000000160 x18: 00000000000000c0
>>>>  x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c3e63500
>>>>  x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c3e63500
>>>>  x11: ff808000095d1a0c x10: 0000000000000000 x9 : 0000000000000000
>>>>  x8 : 0000000000000000 x7 : ffff80000856806c x6 : 0000000000000000
>>>>  x5 : 0000000000000080 x4 : 0000000000000000 x3 : 0000000000000000
>>>>  x2 : 0000000000000000 x1 : ffff80000cb431b1 x0 : 0000000000000000
>>>>  Call trace:
>>>>   lock_page+0x28/0x1e0 include/linux/pagemap.h:956
>>>>   nilfs_segctor_prepare_write+0x6c/0x21c fs/nilfs2/segment.c:1658
>>>>   nilfs_segctor_do_construct+0x9f4/0xee8 fs/nilfs2/segment.c:2068
>>>>   nilfs_segctor_construct+0xa0/0x380 fs/nilfs2/segment.c:2375
>>>>   nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
>>>>   nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
>>>>   kthread+0x12c/0x158 kernel/kthread.c:376
>>>>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>>>>
>>>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construction(),
>>>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, we will
>>>> add a bh in two segbuf->sb_segsum_buffers. And finally cause list error.
>>>>
>>>> Reported-by: syzbot+77e4f005cb899d4268d1@syzkaller.appspotmail.com
>>>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
>>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>>> ---
>>>>  fs/nilfs2/segment.c | 1 +
>>>>  fs/nilfs2/sufile.c  | 2 +-
>>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
>>>> index b4cebad21b48..7be632c15f91 100644
>>>> --- a/fs/nilfs2/segment.c
>>>> +++ b/fs/nilfs2/segment.c
>>>> @@ -1371,6 +1371,7 @@ static int nilfs_segctor_extend_segments(struct nilfs_sc_info *sci,
>>>>                 sci->sc_segbuf_nblocks += segbuf->sb_rest_blocks;
>>>>
>>>>                 /* allocate the next next full segment */
>>>> +               nextnextnum = segbuf->sb_segnum;
>>>>                 err = nilfs_sufile_alloc(sufile, &nextnextnum);
>>>>                 if (unlikely(err))
>>>>                         goto failed_segbuf;
>>>> diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
>>>> index 77ff8e95421f..853a8212114f 100644
>>>> --- a/fs/nilfs2/sufile.c
>>>> +++ b/fs/nilfs2/sufile.c
>>>> @@ -317,7 +317,7 @@ int nilfs_sufile_alloc(struct inode *sufile, __u64 *segnump)
>>>>                 goto out_sem;
>>>>         kaddr = kmap_atomic(header_bh->b_page);
>>>>         header = kaddr + bh_offset(header_bh);
>>>> -       last_alloc = le64_to_cpu(header->sh_last_alloc);
>>>> +       last_alloc = max(le64_to_cpu(header->sh_last_alloc), *segnump);
>>>>         kunmap_atomic(kaddr);
>>>>
>>>>         nsegments = nilfs_sufile_get_nsegments(sufile);
>>>> --
>>>> 2.25.1
>>> Thank you for your help.   I have a few questions, so I'll ask them below.
>>>
>>>> If didn't call nilfs_sufile_alloc() in nilfs_segctor_begin_construction(),
>>>> nilfs_sufile_header's sh_last_alloc is not updated. In such case, we will
>>>> add a bh in two segbuf->sb_segsum_buffers.
>>> If nilfs_sufile_alloc() succeeds to allocate a segment, sh_last_alloc
>>> is updated.
>>> all segment allocation must be done through nilfs_sufile_alloc().
>>> And, the allocated segment is marked dirty on the sufile not to be
>>> reallocated until it's freed.
>>>
>>> So, why is it happening that the same segment is allocated twice in a log ?
>>> Is it hard to fix the problem by correcting the calling sequence of
>>> nilfs_sufile_alloc()/free()/etc without touching nilfs_sufile_alloc()
>>> ?
>> The problem happened when we call nilfs_segctor_begin_construction() and satisfied
>> condition nilfs->ns_segnum != nilfs->ns_nextnum. In such scenario, nilfs_sufile_alloc()
>> will be skipped, but we call nilfs_segbuf_map() and nilfs_segbuf_set_next_segnum()
>> all the time, so last_alloc is not updated.
>> Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->sb_nextnum directly,
>> and calculate next sb_segnum by nilfs_sufile_alloc(), since last_alloc is not updated,
>> we will get sb_segnum again.
>>
>> By the way, I still don't understand why skip nilfs_sufile_alloc() in some cases and why
>> nilfs->ns_segnum != nilfs->ns_nextnum. Do you have any ideas?
>>> I haven't looked closely at this patch yet, but I'm concerned about
>>> the impact on other places as well.
>>> nilfs_sufile_alloc() is also used in
>>> nilfs_segctor_begin_construction() and
>>> nilfs_prepare_segment_for_recovery().  Are there any side effects?
>>>
>>> This patch turns an output-only argument into both input and output,
>>> and that input value is always used in the calculation of
>>> "last_alloc".
>>> So, this change requires all callers to pass a meaningful initial
>>> value (at least a valid value) to *segnump.
>>>
>>> Another question, will this work near the end of the segments ?
>>> Since segments are used cyclically, wouldn't comparison with the max
>>> function break down there?
>>> (I mean it seems that sh_last_alloc may be chosen unintentionally at the end.)
>> Thanks for the heads-up，I need to look at it again. This patch can only prevent this problem,
>> and seems to need improvement. Maybe there is a more reasonable solution.
>>
>> Thanks,
> I will explain step by step.
>
>> By the way, I still don't understand why skip nilfs_sufile_alloc() in some cases and why
>> nilfs->ns_segnum != nilfs->ns_nextnum. Do you have any ideas?
> nilfs->ns_segnum holds the segment number where nilfs2 currently
> writes logs to, and nilfs->ns_nextnum holds the next segment number
> where nilfs2 will select to write logs when the current segment gets
> full.
> Here, a segment is a fixed sized container of logs (*), in which
> multiple logs can be appended and written in.
> (*) Exceptionally, segment #0 is shorter than others to exclude the
> superblock area.
>
> The reason "nextnum" is needed is that mount-time recovery processing
> needs to know which segment the logs follow.
>
> Both segments (nilfs->ns_segnum and nilfs->ns_nextnum) must be already
> allocated on the sufile.
> Here, "allocated" means the corresponding segment usage entry is
> marked "dirty" on the sufile.
> In nilfs_sufile_alloc() this is done with the following line:
>
>                         nilfs_segment_usage_set_dirty(su);
>
> On the other hand, the test whether the segment is allocatable or not
> is done at the following part:
>
>                         if (!nilfs_segment_usage_clean(su))
>                                 continue;
>                         /* found a clean segment */
>
> Coming back to your last question, if nilfs->ns_segnum !=
> nilfs->ns_nextnum, it indicates that nilfs2 is still writing a log to
> the segment of ns_segnum.
> Both should be in the allocated state, so there is no need to call
> nilfs_sufile_alloc() in this case.
>
> If nilfs->ns_segnum == nilfs->ns_nextnum in
> nilfs_segctor_begin_construction(), then nilfs_shift_to_next_segment()
> sets ns_segnum to ns_nextnum because the current segment (ns_segnum)
> is full and no more logs can be written.
> In this case, a new segment must be allocated for new ns_nextnum,
> therefore nilfs_sufile_alloc() will be called.
>
>> The problem happened when we call nilfs_segctor_begin_construction() and satisfied
>> condition nilfs->ns_segnum != nilfs->ns_nextnum. In such scenario, nilfs_sufile_alloc()
>> will be skipped, but we call nilfs_segbuf_map() and nilfs_segbuf_set_next_segnum()
>> all the time, so last_alloc is not updated.
> As I explained above, it is expected behavior that
> nilfs_sufile_alloc() is not called and last_alloc is not updated if
> nilfs->ns_segnum != nilfs->ns_nextnum.
>
> nilfs_segbuf_map() is always called there to set the geometry
> information in the segbuf.  This is expected behavior.
> And, nilfs_segbuf_set_next_segnum() is called later to set the
> determined ns_nextnum to the segbuf, so this is expected behavior as
> well.
>
>> Then in nilfs_segctor_extend_segments(), we set sb_segnum by prev->sb_nextnum directly,
>> and calculate next sb_segnum by nilfs_sufile_alloc(), since last_alloc is not updated,
>> we will get sb_segnum again.
> nilfs_segctor_extend_segments() pre-allocates one or more segments
> large enough to store updated blocks of metadata files that need to be
> written in a series of logs at once, and sets up a chain of segbufs.
> (Sorry for the missing function comment).
>
> sb_segnum is set by prev->sb_nextnum to form a chain of buffers for
> segments.  This is expected behavior.
> And, the sb_nextnum (= next sb_segnum) will be given by
> nilfs_sufile_alloc().   This is also expected.
> It looks like the problem is that nilfs_sufile_alloc() here allocates
> the same segnum again.
Thanks to your series of explanations, I learned a lot. So I can assume that
the skip of nilfs_sufile_alloc() here is because it's already been allocated. So
in next time, we will skip previous sb_segnum natually. And the problem
should not be happend.

>
> Because sb_segnum is set by prev->sb_nextnum which is allocated by the
> previous nilfs_sufile_alloc() call,
> this usually does not happen.
>
> A possible anomaly is if the segment pointed by the first nextnum (or
> segnum) was not marked dirty on sufile.
> This may happen if the sufile is corrupted on the test disk image that
> syzbot provided (mounted).
>
> Can you confirm if this is actually happening?
This problem was discovered through syzbot and can be reproduced. The root
reason I think is data corruption rather than logical error. So we should add
some protection instead of modifying the logic, right?
>
> Regards,
> Ryusuke Konishi
> .
>

