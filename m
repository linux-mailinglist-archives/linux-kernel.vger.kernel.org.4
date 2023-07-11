Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66674E2C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 02:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjGKAuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 20:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjGKAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 20:49:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BAA0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689036597; x=1720572597;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=UZgv5SNKTccA6FLxbfEckb4OEzHKeJEe92vi+aV97zw=;
  b=bEA33E2vTA8iX8oshW5Fl5g1h0dYBJOngZ/A+41hRqLjDZJ7lY4k9zkO
   p9dSfJQiED/4p0pzr5rLepF7wbhbfTUkjWvsUi5gdATRSvsaPnh1jW92P
   UwOTz9kjm53agMhG24wwnaiql5e7iK0KRE9nUbhoGWQ3yT3V6rhlHsB0T
   7kmAHq+hewUdEXuTT/ZifK8ZeEdiYeZLVk5Wcyt+NX4Fd7cbklUkH/BIl
   22vnLti3oGE7nVoCyu7UH9/PoZu5xTLVw6bBXAZmbCsuyoGESlqBbCgNd
   sz1RZ/m+du7j9Hwd04yCDDpe7cRGpqryIuKzb3POVHWQOEOHlyVoFTrXI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="361956157"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="361956157"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 17:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="894981500"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="894981500"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 17:49:53 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Zhu <alexlzhu@fb.com>
Subject: Re: [PATCH v2 4/5] mm: FLEXIBLE_THP for improved performance
References: <20230703135330.1865927-1-ryan.roberts@arm.com>
        <20230703135330.1865927-5-ryan.roberts@arm.com>
        <87edlkgnfa.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <44e60630-5e9d-c8df-ab79-cb0767de680e@arm.com>
        <524bacd2-4a47-2b8b-6685-c46e31a01631@redhat.com>
        <ZKgZrNuxuq4ACvIb@casper.infradead.org>
        <1e406f04-78ef-6573-e1f1-f0d0e0d5246a@redhat.com>
        <9dd036a8-9ba3-0cc4-b791-cb3178237728@arm.com>
        <87y1jofoyi.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <6c2f3127-9334-85ba-48f6-83a9c87abde0@arm.com>
        <874jmcf7kh.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <501d1a6a-c9cf-94c3-b773-c648b944b30f@arm.com>
Date:   Tue, 11 Jul 2023 08:48:16 +0800
In-Reply-To: <501d1a6a-c9cf-94c3-b773-c648b944b30f@arm.com> (Ryan Roberts's
        message of "Mon, 10 Jul 2023 10:25:36 +0100")
Message-ID: <87v8ere0j3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 10/07/2023 10:18, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>=20
>>> On 10/07/2023 04:03, Huang, Ying wrote:
>>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>>
>>>>> On 07/07/2023 15:07, David Hildenbrand wrote:
>>>>>> On 07.07.23 15:57, Matthew Wilcox wrote:
>>>>>>> On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
>>>>>>>> On 07.07.23 11:52, Ryan Roberts wrote:
>>>>>>>>> On 07/07/2023 09:01, Huang, Ying wrote:
>>>>>>>>>> Although we can use smaller page order for FLEXIBLE_THP, it's ha=
rd to
>>>>>>>>>> avoid internal fragmentation completely.=C2=A0 So, I think that =
finally we
>>>>>>>>>> will need to provide a mechanism for the users to opt out, e.g.,
>>>>>>>>>> something like "always madvise never" via
>>>>>>>>>> /sys/kernel/mm/transparent_hugepage/enabled.=C2=A0 I'm not sure =
whether it's
>>>>>>>>>> a good idea to reuse the existing interface of THP.
>>>>>>>>>
>>>>>>>>> I wouldn't want to tie this to the existing interface, simply bec=
ause that
>>>>>>>>> implies that we would want to follow the "always" and "madvise" a=
dvice too;
>>>>>>>>> That
>>>>>>>>> means that on a thp=3Dmadvise system (which is certainly the case=
 for android and
>>>>>>>>> other client systems) we would have to disable large anon folios =
for VMAs that
>>>>>>>>> haven't explicitly opted in. That breaks the intention that this =
should be an
>>>>>>>>> invisible performance boost. I think it's important to set the po=
licy for
>>>>>>>>> use of
>>>>>>>>
>>>>>>>> It will never ever be a completely invisible performance boost, ju=
st like
>>>>>>>> ordinary THP.
>>>>>>>>
>>>>>>>> Using the exact same existing toggle is the right thing to do. If =
someone
>>>>>>>> specify "never" or "madvise", then do exactly that.
>>>>>>>>
>>>>>>>> It might make sense to have more modes or additional toggles, but
>>>>>>>> "madvise=3Dnever" means no memory waste.
>>>>>>>
>>>>>>> I hate the existing mechanisms.=C2=A0 They are an abdication of our
>>>>>>> responsibility, and an attempt to blame the user (be it the sysadmin
>>>>>>> or the programmer) of our code for using it wrongly.=C2=A0 We shoul=
d not
>>>>>>> replicate this mistake.
>>>>>>
>>>>>> I don't agree regarding the programmer responsibility. In some cases=
 the
>>>>>> programmer really doesn't want to get more memory populated than req=
uested --
>>>>>> and knows exactly why setting MADV_NOHUGEPAGE is the right thing to =
do.
>>>>>>
>>>>>> Regarding the madvise=3Dnever/madvise/always (sys admin decision), m=
emory waste
>>>>>> (and nailing down bugs or working around them in customer setups) ha=
ve been very
>>>>>> good reasons to let the admin have a word.
>>>>>>
>>>>>>>
>>>>>>> Our code should be auto-tuning.=C2=A0 I posted a long, detailed out=
line here:
>>>>>>> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradea=
d.org/
>>>>>>>
>>>>>>
>>>>>> Well, "auto-tuning" also should be perfect for everybody, but once r=
eality
>>>>>> strikes you know it isn't.
>>>>>>
>>>>>> If people don't feel like using THP, let them have a word. The "madv=
ise" config
>>>>>> option is probably more controversial. But the "always vs. never" ab=
solutely
>>>>>> makes sense to me.
>>>>>>
>>>>>>>> I remember I raised it already in the past, but you *absolutely* h=
ave to
>>>>>>>> respect the MADV_NOHUGEPAGE flag. There is user space out there (f=
or
>>>>>>>> example, userfaultfd) that doesn't want the kernel to populate any
>>>>>>>> additional page tables. So if you have to respect that already, th=
en also
>>>>>>>> respect MADV_HUGEPAGE, simple.
>>>>>>>
>>>>>>> Possibly having uffd enabled on a VMA should disable using large fo=
lios,
>>>>>>
>>>>>> There are cases where we enable uffd *after* already touching memory=
 (postcopy
>>>>>> live migration in QEMU being the famous example). That doesn't fly.
>>>>>>
>>>>>>> I can get behind that.=C2=A0 But the notion that userspace knows wh=
at it's
>>>>>>> doing ... hahaha.=C2=A0 Just ignore the madvise flags.=C2=A0 Usersp=
ace doesn't
>>>>>>> know what it's doing.
>>>>>>
>>>>>> If user space sets MADV_NOHUGEPAGE, it exactly knows what it is doin=
g ... in
>>>>>> some cases. And these include cases I care about messing with sparse=
 VM memory :)
>>>>>>
>>>>>> I have strong opinions against populating more than required when us=
er space set
>>>>>> MADV_NOHUGEPAGE.
>>>>>
>>>>> I can see your point about honouring MADV_NOHUGEPAGE, so think that i=
t is
>>>>> reasonable to fallback to allocating an order-0 page in a VMA that ha=
s it set.
>>>>> The app has gone out of its way to explicitly set it, after all.
>>>>>
>>>>> I think the correct behaviour for the global thp controls (cmdline an=
d sysfs)
>>>>> are less obvious though. I could get on board with disabling large an=
on folios
>>>>> globally when thp=3D"never". But for other situations, I would prefer=
 to keep
>>>>> large anon folios enabled (treat "madvise" as "always"),
>>>>
>>>> If we have some mechanism to auto-tune the large folios usage, for
>>>> example, detect the internal fragmentation and split the large folio,
>>>> then we can use thp=3D"always" as default configuration.  If my memory
>>>> were correct, this is what Johannes and Alexander is working on.
>>>
>>> Could you point me to that work? I'd like to understand what the mechan=
ism is.
>>> The other half of my work aims to use arm64's pte "contiguous bit" to t=
ell the
>>> HW that a span of PTEs share the same mapping and is therefore coalesce=
d into a
>>> single TLB entry. The side effect of this, however, is that we only hav=
e a
>>> single access and dirty bit for the whole contpte extent. So I'd like t=
o avoid
>>> any mechanism that relies on getting access/dirty at the base page gran=
ularity
>>> for a large folio.
>>=20
>> Please take a look at the THP shrinker patchset,
>>=20
>> https://lore.kernel.org/linux-mm/cover.1667454613.git.alexlzhu@fb.com/
>
> Thanks!
>
>>=20
>>>>
>>>>> with the argument that
>>>>> their order is much smaller than traditional THP and therefore the in=
ternal
>>>>> fragmentation is significantly reduced.
>>>>
>>>> Do you have any data for this?
>>>
>>> Some; its partly based on intuition that the smaller the allocation uni=
t, the
>>> smaller the internal fragmentation. And partly on peak memory usage dat=
a I've
>>> collected for the benchmarks I'm running, comparing baseline-4k kernel =
with
>>> baseline-16k and baseline-64 kernels along with a 4k kernel that suppor=
ts large
>>> anon folios (I appreciate that's not exactly what we are talking about =
here, and
>>> it's not exactly an extensive set of results!):
>>>
>>>
>>> Kernel Compliation with 8 Jobs:
>>> | kernel        |   peak |
>>> |:--------------|-------:|
>>> | baseline-4k   |   0.0% |
>>> | anonfolio     |   0.1% |
>>> | baseline-16k  |   6.3% |
>>> | baseline-64k  |  28.1% |
>>>
>>>
>>> Kernel Compliation with 80 Jobs:
>>> | kernel        |   peak |
>>> |:--------------|-------:|
>>> | baseline-4k   |   0.0% |
>>> | anonfolio     |   1.7% |
>>> | baseline-16k  |   2.6% |
>>> | baseline-64k  |  12.3% |
>>>
>>=20
>> Why is anonfolio better than baseline-64k if you always allocate 64k
>> anonymous folio?  Because page cache uses 64k in baseline-64k?
>
> No, because the VMA boundaries are aligned to 4K and not 64K. Large Anon =
Folios
> only allocates a 64K folio if it does not breach the bounds of the VMA (a=
nd if
> it doesn't overlap other allocated PTEs).

Thanks for explanation!

We will use more memory for file cache too for baseline-64k, right?  So,
you observed much more anonymous pages, but not so for file cache pages?

>>=20
>> We may need to test some workloads with sparse access patterns too.
>
> Yes, I agree if you have a workload with a pathalogical memory access pat=
tern
> where it writes to addresses with a stride of 64K, all contained in a sin=
gle
> VMA, then you will end up allocating 16x the memory. This is obviously an
> unrealistic extreme though.

I think that there should be some realistic workload which has sparse
access patterns.

Best Regards,
Huang, Ying

>>=20
>>>>
>>>>> I really don't want to end up with user
>>>>> space ever having to opt-in (with MADV_HUGEPAGE) to see the benefits =
of large
>>>>> anon folios.
>>>>>
>>>>> I still feel that it would be better for the thp and large anon folio=
 controls
>>>>> to be independent though - what's the argument for tying them togethe=
r?
>>>>>
>>=20
