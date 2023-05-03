Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEFF6F52AE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjECIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjECIHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:07:18 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0F4EE4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:06:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f1217f16e9so7156e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 01:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683101158; x=1685693158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=duSL2057vmRtGPMJIZ6dGrYwq/lIMEGfZ+QIPoJRz8o=;
        b=CjihFCiMyVCY53EhQSS2cj/a3mryIDFUV+PPhVInLD4OSRw2VepB2Un2eZfomqJq4n
         28QRE6YnCWmAub8oGU84TxpwQv1WJ5KGK1lpZsd1ErO0ru+nbiDG00PMvpyCBxAlMVpU
         Gr2dTXvojv2hu1SXXd05jObcAUCCDFnJTgHNqZbVTlq9f9eWGjUuLqpuczoP/Qtv7IRZ
         NvFYu45X7lgaZLeEwxESFeq0v1IoccOgLkPpqPmCUotbcPJWOUDcWhKet/ufIG+yyIh8
         8qvenXvDy1/5h1sL4LMGKM8KUg8DYU4w09eWxTF3C/S7LG5j1AuIAP9E+whvdoj19naY
         DwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683101158; x=1685693158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=duSL2057vmRtGPMJIZ6dGrYwq/lIMEGfZ+QIPoJRz8o=;
        b=hd/7TPlIevnZPL9cApfuyxHB59aR1TOSOFZStmCQAPZfro8pjtWiit+s871Q1ToxPm
         W4opK3yZxOVyYIRah9coftk/fvsiasznuaAPBi8TASQfdjmgbHVoaUtiUDdLWNofzvjy
         d9oIYBC1I3aYg2VmhrHyvNAkxHsj1gtDfRkvNsg/b1c8zok5qtqdQHcTknleWPNEpwF7
         yQuX3WUz1Vx0D4ry+fvaXBDUhVVK5wFZqyO3qEq5rm/luLEqGnujWlXI/BeakCMzwrFK
         t6zb0HsWYWgWv7opriKglVZuFiGvIkj/LPOCYu775jgNPATmI+VVv5Vk++U3TshJRsNR
         ylDw==
X-Gm-Message-State: AC+VfDx/pFcyxJ5ftMNpCf3ptzBa7LXA975TsWvOwKmCXfzS9ux4+uWA
        yrn++kZYdSWBuRX+XHxzaBj0awrtTPzMeTbd3E47MQ==
X-Google-Smtp-Source: ACHHUZ4cyOsCuHs906Vggn8kYUMeeIHUzj2ROM2AyzYuDN3imL2sb2deRXT9g5ttw2DZ9RILf1sXh9NOFr3DaL0q5OA=
X-Received: by 2002:a05:6512:2398:b0:4ea:e5e2:c893 with SMTP id
 c24-20020a056512239800b004eae5e2c893mr117755lfv.1.1683101157679; Wed, 03 May
 2023 01:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230502160839.361544-1-roman.gushchin@linux.dev>
In-Reply-To: <20230502160839.361544-1-roman.gushchin@linux.dev>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 May 2023 10:05:44 +0200
Message-ID: <CACT4Y+ZkcEjWeqvAZCk8KNj3NRcP6osca-VQ+zoNGhri0Q9tAQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org,
        syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 2 May 2023 at 18:09, Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> KCSAN found an issue in obj_stock_flush_required():
> stock->cached_objcg can be reset between the check and dereference:
>
> ==================================================================
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
> CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkaller-00387-g534293368afa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
>
> Fix it by using READ_ONCE()/WRITE_ONCE() for all accesses to
> stock->cached_objcg.
>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link:
> https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+SGFhT+jjm8k1P-a_8Kkxsjg@mail.gmail.com/T/#t
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
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
> @@ -3208,12 +3208,12 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>          * accumulating over a page of vmstat data or when pgdat or idx
>          * changes.
>          */
> -       if (stock->cached_objcg != objcg) {
> +       if (READ_ONCE(stock->cached_objcg) != objcg) {
>                 old = drain_obj_stock(stock);
>                 obj_cgroup_get(objcg);
>                 stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>                                 ? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> -               stock->cached_objcg = objcg;
> +               WRITE_ONCE(stock->cached_objcg, objcg);
>                 stock->cached_pgdat = pgdat;
>         } else if (stock->cached_pgdat != pgdat) {
>                 /* Flush the existing cached vmstat data */
> @@ -3267,7 +3267,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>         local_lock_irqsave(&memcg_stock.stock_lock, flags);
>
>         stock = this_cpu_ptr(&memcg_stock);
> -       if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
> +       if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
>                 stock->nr_bytes -= nr_bytes;
>                 ret = true;
>         }
> @@ -3279,7 +3279,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>
>  static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>  {
> -       struct obj_cgroup *old = stock->cached_objcg;
> +       struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
>
>         if (!old)
>                 return NULL;
> @@ -3332,7 +3332,7 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>                 stock->cached_pgdat = NULL;
>         }
>
> -       stock->cached_objcg = NULL;
> +       WRITE_ONCE(stock->cached_objcg, NULL);
>         /*
>          * The `old' objects needs to be released by the caller via
>          * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
> @@ -3343,10 +3343,11 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>                                      struct mem_cgroup *root_memcg)
>  {
> +       struct obj_cgroup *objcg = READ_ONCE(stock->cached_objcg);
>         struct mem_cgroup *memcg;
>
> -       if (stock->cached_objcg) {
> -               memcg = obj_cgroup_memcg(stock->cached_objcg);
> +       if (objcg) {
> +               memcg = obj_cgroup_memcg(objcg);
>                 if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
>                         return true;
>         }
> @@ -3365,10 +3366,10 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>         local_lock_irqsave(&memcg_stock.stock_lock, flags);
>
>         stock = this_cpu_ptr(&memcg_stock);
> -       if (stock->cached_objcg != objcg) { /* reset if necessary */
> +       if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
>                 old = drain_obj_stock(stock);
>                 obj_cgroup_get(objcg);
> -               stock->cached_objcg = objcg;
> +               WRITE_ONCE(stock->cached_objcg, objcg);
>                 stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>                                 ? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
>                 allow_uncharge = true;  /* Allow uncharge when objcg changes */


Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
