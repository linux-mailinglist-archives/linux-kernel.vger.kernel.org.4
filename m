Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89DD6CC5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjC1PUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1PUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:20:22 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DED81732
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:18:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id z83so15533377ybb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Oo7t3uH5L5XgCZ1uKSglRiPDhZouQp2W4do7dpcvfk=;
        b=sloJNSy6jcyr8V+bl2KDVZrUIx+CgEgGJSFJ4w5WaC8TdDbJCtG+r3mp7IA616+rDp
         vp5xon0cmgSmMxTl22bo4RSzS9zf/7Kn97mBl99ky4OeP2XRyg6onKPOdON3LsP3G/5l
         XANyH+1QqjNiVr6oKoANqKgz1Ajr/GLOPr3j2cYawyyWbFlBNgScTCm22rzxJwSb9p82
         VRIEQDNvWgAhrcsWYx4ovZiheIKaE6I+lr3iNOLgZUWrzZB/z7jbm0dfyF5GYULBzeUy
         sOr3fI0aibAi2tvxQGwIW5wXdwecj11oK32tp95GWC1wSYzzlaWZF+3LUtQI/ppp1xXc
         o8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Oo7t3uH5L5XgCZ1uKSglRiPDhZouQp2W4do7dpcvfk=;
        b=4JFkqbOpNHzLvAR8mGyq7DM5GSofqpOfSTS5RvKBBc+ZxPkBhxIqIf1ZZtqWfEWk3J
         z4oCRAIsr0gYZFoOA6R7GQnHqopvo4ahMsJACXROy780wb5V+GAtSAuUABJvSQP2LDKl
         A9hQrHuO+cuku/8aOm0oS+qEVy5I1gqSYH6pKPBNdsxTE2aH2jB5VkyPH8ZN2s0qvFX9
         kmFonMftiqfCzxo28w5Ahk0IBz9CAkQvLB/hViIkCmtMjYZpFElqaYixf8n9E2BDyr5F
         IbKPQfQXXcnZZErN37r+Ak6eRUNH80vyfRxXvlT+a6LtZO1SQ0MhYSHES3CTovFTIidk
         kR1Q==
X-Gm-Message-State: AAQBX9dq4QVx38lWqsomY28f4R5BXe+//2uVWZGElIKcuSTnRVe/sXSs
        cUJ/3uGOGfUefL8ZLM2BwS0XPuAhRke1HGc77EuB4g==
X-Google-Smtp-Source: AKy350bj5Nyxts8ciOXLw5EWFV9sPrHyhrga3LXQMYyQcc2/rYEnNjc1hc6y50eir7QoYRZz6dOHo8zvJLKF9E3OnwA=
X-Received: by 2002:a25:2749:0:b0:a99:de9d:d504 with SMTP id
 n70-20020a252749000000b00a99de9dd504mr10180174ybn.12.1680016702030; Tue, 28
 Mar 2023 08:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-8-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-8-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 08:18:11 -0700
Message-ID: <CALvZod5_NVTrYUhLjc3Me=CC6y3R4bhA71mCt-jXo0rX+2zUxw@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 27, 2023 at 11:16=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> In workingset_refault(), we call mem_cgroup_flush_stats_ratelimited()
> to flush stats within an RCU read section and with sleeping disallowed.
> Move the call to mem_cgroup_flush_stats_ratelimited() above the RCU read
> section and allow sleeping to avoid unnecessarily performing a lot of
> work without sleeping.
>
> Since workingset_refault() is the only caller of
> mem_cgroup_flush_stats_ratelimited(), just make it call the non-atomic
> mem_cgroup_flush_stats().
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

A nit below:

Acked-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/memcontrol.c | 12 ++++++------
>  mm/workingset.c |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 57e8cbf701f3..0c0e74188e90 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -674,12 +674,6 @@ void mem_cgroup_flush_stats_atomic(void)
>                 __mem_cgroup_flush_stats_atomic();
>  }
>
> -void mem_cgroup_flush_stats_ratelimited(void)
> -{
> -       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> -               mem_cgroup_flush_stats_atomic();
> -}
> -
>  /* non-atomic functions, only safe from sleepable contexts */
>  static void __mem_cgroup_flush_stats(void)
>  {
> @@ -695,6 +689,12 @@ void mem_cgroup_flush_stats(void)
>                 __mem_cgroup_flush_stats();
>  }
>
> +void mem_cgroup_flush_stats_ratelimited(void)
> +{
> +       if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> +               mem_cgroup_flush_stats();
> +}
> +
>  static void flush_memcg_stats_dwork(struct work_struct *w)
>  {
>         __mem_cgroup_flush_stats();
> diff --git a/mm/workingset.c b/mm/workingset.c
> index af862c6738c3..7d7ecc46521c 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *sh=
adow)
>         unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
>         eviction <<=3D bucket_order;
>
> +       /* Flush stats (and potentially sleep) before holding RCU read lo=
ck */

I think the only reason we use rcu lock is due to
mem_cgroup_from_id(). Maybe we should add mem_cgroup_tryget_from_id().
The other caller of mem_cgroup_from_id() in vmscan is already doing
the same and could use mem_cgroup_tryget_from_id().

Though this can be done separately to this series (if we decide to do
it at all).
