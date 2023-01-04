Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D04C65CBB7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjADCBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjADCBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:01:06 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405871091
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:01:01 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso23312979pjc.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 18:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hHeFWn8psj8u8cGp1SABE4QnAQdoZWb4E9tsvr9oCvk=;
        b=dIntYs8Vf4z/54w86VjYfR8QSrf959Il8mXbiEes8eVzuXfpOrY99hD9Ws5Diw5VwO
         V0SzFWJI9wBDkn2eynnJ2czga+dwdBwdgkhdNlE73DqxIBjzn/Mtl2JnRp4hxcV5eQdE
         MdbOPFV+pg2nfORgvucmgCQ3xFIS8SRdbzHhc3O687/EHdUrEyIA4z2W/mfNK/KcUhUt
         bmDhqo0DefNVGKtkJVd09K3bhjLN2dV31/SibDgzkFZohPuRBEl0WQ06frEwB+XuQPqw
         r9THHuktVvRdSaB3+gyJLh8hIHoUbpbJn4aHdar/Aov1ZwcW6vNg+XIihS3ps4F+umpZ
         1zUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHeFWn8psj8u8cGp1SABE4QnAQdoZWb4E9tsvr9oCvk=;
        b=I6U3Xb4VUeuwWl1kaU2rs9kNXqh96Q2LvBvUUnf9URoSu90T48C0zyBSQb5ArqgDqm
         sSY/mWp9gyRVvIfmSiel1jNY5xSKw74x9wzvR6eaiZ4knohTMCSg79uGdJYi8cQAHFDf
         Km5uedn/BqkT7UE7IjIGrZGuEu8fmdoeeL5jFWA4P++0ABnDBXmrhy/6ttu+hIIwVnuf
         9H5gPa04mOY2xu29qlFDTrcJE3Hpe4uuNMlRhhVJGP4EbFulMZagAhLh63jvZoqAuVCP
         VpfWGit2fd7MF9DpWDuSOR/S41mqENEXJgFF2P73J2IUOoTfdApkNBIsUNMMLflg669W
         /BYA==
X-Gm-Message-State: AFqh2krjHerveyIn2/oIMW+rv+/iYbREpfDawbchXWxCwROfae6zdnwo
        78OxMlqUfXwpr1z9XBTfKWUIYFwVElQg8iJQIow=
X-Google-Smtp-Source: AMrXdXvPnPHlt5A1dFrqgtpDhVrKF7vmu2xsFbu9mcs9JiohmPnLDZXYOyZJdIqGkvnD1Xw31jEejLRYjG3pjpTLPjw=
X-Received: by 2002:a17:903:3287:b0:189:8d8b:9db7 with SMTP id
 jh7-20020a170903328700b001898d8b9db7mr3112912plb.150.1672797660693; Tue, 03
 Jan 2023 18:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 4 Jan 2023 03:00:49 +0100
Message-ID: <CA+fCnZdk0HoWx6XCbTsiNhyR2Z_7zv5JUdgNs8Q_tV4GRkkmCg@mail.gmail.com>
Subject: Re: [PATCH] kasan: infer the requested size by scanning shadow memory
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 8:56 AM Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:
>
> We scan the shadow memory to infer the requested size instead of
> printing cache->object_size directly.
>
> This patch will fix the confusing generic kasan report like below. [1]
> Report shows "cache kmalloc-192 of size 192", but user
> actually kmalloc(184).
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in _find_next_bit+0x143/0x160 lib/find_bit.c:109
> Read of size 8 at addr ffff8880175766b8 by task kworker/1:1/26
> ...
> The buggy address belongs to the object at ffff888017576600
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 184 bytes inside of
>  192-byte region [ffff888017576600, ffff8880175766c0)
> ...
> Memory state around the buggy address:
>  ffff888017576580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff888017576600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888017576680: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>                                         ^
>  ffff888017576700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888017576780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
> After this patch, report will show "cache kmalloc-192 of size 184".

I think this introduces more confusion. kmalloc-192 cache doesn't have
the size of 184.

Let's leave the first two lines as is, and instead change the second
two lines to:

The buggy address is located 0 bytes to the right of
 requested 184-byte region [ffff888017576600, ffff8880175766c0)

This specifically points out an out-of-bounds access.

Note the added "requested". Alternatively, we could say "allocated".

> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -340,8 +340,13 @@ static inline void kasan_print_address_stack_frame(const void *addr) { }
>
>  #ifdef CONFIG_KASAN_GENERIC
>  void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object);
> +int kasan_get_alloc_size(void *object_addr, struct kmem_cache *cache);
>  #else
>  static inline void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object) { }
> +static inline int kasan_get_alloc_size(void *object_addr, struct kmem_cache *cache)
> +{
> +       return cache->object_size;

Please implement similar shadow/tag walking for the tag-based modes.
Even though we can only deduce the requested size with the granularity
of 16 bytes, it still makes sense.

It makes sense to also use the word "allocated" instead of "requested"
for these modes, as the size is not deduced precisely.

> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -236,12 +236,13 @@ static void describe_object_addr(const void *addr, struct kmem_cache *cache,
>  {
>         unsigned long access_addr = (unsigned long)addr;
>         unsigned long object_addr = (unsigned long)object;
> +       int real_size = kasan_get_alloc_size((void *)object_addr, cache);

Please add another field to the mode-specific section of the
kasan_report_info structure, fill it in complete_report_info, and use
it here. See kasan_find_first_bad_addr as a reference.

Thanks for working on this!
