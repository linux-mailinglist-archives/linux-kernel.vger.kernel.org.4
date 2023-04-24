Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518646ED33A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 19:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjDXRKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjDXRKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 13:10:33 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F1E5B96
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:10:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef34c49cb9so1585611cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 10:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682356226; x=1684948226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDRpSrlyT9FYzP1gC3JngMLit04Rwq4LBSA35igDfWg=;
        b=cgvKgPjv2wvUQmlzs7RzonUhd4D9I89qNZY69J3xkADpMA5SDr2om76YzaJQL+n/Sb
         EpGHkFt5ZW43wMR3s/gMS1FKlDf5TsJ/1nOWR0hgaZfCWDmctypNV60IEQk7J5wpefIZ
         ZBM6a06ZujhmQvQFctyQwKAG4sm3yIH8mbyXwBoxvC485/JwK4lIAXxs1iQoZ1n34oHA
         gwwmMm9fUPrvajHVdqKNRs85SUGy6aS5/6hFJxUI0Ttn3zJkdS3Eolsr8h1qj0FHejfN
         zwC1UvOIIoVR+OpS0rweiPnmF4GIJOywuTf1FlTQrmHFKdif1lvdUzqiYV+V1Sc/pEmz
         L+Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682356226; x=1684948226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDRpSrlyT9FYzP1gC3JngMLit04Rwq4LBSA35igDfWg=;
        b=WqRSrymsTxSevQB+pjAnMRQ4Q1oLPS7l9OTxUVxXRaj5eXLKG0pa6/Oj8rUhEaVuze
         /xrTTpYQT/TfhP9vrxJYgPkSTOOH27a2FiIIh+x1gtNZfz4+jiuENRPsMmmL5v9QNERY
         SKXVbDrQ8pT4NF3zSSbaEBaBmcvjfyohZNFG2CWDrC4RkxHfhN58QOZz0e6gSNTCVV9e
         pUZC2KFj+KXIxm8TV0enyr1VG494R3wQUHyYIDmkpIQe944/UN/bNu7sSb8f0EckRzvL
         PWtSjBL3PCZSLBOBayIaJZs81qHBy0PiKpa+ENR6wPRBH2uk852oT2lNYFQmH+bu8y6o
         8jow==
X-Gm-Message-State: AAQBX9ditbZ2LegJjuI/0oSbG575FYHZkwvBDJBYa0GLGB3c/6Suby9s
        SiCNN3YqaDNhPadtAiuJWdiF7EExMK2t/hQw51dupw==
X-Google-Smtp-Source: AKy350ZyyNifJYiXT7K3Sg7viGBfJLlTP/oYwyhL6kUf3TLFz1RhlOE2ilhOwdtmAMjnK5wcPdg7UJHkFsB4jH+rYHQ=
X-Received: by 2002:ac8:5908:0:b0:3ef:3083:a437 with SMTP id
 8-20020ac85908000000b003ef3083a437mr637670qty.18.1682356226223; Mon, 24 Apr
 2023 10:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000058b63f05f9d98811@google.com> <20230421174054.3434533-1-roman.gushchin@linux.dev>
 <DB1562BC-CAD0-45B4-8C6D-92E583C128DF@linux.dev> <CACT4Y+Yy9a8R_oiumdZiE-hwAqrDV63VAWgbrE5nFEk9w-JuPQ@mail.gmail.com>
 <CAJD7tkY4VH3CDoZHjOTWvCCPXikRScNjwPsV9hf001X_y6i+FA@mail.gmail.com>
In-Reply-To: <CAJD7tkY4VH3CDoZHjOTWvCCPXikRScNjwPsV9hf001X_y6i+FA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 24 Apr 2023 10:10:15 -0700
Message-ID: <CALvZod4bX+vPLAXb5J4TW=BWDfeweuB_h+B1GgHED39N=b=SbA@mail.gmail.com>
Subject: Re: [PATCH] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
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

On Mon, Apr 24, 2023 at 2:13=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Sun, Apr 23, 2023 at 11:51=E2=80=AFPM Dmitry Vyukov <dvyukov@google.co=
m> wrote:
> >
> > On Sun, 23 Apr 2023 at 04:26, Muchun Song <muchun.song@linux.dev> wrote=
:
> > > > On Apr 22, 2023, at 01:40, Roman Gushchin <roman.gushchin@linux.dev=
> wrote:
> > > >
> > > > KCSAN found an issue in obj_stock_flush_required():
> > > > stock->cached_objcg can be reset between the check and dereference:
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > BUG: KCSAN: data-race in drain_all_stock / drain_obj_stock
> > > >
> > > > write to 0xffff888237c2a2f8 of 8 bytes by task 19625 on cpu 0:
> > > > drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
> > > > refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
> > > > obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
> > > > memcg_slab_free_hook mm/slab.h:587 [inline]
> > > > __cache_free mm/slab.c:3373 [inline]
> > > > __do_kmem_cache_free mm/slab.c:3577 [inline]
> > > > kmem_cache_free+0x105/0x280 mm/slab.c:3602
> > > > __d_free fs/dcache.c:298 [inline]
> > > > dentry_free fs/dcache.c:375 [inline]
> > > > __dentry_kill+0x422/0x4a0 fs/dcache.c:621
> > > > dentry_kill+0x8d/0x1e0
> > > > dput+0x118/0x1f0 fs/dcache.c:913
> > > > __fput+0x3bf/0x570 fs/file_table.c:329
> > > > ____fput+0x15/0x20 fs/file_table.c:349
> > > > task_work_run+0x123/0x160 kernel/task_work.c:179
> > > > resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> > > > exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
> > > > exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
> > > > __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> > > > syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
> > > > do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
> > > > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >
> > > > read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
> > > > obj_stock_flush_required mm/memcontrol.c:3319 [inline]
> > > > drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
> > > > try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
> > > > try_charge mm/memcontrol.c:2837 [inline]
> > > > mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
> > > > sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
> > > > sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
> > > > udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
> > > > udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
> > > > sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
> > > > __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
> > > > __do_sys_setsockopt net/socket.c:2282 [inline]
> > > > __se_sys_setsockopt net/socket.c:2279 [inline]
> > > > __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
> > > > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > > > do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> > > > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > >
> > > > value changed: 0xffff8881382d52c0 -> 0xffff888138893740
> > > >
> > > > Reported by Kernel Concurrency Sanitizer on:
> > > > CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted 6.3.0-rc2-syzkal=
ler-00387-g534293368afa #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 03/02/2023
> > > >
> > > > Fix it by reading the cached_objcg with READ_ONCE().
> > > >
> > > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > > Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
> > > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > > Link: https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+=
SGFhT+jjm8k1P-a_8Kkxsjg@mail.gmail.com/T/#t
> > > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > >
> > > Acked-by: Muchun Song <songmuchun@bytedance.com>
> > >
> > > Thanks.
> >
> > This improves things, but strictly speaking the write side also needs
> > WRITE_ONCE. Ordering is always a game of two. It's not possible to
> > order things on one side, if the other side messes up the ordering.
> >
>
> It looks like most other accesses use memcg_stock.stock_lock for
> synchronization. Based on the output of obj_stock_flush_required()
> we call drain_local_stock(), which acquires that lock as well. Should
> we refactor the code to extend the lock section to cover both
> obj_stock_flush_required() and drain_local_stock()?
>
> IIUC this may unify the synchronization handling and
> READ_ONCE/WRITE_ONCE may no longer be needed. This should also avoid
> any inaccuracies (e.g. unnecessary flushes) that may happen if the
> cached objcg changes between obj_stock_flush_required() and
> drain_local_stock().
>
> Did I miss anything here?

Yes, drain_local_stock only works on local cpu and
obj_stock_flush_required can touch the stock of all the cpus.

The patch is good but I agree with Dmitry that we should add the
WRITE_ONCE as well.
