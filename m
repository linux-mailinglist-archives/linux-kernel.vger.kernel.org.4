Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1E461EF05
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiKGJa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKGJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:30:54 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BD813F99;
        Mon,  7 Nov 2022 01:30:52 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N5Qr764m2zJnT5;
        Mon,  7 Nov 2022 17:27:51 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 17:30:40 +0800
Received: from [10.67.108.67] (10.67.108.67) by dggpemm500013.china.huawei.com
 (7.185.36.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 7 Nov
 2022 17:30:40 +0800
Message-ID: <c01b8c85-59d0-20a8-5e72-4e628a84bf05@huawei.com>
Date:   Mon, 7 Nov 2022 17:30:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] ACPICA: Fix use-after-free in acpi_ps_parse_aml()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <robert.moore@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <lenb@kernel.org>, <lv.zheng@intel.com>
References: <20221019073443.248215-1-chenzhongjin@huawei.com>
 <CAJZ5v0hV2AFEgiuxxbDFUWLa0ZthSz3a=-9U4pjXm-GmmSgexw@mail.gmail.com>
 <CAJZ5v0jPCGoss6X5bmv9Nw9ZxrDxirEEMh6UKSgOoArs2d9ffA@mail.gmail.com>
Content-Language: en-US
From:   Chen Zhongjin <chenzhongjin@huawei.com>
In-Reply-To: <CAJZ5v0jPCGoss6X5bmv9Nw9ZxrDxirEEMh6UKSgOoArs2d9ffA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.108.67]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2022/11/6 3:00, Rafael J. Wysocki wrote:
> On Fri, Oct 28, 2022 at 5:46 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Wed, Oct 19, 2022 at 9:38 AM Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>>> KASAN reports a use-after-free problem and causes kernel panic
>>> triggered by: modprobe acpiphp_ibm
>>>
>>> BUG: KASAN:
>>> use-after-free in acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
>>> Read of size 8 at addr ffff888002f843f0 by task modprobe/519
>>>
>>> CPU: 2 PID: 519 Comm: modprobe Not tainted 6.0.0+
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
>>>      Call Trace:
>>>      <TASK>
>>>      acpi_ds_dump_method_stack (drivers/acpi/acpica/dsdebug.c:145)
>>>      acpi_ds_method_error (drivers/acpi/acpica/dsmethod.c:232)
>>>      acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
>>>      ...
>>>      </TASK>
>>>
>>>      Allocated by task 519:
>>>      ...
>>>      __kasan_kmalloc (mm/kasan/common.c:526)
>>>      acpi_ds_create_walk_state (drivers/acpi/acpica/dswstate.c:519)
>>>      acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:498)
>>>      acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
>>>      ...
>>>
>>>      Freed by task 519:
>>>      ...
>>>      __kmem_cache_free+0xb6/0x3c0
>>>      acpi_ds_delete_walk_state (drivers/acpi/acpica/dswstate.c:722)
>>>      acpi_ds_call_control_method (drivers/acpi/acpica/dsmethod.c:586)
>>>      acpi_ps_parse_aml (drivers/acpi/acpica/psparse.c:607)
>>>      ...
>>> ---[ end Kernel panic - not syncing: Fatal exception ]---
>>>
>>> In the error path in acpi_ps_parse_aml():
>>>
>>>      acpi_ds_call_control_method()
>>>          acpi_ds_create_walk_state()
>>>              acpi_ds_push_walk_state()
>>>              # thread->walk_state_list = walk_state
>>>
>>>          acpi_ds_init_aml_walk # *fail*
>>>          goto cleanup:
>>>          acpi_ds_delete_walk_state() # ACPI_FREE(walk_state)
>>>
>>>      acpi_ds_method_error()
>>>          acpi_ds_dump_method_stack()
>>>          # using freed thread->walk_state_list
>>>
>>> Briefly, the walk_state is pushed to thread, and freed without being poped.
>>> Then it is used in acpi_ds_dump_method_stack() and causes use-after-free.
>>>
>>> Add acpi_ds_pop_walk_state(thread) to the error path to fix the problem.
>>>
>>> Fixes: 0bac4295526c ("ACPICA: Dispatcher: Move stack traversal code to dispatcher")
>>>
>>> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
>> This should be submitted to the upstream project on GitHub, but it
>> looks bad enough, so I'll take care of this.
>>
>> Applied as 6.1-rc material, thanks!
>>
>>> ---
>>>   drivers/acpi/acpica/dsmethod.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
>>> index ae2e768830bf..19da7fc73186 100644
>>> --- a/drivers/acpi/acpica/dsmethod.c
>>> +++ b/drivers/acpi/acpica/dsmethod.c
>>> @@ -581,6 +581,7 @@ acpi_ds_call_control_method(struct acpi_thread_state *thread,
>>>
>>>          acpi_ds_terminate_control_method(obj_desc, next_walk_state);
>>>          acpi_ds_delete_walk_state(next_walk_state);
>>> +       acpi_ds_pop_walk_state(thread);
> On second thought, though, should it be popped before deleting?
> Otherwise it looks like there will be still use-after-free, because
> acpi_ds_pop_walk_state() accesses the walk_state at the top of the
> queue.

You are right it is wrong and sorry I didn't notice that.

I have reproduced same problem on current tree... Have no idea why I 
missed it before.


I noticed that this patch have been on next-tree so I submitted another 
one to fix it.

See "ACPICA: Fix pop_walk_state called after walk_state is deleted"


Thanks for your time!

Best,

Chen

> Moreover, it is not correct to pop the walk state if next_walk_state
> is NULL AFAICS.
>
> I'm dropping this one.
>
>
>>>          return_ACPI_STATUS(status);
>>>   }
>>> --
>> Bob, this looks correct to me, but I may be missing something in which
>> case please let me know.
