Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D906EBC66
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 04:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjDWC0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 22:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDWC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 22:26:12 -0400
Received: from out-7.mta1.migadu.com (out-7.mta1.migadu.com [95.215.58.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA61BE6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 19:26:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682216764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9lnSDSMiuWlEO4inLpvRSFv7RXG1ZzDGKnyzsTUCPA=;
        b=dItySq3rz8cULMxwosDDaVgN6iLxhZgPt0EG2BixAS5pY7rnPff5MchmNh+jUS9NK5vP7u
        5tGC1X9sFBnqF3DuoIy5CxNvnxiJ+WFa2GFQ/+qOMMnzBS/YHY7FM3vy/2fVpcJTfSLGHH
        j5yJFUmAxL346KQAjBWVfdkrpN2WRnU=
MIME-Version: 1.0
Subject: Re: [PATCH] mm: kmem: fix a NULL pointer dereference in
 obj_stock_flush_required()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230421174054.3434533-1-roman.gushchin@linux.dev>
Date:   Sun, 23 Apr 2023 10:25:58 +0800
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org,
        syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB1562BC-CAD0-45B4-8C6D-92E583C128DF@linux.dev>
References: <00000000000058b63f05f9d98811@google.com>
 <20230421174054.3434533-1-roman.gushchin@linux.dev>
To:     Roman Gushchin <roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 22, 2023, at 01:40, Roman Gushchin <roman.gushchin@linux.dev> =
wrote:
>=20
> KCSAN found an issue in obj_stock_flush_required():
> stock->cached_objcg can be reset between the check and dereference:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in drain_all_stock / drain_obj_stock
>=20
> write to 0xffff888237c2a2f8 of 8 bytes by task 19625 on cpu 0:
> drain_obj_stock+0x408/0x4e0 mm/memcontrol.c:3306
> refill_obj_stock+0x9c/0x1e0 mm/memcontrol.c:3340
> obj_cgroup_uncharge+0xe/0x10 mm/memcontrol.c:3408
> memcg_slab_free_hook mm/slab.h:587 [inline]
> __cache_free mm/slab.c:3373 [inline]
> __do_kmem_cache_free mm/slab.c:3577 [inline]
> kmem_cache_free+0x105/0x280 mm/slab.c:3602
> __d_free fs/dcache.c:298 [inline]
> dentry_free fs/dcache.c:375 [inline]
> __dentry_kill+0x422/0x4a0 fs/dcache.c:621
> dentry_kill+0x8d/0x1e0
> dput+0x118/0x1f0 fs/dcache.c:913
> __fput+0x3bf/0x570 fs/file_table.c:329
> ____fput+0x15/0x20 fs/file_table.c:349
> task_work_run+0x123/0x160 kernel/task_work.c:179
> resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> exit_to_user_mode_loop+0xcf/0xe0 kernel/entry/common.c:171
> exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:203
> __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
> syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:296
> do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> read to 0xffff888237c2a2f8 of 8 bytes by task 19632 on cpu 1:
> obj_stock_flush_required mm/memcontrol.c:3319 [inline]
> drain_all_stock+0x174/0x2a0 mm/memcontrol.c:2361
> try_charge_memcg+0x6d0/0xd10 mm/memcontrol.c:2703
> try_charge mm/memcontrol.c:2837 [inline]
> mem_cgroup_charge_skmem+0x51/0x140 mm/memcontrol.c:7290
> sock_reserve_memory+0xb1/0x390 net/core/sock.c:1025
> sk_setsockopt+0x800/0x1e70 net/core/sock.c:1525
> udp_lib_setsockopt+0x99/0x6c0 net/ipv4/udp.c:2692
> udp_setsockopt+0x73/0xa0 net/ipv4/udp.c:2817
> sock_common_setsockopt+0x61/0x70 net/core/sock.c:3668
> __sys_setsockopt+0x1c3/0x230 net/socket.c:2271
> __do_sys_setsockopt net/socket.c:2282 [inline]
> __se_sys_setsockopt net/socket.c:2279 [inline]
> __x64_sys_setsockopt+0x66/0x80 net/socket.c:2279
> do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
>=20
> value changed: 0xffff8881382d52c0 -> 0xffff888138893740
>=20
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 19632 Comm: syz-executor.0 Not tainted =
6.3.0-rc2-syzkaller-00387-g534293368afa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 03/02/2023
>=20
> Fix it by reading the cached_objcg with READ_ONCE().
>=20
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Reported-by: syzbot+774c29891415ab0fd29d@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: =
https://lore.kernel.org/linux-mm/CACT4Y+ZfucZhM60YPphWiCLJr6+SGFhT+jjm8k1P=
-a_8Kkxsjg@mail.gmail.com/T/#t
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

