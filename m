Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167616E973D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjDTOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDTOfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:35:16 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D7A7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1682001314;
        bh=8ZBBaOgr088FiPgbci74Z2Eqlr+yLhPX+q+5IIPuxmQ=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=en46sEw5h1ERF/w8DtSig2fQcFc1QwYdUjMOgUX6NsXqtwAhSQaip4ebQChQ3P8OC
         jR77as3j3esp+zd/TeqyN/Bfm+VAzkvR9fYJCs52GAxb4swk+TjeWlAiaTzZbuHoC5
         ggqgxyb2ypiYUGmJfIIdAraPEsaYNsaESIOdHrqG0HtJMKSrRiDL0J5u8jn3OrQJyZ
         vR7g0TWfLfJX9S3hkHe6bl/4y8z+arbdo/Lj4h/0iTOqTRWEmsendAoBqGVXYkOsO7
         WxPz6GldJlP2LA0S4ZCg2AQjah8NcSJtymzoG2Uv+kxjL4quzHjwbvwvXxg8U9ickC
         8zcsno7VZkEHA==
Received: from [172.16.0.91] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Q2Kv62NmZzwPh;
        Thu, 20 Apr 2023 10:35:14 -0400 (EDT)
Message-ID: <d96164a6-c522-1bfc-8b37-333726cdc573@efficios.com>
Date:   Thu, 20 Apr 2023 10:35:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Content-Language: en-US
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
In-Reply-To: <7a0c1db1-103d-d518-ed96-1584a28fbf32@efficios.com>
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

On 2023-04-20 09:54, Mathieu Desnoyers wrote:
> On 2023-04-20 09:35, Aaron Lu wrote:
> [...]
>>>>>
>>>>> Then we clearly have another member of mm_struct on the same cache 
>>>>> line as
>>>>> pcpu_cid which is bouncing all over the place and causing 
>>>>> false-sharing. Any
>>>>> idea which field(s) are causing this ?
>>>>
>>>> That's my first reaction too but as I said in an earlier reply:
>>>> https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
>>>> I've tried to place pcpu_cid into a dedicate cacheline with no other
>>>> fields sharing a cacheline with it in mm_struct but it didn't help...
>>>
>>> I see two possible culprits there:
>>>
>>> 1) The mm_struct pcpu_cid field is suffering from false-sharing. I 
>>> would be
>>>     interested to look at your attempt to move it to a separate cache 
>>> line to
>>>     try to figure out what is going on.
>>
>> Brain damaged...my mistake, I only made sure its following fields not
>> share the same cacheline but forgot to exclude its preceding fields and
>> turned out it's one(some?) of the preceeding fields that caused false
>> sharing. When I did:
>>
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 5eab61156f0e..a6f9d815991c 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -606,6 +606,7 @@ struct mm_struct {
>>                   */
>>                  atomic_t mm_count;
>>   #ifdef CONFIG_SCHED_MM_CID
>> +               CACHELINE_PADDING(_pad1_);
>>                  /**
>>                   * @pcpu_cid: Per-cpu current cid.
>>                   *
>> mm_cid_get() dropped to 0.0x% when running hackbench :-)
> 
> Now we are talking! :)
> 
>>
>> sched_mm_cid_migrate_to() is about 4% with most cycles spent on
>> accessing mm->mm_users:
>>
>>         │     dst_cid = READ_ONCE(dst_pcpu_cid->cid);
>>    0.03 │       mov     0x8(%r12),%r15d
>>         │     if (!mm_cid_is_unset(dst_cid) &&
>>    0.07 │       cmp     $0xffffffff,%r15d
>>         │     ↓ je      87
>>         │     arch_atomic_read():
>>         │     {
>>         │     /*
>>         │     * Note for KASAN: we deliberately don't use 
>> READ_ONCE_NOCHECK() here,
>>         │     * it's non-inlined function that increases binary size 
>> and stack usage.
>>         │     */
>>         │     return __READ_ONCE((v)->counter);
>>   76.13 │       mov     0x54(%r13),%eax
>>         │     sched_mm_cid_migrate_to():
>>         │       cmp     %eax,0x410(%rdx)
>>   21.71 │     ↓ jle     1d8
>>         │     atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)
>>
>> With this info, it should be mm_users that caused false sharing for
>> pcpu_cid previously. Looks like mm_users is bouncing.
> 
> I suspect that the culprit here is mm_count rather than mm_users. 
> mm_users just happens to share the same cache line as mm_count.
> 
> mm_count is incremented/decremented with mmgrab()/mmdrop() during
> context switch.
> 
> This is likely causing other issues, for instance, the
> membarrier_state field is AFAIR read-mostly, used for 
> membarrier_mm_sync_core_before_usermode() to issue core
> sync before every return to usermode if needed.
> 
> Other things like mm_struct pgd pointer appear to be likely
> read-mostly variables.
> 
> I suspect it's mm_count which should be moved to its own cache line
> to eliminate false-sharing with all the other read-mostly fields
> of mm_struct.

I have prepared a patch which moves the mm_count field into its own
cache line, but after a quick discussion with Peter Zijlstra, it appears
that the work on lazy-tlb refcounting currently in

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/lazy

will take care of this by entirely removing the reference counting for lazy TLB.

So with this, I suspect we are as good as we can be in terms of near-zero
footprint for the mm_cid feature, right ?

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a57e6ae78e65..f740fa447df1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -553,6 +553,21 @@ struct vm_area_struct {
  struct kioctx_table;
  struct mm_struct {
  	struct {
+		/*
+		 * Fields which are often written to are placed in a separate
+		 * cache line.
+		 */
+		struct {
+			/**
+			 * @mm_count: The number of references to &struct mm_struct
+			 * (@mm_users count as 1).
+			 *
+			 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
+			 * &struct mm_struct is freed.
+			 */
+			atomic_t mm_count;
+		} ____cacheline_aligned_in_smp;
+
  		struct maple_tree mm_mt;
  #ifdef CONFIG_MMU
  		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -590,14 +605,6 @@ struct mm_struct {
  		 */
  		atomic_t mm_users;
  
-		/**
-		 * @mm_count: The number of references to &struct mm_struct
-		 * (@mm_users count as 1).
-		 *
-		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
-		 * &struct mm_struct is freed.
-		 */
-		atomic_t mm_count;
  #ifdef CONFIG_SCHED_MM_CID
  		/**
  		 * @cid_lock: Protect cid bitmap updates vs lookups.
  



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

