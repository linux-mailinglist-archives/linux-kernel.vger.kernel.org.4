Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6392A60C23B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJYDZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJYDZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:25:04 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEFF60528
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 20:25:00 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666668298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LH5DBZPs+080KlLpiMFfu+g7+DecHB8krFfWZbsth0k=;
        b=OV0xsd6mmXvElXII3FAVv1fF1vUV0GrdhSTLNqYeSCGjmvt8TcFLYae1KaI4YFER61CkEf
        Q0C/BcIn935yIfVg121J3MmNllT31UVZlfFu2nHBSNuVCEpC1S/hzW5BijQrF2N5onxVKH
        mJiUdkC+kCQJZxqHBiM2mgIIXWsjn8I=
Date:   Tue, 25 Oct 2022 03:24:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <6cccd4cba4f8407d52815c68f60446fb@linux.dev>
Subject: Re: [PATCH] memblock: remove repeat round
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y1a6BoawCoDDCo/K@kernel.org>
References: <Y1a6BoawCoDDCo/K@kernel.org>
 <20221019120337.2098298-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

October 25, 2022 12:15 AM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A=
> Hi,=0A> =0A> On Wed, Oct 19, 2022 at 08:03:37PM +0800, Yajun Deng wrote=
:=0A> =0A>> Subject: memblock: remove repeat round=0A> =0A> Please make t=
he patch subject more detailed. Say=0A> =0A> membloc: don't run loop in m=
emblock_add_range() twice=0A> =0A=0AOkay!=0A>> There is no need round twi=
ce in memblock_add_range().=0A>> =0A>> We can call memblock_double_array(=
) to extand the size if type->cnt no=0A> =0A> ^ extend=0A> =0A>> less tha=
n type->max before memblock_insert_region(), otherwise we can=0A> =0A> s/=
no less than/greater or equal to/=0A> =0A=0AGot it.=0A>> insert the new r=
egion directly.=0A>> =0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.de=
v>=0A>> ---=0A>> mm/memblock.c | 54 +++++++++++++++----------------------=
--------------=0A>> 1 file changed, 16 insertions(+), 38 deletions(-)=0A>=
> =0A>> diff --git a/mm/memblock.c b/mm/memblock.c=0A>> index 511d4783dcf=
1..1679244b4a1a 100644=0A>> --- a/mm/memblock.c=0A>> +++ b/mm/memblock.c=
=0A>> @@ -578,7 +578,6 @@ static int __init_memblock memblock_add_range(s=
truct memblock_type *type,=0A>> phys_addr_t base, phys_addr_t size,=0A>> =
int nid, enum memblock_flags flags)=0A>> {=0A>> - bool insert =3D false;=
=0A>> phys_addr_t obase =3D base;=0A>> phys_addr_t end =3D base + membloc=
k_cap_size(base, &size);=0A>> int idx, nr_new;=0A>> @@ -598,22 +597,6 @@ =
static int __init_memblock memblock_add_range(struct memblock_type *type,=
=0A>> return 0;=0A>> }=0A>> =0A>> - /*=0A>> - * The worst case is when ne=
w range overlaps all existing regions,=0A>> - * then we'll need type->cnt=
 + 1 empty regions in @type. So if=0A>> - * type->cnt * 2 + 1 is less tha=
n type->max, we know=0A>> - * that there is enough empty regions in @type=
, and we can insert=0A>> - * regions directly.=0A>> - */=0A>> - if (type-=
>cnt * 2 + 1 < type->max)=0A>> - insert =3D true;=0A>> -=0A>> -repeat:=0A=
>> - /*=0A>> - * The following is executed twice. Once with %false @inser=
t and=0A>> - * then with %true. The first counts the number of regions ne=
eded=0A>> - * to accommodate the new area. The second actually inserts th=
em.=0A>> - */=0A>> base =3D obase;=0A>> nr_new =3D 0;=0A> =0A> I believe =
nr_new variable is no longer needed, is it?=0A> =0ANo, nr_new is needed b=
efore memblock_merge_regions() for return.=0A=0A>> @@ -635,10 +618,14 @@ =
static int __init_memblock memblock_add_range(struct memblock_type *type,=
=0A>> #endif=0A>> WARN_ON(flags !=3D rgn->flags);=0A>> nr_new++;=0A>> - i=
f (insert)=0A>> - memblock_insert_region(type, idx++, base,=0A>> - rbase =
- base, nid,=0A>> - flags);=0A>> +=0A>> + if ((type->cnt >=3D type->max) =
&&=0A>> + (memblock_double_array(type, obase, size) < 0))=0A> =0A> if ((t=
ype->cnt >=3D type->max) &&=0A> memblock_double_array(type, obase, size))=
=0A> =0A> would be just fine.=0A> =0A> I'd appreciate a comment above the=
 if statement explaining when the=0A> allocation is required.=0A> =0AGot =
it.=0A=0A>> + return -ENOMEM;=0A>> +=0A>> + memblock_insert_region(type, =
idx++, base,=0A>> + rbase - base, nid,=0A>> + flags);=0A>> }=0A>> /* area=
 below @rend is dealt with, forget about it */=0A>> base =3D min(rend, en=
d);=0A>> @@ -647,28 +634,19 @@ static int __init_memblock memblock_add_ra=
nge(struct memblock_type *type,=0A>> /* insert the remaining portion */=
=0A>> if (base < end) {=0A>> nr_new++;=0A>> - if (insert)=0A>> - memblock=
_insert_region(type, idx, base, end - base,=0A>> - nid, flags);=0A>> + if=
 ((type->cnt >=3D type->max) &&=0A>> + (memblock_double_array(type, obase=
, size) < 0))=0A>> + return -ENOMEM;=0A>> +=0A>> + memblock_insert_region=
(type, idx, base, end - base,=0A>> + nid, flags);=0A>> }=0A>> =0A>> if (!=
nr_new)=0A>> return 0;=0A>> =0A>> - /*=0A>> - * If this was the first rou=
nd, resize array and repeat for actual=0A>> - * insertions; otherwise, me=
rge and return.=0A>> - */=0A>> - if (!insert) {=0A>> - while (type->cnt +=
 nr_new > type->max)=0A>> - if (memblock_double_array(type, obase, size) =
< 0)=0A>> - return -ENOMEM;=0A>> - insert =3D true;=0A>> - goto repeat;=
=0A>> - } else {=0A>> - memblock_merge_regions(type);=0A>> - return 0;=0A=
>> - }=0A>> + memblock_merge_regions(type);=0A> =0A> A blank line here wo=
uld be nice.=0A> =0AGot it.=0A=0A>> + return 0;=0A>> }=0A>> =0A>> /**=0A>=
> --=0A>> 2.25.1=0A> =0A> --=0A> Sincerely yours,=0A> Mike.
