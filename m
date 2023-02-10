Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AF56916B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 03:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBJCd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 21:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBJCd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 21:33:56 -0500
X-Greylist: delayed 58910 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 18:33:53 PST
Received: from out-95.mta1.migadu.com (out-95.mta1.migadu.com [IPv6:2001:41d0:203:375::5f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308E21A22
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 18:33:53 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675996430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qZgslIhozh5iAyrVtnK6cx6++WSjKW0MyBqEgbTn14=;
        b=pFJPpcEqqYnLoGy1XK3P7gElVhRRf5laAM5WgIBwP9hwmO9oaf/DpunQ6FgZo4APAGYgxJ
        Yprz1LxbLC/6DdJondvR92Hg1x2Lx1Fsaj3O9nSe84uT2aPdzCQv5cH72yfasWZaoZXxGx
        g39X2JLL6lCgBG1gdUzC3tX6hvtecXc=
Date:   Fri, 10 Feb 2023 02:33:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <626a5f4c4996f57631a8e1877c7646e5@linux.dev>
Subject: Re: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback()
 and fallbacks array
To:     "Zi Yan" <ziy@nvidia.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        david@redhat.com, vbabka@suse.cz, rppt@linux.ibm.com,
        osalvador@suse.de, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <494D9F5D-33A4-48B4-911B-9A75CFC9BC67@nvidia.com>
References: <494D9F5D-33A4-48B4-911B-9A75CFC9BC67@nvidia.com>
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

February 10, 2023 10:14 AM, "Zi Yan" <ziy@nvidia.com> wrote:=0A=0A> On 9 =
Feb 2023, at 20:57, Yajun Deng wrote:=0A> =0A>> February 9, 2023 11:50 PM=
, "Zi Yan" <ziy@nvidia.com> wrote:=0A>> =0A>>> On 9 Feb 2023, at 5:11, Ya=
jun Deng wrote:=0A>> =0A>> There is no need to execute the next loop if i=
t not return in the first=0A>> loop. So add a break at the end of the loo=
p.=0A>>> Can you explain why? If it is the case, MIGRATE_UNMOVABLE cannot=
 fall back=0A>>> to MIGRATE_MOVABLE? And MIGRATE_MOVABLE cannot fall back=
 to MIGRATE_UNMOVABLE?=0A>>> And MIGRATE_RECLAIMABLE cannot fall back to =
MIGRATE_MOVABLE?=0A>> =0A>> The return in the loop is only related to 'or=
der', 'migratetype' and 'only_stealable'=0A>> variables. Even if it execu=
te the next loop, it can't change the result. So the loop=0A>> can be bro=
ken if the first loop can't return.=0A> =0A> OK. Got it. Would the code b=
elow look better?=0A> =0A> for (i =3D 0; i < MIGRATE_PCPTYPES - 1 ; i++) =
{=0A> fallback_mt =3D fallbacks[migratetype][i];=0A> if (free_area_empty(=
area, fallback_mt))=0A> continue;=0A> }=0A> =0A> if (can_steal_fallback(o=
rder, migratetype))=0A> *can_steal =3D true;=0A> =0A> if (!only_stealable=
 || *can_steal)=0A> return fallback_mt;=0A> =0A> return -1;=0A> =0A=0AYes=
, I'll submit a v3 patch. =0AThanks.=0A=0A>> At the same time, add !migra=
tetype_is_mergeable() before the loop and=0A>> reduce the first index siz=
e from MIGRATE_TYPES to MIGRATE_PCPTYPES in=0A>> fallbacks array.=0A>>> Y=
ou sent a patch: https://lore.kernel.org/all/20230203100132.1627787-1-yaj=
un.deng@linux.dev/T/#u,=0A>>> why not squash this one into that? Why do=
=0A>>> we need two separate small patches working on the same code?=0A>> =
=0A>> Yes, this is better, but I overlooked this one when I sent the firs=
t patch. It is already merged.=0A>> =0A>> As Vlastimil Babka said, reduce=
 the first index from MIGRATE_TYPES to MIGRATE_PCPTYPES may be=0A>> cause=
 out of bounds access of the shrinked fallbacks array If we don't judge t=
he range of=0A>> migratetype. But this doesn't happen with the second ind=
ex.=0A>> =0A>>> Thanks.=0A>> =0A>> Signed-off-by: Yajun Deng <yajun.deng@=
linux.dev>=0A>> Acked-by: Vlastimil Babka <vbabka@suse.cz>=0A>> ---=0A>> =
include/linux/mmzone.h | 2 +-=0A>> mm/page_alloc.c | 11 +++++------=0A>> =
2 files changed, 6 insertions(+), 7 deletions(-)=0A>> =0A>> diff --git a/=
include/linux/mmzone.h b/include/linux/mmzone.h=0A>> index ab94985ee7d9..=
0a817b8c7fb2 100644=0A>> --- a/include/linux/mmzone.h=0A>> +++ b/include/=
linux/mmzone.h=0A>> @@ -85,7 +85,7 @@ static inline bool is_migrate_movab=
le(int mt)=0A>> * Check whether a migratetype can be merged with another =
migratetype.=0A>> *=0A>> * It is only mergeable when it can fall back to =
other migratetypes for=0A>> - * allocation. See fallbacks[MIGRATE_TYPES][=
3] in page_alloc.c.=0A>> + * allocation. See fallbacks[][] array in page_=
alloc.c.=0A>> */=0A>> static inline bool migratetype_is_mergeable(int mt)=
=0A>> {=0A>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c=0A>> index 11=
13483fa6c5..536e8d838fb5 100644=0A>> --- a/mm/page_alloc.c=0A>> +++ b/mm/=
page_alloc.c=0A>> @@ -2603,7 +2603,7 @@ struct page *__rmqueue_smallest(s=
truct zone *zone, unsigned int order,=0A>> *=0A>> * The other migratetype=
s do not have fallbacks.=0A>> */=0A>> -static int fallbacks[MIGRATE_TYPES=
][MIGRATE_PCPTYPES - 1] =3D {=0A>> +static int fallbacks[MIGRATE_PCPTYPES=
][MIGRATE_PCPTYPES - 1] =3D {=0A>> [MIGRATE_UNMOVABLE] =3D { MIGRATE_RECL=
AIMABLE, MIGRATE_MOVABLE },=0A>> [MIGRATE_MOVABLE] =3D { MIGRATE_RECLAIMA=
BLE, MIGRATE_UNMOVABLE },=0A>> [MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVA=
BLE, MIGRATE_MOVABLE },=0A>> @@ -2861,7 +2861,7 @@ int find_suitable_fall=
back(struct free_area *area, unsigned int order,=0A>> int i;=0A>> int fal=
lback_mt;=0A>> =0A>> - if (area->nr_free =3D=3D 0)=0A>> + if (area->nr_fr=
ee =3D=3D 0 || !migratetype_is_mergeable(migratetype))=0A>> return -1;=0A=
>> =0A>> *can_steal =3D false;=0A>> @@ -2873,11 +2873,10 @@ int find_suit=
able_fallback(struct free_area *area, unsigned int order,=0A>> if (can_st=
eal_fallback(order, migratetype))=0A>> *can_steal =3D true;=0A>> =0A>> - =
if (!only_stealable)=0A>> - return fallback_mt;=0A>> -=0A>> - if (*can_st=
eal)=0A>> + if (!only_stealable || *can_steal)=0A>> return fallback_mt;=
=0A>> + else=0A>> + break;=0A>> }=0A>> =0A>> return -1;=0A>> --=0A>> 2.25=
.1=0A>>> --=0A>>> Best Regards,=0A>>> Yan, Zi=0A> =0A> --=0A> Best Regard=
s,=0A> Yan, Zi
