Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8F96919D1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 09:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjBJIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 03:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBJIMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 03:12:55 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [IPv6:2001:41d0:203:375::b6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B46A35242
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 00:12:30 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676016747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0iIN3s9vceowifsKNRpYFbtpERy3OAkbKuMLhL+6OCs=;
        b=xm7MF3M1UrxQOTkLJJxrLvzbdGX2ezmqbvS9gW3dvv2NWG2URyMWdtqyRk/zFHJsfCtjUO
        2lC9s78TQMa8MDMu6eHYFstTI746vThdY0/yyHI0maG0q3FCDMlE2umsoqdagokbQQycxE
        a0qVc7I+P/SVKz4iniAWyfwPsPU4QJ8=
Date:   Fri, 10 Feb 2023 08:12:23 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <58d940aba3433bc6928e91c2272a8410@linux.dev>
Subject: Re: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback()
 and fallbacks array
To:     "Vlastimil Babka" <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, david@redhat.com, rppt@linux.ibm.com,
        osalvador@suse.de, rppt@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ziy@nvidia.com
In-Reply-To: <c68af237-11b1-aafa-3a0b-132690f825d6@suse.cz>
References: <c68af237-11b1-aafa-3a0b-132690f825d6@suse.cz>
 <626a5f4c4996f57631a8e1877c7646e5@linux.dev>
 <494D9F5D-33A4-48B4-911B-9A75CFC9BC67@nvidia.com>
 <4C196D76-49A9-4B06-A51F-D8A13109DF3B@nvidia.com>
 <20230209101144.496144-1-yajun.deng@linux.dev>
 <ddc2d9001ef9d44651b62869ff9575b6@linux.dev>
 <fa878915627b52d2e6fdf838b96a2f2f@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

February 10, 2023 3:58 PM, "Vlastimil Babka" <vbabka@suse.cz> wrote:=0A=
=0A> On 2/10/23 03:51, Yajun Deng wrote:=0A> =0A>> February 10, 2023 10:3=
3 AM, "Yajun Deng" <yajun.deng@linux.dev> wrote:=0A>> =0A>>> February 10,=
 2023 10:14 AM, "Zi Yan" <ziy@nvidia.com> wrote:=0A>> =0A>> On 9 Feb 2023=
, at 20:57, Yajun Deng wrote:=0A>> =0A>> February 9, 2023 11:50 PM, "Zi Y=
an" <ziy@nvidia.com> wrote:=0A>> =0A>> On 9 Feb 2023, at 5:11, Yajun Deng=
 wrote:=0A>> There is no need to execute the next loop if it not return i=
n the first=0A>> loop. So add a break at the end of the loop.=0A>> =0A>> =
Can you explain why? If it is the case, MIGRATE_UNMOVABLE cannot fall bac=
k=0A>> to MIGRATE_MOVABLE? And MIGRATE_MOVABLE cannot fall back to MIGRAT=
E_UNMOVABLE?=0A>> And MIGRATE_RECLAIMABLE cannot fall back to MIGRATE_MOV=
ABLE?=0A>> The return in the loop is only related to 'order', 'migratetyp=
e' and 'only_stealable'=0A>> variables. Even if it execute the next loop,=
 it can't change the result. So the loop=0A>> can be broken if the first =
loop can't return.=0A>> =0A>> OK. Got it. Would the code below look bette=
r?=0A>> =0A>> for (i =3D 0; i < MIGRATE_PCPTYPES - 1 ; i++) {=0A>> fallba=
ck_mt =3D fallbacks[migratetype][i];=0A>> if (free_area_empty(area, fallb=
ack_mt))=0A>> continue;=0A>> }=0A>> =0A>> if (can_steal_fallback(order, m=
igratetype))=0A>> *can_steal =3D true;=0A>> =0A>> if (!only_stealable || =
*can_steal)=0A>> return fallback_mt;=0A>> =0A>> return -1;=0A>>> Yes, I'l=
l submit a v3 patch.=0A>>> Thanks.=0A>> =0A>> I found a logical error in =
your code. It should be like this:=0A>> =0A>> for (i =3D 0; i < MIGRATE_P=
CPTYPES - 1 ; i++) {=0A>> fallback_mt =3D fallbacks[migratetype][i];=0A>>=
 if (!free_area_empty(area, fallback_mt))=0A>> break;=0A>> }=0A>> =0A>> i=
f (can_steal_fallback(order, migratetype))=0A>> *can_steal =3D true;=0A>>=
 =0A>> if (!only_stealable || *can_steal)=0A>> return fallback_mt;=0A>> =
=0A>> return -1;=0A>> =0A>> This code will modify the logic to the opposi=
te.=0A> =0A> It's still wrong, IMHO. If all fallbacks have free_area_empt=
y(), it will=0A> return the last one and not -1. Also will set *can_steal=
 in such case.=0A> =0A=0AYes, you are right.=0A=0A>> So can anyone tell m=
e if I should use this code or the v2 patch?=0A> =0A> Once that bugs are =
fixed, the result will probably not look much better than=0A> v2, so I do=
n't mind keeping v2.=0A=0AI agree with that.
