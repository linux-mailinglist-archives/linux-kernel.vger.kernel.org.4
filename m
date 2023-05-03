Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A86F5C7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 19:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjECRFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjECRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 13:05:25 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B954D7A8A
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:04:42 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-24e16918391so1622323a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683133461; x=1685725461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=18yxqDd7XxHN3XYf5/zY3k5Z25g4GxczHaA3reGHgcY=;
        b=ZW2hSH2mP/IB7hviGGDymMYdIt0UHNc4Ik93MGfJ1WfR2Ql3k5TUBPyXmVUUpuwPPb
         ZPg0vd6Ci5J7YWkOv/O8ccU5hWIpKQIvGM8uv5VcbnkbTH1N290iEFTT8AMmwO4TzcEL
         dhO4q9GBAowjN2pVxPjJGrv8+WAWlygpWHWxl3tB3cp77Tv7gaNmWj0EvB/8/1uguuL5
         xsbXRtf4VlTCR+FZTDuT4ADJrYKEeUAbzJGi13lizjBxnpGfVPd4KY7Z3ZTQzDVr/9BB
         zHPXICVYEdW/W1LngvBsqCeKgFjmUGlE5cGlj5va6AsmpXVHyaGS9LaFhcW81ZkOq4kZ
         9r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683133461; x=1685725461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18yxqDd7XxHN3XYf5/zY3k5Z25g4GxczHaA3reGHgcY=;
        b=WVd1QLGNyTfehZxiV3k1p+ZPtY6YYKBBS8DnjI8wSVf44QMeBbn/rGm7Q4KtrrKVdW
         J4JaCHcBzMBG/GkMFfcb1nyitsP6K2p0nZKd7gew6EBMVuvd+hFTRkvp9L84fFaYfVIR
         ZmO52MWvkOB7Rdcgu8dDAzoUVX9C4z20mRSDBU7By+STO8iP6o6dif707qqROTLbbbuQ
         rtBRfRAhAs5vnAKXcv+VO4FVgk4tGjq9ajI0qKVLHYQ8Y2bsX/8duVxplDqm4BhhaPpg
         4AVIiYFRru2yOjsj0rIYXWnXFwoVtSBrUB5FlixPP4C02vjcZfUVOiK2X/XDE8q2Wypn
         4DcA==
X-Gm-Message-State: AC+VfDx9eMzEFnDbRVOtSc2xk3PApvx2EkYYCqGbzd0mTwe+6v8+vUaz
        fFLLYn4NgYXPDJJLLH4B1VvxEy8YcBSAIA==
X-Google-Smtp-Source: ACHHUZ4VuRHULVZY9fK6oBv5OfhLdxE1k9CTVUBudlUVDYy56pbnmFgcbwMFF5Vf6yiwqVO3KbfLp4gRD8bv1Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:6706:b0:24e:1b4:6f57 with SMTP id
 n6-20020a17090a670600b0024e01b46f57mr2915024pjj.8.1683133461227; Wed, 03 May
 2023 10:04:21 -0700 (PDT)
Date:   Wed, 3 May 2023 17:04:19 +0000
In-Reply-To: <20230502160839.361544-1-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20230502160839.361544-1-roman.gushchin@linux.dev>
Message-ID: <20230503170419.aedezirnlbtsaijv@google.com>
Subject: Re: [PATCH v2 1/2] mm: kmem: fix a NULL pointer dereference in obj_stock_flush_required()
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org,
        syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 09:08:38AM -0700, Roman Gushchin wrote:
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

Acked-by: Shakeel Butt <shakeelb@google.com>
