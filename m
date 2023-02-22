Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D217069ED64
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjBVDRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjBVDRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:17:24 -0500
X-Greylist: delayed 56440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Feb 2023 19:17:03 PST
Received: from out-43.mta1.migadu.com (out-43.mta1.migadu.com [95.215.58.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5A34C30
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 19:17:03 -0800 (PST)
Message-ID: <06e1cc6b-8bf7-d2c4-f7de-3cc055f1c866@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1677035821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AlCqFyRXR87fMMJnatrMQs6RG0BLM7Ph0KJRn89LrAI=;
        b=wdod7o6veTf4Bj9vgrtn5+Imv5R8edJL817NInWX61jRzKL0+jfjVc94G7ooCCiv0W/oSL
        DoodIUY0s9xYYgnv4aHfQ+4zCzjY1cYhH1qBpsEFqGRySgksEpF9iqCdsmGkR7CAmWomUo
        tTNAWUupasexqA0Kxb5EkSEOQxv1ftQ=
Date:   Wed, 22 Feb 2023 11:16:55 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdkfd: Fix an illegal memory access
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
        christian.koenig@amd.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <eb49be7c44ae95c4d18e66b59874ef1c@linux.dev>
 <48e5eae7-4848-3aa2-2cb4-5c7ba32a9848@amd.com>
 <c16136b3-d6d6-392e-7d58-cd81bcf426f6@wanadoo.fr>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qu Huang <qu.huang@linux.dev>
In-Reply-To: <c16136b3-d6d6-392e-7d58-cd81bcf426f6@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/22 3:17, Christophe JAILLET wrote:
> Le 21/02/2023 à 17:26, Felix Kuehling a écrit :
>>
>> On 2023-02-21 06:35, qu.huang-fxUVXftIFDnyG1zEObXtfA@public.gmane.org wrote:
>>> From: Qu Huang <qu.huang-fxUVXftIFDnyG1zEObXtfA@public.gmane.org>
>>>
>>> In the kfd_wait_on_events() function, the kfd_event_waiter structure is
>>> allocated by alloc_event_waiters(), but the event field of the waiter
>>> structure is not initialized; When copy_from_user() fails in the
>>> kfd_wait_on_events() function, it will enter exception handling to
>>> release the previously allocated memory of the waiter structure;
>>> Due to the event field of the waiters structure being accessed
>>> in the free_waiters() function, this results in illegal memory access
>>> and system crash, here is the crash log:
>>>
>>> localhost kernel: RIP: 0010:native_queued_spin_lock_slowpath+0x185/0x1e0
>>> localhost kernel: RSP: 0018:ffffaa53c362bd60 EFLAGS: 00010082
>>> localhost kernel: RAX: ff3d3d6bff4007cb RBX: 0000000000000282 RCX: 00000000002c0000
>>> localhost kernel: RDX: ffff9e855eeacb80 RSI: 000000000000279c RDI: ffffe7088f6a21d0
>>> localhost kernel: RBP: ffffe7088f6a21d0 R08: 00000000002c0000 R09: ffffaa53c362be64
>>> localhost kernel: R10: ffffaa53c362bbd8 R11: 0000000000000001 R12: 0000000000000002
>>> localhost kernel: R13: ffff9e7ead15d600 R14: 0000000000000000 R15: ffff9e7ead15d698
>>> localhost kernel: FS:  0000152a3d111700(0000) GS:ffff9e855ee80000(0000) knlGS:0000000000000000
>>> localhost kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> localhost kernel: CR2: 0000152938000010 CR3: 000000044d7a4000 CR4: 00000000003506e0
>>> localhost kernel: Call Trace:
>>> localhost kernel: _raw_spin_lock_irqsave+0x30/0x40
>>> localhost kernel: remove_wait_queue+0x12/0x50
>>> localhost kernel: kfd_wait_on_events+0x1b6/0x490 [hydcu]
>>> localhost kernel: ? ftrace_graph_caller+0xa0/0xa0
>>> localhost kernel: kfd_ioctl+0x38c/0x4a0 [hydcu]
>>> localhost kernel: ? kfd_ioctl_set_trap_handler+0x70/0x70 [hydcu]
>>> localhost kernel: ? kfd_ioctl_create_queue+0x5a0/0x5a0 [hydcu]
>>> localhost kernel: ? ftrace_graph_caller+0xa0/0xa0
>>> localhost kernel: __x64_sys_ioctl+0x8e/0xd0
>>> localhost kernel: ? syscall_trace_enter.isra.18+0x143/0x1b0
>>> localhost kernel: do_syscall_64+0x33/0x80
>>> localhost kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> localhost kernel: RIP: 0033:0x152a4dff68d7
>>>
>>> Signed-off-by: Qu Huang <qu.huang-fxUVXftIFDnyG1zEObXtfA@public.gmane.org>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> index 729d26d..e5faaad 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> @@ -787,6 +787,7 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
>>>       for (i = 0; (event_waiters) && (i < num_events) ; i++) {
>>>           init_wait(&event_waiters[i].wait);
>>>           event_waiters[i].activated = false;
>>> +        event_waiters[i].event = NULL;
>>
>> Thank you for catching this. We're often lazy about initializing things to NULL or 0 because most of our data structures are allocated with kzalloc or similar. I'm not sure why we're not doing this here. If we allocated event_waiters with kcalloc, we could also remove the initialization of activated. I think that would be the cleaner and safer solution.
>
> Hi,
>
> I think that the '(event_waiters) &&' in the 'for' can also be removed.
> 'event_waiters' is already NULL tested a few lines above
>
>
> Just my 2c.
>
> CJ
>

Thanks for the suggestions from Felix and CJ, I have re-submitted patch v2, please review it：

https://lore.kernel.org/all/ea5b997309825b21e406f9bad2ce8779@linux.dev/

Regards,

Qu


>>
>> Regards,
>>    Felix
>>
>>
>>>       }
>>>
>>>       return event_waiters;
>>> -- 
>>> 1.8.3.1
>>
>
