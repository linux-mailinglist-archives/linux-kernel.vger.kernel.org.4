Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56894734220
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 18:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236162AbjFQQIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 12:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjFQQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 12:08:12 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CB2E49
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 09:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1687018088;
        bh=hgJzCXMmkqHB9zu6/hj+qfZRgZydP6kjIOD4e+oiFOA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mFQYEPED4gaJvcYd/O4g7kh85pD3HfCmBmGvIdkS/CeO1+GqM6lShnYTTr3gpOD2+
         +iKvK1voevlX17Etylc0ncbsfG76IkRi6lPWDut+biCo0o6va+ldebHsmIFyR0xzty
         TO3f2nkKYAPn6oWlXhHYHC8Ht1IvR5SVTchaWB3V5GAHKaWalLKNsGygXSJQLt7hZf
         DaEMIT6rD4t+zxqIlThQLOyMXAdimtHB6OlVSTW5ezrhv8uSjbw7vcy1cJWeH1ef9q
         Gepq+uI6pknU4ySsG6OkjP6aKYS/SCcTBCF03JCrLxITrO0xwqw4+24U6fsSlP706T
         jAluni3D9LDyA==
Received: from [192.168.18.28] (unknown [107.159.220.152])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qk1CX03Ksz18k0;
        Sat, 17 Jun 2023 12:08:07 -0400 (EDT)
Message-ID: <6bbbb1f9-fc2b-c95d-5ef1-c178cfaae1ba@efficios.com>
Date:   Sat, 17 Jun 2023 12:08:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] mm: Move mm_count into its own cache line
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Olivier Dion <odion@efficios.com>, michael.christie@oracle.com,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-mm@kvack.org
References: <20230515143536.114960-1-mathieu.desnoyers@efficios.com>
 <20230616131639.992998157fe696eb0e0589aa@linux-foundation.org>
 <efb2e71a-9b18-4ccd-bdbc-3014fae032fc@efficios.com>
 <1634ca8f-2b22-712e-15f9-9980ba8a4e64@nvidia.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <1634ca8f-2b22-712e-15f9-9980ba8a4e64@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 18:35, John Hubbard wrote:
> On 6/16/23 13:38, Mathieu Desnoyers wrote:
> ...
>>>> This comment is rather odd for a few reasons:
>>>>
>>>> - It requires addition/removal of mm_struct fields to carefully 
>>>> consider
>>>>    field alignment of _other_ fields,
>>>> - It expresses the wish to keep an "optimal" alignment for a specific
>>>>    kernel config.
>>>>
>>>> I suspect that the author of this comment may want to revisit this 
>>>> topic
>>>> and perhaps introduce a split-struct approach for struct rw_semaphore,
>>>> if the need is to place various fields of this structure in different
>>>> cache lines.
>>>>
> 
> Agreed. The whole thing is far too fragile, but when reviewing this I
> wasn't sure what else to suggest. Now looking at it again with your
> alignment suggestion, there is an interesting conflicting set of
> desires:
> 
> a) Here: Feng Tang discovered that .count and .owner are best put in
> separate cache lines for the contended case for mmap_lock, and
> 
> b) rwsem.h, which specifies precisely the opposite for the uncontended
> case:
> 
>   * For an uncontended rwsem, count and owner are the only fields a task
>   * needs to touch when acquiring the rwsem. So they are put next to each
>   * other to increase the chance that they will share the same cacheline.
> 
> I suspect that overall, it's "better" to align rw_semaphore's .count and
> .owner field so that the lock is optimized for the contended case,
> because it's reasonable to claim that the benefit of having those two
> fields in the same cacheline for the uncontended case is far less than
> the cost to the contended case, of keeping them close to each other.
> 
> However, it's still not unlikely that someone will measure a performance
> regression if such a change is made.
> 
> Thoughts?
> 

I suspect that the purpose of b) is only to maximize the functional density
of the data cache: only using a single cache line for the rwsem uncontended
case has the smallest footprint on the data cache.

However, if we look at the rwsem in the context of its use within another
data structure containing it, I think we can do better by analyzing the access
pattern of _other_ fields of that structure.

I have faced a similar situation within liburcu's wfcqueue's API [1], where
it's better for head and tail to sit on different cache lines to eliminate
false-sharing between enqueue and dequeue. I solved this by splitting the
head and tail parameters in the API. So the user can decide to place them
other on the same cache line, or on different cache lines, depending on the
use-case. The user also has the freedom to place both head and tail on the
same cache line as _other_ fields based on usage pattern.

By providing enough flexibility to place the rwsem fields so that the count
is on its own cache-line, and owner is on the same cache line as other fields
touched when the rwsem is held, I suspect we can both improve functional
density _and_ eliminate false-sharing in the contended case.

Thanks,

Mathieu

[1] https://github.com/urcu/userspace-rcu/blob/master/include/urcu/wfcqueue.h#L279


> ...
>>> If the plan is to put mm_count in "its own" cacheline then padding will
>>> be needed?
>>
>> It's taken care of by the anonymous structure trick. Here is an quick 
>> example showing the difference between alignment attribute applied to 
>> an integer type vs to an anonymous structure:
> 
> Thanks for explaining very clearly how that works, that's really
> helpful!
> thanks,

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

