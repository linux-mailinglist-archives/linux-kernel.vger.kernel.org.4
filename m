Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE8169518C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBMUO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjBMUOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:14:48 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A2558B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:14:46 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-52f1b1d08c2so54144137b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DVBZe7FHVHxsSQIXf3WpSgVuZprABFUjQYlhoNVCR64=;
        b=DXYXMqkm9VM+ixvfhyWjwEU7GB98j2w3mIeX9aKCNqrfnONjizGGw2SdHddg8N5tl2
         E00LrwudUDCFtOPc0zaWWLwicR7UrqVht+HK+GRWItmnZjBW4llgaIGym59BdZTGXqOJ
         e9EnkR5F8L8fUGjaTiN9/IPXVLCuku46pLbcXOkWiidFwHUrCwal3eo+tahWe9fjmCOg
         xm27drN0CQYRtQcCskcmeSAmnDeXv7J9AZPOIyL7vWsz81xG5zyNBT1ldsXNADD0eZOv
         6Pk3rj9F69fAsWajh1bXsI4+yiDErEaOz0GgUsM6qZlA8UlZmr/uud9aWeF5a2TkpKjQ
         ztMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVBZe7FHVHxsSQIXf3WpSgVuZprABFUjQYlhoNVCR64=;
        b=jYHcQTeWn2gAiwQ9zmaezLwR0BvU+aWpdNautOMyUTT5XGVANO0n7tIUPuXHN2JkEd
         cmSpZkEw0ZHKpyvpB5wCzxLNBJPIHQl+kzIPxcH1wBgi4QfaOOMfHneuu+HuWBaYG+a0
         MmuhXKFG7VNK6CEc3oFtftSZrUexslwxvTyoBkJzwf7xxOlnvjGSTPTkLCKh3AMPXj1u
         8Ss5iCkkeyMDVEA2FDr1acqgw1dJnxPWaPtsku5RLe3h7RCPqRS0TsCvGsfWVRudoAO2
         Cgb/zhUESjGoJBMq1CY5m40weCz62fzitgVN3VSLsVVt+1oozBxCKI6MZp5Botos5a6D
         sitw==
X-Gm-Message-State: AO0yUKXj/V53QpyWE+eZ0pgpF7D3qEiLcxIDKcDUltQQSbNSQ7JFaVPv
        vSv4frixFUgPxlKqHuE5NuT2HIQ41V7K63L6WJw=
X-Google-Smtp-Source: AK7set+r5/WDZDUysolD6CVwopt5Ni7Zs7kVqgz/wqaChX0iJ5QDirFJk362e+g/2RSK1kXsahvaBzfaO+ig/BwhnzA=
X-Received: by 2002:a0d:d48e:0:b0:52f:b76:e21d with SMTP id
 w136-20020a0dd48e000000b0052f0b76e21dmr857600ywd.493.1676319286021; Mon, 13
 Feb 2023 12:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20230209181819.2333522-1-daeho43@gmail.com> <18916dd5-67cc-fe21-f78b-8a6dfbcb1c97@kernel.org>
In-Reply-To: <18916dd5-67cc-fe21-f78b-8a6dfbcb1c97@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 13 Feb 2023 12:14:34 -0800
Message-ID: <CACOAw_w5Mc3aqS_RD_W7MdLGFQV3O_Jq1WSAVKAxJkEk5uUgeQ@mail.gmail.com>
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

On Mon, Feb 13, 2023 at 1:47 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2023/2/10 2:18, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > To fix a race condition between atomic write aborts, I use the inode
> > lock and make COW inode to be re-usable thoroughout the whole
> > atomic file inode lifetime.
> >
> > Reported-by: syzbot+823000d23b3400619f7c@syzkaller.appspotmail.com
> > Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> >   fs/f2fs/file.c    | 44 +++++++++++++++++++++++++++++---------------
> >   fs/f2fs/inode.c   | 11 +++++++++--
> >   fs/f2fs/segment.c |  3 ---
> >   fs/f2fs/super.c   |  2 --
> >   4 files changed, 38 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 300eae8b5415..6436c52e7913 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1863,7 +1863,10 @@ static int f2fs_release_file(struct inode *inode, struct file *filp)
> >                       atomic_read(&inode->i_writecount) != 1)
> >               return 0;
> >
> > +     inode_lock(inode);
> >       f2fs_abort_atomic_write(inode, true);
> > +     inode_unlock(inode);
> > +
> >       return 0;
> >   }
> >
> > @@ -1878,8 +1881,12 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
> >        * before dropping file lock, it needs to do in ->flush.
> >        */
> >       if (F2FS_I(inode)->atomic_write_task == current &&
> > -                             (current->flags & PF_EXITING))
> > +                             (current->flags & PF_EXITING)) {
> > +             inode_lock(inode);
> >               f2fs_abort_atomic_write(inode, true);
> > +             inode_unlock(inode);
> > +     }
> > +
> >       return 0;
> >   }
> >
> > @@ -2085,19 +2092,28 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
> >               goto out;
> >       }
> >
> > -     /* Create a COW inode for atomic write */
> > -     pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> > -     if (IS_ERR(pinode)) {
> > -             f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > -             ret = PTR_ERR(pinode);
> > -             goto out;
> > -     }
> > +     /* Check if the inode already has a COW inode */
> > +     if (fi->cow_inode == NULL) {
> > +             /* Create a COW inode for atomic write */
> > +             pinode = f2fs_iget(inode->i_sb, fi->i_pino);
> > +             if (IS_ERR(pinode)) {
> > +                     f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > +                     ret = PTR_ERR(pinode);
> > +                     goto out;
> > +             }
> >
> > -     ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
> > -     iput(pinode);
> > -     if (ret) {
> > -             f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > -             goto out;
> > +             ret = f2fs_get_tmpfile(mnt_userns, pinode, &fi->cow_inode);
> > +             iput(pinode);
> > +             if (ret) {
> > +                     f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> > +                     goto out;
> > +             }
> > +
> > +             set_inode_flag(fi->cow_inode, FI_COW_FILE);
> > +             clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> > +     } else {
> > +             /* Reuse the already created COW inode */
> > +             f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
> >       }
> >
> >       f2fs_write_inode(inode, NULL);
> > @@ -2105,8 +2121,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
> >       stat_inc_atomic_inode(inode);
> >
> >       set_inode_flag(inode, FI_ATOMIC_FILE);
> > -     set_inode_flag(fi->cow_inode, FI_COW_FILE);
> > -     clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
> >
> >       isize = i_size_read(inode);
> >       fi->original_i_size = isize;
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index 28c9c72dda2a..7bf660d4cad9 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -777,11 +777,18 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
> >   void f2fs_evict_inode(struct inode *inode)
> >   {
> >       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> > -     nid_t xnid = F2FS_I(inode)->i_xattr_nid;
> > +     struct f2fs_inode_info *fi = F2FS_I(inode);
> > +     nid_t xnid = fi->i_xattr_nid;
> >       int err = 0;
> >
> >       f2fs_abort_atomic_write(inode, true);
> >
> > +     if (fi->cow_inode) {
> > +             clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> > +             iput(fi->cow_inode);
> > +             fi->cow_inode = NULL;
> > +     }
>
> It looks "fi->cow_inode = NULL" here may race w/ cow_inode allocation in
> f2fs_ioc_start_atomic_write due to f2fs_write_inode() has not been covered
> by inode_lock()? IIUC.

Sorry, I couldn't understand it, since I couldn't find any relation
between f2fs_ioc_start_atomic_write and f2fs_write_inode. Could you
elaborate more on this? I thought the code might be safe, since it
happens in the inode eviction phase.

>
> Thanks,
>
> > +
> >       trace_f2fs_evict_inode(inode);
> >       truncate_inode_pages_final(&inode->i_data);
> >
> > @@ -866,7 +873,7 @@ void f2fs_evict_inode(struct inode *inode)
> >       stat_dec_inline_inode(inode);
> >       stat_dec_compr_inode(inode);
> >       stat_sub_compr_blocks(inode,
> > -                     atomic_read(&F2FS_I(inode)->i_compr_blocks));
> > +                     atomic_read(&fi->i_compr_blocks));
> >
> >       if (likely(!f2fs_cp_error(sbi) &&
> >                               !is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index ead3f35f501d..719329c1808c 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -192,9 +192,6 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
> >       if (!f2fs_is_atomic_file(inode))
> >               return;
> >
> > -     clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> > -     iput(fi->cow_inode);
> > -     fi->cow_inode = NULL;
> >       release_atomic_write_cnt(inode);
> >       clear_inode_flag(inode, FI_ATOMIC_COMMITTED);
> >       clear_inode_flag(inode, FI_ATOMIC_REPLACE);
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index c11a161ba5be..aa55dc12aff2 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1427,8 +1427,6 @@ static int f2fs_drop_inode(struct inode *inode)
> >                       atomic_inc(&inode->i_count);
> >                       spin_unlock(&inode->i_lock);
> >
> > -                     f2fs_abort_atomic_write(inode, true);
> > -
> >                       /* should remain fi->extent_tree for writepage */
> >                       f2fs_destroy_extent_node(inode);
> >
