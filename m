Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B05072866E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 19:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjFHRi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 13:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFHRiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 13:38:25 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD08F2115
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 10:38:24 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-653496acd69so786056b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 10:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686245904; x=1688837904;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ws5hYOAz5LdpAS698YPjYKgEw8uTHLTQwc5TJ4BE0Mo=;
        b=CJ1xvFmRtdO1o+kam9oDcnjq8RYnT6Vc7hNZJqwlW6t8RV0rau1YmewdR0UXr6uB6u
         jw8bKO2uw8AnWzjHmZi8/Y5sVH5KEEKF6tb6dfNUZbj++Q65T8DfckkuAIYNPN0RPq0e
         kxsLBpyQ1cPBXEQHYwewzh1QcmbHwQl7DeJjCfnAs3ZyxRX/imca6DOKlYmmjwo/IX1C
         ZUjHdFDvWJlhZVW5RmPAoe1+JBYRgIDpRHOfKQhWhqjr8Oc2xzqNJQJqT7l3otEZhUpG
         tit/B4SF1bRHlgpd89GF1o5RaY4EBYXeSQMt/GQtj4eZy3keFDle4o4w9KeZWgs22pp4
         wjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686245904; x=1688837904;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ws5hYOAz5LdpAS698YPjYKgEw8uTHLTQwc5TJ4BE0Mo=;
        b=iiXKiaIY7BJKgJtHio900dRQug1/xfzIRMsmXdw9FU6brmH4s8nT9dZM+eA85+nLOi
         LBzKJOTx5NPZkTxKY9uknmc76G4q7/ZUNzEBABlWV6OHxd9oTpGv+Ftog7a06LeoHSBM
         RBWST2sXuRiRJ3fkgscjVOPo4tDL6C5OD/kZL60IMzrGaM4XalqvfzFDVKfUCR8lSioT
         44IxQHr7zYpD02HENtQJnMT2g1x7BhBQidg9bsNqcGDFWHangWO1CxVygf9ixzjeExgD
         +q0FRJBtIwCrSXSevkyFxugrojCqfCgkwguiFg1rCXj6PPa60Y9c/fWOj1YJcAmYdngd
         gQqw==
X-Gm-Message-State: AC+VfDxr6TGzkDSMBRCxIBP/uFaOJypkkHx6km4v8KXmFyOTIyEVXS90
        Dzq/LwmACQMTAlUluUnWVjogqPAjtH/lGg==
X-Google-Smtp-Source: ACHHUZ6ksU2ZPjLv8B/yxec/3W1lqJ6bFUy07oFJDWD/BMzRYlWNXQgkON1sn42NEpfTRqZ6Dv65NPbUHkC1Uw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a05:6a00:3a0b:b0:655:4e44:d2fc with SMTP
 id fj11-20020a056a003a0b00b006554e44d2fcmr3923272pfb.2.1686245904138; Thu, 08
 Jun 2023 10:38:24 -0700 (PDT)
Date:   Thu, 8 Jun 2023 17:38:22 +0000
In-Reply-To: <20230608171256.17827-1-mkoutny@suse.com>
Mime-Version: 1.0
References: <20230608171256.17827-1-mkoutny@suse.com>
Message-ID: <20230608173822.zezggshxhh62mxoi@google.com>
Subject: Re: [RFC PATCH] mm: Sync percpu mm RSS counters before querying
From:   Shakeel Butt <shakeelb@google.com>
To:     "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adam Majer <amajer@suse.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 07:12:56PM +0200, Michal Koutn=C3=BD wrote:
> An issue was observed with stats collected in struct rusage on ppc64le
> with 64kB pages. The percpu counters use batching with
> 	percpu_counter_batch =3D max(32, nr*2) # in PAGE_SIZE
> i.e. with larger pages but similar RSS consumption (bytes), there'll be
> less flushes and error more noticeable.
>=20
> In this given case (getting consumption of exited child), we can request
> percpu counter's flush without worrying about contention with updaters.
>=20
> Fortunately, the commit f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter") didn't eradicate all traces of SPLIT_RSS_COUNTING and
> this mechanism already provided some synchronization points before
> reading stats.
> Therefore, use sync_mm_rss as carrier for percpu counters refreshes and
> forget SPLIT_RSS_COUNTING macro for good.
>=20
> Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> Reported-by: Adam Majer <amajer@suse.com>
> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>

The patch seems reasonable to me. Are any of the callsites of
sync_mm_rss performance sensitive?

> ---
>  include/linux/mm.h | 6 ++----
>  kernel/fork.c      | 4 ----
>  2 files changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..30cfde88d5b2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2547,13 +2547,11 @@ static inline void setmax_mm_hiwater_rss(unsigned=
 long *maxrss,
>  		*maxrss =3D hiwater_rss;
>  }
> =20
> -#if defined(SPLIT_RSS_COUNTING)
> -void sync_mm_rss(struct mm_struct *mm);
> -#else
>  static inline void sync_mm_rss(struct mm_struct *mm)
>  {
> +	for (int i =3D 0; i < NR_MM_COUNTERS; ++i)
> +		percpu_counter_sum(&mm->rss_stat[i]);
>  }
> -#endif
> =20
>  #ifndef CONFIG_ARCH_HAS_PTE_SPECIAL
>  static inline int pte_special(pte_t pte)
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 81cba91f30bb..e030eb902e4b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2412,10 +2412,6 @@ __latent_entropy struct task_struct *copy_process(
>  	p->io_uring =3D NULL;
>  #endif
> =20
> -#if defined(SPLIT_RSS_COUNTING)
> -	memset(&p->rss_stat, 0, sizeof(p->rss_stat));
> -#endif
> -
>  	p->default_timer_slack_ns =3D current->timer_slack_ns;
> =20
>  #ifdef CONFIG_PSI
> --=20
> 2.40.1
>=20
