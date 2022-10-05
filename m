Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3FA5F54A9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJEMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJEMjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:39:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E6615788D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:39:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCCB8113E;
        Wed,  5 Oct 2022 05:39:09 -0700 (PDT)
Received: from [10.1.197.78] (unknown [10.1.197.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271383F792;
        Wed,  5 Oct 2022 05:39:01 -0700 (PDT)
Message-ID: <830e8c64-0118-9a2d-5dcf-5cad55425dc2@arm.com>
Date:   Wed, 5 Oct 2022 13:38:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [syzbot] KASAN: invalid-access Read in copy_page
Content-Language: en-GB
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        tongtiangen@huawei.com,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Will Deacon <will@kernel.org>,
        syzbot <syzbot+c2c79c6d6eddc5262b77@syzkaller.appspotmail.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <0000000000004387dc05e5888ae5@google.com>
 <CA+fCnZc9u+QrF-JCQSA+uCM9-egh_=9x4hPdJng6T_uh6XWMZQ@mail.gmail.com>
 <YxdJ684ypgAy8k98@arm.com>
 <CACT4Y+YOnTpWT5NCNhsPY=kV=2gFfQkY=7xGdU_1k7AdGhQneg@mail.gmail.com>
 <YxdZXvsWr37RrFRk@arm.com>
 <CA+fCnZf-GOZpnBRLkRPrL7FUwYrAb-bu=PV0zMfbKOuNYrZ00A@mail.gmail.com>
 <Yxd0C7ndn+iPAGcj@arm.com>
 <CA+fCnZcpba7qinx4DmuJPjRQj07uJ5H9Xq9Zhi8v1rw-AW_yWQ@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <CA+fCnZcpba7qinx4DmuJPjRQj07uJ5H9Xq9Zhi8v1rw-AW_yWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 27/09/2022 17:55, Andrey Konovalov wrote:
> On Tue, Sep 6, 2022 at 6:23 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>
>> On Tue, Sep 06, 2022 at 04:39:57PM +0200, Andrey Konovalov wrote:
>>> On Tue, Sep 6, 2022 at 4:29 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>>>>>> Does it take long to reproduce this kasan warning?
>>>>>
>>>>> syzbot finds several such cases every day (200 crashes for the past 35 days):
>>>>> https://syzkaller.appspot.com/bug?extid=c2c79c6d6eddc5262b77
>>>>> So once it reaches the tested tree, we should have an answer within a day.
>>>
>>> To be specific, this syzkaller instance fuzzes the mainline, so the
>>> patch with the WARN_ON needs to end up there.
>>>
>>> If this is unacceptable, perhaps, we could switch the MTE syzkaller
>>> instance to the arm64 testing tree.
>>
>> It needs some more digging first. My first guess was that a PROT_MTE
>> page was mapped into the user address space and the task repainted it
>> but I don't think that's the case.

> syzkaller still keeps hitting this issue and I was wondering if you
> have any ideas of what could be wrong here?
> 
>> Since I can't find the kernel boot log for these runs, is there any kind
>> of swap enabled? I'm trying to narrow down where the problem may be.
> 
> I don't think there is.


I've reproduced this with the latest qemu and v6.0 kernel using ubuntu 15.04 user-space.

The reproducer is just to log in once its booted. The vm has swap, and I've turned the
memory down low enough to force it to swap. The round trip time is about 15 minutes.

I've not managed to reproduce it without swap, or with more memory. (but it may be a
timing thing)


Below is one example of tag corruption that affected page-cache memory that wouldn't be
swapped:
-------------------%<-------------------
[49488.484420] BUG: KASAN: invalid-access in __arch_copy_to_user+0x180/0x240
[49488.487122] Read at addr f1ff00000ad48000 by task apt-config/5041
[49488.488614] Pointer tag: [f1], memory tag: [fe]

[49488.490921] CPU: 1 PID: 5041 Comm: apt-config Not tainted 6.0.0 #14546
[49488.492364] Hardware name: linux,dummy-virt (DT)
[49488.493790] Call trace:
[49488.494640]  dump_backtrace.part.0+0xd0/0xe0
[49488.495811]  show_stack+0x18/0x50
[49488.496785]  dump_stack_lvl+0x68/0x84
[49488.497781]  print_report+0x104/0x604
[49488.498790]  kasan_report+0x8c/0xb0
[49488.499758]  __do_kernel_fault+0x11c/0x1bc
[49488.500801]  do_tag_check_fault+0x78/0x90
[49488.501830]  do_mem_abort+0x44/0x9c
[49488.502813]  el1_abort+0x40/0x60
[49488.503839]  el1h_64_sync_handler+0xb0/0xd0
[49488.504880]  el1h_64_sync+0x64/0x68
[49488.505847]  __arch_copy_to_user+0x180/0x240
[49488.506917]  _copy_to_iter+0x68/0x5c0
[49488.507918]  copy_page_to_iter+0xac/0x33c
[49488.508943]  filemap_read+0x1b4/0x3b0
[49488.509936]  generic_file_read_iter+0x108/0x1a0
[49488.511033]  ext4_file_read_iter+0x58/0x1f0
[49488.512078]  vfs_read+0x1f8/0x2a0
[49488.513031]  ksys_read+0x68/0xf4
[49488.513978]  __arm64_sys_read+0x1c/0x2c
[49488.514998]  invoke_syscall+0x48/0x114
[49488.516046]  el0_svc_common.constprop.0+0x44/0xec
[49488.517153]  do_el0_svc+0x2c/0xc0
[49488.518120]  el0_svc+0x2c/0xb4
[49488.519041]  el0t_64_sync_handler+0xb8/0xc0
[49488.520080]  el0t_64_sync+0x198/0x19c

[49488.522268] The buggy address belongs to the physical page:
[49488.523778] page:00000000db6e19d9 refcount:20 mapcount:18 mapping:0000000052573be9
index:0x0 pfn:0x4ad48
[49488.524938] memcg:faff000002c70000
[49488.525430] aops:ext4_da_aops ino:8061 dentry name:"libc-2.21.so"
[49488.526289] flags:
0x1ffc38002020876(referenced|uptodate|lru|active|workingset|arch_1|mappedtodisk|arch_2|node=0|zone=0|lastcpupid=0x7ff|kasantag=0xe)
CMA
[49488.527947] raw: 01ffc38002020876 fffffc00002b5248 fffffc00002b51c8 f8ff00000335c760
[49488.528325] raw: 0000000000000000 0000000000000000 0000001400000011 faff000002c70000
[49488.528669] page dumped because: kasan: bad access detected

[49488.529615] Memory state around the buggy address:
[49488.531027]  ffff00000ad47e00: f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1
[49488.532442]  ffff00000ad47f00: f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1 f1
[49488.533922] >ffff00000ad48000: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[49488.535259]                    ^
[49488.536292]  ffff00000ad48100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[49488.537628]  ffff00000ad48200: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
[49488.539015] ==================================================================
[49488.603970] Disabling lock debugging due to kernel taint
-------------------%<-------------------


Thanks,

James
