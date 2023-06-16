Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47815733AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjFPUh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 16:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjFPUhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 16:37:50 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694773A91
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1686947867;
        bh=lV56SIFY+NaaZGQLbwvxwxZ65X0Qrs1nSQfoFKDC76k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DVxOyhIRHEXTGgYAqb2Nk1nIFJglMpSEFfiWCETrphaVMDdWpdr/quCnlBRuE0Emz
         /OKC17eXzDZZIRrNkOYGPeTzUeCW/D1HnkSU8M0s1PA4wrtEYe1MC0WoRIP9Hw26Eg
         e8jDr5DLMxddVPRUeIdrkwoa4cO2i+P1BuQW9Ckf1HrHTV06+2ssznjSzUzmx1Lti8
         Dd5qNB/xYF7oXC9wqxtNQRFc+G6TrRWjO1mNZigEmGYLk9doXR604HqKTcN9VJphx4
         fPCsujidzidOmd8ULo121p6eZMtHYMyA5qUFVT87M1iBlKFNOVQzoKqC9U94T8kxQt
         ZX96zZfQZTYvg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QjWF70w6dz18YK;
        Fri, 16 Jun 2023 16:37:47 -0400 (EDT)
Message-ID: <efb2e71a-9b18-4ccd-bdbc-3014fae032fc@efficios.com>
Date:   Fri, 16 Jun 2023 16:38:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        Feng Tang <feng.tang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
 <20230616131639.992998157fe696eb0e0589aa@linux-foundation.org>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20230616131639.992998157fe696eb0e0589aa@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 16:16, Andrew Morton wrote:
> On Mon, 15 May 2023 10:35:36 -0400 Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> The mm_struct mm_count field is frequently updated by mmgrab/mmdrop
>> performed by context switch. This causes false-sharing for surrounding
>> mm_struct fields which are read-mostly.
>>
>> This has been observed on a 2sockets/112core/224cpu Intel Sapphire
>> Rapids server running hackbench, and by the kernel test robot
>> will-it-scale testcase.
>>
>> Move the mm_count field into its own cache line to prevent false-sharing
>> with other mm_struct fields.
>>
>> Move mm_count to the first field of mm_struct to minimize the amount of
>> padding required: rather than adding padding before and after the
>> mm_count field, padding is only added after mm_count.
>>
>> Note that I noticed this odd comment in mm_struct:
>>
>> commit 2e3025434a6b ("mm: relocate 'write_protect_seq' in struct mm_struct")
>>
>>                  /*
>>                   * With some kernel config, the current mmap_lock's offset
>>                   * inside 'mm_struct' is at 0x120, which is very optimal, as
>>                   * its two hot fields 'count' and 'owner' sit in 2 different
>>                   * cachelines,  and when mmap_lock is highly contended, both
>>                   * of the 2 fields will be accessed frequently, current layout
>>                   * will help to reduce cache bouncing.
>>                   *
>>                   * So please be careful with adding new fields before
>>                   * mmap_lock, which can easily push the 2 fields into one
>>                   * cacheline.
>>                   */
>>                  struct rw_semaphore mmap_lock;
>>
>> This comment is rather odd for a few reasons:
>>
>> - It requires addition/removal of mm_struct fields to carefully consider
>>    field alignment of _other_ fields,
>> - It expresses the wish to keep an "optimal" alignment for a specific
>>    kernel config.
>>
>> I suspect that the author of this comment may want to revisit this topic
>> and perhaps introduce a split-struct approach for struct rw_semaphore,
>> if the need is to place various fields of this structure in different
>> cache lines.
>>
>> ...
>>
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -583,6 +583,21 @@ struct mm_cid {
>>   struct kioctx_table;
>>   struct mm_struct {
>>   	struct {
>> +		/*
>> +		 * Fields which are often written to are placed in a separate
>> +		 * cache line.
>> +		 */
>> +		struct {
>> +			/**
>> +			 * @mm_count: The number of references to &struct
>> +			 * mm_struct (@mm_users count as 1).
>> +			 *
>> +			 * Use mmgrab()/mmdrop() to modify. When this drops to
>> +			 * 0, the &struct mm_struct is freed.
>> +			 */
>> +			atomic_t mm_count;
>> +		} ____cacheline_aligned_in_smp;
>> +
> 
> Why add the anonymous struct?
> 
> 	atomic_t mm_count ____cacheline_aligned_in_smp;
> 
> would suffice?

The anonymous struct is needed to ensure the mm_count is alone in its 
own cacheline.

An aligned attribute applied to an integer field only aligns the offset 
of that field in the structure, without changing its size. An aligned 
attribute applied to a structure aligns both its offset in the structure 
containing it _and_ extends its size with padding.

This takes care of adding padding _after_ mm_count as well. Alignment on 
a structure requires that the structure size is extended with padding to 
cover the required alignment. Otherwise an array of that structure could 
not have each of its items on a multiple of the required alignment.

> 
> Secondly, the ____cacheline_aligned_in_smp doesn't actually do
> anything?  mm_count is at offset 0 which is cacheline aligned anyway.
> The next field (mm_mt) will share a cacheline with mm_count.

If applied on the integer field, I agree that it would not do anything. 
However, applied on the anonymous structure, it takes care of adding 
padding _after_ the mm_count field, which is exactly what we want here.

> 
> If the plan is to put mm_count in "its own" cacheline then padding will
> be needed?

It's taken care of by the anonymous structure trick. Here is an quick 
example showing the difference between alignment attribute applied to an 
integer type vs to an anonymous structure:

#include <stdio.h>

struct s1 {
         int a __attribute__((aligned(32)));
         int b;
};

struct s2 {
         int a;
         int b __attribute__((aligned(32)));
};

struct s3 {
         struct {
                 int a;
         } __attribute__((aligned(32)));
         int b;
};

int main()
{
         struct s1 t1;
         struct s2 t2;
         struct s3 t3;

         printf("%d %d\n", (unsigned long)&t1.a - (unsigned long)&t1,
                         (unsigned long)&t1.b - (unsigned long)&t1);
         printf("%d %d\n", (unsigned long)&t2.a - (unsigned long)&t2,
                         (unsigned long)&t2.b - (unsigned long)&t2);
         printf("%d %d\n", (unsigned long)&t3.a - (unsigned long)&t3,
                         (unsigned long)&t3.b - (unsigned long)&t3);
         return 0;
}

Result:

0 4
0 32
0 32

Applying the aligned attribute on the integer field would require 
explicit padding, because it does not add padding after the field.

Applying the aligned attribute on the _following_ field would work, but 
it's rather odd and error-prone.

Applying the aligned attribute on an anonymous structure clearly 
documents the intent, and adds the padding that guarantees this variable 
is alone in its cache line.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

