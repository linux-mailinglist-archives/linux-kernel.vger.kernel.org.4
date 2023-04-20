Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAB6E94B4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjDTMjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjDTMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:38:54 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6A4221
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681994327;
        bh=Tb2lmmehqfarpNiwJjg5fLRXiWjGvaWeqi3pLJHnzD4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OAb07enpAgQ0C9UMe/0FwHN+Claghh/fvHxCNq946mFEjB5od5f6mjvUUNTL/heAK
         QH3lETQ7JC2qpbYy5wzhvt309cH19U0ZePShgNWdJnyfaFpwK1Ui5Lj0x94ZDgvfhP
         MoRrUQHjOP7MSYenDXAduY6i2wnlUreSc7Z2+YSnDHaRSaAyT9csCwEQcBQ3amdPEZ
         Ce220ox18hZGg9MwwcOKfX2axD0x2bh4ZgYjO6ef6jC0E3MrOvCB6D6QsWIsxgzT6b
         QYdZrI3NdGipOh3dW3DC1/66tM2rFC4jE4Ivm2nAWWwnjh3LuTjGUwcshjPr0aA8sw
         dXxwqSgyJEmDA==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q2HJk6cDKzwMt;
        Thu, 20 Apr 2023 08:38:46 -0400 (EDT)
Message-ID: <6b6569e2-895c-69a8-0c15-838bbe1d3233@efficios.com>
Date:   Thu, 20 Apr 2023 08:38:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v8] sched: Fix performance regression introduced by
 mm_cid
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230417150831.264780-1-mathieu.desnoyers@efficios.com>
 <20230420060004.GA52173@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230420060004.GA52173@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 02:00, Aaron Lu wrote:
> On Mon, Apr 17, 2023 at 11:08:31AM -0400, Mathieu Desnoyers wrote:
> 
>> +/*
>> + * Save a snapshot of the current runqueue time of this cpu
>> + * with the per-cpu cid value, allowing to estimate how recently it was used.
>> + */
>> +static inline void mm_cid_snapshot_time(struct mm_struct *mm)
>>   {
>> -	lockdep_assert_irqs_disabled();
>> -	if (cid < 0)
>> -		return;
>> -	raw_spin_lock(&mm->cid_lock);
>> -	__cpumask_clear_cpu(cid, mm_cidmask(mm));
>> -	raw_spin_unlock(&mm->cid_lock);
>> +	struct rq *rq = this_rq();
>> +	struct mm_cid *pcpu_cid;
>> +
>> +	lockdep_assert_rq_held(rq);
> 
> On wake up path when src_cid is migrated to dst_cid, this rq is the waker
> rq and is not locked, the wakee's dst_rq is locked.

Doh, yes, good catch thanks! This one was puzzling me.

I'll fix this in my next version.

Thanks,

Mathieu

> 
> I got below warning on a VM boot with v8:
> 
> [    2.496964] ------------[ cut here ]------------
> [    2.497499] WARNING: CPU: 13 PID: 99 at kernel/sched/sched.h:1357 sched_mm_cid_migrate_to+0x2ce/0x330
> [    2.498478] Modules linked in:
> [    2.498481] CPU: 13 PID: 99 Comm: kworker/u32:5 Tainted: G        W 6.3.0-rc7-00002-gb8012ce004f4 #32
> [    2.498484] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.1-2.fc36 04/01/2014
> [    2.498485] Workqueue: events_unbound flush_to_ldisc
> [    2.501094] RIP: 0010:sched_mm_cid_migrate_to+0x2ce/0x330
> [    2.501099] Code: 45 89 74 24 08 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 48 8d 7b 18 be ff ff ff ff7
> [    2.503101] RSP: 0018:ffffc900003d7ac0 EFLAGS: 00010046
> [    2.503608] RAX: 0000000000000000 RBX: ffff88842f3fe700 RCX: 0000000000000001
> [    2.504313] RDX: 0000000000000000 RSI: ffffffff823ccffd RDI: ffffffff8244e8fe
> [    2.505000] RBP: ffffe8ffff20c268 R08: 00000000954b8e6a R09: 00000000950aa3ff
> [    2.505680] R10: 00000000f950aa3f R11: ffff88810005e900 R12: ffffe8fffe60c268
> [    2.506406] R13: ffff88810005e900 R14: 0000000000000000 R15: 00000000ffffffff
> [    2.506935] FS:  0000000000000000(0000) GS:ffff88842f200000(0000) knlGS:0000000000000000
> [    2.507375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.507678] CR2: 00007f0aadff6db8 CR3: 0000000106ba2002 CR4: 0000000000770ee0
> [    2.508050] PKRU: 55555554
> [    2.508209] Call Trace:
> [    2.508342]  <TASK>
> [    2.508492]  ttwu_do_activate+0x129/0x300
> [    2.508727]  try_to_wake_up+0x2b7/0x8a0
> [    2.508963]  ep_autoremove_wake_function+0x11/0x50
> [    2.509259]  __wake_up_common+0x83/0x1a0
> [    2.509481]  __wake_up_common_lock+0x81/0xd0
> [    2.509738]  ep_poll_callback+0x147/0x310
> [    2.509965]  __wake_up_common+0x83/0x1a0
> [    2.510185]  __wake_up_common_lock+0x81/0xd0
> [    2.510463]  n_tty_receive_buf_common+0x235/0x6a0
> [    2.510728]  tty_port_default_receive_buf+0x3d/0x70
> [    2.510987]  flush_to_ldisc+0x9b/0x1a0
> [    2.511191]  process_one_work+0x27a/0x560
> [    2.511420]  worker_thread+0x4f/0x3b0
> [    2.511657]  ? __pfx_worker_thread+0x10/0x10
> [    2.511930]  kthread+0xf2/0x120
> [    2.512108]  ? __pfx_kthread+0x10/0x10
> [    2.512340]  ret_from_fork+0x29/0x50
> [    2.512552]  </TASK>
> [    2.512679] ---[ end trace 0000000000000000 ]---
> 
> $ ./scripts/faddr2line ../guest_debug/vmlinux sched_mm_cid_migrate_to+0x2ce
> sched_mm_cid_migrate_to+0x2ce/0x330:
> lockdep_assert_rq_held at kernel/sched/sched.h:1357
> (inlined by) mm_cid_snapshot_time at kernel/sched/sched.h:3355
> (inlined by) sched_mm_cid_migrate_to at kernel/sched/core.c:11666
> 
>> +	pcpu_cid = this_cpu_ptr(mm->pcpu_cid);
>> +	WRITE_ONCE(pcpu_cid->time, rq->clock);
>> +}
>> +
> 
> Thanks,
> Aaron

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

