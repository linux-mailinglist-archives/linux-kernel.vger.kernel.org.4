Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252CD651185
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 19:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiLSSJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 13:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiLSSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 13:09:14 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0260513CE1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:09:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so9640961pjm.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 10:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ztWy+TAPu9znv9bYACdxKCT9vj/i9mvgkta/yxexP28=;
        b=pTBv6akZvvEU1KmR3lTWhi+3A6mHZkvtA62TE2AcTstOKYU539wAchOHfy+v0SUEW+
         xkdTxAdg77XkUds2vPLSpBzAMec6QUPSulmLZ2PCWk6bsm6vG8ErJOBw3WUAhqyaivc6
         wTIvKONQgxbq8IjgeSjQPqkvQLwGIzYMLd6sHX5MoqrHiEKa9epN647F9AIB3j7gx5gy
         jxmBQIsfWDS5rsZPN/Noso9S7m/C2WZ5RNigSXo75/VzeCKprIlpeEukGnnXKkxPEhJk
         8nScmGo2qiFBbbNaD8Y6R1OuHI5TUPKzxJhdRai8BtOr0MUkRoyC6IUC0b+oMo5S4nPi
         aUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztWy+TAPu9znv9bYACdxKCT9vj/i9mvgkta/yxexP28=;
        b=ARSMroAGyGOEASe121DFLrl8IyylU4ksJq9ojKRR/M2dacaDlxNruGoh5cAYTtvJb1
         L//IheIGmYGyja57jKcBD4AMVxgNpY5fmilnIFaF942h9eIaGahfLupenLcfGFizbMaN
         cpFB1fAV2BMrj7x4aHomKPDmszct0ec+7S3fi92ciVwd+3zQxw5JDIoZqninNFlFYbzA
         HbUxssAZPdr+5TDkZnsT/M5dafBiBbLLgcWXPZQWR1n6DAEfIwepYQapLcBK3alTX24q
         EtlM5v3MNhqS6c7Dztp+cb3SHoqS15JTj3Rx4bU1tEfEByQF/ALLBSiHSVKSorTxqCdg
         Qqlw==
X-Gm-Message-State: AFqh2krcQG9S2ZkvDZtm/PYotxA0fHiximqYUJKsQBp5khliRIO4Tigm
        +1A72aVoRCcfvnXYNGADmA3mdi7VYNwWB18MyMo=
X-Google-Smtp-Source: AMrXdXvnwoXDbWnLBN4wjnak905mp6IsVC8S3WaMyH0j8Tg3tbWWQmwGY1flD9NHdsYH9sYm8l1xG+FrULQs/pdy0BY=
X-Received: by 2002:a17:90a:fb83:b0:219:932c:febe with SMTP id
 cp3-20020a17090afb8300b00219932cfebemr1875071pjb.47.1671473350453; Mon, 19
 Dec 2022 10:09:10 -0800 (PST)
MIME-Version: 1.0
References: <323d51d422d497b3783dacb130af245f67d77671.1671228324.git.andreyknvl@google.com>
 <CANpmjNPKYEohPBnQ59GVKfCYc+dRUo-YtaR0PzPiwtALNghdFA@mail.gmail.com>
In-Reply-To: <CANpmjNPKYEohPBnQ59GVKfCYc+dRUo-YtaR0PzPiwtALNghdFA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 19 Dec 2022 19:08:59 +0100
Message-ID: <CA+fCnZcDEV4hmeyLb6paTvR7Z3gjQOTJn_M9wTMN-cy+9DKUTw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: allow sampling page_alloc allocations for HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, Dec 19, 2022 at 12:31 PM Marco Elver <elver@google.com> wrote:
>
> On a whole:
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> This looks much better, given it'll automatically do the right thing
> without marking costly allocation sites.

Agreed, thank you for the suggestion!

> > +- ``kasan.page_alloc.sample.order=<minimum page order>`` specifies the minimum
> > +  order of allocations that are affected by sampling (default: ``3``).
> > +  Only applies when ``kasan.page_alloc.sample`` is set to a non-default value.
>
> "set to a value greater than 1"? The additional indirection through
> "non-default" seems unnecessary.

Will fix in v4.

> > +  This parameter is intended to allow sampling only large page_alloc
> > +  allocations, which is the biggest source of the performace overhead.
>
> s/performace/performance/

Will fix in v4.

> > --- a/mm/kasan/hw_tags.c
> > +++ b/mm/kasan/hw_tags.c
> > @@ -59,6 +59,24 @@ EXPORT_SYMBOL_GPL(kasan_mode);
> >  /* Whether to enable vmalloc tagging. */
> >  DEFINE_STATIC_KEY_TRUE(kasan_flag_vmalloc);
> >
> > +#define PAGE_ALLOC_SAMPLE_DEFAULT      1
> > +#define PAGE_ALLOC_SAMPLE_ORDER_DEFAULT        3
>
> Why not just set it to PAGE_ALLOC_COSTLY_ORDER?

I've been thinking about this, but technically PAGE_ALLOC_COSTLY_ORDER
is related to allocations that are costly to service due to
fragmentation/reclaim-related issues. We also don't rely on
PAGE_ALLOC_COSTLY_ORDER only, but also on SKB_FRAG_PAGE_ORDER. (I
guess some clean-up is possible wrt these constants: I suspect both
have the same value for the same reason. But I don't want to attempt
it with this patch. )

We could add a BUILD_BUG_ON that makes sure that all 3 constants are
the same. But then the only thing to do if one of them is changed is
to remove the BUG_ON, which doesn't seem very useful.

I'll leave the current implementation in v4.

Thank you, Marco!
