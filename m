Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F26EB7B8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 08:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDVG6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 02:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVG6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 02:58:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E3C1BD7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 23:58:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso4202636a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682146709; x=1684738709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxJPv5YUaYga4qP2tCFY0+OVCeqNKCa3+IshF6a4isY=;
        b=lg3kth/JQc4G2JfDfTNxGxfiDovVd6ZjhMh6NPyApYjYcAksdg+wPN0R9/hb4QUJao
         zBgBRdEW/iJ/509DgyVjsT5132dXqftepM2ywJWPkz0Tgw0UWy6SCRYZ1YwkvcvL+bsP
         CdGFkXybgmK0u3oR3QcHalGXDHcjADcfdsWwXzGk4v6FwSQUU/a3s7NhgqOckMa7Y78b
         P8Nrs7U3gtGBJrNDNAQ3JENQfiBtP4cT1E/JW6A/r88dK/Gwzdlh5uCTD6wyKFcDOJds
         QmLCx3yy21Om8ZPKxGJxYjuDiDL7Wci3r4oM2DO1ej072r/HL8t+b2C42R2Z1lcyDHpe
         y7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682146709; x=1684738709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxJPv5YUaYga4qP2tCFY0+OVCeqNKCa3+IshF6a4isY=;
        b=j7+32cQpDjAU8yB3DwB6tzUC4jD60q0T+VwZDvi1d1pwQTsKJpr/0p4rBFIRSz8i75
         ULZsbtU+Ef6OeA5ve+ypugM5Bdam7ehoJw6g8+LG0HiSkj4Wa8oQYGf0bIl0XwwlXrsh
         Sgn3rNHYc3VYrQRgb/VCgGEYWMIs/avoSU4OZnID4bvshsw8qtCNiO4KnGZ08+MNV4pC
         sjs5haWIhXdV1qO6BKnVRRfqkYDdgoTYRWOETwIJ13lkwk3LNa81JlrnwRy4digfvdsK
         sM1pIDjbskTQvthRoG5GNC15siZTxX3nW278sGDQVRhLl9VkJsR5dTf9HDrUfVokAkRS
         r7og==
X-Gm-Message-State: AAQBX9d7xIIRSFPEhPQtDw4w9SBCFpj22wCd2mQNDSY6t2u6DxTuFMAP
        1YkfBsPFHfVN95s+MVcW0m1pDe///yDOrKOQ/8azBw==
X-Google-Smtp-Source: AKy350YxgjFw8cxiHvQo+WWhydsW2+VUn2corXP+T4ebUl85rcxnGoyVmj3N/wYnJWG8HFhcVS9W/f1/pBiKHkdGJ5E=
X-Received: by 2002:a17:907:3fa9:b0:949:797e:ea91 with SMTP id
 hr41-20020a1709073fa900b00949797eea91mr5729303ejc.56.1682146708594; Fri, 21
 Apr 2023 23:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000058b63f05f9d98811@google.com> <20230421174054.3434533-1-roman.gushchin@linux.dev>
 <CAJD7tkZRLsubybPesf65t1ATEksTtif8uztAFZ-gVmYCnjw0Bg@mail.gmail.com> <ZEMUYCcUtqDFSYXH@P9FQF9L96D>
In-Reply-To: <ZEMUYCcUtqDFSYXH@P9FQF9L96D>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 21 Apr 2023 23:57:50 -0700
Message-ID: <CAJD7tkaqCLsSufTnC7bi8km13E4=R_jkid_ot99RLnFnE4p-2g@mail.gmail.com>
Subject: Re: [PATCH] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
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

On Fri, Apr 21, 2023 at 3:55=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Fri, Apr 21, 2023 at 03:16:02PM -0700, Yosry Ahmed wrote:
> > On Fri, Apr 21, 2023 at 10:41=E2=80=AFAM Roman Gushchin
> > <roman.gushchin@linux.dev> wrote:
> > >
> > > KCSAN found an issue in obj_stock_flush_required():
> > > stock->cached_objcg can be reset between the check and dereference:
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > BUG: KCSAN: data-race in drain_all_stock / drain_obj_stock
> > >
> > > write to 0xffff888237c2a2f8 of 8 bytes by task 19625 on cpu 0:
> > >  drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
> > >  refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
> > >  obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
> > >  memcg_slab_free_hook mm/slab.h:587 [inline]
> > >  __cache_free mm/slab.c:3373 [inline]
> > >  __do_kmem_cache_free mm/slab.c:3577 [inline]
> > >  kmem_cache_free+0x105/0x280 mm/slab.c:3602
> > >  __d_free fs/dcache.c:298 [inline]
> > >  dentry_free fs/dcache.c:375 [inline]
> > >  __dentry_kill+0x422/0x4a0 fs/dcache.c:621
> > >  dentry_kill+0x8d/0x1e0
> > >  dput+0x118/0x1f0 fs/dcache.c:913
> > >  __fput+0x3bf/0x570 fs/file_table.c:329
> > >  ____fput+0x15/0x20 fs/file_table.c:349
> > >  task_work_run+0x123/0x160 kernel/task_work.c:179
> > >  resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> > >  exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
> > >  exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
> > >  __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> > >  syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
> > >  do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
> > >  obj_stock_flush_required mm/memcontrol.c:3319 [inline]
> > >  drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
> > >  try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
> > >  try_charge mm/memcontrol.c:2837 [inline]
> > >  mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
> > >  sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
> > >  sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
> > >  udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
> > >  udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
> > >  sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
> > >  __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
> > >  __do_sys_setsockopt net/socket.c:2282 [inline]
> > >  __se_sys_setsockopt net/socket.c:2279 [inline]
> > >  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
> > >  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > >  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > >  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > value changed: 0xffff8881382d52c0 -> 0xffff888138893740
> > >
> > > Reported by Kernel Concurrency Sanitizer on:
> > > CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkalle=
r-00387-g534293368afa #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 03/02/2023
> > >
> > > Fix it by reading the cached_objcg with READ_ONCE().
> >
> > IIUC reading an outdated objcg is fine here, and the real problem is a
> > potential NULL dereference, which isn't shown by this report. Is this
> > correct?
>
> My understanding of the problem:
> 1) we are reading stock->cached_objcg and checking for being NULL, it's n=
ot NULL.
> 2) we're reading it again and dereferencing it without a check.
>
> If stock->cached_objcg is zeroed between 1) and 2), we're in trouble.
>
> The fix makes sure we're dereferencing exactly what we check.

I see. This matches my understanding. The bug report does not show a
NULL dereference but it shows a data race that can very well lead to
one.

FWIW,
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

>
> >
> > >
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
> > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > Link: https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+SG=
FhT+jjm8k1P-a_8Kkxsjg@mail.gmail.com/T/#t
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > > ---
> > >  mm/memcontrol.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 5abffe6f8389..9426a1ddc190 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -3314,10 +3314,11 @@ static struct obj_cgroup *drain_obj_stock(str=
uct memcg_stock_pcp *stock)
> > >  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> > >                                      struct mem_cgroup *root_memcg)
> > >  {
> > > +       struct obj_cgroup *objcg =3D READ_ONCE(stock->cached_objcg);
> > >         struct mem_cgroup *memcg;
> > >
> > > -       if (stock->cached_objcg) {
> > > -               memcg =3D obj_cgroup_memcg(stock->cached_objcg);
> > > +       if (objcg) {
> > > +               memcg =3D obj_cgroup_memcg(objcg);
> > >                 if (memcg && mem_cgroup_is_descendant(memcg, root_mem=
cg))
> > >                         return true;
> > >         }
> > > --
> > > 2.40.0
> > >
> > >
