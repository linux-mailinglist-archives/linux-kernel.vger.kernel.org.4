Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9397A69025B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjBIIoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:44:13 -0500
Received: from out-88.mta1.migadu.com (out-88.mta1.migadu.com [95.215.58.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B772C67D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:44:10 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675932248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X09NlSnlCqOFDHRmNIUla4/Fdrekk7b5KqSyYEpqWl8=;
        b=WwQGh7T9xxTDhr9W788ubHBHcdXgYY7Oqovq8/c9trbzG6OndR+u8qbMNc2OFhttbkT/m/
        8eKX8QOVMyAemHWbNxTIPeSlxVP293Ju4CqdYN6UvsEDMe1M2QSS82HQ3BgUhyz6BKXCfe
        izEKhVRlxFKMICPZA45aYQo1YX9IJkA=
Date:   Thu, 09 Feb 2023 08:44:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <7cc548bc6be5f84e1fb9c6cac07b7451@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: optimize the loop in
 find_suitable_fallback()
To:     "Vlastimil Babka" <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     ziy@nvidia.com, mgorman@techsingularity.net, david@redhat.com,
        rppt@linux.ibm.com, osalvador@suse.de, rppt@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <362e1270-8a54-36f5-f7c0-d922b3d12860@suse.cz>
References: <362e1270-8a54-36f5-f7c0-d922b3d12860@suse.cz>
 <20230209024435.3392916-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

February 9, 2023 4:12 PM, "Vlastimil Babka" <vbabka@suse.cz> wrote:=0A=0A=
> On 2/9/23 03:44, Yajun Deng wrote:=0A> =0A>> There is no need to execut=
e the next loop if it not return in the first=0A>> loop. So add a break a=
t the end of the loop.=0A>> =0A>> There are only three rows in fallbacks,=
 so reduce the first index size=0A>> from MIGRATE_TYPES to MIGRATE_PCPTYP=
ES.=0A>> =0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A> =0A> =
Acked-by: Vlastimil Babka <vbabka@suse.cz>=0A> =0A>> ---=0A>> mm/page_all=
oc.c | 11 +++++------=0A>> 1 file changed, 5 insertions(+), 6 deletions(-=
)=0A>> =0A>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c=0A>> index 11=
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
ee =3D=3D 0 || !migratetype_is_mergeable(migratetype))=0A> =0A> Just curi=
ous, did you the check for extra safety or did you find (by running=0A> o=
r code inspection) that this can be indeed called with a non-mergeable=0A=
> migratetype, and cause out of bounds access of the shrinked fallbacks a=
rray?=0A> =0A=0ANo, I'm not sure if it is called with a non-mergeable mig=
ratetype.=0AIt is just for extra safety.=0A=0A> BTW, I noticed the commme=
nt on migratetype_is_mergeable() contains:=0A> =0A> "See fallbacks[MIGRAT=
E_TYPES][3] in page_alloc.c. "=0A> =0A> Should probably change it to e.g.=
 "See fallbacks[][] array ..." so we don't=0A> have to keep it in exact s=
ync...=0A> =0A=0AYes, this comment should be changed.=0ASo do I need to s=
ubmit a v2 patch?=0A=0A>> return -1;=0A>> =0A>> *can_steal =3D false;=0A>=
> @@ -2873,11 +2873,10 @@ int find_suitable_fallback(struct free_area *ar=
ea, unsigned int order,=0A>> if (can_steal_fallback(order, migratetype))=
=0A>> *can_steal =3D true;=0A>> =0A>> - if (!only_stealable)=0A>> - retur=
n fallback_mt;=0A>> -=0A>> - if (*can_steal)=0A>> + if (!only_stealable |=
| *can_steal)=0A>> return fallback_mt;=0A>> + else=0A>> + break;=0A>> }=
=0A>> =0A>> return -1;
