Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D775BD993
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 03:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiITBoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 21:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiITBnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 21:43:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197B854642
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:43:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so1907866wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=F4ITKG33T7YLqBOkr0dCfFEupJUqxrsjsayFSB1eVuQ=;
        b=imS0eXryPZF2ZP3SxRXkJ8FBfg0HL6gl7WA1Uqu2VK44HNGUF01d5wtO3NhTlzIqPT
         cvUUUYCFEVwILg3T/t3snVXBsiIDU5oRDdLnl4K+9FFEALuJQkqKIIBHt2xE6UTSwuWN
         Mo0TR4WB8JdaGHMvqyFHjFYcm/YX76+aHWWTO7uJLI/z7i27dY1AZEbNS2cKHhGIR8CY
         6XNHYxSjgpY7mICcnfg6a78zKElXP3E9c7NJfDiEq3mMEHqSNpWIGbIjZl9ecOsq+uRv
         Uwz5sFi0Q/c4f2oO3NXXwk2CGnY3XF9q1i9hZsPsK5CfFRWkaIUaBODk0F23SCeHOGyW
         0MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=F4ITKG33T7YLqBOkr0dCfFEupJUqxrsjsayFSB1eVuQ=;
        b=ztC8fRwTksAXrpj8Q2KMSXK4n4Pofr0KpTNLm6TdOQGUBr/0JQ/ni36ghc3lQ/+h48
         jxjzDknfFJ4rtjWxrDCD4asHGOFE7B6yJZb39kXST3Fedvg27TBvAm4cKqQzdrOa2Cg1
         NXDS30VJNUGoAKUkyRopissHnSngx6K4zPDVPKA57qF2nC5BEP/CV3Y4NI7Nh/18MOsW
         HRYDFYX6DRdVMMePkTZrjIUVrlyq4W0mhoeSHJLOow1gCNuwSj59rGaYJeyWj3QP8fds
         fqw35rcJt/oqwY/epsfw8fTcA/igfyOlCfaJ2JJ1z+JtiaqffzWp+bVMQD5D1P7N4mld
         UziQ==
X-Gm-Message-State: ACrzQf3b5IoFgT5bmD7ZC9qXvgRgYoV6AT0FneNCw3aMld6dF7i4R4Ng
        7cD7prs8TfnYAxDv0iQCIjYUuiJjrZFfXEk5cMcXx291Sg==
X-Google-Smtp-Source: AMsMyM6hsiRiSIOyhDtCQ4b+Rn3dgXsxbBT4UQhkOw4S7Ew9mY0lcIo5kmDMmHITSLMvddZ5pCBz7CGPKorMISpu+NA=
X-Received: by 2002:adf:8b07:0:b0:228:da7c:80ee with SMTP id
 n7-20020adf8b07000000b00228da7c80eemr12096764wra.25.1663638209988; Mon, 19
 Sep 2022 18:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <1663568889-17634-1-git-send-email-kaixuxia@tencent.com> <20220919165604.61177-1-sj@kernel.org>
In-Reply-To: <20220919165604.61177-1-sj@kernel.org>
From:   Kaixu Xia <xiakaixu1987@gmail.com>
Date:   Tue, 20 Sep 2022 09:43:18 +0800
Message-ID: <CAGjdHukQHkPy_wt8igpLCxTJWeEUY9HzbKtfiEDueJrOvxaVxw@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: deduplicate damon_{reclaim,lru_sort}_apply_parameters()
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Kaixu Xia <kaixuxia@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:56 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Kaixu,
>
> On Mon, 19 Sep 2022 14:28:09 +0800 xiakaixu1987@gmail.com wrote:
>
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > The bodies of damon_{reclaim,lru_sort}_apply_parameters() contain
> > duplicates.
>
> Good finding!
>
> > This commit add a common function
> > damon_set_regions_from_system_ram() to removes the duplicates.
> >
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> > ---
> >  include/linux/damon.h |  3 ++-
> >  mm/damon/core.c       | 20 +++++++++++++++++++-
> >  mm/damon/lru_sort.c   | 13 +++----------
> >  mm/damon/reclaim.c    | 13 +++----------
> >  4 files changed, 27 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index e7808a84675f..2fd05568ef45 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -557,7 +557,8 @@ static inline bool damon_target_has_pid(const struct damon_ctx *ctx)
> >  int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
> >  int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> >
> > -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end);
> > +int damon_set_regions_from_system_ram(struct damon_target *t,
> > +                             unsigned long *start, unsigned long *end);
> >
> >  #endif       /* CONFIG_DAMON */
> >
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 9c80c6eb00c2..d967b2805a53 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -1245,7 +1245,8 @@ static int walk_system_ram(struct resource *res, void *arg)
> >   * Find biggest 'System RAM' resource and store its start and end address in
> >   * @start and @end, respectively.  If no System RAM is found, returns false.
> >   */
> > -bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
> > +static bool damon_find_biggest_system_ram(unsigned long *start,
> > +                                             unsigned long *end)
> >
> >  {
> >       struct damon_system_ram_region arg = {};
> > @@ -1259,6 +1260,23 @@ bool damon_find_biggest_system_ram(unsigned long *start, unsigned long *end)
> >       return true;
> >  }
> >
> > +int damon_set_regions_from_system_ram(struct damon_target *t,
> > +                     unsigned long *start, unsigned long *end)
> > +{
> > +     struct damon_addr_range addr_range;
> > +
> > +     if (*start > *end)
> > +             return -EINVAL;
> > +
> > +     if (!*start && !*end &&
> > +             !damon_find_biggest_system_ram(start, end))
> > +             return -EINVAL;
>
> This function sets the region as biggest system ram only if both *start and
> *end are zero.  The name should be changed, and it would better to have a
> kernel doc comment as the behavior is not very simple.  How about below?
>
> /**
>  * damon_set_region_biggest_system_ram_default() - Set the region of the given
>  * monitoring target as requested, or biggest 'System RAM'.
>  * @t:          The monitoring target to set the region.
>  * @start:      The pointer to the start address of the region.
>  * @end:        The pointer to the end address of the region.
>  *
>  * This function sets the region of @t as requested by @start and @end.  If the
>  * values of the two pointers are pointing to are zero, however, this function
>  * finds the biggest 'System RAM' resource and set the region to cover the
>  * resource.  In the latter case, this function saves the start and end address
>  * of the resource in @start and @end, respectively.
>  *
>  * Return: 0 on success, negative error code otherwise.
>  */
>
Thanks for your detailed comments! I'll follow that in the next version.


Thanks,
Kaixu
> > +
> > +     addr_range.start = *start;
> > +     addr_range.end = *end;
> > +     return damon_set_regions(t, &addr_range, 1);
> > +}
> > +
> >  static int __init damon_init(void)
> >  {
> >       damon_region_cache = KMEM_CACHE(damon_region, 0);
> > diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
> > index d7eb72b41cb6..0276cbec632a 100644
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -188,7 +188,6 @@ static struct damos *damon_lru_sort_new_cold_scheme(unsigned int cold_thres)
> >  static int damon_lru_sort_apply_parameters(void)
> >  {
> >       struct damos *scheme;
> > -     struct damon_addr_range addr_range;
> >       unsigned int hot_thres, cold_thres;
> >       int err = 0;
> >
> > @@ -211,15 +210,9 @@ static int damon_lru_sort_apply_parameters(void)
> >               return -ENOMEM;
> >       damon_add_scheme(ctx, scheme);
> >
> > -     if (monitor_region_start > monitor_region_end)
> > -             return -EINVAL;
> > -     if (!monitor_region_start && !monitor_region_end &&
> > -         !damon_find_biggest_system_ram(&monitor_region_start,
> > -                                        &monitor_region_end))
> > -             return -EINVAL;
> > -     addr_range.start = monitor_region_start;
> > -     addr_range.end = monitor_region_end;
> > -     return damon_set_regions(target, &addr_range, 1);
> > +     return damon_set_regions_from_system_ram(target,
> > +                             &monitor_region_start,
> > +                             &monitor_region_end);
> >  }
> >
> >  static int damon_lru_sort_turn(bool on)
> > diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
> > index 3d59ab11b7b3..6297e1799190 100644
> > --- a/mm/damon/reclaim.c
> > +++ b/mm/damon/reclaim.c
> > @@ -144,7 +144,6 @@ static struct damos *damon_reclaim_new_scheme(void)
> >  static int damon_reclaim_apply_parameters(void)
> >  {
> >       struct damos *scheme;
> > -     struct damon_addr_range addr_range;
> >       int err = 0;
> >
> >       err = damon_set_attrs(ctx, &damon_reclaim_mon_attrs);
> > @@ -157,15 +156,9 @@ static int damon_reclaim_apply_parameters(void)
> >               return -ENOMEM;
> >       damon_set_schemes(ctx, &scheme, 1);
> >
> > -     if (monitor_region_start > monitor_region_end)
> > -             return -EINVAL;
> > -     if (!monitor_region_start && !monitor_region_end &&
> > -         !damon_find_biggest_system_ram(&monitor_region_start,
> > -                                        &monitor_region_end))
> > -             return -EINVAL;
> > -     addr_range.start = monitor_region_start;
> > -     addr_range.end = monitor_region_end;
> > -     return damon_set_regions(target, &addr_range, 1);
> > +     return damon_set_regions_from_system_ram(target,
> > +                             &monitor_region_start,
> > +                             &monitor_region_end);
> >  }
> >
> >  static int damon_reclaim_turn(bool on)
> > --
> > 2.27.0
> >
>
> Thanks,
> SJ
