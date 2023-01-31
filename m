Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264B0682732
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjAaIps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjAaIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:45:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25594AA53
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:41:13 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id t16so17203668ybk.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yvlc2S1AAw794p9I4WDQhqKM70Pw3dKGUU8UcdesOEI=;
        b=ETAdz3U3iNorPk84Yo4YoksElTYXnqVqZKrk2FroxySyZLZvoNSNOznI63RFjEG/xl
         Fz5M3bWAsdxuMGGqV4/qvkgxV0I4CGBcgHocdhltUuCGYUxnk+yVcVNGPFRzBzUrnhLL
         KC4Nk1wb11wQ7rbXMxNCXyXQrxU7I8Xa6/gfSw/dI8VX7FKuh20ZT/jZ4REoRD9PZm7N
         7V71u2T60cJ7snnDfNm1pyusI+CObJJ84/29UT/HGdME247p+EvumJfu+xZBWmcHtlHQ
         l2bKyx96NJl+jga8SynzI6QDqPu3uciRI7koEvCdwLRG2P06/zzZ+JAh7AQtNtSDhMvL
         2khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvlc2S1AAw794p9I4WDQhqKM70Pw3dKGUU8UcdesOEI=;
        b=F5CkzPdmK8pgkkTwf1P4I3p5KzMdSOFax9ywMZMcKHshxrKhmsDBykJpdQHVTDvANP
         6cYXSC5/RqNRgETxJgIsa82rvdpmKI+Q3lNMLxKTeQlbB90e3GSfkK9pfScGJoXf/GpU
         Rrfbwk2AsgYp0daMUo5TBMzQfUuwXbr8cxYEQrI1O8nzs+Vq7nI9310vEMTWLcAfh7lS
         hzinYvR/GnkEAveXfb2VPdF4kvGz7GSqKM18Wt+yQu/JljVxIH8eef7+OxA3qzQNkL4c
         0UAw5uJ82UAqhwe2Ltb0PaIt2aoypQ/kTHCqd5Uol2gJXU9DayrtMrzKFuNCG4M3KiSk
         NkCw==
X-Gm-Message-State: AO0yUKVbRg68WMYG0KAvlRla+e7Shen706uAxDlXP7b4RkhClZ67nI24
        tM8XNp1+XR/hNZjnFtyNjdug/nVBcKGmHp9EQ6BKjw==
X-Google-Smtp-Source: AK7set8rzeOh/YFX5uCS8Lf39fShXP8hu1yIak538VPbc6REwLQF2e2K5bOTsWogNSa9ylGuYFd0+IwMG7MGZBKOz1Q=
X-Received: by 2002:a25:d1d1:0:b0:80b:4d84:b25 with SMTP id
 i200-20020a25d1d1000000b0080b4d840b25mr2338010ybg.584.1675154472393; Tue, 31
 Jan 2023 00:41:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <19512bb03eed27ced5abeb5bd03f9a8381742cb1.1675111415.git.andreyknvl@google.com>
In-Reply-To: <19512bb03eed27ced5abeb5bd03f9a8381742cb1.1675111415.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 31 Jan 2023 09:40:36 +0100
Message-ID: <CANpmjNNzNSDrxfrZUcRtt7=hV=Mz8_kyCpqVnyAqzhaiyipXCg@mail.gmail.com>
Subject: Re: [PATCH 16/18] lib/stackdepot: annotate racy slab_index accesses
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 at 21:51, <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Accesses to slab_index are protected by slab_lock everywhere except
> in a sanity check in stack_depot_fetch. The read access there can race
> with the write access in depot_alloc_stack.
>
> Use WRITE/READ_ONCE() to annotate the racy accesses.
>
> As the sanity check is only used to print a warning in case of a
> violation of the stack depot interface usage, it does not make a lot
> of sense to use proper synchronization.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/stackdepot.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index f291ad6a4e72..cc2fe8563af4 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -269,8 +269,11 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>                         return NULL;
>                 }
>
> -               /* Move on to the next slab. */
> -               slab_index++;
> +               /*
> +                * Move on to the next slab.
> +                * WRITE_ONCE annotates a race with stack_depot_fetch.

"Pairs with potential concurrent read in stack_depot_fetch()." would be clearer.

I wouldn't say WRITE_ONCE annotates a race (race = involves 2+
accesses, but here's just 1), it just marks this access here which
itself is paired with the potential racing read in the other function.

> +                */
> +               WRITE_ONCE(slab_index, slab_index + 1);
>                 slab_offset = 0;
>                 /*
>                  * smp_store_release() here pairs with smp_load_acquire() in
> @@ -492,6 +495,8 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>                                unsigned long **entries)
>  {
>         union handle_parts parts = { .handle = handle };
> +       /* READ_ONCE annotates a race with depot_alloc_stack. */
> +       int slab_index_cached = READ_ONCE(slab_index);
>         void *slab;
>         size_t offset = parts.offset << DEPOT_STACK_ALIGN;
>         struct stack_record *stack;
> @@ -500,9 +505,9 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
>         if (!handle)
>                 return 0;
>
> -       if (parts.slab_index > slab_index) {
> +       if (parts.slab_index > slab_index_cached) {
>                 WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
> -                       parts.slab_index, slab_index, handle);
> +                       parts.slab_index, slab_index_cached, handle);
>                 return 0;
>         }
>         slab = stack_slabs[parts.slab_index];
> --
> 2.25.1
>
