Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFFE65ACC9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 02:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjABBk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 20:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABBk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 20:40:27 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D6E2196
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 17:40:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id c11so21520993qtn.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 17:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKe7CHdab8mIbJ0mMxRFBSBGuJHIvKXl4x/yHQ6F9DU=;
        b=HP16kw1SRu8lXjQXWvDQZ5OA3KVMBXOT92mtfFl2biLVpfyv8YLrWqfYnMuWB4APQN
         lg8caVYjHim/LXaljqp9LL+P3jmO3adVNToO6p4dBU+s0dmT35t+N7ycOn3e3Z82HxEg
         Ks8R+05VbCowFuYQoKbl6rQjy8OWtf1nfEKEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKe7CHdab8mIbJ0mMxRFBSBGuJHIvKXl4x/yHQ6F9DU=;
        b=EJRuAAIuCmMXNOhGQOtf+2CeeiRdrE6InRI+dGmdlBjwiLsJqGbjLEZlSzSI8R9jmc
         hhrQeWbzgOuPPY3CDhbdL61BQIS3AwCAJ/M6nAziIr7l+ZbJnCz//MwmtHWfVlLa6DHx
         9mahh3WyeEqYDWmOCSbWlRQ3kr9fwUhBJpgeYXUogppjxxjAZyquT/0gA4DJC5bdr+Lc
         tshRIBy/nV1XCeJAlOrW5kWTHtkng53h4AlvuNbeItaCb8VpjV5hQmXtGWF+3+DXkCxc
         0rFCyDjtzwBhxqnkbpexGs/+oYytXkH02iB8Uw4BM/ZZnH+ZzdZfcRRw2nzvLbRsGG9l
         a3xA==
X-Gm-Message-State: AFqh2kpbNLKRwooISVkFpvqCUK6/zMip0ivYMbWDq7MZLsHLtZDAICTW
        T2tsVN++0BblPqekD6+1qS8sff9Do/SbdWRT
X-Google-Smtp-Source: AMrXdXvSWbtX6z11/lTpD1jOS26TUEj/ekwxu6+UkXCrCEXbmlEnMZW3fpSm35RPt8D7lrCixVXirw==
X-Received: by 2002:a05:622a:450:b0:3a8:2d3d:7c51 with SMTP id o16-20020a05622a045000b003a82d3d7c51mr79853593qtx.33.1672623624955;
        Sun, 01 Jan 2023 17:40:24 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id q12-20020a05620a2a4c00b006fef61300fesm19988322qkp.16.2023.01.01.17.40.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 17:40:23 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id h10so18839570qvq.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 17:40:23 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr1841721qvv.130.1672623623525; Sun, 01
 Jan 2023 17:40:23 -0800 (PST)
MIME-Version: 1.0
References: <00000000000060d41f05f139aa44@google.com> <20230102005409.3474-1-hdanton@sina.com>
In-Reply-To: <20230102005409.3474-1-hdanton@sina.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 1 Jan 2023 17:40:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wim+_xutuWdeykqM34EQxbE3As7+91L5uEVLUCXbUL1CA@mail.gmail.com>
Message-ID: <CAHk-=wim+_xutuWdeykqM34EQxbE3As7+91L5uEVLUCXbUL1CA@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in do_user_addr_fault (3)
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 1, 2023 at 4:54 PM Hillf Danton <hdanton@sina.com> wrote:
>
> >  ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]

Something holds the ni_lock, so this process has blocked on it, and
this all happens inside mmap():

> >  attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
> >  ntfs_file_mmap+0x4cc/0x780 fs/ntfs3/file.c:296
> >  call_mmap include/linux/fs.h:2191 [inline]
> >  mmap_region+0x1022/0x1e60 mm/mmap.c:2621
> >  do_mmap+0x8d9/0xf30 mm/mmap.c:1411
> >  vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:520

so this code holds the mmapo_lock for writing, which is why all those
other processes are hung on getting it for reading for page faults
etc.

End result: ignore all those page fault processes, this mmap_lock ->
ni_lock explains them all, and they aren't the cause.

> >  folio_wait_bit_common+0x8ca/0x1390 mm/filemap.c:1297
> >  folio_lock include/linux/pagemap.h:938 [inline]
> >  truncate_inode_pages_range+0xc8d/0x1650 mm/truncate.c:421
> >  truncate_inode_pages mm/truncate.c:448 [inline]
> >  truncate_pagecache mm/truncate.c:743 [inline]
> >  truncate_setsize+0xcb/0xf0 mm/truncate.c:768
> >  ntfs_truncate fs/ntfs3/file.c:395 [inline]

.. and this thread is waiting on the page lock (well, folio, same
thing), and the IO apparently isn't completing.

And that seems to be because this one is busy reading the page, and
blocked on that same ni_lock:

> > task:syz-executor394 state:D stack:24072 pid:6048  ppid:5125   flags:0x00004004
> > Call Trace:
> >  <TASK>
> >  ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
> >  attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
> >  ntfs_get_block_vbo+0x374/0xd20 fs/ntfs3/inode.c:573
> >  do_mpage_readpage+0x98b/0x1bb0 fs/mpage.c:208
> >  mpage_read_folio+0x103/0x1d0 fs/mpage.c:379

But our debugging output looks a bit bogus:

> > Showing all locks held in the system:
> > 3 locks held by syz-executor394/5214:
> >  #0: ffff88801ee04460 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x61c/0xfd0 fs/read_write.c:1254
> >  #1: ffff888073930ca0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
> >  #1: ffff888073930ca0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_update_page+0x72/0x550 mm/filemap.c:2478
> >  #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
> >  #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919

It's showing 394/5214 as "holding" the lock, even though it's just
waiting for it - it's the one doing the readpage.

I think it's just because lockdep ends up adding the lock to the queue
before it actually gets the lock, so anybody pending will be shown as
"holding" it.

And the 5221 one:

> > 2 locks held by syz-executor394/5221:
> >  #0: ffff88802c7bc758 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
> >  #0: ffff88802c7bc758 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x18f/0x2f0 mm/util.c:518
> >  #1: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
> >  #1: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919

is that mmap() one, which is waiting for the ni_lock too (while
holding the mmap_sem, which is why the page faulters are all blocked).

But 5222 is is interesting, it is the truncate one, and it's waiting
for the page lock, and it really does seem to hold the ni_lock:

> > 3 locks held by syz-executor394/5222:
> >  #0: ffff88801ee04460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
> >  #1: ffff888073930b00 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
> >  #1: ffff888073930b00 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: do_truncate+0x205/0x300 fs/open.c:63
> >  #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
> >  #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_truncate fs/ntfs3/file.c:393 [inline]
> >  #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs3_setattr+0x596/0xca0 fs/ntfs3/file.c:696

So I think that we have:

 - ntfs_truncate()  gets the ni_lock (fs/ntfs3/file.c:393)

 - it then - while holding that lock - calls (on line 395):

      truncate_setsize ->
         truncate_pagecache ->
            truncate_inode_pages ->
               truncate_inode_pages_range ->
                  folio_lock

but that deadlocks on another process that wants to read that page,
and that needs ni_lock to do so.

So yes, it does look like a ntfs3 deadlock involving ni_lock.

Anyway, the above is just me trying to make sense of the call traces
and trying to cut out all the noise. I might have mis-read something.

             Linus
