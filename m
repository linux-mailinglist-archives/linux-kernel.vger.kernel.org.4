Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E368BA4D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjBFKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjBFKe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:34:59 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666CE144B7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 02:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675679664; x=1707215664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QuGXFzog/2TLYOIOh3hII8O6V1snANioCocHfYn8yws=;
  b=ge2+OMUiEiVgKBcxlb6Ol0zgl8Q5VQLske80OQO8aPNU5o1EenO4M7Ll
   xTdJ3v4L+Dn1Wb4fBYnUjVbKuoVKg+o7vNNeRnRuJkixT/WGizBJQk0eq
   fKabI5Ic4VfN6ARHWa2VYUPdVx5boj4F85pcjA1J803mhYtymH6v9BERn
   qlyfNZQyqkT9fJUByQJdsK5HDtGO2QuiOZM5w77py6GFRh1J2UbvhwTF0
   zjFsx7ciVmbo5PrIhfIdXAOHg5nJNqPL1SsQgTKmoBD5dQlE9WhN0BLWt
   qbMjqP6lAuIhgp+OMQ9aCy9S9G+Ca4O7sazCFbSLLzxF3ycVt5Mhzvv1Y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="308818081"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308818081"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 02:33:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10612"; a="790393723"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="790393723"
Received: from abotsiev-mobl.ger.corp.intel.com (HELO [10.252.3.115]) ([10.252.3.115])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 02:33:16 -0800
Message-ID: <aa8af778-2a40-7fe0-eb14-234469c74523@intel.com>
Date:   Mon, 6 Feb 2023 10:33:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/i915/gt: Avoid redundant pointer validity check
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Deepak R Varma <drv@mailo.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thomas.hellstrom@intel.com>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y91g081OauhQNxMe@ubun2204.myguest.virtualbox.org>
 <d58fff32-edad-4a7f-7409-7e57593df3ed@linux.intel.com>
Content-Language: en-GB
From:   Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <d58fff32-edad-4a7f-7409-7e57593df3ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 09:45, Tvrtko Ursulin wrote:
> 
> Hi,
> 
> Adding Matt & Thomas as potential candidates to review.
> 
> Regards,
> 
> Tvrtko
> 
> On 03/02/2023 19:30, Deepak R Varma wrote:
>> The macro definition of gen6_for_all_pdes() expands to a for loop such
>> that it breaks when the page table is null. Hence there is no need to
>> again test validity of the page table entry pointers in the pde list.
>> This change is identified using itnull.cocci semantic patch.
>>
>> Signed-off-by: Deepak R Varma <drv@mailo.com>
>> ---
>> Please note: Proposed change is compile tested only.
>>
>>   drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c 
>> b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
>> index 5aaacc53fa4c..787b9e6d9f59 100644
>> --- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
>> +++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
>> @@ -258,8 +258,7 @@ static void gen6_ppgtt_free_pd(struct gen6_ppgtt 
>> *ppgtt)
>>       u32 pde;
>>       gen6_for_all_pdes(pt, pd, pde)
>> -        if (pt)
>> -            free_pt(&ppgtt->base.vm, pt);
>> +        free_pt(&ppgtt->base.vm, pt);
>>   }
>>   static void gen6_ppgtt_cleanup(struct i915_address_space *vm)
>> @@ -304,7 +303,7 @@ static void pd_vma_unbind(struct 
>> i915_address_space *vm,
>>       /* Free all no longer used page tables */
>>       gen6_for_all_pdes(pt, ppgtt->base.pd, pde) {
>> -        if (!pt || atomic_read(&pt->used))
>> +        if (atomic_read(&pt->used))

Wow, I was really confused trying to remember how this all works.

The gen6_for_all_pdes() does:

(pt = i915_pt_entry(pd, iter), true)

So NULL pt is expected, and does not 'break' here, since 'true' is 
always the value that decides whether to terminate the loop. So this 
patch would lead to NULL ptr deref, AFAICT.



>>               continue;
>>           free_pt(&ppgtt->base.vm, pt);
