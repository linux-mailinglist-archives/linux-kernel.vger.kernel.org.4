Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948E86F4B25
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjEBUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEBUP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:15:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F472691
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:15:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bcae898b2so3860290a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683058539; x=1685650539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9QHtsPGpUiOO8P09+xIa3RCAMRlLX2P/2MPTz6R0SU=;
        b=W4MFXuLt4RZ5jIx3f+5AedVSYTsRoE4ZfFWepQfQaUFPEyKcIArk9quArn+eaQZK78
         qScaPeEci5bNT7Iz0qpFcFce81vbEouaxh9uHUu6cdLUikeemOoc21OfNQsS3KIfw2te
         gAGQkspHf85vLxZghagW1gLkyCC/iJZSzMJEGlb6HnzOwijlPADsZck8XZ5cxw+BPINm
         2GLpTXfWFoe35EkzWdFgWPAfGNhPgr259nrAvnw+nHBbQzF2d6NfTYqbEqSc0YahB0G2
         kDH6zXEtZEAlYgyMT6qhebHD7QeY+NwVaUy3Uh48j2bQkEsQKXj/sScB03JP2MnFX4Ib
         I3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058539; x=1685650539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9QHtsPGpUiOO8P09+xIa3RCAMRlLX2P/2MPTz6R0SU=;
        b=havdIm80fxWB+TxyXo78lWqFV8S/qAV89x+tgM8mH98J/roalCnINxYxmAcfPw+Fev
         cfYzKrELjbEKpiIoNKDhO2DKvtbgBDzpDO0K4orsJUnzX36FjRIK9yO4hCnwk3g4TLAn
         +4/WCZhAYs6hyo+75ADOhE3RCLUgNTupqK/h2bMjyB0M69OCyqql4woqmgA5c7K4qIFh
         ukhpastvR/dNJGwQ7Df1l7HIU5fkOc/AC9pUCas92XS2/ylCInj5loB2QnbLTZbvrxk1
         OwTLkQIXyhFyF3TlfVrDQi2Htt/c5/OB95wdi8//mb6u+KsjOEPLvkOWEtxslz/2fAwx
         sp7Q==
X-Gm-Message-State: AC+VfDw6OrXvasMStigBZUNtBiRXAfqIuk1EzPp+wQHufTeLqHIOsQjm
        caO6qJ83s1QciobMNyD3DO0dcMiZcGvrvzX6NtMcdA==
X-Google-Smtp-Source: ACHHUZ5SfrXf9BlUW1xsyqZ7gbDNKA9OjIbTRJxbPVHgNZQd3U5wwyx/cvb95Ct49JxzqUlMiiizBkfAxcpIkwglavk=
X-Received: by 2002:a50:e604:0:b0:4ac:b687:f57e with SMTP id
 y4-20020a50e604000000b004acb687f57emr9358595edm.1.1683058538647; Tue, 02 May
 2023 13:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230502160839.361544-1-roman.gushchin@linux.dev>
In-Reply-To: <20230502160839.361544-1-roman.gushchin@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 2 May 2023 13:15:02 -0700
Message-ID: <CAJD7tkZ7Vnk6J9cJoj66wAUzmSeAopFpuXrtxZCsCtPCvvwzuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org,
        syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
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
> KCSAN found an issue in obj_stock_flush_required():
> stock->cached_objcg can be reset between the check and dereference:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in drain_all_stock / drain_obj_stock
>
> write to 0xffff888237c2a2f8 of 8 bytes by task 19625 on cpu 0:
>  drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
>  refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
>  obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
>  memcg_slab_free_hook mm/slab.h:587 [inline]
>  __cache_free mm/slab.c:3373 [inline]
>  __do_kmem_cache_free mm/slab.c:3577 [inline]
>  kmem_cache_free+0x105/0x280 mm/slab.c:3602
>  __d_free fs/dcache.c:298 [inline]
>  dentry_free fs/dcache.c:375 [inline]
>  __dentry_kill+0x422/0x4a0 fs/dcache.c:621
>  dentry_kill+0x8d/0x1e0
>  dput+0x118/0x1f0 fs/dcache.c:913
>  __fput+0x3bf/0x570 fs/file_table.c:329
>  ____fput+0x15/0x20 fs/file_table.c:349
>  task_work_run+0x123/0x160 kernel/task_work.c:179
>  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>  exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
>  exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
>  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
>  obj_stock_flush_required mm/memcontrol.c:3319 [inline]
>  drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
>  try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
>  try_charge mm/memcontrol.c:2837 [inline]
>  mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
>  sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
>  sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
>  udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
>  udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
>  sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
>  __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
>  __do_sys_setsockopt net/socket.c:2282 [inline]
>  __se_sys_setsockopt net/socket.c:2279 [inline]
>  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> value changed: 0xffff8881382d52c0 -> 0xffff888138893740
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkaller-00=
387-g534293368afa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/02/2023
>
> Fix it by using READ_ONCE()/WRITE_ONCE() for all accesses to
> stock->cached_objcg.

I believe all read accesses other than obj_stock_flush_required() are
done under the lock, so READ_ONCE() wouldn't be needed AFAICT. Having
READ_ONCE() only around the racy read can be useful to document the
racy read and differentiate it from others.

With that said, it's also inconvenient to keep track moving forward of
which reading sites are racy, and it may be simpler to just annotate
all readers with READ_ONCE().

I am not sure which approach is better, just thinking out loud.

>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link:
> https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+SGFhT+jjm8k1=
P-a_8Kkxsjg@mail.gmail.com/T/#t
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

With the above said, I don't feel strongly either way, the patch looks
good AFAICT:
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> Cc: Yosry Ahmed <yosryahmed@google.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4b27e245a055..c823c35c2ed4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3208,12 +3208,12 @@ void mod_objcg_state(struct obj_cgroup *objcg, st=
ruct pglist_data *pgdat,
>          * accumulating over a page of vmstat data or when pgdat or idx
>          * changes.
>          */
> -       if (stock->cached_objcg !=3D objcg) {
> +       if (READ_ONCE(stock->cached_objcg) !=3D objcg) {
>                 old =3D drain_obj_stock(stock);
>                 obj_cgroup_get(objcg);
>                 stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
>                                 ? atomic_xchg(&objcg->nr_charged_bytes, 0=
) : 0;
> -               stock->cached_objcg =3D objcg;
> +               WRITE_ONCE(stock->cached_objcg, objcg);
>                 stock->cached_pgdat =3D pgdat;
>         } else if (stock->cached_pgdat !=3D pgdat) {
>                 /* Flush the existing cached vmstat data */
> @@ -3267,7 +3267,7 @@ static bool consume_obj_stock(struct obj_cgroup *ob=
jcg, unsigned int nr_bytes)
>         local_lock_irqsave(&memcg_stock.stock_lock, flags);
>
>         stock =3D this_cpu_ptr(&memcg_stock);
> -       if (objcg =3D=3D stock->cached_objcg && stock->nr_bytes >=3D nr_b=
ytes) {
> +       if (objcg =3D=3D READ_ONCE(stock->cached_objcg) && stock->nr_byte=
s >=3D nr_bytes) {
>                 stock->nr_bytes -=3D nr_bytes;
>                 ret =3D true;
>         }
> @@ -3279,7 +3279,7 @@ static bool consume_obj_stock(struct obj_cgroup *ob=
jcg, unsigned int nr_bytes)
>
>  static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>  {
> -       struct obj_cgroup *old =3D stock->cached_objcg;
> +       struct obj_cgroup *old =3D READ_ONCE(stock->cached_objcg);
>
>         if (!old)
>                 return NULL;
> @@ -3332,7 +3332,7 @@ static struct obj_cgroup *drain_obj_stock(struct me=
mcg_stock_pcp *stock)
>                 stock->cached_pgdat =3D NULL;
>         }
>
> -       stock->cached_objcg =3D NULL;
> +       WRITE_ONCE(stock->cached_objcg, NULL);
>         /*
>          * The `old' objects needs to be released by the caller via
>          * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
> @@ -3343,10 +3343,11 @@ static struct obj_cgroup *drain_obj_stock(struct =
memcg_stock_pcp *stock)
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>                                      struct mem_cgroup *root_memcg)
>  {
> +       struct obj_cgroup *objcg =3D READ_ONCE(stock->cached_objcg);
>         struct mem_cgroup *memcg;
>
> -       if (stock->cached_objcg) {
> -               memcg =3D obj_cgroup_memcg(stock->cached_objcg);
> +       if (objcg) {
> +               memcg =3D obj_cgroup_memcg(objcg);
>                 if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
>                         return true;
>         }
> @@ -3365,10 +3366,10 @@ static void refill_obj_stock(struct obj_cgroup *o=
bjcg, unsigned int nr_bytes,
>         local_lock_irqsave(&memcg_stock.stock_lock, flags);
>
>         stock =3D this_cpu_ptr(&memcg_stock);
> -       if (stock->cached_objcg !=3D objcg) { /* reset if necessary */
> +       if (READ_ONCE(stock->cached_objcg) !=3D objcg) { /* reset if nece=
ssary */
>                 old =3D drain_obj_stock(stock);
>                 obj_cgroup_get(objcg);
> -               stock->cached_objcg =3D objcg;
> +               WRITE_ONCE(stock->cached_objcg, objcg);
>                 stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
>                                 ? atomic_xchg(&objcg->nr_charged_bytes, 0=
) : 0;
>                 allow_uncharge =3D true;  /* Allow uncharge when objcg ch=
anges */
> --
> 2.40.1
>
