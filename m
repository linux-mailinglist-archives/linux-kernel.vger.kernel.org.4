Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E976CBFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjC1Mz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjC1MzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:55:24 -0400
Received: from out-9.mta0.migadu.com (out-9.mta0.migadu.com [IPv6:2001:41d0:1004:224b::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABA6AF2C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:54:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680008037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lEBAyDbpcGWWtLv7yxB3dM0CQE6fBpZjwez5iEbApJM=;
        b=JcgQBtGAiRSMcJe4TFONHRM5XJlkO+dRGxze6FCLE956VTbeIW82Y/C5y5avDoT0EWaKw2
        cvf+Qk2uA/xf9Q+/NoMvotDIwhlh0W0YCx5vq+5t09tSWsA1zhs/jYrR+LFHh5wQBg4bF9
        NcCOi6cimUF6thMuyWDvg4WfvMX1Ar0=
MIME-Version: 1.0
Subject: Re: [PATCH 1/6] mm: kfence: simplify kfence pool initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CANpmjNNXDHZGr_r6aZi1bv5itc5KvGhRNnq_CSQRrmB6Wwx+Dg@mail.gmail.com>
Date:   Tue, 28 Mar 2023 20:53:21 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        dvyukov@google.com, Andrew Morton <akpm@linux-foundation.org>,
        jannh@google.com, sjpark@amazon.de, kasan-dev@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D04CBA99-3E17-4749-9144-34B6D9D3208E@linux.dev>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
 <20230328095807.7014-2-songmuchun@bytedance.com>
 <CANpmjNP+nLfMKLj-4L4wXBfQpO5N0Y6q_TEkxjM+Z0WXxPvVxg@mail.gmail.com>
 <CANpmjNNXDHZGr_r6aZi1bv5itc5KvGhRNnq_CSQRrmB6Wwx+Dg@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 28, 2023, at 20:05, Marco Elver <elver@google.com> wrote:
>=20
> On Tue, 28 Mar 2023 at 13:55, Marco Elver <elver@google.com> wrote:
>>=20
>> On Tue, 28 Mar 2023 at 11:58, Muchun Song <songmuchun@bytedance.com> =
wrote:
>>>=20
>>> There are three similar loops to initialize kfence pool, we could =
merge
>>> all of them into one loop to simplify the code and make code more
>>> efficient.
>>>=20
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>=20
>> Reviewed-by: Marco Elver <elver@google.com>
>>=20
>>> ---
>>> mm/kfence/core.c | 47 =
++++++-----------------------------------------
>>> 1 file changed, 6 insertions(+), 41 deletions(-)
>>>=20
>>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>>> index 7d01a2c76e80..de62a84d4830 100644
>>> --- a/mm/kfence/core.c
>>> +++ b/mm/kfence/core.c
>>> @@ -539,35 +539,10 @@ static void rcu_guarded_free(struct rcu_head =
*h)
>>> static unsigned long kfence_init_pool(void)
>>> {
>>>        unsigned long addr =3D (unsigned long)__kfence_pool;
>>> -       struct page *pages;
>>>        int i;
>>>=20
>>>        if (!arch_kfence_init_pool())
>>>                return addr;
>>> -
>>> -       pages =3D virt_to_page(__kfence_pool);
>>> -
>>> -       /*
>>> -        * Set up object pages: they must have PG_slab set, to avoid =
freeing
>>> -        * these as real pages.
>>> -        *
>>> -        * We also want to avoid inserting kfence_free() in the =
kfree()
>>> -        * fast-path in SLUB, and therefore need to ensure kfree() =
correctly
>>> -        * enters __slab_free() slow-path.
>>> -        */
>=20
> Actually: can you retain this comment somewhere?

Sure, I'll move this to right place.

Thanks.

