Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60A969166C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBJB5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBJB5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:57:16 -0500
Received: from out-225.mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EDD2A149
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:57:12 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675994230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RinPeFsXh+XMzYYEWfsQdeulY7XTEoCzMTiHJ7AIgls=;
        b=bb0svPJrVm7XmGXTwmnYKCVRA1/yjOzA/0xlCBDKtFe67DN5ktFzIBgxgs7yjdXhp4MLe1
        2+dcavVmgDVFfkczF0lzMwl58J9S7accl0D+K/U1edhpqq8IrvbgojKFifPIC76rFQcegG
        W+hkK9oUxzhu8Td3mx6EEvLgOHTxVuo=
Date:   Fri, 10 Feb 2023 01:57:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <ddc2d9001ef9d44651b62869ff9575b6@linux.dev>
Subject: Re: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback()
 and fallbacks array
To:     "Zi Yan" <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, rppt@linux.ibm.com,
        osalvador@suse.de, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <4C196D76-49A9-4B06-A51F-D8A13109DF3B@nvidia.com>
References: <4C196D76-49A9-4B06-A51F-D8A13109DF3B@nvidia.com>
 <20230209101144.496144-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

February 9, 2023 11:50 PM, "Zi Yan" <ziy@nvidia.com> wrote:=0A=0A> On 9 F=
eb 2023, at 5:11, Yajun Deng wrote:=0A> =0A>> There is no need to execute=
 the next loop if it not return in the first=0A>> loop. So add a break at=
 the end of the loop.=0A> =0A> Can you explain why? If it is the case, MI=
GRATE_UNMOVABLE cannot fall back=0A> to MIGRATE_MOVABLE? And MIGRATE_MOVA=
BLE cannot fall back to MIGRATE_UNMOVABLE?=0A> And MIGRATE_RECLAIMABLE ca=
nnot fall back to MIGRATE_MOVABLE?=0A> =0A=0AThe return in the loop is on=
ly related to 'order', 'migratetype' and 'only_stealable'=0Avariables. Ev=
en if it execute the next loop, it can't change the result. So the loop=
=0Acan be broken if the first loop can't return.=0A=0A>> At the same time=
, add !migratetype_is_mergeable() before the loop and=0A>> reduce the fir=
st index size from MIGRATE_TYPES to MIGRATE_PCPTYPES in=0A>> fallbacks ar=
ray.=0A> =0A> You sent a patch: https://lore.kernel.org/all/2023020310013=
2.1627787-1-yajun.deng@linux.dev/T/#u,=0A> why not squash this one into t=
hat? Why do=0A> we need two separate small patches working on the same co=
de?=0A> =0A=0AYes, this is better, but I overlooked this one when I sent =
the first patch. It is already merged.=0A=0AAs Vlastimil Babka said, redu=
ce the first index from MIGRATE_TYPES to MIGRATE_PCPTYPES may be =0Acause=
 out of bounds access of the shrinked fallbacks array If we don't judge t=
he range of =0Amigratetype. But this doesn't happen with the second index=
.=0A=0A> Thanks.=0A> =0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.de=
v>=0A>> Acked-by: Vlastimil Babka <vbabka@suse.cz>=0A>> ---=0A>> include/=
linux/mmzone.h | 2 +-=0A>> mm/page_alloc.c | 11 +++++------=0A>> 2 files =
changed, 6 insertions(+), 7 deletions(-)=0A>> =0A>> diff --git a/include/=
linux/mmzone.h b/include/linux/mmzone.h=0A>> index ab94985ee7d9..0a817b8c=
7fb2 100644=0A>> --- a/include/linux/mmzone.h=0A>> +++ b/include/linux/mm=
zone.h=0A>> @@ -85,7 +85,7 @@ static inline bool is_migrate_movable(int m=
t)=0A>> * Check whether a migratetype can be merged with another migratet=
ype.=0A>> *=0A>> * It is only mergeable when it can fall back to other mi=
gratetypes for=0A>> - * allocation. See fallbacks[MIGRATE_TYPES][3] in pa=
ge_alloc.c.=0A>> + * allocation. See fallbacks[][] array in page_alloc.c.=
=0A>> */=0A>> static inline bool migratetype_is_mergeable(int mt)=0A>> {=
=0A>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c=0A>> index 1113483fa=
6c5..536e8d838fb5 100644=0A>> --- a/mm/page_alloc.c=0A>> +++ b/mm/page_al=
loc.c=0A>> @@ -2603,7 +2603,7 @@ struct page *__rmqueue_smallest(struct z=
one *zone, unsigned int order,=0A>> *=0A>> * The other migratetypes do no=
t have fallbacks.=0A>> */=0A>> -static int fallbacks[MIGRATE_TYPES][MIGRA=
TE_PCPTYPES - 1] =3D {=0A>> +static int fallbacks[MIGRATE_PCPTYPES][MIGRA=
TE_PCPTYPES - 1] =3D {=0A>> [MIGRATE_UNMOVABLE] =3D { MIGRATE_RECLAIMABLE=
, MIGRATE_MOVABLE },=0A>> [MIGRATE_MOVABLE] =3D { MIGRATE_RECLAIMABLE, MI=
GRATE_UNMOVABLE },=0A>> [MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVABLE, MI=
GRATE_MOVABLE },=0A>> @@ -2861,7 +2861,7 @@ int find_suitable_fallback(st=
ruct free_area *area, unsigned int order,=0A>> int i;=0A>> int fallback_m=
t;=0A>> =0A>> - if (area->nr_free =3D=3D 0)=0A>> + if (area->nr_free =3D=
=3D 0 || !migratetype_is_mergeable(migratetype))=0A>> return -1;=0A>> =0A=
>> *can_steal =3D false;=0A>> @@ -2873,11 +2873,10 @@ int find_suitable_f=
allback(struct free_area *area, unsigned int order,=0A>> if (can_steal_fa=
llback(order, migratetype))=0A>> *can_steal =3D true;=0A>> =0A>> - if (!o=
nly_stealable)=0A>> - return fallback_mt;=0A>> -=0A>> - if (*can_steal)=
=0A>> + if (!only_stealable || *can_steal)=0A>> return fallback_mt;=0A>> =
+ else=0A>> + break;=0A>> }=0A>> =0A>> return -1;=0A>> --=0A>> 2.25.1=0A>=
 =0A> --=0A> Best Regards,=0A> Yan, Zi
