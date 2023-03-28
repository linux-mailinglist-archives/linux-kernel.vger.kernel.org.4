Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554146CC019
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjC1NEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjC1NEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:04:37 -0400
X-Greylist: delayed 556 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Mar 2023 06:03:52 PDT
Received: from out-23.mta0.migadu.com (out-23.mta0.migadu.com [91.218.175.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C921BF9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:03:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680008630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V66ylQ1ow/PtGbySiIbSuU+rKhrjYB2OH7bPvmS2Z5E=;
        b=RAvirNNuQ9YV/tMSABybGE9T5wJP7bxOy8eucUIZyDsT23tztNKQn+3ARREhqry5rQ4vcy
        cApKQXt6Jk+1JMIQPXXCFSrqKKq2KtR0Kz1aAWeuIxSG/imLNTg9IrOLdLFcsNE1zVxgd9
        oomNSscNdoujDV45gLBoC7aXPaSLe/E=
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] mm: kfence: check kfence pool size at building time
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CANpmjNMVOwgc6dBnrUbGimi1oAJacwYBzRfpaZ8nqQz-ApDMXg@mail.gmail.com>
Date:   Tue, 28 Mar 2023 21:03:15 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, jannh@google.com,
        sjpark@amazon.de, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FD867635-75BE-4C87-857F-057BEB5530D1@linux.dev>
References: <20230328095807.7014-1-songmuchun@bytedance.com>
 <20230328095807.7014-3-songmuchun@bytedance.com>
 <CANpmjNMVOwgc6dBnrUbGimi1oAJacwYBzRfpaZ8nqQz-ApDMXg@mail.gmail.com>
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



> On Mar 28, 2023, at 18:14, Marco Elver <elver@google.com> wrote:
>=20
> On Tue, 28 Mar 2023 at 11:58, 'Muchun Song' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>>=20
>> Check kfence pool size at building time to expose problem ASAP.
>>=20
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/kfence/core.c | 7 +++----
>> 1 file changed, 3 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
>> index de62a84d4830..6781af1dfa66 100644
>> --- a/mm/kfence/core.c
>> +++ b/mm/kfence/core.c
>> @@ -841,10 +841,9 @@ static int kfence_init_late(void)
>>                return -ENOMEM;
>>        __kfence_pool =3D page_to_virt(pages);
>> #else
>> -       if (nr_pages > MAX_ORDER_NR_PAGES) {
>> -               pr_warn("KFENCE_NUM_OBJECTS too large for buddy =
allocator\n");
>> -               return -EINVAL;
>> -       }
>> +       BUILD_BUG_ON_MSG(get_order(KFENCE_POOL_SIZE) > MAX_ORDER,
>> +                        "CONFIG_KFENCE_NUM_OBJECTS is too large for =
buddy allocator");
>> +
>=20
> It's perfectly valid to want to use KFENCE with a very large pool that
> is initialized on boot, and simply sacrifice the ability to initialize
> late.

You are right. I didn=E2=80=99t realize this.

Thanks=20

>=20
> Nack.


