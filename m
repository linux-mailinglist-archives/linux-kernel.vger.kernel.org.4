Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3287B730D67
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238903AbjFODDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbjFODDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:03:01 -0400
Received: from out-34.mta0.migadu.com (out-34.mta0.migadu.com [91.218.175.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CAE26A8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:03:00 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686798178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTBLikR+nElJ/6KpNyp6r3fLW0Bxen1kyP8+qa7AGa4=;
        b=S7YHxdHe5jFLP5OpRi1b7J95PQyFD7S7V+K9laipGHXyFkg1rW0j87M+UOjkYoj9LOwpMt
        /dD6EqjaY/qtt6aGfthr2zb8Uh3lhGFEdA4pEmqFMwkWAShT42o9N9ZfTZ5Kq7Bb6WZf1S
        CvMlMfg/f+gnW64ewyKRdyKa9j+SiDw=
Date:   Thu, 15 Jun 2023 03:02:58 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <a96c998f9d73f03c85463d7314f6ea8a@linux.dev>
Subject: Re: [PATCH] mm/mm_init.c: remove spinlock in early_pfn_to_nid()
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>, rafael@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20230614115339.GX52412@kernel.org>
References: <20230614115339.GX52412@kernel.org>
 <2023061431-litigate-upchuck-7ed1@gregkh>
 <20230614110324.3839354-1-yajun.deng@linux.dev>
 <ab067588892217b6ee6ce759bd569b12@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 14, 2023 7:53 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A> Hi=
,=0A> =0A> On Wed, Jun 14, 2023 at 11:28:32AM +0000, Yajun Deng wrote:=0A=
> =0A>> June 14, 2023 7:09 PM, "Greg KH" <gregkh@linuxfoundation.org> wro=
te:=0A>> =0A>> On Wed, Jun 14, 2023 at 07:03:24PM +0800, Yajun Deng wrote=
:=0A>> =0A>> When the system boots, only one cpu is enabled before smp_in=
it().=0A>> So the spinlock is not needed in most cases, remove it.=0A>> =
=0A>> Add spinlock in get_nid_for_pfn() because it is after smp_init().=
=0A>> =0A>> So this is two different things at once in the same patch?=0A=
>> =0A>> Or are they the same problem and both need to go in to solve it?=
=0A>> =0A>> And if a spinlock is not needed at early boot, is it really c=
ausing any=0A>> problems?=0A>> =0A>> They are the same problem.=0A>> I ad=
ded pr_info in early_pfn_to_nid(), found get_nid_for_pfn() is the only=0A=
>> case need to add spinlock.=0A>> This patch tested on my x86 system.=0A=
> =0A> Are you sure it'll work on !x86?=0A>=0A=0AI'm probably sure of tha=
t, although I don't have a !x86 machine.=0A=0Aearly_pfn_to_nid() is calle=
d in smp_init() and kasan_init() on =0Adifferent architectures. If it wor=
ks well on x86, it'll work on=0A!x86.=0A=0A =0A>> Signed-off-by: Yajun De=
ng <yajun.deng@linux.dev>=0A>> ---=0A>> drivers/base/node.c | 11 ++++++++=
+--=0A>> mm/mm_init.c | 18 +++---------------=0A>> 2 files changed, 12 in=
sertions(+), 17 deletions(-)=0A>> =0A>> diff --git a/drivers/base/node.c =
b/drivers/base/node.c=0A>> index 9de524e56307..844102570ff2 100644=0A>> -=
-- a/drivers/base/node.c=0A>> +++ b/drivers/base/node.c=0A>> @@ -748,8 +7=
48,15 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid=
)=0A>> static int __ref get_nid_for_pfn(unsigned long pfn)=0A>> {=0A>> #i=
fdef CONFIG_DEFERRED_STRUCT_PAGE_INIT=0A>> - if (system_state < SYSTEM_RU=
NNING)=0A>> - return early_pfn_to_nid(pfn);=0A>> + static DEFINE_SPINLOCK=
(early_pfn_lock);=0A>> + int nid;=0A>> +=0A>> + if (system_state < SYSTEM=
_RUNNING) {=0A>> + spin_lock(&early_pfn_lock);=0A>> + nid =3D early_pfn_t=
o_nid(pfn);=0A>> + spin_unlock(&early_pfn_lock);=0A>> =0A>> Adding an ext=
ernal lock for when you call a function is VERY dangerous=0A>> as you did=
 not document this anywhere, and there's no way to enforce it=0A>> proper=
ly at all.=0A>> =0A>> I should add a comment before early_pfn_to_nid().=
=0A>> =0A>> Does your change actually result in any boot time changes? Ho=
w was this=0A>> tested?=0A>> =0A>> Just a bit.=0A> =0A> Just a bit tested=
? Or just a bit of boot time changes?=0A> For the latter, do you have num=
bers?=0A> =0A=0AFor the latter, the most beneficial function is memmap_in=
it_reserved_pages(),=0Athe boot time changes depending on whether DEFERRE=
D_STRUCT_PAGE_INIT=0Ais defined or not. =0A=0A-->memmap_init_reserved_pag=
es()=0A   -->for_each_reserved_mem_range()=0A      reserve_bootmem_region=
()=0A      -->for()=0A         init_reserved_page()=0A         --> early_=
pfn_to_nid()=0A=0A=0AIf define CONFIG_DEFERRED_STRUCT_PAGE_INIT:=0A=0Abef=
ore:=0Amemmap_init_reserved_pages()   1.87 seconds=0Aafter:=0Amemmap_init=
_reserved_pages()   1.27 seconds=0A=0A32% time reduction.=0A=0A=0AIf not =
define CONFIG_DEFERRED_STRUCT_PAGE_INIT:=0A=0Aearly_pfn_to_nid() is calle=
d by few, =0Aboot time didn't change.=0A=0A=0ABy the way, this machine ha=
s 190GB RAM.=0A=0A> --=0A> Sincerely yours,=0A> Mike.
