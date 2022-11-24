Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA896370E3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiKXDRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKXDRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:17:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585BAE56
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:17:31 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z3so468229iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fsj15DlIxi1p8BdOL0QgOxfY+9nESmZnVG6dxzy5A24=;
        b=eVMMQNnXhH1vKXeIWkE6RTFpv52GCC4QtJXcuw8sr9z4MUlPw+XZkBYj5HxCQV2JKf
         FPt4SB4mzsBdLJv3/L5Irl/m9w8xId3oqKbnQ2fLYTSXjkGT1ULCmKfYvFj+NwQ10RKI
         qDUPLKzD/446jpylZISgHV2dipvq8GHjsgnP7fhIcinaMre615j9Ful/xRpw3q8bxYQb
         kxFD6mZQWYIVHQxvMF/Gfbsrdccps3M6fd9IsHHNxvLz+ji0CXLYQbRRe3Lz6UT8RaKP
         ZZ7FSRgNc6EI06d3lyLTSg8FX1IAl0/HYxRX1s7v9y90/IvgIsxVYnRyh2g9NaFbYzze
         PPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fsj15DlIxi1p8BdOL0QgOxfY+9nESmZnVG6dxzy5A24=;
        b=xunv2xhApx7N53tj3fk9h1zZUtwM8hS/ozWhlCvDQk0Bu3lPm0Uymc1ufu5g34+VK/
         wSxdSnFZe3fi6H3RyvtqugQ5Egto3HcpSlVC5mUCmji+o9/FchaJh8x02YDWxRsBwPum
         KaF0quusMBVEvwno64cATZCTaF/s8vw96H9RPdKNdPW8ictlxtvlERG9srqez/H3cVH6
         aeTV/gTGAtbzL2WoGPO2gmJkpoNMiojXRwXJ73dxObjOtjaWUsj6NvB2N9PsSS8srBhj
         0cIC+WMoxRXtJl4zXwQTRlkS+DHkZUuZZmUQYkf6tYSlvWPhHwfees2Ehl7T+yArvOGn
         8PCA==
X-Gm-Message-State: ANoB5pnFjpEV4cNp0qAFbbgmyohyQL0RuEh9qYY4+9p8Y9tuG3rWCp9S
        KSA8W5nBjJAY62BvH1LbrBzBS4GYF1EnASbI6MhxtA==
X-Google-Smtp-Source: AA0mqf7K42pA8O0tKKrne5Z7+/bPfH3u54TiV5CXl6bL2+TSMkxjiy3i1LClciRHhxZ0Voo5vxj+u9Rat3Fz/bnoGzU=
X-Received: by 2002:a02:9422:0:b0:373:2c18:a37e with SMTP id
 a31-20020a029422000000b003732c18a37emr14119216jai.51.1669259850632; Wed, 23
 Nov 2022 19:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-3-yosryahmed@google.com> <Y37C68kUYakRQ2ZC@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y37C68kUYakRQ2ZC@P9FQF9L96D.corp.robot.car>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Nov 2022 19:16:54 -0800
Message-ID: <CAJD7tkZUcbkzG=g1wgkoWgBgZM2eHQLNY0dmHnWghzHRmeDjkQ@mail.gmail.com>
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

On Wed, Nov 23, 2022 at 5:03 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Wed, Nov 23, 2022 at 09:21:31AM +0000, Yosry Ahmed wrote:
> > Refactor the code that drives writing to memory.reclaim (retrying, error
> > handling, etc) from test_memcg_reclaim() to a helper called
> > reclaim_until(), which proactively reclaims from a memcg until its
> > usage reaches a certain value.
> >
> > This will be used in a following patch in another test.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  .../selftests/cgroup/test_memcontrol.c        | 85 +++++++++++--------
> >  1 file changed, 49 insertions(+), 36 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > index 8833359556f3..d4182e94945e 100644
> > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > @@ -645,6 +645,53 @@ static int test_memcg_max(const char *root)
> >       return ret;
>
>
> The code below looks correct, but can be simplified a bit.
> And btw thank you for adding a test!
>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> (idk if you want invest your time in further simplication of this code,
> it was this way before this patch, so up to you).

I don't "want" to, but the voices in my head won't shut up until I do so..

Here's a patch that simplifies the code, I inlined it here to avoid
sending a new version. If it looks good to you, it can be squashed
into this patch or merged separately (whatever you and Andrew prefer).
I can also send it in a separate thread if preferred.

From 18c40d61dac05b33cfc9233b17979b54422ed7c5 Mon Sep 17 00:00:00 2001
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 24 Nov 2022 02:21:12 +0000
Subject: [PATCH] selftests: cgroup: simplify memcg reclaim code

Simplify the code for the reclaim_until() helper used for memcg reclaim
through memory.reclaim.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 65 ++++++++++---------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c
b/tools/testing/selftests/cgroup/test_memcontrol.c
index bac3b91f1579..2e2bde44a6f7 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -17,6 +17,7 @@
 #include <netdb.h>
 #include <errno.h>
 #include <sys/mman.h>
+#include <limits.h>

 #include "../kselftest.h"
 #include "cgroup_util.h"
@@ -656,51 +657,51 @@ static int test_memcg_max(const char *root)
        return ret;
 }

-/* Reclaim from @memcg until usage reaches @goal_usage */
+/*
+ * Reclaim from @memcg until usage reaches @goal_usage by writing to
+ * memory.reclaim.
+ *
+ * This function will return false if the usage is already below the
+ * goal.
+ *
+ * This function assumes that writing to memory.reclaim is the only
+ * source of change in memory.current (no concurrent allocations or
+ * reclaim).
+ *
+ * This function makes sure memory.reclaim is sane. It will return
+ * false if memory.reclaim's error codes do not make sense, even if
+ * the usage goal was satisfied.
+ */
 static bool reclaim_until(const char *memcg, long goal_usage)
 {
        char buf[64];
        int retries = 5;
-       int err;
+       int err = INT_MAX;
        long current, to_reclaim;

-       /* Nothing to do here */
-       if (cg_read_long(memcg, "memory.current") <= goal_usage)
-               return true;
-
        while (true) {
                current = cg_read_long(memcg, "memory.current");
-               to_reclaim = current - goal_usage;

-               /*
-                * We only keep looping if we get -EAGAIN, which means we could
-                * not reclaim the full amount. This means we got -EAGAIN when
-                * we actually reclaimed the requested amount, so fail.
-                */
-               if (to_reclaim <= 0)
-                       break;
+               /* First iteration*/
+               if (err == INT_MAX) {
+                       if (current <= goal_usage)
+                               return false;
+               /* Write successful, check reclaimed amount */
+               } else if (!err) {
+                       return current <= goal_usage ||
+                               values_close(current, goal_usage, 3);
+               /* Unexpected error, or ran out of retries */
+               } else if (err != -EAGAIN || !retries--) {
+                       return false;
+               /* EAGAIN -> retry, but check for false negatives */
+               } else if (current <= goal_usage) {
+                       return false;
+               }

+               to_reclaim = current - goal_usage;
                snprintf(buf, sizeof(buf), "%ld", to_reclaim);
                err = cg_write(memcg, "memory.reclaim", buf);
-               if (!err) {
-                       /*
-                        * If writing succeeds, then the written
amount should have been
-                        * fully reclaimed (and maybe more).
-                        */
-                       current = cg_read_long(memcg, "memory.current");
-                       if (!values_close(current, goal_usage, 3) &&
current > goal_usage)
-                               break;
-                       return true;
-               }
-
-               /* The kernel could not reclaim the full amount, try again. */
-               if (err == -EAGAIN && retries--)
-                       continue;
-
-               /* We got an unexpected error or ran out of retries. */
-               break;
        }
-       return false;
 }

 /*
--
2.38.1.584.g0f3c55d4c2-goog

>
> >  }
> >
> > +/* Reclaim from @memcg until usage reaches @goal_usage */
> > +static bool reclaim_until(const char *memcg, long goal_usage)
> > +{
> > +     char buf[64];
> > +     int retries = 5;
> > +     int err;
> > +     long current, to_reclaim;
> > +
> > +     /* Nothing to do here */
> > +     if (cg_read_long(memcg, "memory.current") <= goal_usage)
> > +             return true;
> > +
> > +     while (true) {
> > +             current = cg_read_long(memcg, "memory.current");
> > +             to_reclaim = current - goal_usage;
> > +
> > +             /*
> > +              * We only keep looping if we get -EAGAIN, which means we could
> > +              * not reclaim the full amount. This means we got -EAGAIN when
> > +              * we actually reclaimed the requested amount, so fail.
> > +              */
> > +             if (to_reclaim <= 0)
> > +                     break;
> > +
> > +             snprintf(buf, sizeof(buf), "%ld", to_reclaim);
> > +             err = cg_write(memcg, "memory.reclaim", buf);
> > +             if (!err) {
> > +                     /*
> > +                      * If writing succeeds, then the written amount should have been
> > +                      * fully reclaimed (and maybe more).
> > +                      */
> > +                     current = cg_read_long(memcg, "memory.current");
> > +                     if (!values_close(current, goal_usage, 3) && current > goal_usage)
> > +                             break;
>
> There are 3 places in this function where memory.current is read and compared
> to goal_usage. I believe only one can be left.
>
> > +                     return true;
> > +             }
> > +
> > +             /* The kernel could not reclaim the full amount, try again. */
> > +             if (err == -EAGAIN && retries--)
> > +                     continue;
> > +
> > +             /* We got an unexpected error or ran out of retries. */
> > +             break;
>
> if (err != -EAGAIN || retries--)
>         break;
>
> Thanks!
