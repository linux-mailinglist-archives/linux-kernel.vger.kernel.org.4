Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A486274D13A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGJJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 05:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjGJJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 05:20:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0128B8E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 02:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688980819; x=1720516819;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=ly/MDRV2EOLHcR5c4dEoNmyijTn1dRwSPnIkbL/BJH0=;
  b=lNrYko/wa+aaadU0DFKPgPX3FcNyWk3SrgzxRmosiFO5LXWYjZT94iDX
   hMhzvlwL/3aIMRp68PP3LV/q4jmfN8U48lLUXVujX6S7+0r32JJl5UGPs
   3xtVQ33AQf351eDuBnhtu03j7fmTC0C9js0+kmiY52kcbxjhI3oq9BsNT
   f1o5Qd/Mn47ZUtdpvH6TTfSmTVGzYtBfe3wVdCeLkmCbEY20rLuMNOG9V
   QyZMr8Po0vq9+rQjc6S9fnK5XvSILYPowMzlhOU+m65err5CdgyHk06N0
   UNqtJPVp9cf4kSLbvZYsw6Q0LyPBClvFwIywpK8RpQZmsOWvEQSnaqn7q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="427988494"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="427988494"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="670880190"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="670880190"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 02:20:15 -0700
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
Date:   Mon, 10 Jul 2023 17:18:38 +0800
In-Reply-To: <6c2f3127-9334-85ba-48f6-83a9c87abde0@arm.com> (Ryan Roberts's
        message of "Mon, 10 Jul 2023 09:55:14 +0100")
Message-ID: <874jmcf7kh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 10/07/2023 04:03, Huang, Ying wrote:
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>=20
>>> On 07/07/2023 15:07, David Hildenbrand wrote:
>>>> On 07.07.23 15:57, Matthew Wilcox wrote:
>>>>> On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
>>>>>> On 07.07.23 11:52, Ryan Roberts wrote:
>>>>>>> On 07/07/2023 09:01, Huang, Ying wrote:
>>>>>>>> Although we can use smaller page order for FLEXIBLE_THP, it's hard=
 to
>>>>>>>> avoid internal fragmentation completely.=C2=A0 So, I think that fi=
nally we
>>>>>>>> will need to provide a mechanism for the users to opt out, e.g.,
>>>>>>>> something like "always madvise never" via
>>>>>>>> /sys/kernel/mm/transparent_hugepage/enabled.=C2=A0 I'm not sure wh=
ether it's
>>>>>>>> a good idea to reuse the existing interface of THP.
>>>>>>>
>>>>>>> I wouldn't want to tie this to the existing interface, simply becau=
se that
>>>>>>> implies that we would want to follow the "always" and "madvise" adv=
ice too;
>>>>>>> That
>>>>>>> means that on a thp=3Dmadvise system (which is certainly the case f=
or android and
>>>>>>> other client systems) we would have to disable large anon folios fo=
r VMAs that
>>>>>>> haven't explicitly opted in. That breaks the intention that this sh=
ould be an
>>>>>>> invisible performance boost. I think it's important to set the poli=
cy for
>>>>>>> use of
>>>>>>
>>>>>> It will never ever be a completely invisible performance boost, just=
 like
>>>>>> ordinary THP.
>>>>>>
>>>>>> Using the exact same existing toggle is the right thing to do. If so=
meone
>>>>>> specify "never" or "madvise", then do exactly that.
>>>>>>
>>>>>> It might make sense to have more modes or additional toggles, but
>>>>>> "madvise=3Dnever" means no memory waste.
>>>>>
>>>>> I hate the existing mechanisms.=C2=A0 They are an abdication of our
>>>>> responsibility, and an attempt to blame the user (be it the sysadmin
>>>>> or the programmer) of our code for using it wrongly.=C2=A0 We should =
not
>>>>> replicate this mistake.
>>>>
>>>> I don't agree regarding the programmer responsibility. In some cases t=
he
>>>> programmer really doesn't want to get more memory populated than reque=
sted --
>>>> and knows exactly why setting MADV_NOHUGEPAGE is the right thing to do.
>>>>
>>>> Regarding the madvise=3Dnever/madvise/always (sys admin decision), mem=
ory waste
>>>> (and nailing down bugs or working around them in customer setups) have=
 been very
>>>> good reasons to let the admin have a word.
>>>>
>>>>>
>>>>> Our code should be auto-tuning.=C2=A0 I posted a long, detailed outli=
ne here:
>>>>> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.=
org/
>>>>>
>>>>
>>>> Well, "auto-tuning" also should be perfect for everybody, but once rea=
lity
>>>> strikes you know it isn't.
>>>>
>>>> If people don't feel like using THP, let them have a word. The "madvis=
e" config
>>>> option is probably more controversial. But the "always vs. never" abso=
lutely
>>>> makes sense to me.
>>>>
>>>>>> I remember I raised it already in the past, but you *absolutely* hav=
e to
>>>>>> respect the MADV_NOHUGEPAGE flag. There is user space out there (for
>>>>>> example, userfaultfd) that doesn't want the kernel to populate any
>>>>>> additional page tables. So if you have to respect that already, then=
 also
>>>>>> respect MADV_HUGEPAGE, simple.
>>>>>
>>>>> Possibly having uffd enabled on a VMA should disable using large foli=
os,
>>>>
>>>> There are cases where we enable uffd *after* already touching memory (=
postcopy
>>>> live migration in QEMU being the famous example). That doesn't fly.
>>>>
>>>>> I can get behind that.=C2=A0 But the notion that userspace knows what=
 it's
>>>>> doing ... hahaha.=C2=A0 Just ignore the madvise flags.=C2=A0 Userspac=
e doesn't
>>>>> know what it's doing.
>>>>
>>>> If user space sets MADV_NOHUGEPAGE, it exactly knows what it is doing =
... in
>>>> some cases. And these include cases I care about messing with sparse V=
M memory :)
>>>>
>>>> I have strong opinions against populating more than required when user=
 space set
>>>> MADV_NOHUGEPAGE.
>>>
>>> I can see your point about honouring MADV_NOHUGEPAGE, so think that it =
is
>>> reasonable to fallback to allocating an order-0 page in a VMA that has =
it set.
>>> The app has gone out of its way to explicitly set it, after all.
>>>
>>> I think the correct behaviour for the global thp controls (cmdline and =
sysfs)
>>> are less obvious though. I could get on board with disabling large anon=
 folios
>>> globally when thp=3D"never". But for other situations, I would prefer t=
o keep
>>> large anon folios enabled (treat "madvise" as "always"),
>>=20
>> If we have some mechanism to auto-tune the large folios usage, for
>> example, detect the internal fragmentation and split the large folio,
>> then we can use thp=3D"always" as default configuration.  If my memory
>> were correct, this is what Johannes and Alexander is working on.
>
> Could you point me to that work? I'd like to understand what the mechanis=
m is.
> The other half of my work aims to use arm64's pte "contiguous bit" to tel=
l the
> HW that a span of PTEs share the same mapping and is therefore coalesced =
into a
> single TLB entry. The side effect of this, however, is that we only have a
> single access and dirty bit for the whole contpte extent. So I'd like to =
avoid
> any mechanism that relies on getting access/dirty at the base page granul=
arity
> for a large folio.

Please take a look at the THP shrinker patchset,

https://lore.kernel.org/linux-mm/cover.1667454613.git.alexlzhu@fb.com/

>>=20
>>> with the argument that
>>> their order is much smaller than traditional THP and therefore the inte=
rnal
>>> fragmentation is significantly reduced.
>>=20
>> Do you have any data for this?
>
> Some; its partly based on intuition that the smaller the allocation unit,=
 the
> smaller the internal fragmentation. And partly on peak memory usage data =
I've
> collected for the benchmarks I'm running, comparing baseline-4k kernel wi=
th
> baseline-16k and baseline-64 kernels along with a 4k kernel that supports=
 large
> anon folios (I appreciate that's not exactly what we are talking about he=
re, and
> it's not exactly an extensive set of results!):
>
>
> Kernel Compliation with 8 Jobs:
> | kernel        |   peak |
> |:--------------|-------:|
> | baseline-4k   |   0.0% |
> | anonfolio     |   0.1% |
> | baseline-16k  |   6.3% |
> | baseline-64k  |  28.1% |
>
>
> Kernel Compliation with 80 Jobs:
> | kernel        |   peak |
> |:--------------|-------:|
> | baseline-4k   |   0.0% |
> | anonfolio     |   1.7% |
> | baseline-16k  |   2.6% |
> | baseline-64k  |  12.3% |
>

Why is anonfolio better than baseline-64k if you always allocate 64k
anonymous folio?  Because page cache uses 64k in baseline-64k?

We may need to test some workloads with sparse access patterns too.

Best Regards,
Huang, Ying

>>=20
>>> I really don't want to end up with user
>>> space ever having to opt-in (with MADV_HUGEPAGE) to see the benefits of=
 large
>>> anon folios.
>>>
>>> I still feel that it would be better for the thp and large anon folio c=
ontrols
>>> to be independent though - what's the argument for tying them together?
>>>

