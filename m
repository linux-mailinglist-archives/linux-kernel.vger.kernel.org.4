Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1D5B8656
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiINK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiINK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:26:42 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EA47C1F0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:26:41 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663151199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lj2gDBWDxhbWfpJ3F2DuTG5OBZRpUdCDuERum2ovK+M=;
        b=hi3QMYUHfOuFXdjn7Jj90aA+Gc8WFyhf8nuRHV+74HB/tNyT3LV3i6+Gsw71o0FMvw094B
        T46x39QgtouHs46DDXcMBrAcRHg9wi2LiZQUdlakIHuX64XxSOjOKKY4Xa6GzOcMOD5ovV
        nK9SK1GTc5h9GFctTL9sFh5S1a3jFDo=
Date:   Wed, 14 Sep 2022 10:26:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <78c7cd3900e0a33da514be8799b35f9f@linux.dev>
Subject: Re: [PATCH] mm/damon: fix missing damon_del_region()
To:     "SeongJae Park" <sj@kernel.org>
Cc:     akpm@linux-foundation.org, sieberf@amazon.com, shakeelb@google.com,
        foersleo@amazon.de, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220914095206.70459-1-sj@kernel.org>
References: <20220914095206.70459-1-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

September 14, 2022 5:52 PM, "SeongJae Park" <sj@kernel.org> wrote:=0A=0A>=
 Hi Yajun,=0A> =0A> On Wed, 14 Sep 2022 17:36:36 +0800 Yajun Deng <yajun.=
deng@linux.dev> wrote:=0A> =0A>> It should be called damon_del_region() b=
efore free each region, so use=0A>> damon_destroy_region() instead of dam=
on_free_region().=0A> =0A> What 'damon_del_region()' does is deleting the=
 region from target's regions=0A> linked list so that nobody references i=
t later after its freed. However, as=0A> each region is linked to one tar=
get, and as we will free the target here, the=0A> list will also be freed=
. Therefore, we don't need to worry about future=0A> references to the re=
gion.=0A> =0A> Anything I'm missing?=0A> =0AOK, got it.=0A=0A> Thanks,=0A=
> SJ=0A> =0A>> Fixes: f23b8eee1871 (mm/damon/core: implement region-based=
 sampling)=0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A>> ---=
=0A>> mm/damon/core.c | 2 +-=0A>> 1 file changed, 1 insertion(+), 1 delet=
ion(-)=0A>> =0A>> diff --git a/mm/damon/core.c b/mm/damon/core.c=0A>> ind=
ex 0b1eb945c68a..e62e7ebf4b12 100644=0A>> --- a/mm/damon/core.c=0A>> +++ =
b/mm/damon/core.c=0A>> @@ -361,7 +361,7 @@ void damon_free_target(struct =
damon_target *t)=0A>> struct damon_region *r, *next;=0A>> =0A>> damon_for=
_each_region_safe(r, next, t)=0A>> - damon_free_region(r);=0A>> + damon_d=
estroy_region(r, t);=0A>> kfree(t);=0A>> }=0A>> =0A>> --=0A>> 2.25.1
