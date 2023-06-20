Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E467B7375FA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjFTUUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjFTUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:20:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76F1BD5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:20:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso6808866a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687292415; x=1689884415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Zy9E39IJgeyzmvbXlZlqFtNdvkFQRFNcCLclJAn3Dk=;
        b=w7nUpfulgg5cVpdAqhG2Xt87fp+T4OHkUaUAAHNTM5RqhmEqgDa+Eq/iezw9tpQc2g
         rB4y3XXbzSHodfyyJ2fcvFBOX4t1l5fvxzPDV8K158mDoC3D6RSqN8HaWllO1jiHck+a
         EF0ElzRbdWu8NE0gQUYTT1XW7nJMk16fudN8dQc6BIApzpEsUcI+w/VpM1X9SFmCDrgE
         7k5f3sW0hVpjZje7oO3U3k2s4/vUAY91azC8VAW+0pDB1PLq4zT4QbvjeFjUMMTIGnJU
         ftcKSF5l/6By5dHPdtDLRcPIikVcjMYdVgKKfzjdnRUg8AsvjJrMlJh2etXoLalRnfcR
         LBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292415; x=1689884415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zy9E39IJgeyzmvbXlZlqFtNdvkFQRFNcCLclJAn3Dk=;
        b=JTdoib9hqWxLHaN+3D4kRRg7evpu4sU5ePoNsPMC3zluoFKtZA+bn1Wem4y78acmPU
         LRDdeI3KNcMV1lia8QUVSkFy8wBM5Z0wGW0NtEzJEx9fwQHchvg/7HKLroNLEPK037US
         7/LwOZRl1N8TpzFh2X0gs/SvfGVVd27Fa37GTzqZTnVUfxi6sAdk2jWtL8uWEnuljVvL
         zqdX9D7pzzMjzYC9VgM7b5BCgAeAurgmhoImtg586NgIhRHyk1J066nG71pEec+Xrb+j
         pJv8r1BA+C6t9iItdGcy/ys4Kq9cad40A56cbZL0wO6alxXH2x1zNyuR/FzkXENRJNiW
         TMoQ==
X-Gm-Message-State: AC+VfDx5Z0w8zMw6mizRMTxdODMjW2mc+ME/7yqZKgy6cmhm7My5aaTF
        Qct/BZ7pUCoEbXjRKRL0zqLGyzjdCKGpyIqjf3keMA==
X-Google-Smtp-Source: ACHHUZ4F1CiTZ+c9pAohA09rIRP6Qf5cYoYVb0ympDQgfKqCJ3aijqKOesZFVWTbdAIVjt+MYTHTHY9ehWV3hzkRzJs=
X-Received: by 2002:a17:907:808:b0:977:ceab:3996 with SMTP id
 wv8-20020a170907080800b00977ceab3996mr11622602ejb.76.1687292414702; Tue, 20
 Jun 2023 13:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230619193821.2710944-1-yuzhao@google.com>
In-Reply-To: <20230619193821.2710944-1-yuzhao@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 20 Jun 2023 13:19:38 -0700
Message-ID: <CAJD7tkb=5kOiuYZxYQVCpjZZriCf2wrx9sgenrpP_Bct=GWfcw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1] mm/mglru: make memcg_lru->lock irq safe
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 12:38=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> lru_gen_rotate_memcg() can happen in softirq if
> memory.soft_limit_in_bytes is set. This requires memcg_lru->lock to be
> irq safe.
>
> This problem only affects memcg v1.
>
> Reported-by: syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D87c490fd2be656269b6a
> Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/vmscan.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 45d17c7cc555..27f90896f789 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4759,10 +4759,11 @@ static void lru_gen_rotate_memcg(struct lruvec *l=
ruvec, int op)
>  {
>         int seg;
>         int old, new;
> +       unsigned long flags;
>         int bin =3D get_random_u32_below(MEMCG_NR_BINS);
>         struct pglist_data *pgdat =3D lruvec_pgdat(lruvec);
>
> -       spin_lock(&pgdat->memcg_lru.lock);
> +       spin_lock_irqsave(&pgdat->memcg_lru.lock, flags);

Nit: I think it might be useful to add a comment here that this is
needed due to the call path from memcg_check_events() ->
mem_cgroup_update_tree() -- so that if that call path changes we can
come back and remove the irq-disablement.

FWIW:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>
>         VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
>
> @@ -4797,7 +4798,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lru=
vec, int op)
>         if (!pgdat->memcg_lru.nr_memcgs[old] && old =3D=3D get_memcg_gen(=
pgdat->memcg_lru.seq))
>                 WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1=
);
>
> -       spin_unlock(&pgdat->memcg_lru.lock);
> +       spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
>  }
>
>  void lru_gen_online_memcg(struct mem_cgroup *memcg)
> @@ -4810,7 +4811,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
>                 struct pglist_data *pgdat =3D NODE_DATA(nid);
>                 struct lruvec *lruvec =3D get_lruvec(memcg, nid);
>
> -               spin_lock(&pgdat->memcg_lru.lock);
> +               spin_lock_irq(&pgdat->memcg_lru.lock);
>
>                 VM_WARN_ON_ONCE(!hlist_nulls_unhashed(&lruvec->lrugen.lis=
t));
>
> @@ -4821,7 +4822,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
>
>                 lruvec->lrugen.gen =3D gen;
>
> -               spin_unlock(&pgdat->memcg_lru.lock);
> +               spin_unlock_irq(&pgdat->memcg_lru.lock);
>         }
>  }
>
> @@ -4845,7 +4846,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg=
)
>                 struct pglist_data *pgdat =3D NODE_DATA(nid);
>                 struct lruvec *lruvec =3D get_lruvec(memcg, nid);
>
> -               spin_lock(&pgdat->memcg_lru.lock);
> +               spin_lock_irq(&pgdat->memcg_lru.lock);
>
>                 VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list=
));
>
> @@ -4857,7 +4858,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg=
)
>                 if (!pgdat->memcg_lru.nr_memcgs[gen] && gen =3D=3D get_me=
mcg_gen(pgdat->memcg_lru.seq))
>                         WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru=
.seq + 1);
>
> -               spin_unlock(&pgdat->memcg_lru.lock);
> +               spin_unlock_irq(&pgdat->memcg_lru.lock);
>         }
>  }
>
> --
> 2.41.0.185.g7c58973941-goog
>
>
