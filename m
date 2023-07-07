Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB2E74B3E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjGGPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjGGPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:13:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E8772115
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:13:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F31FD75;
        Fri,  7 Jul 2023 08:14:38 -0700 (PDT)
Received: from [10.57.77.63] (unknown [10.57.77.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 091EF3F762;
        Fri,  7 Jul 2023 08:13:53 -0700 (PDT)
Message-ID: <9dd036a8-9ba3-0cc4-b791-cb3178237728@arm.com>
Date:   Fri, 7 Jul 2023 16:13:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
 <20230703135330.1865927-5-ryan.roberts@arm.com>
 <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
 <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
 <ZKgZrNuxuq4ACvIb@casper.infradead.org>
 <1e406f04-78ef-6573-e1f1-f0d0e0d5246a@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <1e406f04-78ef-6573-e1f1-f0d0e0d5246a@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 15:07, David Hildenbrand wrote:
> On 07.07.23 15:57, Matthew Wilcox wrote:
>> On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
>>> On 07.07.23 11:52, Ryan Roberts wrote:
>>>> On 07/07/2023 09:01, Huang, Ying wrote:
>>>>> Although we can use smaller page order for FLEXIBLE_THP, it's hard to
>>>>> avoid internal fragmentation completely.  So, I think that finally we
>>>>> will need to provide a mechanism for the users to opt out, e.g.,
>>>>> something like "always madvise never" via
>>>>> /sys/kernel/mm/transparent_hugepage/enabled.  I'm not sure whether it's
>>>>> a good idea to reuse the existing interface of THP.
>>>>
>>>> I wouldn't want to tie this to the existing interface, simply because that
>>>> implies that we would want to follow the "always" and "madvise" advice too;
>>>> That
>>>> means that on a thp=madvise system (which is certainly the case for android and
>>>> other client systems) we would have to disable large anon folios for VMAs that
>>>> haven't explicitly opted in. That breaks the intention that this should be an
>>>> invisible performance boost. I think it's important to set the policy for
>>>> use of
>>>
>>> It will never ever be a completely invisible performance boost, just like
>>> ordinary THP.
>>>
>>> Using the exact same existing toggle is the right thing to do. If someone
>>> specify "never" or "madvise", then do exactly that.
>>>
>>> It might make sense to have more modes or additional toggles, but
>>> "madvise=never" means no memory waste.
>>
>> I hate the existing mechanisms.  They are an abdication of our
>> responsibility, and an attempt to blame the user (be it the sysadmin
>> or the programmer) of our code for using it wrongly.  We should not
>> replicate this mistake.
> 
> I don't agree regarding the programmer responsibility. In some cases the
> programmer really doesn't want to get more memory populated than requested --
> and knows exactly why setting MADV_NOHUGEPAGE is the right thing to do.
> 
> Regarding the madvise=never/madvise/always (sys admin decision), memory waste
> (and nailing down bugs or working around them in customer setups) have been very
> good reasons to let the admin have a word.
> 
>>
>> Our code should be auto-tuning.  I posted a long, detailed outline here:
>> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.org/
>>
> 
> Well, "auto-tuning" also should be perfect for everybody, but once reality
> strikes you know it isn't.
> 
> If people don't feel like using THP, let them have a word. The "madvise" config
> option is probably more controversial. But the "always vs. never" absolutely
> makes sense to me.
> 
>>> I remember I raised it already in the past, but you *absolutely* have to
>>> respect the MADV_NOHUGEPAGE flag. There is user space out there (for
>>> example, userfaultfd) that doesn't want the kernel to populate any
>>> additional page tables. So if you have to respect that already, then also
>>> respect MADV_HUGEPAGE, simple.
>>
>> Possibly having uffd enabled on a VMA should disable using large folios,
> 
> There are cases where we enable uffd *after* already touching memory (postcopy
> live migration in QEMU being the famous example). That doesn't fly.
> 
>> I can get behind that.  But the notion that userspace knows what it's
>> doing ... hahaha.  Just ignore the madvise flags.  Userspace doesn't
>> know what it's doing.
> 
> If user space sets MADV_NOHUGEPAGE, it exactly knows what it is doing ... in
> some cases. And these include cases I care about messing with sparse VM memory :)
> 
> I have strong opinions against populating more than required when user space set
> MADV_NOHUGEPAGE.

I can see your point about honouring MADV_NOHUGEPAGE, so think that it is
reasonable to fallback to allocating an order-0 page in a VMA that has it set.
The app has gone out of its way to explicitly set it, after all.

I think the correct behaviour for the global thp controls (cmdline and sysfs)
are less obvious though. I could get on board with disabling large anon folios
globally when thp="never". But for other situations, I would prefer to keep
large anon folios enabled (treat "madvise" as "always"), with the argument that
their order is much smaller than traditional THP and therefore the internal
fragmentation is significantly reduced. I really don't want to end up with user
space ever having to opt-in (with MADV_HUGEPAGE) to see the benefits of large
anon folios.

I still feel that it would be better for the thp and large anon folio controls
to be independent though - what's the argument for tying them together?

> 

