Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EDA6D58D8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjDDGkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjDDGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:40:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8060C1BD2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:40:30 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PrJ3p4qt6zKwRX;
        Tue,  4 Apr 2023 14:37:58 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 4 Apr 2023 14:40:26 +0800
Subject: Re: [PATCH 2/2] lib/percpu_counter: fix dying cpu compare race
To:     Dave Chinner <dchinner@redhat.com>, Ye Bin <yebin@huaweicloud.com>
References: <20230404014206.3752945-1-yebin@huaweicloud.com>
 <20230404014206.3752945-3-yebin@huaweicloud.com> <ZCu9LtdA+NMrfG9x@rh>
CC:     <dennis@kernel.org>, <tj@kernel.org>, <cl@linux.com>,
        <linux-mm@kvack.org>, <yury.norov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <642BC659.7000007@huawei.com>
Date:   Tue, 4 Apr 2023 14:40:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <ZCu9LtdA+NMrfG9x@rh>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.6 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/4 14:01, Dave Chinner wrote:
> On Tue, Apr 04, 2023 at 09:42:06AM +0800, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> In commit 8b57b11cca88 ("pcpcntrs: fix dying cpu summation race") a race
>> condition between a cpu dying and percpu_counter_sum() iterating online CPUs
>> was identified.
>> Acctually, there's the same race condition between a cpu dying and
>> __percpu_counter_compare(). Here, use 'num_online_cpus()' for quick judgment.
>> But 'num_online_cpus()' will be decreased before call 'percpu_counter_cpu_dead()',
>> then maybe return incorrect result.
>> To solve above issue, also need to add dying CPUs count when do quick judgment
>> in __percpu_counter_compare().
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   lib/percpu_counter.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
>> index 5004463c4f9f..399840cb0012 100644
>> --- a/lib/percpu_counter.c
>> +++ b/lib/percpu_counter.c
>> @@ -227,6 +227,15 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
>>   	return 0;
>>   }
>>   
>> +static __always_inline unsigned int num_count_cpus(void)
>> +{
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	return (num_online_cpus() + num_dying_cpus());
>> +#else
>> +	return num_online_cpus();
>> +#endif
>> +}
>> +
>>   /*
>>    * Compare counter against given value.
>>    * Return 1 if greater, 0 if equal and -1 if less
>> @@ -237,7 +246,7 @@ int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
>>   
>>   	count = percpu_counter_read(fbc);
>>   	/* Check to see if rough count will be sufficient for comparison */
>> -	if (abs(count - rhs) > (batch * num_online_cpus())) {
>> +	if (abs(count - rhs) > (batch * num_count_cpus())) {
> What problem is this actually fixing? You haven't explained how the
> problem you are fixing manifests in the commit message or the cover
> letter.
Before commit 5825bea05265("xfs: __percpu_counter_compare() inode count 
debug too expensive").
I got issue as follows when do cpu online/offline test:

smpboot: CPU 1 is now offline
XFS: Assertion failed: percpu_counter_compare(&mp->m_ifree, 0) >= 0, file: fs/xfs/xfs_trans.c, line: 622
------------[ cut here ]------------
kernel BUG at fs/xfs/xfs_message.c:110!
invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 3 PID: 25512 Comm: fsstress Not tainted 5.10.0-04288-gcb31bdc8c65d #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:assfail+0x77/0x8b fs/xfs/xfs_message.c:110
Code: 7f 10 84 d2 74 0c 48 c7 c7 0c dc e6 ab e8 e8 1e 52 fd 8a 1d 5e 04 5b 01 31 ff 89 de e8 e9 37 14 fd 84 db 74 07 e8 60 36 14 fd <0f> 0b e8 59 36 14 fd 0f 0b 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 47
RSP: 0018:ffff88810a5df5c0 EFLAGS: 00010293
RAX: ffff88810f3a8000 RBX: 0000000000000201 RCX: ffffffffaa8bd7c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000000 R08: ffff88810f3a8000 R09: ffffed103edf71cd
R10: ffff8881f6fb8e67 R11: ffffed103edf71cc R12: ffffffffab0108c0
R13: ffffffffab010220 R14: ffffffffffffffff R15: 0000000000000000
FS:  00007f8536e16b80(0000) GS:ffff8881f6f80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005617e1115f44 CR3: 000000015873a005 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  xfs_trans_unreserve_and_mod_sb+0x833/0xca0 fs/xfs/xfs_trans.c:622
  xlog_cil_commit+0x1169/0x29b0 fs/xfs/xfs_log_cil.c:1325
  __xfs_trans_commit+0x2c0/0xe20 fs/xfs/xfs_trans.c:889
  xfs_create_tmpfile+0x6a6/0x9a0 fs/xfs/xfs_inode.c:1320
  xfs_rename_alloc_whiteout fs/xfs/xfs_inode.c:3193 [inline]
  xfs_rename+0x58a/0x1e00 fs/xfs/xfs_inode.c:3245
  xfs_vn_rename+0x28e/0x410 fs/xfs/xfs_iops.c:436
  vfs_rename+0x10b5/0x1dd0 fs/namei.c:4329
  do_renameat2+0xa19/0xb10 fs/namei.c:4474
  __do_sys_renameat2 fs/namei.c:4512 [inline]
  __se_sys_renameat2 fs/namei.c:4509 [inline]
  __x64_sys_renameat2+0xe4/0x120 fs/namei.c:4509
  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7f853623d91d

I can reproduce above issue by injecting kernel latency to invalidate 
the quick
judgment of “__percpu_counter_compare()”.
For quick judgment logic, the number of CPUs may have decreased before 
calling
percpu_counter_cpu_dead() when concurrent with CPU offline. That leads to
calculation errors. For example:
Assumption:
(1) batch = 32
(2) The final count is 2
(3) The number of CPUs is 4
If the number of percpu variables on each CPU is as follows when CPU3 is 
offline
cpu0 cpu1 cpu2 cpu3
   31     31     31    31
fbc->count = -122
So at this point, add a check to determine if fbc is greater than 0
abs(count - rhs) = -122
batch * num_ online_ cpus() = 32 * 3 = 96
That is: abs (count rhs)>batch * num_online_cpus() conditions met. The 
actual
value is 2, but the fact that count<0 returns -1 is the opposite.

> We generally don't care about the accuracy of the comparison here
> because we've used percpu_counter_read() which is completely racy
> against on-going updates. e.g. we can get preempted between
> percpu_counter_read() and the check and so the value can be
> completely wrong by the time we actually check it. Hence checking
> online vs online+dying really doesn't fix any of the common race
> conditions that occur here.
>
> Even if we fall through to using percpu_counter_sum() for the
> comparison value, that is still not accurate in the face of racing
> updates to the counter because percpu_counter_sum only prevents
> the percpu counter from being folded back into the global sum
> while it is running. The comparison is still not precise or accurate.
>
> IOWs, the result of this whole function is not guaranteed to be
> precise or accurate; percpu counters cannot ever be relied on for
> exact threshold detection unless there is some form of external
> global counter synchronisation being used for those comparisons
> (e.g. a global spinlock held around all the percpu_counter_add()
> modifications as well as the __percpu_counter_compare() call).
>
> That's always been the issue with unsynchronised percpu counters -
> cpus dying just don't matter here because there are many other more
> common race conditions that prevent accurate, race free comparison
> of per-cpu counters.
>
> Cheers,
>
> Dave.

