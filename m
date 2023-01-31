Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672C7683963
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjAaWez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAaWex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:34:53 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A75113E6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:34:51 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id e15so20068847ybn.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 14:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9XicOfcqqNM1itUQPV+dJJrN2wek/fukurDaOFYRQjg=;
        b=O123Q6cXminCjI73CghRhcOXwtBPGF5TF9pRKjAYVxKPux7jwzk7T1N9FKBGfNk2tA
         e8NfMB6QNXo2b3sFzPqxCAjAJNvkLyFKJruIBJq99DMpOPGGThHCv0QutZVekXror0e+
         efAI+tDJWSSkNlEVAQHh8S128Di9RH/e9wbheBsTxBQOcqzC0a4hpQne2HI5mImnW2hy
         T5kJMs8qRf3bCjgfPAx4yyr3VrSo/hbzDpG+WFDDfGFrs3MC4iRC6LFON7LCGhf5vgui
         XKSbdPLx9+OuuUlterm+6nubGA7UZI4ScnlqPaVm0foEQ2PoV1vzcRfTNAHkmhe/eLjF
         vo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9XicOfcqqNM1itUQPV+dJJrN2wek/fukurDaOFYRQjg=;
        b=WJJZk5TtxiBFcEIL/lUm9KLkrgiwifAoIXN51mHbXklmz7j6bqSeo+yGlpae977wS0
         mi9PqM4JmteO07puuIcu/JxOSUk/JpboOgnvq8lNMYLj5FDhQ9ApWTmCNRN4JizcPMsH
         Dx0NnjGLQl91NHmJoDaMJifLuPzhwKBSvZxiN4LI170zp3nTQXlOn07FehM1xRvl3P4J
         nGnchhpmMDhM08JKtcPSVRnmU5Ym0BM9M/Ko8FDjyxRb2JcUOA0ACgMyaXA7yqVbdsG7
         C5GoBPEq8PDP5+hMSi9fYMM87V+PcXJFdGzRdCrVQB6K9wD+4PXyqKVvXcsPXnPoHELY
         Frgg==
X-Gm-Message-State: AO0yUKV45/YJ05klcgVTen67PxcOQEW7ab1m8yrGywEJV5S5McGJQwbl
        aCkaejOwJCZsH+vr3mMoRq7HqP+uv7nvprMwrCk=
X-Google-Smtp-Source: AK7set9l6t98Dczae+ykcthjb6m3s0ZXQs2rquk1yT4RkLiMJsom83W+xPuSx/VY/hbkkQ5tj7D+tspsxq/1Q5fllvw=
X-Received: by 2002:a25:af4e:0:b0:80b:c92b:ed77 with SMTP id
 c14-20020a25af4e000000b0080bc92bed77mr72562ybj.205.1675204491043; Tue, 31 Jan
 2023 14:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20230113004933.2082072-1-daeho43@gmail.com> <ed5f65a7-13bb-581c-cfb5-df5ab30fbc4c@kernel.org>
 <CACOAw_zhVgS84gOXpfZuvptMgsZDhP3QX2EFm=5CoKibB+3V1A@mail.gmail.com>
 <8f1c15a3-d056-7709-af45-fe7cba56463f@kernel.org> <CACOAw_zSaZ5JKFtFSxRK3a5_260AYbeYCMzHL11pD8=mWM91Sw@mail.gmail.com>
 <CACOAw_xjNz2AKa+MMqpVKo4SOC_ptbXY1P3S4tY2g8JneTzkPQ@mail.gmail.com> <CACOAw_wUOv6GjiErE=m8vVHL8T9wzAe-TQ6=xYaNKWcoMaNDYw@mail.gmail.com>
In-Reply-To: <CACOAw_wUOv6GjiErE=m8vVHL8T9wzAe-TQ6=xYaNKWcoMaNDYw@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 31 Jan 2023 14:34:39 -0800
Message-ID: <CACOAw_w41sYTZnmJ6fMth_9YQJhcZbbQP9rdm2Ttz5uwhGPK9A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: synchronize atomic write aborts
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 1:57 PM Daeho Jeong <daeho43@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 1:38 PM Daeho Jeong <daeho43@gmail.com> wrote:
> >
> > On Tue, Jan 31, 2023 at 11:13 AM Daeho Jeong <daeho43@gmail.com> wrote:
> > >
> > > Hi Chao,
> > >
> > > On Tue, Jan 31, 2023 at 3:37 AM Chao Yu <chao@kernel.org> wrote:
> > > >
> > > > Hi Daeho,
> > > >
> > > > On 2023/1/31 0:34, Daeho Jeong wrote:
> > > > > Hi Chao,
> > > > >
> > > > > I read your patch series now and I like it.
> > > >
> > > > Thank you for checking the patches. :)
> > > >
> > > > > However, how about a race condition between start_atomic_write and
> > > > > abort_atomic_write?
> > > >
> > > > Yup, I noticed that issue, I guess we can avoid this race condition by
> > > > covering these two flows w/ i_atomic_sem.
> > > >
> > > > > abort_atomic_write is called without inode_lock in closing filp scenarios.
> > > > > What do you think about this?
> > > >
> > > > I'm fine w/ your change as it's more clean, but it's better to drop cow_inode's
> > > > page cache if atomic_write is committed or aborted to avoid caching obsolete page?
> > >
> > > It's better to put that part in f2fs_abort_atomic_write().
> > > On top of that, maybe, we should move
> > > f2fs_do_truncate_blocks(fi->cow_inode, 0, true) part from
> > > f2fs_ioc_start_atomic_write() to f2fs_abort_atomic_write(), too.
> >
> > Oh, we shouldn't touch the f2fs_do_truncate_blocks() part, since there
> > might be some left writeback after aborting atomic write.
> > Plz. review it related to the timing of calling truncate_inode_pages_final().
>
> Looks like the scenario becomes too complicated if I think about more
> than one writer's scenario.
> How about we check writecount in commit_atomic_write ioctl and return
> EBUSY when it's not only one writer?
> In that case, we can make the scenario simple and effective, and we
> can release all the resources in abort_atomic_write().

Oh, I totally forgot this. We don't use pages of COW inode. So, we
don't need to clean them up.

>
> >
> > >
> > > Thanks,
> > >
> > > >
> > > > Thanks,
> > > >
> > > > >
> > > > > Thanks,
> > > > >
> > > > >
> > > > > On Fri, Jan 27, 2023 at 6:07 PM Chao Yu <chao@kernel.org> wrote:
> > > > >>
> > > > >> Hi Daeho, Jaegeuk,
> > > > >>
> > > > >> Please take a look at patchset in below link:
> > > > >>
> > > > >> https://lore.kernel.org/linux-f2fs-devel/20230109034453.490176-1-chao@kernel.org/T/#t
> > > > >>
> > > > >> In PATCH 4/5, I'm trying to fix the same issue w/ alternative way, let me
> > > > >> know your preference. :)
> > > > >>
> > > > >> One comment as below.
> > > > >>
> > > > >> On 2023/1/13 8:49, Daeho Jeong wrote:
> > > > >>> From: Daeho Jeong <daehojeong@google.com>
> > > > >>>
> > > > >>> To fix a race condition between atomic write aborts, I use the inode
> > > > >>> lock and make COW inode to be re-usable thoroughout the whole
> > > > >>> atomic file inode lifetime.
> > > > >>>
> > > > >>> Reported-by: syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
> > > > >>> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> > > > >>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > > > >>> ---
> > > > >>>    fs/f2fs/file.c    | 43 ++++++++++++++++++++++++++++---------------
> > > > >>>    fs/f2fs/inode.c   | 11 +++++++++--
> > > > >>>    fs/f2fs/segment.c |  3 ---
> > > > >>>    fs/f2fs/super.c   |  2 --
> > > > >>>    4 files changed, 37 insertions(+), 22 deletions(-)
> > > > >>>
> > > > >>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > >>> index ecbc8c135b49..ff072a9ed258 100644
> > > > >>> --- a/fs/f2fs/file.c
> > > > >>> +++ b/fs/f2fs/file.c
> > > > >>> @@ -1866,7 +1866,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
> > > > >>>                        atomic_read(&inode->i_writecount) != 1)
> > > > >>>                return 0;
> > > > >>>
> > > > >>> +     inode_lock(inode);
> > > > >>>        f2fs_abort_atomic_write(inode, true);
> > > > >>> +     inode_unlock(inode);
> > > > >>> +
> > > > >>>        return 0;
> > > > >>>    }
> > > > >>>
> > > > >>> @@ -1880,8 +1883,11 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
> > > > >>>         * until all the writers close its file. Since this should be done
> > > > >>>         * before dropping file lock, it needs to do in ->flush.
> > > > >>>         */
> > > > >>> -     if (F2FS_I(inode)->atomic_write_task == current)
> > > > >>> +     if (F2FS_I(inode)->atomic_write_task == current) {
> > > > >>> +             inode_lock(inode);
> > > > >>>                f2fs_abort_atomic_write(inode, true);
> > > > >>> +             inode_unlock(inode);
> > > > >>> +     }
> > > > >>>        return 0;
> > > > >>>    }
> > > > >>>
> > > > >>> @@ -2087,19 +2093,28 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
> > > > >>>                goto out;
> > > > >>>        }
> > > > >>>
> > > > >>> -     /* Create a COW inode for atomic write */
> > > > >>> -     pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> > > > >>> -     if (IS_ERR(pinode)) {
> > > > >>> -             f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > > >>> -             ret = PTR_ERR(pinode);
> > > > >>> -             goto out;
> > > > >>> -     }
> > > > >>> +     /* Check if the inode already has a COW inode */
> > > > >>> +     if (fi->cow_inode == NULL) {
> > > > >>> +             /* Create a COW inode for atomic write */
> > > > >>> +             pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> > > > >>> +             if (IS_ERR(pinode)) {
> > > > >>> +                     f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > > >>> +                     ret = PTR_ERR(pinode);
> > > > >>> +                     goto out;
> > > > >>> +             }
> > > > >>>
> > > > >>> -     ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
> > > > >>> -     iput(pinode);
> > > > >>> -     if (ret) {
> > > > >>> -             f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > > >>> -             goto out;
> > > > >>> +             ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
> > > > >>> +             iput(pinode);
> > > > >>> +             if (ret) {
> > > > >>> +                     f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > > > >>> +                     goto out;
> > > > >>> +             }
> > > > >>> +
> > > > >>> +             set_inode_flag(fi->cow_inode, FI_COW_FILE);
> > > > >>> +             clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> > > > >>> +     } else {
> > > > >>> +             /* Reuse the already created COW inode */
> > > > >>> +             f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> > > > >>>        }
> > > > >>>
> > > > >>>        f2fs_write_inode(inode, NULL);
> > > > >>> @@ -2107,8 +2122,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
> > > > >>>        stat_inc_atomic_inode(inode);
> > > > >>>
> > > > >>>        set_inode_flag(inode, FI_ATOMIC_FILE);
> > > > >>> -     set_inode_flag(fi->cow_inode, FI_COW_FILE);
> > > > >>> -     clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> > > > >>>
> > > > >>>        isize = i_size_read(inode);
> > > > >>>        fi->original_i_size = isize;
> > > > >>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > > > >>> index ff6cf66ed46b..4921f7209e28 100644
> > > > >>> --- a/fs/f2fs/inode.c
> > > > >>> +++ b/fs/f2fs/inode.c
> > > > >>> @@ -766,11 +766,18 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
> > > > >>>    void f2fs_evict_inode(struct inode *inode)
> > > > >>>    {
> > > > >>>        struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > > > >>> -     nid_t xnid = F2FS_I(inode)->i_xattr_nid;
> > > > >>> +     struct f2fs_inode_info *fi = F2FS_I(inode);
> > > > >>> +     nid_t xnid = fi->i_xattr_nid;
> > > > >>>        int err = 0;
> > > > >>>
> > > > >>>        f2fs_abort_atomic_write(inode, true);
> > > > >>>
> > > > >>> +     if (fi->cow_inode) {
> > > > >>> +             clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> > > > >>> +             iput(fi->cow_inode);
> > > > >>> +             fi->cow_inode = NULL;
> > > > >>> +     }
> > > > >>> +
> > > > >>>        trace_f2fs_evict_inode(inode);
> > > > >>>        truncate_inode_pages_final(&inode->i_data);
> > > > >>>
> > > > >>> @@ -857,7 +864,7 @@ void f2fs_evict_inode(struct inode *inode)
> > > > >>>        stat_dec_inline_inode(inode);
> > > > >>>        stat_dec_compr_inode(inode);
> > > > >>>        stat_sub_compr_blocks(inode,
> > > > >>> -                     atomic_read(&F2FS_I(inode)->i_compr_blocks));
> > > > >>> +                     atomic_read(&fi->i_compr_blocks));
> > > > >>>
> > > > >>>        if (likely(!f2fs_cp_error(sbi) &&
> > > > >>>                                !is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> > > > >>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > >>> index ae3c4e5474ef..536d7c674b04 100644
> > > > >>> --- a/fs/f2fs/segment.c
> > > > >>> +++ b/fs/f2fs/segment.c
> > > > >>> @@ -192,9 +192,6 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
> > > > >>>        if (!f2fs_is_atomic_file(inode))
> > > > >>>                return;
> > > > >>>
> > > > >>> -     clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> > > > >>> -     iput(fi->cow_inode);
> > > > >>> -     fi->cow_inode = NULL;
> > > > >>>        release_atomic_write_cnt(inode);
> > > > >>>        clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
> > > > >>>        clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> > > > >>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > >>> index 1f812b9ce985..10463f084d30 100644
> > > > >>> --- a/fs/f2fs/super.c
> > > > >>> +++ b/fs/f2fs/super.c
> > > > >>> @@ -1430,8 +1430,6 @@ static int f2fs_drop_inode(struct inode *inode)
> > > > >>>                        atomic_inc(&inode->i_count);
> > > > >>>                        spin_unlock(&inode->i_lock);
> > > > >>>
> > > > >>> -                     f2fs_abort_atomic_write(inode, true);
> > > > >>
> > > > >> In order to avoid caching obsolete page of cow_inode, how about truncating
> > > > >> them here?
> > > > >>
> > > > >> if (f2fs_is_atomic_file() && cow_inode)
> > > > >>          truncate_inode_pages_final(&cow_inode->i_data);
> > > > >>
> > > > >> Thanks,
> > > > >>
> > > > >>> -
> > > > >>>                        /* should remain fi->extent_tree for writepage */
> > > > >>>                        f2fs_destroy_extent_node(inode);
> > > > >>>
