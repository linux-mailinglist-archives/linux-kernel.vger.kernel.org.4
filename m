Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBC468FCCD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjBICDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjBICC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:02:56 -0500
Received: from out-146.mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E082748E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:02:43 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675908161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMhZHoaaJdYbb69aTlXe/6pxdfYme2CNDuDKX8yokyM=;
        b=Svg0YGWUzIg4doB+z8KZ08/SERQyshEKpDoKR+FkMd7p+myMMAwTiT096myxZzdKh4GpU6
        SF+aERa7tJAv6MfMFtOHVy9Ne/J10qvtTj1PfcqcTVFiq0KQmir4Ppmt+pZVHOMOZC72kf
        NxecOnC/1tiKF0Rfk5469HyG5UE5OP8=
Date:   Thu, 09 Feb 2023 02:02:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <cb0292e44321325fbd8c2cc069894f79@linux.dev>
Subject: Re: [PATCH] mm/page_alloc: reduce fallbacks to (MIGRATE_PCPTYPES
 - 1)
To:     "Vlastimil Babka" <vbabka@suse.cz>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Zi Yan" <ziy@nvidia.com>,
        "Mel Gorman" <mgorman@techsingularity.net>,
        "David Hildenbrand" <david@redhat.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        "Oscar Salvador" <osalvador@suse.de>
In-Reply-To: <b95505ab-8206-2a00-e199-e3defecd9d72@suse.cz>
References: <b95505ab-8206-2a00-e199-e3defecd9d72@suse.cz>
 <20230203100132.1627787-1-yajun.deng@linux.dev>
 <20230203142324.e5c0652990676ac69a4e5eb1@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

February 9, 2023 12:07 AM, "Vlastimil Babka" <vbabka@suse.cz> wrote:=0A=
=0A> On 2/3/23 23:23, Andrew Morton wrote:=0A> =0A>> On Fri, 3 Feb 2023 1=
8:01:32 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:=0A>> =0A>>> The co=
mmit 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable=0A>>> =
pageblocks with others") has removed MIGRATE_CMA and MIGRATE_ISOLATE from=
=0A>>> fallbacks list. so there is no need to add an element at the end o=
f every=0A>>> type.=0A>>> =0A>>> Reduce fallbacks to (MIGRATE_PCPTYPES - =
1).=0A> =0A> Acked-by: Vlastimil Babka <vbabka@suse.cz>=0A> =0A>> Thanks.=
 `git log' suggests who should be cc'ed when fixing things...=0A>> =0A>>>=
 --- a/mm/page_alloc.c=0A>>> +++ b/mm/page_alloc.c=0A>>> @@ -2603,10 +260=
3,10 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int o=
rder,=0A>>> *=0A>>> * The other migratetypes do not have fallbacks.=0A>>>=
 */=0A>>> -static int fallbacks[MIGRATE_TYPES][3] =3D {=0A>>> - [MIGRATE_=
UNMOVABLE] =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE, MIGRATE_TYPES },=
=0A>>> - [MIGRATE_MOVABLE] =3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, =
MIGRATE_TYPES },=0A>>> - [MIGRATE_RECLAIMABLE] =3D { MIGRATE_UNMOVABLE, M=
IGRATE_MOVABLE, MIGRATE_TYPES },=0A>>> +static int fallbacks[MIGRATE_TYPE=
S][MIGRATE_PCPTYPES - 1] =3D {=0A> =0A> Why not also reduce the first ind=
ex size from [MIGRATE_TYPES] to=0A> [MIGRATE_PCPTYPES] ?=0A> =0A=0AI over=
looked this. I'll do it in the next patch.=0A=0A>>> + [MIGRATE_UNMOVABLE]=
 =3D { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE },=0A>>> + [MIGRATE_MOVABLE] =
=3D { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },=0A>>> + [MIGRATE_RECLAIMA=
BLE] =3D { MIGRATE_UNMOVABLE, MIGRATE_MOVABLE },=0A>>> };=0A>>> =0A>>> #i=
fdef CONFIG_CMA=0A>>> @@ -2865,11 +2865,8 @@ int find_suitable_fallback(s=
truct free_area *area, unsigned int order,=0A>>> return -1;=0A>>> =0A>>> =
*can_steal =3D false;=0A>>> - for (i =3D 0;; i++) {=0A>>> + for (i =3D 0;=
 i < MIGRATE_PCPTYPES - 1 ; i++) {=0A>>> fallback_mt =3D fallbacks[migrat=
etype][i];=0A>>> - if (fallback_mt =3D=3D MIGRATE_TYPES)=0A>>> - break;=
=0A>>> -=0A>>> if (free_area_empty(area, fallback_mt))=0A>>> continue;=0A=
>>> =0A>>> --=0A>>> 2.25.1
