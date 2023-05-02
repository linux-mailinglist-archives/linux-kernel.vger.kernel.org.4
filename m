Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F726F4B47
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjEBUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjEBUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:22:09 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EDA10FF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:22:08 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so4525024a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058927; x=1685650927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/q9Cv2MQT9eLyrPuhttAiOoNP+QHKlxs2pHWJJ60P9E=;
        b=PWA1P6JirIfHR9m+KmOxnNtkoYYR/kRT6PuZd6baEG63ngeiMk9acCtR1afWJEBCgc
         WAZttNKQ9cfB7mClkSe3gzkuHU2pYtLTZGk47QHa0dW0b2Q0Ag2PIf8BVAvhD9MOnSD0
         el+3Erqa2j++W0vb6mnWDJITa0deywZjc95Mf7J9Q4BVU3d+IWE0VGF+akgvZPXpmaVS
         wRZFkeQ+SdqLZRIrfYy4YJpAywYogcMmrn2YzxcF9RLcK2HJSt0ZpsnF6WfNJLOhg7Li
         PWAvEcDqZZx2mLjrgdd0zS8/e7ilPVc5fhM/EgmeGPHYl6K5jTHE7VIg+ZcRgxS4TaZz
         FB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058927; x=1685650927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/q9Cv2MQT9eLyrPuhttAiOoNP+QHKlxs2pHWJJ60P9E=;
        b=DNGxVL4t7U9GO5nbtx+lCoTkSNvjXVGtO+eLbz5fIgMs8OH7pXLCwwg3CYlqOscydW
         ydiCLm7CdnvuCPPc1uvw8S+1T++vJpvkB0K+Bzdm0M6NGRNnbda83eD0w02+cCcttxOI
         yVZ8gdqw+ewN2JEHaddN33pkKy5Wrdz5xEcvpBeFC9k475LbNYKnsxZlBlfOWMxU4bY7
         NqtNbulv1swb2VaGpXED89rbvZRmHKu61sBqJuIfUWy6fNHVcCH9uR01sj21P7JFU3ce
         KjT9lFPqCglu0kWcohF/FWzee6Cq51MDMzcP9mHieAGEpiST3Z45uJMqA5n2JcMFn/AV
         aOLA==
X-Gm-Message-State: AC+VfDwrXedg0VFAtLASedGG6UH2xvbjcfOz30Ca/Y+2YJ5a/Lwy2HaS
        0rl2K0wPX52t2zWhczj6BONm3lup4dye960Jc+mKLQ==
X-Google-Smtp-Source: ACHHUZ6qmBMJ6SnM761gz0lfoCSbCZ8NVMbggUmrQAgm1Bi1iRN+BZTT3lvz+7XZkKaxm2uSMlTuEfWp9+YLV2XzEKE=
X-Received: by 2002:a50:fe94:0:b0:506:af22:1271 with SMTP id
 d20-20020a50fe94000000b00506af221271mr9313716edt.0.1683058926595; Tue, 02 May
 2023 13:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230502160839.361544-1-roman.gushchin@linux.dev> <20230502160839.361544-2-roman.gushchin@linux.dev>
In-Reply-To: <20230502160839.361544-2-roman.gushchin@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 2 May 2023 13:21:30 -0700
Message-ID: <CAJD7tkbPUNv+tNDwnsmyXdOStCoA91dBCX+bRDQx5pDQx4bmpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: memcg: use READ_ONCE()/WRITE_ONCE() to access stock->cached
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 9:09=E2=80=AFAM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> A memcg pointer in the percpu stock can be accessed by drain_all_stock()
> from another cpu in a lockless way.
> In theory it might lead to an issue, similar to the one which has been
> discovered with stock->cached_objcg, where the pointer was zeroed
> between the check for being NULL and dereferencing.
> In this case the issue is unlikely a real problem, but to make it
> bulletproof and similar to stock->cached_objcg, let's annotate all
> accesses to stock->cached with READ_ONCE()/WTRITE_ONCE().

Is it time to rename that to cached_memcg? :)

Anyway, same comment as patch 1 about annotating all reads with
READ_ONCE() vs. singling out the racy read.

>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c823c35c2ed4..1e364ad495a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2275,7 +2275,7 @@ static bool consume_stock(struct mem_cgroup *memcg,=
 unsigned int nr_pages)
>         local_lock_irqsave(&memcg_stock.stock_lock, flags);
>
>         stock =3D this_cpu_ptr(&memcg_stock);
> -       if (memcg =3D=3D stock->cached && stock->nr_pages >=3D nr_pages) =
{
> +       if (memcg =3D=3D READ_ONCE(stock->cached) && stock->nr_pages >=3D=
 nr_pages) {
>                 stock->nr_pages -=3D nr_pages;
>                 ret =3D true;
>         }
> @@ -2290,7 +2290,7 @@ static bool consume_stock(struct mem_cgroup *memcg,=
 unsigned int nr_pages)
>   */
>  static void drain_stock(struct memcg_stock_pcp *stock)
>  {
> -       struct mem_cgroup *old =3D stock->cached;
> +       struct mem_cgroup *old =3D READ_ONCE(stock->cached);
>
>         if (!old)
>                 return;
> @@ -2303,7 +2303,7 @@ static void drain_stock(struct memcg_stock_pcp *sto=
ck)
>         }
>
>         css_put(&old->css);
> -       stock->cached =3D NULL;
> +       WRITE_ONCE(stock->cached, NULL);

Is it me or can we call drain_stock() from memcg_hotplug_cpu_dead()
without holding the lock, unlike all other callers. Is this a problem?

>  }
>
>  static void drain_local_stock(struct work_struct *dummy)
> @@ -2338,10 +2338,10 @@ static void __refill_stock(struct mem_cgroup *mem=
cg, unsigned int nr_pages)
>         struct memcg_stock_pcp *stock;
>
>         stock =3D this_cpu_ptr(&memcg_stock);
> -       if (stock->cached !=3D memcg) { /* reset if necessary */
> +       if (READ_ONCE(stock->cached) !=3D memcg) { /* reset if necessary =
*/
>                 drain_stock(stock);
>                 css_get(&memcg->css);
> -               stock->cached =3D memcg;
> +               WRITE_ONCE(stock->cached, memcg);
>         }
>         stock->nr_pages +=3D nr_pages;
>
> @@ -2383,7 +2383,7 @@ static void drain_all_stock(struct mem_cgroup *root=
_memcg)
>                 bool flush =3D false;
>
>                 rcu_read_lock();
> -               memcg =3D stock->cached;
> +               memcg =3D READ_ONCE(stock->cached);
>                 if (memcg && stock->nr_pages &&
>                     mem_cgroup_is_descendant(memcg, root_memcg))
>                         flush =3D true;
> --
> 2.40.1
>
