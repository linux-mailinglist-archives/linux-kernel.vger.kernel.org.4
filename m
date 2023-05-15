Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD52702C74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241598AbjEOMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241518AbjEOMO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:14:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 508E11B7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:14:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB232FEC;
        Mon, 15 May 2023 05:15:11 -0700 (PDT)
Received: from [10.57.73.22] (unknown [10.57.73.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FB783F663;
        Mon, 15 May 2023 05:14:25 -0700 (PDT)
Message-ID: <47077d53-050b-5521-3dd8-dfd0f5e89269@arm.com>
Date:   Mon, 15 May 2023 13:14:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        Christoph Hellwig <hch@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
 <db1b8b8f-c3ac-4dbb-8b15-125c0929856a@lucifer.local>
 <2d43731e-3a38-c96e-320e-6a0dc16f10e4@arm.com>
 <54ecd324-91ac-4fbc-8c47-46f12b2f5256@lucifer.local>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <54ecd324-91ac-4fbc-8c47-46f12b2f5256@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 12:25, Lorenzo Stoakes wrote:
> On Mon, May 15, 2023 at 09:29:16AM +0100, Ryan Roberts wrote:
>> Hi Lorenzo,
>>
>> Thanks for the review - I appreciate it!
>>
>>
>> On 13/05/2023 14:14, Lorenzo Stoakes wrote:
>>> You've not cc'd the vmalloc reviewers, including the author of 3e9a9e256b1e
>>> whose patch you purport to fix. Please remember to run get_maintainers.pl
>>> on all files you patch and cc them at least on relevant patches.
>>>
>>> Have added Christoph + Uladzislau as cc.
>>
>> I did run get_maintainers.pl, but it gave me 82 names. I assumed I wouldn't be
>> making any friends by CCing everyone, so tried to choose what I thought was a
>> sensible base. I guess I didn't quite get it right. Sorry about that. Thanks for
>> noticing and adding the right people.
> 
> Right you mean across the whole of the patch set? Different people have
> different approaches as to how to cc patch sets as a whole, but it's not
> optional to include maintainers and reviewers on patches, so you should at least
> cc- them on individual patches.
> 
> It's ok, it's really easy to mess this up, I have managed every variant of doing
> this the wrong way myself... :)

Well I look forward to tripping over all the other variants in due course. ;-)

> 
>>
>>>
>>> You'll definitely want an ack from Christoph on this!
>>>
>>> On Thu, May 11, 2023 at 02:21:09PM +0100, Ryan Roberts wrote:
>>>> It is bad practice to directly set pte entries within a pte table.
>>>> Instead all modifications must go through arch-provided helpers such as
>>>> set_pte_at() to give the arch code visibility and allow it to validate
>>>> (and potentially modify) the operation.
>>>
>>> This does make sense, and I see for example in xtensa that an arch-specific
>>> instruction is issued under certain circumstances so I do suspect we should
>>> do this.
>>
>> arm64 provides another example, where barriers are required to ensure the page
>> table walker sees the new pte and no fault is raised. See
>> arch/arm64/include/asm/pgtable.h:set_pte() (which is called by its
>> implementation of set_pte_at()).
> 
> Ack, yeah I do think your patch is correct.
> 
>>
>>>
>>> As for validation, the function never indicates an error, so only in the
>>> sense that a WARN_ON() could _in theory_ trigger is it being
>>> validated. This might be quite a nitty point :) as set_pte_at() has no
>>> means of indicating an error. But maybe to be pedantic 'check' rather than
>>> 'validate'?
>>
>> I'm sorry, I'm not sure what you are asking here? set_pte_at() forms part of the
>> contract with he arch code and is defined never to return an error. Some
>> implementations might have code enabled in debug configs to detect incorrect
>> usage and emit warnings (see arm64's implementation).
> 
> I'm saying that 'validate' implies to me that you assess whether the value is
> correct and behave differently accordingly. It's something of a pedantic point,
> but perhaps 'check' is better here.

Ahh, you were critiqing the commit message, sorry totally missed that. I'll
change 'validate' to 'check' in v2.

> 
>>
>>>
>>>>
>>>> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
>>>
>>> Not sure if this is really 'fixing' anything, I mean ostensibly, but not
>>> sure if the tag is relevant here, that is more so for a bug being
>>> introduced, and unless an issue has arisen not sure if it's
>>> appropriate. But this might be a nit, again!
>>
>> Well I'm happy to remove it if that's the concensus. But I do believe there is a
>> real bug here. At least on arm64, the barriers are needed to prevent a race with
>> the page table walker. That said, the only place in the tree I can see
>> vmap_pfn() used, is in the i915 driver, which I guess has never been used on an
>> arm64 platform.
> 
> Yeah, again this might be a little too nitty! And I totally understand where
> you're coming from, I do agree this is appears to be an issue and your solution
> is right, it just feels less like an obvious 'bug' and more of an oversight. But
> I am being pedantic, and am not overly worried if you retain it :)

OK, I'm going to retain it.

> 
>>
>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  mm/vmalloc.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index 9683573f1225..d8d2fe797c55 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -2899,10 +2899,13 @@ struct vmap_pfn_data {
>>>>  static int vmap_pfn_apply(pte_t *pte, unsigned long addr, void *private)
>>>>  {
>>>>  	struct vmap_pfn_data *data = private;
>>>> +	pte_t ptent;
>>>>
>>>>  	if (WARN_ON_ONCE(pfn_valid(data->pfns[data->idx])))
>>>>  		return -EINVAL;
>>>> -	*pte = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
>>>> +
>>>> +	ptent = pte_mkspecial(pfn_pte(data->pfns[data->idx++], data->prot));
>>>> +	set_pte_at(&init_mm, addr, pte, ptent);>
>>> While we're refactoring, it'd be nice to stash data->pfns[data->idx] into a
>>> local pfn variable.
>>
>> OK, I'll do this for v2.
> 
> Thanks!
> 
>>
>> Thanks,
>> Ryan
>>
>>
>>>
>>>>  	return 0;
>>>>  }
>>>>
>>>> --
>>>> 2.25.1
>>>>
>>
> 
> Sorry to get into the weeds here a bit, overall I think this patch is fine, I
> would like Christoph to take a look given it's his code however.

No problem; I'm new here, so just having someone taking the time to respond with
specific feedback, is a win as far as I'm concerned!

Thanks,
Ryan

