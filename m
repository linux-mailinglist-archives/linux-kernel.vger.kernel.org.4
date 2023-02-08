Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD14668E682
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 04:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjBHDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 22:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBHDOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 22:14:33 -0500
Received: from out-164.mta1.migadu.com (out-164.mta1.migadu.com [95.215.58.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A4714216
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 19:14:31 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675826069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmNO8ZvQKaTkdERQULbnyw6Hc5sWsKOu9F+mkxB4iyU=;
        b=H7VyY7chdYq41tFb5E9FnhdqH2dIXn01Sdy8nVqemHCiqtmebqmthIM4N/JiSHjHJ5IZRm
        thYDaGnM/+zgbpSUEKQI56vYHGfJ7Jpy8yVrF/3FaIlkm8mNnuCbTrlLPM2EHMV/y6+F7c
        E2Q2uGMAjecM+a6CPyh5P9fnrpqNLaU=
MIME-Version: 1.0
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230207143131.GA12475@willie-the-truck>
Date:   Wed, 8 Feb 2023 11:13:46 +0800
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB3AE2F1-2EF8-4960-884E-DABA7E64CE59@linux.dev>
References: <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
 <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck> <Y9pZALdn3pKiJUeQ@arm.com>
 <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev> <Y9uUO9AadE+8ik/0@arm.com>
 <F10F1618-7153-41C7-A475-522D833C41D4@linux.dev>
 <20230203101023.GA5597@willie-the-truck>
 <93461768-791A-45BE-BEF2-344CC5228C92@linux.dev>
 <20230207143131.GA12475@willie-the-truck>
To:     Will Deacon <will@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 7, 2023, at 22:31, Will Deacon <will@kernel.org> wrote:
>=20
> On Mon, Feb 06, 2023 at 11:28:12AM +0800, Muchun Song wrote:
>>=20
>>=20
>>> On Feb 3, 2023, at 18:10, Will Deacon <will@kernel.org> wrote:
>>>=20
>>> On Fri, Feb 03, 2023 at 10:40:18AM +0800, Muchun Song wrote:
>>>>=20
>>>>=20
>>>>> On Feb 2, 2023, at 18:45, Catalin Marinas =
<catalin.marinas@arm.com> wrote:
>>>>>=20
>>>>> On Thu, Feb 02, 2023 at 05:51:39PM +0800, Muchun Song wrote:
>>>>>>> On Feb 1, 2023, at 20:20, Catalin Marinas =
<catalin.marinas@arm.com> wrote:
>>>>>>>> Bah, sorry! Catalin reckons it may have been him talking about =
the vmemmap.
>>>>>>>=20
>>>>>>> Indeed. The discussion with Anshuman started from this thread:
>>>>>>>=20
>>>>>>> =
https://lore.kernel.org/all/20221025014215.3466904-1-mawupeng1@huawei.com/=

>>>>>>>=20
>>>>>>> We already trip over the existing checks even without Anshuman's =
patch,
>>>>>>> though only by chance. We are not setting the software PTE_DIRTY =
on the
>>>>>>> new pte (we don't bother with this bit for kernel mappings).
>>>>>>>=20
>>>>>>> Given that the vmemmap ptes are still live when such change =
happens and
>>>>>>> no-one came with a solution to the break-before-make problem, I =
propose
>>>>>>> we revert the arm64 part of commit 47010c040dec ("mm: =
hugetlb_vmemmap:
>>>>>>> cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*"). We just need this =
hunk:
>>>>>>>=20
>>>>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>>>>> index 27b2592698b0..5263454a5794 100644
>>>>>>> --- a/arch/arm64/Kconfig
>>>>>>> +++ b/arch/arm64/Kconfig
>>>>>>> @@ -100,7 +100,6 @@ config ARM64
>>>>>>> select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>>>>>>> select ARCH_WANT_FRAME_POINTERS
>>>>>>> select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || =
(ARM64_16K_PAGES && !ARM64_VA_BITS_36)
>>>>>>> - select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>>>>>>=20
>>>>>> Maybe it is a little overkill for HVO as it can significantly =
minimize the
>>>>>> overhead of vmemmap on ARM64 servers for some workloads (like =
qemu, DPDK).
>>>>>> So I don't think disabling it is a good approach. Indeed, HVO =
broke BBM,
>>>>>> but the waring does not affect anything since the tail vmemmap =
pages are
>>>>>> supposed to be read-only. So, I suggest skipping warnings if it =
is the
>>>>>> vmemmap address in set_pte_at(). What do you think of?
>>>>>=20
>>>>> IIUC, vmemmap_remap_pte() not only makes the pte read-only but =
also
>>>>> changes the output address. Architecturally, this needs a BBM =
sequence.
>>>>> We can avoid going through an invalid pte if we first make the pte
>>>>> read-only, TLBI but keeping the same pfn, followed by a change of =
the
>>>>> pfn while keeping the pte readonly. This also assumes that the =
content
>>>>> of the page pointed at by the pte is the same at both old and new =
pfn.
>>>>=20
>>>> Right. I think using BBM is to avoid possibly creating multiple TLB =
entries
>>>> for the same address for a extremely short period. But accessing =
either the
>>>> old page or the new page is fine in this case. Is it acceptable for =
this
>>>> special case without using BBM?
>>>=20
>>> Sadly, the architecture allows the CPU to conjure up a mapping based =
on a
>>> combination of the old and the new descriptor (a process known as
>>> "amalgamation") so we _really_ need the BBM sequence.
>>=20
>> I am not familiar with ARM64, what's the user-visible effect if this
>> "amalgamation" occurs?
>=20
> The user-visible effects would probably be data corruption and =
instability,
> since the amalgamated TLB entry could result in a bogus physical =
address and
> bogus permissions.

You mean the output address of amalgamated TLB entry is neither the old
address (before updated) nor the new address (after updated)? So it is
a bogus physical address? Is there any specifications to describe the
rules of how to create a amalgamated TLB entry? Thanks.

Muchun

>=20
> Will

