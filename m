Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413425B8C56
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiINPzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiINPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:55:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B6913D2F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 08:55:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AE29B81178
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 15:55:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4316CC433C1;
        Wed, 14 Sep 2022 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663170911;
        bh=CeuOyMEVkb9REc9JL9C/aOeVs5Xn30KZu2M8Yy4gaf4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=bwd8sgNa8Eaiz7FyieMf+7bse0D/zBZQNjBrtdutXOnYa/3SeloxTdxL1OF7r8HYY
         UYVNGidVoxiXCrW+Myk2jalsvr65rqcRIZAwm83jl2iyigTwx4iqwveKUoNwX2RWc5
         XLjSSQjrOSRZuG29AhdfbA6WBsRMR/BnQFqzTlEueFN7QQ4gh1eHUC2/3LUggDyLva
         IABWU8CQ5GG7Rg56pIqFIerdic5jnRPNZItEMVeaHEZ3hBQGPXb4Xb2xqYfkCQ5Nas
         ImH8tpWTnoINRkULP8Ot1uI8EDFRNikzIf/kIhwbF4k3ets54BPKMB05y8eGdvARZY
         rw9AKPBIydjzg==
Date:   Wed, 14 Sep 2022 16:55:04 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        Ash Logan <ash@heyquark.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "j.ne@posteo.net" <j.ne@posteo.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Fragmented physical memory on powerpc/32
User-Agent: K-9 Mail for Android
In-Reply-To: <ed8ff681-4182-3f9f-a65f-21cf5012fff0@csgroup.eu>
References: <20220609222420.ponpoodiqmaqtwht@pali> <20220808184034.lskqrk6z3gb5q76r@pali> <219cda7b-da4b-7a5a-9809-0878e0fc02ba@csgroup.eu> <20220908153511.57ceunyusziqfcav@pali> <20220908201701.sd3zqn5hfixmjvhh@pali> <9fbc5338-5e10-032a-8f55-e080bd93f74b@csgroup.eu> <Yx9GpV1XT8r2a++R@kernel.org> <20220912211623.djb7fckgknyfmof7@pali> <1c95875c-29f8-68b7-e480-fed8614f3037@csgroup.eu> <4f540391-37dc-8e22-be0a-74543082504d@csgroup.eu> <YyGfkDKgeW7/nNlr@kernel.org> <ed8ff681-4182-3f9f-a65f-21cf5012fff0@csgroup.eu>
Message-ID: <9779CA34-E40D-4035-A319-A92D2F6E4DDF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 14, 2022 10:43:52 AM GMT+01:00, Christophe Leroy <christophe=
=2Eleroy@csgroup=2Eeu> wrote:
>
>
>Le 14/09/2022 =C3=A0 11:32, Mike Rapoport a =C3=A9crit=C2=A0:
>> On Tue, Sep 13, 2022 at 02:36:13PM +0200, Christophe Leroy wrote:
>>>
>>>
>>> Le 13/09/2022 =C3=A0 08:11, Christophe Leroy a =C3=A9crit=C2=A0:
>>>>
>>>>
>>>> Le 12/09/2022 =C3=A0 23:16, Pali Roh=C3=A1r a =C3=A9crit=C2=A0:
>>>>>>
>>>>>> My guess would be that something went wrong in the linear map
>>>>>> setup, but it
>>>>>> won't hurt running with "memblock=3Ddebug" added to the kernel
>>>>>> command line
>>>>>> to see if there is anything suspicious there=2E
>>>>>
>>>>> Here is boot log on serial console with memblock=3Ddebug command lin=
e:
>>>>>
>>>> =2E=2E=2E
>>>>>
>>>>> Do you need something more for debug?
>>>>
>>>> Can you send me the 'vmlinux' used to generate the above Oops so that=
 I
>>>> can see exactly where we are in function mem_init()=2E
>>>>
>>>> And could you also try without CONFIG_HIGHMEM just in case=2E
>>>>
>>>
>>> I looked at the vmlinux you sent me, the problem is in the loop for hi=
ghmem
>>> in mem_init()=2E It crashes in the call to free_highmem_page()
>>>
>>> #ifdef CONFIG_HIGHMEM
>>> 	{
>>> 		unsigned long pfn, highmem_mapnr;
>>>
>>> 		highmem_mapnr =3D lowmem_end_addr >> PAGE_SHIFT;
>>> 		for (pfn =3D highmem_mapnr; pfn < max_mapnr; ++pfn) {
>>> 			phys_addr_t paddr =3D (phys_addr_t)pfn << PAGE_SHIFT;
>>> 			struct page *page =3D pfn_to_page(pfn);
>>> 			if (!memblock_is_reserved(paddr))
>>> 				free_highmem_page(page);
>>> 		}
>>> 	}
>>> #endif /* CONFIG_HIGHMEM */
>>>
>>>
>>> As far as I can see in the memblock debug lines, the holes don't seem =
to be
>>> marked as reserved by memblock=2E So it is above valid ? Other archite=
ctures
>>> seem to do differently=2E
>>>
>>> Can you try by replacing !memblock_is_reserved(paddr) by
>>> memblock_is_memory(paddr) ?
>>=20
>> The holes should not be marked as reserved, we just need to loop over t=
he
>> memory ranges rather than over pfns=2E Then the holes will be taken int=
o
>> account=2E
>>=20
>> I believe arm and xtensa got this right:
>>=20
>> (from arch/arm/mm/init=2Ec)
>>=20
>> static void __init free_highpages(void)
>> {
>> #ifdef CONFIG_HIGHMEM
>> 	unsigned long max_low =3D max_low_pfn;
>> 	phys_addr_t range_start, range_end;
>> 	u64 i;
>>=20
>> 	/* set highmem page free */
>> 	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
>> 				&range_start, &range_end, NULL) {
>> 		unsigned long start =3D PFN_UP(range_start);
>> 		unsigned long end =3D PFN_DOWN(range_end);
>>=20
>> 		/* Ignore complete lowmem entries */
>> 		if (end <=3D max_low)
>> 			continue;
>>=20
>> 		/* Truncate partial highmem entries */
>> 		if (start < max_low)
>> 			start =3D max_low;
>>=20
>> 		for (; start < end; start++)
>> 			free_highmem_page(pfn_to_page(start));
>> 	}
>> #endif
>> }
>>=20
>
>
>And what about the way MIPS does it ?
>
>static inline void __init mem_init_free_highmem(void)
>{
>#ifdef CONFIG_HIGHMEM
>	unsigned long tmp;
>
>	if (cpu_has_dc_aliases)
>		return;
>
>	for (tmp =3D highstart_pfn; tmp < highend_pfn; tmp++) {
>		struct page *page =3D pfn_to_page(tmp);
>
>		if (!memblock_is_memory(PFN_PHYS(tmp)))
>			SetPageReserved(page);
>		else
>			free_highmem_page(page);
>	}
>#endif
>}

This iterates over all PFNs in the highmem range and skips those in holes=
=2E
for_each_free_mem_range() skips the holes altogether=2E

Largely, I think we need to move, say, arm's version to mm/ and use it eve=
rywhere, except, perhaps, x86=2E

>Christophe
--=20
Sincerely yours,
Mike
