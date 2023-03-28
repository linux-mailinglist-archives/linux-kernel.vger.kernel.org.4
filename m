Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6306CBC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjC1KOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjC1KOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:14:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4ED4494
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:14:39 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id p204so14289319ybc.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679998478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wxx7pqmkD/seHpGsWDBmNccJaAtu0PA/48RM8nZtDsM=;
        b=jFhXi0OY4+lGYplogq3AMQccQZ8/tpc7UyCmJ91GOCv8/aBsVRIFxcjRBhdsE3q8kZ
         UaCpbkb8wp8NaUMd2yBj8H3YyatofCGMio1i5lQreeR9AhAJVGe/4i76xIUREN8CFkLy
         oxsfzpCQcad3Y33hoczdEiBpiMwzwSySFyWtz196Ni0K2C3xIJWiIsoaTl5qXPhilFXw
         nqrmYH8zbIrBiv9qGou6rJXiVAlYF9MKUZOfc3DRF58IejU95v0dq949mTI1ew7CEV99
         hINMcM5tesgqAdYjUYLROrKRAsYdQinsBMTqRrCUkDvlFV50GscrPVATbKnkEe+IpeRA
         XMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wxx7pqmkD/seHpGsWDBmNccJaAtu0PA/48RM8nZtDsM=;
        b=5+B5hGnI2Y9I6PEXrQhmG4PiRCBh9dhtWhLgH3WaqzUQZX8eYJZW6mbBisIK08/x0X
         o5bQSAh5y2ZEJvOwquEujX6OQjtP8QVX2VYyqsomclzTPvdz7k0BQF3w7sKyfG/WwVyK
         pxso8Z8NySudSmacquD+5hOA/3m0rrCJrV+Y319nQRe52nkf0c0Yofg+qu5B/sMxe5ok
         8jGMublUOkg6YDLxuzA/oX7cikdHJJdRWmgw5v9clo7sAg05Iul2pq3AjwY6kCiKJnMk
         I3YpRESxzulbJgmxvr0NXDAN9VEgEq4E9r2R0MtRBsD+lHC7sRorl1hh628gZcRzVBdY
         ib3w==
X-Gm-Message-State: AAQBX9dqzFvDvHJDBnoR0j5/1U5d9Fii6rhLMZ6OdNYDY6HezpZkNM4t
        Ord5sozzTD+UwdY/5H3BmDjGjFZwG6S/+PtW73nfAA==
X-Google-Smtp-Source: AKy350ZMvZiHe2MYvlI8H0eOSo5035+0N51QrPGuiIB378E8P54GgnYFvxLt7XdIBv3bTc5OUmPmQvyRQPgWJQ6MSEE=
X-Received: by 2002:a25:aaae:0:b0:b50:de89:68da with SMTP id
 t43-20020a25aaae000000b00b50de8968damr14945884ybi.32.1679998478582; Tue, 28
 Mar 2023 03:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com> <20230328095807.7014-3-songmuchun@bytedance.com>
In-Reply-To: <20230328095807.7014-3-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Mar 2023 12:14:02 +0200
Message-ID: <CANpmjNMVOwgc6dBnrUbGimi1oAJacwYBzRfpaZ8nqQz-ApDMXg@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm: kfence: check kfence pool size at building time
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        jannh@google.com, sjpark@amazon.de, muchun.song@linux.dev,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 11:58, 'Muchun Song' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Check kfence pool size at building time to expose problem ASAP.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/kfence/core.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index de62a84d4830..6781af1dfa66 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -841,10 +841,9 @@ static int kfence_init_late(void)
>                 return -ENOMEM;
>         __kfence_pool = page_to_virt(pages);
>  #else
> -       if (nr_pages > MAX_ORDER_NR_PAGES) {
> -               pr_warn("KFENCE_NUM_OBJECTS too large for buddy allocator\n");
> -               return -EINVAL;
> -       }
> +       BUILD_BUG_ON_MSG(get_order(KFENCE_POOL_SIZE) > MAX_ORDER,
> +                        "CONFIG_KFENCE_NUM_OBJECTS is too large for buddy allocator");
> +

It's perfectly valid to want to use KFENCE with a very large pool that
is initialized on boot, and simply sacrifice the ability to initialize
late.

Nack.
