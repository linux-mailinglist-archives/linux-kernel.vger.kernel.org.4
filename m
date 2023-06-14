Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C872F15E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 03:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjFNBK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 21:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjFNBKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 21:10:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319471BE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 18:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686705053; x=1718241053;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=azG8hPwvF5L6fVTdJH7JGGkoqQA3l0SkJuzFaSDICuE=;
  b=F9T0ypyTjXmTQ3/CYXY3jsVIr/Gr/DwnIVWLhnJTXRx0ID6Fh1UyZTko
   PWD8+djTY5ROMMnbRnizP8hf/QsVskMYmgSty5ioyEo3PJ2vb16nMX+Rf
   SPJ5FeE1om+rzNcXzXru/m17poawg1ZuvZYW4K9zURU2BIFfrTxLBcPL5
   XkAr4I5Pvr81ntdK4py6nqhrQxfQ7lNUN/ykdKsKnwQMvDmiY5XEBw6d3
   EgWMUlnyc0YcaCdVf4OcWMNaFg8v7UizwkZcOji73HI4y40DWZqeMC+WQ
   mEvQWNpxJki6Ypzly3aGxsbtGJwAqTjOpA/BTd/5kb018X0fh87FXOsTe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="348146734"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="348146734"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 18:10:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="744890461"
X-IronPort-AV: E=Sophos;i="6.00,241,1681196400"; 
   d="scan'208";a="744890461"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 18:10:33 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: compaction: skip memory hole rapidly when
 isolating migratable pages
References: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
        <c9384e52-3f3b-cb1b-a607-955cd7066422@redhat.com>
        <838c3066-43e9-2035-cf69-4957481cddda@linux.alibaba.com>
        <77b2ffeb-732c-229e-0f41-f63f75e43164@redhat.com>
Date:   Wed, 14 Jun 2023 09:08:55 +0800
In-Reply-To: <77b2ffeb-732c-229e-0f41-f63f75e43164@redhat.com> (David
        Hildenbrand's message of "Tue, 13 Jun 2023 14:36:33 +0200")
Message-ID: <87wn06j1eg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 13.06.23 13:13, Baolin Wang wrote:
>> On 6/13/2023 5:56 PM, David Hildenbrand wrote:
>>> On 13.06.23 10:55, Baolin Wang wrote:
>>>> On some machines, the normal zone can have a large memory hole like
>>>> below memory layout, and we can see the range from 0x100000000 to
>>>> 0x1800000000 is a hole. So when isolating some migratable pages, the
>>>> scanner can meet the hole and it will take more time to skip the large
>>>> hole. From my measurement, I can see the isolation scanner will take
>>>> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
>>>>
>>>> So adding a new helper to fast search next online memory section
>>>> to skip the large hole can help to find next suitable pageblock
>>>> efficiently. With this patch, I can see the large hole scanning only
>>>> takes < 1us.
>>>>
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] Zone ranges:
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 [mem 0x0000000040000000-0x00000000ffffffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 DMA32=C2=A0=C2=A0=C2=A0 empty
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 Normal=C2=A0=C2=A0 [mem 0x00=
00000100000000-0x0000001fa7ffffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] Movable zone start for each node
>>>> [=C2=A0=C2=A0=C2=A0 0.000000] Early memory node ranges
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000000040000000-0x0000000fffffffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001800000000-0x0000001fa3c7ffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa3c80000-0x0000001fa3ffffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa4000000-0x0000001fa402ffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa4030000-0x0000001fa40effff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa40f0000-0x0000001fa73cffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa73d0000-0x0000001fa745ffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa7460000-0x0000001fa746ffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa7470000-0x0000001fa758ffff]
>>>> [=C2=A0=C2=A0=C2=A0 0.000000]=C2=A0=C2=A0 node=C2=A0=C2=A0 0: [mem 0x0=
000001fa7590000-0x0000001fa7ffffff]
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>> Changes from v1:
>>>>  =C2=A0 - Fix building errors if CONFIG_SPARSEMEM is not selected.
>>>>  =C2=A0 - Use NR_MEM_SECTIONS instead of '-1' per Huang Ying.
>>>> ---
>>>>  =C2=A0 include/linux/mmzone.h | 10 ++++++++++
>>>>  =C2=A0 mm/compaction.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30=
 +++++++++++++++++++++++++++++-
>>>>  =C2=A0 2 files changed, 39 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>>>> index 5a7ada0413da..5ff1fa2efe28 100644
>>>> --- a/include/linux/mmzone.h
>>>> +++ b/include/linux/mmzone.h
>>>> @@ -2000,6 +2000,16 @@ static inline unsigned long
>>>> next_present_section_nr(unsigned long section_nr)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>>  =C2=A0 }
>>>> +static inline unsigned long next_online_section_nr(unsigned long
>>>> section_nr)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 while (++section_nr <=3D __highest_present_section=
_nr) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (online_section_nr(sect=
ion_nr))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn section_nr;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return NR_MEM_SECTIONS;
>>>> +}
>>>> +
>>>>  =C2=A0 /*
>>>>  =C2=A0=C2=A0 * These are _only_ used during initialisation, therefore=
 they
>>>>  =C2=A0=C2=A0 * can use __initdata ...=C2=A0 They could have names to =
indicate
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index 3398ef3a55fe..c31ff6123891 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -229,6 +229,28 @@ static void reset_cached_positions(struct zone
>>>> *zone)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pageblock_start_pfn(zone_end_pfn(zone) - =
1);
>>>>  =C2=A0 }
>>>> +#ifdef CONFIG_SPARSEMEM
>>>> +static unsigned long skip_hole_pageblock(unsigned long start_pfn)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long next_online_nr;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long start_nr =3D pfn_to_section_nr(start=
_pfn);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (online_section_nr(start_nr))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 next_online_nr =3D next_online_section_nr(start_nr=
);
>>>> +=C2=A0=C2=A0=C2=A0 if (next_online_nr < NR_MEM_SECTIONS)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return section_nr_to_pfn(n=
ext_online_nr);
>>>> +
>>>
>>> I would simply inline next_online_section_nr and simplify (and add a
>>> comment):
>>>
>>> /*
>>>   =C2=A0* If the PFN falls into an offline section, return the start PF=
N of the
>>>   =C2=A0* next online section. If the PFN falls into an online section =
or if
>>>   =C2=A0* there is no next online section, return 0.
>>>   =C2=A0*/
>>> static unsigned long skip_hole_pageblock(unsigned long start_pfn)
>>> {
>>>   =C2=A0=C2=A0=C2=A0=C2=A0unsigned long nr =3D pfn_to_section_nr(start_=
pfn);
>>>
>>>   =C2=A0=C2=A0=C2=A0=C2=A0if (online_section_nr(nr))
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>
>>>   =C2=A0=C2=A0=C2=A0=C2=A0while (++nr <=3D __highest_present_section_nr=
) {
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (online_section_nr(nr))
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn section_nr_to_pfn(nr);
>>>   =C2=A0=C2=A0=C2=A0=C2=A0}
>>>   =C2=A0=C2=A0=C2=A0=C2=A0return 0
>>> }
>>>
>>> Easier, no?
>> Originally I want to add a common helper like
>> next_present_section_nr(),
>> which can be used by other users. But yes, your suggestion is easier,
>> and I am fine with that.
>>=20
>>> And maybe just call that function "skip_offline_sections()" then?
>>> Because we're not operating on pageblocks.
>> OK. Thanks.
>>=20
>
> Feel free to add to the simplified version
>
> Acked-by: David Hildenbrand <david@redhat.com>

With David's above comments addressed, feel free to add

Acked-by: "Huang, Ying" <ying.huang@intel.com>
