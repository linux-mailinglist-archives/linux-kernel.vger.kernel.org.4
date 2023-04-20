Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66176E965F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjDTNyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjDTNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:54:33 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2B149DE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1681998868;
        bh=rwRmM182sXNTsr0ux7x6RIMVFw6JsvFJTo2rNUdgULw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TOS7Tusj4vsdteE3MVM3OI5Tph7UQUIi+f2A626dVVCWrpP7ZApXjQxn98mrw2QZk
         Kf6ZEW6ZzkxReQm/DfpvEygqYdY0ArpEcLYzc4bwKEG5L/cZAS4g7ALgNbseZ44ASm
         Y4MLNKq2Mrq6L6GeURg7QALudQPllE1jSGyTEeGUGpVoOXmv9c048mCHMgY8bcA/PN
         GYMGsiYeEHSMTyzwxwUTiqr+hBKN47R/pXM40MB2xtNFdUZn4fc3x7wqREhRwnB/bz
         kVsqSpdHaH1Y1+tRe7TcQNydQTV20Ll+DX6Agn+qJKmVj+mKrp4jAcTKPQk2irP89b
         N4KXnE2oyp5Vg==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q2K04519Vzw2t;
        Thu, 20 Apr 2023 09:54:28 -0400 (EDT)
Message-ID: <7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com>
Date:   Thu, 20 Apr 2023 09:54:29 -0400
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
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230420133519.GA154479@ziqianlu-desk2>
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

On 2023-04-20 09:35, Aaron Lu wrote:
[...]
>>>>
>>>> Then we clearly have another member of mm_struct on the same cache line as
>>>> pcpu_cid which is bouncing all over the place and causing false-sharing. Any
>>>> idea which field(s) are causing this ?
>>>
>>> That's my first reaction too but as I said in an earlier reply:
>>> https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
>>> I've tried to place pcpu_cid into a dedicate cacheline with no other
>>> fields sharing a cacheline with it in mm_struct but it didn't help...
>>
>> I see two possible culprits there:
>>
>> 1) The mm_struct pcpu_cid field is suffering from false-sharing. I would be
>>     interested to look at your attempt to move it to a separate cache line to
>>     try to figure out what is going on.
> 
> Brain damaged...my mistake, I only made sure its following fields not
> share the same cacheline but forgot to exclude its preceding fields and
> turned out it's one(some?) of the preceeding fields that caused false
> sharing. When I did:
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5eab61156f0e..a6f9d815991c 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -606,6 +606,7 @@ struct mm_struct {
>                   */
>                  atomic_t mm_count;
>   #ifdef CONFIG_SCHED_MM_CID
> +               CACHELINE_PADDING(_pad1_);
>                  /**
>                   * @pcpu_cid: Per-cpu current cid.
>                   *
> mm_cid_get() dropped to 0.0x% when running hackbench :-)

Now we are talking! :)

> 
> sched_mm_cid_migrate_to() is about 4% with most cycles spent on
> accessing mm->mm_users:
> 
>         │     dst_cid = READ_ONCE(dst_pcpu_cid->cid);
>    0.03 │       mov     0x8(%r12),%r15d
>         │     if (!mm_cid_is_unset(dst_cid) &&
>    0.07 │       cmp     $0xffffffff,%r15d
>         │     ↓ je      87
>         │     arch_atomic_read():
>         │     {
>         │     /*
>         │     * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
>         │     * it's non-inlined function that increases binary size and stack usage.
>         │     */
>         │     return __READ_ONCE((v)->counter);
>   76.13 │       mov     0x54(%r13),%eax
>         │     sched_mm_cid_migrate_to():
>         │       cmp     %eax,0x410(%rdx)
>   21.71 │     ↓ jle     1d8
>         │     atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
> 
> With this info, it should be mm_users that caused false sharing for
> pcpu_cid previously. Looks like mm_users is bouncing.

I suspect that the culprit here is mm_count rather than mm_users. 
mm_users just happens to share the same cache line as mm_count.

mm_count is incremented/decremented with mmgrab()/mmdrop() during
context switch.

This is likely causing other issues, for instance, the
membarrier_state field is AFAIR read-mostly, used for 
membarrier_mm_sync_core_before_usermode() to issue core
sync before every return to usermode if needed.

Other things like mm_struct pgd pointer appear to be likely
read-mostly variables.

I suspect it's mm_count which should be moved to its own cache line
to eliminate false-sharing with all the other read-mostly fields
of mm_struct.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

