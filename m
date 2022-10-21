Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFC2606E57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJUDcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJUDcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:32:09 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695F1F042A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666323128; x=1697859128;
  h=message-id:date:mime-version:subject:to:cc:from:
   content-transfer-encoding;
  bh=jiZCX+XpFoSjkO0CVagtGX3LOyBOTiU56aicHHQlG/A=;
  b=SFLP/ywqupn7v0K6oGraCRqhujWEa3tG04KfJVqJjok4MwUlS5S8gX4E
   x/fyyJSChqCltDMRYKdkuMDePC8humcXxn7nDIzwGeuJlhBBe9vPs9FKZ
   vOD0aQyx595pJYHjnW/9/TItOSuIvrHf+V99+rlTGlwxIzpaMSAhhLoUn
   dv7PrevzGlK7zH5K9YWe62z6TILpsdF+XBwLHJ/CO3MLTCt6eYA4PKpck
   p8+gVCAdIkpClKmUV39n45hpi1Jwzn16gWrmotQgQrtwzgjrtKs3knFTz
   Gp69MtfJW/BsgnC2RAxxSwG8LoWYWLOH5nBX8gbTgKfqGk2yoi9mOYxiQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="393200714"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="393200714"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:32:08 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10506"; a="693431083"
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="693431083"
Received: from jiebinsu-mobl.ccr.corp.intel.com (HELO [10.255.28.147]) ([10.255.28.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 20:32:06 -0700
Message-ID: <6283cbe8-06ff-c355-2028-bd35087a7a32@intel.com>
Date:   Fri, 21 Oct 2022 11:31:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in
 percpu_counter_add_batch
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com, jiebin.sun@intel.com
From:   "Sun, Jiebin" <jiebin.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/1/1970 8:00 AM, Andrew Morton wrote:
> On Thu, 20 Oct 2022 19:24:40 -0700 syzbot
> <syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com> wrote:
>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    aae703b02f92 Merge tag 'for-6.1-rc1-tag' of git://git.kern..
>> git tree:       upstream
>> console output:
>> https://syzkaller.appspot.com/x/log.txt?x=1686e478880000
>> kernel config:
>> https://syzkaller.appspot.com/x/.config?x=883de36878e6d869
>> dashboard link: https://syzkaller.appspot.com/bug?extid=96e659d35b9d6b541152
>> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for
> Debian) 2.35.2
>> userspace arch: arm
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+96e659d35b9d6b541152@syzkaller.appspotmail.com
>>
>> Unable to handle kernel paging request at virtual address
>> ffff70000b978a00
>> KASAN: maybe wild-memory-access in range
>> [0xffff80005cbc5000-0xffff80005cbc5007]
>> Mem abort info:
>>    ESR = 0x0000000096000006
>>    EC = 0x25: DABT (current EL), IL = 32 bits
>>    SET = 0, FnV = 0
>>    EA = 0, S1PTW = 0
>>    FSC = 0x06: level 2 translation fault Data abort info:
>>    ISV = 0, ISS = 0x00000006
>>    CM = 0, WnR = 0
>> swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000045dfb000
>> [ffff70000b978a00] pgd=00000000bfbeb003, p4d=00000000bfbeb003,
>> pud=00000000bfbea003, pmd=0000000000000000 Internal error: Oops:
>> 0000000096000006 [#1] PREEMPT SMP Modules linked in:
>> CPU: 0 PID: 2820 Comm: kworker/0:3 Tainted: G        W          6.1.0-rc1-syzkaller-00025-gaae703b02f92
> #0
>> Hardware name: linux,dummy-virt (DT)
>> Workqueue: events free_ipc
>> pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--) pc :
>> percpu_counter_add_batch+0x78/0x2f0 lib/percpu_counter.c:87 lr :
>> percpu_counter_add_batch+0x44/0x2f0 lib/percpu_counter.c:87 sp :
>> ffff8000120979c0
>> x29: ffff8000120979c0 x28: ffff0000151ff800 x27: 1fffe00002a3ff24
>> x26: ffff80005cbc5000 x25: ffff00000eeac7b0 x24: 1fffe00001dd58f6
>> x23: 000000007fffffff x22: ffff80000cc4e800 x21: 0000000000000000
>> x20: 0000000000000000 x19: ffff00000eeac758 x18: ffff00006a9cbbc0
>> x17: 0000000000000000 x16: 0000000000000000 x15: ffff800008d9c830
>> x14: ffff800008d78ecc x13: ffff800008d752d4 x12: ffff600002a3ff01
>> x11: 1fffe00002a3ff00 x10: ffff600002a3ff00 x9 : dfff800000000000
>> x8 : ffff0000151ff800 x7 : 00000000f1f1f1f1 x6 : dfff800000000000
>> x5 : ffff700002412f32 x4 : 1ffff000020ef1ac x3 : 1ffff0000b978a00
>> x2 : dfff800000000000 x1 : 0000000000000003 x0 : ffff80005cbc5000 Call
>> trace:
>>   percpu_counter_add_batch+0x78/0x2f0 lib/percpu_counter.c:87
>> percpu_counter_add_local include/linux/percpu_counter.h:75 [inline]
>> percpu_counter_sub_local include/linux/percpu_counter.h:225 [inline]
>>   freeque+0x20c/0x364 ipc/msg.c:292
>>   free_ipcs+0xa0/0x160 ipc/namespace.c:125
>>   msg_exit_ns+0x38/0x60 ipc/msg.c:1334
>>   free_ipc_ns ipc/namespace.c:138 [inline]
>>   free_ipc+0xd0/0x1c0 ipc/namespace.c:157
>> process_one_work+0x780/0x184c kernel/workqueue.c:2289
>>   worker_thread+0x3cc/0xc40 kernel/workqueue.c:2436
>>   kthread+0x23c/0x2a0 kernel/kthread.c:376
>>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> Well.  freeque() messes with ns->percpu_msg_hdrs but msg_exit_ns() already did
> percpu_counter_destroy(&ns->percpu_msg_hdrs);
>
> I'm thinking something like this?
>
> --- a/ipc/msg.c~a
> +++ a/ipc/msg.c
> @@ -1329,11 +1329,11 @@ fail_msg_bytes:
>   #ifdef CONFIG_IPC_NS
>   void msg_exit_ns(struct ipc_namespace *ns)  {
> -	percpu_counter_destroy(&ns->percpu_msg_bytes);
> -	percpu_counter_destroy(&ns->percpu_msg_hdrs);
>   	free_ipcs(ns, &msg_ids(ns), freeque);
>   	idr_destroy(&ns->ids[IPC_MSG_IDS].ipcs_idr);
>   	rhashtable_destroy(&ns->ids[IPC_MSG_IDS].key_ht);
> +	percpu_counter_destroy(&ns->percpu_msg_bytes);
> +	percpu_counter_destroy(&ns->percpu_msg_hdrs);
>   }
>   #endif
>   
> _

Hi Andrew,

The quick fix looks good to me. There is protection in 
percpu_counter_destroy if the it has been released in freeque. Thanks.

