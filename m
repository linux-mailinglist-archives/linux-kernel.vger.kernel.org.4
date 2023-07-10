Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABC74CA28
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjGJDEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGJDEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:04:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23ACEC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688958285; x=1720494285;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=nMqtwlxWp4NwHTz7RdNmIP/l04x9qUUR29iSxAEIaVo=;
  b=ODbno5obIgIcGaFW35R94qnJV8XkD2gqufxLfmssKKfcI65k9d9XWoNz
   OydB+u7EW7sEeh7q5x7yz/SkRoNPEpKw3EEVIPJFSUihW1NNcPFF0Rj7c
   Zo9vqm4jziD0ia+Q7gD0LXi64cvwyCMVXtOdKSHTdHhoh3ijDHTUvTCPx
   eaLU+UsKLzl1TC480q3L4J75iU00PP46nFPm1Wt2bXtWmTwik+i1GtzrS
   xT0qyuZwkpb3xJ9zMi+BrX741K5jViZUgH1YUY7x8iGc9Hkx8q67mSw4V
   368TpW9FKPNKfQYwmVI6/hNkmLGQGRLF8PPSQ0ZLmiP3GcgLyuXC/I8z1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="343835530"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="343835530"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 20:04:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="810670994"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="810670994"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 20:04:37 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        "Yu Zhao" <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
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
Date:   Mon, 10 Jul 2023 11:03:01 +0800
In-Reply-To: <9dd036a8-9ba3-0cc4-b791-cb3178237728@arm.com> (Ryan Roberts's
        message of "Fri, 7 Jul 2023 16:13:52 +0100")
Message-ID: <87y1jofoyi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 07/07/2023 15:07, David Hildenbrand wrote:
>> On 07.07.23 15:57, Matthew Wilcox wrote:
>>> On Fri, Jul 07, 2023 at 01:29:02PM +0200, David Hildenbrand wrote:
>>>> On 07.07.23 11:52, Ryan Roberts wrote:
>>>>> On 07/07/2023 09:01, Huang, Ying wrote:
>>>>>> Although we can use smaller page order for FLEXIBLE_THP, it's hard to
>>>>>> avoid internal fragmentation completely.=C2=A0 So, I think that fina=
lly we
>>>>>> will need to provide a mechanism for the users to opt out, e.g.,
>>>>>> something like "always madvise never" via
>>>>>> /sys/kernel/mm/transparent_hugepage/enabled.=C2=A0 I'm not sure whet=
her it's
>>>>>> a good idea to reuse the existing interface of THP.
>>>>>
>>>>> I wouldn't want to tie this to the existing interface, simply because=
 that
>>>>> implies that we would want to follow the "always" and "madvise" advic=
e too;
>>>>> That
>>>>> means that on a thp=3Dmadvise system (which is certainly the case for=
 android and
>>>>> other client systems) we would have to disable large anon folios for =
VMAs that
>>>>> haven't explicitly opted in. That breaks the intention that this shou=
ld be an
>>>>> invisible performance boost. I think it's important to set the policy=
 for
>>>>> use of
>>>>
>>>> It will never ever be a completely invisible performance boost, just l=
ike
>>>> ordinary THP.
>>>>
>>>> Using the exact same existing toggle is the right thing to do. If some=
one
>>>> specify "never" or "madvise", then do exactly that.
>>>>
>>>> It might make sense to have more modes or additional toggles, but
>>>> "madvise=3Dnever" means no memory waste.
>>>
>>> I hate the existing mechanisms.=C2=A0 They are an abdication of our
>>> responsibility, and an attempt to blame the user (be it the sysadmin
>>> or the programmer) of our code for using it wrongly.=C2=A0 We should not
>>> replicate this mistake.
>>=20
>> I don't agree regarding the programmer responsibility. In some cases the
>> programmer really doesn't want to get more memory populated than request=
ed --
>> and knows exactly why setting MADV_NOHUGEPAGE is the right thing to do.
>>=20
>> Regarding the madvise=3Dnever/madvise/always (sys admin decision), memor=
y waste
>> (and nailing down bugs or working around them in customer setups) have b=
een very
>> good reasons to let the admin have a word.
>>=20
>>>
>>> Our code should be auto-tuning.=C2=A0 I posted a long, detailed outline=
 here:
>>> https://lore.kernel.org/linux-mm/Y%2FU8bQd15aUO97vS@casper.infradead.or=
g/
>>>
>>=20
>> Well, "auto-tuning" also should be perfect for everybody, but once reali=
ty
>> strikes you know it isn't.
>>=20
>> If people don't feel like using THP, let them have a word. The "madvise"=
 config
>> option is probably more controversial. But the "always vs. never" absolu=
tely
>> makes sense to me.
>>=20
>>>> I remember I raised it already in the past, but you *absolutely* have =
to
>>>> respect the MADV_NOHUGEPAGE flag. There is user space out there (for
>>>> example, userfaultfd) that doesn't want the kernel to populate any
>>>> additional page tables. So if you have to respect that already, then a=
lso
>>>> respect MADV_HUGEPAGE, simple.
>>>
>>> Possibly having uffd enabled on a VMA should disable using large folios,
>>=20
>> There are cases where we enable uffd *after* already touching memory (po=
stcopy
>> live migration in QEMU being the famous example). That doesn't fly.
>>=20
>>> I can get behind that.=C2=A0 But the notion that userspace knows what i=
t's
>>> doing ... hahaha.=C2=A0 Just ignore the madvise flags.=C2=A0 Userspace =
doesn't
>>> know what it's doing.
>>=20
>> If user space sets MADV_NOHUGEPAGE, it exactly knows what it is doing ..=
. in
>> some cases. And these include cases I care about messing with sparse VM =
memory :)
>>=20
>> I have strong opinions against populating more than required when user s=
pace set
>> MADV_NOHUGEPAGE.
>
> I can see your point about honouring MADV_NOHUGEPAGE, so think that it is
> reasonable to fallback to allocating an order-0 page in a VMA that has it=
 set.
> The app has gone out of its way to explicitly set it, after all.
>
> I think the correct behaviour for the global thp controls (cmdline and sy=
sfs)
> are less obvious though. I could get on board with disabling large anon f=
olios
> globally when thp=3D"never". But for other situations, I would prefer to =
keep
> large anon folios enabled (treat "madvise" as "always"),

If we have some mechanism to auto-tune the large folios usage, for
example, detect the internal fragmentation and split the large folio,
then we can use thp=3D"always" as default configuration.  If my memory
were correct, this is what Johannes and Alexander is working on.

> with the argument that
> their order is much smaller than traditional THP and therefore the intern=
al
> fragmentation is significantly reduced.

Do you have any data for this?

> I really don't want to end up with user
> space ever having to opt-in (with MADV_HUGEPAGE) to see the benefits of l=
arge
> anon folios.
>
> I still feel that it would be better for the thp and large anon folio con=
trols
> to be independent though - what's the argument for tying them together?
>

Best Regards,
Huang, Ying

