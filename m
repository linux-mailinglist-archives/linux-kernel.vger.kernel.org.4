Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6263CD76
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 03:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiK3Cir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 21:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiK3Ciq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 21:38:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F5C6A74D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 18:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669775925; x=1701311925;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=PQAlzj9x5Nt5ZZJCWyX7IxJO+PzBYV/VRDx2ZGEtf2I=;
  b=FX3CPONu5pgnRaBbiSosTqIDaKbwLiG/z+wM99YWHNC0YLgXDsFaRMKO
   leKFIOdYGHSgzs/XXBurkwG1vT8gq+bYzGbRjQu4JoVjofrkkIxUNHxrP
   a0dQvIeVplb7jFsD30LDpsPqjh32EXATcjyiefpocx6vOzf2I7vg//qXg
   3sZF9L9V3Uh58fWqmwrTk5ffnNygEBB+7kVJuvmz/8MsSgBHshMh5du16
   yWUoiVil7/2aZLtWP2OgC+Gvn/VoGjY73kTo1Dd6e72DT7CZt+pdtiwK3
   GHtH8t85Q0YokOCAMzvHIE2Y/wtNJVHPQGpDAsh7e9DQhC5aKlBESmWYp
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="295651366"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="295651366"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 18:38:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="644036816"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="644036816"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 18:38:41 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     xialonglong <xialonglong1@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, <hannes@cmpxchg.org>,
        <linux-mm@kvack.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        chenwandun <chenwandun@huawei.com>, <songmuchun@bytedance.com>,
        <gregkh@linuxfoundation.org>
Subject: Re: =?utf-8?B?44CQQlVH44CRTlVMTA==?= pointer dereference at
 __lookup_swap_cgroup
References: <25f28e73-5fc6-6e7f-3d41-a5970537fb8b@huawei.com>
        <87fse3homz.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2e132246-96be-a281-78f4-8310f75a0ed8@huawei.com>
Date:   Wed, 30 Nov 2022 10:37:20 +0800
In-Reply-To: <2e132246-96be-a281-78f4-8310f75a0ed8@huawei.com> (xialonglong's
        message of "Wed, 30 Nov 2022 09:31:56 +0800")
Message-ID: <87y1rtb21r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xialonglong <xialonglong1@huawei.com> writes:

> Thank you very much for your reply :)
> Inspired by your replywe successfully reproduced the bug.
>
> The test steps:
> 1.swapon /dev/zram0
> 2.add some memory pressure by stress-ng
> 3.calling swapoff /dev/zram0 in the do_swap_page function (this
> changed the source code)
> 4.bug occured in the same place.
>
> After testing, this patch solves the bug.
> Finally, there is a small question. Why linux5.10 revert this patch
> (2799e77529c2)?

2799e77529c2 is merged by v5.14.

Best Regards,
Huang, Ying

> We found that to fix this bug, the following patches may be required:
> efa33fc7f6e mm/shmem: fix shmem_swapin() race with swapoff
> 5c046235a826 mm/swap: remove confusing checking for non_swap_entry()
> in swap_ra_info()
> 2799e77529c2 swap: fix do_swap_page() race with swapoff
> 63d8620ecf93 mm/swapfile: use percpu_ref to serialize against
> concurrent swapoff
> seem like all this patchset is needed except commit 5c046235a826
> ("mm/swap: remove confusing checking for non_swap_entry() in 
> swap_ra_info()")
>
> Best Regards,
> Xia, longlong
>
> ( 2022/11/28 9:08, Huang, Ying S:
>> Hi,
>>
>> xialonglong <xialonglong1@huawei.com> writes:
>>
>>> A panic occur in the linux 5.10we meet it only onceit seems that
>>> there is no special changes between 5.10 and upsteam about swap_cgroup.
>>>
>>> The test is based on QEMU with 64GB memory, one 2GB zram device as
>>> swap area.
>>> The test steps:
>>> 1.swapoff -a
>>> 2.add some memory pressure by stress-ng
>>> 3.while (2 minutes) {
>>>   swapoff /dev/zram0
>>>   swapon /dev/zram0
>>>   sleep 3
>>> }
>>> 4. swapon -a
>>>
>>> Preliminary analysis showed that the swap entry point to a swap area
>>> which have already been swapoff, and no other obvious clues, still
>>> trying to reproduce it.
>> We have a patch as follows to fix a similar issue,
>>
>> 2799e77529c2a25492a4395db93996e3dacd762d
>> Author:     Miaohe Lin <linmiaohe@huawei.com>
>> AuthorDate: Mon Jun 28 19:36:50 2021 -0700
>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Tue Jun 29 10:53:49 2021 -0700
>>
>> swap: fix do_swap_page() race with swapoff
>>
>> When I was investigating the swap code, I found the below possible race
>> window:
>>
>> CPU 1                                   	CPU 2
>> -----                                   	-----
>> do_swap_page
>>    if (data_race(si->flags & SWP_SYNCHRONOUS_IO)
>>    swap_readpage
>>      if (data_race(sis->flags & SWP_FS_OPS)) {
>>                                          	swapoff
>> 					  	  ..
>> 					  	  p->swap_file = NULL;
>> 					  	  ..
>>      struct file *swap_file = sis->swap_file;
>>      struct address_space *mapping = swap_file->f_mapping;[oops!]
>>
>> Note that for the pages that are swapped in through swap cache, this isn't
>> an issue. Because the page is locked, and the swap entry will be marked
>> with SWAP_HAS_CACHE, so swapoff() can not proceed until the page has been
>> unlocked.
>>
>> Fix this race by using get/put_swap_device() to guard against concurrent
>> swapoff.
>>
>> Can you check whether that can fix your issue?
>>
>> Best Regards,
>> Huang, Ying
>>
>>> Any known issue about this feature, or any advise will be appreciated.
>>>
>>> Here are the panic log,
>>>
>>> Unable to handle kernel NULL pointer dereference at virtual address
>>> 0000000000000740
>>> Mem abort info:
>>> ESR = 0x96000004
>>> EC = 0x25: DABT (current EL), IL = 32 bits SET = 0, FnV = 0 EA = 0,
>>> S1PTW = 0 Data abort info:
>>> ISV = 0, ISS = 0x00000004
>>> CM = 0, WnR = 0
>>> user pgtable: 4k pages, 48-bit VAs, pgdp=000000010ae6e000
>>> pgd=0000000000000000, p4d=0000000000000000 Internal error: Oops:
>>> 96000004 [#1] SMP Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0
>>> 02/06/2015
>>> pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
>>> pc : lookup_swap_cgroup_id+0x38/0x50
>>> lr : mem_cgroup_charge+0x9c/0x424
>>> sp : ffff800102f63bc0
>>> x29: ffff800102f63bc0 x28: ffff0000d0d64d00
>>> x27: 0000000000000000 x26: 0000000000000007
>>> x25: ffff0000018c86a8 x24: ffff0000018c8640
>>> x23: 0000000000000cc0 x22: 0000000000000001
>>> x21: 0000000000000001 x20: ffff800102f63d28
>>> x19: fffffe000373cb40 x18: 0000000000000000
>>> x17: 0000000000000000 x16: ffff8001004715a4
>>> x15: 00000000ffffffff x14: 0000000000003000
>>> x13: 00000000ffffffff x12: 0000000000000040
>>> x11: ffff0000c0403478 x10: ffff0000c040347a
>>> x9 : ffff8001003e957c x8 : 000000000009dddd
>>> x7 : 0000000000000600 x6 : 00000000000000e8
>>> x5 : 0000020000200000 x4 : ffff000000000000
>>> x3 : ffff800101f4c030 x2 : 0000000000000000
>>> x1 : 00000000000001e4 x0 : 0000000000000000
>>>
>>> Call trace:
>>> lookup_swap_cgroup_id+0x38/0x50
>>> do_swap_page+0xa64/0xc04
>>> handle_pte_fault+0x1c8/0x214
>>> __handle_mm_fault+0x1b0/0x380
>>> handle_mm_fault+0xf4/0x284
>>> do_page_fault+0x188/0x474
>>> do_translation_fault+0xb8/0xe4
>>> do_mem_abort+0x48/0xb0
>>> el0_da+0x44/0x80
>>> el0_sync_handler+0x88/0xb4
>>> el0_sync+0x160/0x180
>>>
>>> <lookup_swap_cgroup_id>:?????? mov?? x9, x30
>>> <lookup_swap_cgroup_id+0x4>:???? nop
>>> <lookup_swap_cgroup_id+0x8>:????
>>> lsr?? x2, x0, #58 SWP_TYPE_SHIFT == 58? x2 =
>>> swp_type
>>> <lookup_swap_cgroup_id+0xc>:????
>>> adrp? x1, 0xffff800101f4c000
>>> <memcg_sockets_enabled_key+0x8>
>>> <lookup_swap_cgroup_id+0x10>:???
>>> add?? x3, x1, #0x30????
>>> x3 == swap_cgroup_ctrl
>>> <lookup_swap_cgroup_id+0x14>:??? ubfx? x6, x0, #11, #47
>>> <lookup_swap_cgroup_id+0x18>:??? add?? x2, x2, x2, lsl #1
>>> <lookup_swap_cgroup_id+0x1c>:??? ubfiz? x1, x0, #1, #11
>>> <lookup_swap_cgroup_id+0x20>:???
>>> mov?? x5,
>>> #0x200000?????????
>>> // #2097152
>>> <lookup_swap_cgroup_id+0x24>:???
>>> mov?? x4,
>>> #0xffff000000000000???? //
>>> #-281474976710656
>>> <lookup_swap_cgroup_id+0x28>:??? movk? x5, #0x200, lsl #32
>>> <lookup_swap_cgroup_id+0x2c>:??? hint? #0x19
>>> <lookup_swap_cgroup_id+0x30>:???
>>> ldr?? x0, [x3,x2,lsl #3] x3=ffff800101f4c030, x0 = 0
>>> <lookup_swap_cgroup_id+0x34>:??? hint? #0x1d
>>> <lookup_swap_cgroup_id+0x38>:???
>>> ldr?? x0, [x0,x6,lsl #3] x0 = 0 + 0xe8 * 8 == 0x740
>>> <lookup_swap_cgroup_id+0x3c>:??? add?? x0, x0, x5
>>> <lookup_swap_cgroup_id+0x40>:??? lsr?? x0, x0, #6
>>> <lookup_swap_cgroup_id+0x44>:??? add?? x0, x1, x0, lsl #12
>>> <lookup_swap_cgroup_id+0x48>:??? ldrh? w0, [x0,x4]
>>> <lookup_swap_cgroup_id+0x4c>:??? ret
