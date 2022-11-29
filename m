Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C063C8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 20:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiK2Trm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 14:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiK2Tqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 14:46:48 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9290577226
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:43:07 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id d123so10840889iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K858VX6Ny/24ecFdmLLnlAm5s8AXdbiBDOzfUbh3QOs=;
        b=kTw39rez3mu1L8GpQpSOqxmMlw48wsD7tb7s+3MAWhWRJIwGv1UgCNhjzmm3KcI+qY
         xAuq9bu/ev8Mt4r3DS9t968gDvlhxvhf3t8Hpn+uTkXyRiymlte2z1UkUqKpm2dGGFUa
         zFra/ShDK2ASAwS4pZiAKtfOlcq5UaoGnrC17EYV4BAeNnUl8Gb+V6iWseZR7a99m00q
         K1gTjy9kQbCXkKanXx00sKEjUm7iN+akWOlllHlUlP0aZdFM1kXYyrgVUjAUYxHTnHtP
         kH7uumLFM3xGNvI5kBOf6DHMtexFUROA+KKorGDcvSjJ80+Nss4MPzHLn1WeUzwXWJzc
         MyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K858VX6Ny/24ecFdmLLnlAm5s8AXdbiBDOzfUbh3QOs=;
        b=V7fnrBkpIb93FQticq4iOm5fpMnS5CN952GthKGeSWUUsfw2iaSDDnTq+lrAGx5xSQ
         c+jXSabhvstP6dG7VBTlmj052RPBWYtSiEpIrQY/IwyJMtkm+kfuZt5tHzY3sVAr1rQ/
         CZrh/9eWakERRKQrLL73K3pMJ2bBCmc2X/3/77YEyRlbNEG4Q/I4xirLLBtnlvuTZV4H
         OgeRHiyb+/ngnNZVZL6YJGOjoLz/DVWcceERo3IpMYVCkWTDSe3O/ZpxERLy6dl2izi9
         FneYiM8ytdIjKinutuovQ+pFydl8Cjv9ydpcnSKkxLNugv/27kaM6qigGkwkBauL1UbB
         VGyg==
X-Gm-Message-State: ANoB5pnkUrh5BCIpk56CcvXntnc1M/op4Qcw+nCJCr7vZFkHX/cc9slN
        N6P9MlzMOJHcrhCjrUQQGQk6uwRZDk/ZZeS6/OMNMyzZ4mc99w==
X-Google-Smtp-Source: AA0mqf6VwVcljkAU9sCjrpr1VDvLZdm5+uq5z17tkoR5gBJ+d94VjXxfXGddRknuBaXsuFL8/Es8mj7aIohJ6dMXzzQ=
X-Received: by 2002:a5d:9684:0:b0:6de:18b2:1025 with SMTP id
 m4-20020a5d9684000000b006de18b21025mr27023260ion.102.1669750986768; Tue, 29
 Nov 2022 11:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-3-yosryahmed@google.com> <Y37C68kUYakRQ2ZC@P9FQF9L96D.corp.robot.car>
 <CAJD7tkZUcbkzG=g1wgkoWgBgZM2eHQLNY0dmHnWghzHRmeDjkQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZUcbkzG=g1wgkoWgBgZM2eHQLNY0dmHnWghzHRmeDjkQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 29 Nov 2022 11:42:31 -0800
Message-ID: <CAJD7tkYC9Ba0p2GDnXTMOqqLWyCpKoX0qUgviGcmWa4abNVV-Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] selftests: cgroup: refactor proactive reclaim code
 to reclaim_until()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Wed, Nov 23, 2022 at 7:16 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Wed, Nov 23, 2022 at 5:03 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> > On Wed, Nov 23, 2022 at 09:21:31AM +0000, Yosry Ahmed wrote:
> > > Refactor the code that drives writing to memory.reclaim (retrying, error
> > > handling, etc) from test_memcg_reclaim() to a helper called
> > > reclaim_until(), which proactively reclaims from a memcg until its
> > > usage reaches a certain value.
> > >
> > > This will be used in a following patch in another test.
> > >
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > ---
> > >  .../selftests/cgroup/test_memcontrol.c        | 85 +++++++++++--------
> > >  1 file changed, 49 insertions(+), 36 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > index 8833359556f3..d4182e94945e 100644
> > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > @@ -645,6 +645,53 @@ static int test_memcg_max(const char *root)
> > >       return ret;
> >
> >
> > The code below looks correct, but can be simplified a bit.
> > And btw thank you for adding a test!
> >
> > Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> > (idk if you want invest your time in further simplication of this code,
> > it was this way before this patch, so up to you).
>
> I don't "want" to, but the voices in my head won't shut up until I do so..
>
> Here's a patch that simplifies the code, I inlined it here to avoid
> sending a new version. If it looks good to you, it can be squashed
> into this patch or merged separately (whatever you and Andrew prefer).
> I can also send it in a separate thread if preferred.

Roman, any thoughts on this?

>
>
> From 18c40d61dac05b33cfc9233b17979b54422ed7c5 Mon Sep 17 00:00:00 2001
> From: Yosry Ahmed <yosryahmed@google.com>
> Date: Thu, 24 Nov 2022 02:21:12 +0000
> Subject: [PATCH] selftests: cgroup: simplify memcg reclaim code
>
> Simplify the code for the reclaim_until() helper used for memcg reclaim
> through memory.reclaim.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 65 ++++++++++---------
>  1 file changed, 33 insertions(+), 32 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c
> b/tools/testing/selftests/cgroup/test_memcontrol.c
> index bac3b91f1579..2e2bde44a6f7 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -17,6 +17,7 @@
>  #include <netdb.h>
>  #include <errno.h>
>  #include <sys/mman.h>
> +#include <limits.h>
>
>  #include "../kselftest.h"
>  #include "cgroup_util.h"
> @@ -656,51 +657,51 @@ static int test_memcg_max(const char *root)
>         return ret;
>  }
>
> -/* Reclaim from @memcg until usage reaches @goal_usage */
> +/*
> + * Reclaim from @memcg until usage reaches @goal_usage by writing to
> + * memory.reclaim.
> + *
> + * This function will return false if the usage is already below the
> + * goal.
> + *
> + * This function assumes that writing to memory.reclaim is the only
> + * source of change in memory.current (no concurrent allocations or
> + * reclaim).
> + *
> + * This function makes sure memory.reclaim is sane. It will return
> + * false if memory.reclaim's error codes do not make sense, even if
> + * the usage goal was satisfied.
> + */
>  static bool reclaim_until(const char *memcg, long goal_usage)
>  {
>         char buf[64];
>         int retries = 5;
> -       int err;
> +       int err = INT_MAX;
>         long current, to_reclaim;
>
> -       /* Nothing to do here */
> -       if (cg_read_long(memcg, "memory.current") <= goal_usage)
> -               return true;
> -
>         while (true) {
>                 current = cg_read_long(memcg, "memory.current");
> -               to_reclaim = current - goal_usage;
>
> -               /*
> -                * We only keep looping if we get -EAGAIN, which means we could
> -                * not reclaim the full amount. This means we got -EAGAIN when
> -                * we actually reclaimed the requested amount, so fail.
> -                */
> -               if (to_reclaim <= 0)
> -                       break;
> +               /* First iteration*/
> +               if (err == INT_MAX) {
> +                       if (current <= goal_usage)
> +                               return false;
> +               /* Write successful, check reclaimed amount */
> +               } else if (!err) {
> +                       return current <= goal_usage ||
> +                               values_close(current, goal_usage, 3);
> +               /* Unexpected error, or ran out of retries */
> +               } else if (err != -EAGAIN || !retries--) {
> +                       return false;
> +               /* EAGAIN -> retry, but check for false negatives */
> +               } else if (current <= goal_usage) {
> +                       return false;
> +               }
>
> +               to_reclaim = current - goal_usage;
>                 snprintf(buf, sizeof(buf), "%ld", to_reclaim);
>                 err = cg_write(memcg, "memory.reclaim", buf);
> -               if (!err) {
> -                       /*
> -                        * If writing succeeds, then the written
> amount should have been
> -                        * fully reclaimed (and maybe more).
> -                        */
> -                       current = cg_read_long(memcg, "memory.current");
> -                       if (!values_close(current, goal_usage, 3) &&
> current > goal_usage)
> -                               break;
> -                       return true;
> -               }
> -
> -               /* The kernel could not reclaim the full amount, try again. */
> -               if (err == -EAGAIN && retries--)
> -                       continue;
> -
> -               /* We got an unexpected error or ran out of retries. */
> -               break;
>         }
> -       return false;
>  }
>
>  /*
> --
> 2.38.1.584.g0f3c55d4c2-goog
>
> >
> > >  }
> > >
> > > +/* Reclaim from @memcg until usage reaches @goal_usage */
> > > +static bool reclaim_until(const char *memcg, long goal_usage)
> > > +{
> > > +     char buf[64];
> > > +     int retries = 5;
> > > +     int err;
> > > +     long current, to_reclaim;
> > > +
> > > +     /* Nothing to do here */
> > > +     if (cg_read_long(memcg, "memory.current") <= goal_usage)
> > > +             return true;
> > > +
> > > +     while (true) {
> > > +             current = cg_read_long(memcg, "memory.current");
> > > +             to_reclaim = current - goal_usage;
> > > +
> > > +             /*
> > > +              * We only keep looping if we get -EAGAIN, which means we could
> > > +              * not reclaim the full amount. This means we got -EAGAIN when
> > > +              * we actually reclaimed the requested amount, so fail.
> > > +              */
> > > +             if (to_reclaim <= 0)
> > > +                     break;
> > > +
> > > +             snprintf(buf, sizeof(buf), "%ld", to_reclaim);
> > > +             err = cg_write(memcg, "memory.reclaim", buf);
> > > +             if (!err) {
> > > +                     /*
> > > +                      * If writing succeeds, then the written amount should have been
> > > +                      * fully reclaimed (and maybe more).
> > > +                      */
> > > +                     current = cg_read_long(memcg, "memory.current");
> > > +                     if (!values_close(current, goal_usage, 3) && current > goal_usage)
> > > +                             break;
> >
> > There are 3 places in this function where memory.current is read and compared
> > to goal_usage. I believe only one can be left.
> >
> > > +                     return true;
> > > +             }
> > > +
> > > +             /* The kernel could not reclaim the full amount, try again. */
> > > +             if (err == -EAGAIN && retries--)
> > > +                     continue;
> > > +
> > > +             /* We got an unexpected error or ran out of retries. */
> > > +             break;
> >
> > if (err != -EAGAIN || retries--)
> >         break;
> >
> > Thanks!
