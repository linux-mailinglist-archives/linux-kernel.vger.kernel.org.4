Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB80730F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243179AbjFOGic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244085AbjFOGh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:37:59 -0400
Received: from out-51.mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB8D2945
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 23:36:50 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686811009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xqyxiv3NjzIYmlM2b62iN8glzRDo+4uOYjVrDy5I0P8=;
        b=t6zyKJvFRDiN0aAngGaVQ1jAQOVILdfKieEoYB+ja0n9eE8YfrwsOvUu7Fim0UompUZFbB
        Yhpnt8d4Q0WHDl0DwiUwqnpPjZhWkdvMlAJorKSk9MGdYM3Bvq9qaC86/OaSo5WBlI5rkH
        TI6eg8URPCr7DQabm+0ubQf3GWOTH2o=
Date:   Thu, 15 Jun 2023 06:36:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <d8a0a36fbf88497e051ce7610678ce5c@linux.dev>
Subject: Re: [PATCH] mm/mm_init.c: remove spinlock in early_pfn_to_nid()
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     "Greg KH" <gregkh@linuxfoundation.org>, rafael@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20230615062021.GI52412@kernel.org>
References: <20230615062021.GI52412@kernel.org>
 <20230614115339.GX52412@kernel.org>
 <2023061431-litigate-upchuck-7ed1@gregkh>
 <20230614110324.3839354-1-yajun.deng@linux.dev>
 <ab067588892217b6ee6ce759bd569b12@linux.dev>
 <a96c998f9d73f03c85463d7314f6ea8a@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 15, 2023 2:20 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A=0A> On=
 Thu, Jun 15, 2023 at 03:02:58AM +0000, Yajun Deng wrote:=0A> =0A>> June =
14, 2023 7:53 PM, "Mike Rapoport" <rppt@kernel.org> wrote:=0A>> =0A>> Hi,=
=0A>> =0A>> On Wed, Jun 14, 2023 at 11:28:32AM +0000, Yajun Deng wrote:=
=0A>> =0A>> June 14, 2023 7:09 PM, "Greg KH" <gregkh@linuxfoundation.org>=
 wrote:=0A>> =0A>> On Wed, Jun 14, 2023 at 07:03:24PM +0800, Yajun Deng w=
rote:=0A>> =0A>> When the system boots, only one cpu is enabled before sm=
p_init().=0A>> So the spinlock is not needed in most cases, remove it.=0A=
>> =0A>> Add spinlock in get_nid_for_pfn() because it is after smp_init()=
.=0A>> =0A>> So this is two different things at once in the same patch?=
=0A>> =0A>> Or are they the same problem and both need to go in to solve =
it?=0A>> =0A>> And if a spinlock is not needed at early boot, is it reall=
y causing any=0A>> problems?=0A>> =0A>> They are the same problem.=0A>> I=
 added pr_info in early_pfn_to_nid(), found get_nid_for_pfn() is the only=
=0A>> case need to add spinlock.=0A>> This patch tested on my x86 system.=
=0A>> =0A>> Are you sure it'll work on !x86?=0A>> =0A>> I'm probably sure=
 of that, although I don't have a !x86 machine.=0A>> =0A>> early_pfn_to_n=
id() is called in smp_init() and kasan_init() on=0A>> different architect=
ures. If it works well on x86, it'll work on=0A>> !x86.=0A> =0A> This is =
often not true. Please verify that other architectures do not call=0A> ea=
rly_pfn_to_nid() after smp_init(). The explanation why it is safe should=
=0A> be a part of the changelog.=0A> =0A>> Signed-off-by: Yajun Deng <yaj=
un.deng@linux.dev>=0A>> ---=0A>> drivers/base/node.c | 11 +++++++++--=0A>=
> mm/mm_init.c | 18 +++---------------=0A>> 2 files changed, 12 insertion=
s(+), 17 deletions(-)=0A>> =0A>> diff --git a/drivers/base/node.c b/drive=
rs/base/node.c=0A>> index 9de524e56307..844102570ff2 100644=0A>> --- a/dr=
ivers/base/node.c=0A>> +++ b/drivers/base/node.c=0A>> @@ -748,8 +748,15 @=
@ int unregister_cpu_under_node(unsigned int cpu, unsigned int nid)=0A>> =
static int __ref get_nid_for_pfn(unsigned long pfn)=0A>> {=0A>> #ifdef CO=
NFIG_DEFERRED_STRUCT_PAGE_INIT=0A>> - if (system_state < SYSTEM_RUNNING)=
=0A>> - return early_pfn_to_nid(pfn);=0A>> + static DEFINE_SPINLOCK(early=
_pfn_lock);=0A>> + int nid;=0A>> +=0A>> + if (system_state < SYSTEM_RUNNI=
NG) {=0A>> + spin_lock(&early_pfn_lock);=0A>> + nid =3D early_pfn_to_nid(=
pfn);=0A>> + spin_unlock(&early_pfn_lock);=0A>> =0A>> Adding an external =
lock for when you call a function is VERY dangerous=0A>> as you did not d=
ocument this anywhere, and there's no way to enforce it=0A>> properly at =
all.=0A>> =0A>> I should add a comment before early_pfn_to_nid().=0A>> =
=0A>> Does your change actually result in any boot time changes? How was =
this=0A>> tested?=0A>> =0A>> Just a bit.=0A>> =0A>> Just a bit tested? Or=
 just a bit of boot time changes?=0A>> For the latter, do you have number=
s?=0A>> =0A>> For the latter, the most beneficial function is memmap_init=
_reserved_pages(),=0A>> the boot time changes depending on whether DEFERR=
ED_STRUCT_PAGE_INIT=0A>> is defined or not.=0A>> =0A>> -->memmap_init_res=
erved_pages()=0A>> -->for_each_reserved_mem_range()=0A>> reserve_bootmem_=
region()=0A>> -->for()=0A>> init_reserved_page()=0A>> --> early_pfn_to_ni=
d()=0A> =0A> A better solution would be to pass nid to reserve_bootmem_ra=
nge() and drop=0A> the call to early_pfn_to_nid() in init_reserved_page()=
.=0A> =0A> Then there won't be lock contention and no need for fragile ch=
anges in the=0A> locking.=0A>=0A=0AGreat, I will try it.=0A=0A =0A>> If d=
efine CONFIG_DEFERRED_STRUCT_PAGE_INIT:=0A>> =0A>> before:=0A>> memmap_in=
it_reserved_pages() 1.87 seconds=0A>> after:=0A>> memmap_init_reserved_pa=
ges() 1.27 seconds=0A>> =0A>> 32% time reduction.=0A> =0A> These measurem=
ents should be part of the changelog.=0A> =0A>> If not define CONFIG_DEFE=
RRED_STRUCT_PAGE_INIT:=0A>> =0A>> early_pfn_to_nid() is called by few,=0A=
>> boot time didn't change.=0A>> =0A>> By the way, this machine has 190GB=
 RAM.=0A>> =0A>> --=0A>> Sincerely yours,=0A>> Mike.=0A> =0A> --=0A> Sinc=
erely yours,=0A> Mike.
