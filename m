Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0128E72FC64
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243970AbjFNL2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243985AbjFNL2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:28:37 -0400
Received: from out-53.mta0.migadu.com (out-53.mta0.migadu.com [91.218.175.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF71BF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:28:35 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1686742113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cTaa5bkAAsCLeUbvEbbT4RXCgahfVxUJZ2KAppeaueI=;
        b=EjE6/y/cxxH5htYlmhMO86yXvD02DrutaaufHKu8Kjw8DC+9PZQvgzrHvEJo3ybV+HnnjJ
        1tIEKaIPB0iBFLcX0p+yTkwNd2dfF//G5rTHgov8fNIlYlBcjH5BGtrwXuUNNKmaY5YFBh
        8HvEwTlZJ6AkYhRWpDPkW+29HxNlcFA=
Date:   Wed, 14 Jun 2023 11:28:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <ab067588892217b6ee6ce759bd569b12@linux.dev>
Subject: Re: [PATCH] mm/mm_init.c: remove spinlock in early_pfn_to_nid()
To:     "Greg KH" <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, rppt@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <2023061431-litigate-upchuck-7ed1@gregkh>
References: <2023061431-litigate-upchuck-7ed1@gregkh>
 <20230614110324.3839354-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

June 14, 2023 7:09 PM, "Greg KH" <gregkh@linuxfoundation.org> wrote:=0A=
=0A> On Wed, Jun 14, 2023 at 07:03:24PM +0800, Yajun Deng wrote:=0A> =0A>=
> When the system boots, only one cpu is enabled before smp_init().=0A>> =
So the spinlock is not needed in most cases, remove it.=0A>> =0A>> Add sp=
inlock in get_nid_for_pfn() because it is after smp_init().=0A> =0A> So t=
his is two different things at once in the same patch?=0A> =0A> Or are th=
ey the same problem and both need to go in to solve it?=0A> =0A> And if a=
 spinlock is not needed at early boot, is it really causing any=0A> probl=
ems?=0A> =0A=0AThey are the same problem.=0AI added pr_info in early_pfn_=
to_nid(), found get_nid_for_pfn() is the only=0Acase need to add spinlock=
.=0AThis patch tested on my x86 system.=0A=0A=0A>> Signed-off-by: Yajun D=
eng <yajun.deng@linux.dev>=0A>> ---=0A>> drivers/base/node.c | 11 +++++++=
++--=0A>> mm/mm_init.c | 18 +++---------------=0A>> 2 files changed, 12 i=
nsertions(+), 17 deletions(-)=0A>> =0A>> diff --git a/drivers/base/node.c=
 b/drivers/base/node.c=0A>> index 9de524e56307..844102570ff2 100644=0A>> =
--- a/drivers/base/node.c=0A>> +++ b/drivers/base/node.c=0A>> @@ -748,8 +=
748,15 @@ int unregister_cpu_under_node(unsigned int cpu, unsigned int ni=
d)=0A>> static int __ref get_nid_for_pfn(unsigned long pfn)=0A>> {=0A>> #=
ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT=0A>> - if (system_state < SYSTEM_R=
UNNING)=0A>> - return early_pfn_to_nid(pfn);=0A>> + static DEFINE_SPINLOC=
K(early_pfn_lock);=0A>> + int nid;=0A>> +=0A>> + if (system_state < SYSTE=
M_RUNNING) {=0A>> + spin_lock(&early_pfn_lock);=0A>> + nid =3D early_pfn_=
to_nid(pfn);=0A>> + spin_unlock(&early_pfn_lock);=0A> =0A> Adding an exte=
rnal lock for when you call a function is VERY dangerous=0A> as you did n=
ot document this anywhere, and there's no way to enforce it=0A> properly =
at all.=0A> =0A=0AI should add a comment before early_pfn_to_nid().=0A=0A=
> Does your change actually result in any boot time changes? How was this=
=0A> tested?=0A> =0A=0AJust a bit.=0A=0A> thanks,=0A> =0A> greg k-h
