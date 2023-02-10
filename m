Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670586916DF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjBJCwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBJCv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:51:59 -0500
Received: from out-141.mta1.migadu.com (out-141.mta1.migadu.com [IPv6:2001:41d0:203:375::8d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB71721C9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:51:16 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675997471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHgREwhLRCk8vMbrhrQBJ0zTZ03LfJvnd0UiicWdo8k=;
        b=xGCaTyzoq+vrRO4mVJgaqDdS6ow/C0VQ47t2zQq1pEtSpJUvo/XmDodD48RAUgFCuAMtOy
        glIYrIdjnithUBJvBFDxW/e0fTlIdPRX0rB1ZN4CfQJzwOWYlViT31gYVx/fu32IUkOCMQ
        f28ocdjcP59woRKDdMntU1Yw7qR7Tv0=
Date:   Fri, 10 Feb 2023 02:51:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <fa878915627b52d2e6fdf838b96a2f2f@linux.dev>
Subject: Re: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback()
 and fallbacks array
To:     "Zi Yan" <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, rppt@linux.ibm.com,
        osalvador@suse.de, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <626a5f4c4996f57631a8e1877c7646e5@linux.dev>
References: <626a5f4c4996f57631a8e1877c7646e5@linux.dev>
 <494D9F5D-33A4-48B4-911B-9A75CFC9BC67@nvidia.com>
 <4C196D76-49A9-4B06-A51F-D8A13109DF3B@nvidia.com>
 <20230209101144.496144-1-yajun.deng@linux.dev>
 <ddc2d9001ef9d44651b62869ff9575b6@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

February 10, 2023 10:33 AM, "Yajun Deng" <yajun.deng@linux.dev> wrote:=0A=
=0A> February 10, 2023 10:14 AM, "Zi Yan" <ziy@nvidia.com> wrote:=0A> =0A=
>> On 9 Feb 2023, at 20:57, Yajun Deng wrote:=0A>> =0A>>> February 9, 202=
3 11:50 PM, "Zi Yan" <ziy@nvidia.com> wrote:=0A>> =0A>> On 9 Feb 2023, at=
 5:11, Yajun Deng wrote:=0A>>> There is no need to execute the next loop =
if it not return in the first=0A>>> loop. So add a break at the end of th=
e loop.=0A>> =0A>> Can you explain why? If it is the case, MIGRATE_UNMOVA=
BLE cannot fall back=0A>> to MIGRATE_MOVABLE? And MIGRATE_MOVABLE cannot =
fall back to MIGRATE_UNMOVABLE?=0A>> And MIGRATE_RECLAIMABLE cannot fall =
back to MIGRATE_MOVABLE?=0A>>> The return in the loop is only related to =
'order', 'migratetype' and 'only_stealable'=0A>>> variables. Even if it e=
xecute the next loop, it can't change the result. So the loop=0A>>> can b=
e broken if the first loop can't return.=0A>> =0A>> OK. Got it. Would the=
 code below look better?=0A>> =0A>> for (i =3D 0; i < MIGRATE_PCPTYPES - =
1 ; i++) {=0A>> fallback_mt =3D fallbacks[migratetype][i];=0A>> if (free_=
area_empty(area, fallback_mt))=0A>> continue;=0A>> }=0A>> =0A>> if (can_s=
teal_fallback(order, migratetype))=0A>> *can_steal =3D true;=0A>> =0A>> i=
f (!only_stealable || *can_steal)=0A>> return fallback_mt;=0A>> =0A>> ret=
urn -1;=0A> =0A> Yes, I'll submit a v3 patch.=0A> Thanks.=0A> =0A=0AI fou=
nd a logical error in your code. It should be like this:=0A=0A        for=
 (i =3D 0; i < MIGRATE_PCPTYPES - 1 ; i++) {=0A                fallback_m=
t =3D fallbacks[migratetype][i];=0A                if (!free_area_empty(a=
rea, fallback_mt))=0A                        break;=0A        }=0A=0A    =
    if (can_steal_fallback(order, migratetype))=0A                *can_st=
eal =3D true;=0A=0A        if (!only_stealable || *can_steal)=0A         =
       return fallback_mt;=0A=0A        return -1;=0A=0AThis code will mo=
dify the logic to the opposite.=0ASo can anyone tell me if I should use t=
his code or the v2 patch?=0A=0A=0A>>> At the same time, add !migratetype_=
is_mergeable() before the loop and=0A>>> reduce the first index size from=
 MIGRATE_TYPES to MIGRATE_PCPTYPES in=0A>>> fallbacks array.=0A>> =0A>> Y=
ou sent a patch: https://lore.kernel.org/all/20230203100132.1627787-1-yaj=
un.deng@linux.dev/T/#u,=0A>> why not squash this one into that? Why do=0A=
>> we need two separate small patches working on the same code?=0A>>> Yes=
, this is better, but I overlooked this one when I sent the first patch. =
It is already merged.=0A>>> =0A>>> As Vlastimil Babka said, reduce the fi=
rst index from MIGRATE_TYPES to MIGRATE_PCPTYPES may be=0A>>> cause out o=
f bounds access of the shrinked fallbacks array If we don't judge the ran=
ge of=0A>>> migratetype. But this doesn't happen with the second index.=
=0A>> =0A>> Thanks.=0A>>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev=
>=0A>>> Acked-by: Vlastimil Babka <vbabka@suse.cz>=0A>>> ---=0A>>> includ=
e/linux/mmzone.h | 2 +-=0A>>> mm/page_alloc.c | 11 +++++------=0A>>> 2 fi=
les changed, 6 insertions(+), 7 deletions(-)=0A>>> =0A>>> diff --git a/in=
clude/linux/mmzone.h b/include/linux/mmzone.h=0A>>> index ab94985ee7d9..0=
a817b8c7fb2 100644=0A>>> --- a/include/linux/mmzone.h=0A>>> +++ b/include=
/linux/mmzone.h=0A>>> @@ -85,7 +85,7 @@ static inline bool is_migrate_mov=
able(int mt)=0A>>> * Check whether a migratetype can be merged with anoth=
er migratetype.=0A>>> *=0A>>> * It is only mergeable when it can fall bac=
k to other migratetypes for=0A>>> - * allocation. See fallbacks[MIGRATE_T=
YPES][3] in page_alloc.c.=0A>>> + * allocation. See fallbacks[][] array i=
n page_alloc.c.=0A>>> */=0A>>> static inline bool migratetype_is_mergeabl=
e(int mt)=0A>>> {=0A>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c=0A=
>>> index 1113483fa6c5..536e8d838fb5 100644=0A>>> --- a/mm/page_alloc.c=
=0A>>> +++ b/mm/page_alloc.c=0A>>> @@ -2603,7 +2603,7 @@ struct page *__r=
mqueue_smallest(struct zone *zone, unsigned int order,=0A>>> *=0A>>> * Th=
e other migratetypes do not have fallbacks.=0A>>> */=0A>>> -static int fa=
llbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] =3D {=0A>>> +static int fall=
backs[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] =3D {=0A>>> [MIGRATE_UNMOVA=
BLE] =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE },=0A>>> [MIGRATE_MOVABLE=
] =3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },=0A>>> [MIGRATE_RECLAIMA=
BLE] =3D { MIGRATE_UNMOVABLE, MIGRATE_MOVABLE },=0A>>> @@ -2861,7 +2861,7=
 @@ int find_suitable_fallback(struct free_area *area, unsigned int order=
,=0A>>> int i;=0A>>> int fallback_mt;=0A>>> =0A>>> - if (area->nr_free =
=3D=3D 0)=0A>>> + if (area->nr_free =3D=3D 0 || !migratetype_is_mergeable=
(migratetype))=0A>>> return -1;=0A>>> =0A>>> *can_steal =3D false;=0A>>> =
@@ -2873,11 +2873,10 @@ int find_suitable_fallback(struct free_area *area=
, unsigned int order,=0A>>> if (can_steal_fallback(order, migratetype))=
=0A>>> *can_steal =3D true;=0A>>> =0A>>> - if (!only_stealable)=0A>>> - r=
eturn fallback_mt;=0A>>> -=0A>>> - if (*can_steal)=0A>>> + if (!only_stea=
lable || *can_steal)=0A>>> return fallback_mt;=0A>>> + else=0A>>> + break=
;=0A>>> }=0A>>> =0A>>> return -1;=0A>>> --=0A>>> 2.25.1=0A>> =0A>> --=0A>=
> Best Regards,=0A>> Yan, Zi=0A>> =0A>> --=0A>> Best Regards,=0A>> Yan, Z=
i
