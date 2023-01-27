Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8655067DE52
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 08:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjA0HNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 02:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjA0HNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 02:13:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC462A177
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:13:46 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id v17so859415lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 23:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EEP8zDO8ozCMtoU2yIakeJQoGjE9iQwgInKdAIy6pDg=;
        b=gulB2DE7bcTKsjtFe+5HYsLOYJ9dPG9ctoWfSUSj6VpyvPUNMo+hRjQJQgsEmzcXpA
         36XUVqyC5MNhrXfHIUGd2WnQkyJE/aGMu47RjmXexrsbYqsmrfup2P/JvW8AU/so2odc
         xFz0byhV5G6MYLNy3MftefHWfuIMV4gu2u1+QW/gU1k0JbaqvZkwdfOx2Mu6jNFKIDzc
         3QEvEwXSHsoIJrjMbG+RHO1BwxVk0vOwIfkHP7la7dbOZ9wzPygEd0FyOvGnhFR6K0h3
         YWGDHVq10uKDSGw71EmxEauhM+Am+/XYPh72oOYHJrO9gBLzgKk5dNzvj/Kqc2gkW1i/
         Z+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEP8zDO8ozCMtoU2yIakeJQoGjE9iQwgInKdAIy6pDg=;
        b=Ofe+QP3twbprj5XEzBT+LWMZc24UlwyjhLgp6AV7kswn3M7r3Qu4vy6JPvMW6SBEIq
         ZeeWh++c+GOlk8LTOwrEvgVxva8kgiSxysko5cf0zk2+eWjjH+e/e2Fau9IUnHU3PgJT
         ExAybnncRlj8lHpShYcZU9QU9t4n/g+gVI28meOCoeO+GBonKcfiE5gvXdZ9WuOpY9Ja
         izsNhkoWNoy+Jop2VL4pTklKVyB8XlgDtwUpCfwBHiPG8FLG+OX6EMuYK9Gx344ly6V3
         JO/J88ByoqJ5wc9QpmyiPUiFtmzsCeDM1lwpo9mHQnchVslbpEe/aKigRcdku11FUFry
         mrPg==
X-Gm-Message-State: AFqh2kqpsUoJyCI9OS9I/ITSbGGkiN2BnO2zCjn6XhXOLk64NfsFO2+3
        0a6DL8SvDOZiJ8tZxBxw+GswNeMQ8g+OIAePqUOnrg==
X-Google-Smtp-Source: AMrXdXumO8/cIDB7gh+5PwvZp8D4KEo+WwFV0tWafrpjxlJLWj+HXHeudV8I7pMsSVyMsv0lgj4AFY0w3alNIv6MOyo=
X-Received: by 2002:ac2:508f:0:b0:4cb:7c2:87ee with SMTP id
 f15-20020ac2508f000000b004cb07c287eemr3925867lfm.165.1674803625015; Thu, 26
 Jan 2023 23:13:45 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f6540d05f30bb23f@google.com> <20230126121905.toze65yum336s42p@quack3>
In-Reply-To: <20230126121905.toze65yum336s42p@quack3>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 Jan 2023 08:13:32 +0100
Message-ID: <CACT4Y+ZV0t9vSgwurRGDsOTdBQJO1ZyOA2s0JkgL1oKXchQjSA@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_set_handle (3)
To:     Jan Kara <jack@suse.cz>
Cc:     syzbot <syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023 at 13:19, Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Tue 24-01-23 16:27:36, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    edc00350d205 Merge tag 'block-6.2-2023-01-20' of git://git..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=134b1441480000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=899d86a7610a0ea0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=edce54daffee36421b4c
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+edce54daffee36421b4c@syzkaller.appspotmail.com
> >
> > ext4 filesystem being mounted at /syzkaller-testdir3627507797/syzkaller.9jT2hR/316/file0 supports timestamps until 2038 (0x7fffffff)
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.2.0-rc4-syzkaller-00350-gedc00350d205 #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.2/573 is trying to acquire lock:
> > ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/sched/mm.h:271 [inline]
> > ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slab.h:720 [inline]
> > ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:3434 [inline]
> > ffffffff8c8d4f60 (fs_reclaim){+.+.}-{0:0}, at: __kmem_cache_alloc_node+0x41/0x430 mm/slub.c:3491
> >
> > but task is already holding lock:
> > ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_write_lock_xattr fs/ext4/xattr.h:155 [inline]
> > ffff8880277eb2f0 (&ei->xattr_sem){++++}-{3:3}, at: ext4_xattr_set_handle+0x160/0x1510 fs/ext4/xattr.c:2305
> >
> > which lock already depends on the new lock.
>
> So I don't see how the below is ever possible:
>
> > -> #0 (fs_reclaim){+.+.}-{0:0}:
> >        check_prev_add kernel/locking/lockdep.c:3097 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3216 [inline]
> >        validate_chain kernel/locking/lockdep.c:3831 [inline]
> >        __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
> >        lock_acquire kernel/locking/lockdep.c:5668 [inline]
> >        lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
> >        __fs_reclaim_acquire mm/page_alloc.c:4674 [inline]
>
> So we are acquiring fs_reclaim here which means that
> current_gfp_context(gfp_mask) contained __GFP_FS...
>
> >        fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4688
> >        might_alloc include/linux/sched/mm.h:271 [inline]
> >        slab_pre_alloc_hook mm/slab.h:720 [inline]
> >        slab_alloc_node mm/slub.c:3434 [inline]
> >        __kmem_cache_alloc_node+0x41/0x430 mm/slub.c:3491
> >        __do_kmalloc_node mm/slab_common.c:967 [inline]
> >        __kmalloc_node+0x4d/0xd0 mm/slab_common.c:975
> >        kmalloc_node include/linux/slab.h:610 [inline]
> >        kvmalloc_node+0x76/0x1a0 mm/util.c:581
> >        kvmalloc include/linux/slab.h:737 [inline]
> >        ext4_xattr_inode_cache_find fs/ext4/xattr.c:1484 [inline]
> >        ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1527 [inline]
> >        ext4_xattr_set_entry+0x1d92/0x3a00 fs/ext4/xattr.c:1669
> >        ext4_xattr_block_set+0x61b/0x3000 fs/ext4/xattr.c:1906
> >        ext4_xattr_set_handle+0xd8a/0x1510 fs/ext4/xattr.c:2390
> >        ext4_xattr_set+0x144/0x360 fs/ext4/xattr.c:2492
>
> ... however here we've started a transaction so we should have
> PF_MEMALLOC_NOFS set?
>
> The only good explanation I have is that lockdep is mixing dependencies
> from an ext4 filesystem without a journal with dependencies created by
> filesystem with a journal. Since we have no reproducer, it's hard to
> tell.

Should the xattr_sem class be differentiated based on use/no-use of the journal?

> >        __vfs_setxattr+0x173/0x1e0 fs/xattr.c:202
> >        __vfs_setxattr_noperm+0x129/0x5f0 fs/xattr.c:236
> >        __vfs_setxattr_locked+0x1d3/0x260 fs/xattr.c:297
> >        vfs_setxattr+0x143/0x340 fs/xattr.c:323
> >        do_setxattr+0x151/0x190 fs/xattr.c:608
> >        setxattr+0x146/0x160 fs/xattr.c:631
> >        path_setxattr+0x197/0x1c0 fs/xattr.c:650
> >        __do_sys_setxattr fs/xattr.c:666 [inline]
> >        __se_sys_setxattr fs/xattr.c:662 [inline]
> >        __ia32_sys_setxattr+0xc0/0x160 fs/xattr.c:662
> >        do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
> >        __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
> >        do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
> >        entry_SYSENTER_compat_after_hwframe+0x70/0x82
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
