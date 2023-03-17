Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876916BDE70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 03:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCQCHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 22:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCQCHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 22:07:23 -0400
X-Greylist: delayed 568 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Mar 2023 19:07:18 PDT
Received: from out-53.mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2240A497F1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 19:07:18 -0700 (PDT)
Message-ID: <4be3cbb7-ef4f-69f9-7212-123faec96044@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679018266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wJOU11SbL9/kaDnu46rJWsPZcBg70MspuwQ4F/vkNx0=;
        b=dUOguqoBVgVvt0KVjF0g3kzsGkOY7pUxYxTjY1vpsZxafJemjI/kyNepPUg/LhkhLucorz
        q/lBlfygL4INZlAGCfNx2GPpMgptsSJHuW3upBDwHIuNncTDkkuDznRHonzDtjfPkCeuTO
        gCax/rVU3QO8+yf1CN5d8E2zI2lRrcQ=
Date:   Thu, 16 Mar 2023 18:57:35 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vineet Gupta <vgupta@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
 <20230316181547.GA6211@monkey>
 <20230316233053.iwsffmfxzzacnkuy@box.shutemov.name>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vineet Gupta <vineet.gupta@linux.dev>
In-Reply-To: <20230316233053.iwsffmfxzzacnkuy@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/23 16:30, Kirill A. Shutemov wrote:
> On Thu, Mar 16, 2023 at 11:15:47AM -0700, Mike Kravetz wrote:
>> On 03/15/23 14:31, Kirill A. Shutemov wrote:
>>> MAX_ORDER currently defined as number of orders page allocator supports:
>>> user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
>>>
>>> This definition is counter-intuitive and lead to number of bugs all over
>>> the kernel.
>>>
>>> Change the definition of MAX_ORDER to be inclusive: the range of orders
>>> user can ask from buddy allocator is 0..MAX_ORDER now.
>>>
>>> --- a/arch/arc/Kconfig
>>> +++ b/arch/arc/Kconfig
>>> @@ -556,7 +556,7 @@ endmenu	 # "ARC Architecture Configuration"
>>>   
>>>   config ARCH_FORCE_MAX_ORDER
>>>   	int "Maximum zone order"
>>> -	default "12" if ARC_HUGEPAGE_16M
>>> -	default "11"
>>> +	default "11" if ARC_HUGEPAGE_16M
>>> +	default "10"
>> Is this Kconfig file wrong (off by 1) today?  It seems like it wants MAX_ORDER
>> to be sufficiently large to allocate 16M if ARC_HUGEPAGE_16M.  So, seems like
>> it should be 13 today?
> +Vineet.
>
> Hm. I think it is okay as long as CONFIG_ARC_PAGE_SIZE_8K=y which is
> default, but breaks for other PAGE_SIZE.
>
> Looks like ARCH_FORCE_MAX_ORDER calculation should involve selected page
> size.

Thats right 8K is default for ARC.

-Vineet
