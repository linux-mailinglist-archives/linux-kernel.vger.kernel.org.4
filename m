Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0F16879AF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjBBKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjBBKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:02:21 -0500
X-Greylist: delayed 606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Feb 2023 02:02:19 PST
Received: from out-154.mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BB875B3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:02:18 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675331528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LCBTDt5ICx8Mvi5W+/+gY2aaUdXSNOvE3rMuXJ+tKi8=;
        b=PhVeP3jDB1n3NatercWXmqIzxQrWiQ3p3vD33qp0f1yK20MLk9VJ8i4aPAYHHzqiiYURz+
        5PXAOZw2RCL4CtNccLoGB4shACHCh4IvceHoaFWCF/TfeMUtscf95Kh2MYVTkZXOjkms4a
        GQs7d3Qr1k4ffDwiAIiOtcdj3WyAvEY=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH V2] arm64/mm: Intercept pfn changes in set_pte_at()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <Y9pZALdn3pKiJUeQ@arm.com>
Date:   Thu, 2 Feb 2023 17:51:39 +0800
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8DF7D56-C145-4B49-A034-022917B87C89@linux.dev>
References: <20230109052816.405335-1-anshuman.khandual@arm.com>
 <e924c1aa-5f04-fd7f-52d4-7cf22c476016@arm.com>
 <20230126133321.GB29148@willie-the-truck>
 <d454c9a2-5300-b600-a2ae-21d82d338470@arm.com>
 <20230131154950.GB2646@willie-the-truck> <Y9pZALdn3pKiJUeQ@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 1, 2023, at 20:20, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>=20
> On Tue, Jan 31, 2023 at 03:49:51PM +0000, Will Deacon wrote:
>> On Fri, Jan 27, 2023 at 12:43:17PM +0000, Robin Murphy wrote:
>>> On 2023-01-26 13:33, Will Deacon wrote:
>>>> On Tue, Jan 24, 2023 at 11:11:49AM +0530, Anshuman Khandual wrote:
>>>>> On 1/9/23 10:58, Anshuman Khandual wrote:
>>>>>> Changing pfn on a user page table mapped entry, without first =
going through
>>>>>> break-before-make (BBM) procedure is unsafe. This just updates =
set_pte_at()
>>>>>> to intercept such changes, via an updated =
pgattr_change_is_safe(). This new
>>>>>> check happens via __check_racy_pte_update(), which has now been =
renamed as
>>>>>> __check_safe_pte_update().
>>>>>>=20
>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>> Cc: Will Deacon <will@kernel.org>
>>>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>>>> ---
>>>>>> This applies on v6.2-rc3. This patch had some test time on an =
internal CI
>>>>>> system without any issues being reported.
>>>>>=20
>>>>> Gentle ping, any updates on this patch ? Still any concerns ?
>>>>=20
>>>> I don't think we really got to the bottom of Mark's concerns with
>>>> unreachable ptes on the stack, did we? I also have vague =
recollections
>>>> of somebody (Robin?) running into issues with the vmap code not =
honouring
>>>> BBM.
>>>=20
>>> Doesn't ring a bell, so either it wasn't me, or it was many years =
ago and
>>> about 5 levels deep into trying to fix something else :/
>>=20
>> Bah, sorry! Catalin reckons it may have been him talking about the =
vmemmap.
>=20
> Indeed. The discussion with Anshuman started from this thread:
>=20
> =
https://lore.kernel.org/all/20221025014215.3466904-1-mawupeng1@huawei.com/=

>=20
> We already trip over the existing checks even without Anshuman's =
patch,
> though only by chance. We are not setting the software PTE_DIRTY on =
the
> new pte (we don't bother with this bit for kernel mappings).
>=20
> Given that the vmemmap ptes are still live when such change happens =
and
> no-one came with a solution to the break-before-make problem, I =
propose
> we revert the arm64 part of commit 47010c040dec ("mm: hugetlb_vmemmap:
> cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*"). We just need this hunk:
>=20
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 27b2592698b0..5263454a5794 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -100,7 +100,6 @@ config ARM64
> 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> 	select ARCH_WANT_FRAME_POINTERS
> 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || =
(ARM64_16K_PAGES && !ARM64_VA_BITS_36)
> -	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP

Maybe it is a little overkill for HVO as it can significantly minimize =
the
overhead of vmemmap on ARM64 servers for some workloads (like qemu, =
DPDK).
So I don't think disabling it is a good approach. Indeed, HVO broke BBM,
but the waring does not affect anything since the tail vmemmap pages are
supposed to be read-only. So, I suggest skipping warnings if it is the
vmemmap address in set_pte_at(). What do you think of?

Muchun,
Thanks.

> 	select ARCH_WANT_LD_ORPHAN_WARN
> 	select ARCH_WANTS_NO_INSTR
> 	select ARCH_WANTS_THP_SWAP if ARM64_4K_PAGES
>=20
> --=20
> Catalin

