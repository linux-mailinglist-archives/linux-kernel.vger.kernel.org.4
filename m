Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF616E975E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjDTOlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbjDTOlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:41:09 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FC12709
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1682001666;
        bh=aX3QHlLhwlOuT8ILYxc/AT/1EhCKwbhaHkbg85dPvZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AIplAi/tnmoNG7JvbiYE0dhJsYG0q5gisipURrJJUQVHdA0rMgOa6J5o4LEnCRPeX
         X/EslNAzi7SixJNWQIScIL6ZKQOEkTrs85cNcmQGbyjtxTi1LUmvXjWFDd8AJ6mUP5
         lDDRUtmPdrU9ARuMLjSFutrGtSoaQGyjdmW5MR65CbKlqGUDPxKqatY/Jr1Nvn7uxw
         t6YlqDZDUDcQlTgaiTP6odYgpr80e60DZpCifPp+WrkpxGInN0+GwTsS5sFFWaRTcV
         LzPihP2tu5xYu7Zi2eTYIBN2fv+XiKtUi0fzfs4D6/o//MI7k4XysTJgG5lGovT5NK
         kT1cj+c1ZI8Kw==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q2L1t38XvzwKJ;
        Thu, 20 Apr 2023 10:41:06 -0400 (EDT)
Message-ID: <d5c394f8-5833-6e5c-2155-6160415cfd92@efficios.com>
Date:   Thu, 20 Apr 2023 10:41:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Content-Language: en-US
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Olivier Dion <odion@efficios.com>,
        michael.christie@oracle.com
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
 <20230420095610.GA153295@ziqianlu-desk2>
 <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
 <20230420125048.GA154262@ziqianlu-desk2>
 <721f4b8b-c238-53b1-9085-a9dae6a961e1@efficios.com>
 <20230420133519.GA154479@ziqianlu-desk2>
 <7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com>
 <20230420141852.GA154815@ziqianlu-desk2>
 <20230420143910.GB154815@ziqianlu-desk2>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230420143910.GB154815@ziqianlu-desk2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-20 10:39, Aaron Lu wrote:
> On Thu, Apr 20, 2023 at 10:18:52PM +0800, Aaron Lu wrote:
>> On Thu, Apr 20, 2023 at 09:54:29AM -0400, Mathieu Desnoyers wrote:
>>> On 2023-04-20 09:35, Aaron Lu wrote:
>>> [...]
>>>>>>>
>>>>>>> Then we clearly have another member of mm_struct on the same cache line as
>>>>>>> pcpu_cid which is bouncing all over the place and causing false-sharing. Any
>>>>>>> idea which field(s) are causing this ?
>>>>>>
>>>>>> That's my first reaction too but as I said in an earlier reply:
>>>>>> https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
>>>>>> I've tried to place pcpu_cid into a dedicate cacheline with no other
>>>>>> fields sharing a cacheline with it in mm_struct but it didn't help...
>>>>>
>>>>> I see two possible culprits there:
>>>>>
>>>>> 1) The mm_struct pcpu_cid field is suffering from false-sharing. I would be
>>>>>      interested to look at your attempt to move it to a separate cache line to
>>>>>      try to figure out what is going on.
>>>>
>>>> Brain damaged...my mistake, I only made sure its following fields not
>>>> share the same cacheline but forgot to exclude its preceding fields and
>>>> turned out it's one(some?) of the preceeding fields that caused false
>>>> sharing. When I did:
>>>>
>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>>> index 5eab61156f0e..a6f9d815991c 100644
>>>> --- a/include/linux/mm_types.h
>>>> +++ b/include/linux/mm_types.h
>>>> @@ -606,6 +606,7 @@ struct mm_struct {
>>>>                    */
>>>>                   atomic_t mm_count;
>>>>    #ifdef CONFIG_SCHED_MM_CID
>>>> +               CACHELINE_PADDING(_pad1_);
>>>>                   /**
>>>>                    * @pcpu_cid: Per-cpu current cid.
>>>>                    *
>>>> mm_cid_get() dropped to 0.0x% when running hackbench :-)
>>>
>>> Now we are talking! :)
>>>
>>>>
>>>> sched_mm_cid_migrate_to() is about 4% with most cycles spent on
>>>> accessing mm->mm_users:
>>>>
>>>>          │     dst_cid = READ_ONCE(dst_pcpu_cid->cid);
>>>>     0.03 │       mov     0x8(%r12),%r15d
>>>>          │     if (!mm_cid_is_unset(dst_cid) &&
>>>>     0.07 │       cmp     $0xffffffff,%r15d
>>>>          │     ↓ je      87
>>>>          │     arch_atomic_read():
>>>>          │     {
>>>>          │     /*
>>>>          │     * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
>>>>          │     * it's non-inlined function that increases binary size and stack usage.
>>>>          │     */
>>>>          │     return __READ_ONCE((v)->counter);
>>>>    76.13 │       mov     0x54(%r13),%eax
>>>>          │     sched_mm_cid_migrate_to():
>>>>          │       cmp     %eax,0x410(%rdx)
>>>>    21.71 │     ↓ jle     1d8
>>>>          │     atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
>>>>
>>>> With this info, it should be mm_users that caused false sharing for
>>>> pcpu_cid previously. Looks like mm_users is bouncing.
>>>
>>> I suspect that the culprit here is mm_count rather than mm_users. mm_users
>>> just happens to share the same cache line as mm_count.
>>>
>>> mm_count is incremented/decremented with mmgrab()/mmdrop() during
>>> context switch.
>>>
>>> This is likely causing other issues, for instance, the
>>> membarrier_state field is AFAIR read-mostly, used for
>>> membarrier_mm_sync_core_before_usermode() to issue core
>>> sync before every return to usermode if needed.
>>>
>>> Other things like mm_struct pgd pointer appear to be likely
>>> read-mostly variables.
>>>
>>> I suspect it's mm_count which should be moved to its own cache line
>>> to eliminate false-sharing with all the other read-mostly fields
>>> of mm_struct.
>>>
>>> Thoughts ?
>>
>> Makes sesne, I was wondering where the write side of mm_user is. Let me
>> see how that goes by placing mm_count aside from other read mostly fields.
> 
> With the following naive padding for mm_count:
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5eab61156f0e..866696e2d83e 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -604,7 +604,9 @@ struct mm_struct {
>                   * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
>                   * &struct mm_struct is freed.
>                   */
> +               CACHELINE_PADDING(_pad1_);
>                  atomic_t mm_count;
> +               CACHELINE_PADDING(_pad2_);
>   #ifdef CONFIG_SCHED_MM_CID
>                  /**
>                   * @pcpu_cid: Per-cpu current cid.
> 
> mm_cid_get() is about 0.1% and sched_mm_cid_migrate_to() is about 0.2%
> for hackbench on SPR :-)

Allright, then our work is done here. I'm popping the champagne.

I'm doing some more testing on v10 which includes a fix for the
time-snapshot wrong runqueue, and I'll post it today.

Thanks a lot for your help ! :-)

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

