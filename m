Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16616EC87F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjDXJNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjDXJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:13:07 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AFBE4B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:13:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5052caa1e32so7362875a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682327584; x=1684919584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9ASJUqID+uy5gSm/nTraMoaG6Bfnet6578mvanBog4=;
        b=yw4OQof9e40KWx9hR46+xXmc6Lvw61Mk5l9oQe+E+SSePemiPseaBPx3kib+rd7Qmq
         6mjfeWkou/jWF6/FBoKKdp+pHs2NL5lkh/d7nKAMns+RDdz0U22kLZupWELfnmR5pNYO
         KANwhLdSnxxXHvP4Z6Fjwvc3LE8gmR5u4AHwVojUPbcv3maf/TJvmg5f8mgKoblYlLRz
         KX76uLxloGgJESyqrt4bH1hKBvYrXGVKSP0a3BBHq2qDPJx9q+Z18hTaaVX7NKmP7gHk
         FnQnrHo7DYk+GkdNvl5MEb7EpHc/vf5RfVSfSUtahF0wYv8e7YHjeOuDSz2M0d8ii4dN
         G9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682327584; x=1684919584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9ASJUqID+uy5gSm/nTraMoaG6Bfnet6578mvanBog4=;
        b=A3BAZP0Ezz5ksSQwl43awmkHje8DdXJYs5EjuWjaYJgZWRDJFR3WSOTGkQc5VuXgdp
         x16YTFSEKnwvzpy1Ft6goWkmOdnRIOWQWY7YXZ3KwDO6SMZX8HOTg7N6z2sZuEecKlR+
         GZ8eOin6xAxYNOPGsYsuYHQtUkenBfGm2Hz5Wgy1hl7azim55MOjIDd40hI2zCL0wet/
         Dd/RVF9m0qlvKxUN11duM+PKooJmUflHaVxxrLmwyshvCOqKZzjt2s+nr6G0PP4hWfK9
         Bx+a5xRVQR65keENI8uabp4A8oF7iWAwlOhNNmPex3gAXmVshnAaLFXCxE0Q6oOkS/Hj
         b1sA==
X-Gm-Message-State: AAQBX9ccM+B2CB1Dism72HGuQyz8/lPyLFFUDDoipg6YtB2Vaa12ix7N
        qnqt1qB9o+KhtsP8TZ2tUwE/2fOpSOlL+4iZ97tqAg==
X-Google-Smtp-Source: AKy350aKOdsRdtTx+h/yCBnJsSwu6ErpzOZjnwKPNz0OXf/Owln7kXaVA3dWL5ztoZGL2TF6Wf6/tMHEgkPHepXRgdo=
X-Received: by 2002:aa7:cf8b:0:b0:506:7c86:1fd with SMTP id
 z11-20020aa7cf8b000000b005067c8601fdmr10148284edx.37.1682327584335; Mon, 24
 Apr 2023 02:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000058b63f05f9d98811@google.com> <20230421174054.3434533-1-roman.gushchin@linux.dev>
 <DB1562BC-CAD0-45B4-8C6D-92E583C128DF@linux.dev> <CACT4Y+Yy9a8R_oiumdZiE-hwAqrDV63VAWgbrE5nFEk9w-JuPQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Yy9a8R_oiumdZiE-hwAqrDV63VAWgbrE5nFEk9w-JuPQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 24 Apr 2023 02:12:27 -0700
Message-ID: <CAJD7tkY4VH3CDoZHjOTWvCCPXikRScNjwPsV9hf001X_y6i+FA@mail.gmail.com>
Subject: Re: [PATCH] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
To:     Dmitry Vyukov <dvyukov@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org,
        syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
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

On Sun, Apr 23, 2023 at 11:51=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
>
> On Sun, 23 Apr 2023 at 04:26, Muchun Song <muchun.song@linux.dev> wrote:
> > > On Apr 22, 2023, at 01:40, Roman Gushchin <roman.gushchin@linux.dev> =
wrote:
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
> > > drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
> > > refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
> > > obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
> > > memcg_slab_free_hook mm/slab.h:587 [inline]
> > > __cache_free mm/slab.c:3373 [inline]
> > > __do_kmem_cache_free mm/slab.c:3577 [inline]
> > > kmem_cache_free+0x105/0x280 mm/slab.c:3602
> > > __d_free fs/dcache.c:298 [inline]
> > > dentry_free fs/dcache.c:375 [inline]
> > > __dentry_kill+0x422/0x4a0 fs/dcache.c:621
> > > dentry_kill+0x8d/0x1e0
> > > dput+0x118/0x1f0 fs/dcache.c:913
> > > __fput+0x3bf/0x570 fs/file_table.c:329
> > > ____fput+0x15/0x20 fs/file_table.c:349
> > > task_work_run+0x123/0x160 kernel/task_work.c:179
> > > resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> > > exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
> > > exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
> > > __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> > > syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
> > > do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
> > > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > >
> > > read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
> > > obj_stock_flush_required mm/memcontrol.c:3319 [inline]
> > > drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
> > > try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
> > > try_charge mm/memcontrol.c:2837 [inline]
> > > mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
> > > sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
> > > sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
> > > udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
> > > udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
> > > sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
> > > __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
> > > __do_sys_setsockopt net/socket.c:2282 [inline]
> > > __se_sys_setsockopt net/socket.c:2279 [inline]
> > > __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
> > > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > > entry_SYSCALL_64_after_hwframe+0x63/0xcd
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
> > >
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
> > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > Link: https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+SG=
FhT+jjm8k1P-a_8Kkxsjg@mail.gmail.com/T/#t
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > Acked-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Thanks.
>
> This improves things, but strictly speaking the write side also needs
> WRITE_ONCE. Ordering is always a game of two. It's not possible to
> order things on one side, if the other side messes up the ordering.
>

It looks like most other accesses use memcg_stock.stock_lock for
synchronization. Based on the output of obj_stock_flush_required()
we call drain_local_stock(), which acquires that lock as well. Should
we refactor the code to extend the lock section to cover both
obj_stock_flush_required() and drain_local_stock()?

IIUC this may unify the synchronization handling and
READ_ONCE/WRITE_ONCE may no longer be needed. This should also avoid
any inaccuracies (e.g. unnecessary flushes) that may happen if the
cached objcg changes between obj_stock_flush_required() and
drain_local_stock().

Did I miss anything here?
