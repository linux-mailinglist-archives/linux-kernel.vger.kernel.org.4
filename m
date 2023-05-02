Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA96F4CC5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEBWLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjEBWLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:11:09 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3801FFF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:11:06 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso5845047a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 15:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683065465; x=1685657465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMksZkaGlpKMqsslbFNXZJQ62LtJSRzM3HzCusN12Ms=;
        b=xcEtWBcd2JAnnRup9l8GHssko4lY5Zfp9XqYRvhW6MqkW6YEMLPcbSEpSSjahyV8le
         v2OIrsQSxRaCe9DxR+bxAmwpOocg7p/oy0hRriipSkDhqzEr/PM9qB1GjgEwkHThb0Ww
         A42/qn/czzeBA3SvFNH8M0lE0nptHdKuTX9rIR87l43wKxcVrziW3XzAIa3Clm/M0Md9
         c8sx8zpf1Nzk+GbmiAVHxJE1+O2nlFPhboPou97tzoVmyjFx6lxdVRDtACLbaaQePlL6
         IGdSKlsSy6lBu3YhKVlD2WV19ohIHoLoHfnDgSLHn+6KRwaXL30j4OHdmmWki0CeIvBb
         ySvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683065465; x=1685657465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMksZkaGlpKMqsslbFNXZJQ62LtJSRzM3HzCusN12Ms=;
        b=gHXSzhZo2qMEnwr2AeRya+2B2cmnTJqwuQrzKmhHXd/ipjCjJPrTwceC+8tuR2XYv/
         /CMsdR/0rC2Ecm/bO98pg24QOnvZbpQgW18PPO3FG59hyYpiZNs/Sg20Hi/BACdVuDDv
         bYrNHkN/au3/ABmARbRcsK4eGPxCMvPyZVHevrBklZfrhsgco8ML4EjYIjtChFSt9fco
         199Jgr68JRIiqqo5NRj8SFySjOaV2YonMH4fNGVIZzgh/2Y0u3CI8ZY1fsjRB1y8oYSa
         4r6kZTqrhEo0v/io++X/qiZeZJmq8+uLUTcSVaNcjww7n7ajxpFfGTrsRrI1XcVxBfaq
         ot0w==
X-Gm-Message-State: AC+VfDxHmAg/ziDoerwz88sqtu/suzSEhyoap0gJDYgsw4wMZebdilAL
        k3BYwR9vkPnVkUQsseeCtiezMIfa0GSxah1CWt/JpA==
X-Google-Smtp-Source: ACHHUZ4TSvgIsqU6L5mrgHClztzRp2Icxk76FLea1y67tqvap8CZ1vg3n0Yq9kJA1ygzdOL480aWcVrzfFjXOkWvOPM=
X-Received: by 2002:aa7:cb87:0:b0:50b:d34c:4710 with SMTP id
 r7-20020aa7cb87000000b0050bd34c4710mr2844855edt.5.1683065464838; Tue, 02 May
 2023 15:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230502160839.361544-1-roman.gushchin@linux.dev>
 <CAJD7tkZ7Vnk6J9cJoj66wAUzmSeAopFpuXrtxZCsCtPCvvwzuQ@mail.gmail.com> <ZFGCy1d/wM+JC7xS@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZFGCy1d/wM+JC7xS@P9FQF9L96D.corp.robot.car>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 2 May 2023 15:10:28 -0700
Message-ID: <CAJD7tkZhRrtS3pBRC1xb46f7MTXnOhcok=QHQOiSgmXtoj5JWQ@mail.gmail.com>
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

On Tue, May 2, 2023 at 2:38=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> On Tue, May 02, 2023 at 01:15:02PM -0700, Yosry Ahmed wrote:
> > On Tue, May 2, 2023 at 9:09=E2=80=AFAM Roman Gushchin <roman.gushchin@l=
inux.dev> wrote:
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
> > > Fix it by using READ_ONCE()/WRITE_ONCE() for all accesses to
> > > stock->cached_objcg.
> >
> > I believe all read accesses other than obj_stock_flush_required() are
> > done under the lock, so READ_ONCE() wouldn't be needed AFAICT. Having
> > READ_ONCE() only around the racy read can be useful to document the
> > racy read and differentiate it from others.
> >
> > With that said, it's also inconvenient to keep track moving forward of
> > which reading sites are racy, and it may be simpler to just annotate
> > all readers with READ_ONCE().
> >
> > I am not sure which approach is better, just thinking out loud.
>
> Yeah, I wasn't sure either. I believe that all changes except the origina=
l
> READ_ONCE() are not leading to any meaningful asm changes, so it's a matt=
er
> of taste.
>
> The reason why I went with the "change them all" approach:
> reads without READ_ONCE() and subsequent writes with WRITE_ONCE()
> inside a single function looked really weird.
>

Agreed. It might be worth adding a comment somewhere documenting this.
It's not very hard to dig though, so whatever you think is best.

> >
> > >
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
> > > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > > Link:
> > > https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+SGFhT+jj=
m8k1P-a_8Kkxsjg@mail.gmail.com/T/#t
> > > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > With the above said, I don't feel strongly either way, the patch looks
> > good AFAICT:
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
> Thanks!
