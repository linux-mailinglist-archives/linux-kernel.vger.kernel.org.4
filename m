Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD835F57FE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJEQGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiJEQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:06:34 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC057C19C
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:06:29 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-35befab86a4so46878407b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3RXcLqDmCgIFL8gLf0wf2YJeFQ92noy1tBQH2aFBIYg=;
        b=Y585obsPPaAtDNEx9rHoaMZPT3x1NomuEgcnNXwP6ApTZkaXB+Swymb+6iuWYNRmOt
         mpWtcl9iNUKNRM0HhyqNcb1cQUFJVkiRuxmOryHmgMKoSCujBkHokSaoKc1gwqLznFO2
         cly2DlOyBJWf+AvwFBfothOTJDa+sHeunmNYJIU5ybvT1OWAdpiISG+2i/0Zb5ytYh2Q
         S2FTXYo5goPjrFYd6PPE/nzrJDwMrv6BhoecWGuHWw8LA3Oy9bk9WRXzr3Mg7DdEwILG
         4BorW8GX8hLyMuK5RiYWuBknrmzHanAvrsZhXevbroXFffgD0AOWybtavFK8AjjPBTcY
         M+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3RXcLqDmCgIFL8gLf0wf2YJeFQ92noy1tBQH2aFBIYg=;
        b=2REiSuN4WjI92tr2S4ih3dTiH2fK/OrFiVpqx3899ERZ7ZoSffICqTIwiqFzAr+TtC
         DOgVR/0a4OkU+5jG/e2aq604mRnq18qly8bdG4pqihLln26Cde9rZcWLhMTqXZKe5a0Z
         F4rytiRgNjjaZJ/b6Vy2/H8h1y96+/uLAFpXxkka1HPeB7TGCgYv2YJA3ahdYyV1SQaU
         dM2oQVneF6KkMjxg5u2r0aY8vgU9vbCcLflqEL1ZfbpquXZYtrPn2qfBQWLQhZ7K/gql
         TL2wPPH2il9URPvkkHmlLwPFvyDpEC7TvfWgIfgTlYiPd2Y5RmSQskHn0WCxOfjYVm/v
         qeew==
X-Gm-Message-State: ACrzQf1JWgefgXFxx79u3nRzZq6geoBipOwIfnCA37gW0F3EOF8CCbcz
        Jo5dagM0G45AorIbveKLZklmCE22eECOl20eLTI=
X-Google-Smtp-Source: AMsMyM5I/FBWvG0Oig+1lhQmFr1I8wjY7qbXxB9cqqKTFzhUx5hCG7mjnTUyqcaOivXUau8XPb9CxFlyhCyqSOLZAxE=
X-Received: by 2002:a81:c20d:0:b0:356:c9d4:26b with SMTP id
 z13-20020a81c20d000000b00356c9d4026bmr413020ywc.251.1664985988727; Wed, 05
 Oct 2022 09:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221004171351.3678194-1-daeho43@gmail.com> <b1ca9048-99c5-1ab4-fb77-5fe0bbc6d4de@kernel.org>
In-Reply-To: <b1ca9048-99c5-1ab4-fb77-5fe0bbc6d4de@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 5 Oct 2022 09:06:17 -0700
Message-ID: <CACOAw_zXTHzc5mjPchGNXkgnswZLxLEBfRoEztB7VFdV-rtpwQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: correct i_size change for atomic writes
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
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

On Wed, Oct 5, 2022 at 6:46 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/10/5 1:13, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We need to make sure i_size doesn't change until atomic write commit is
> > successful and restore it when commit is failed.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v4: move i_size update after clearing atomic file flag in
> >      f2fs_abort_atomic_write()
> > v3: make sure inode is clean while atomic writing
> > ---
> >   fs/f2fs/f2fs.h    |  1 +
> >   fs/f2fs/file.c    | 18 +++++++++++-------
> >   fs/f2fs/inode.c   |  3 +++
> >   fs/f2fs/segment.c |  7 +++++--
> >   4 files changed, 20 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index dee7b67a17a6..539da7f12cfc 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -821,6 +821,7 @@ struct f2fs_inode_info {
> >       unsigned int i_cluster_size;            /* cluster size */
> >
> >       unsigned int atomic_write_cnt;
> > +     loff_t original_i_size;         /* original i_size before atomic write */
> >   };
> >
> >   static inline void get_extent_info(struct extent_info *ext,
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 5efe0e4a725a..ce2336d2f688 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1989,6 +1989,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >       struct f2fs_inode_info *fi = F2FS_I(inode);
> >       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >       struct inode *pinode;
> > +     loff_t isize;
> >       int ret;
> >
> >       if (!inode_owner_or_capable(mnt_userns, inode))
> > @@ -2047,7 +2048,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >               f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> >               goto out;
> >       }
> > -     f2fs_i_size_write(fi->cow_inode, i_size_read(inode));
> > +
> > +     f2fs_write_inode(inode, NULL);
> > +
> > +     isize = i_size_read(inode);
> > +     fi->original_i_size = isize;
> > +     f2fs_i_size_write(fi->cow_inode, isize);
> >
> >       spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >       sbi->atomic_files++;
> > @@ -2087,16 +2093,14 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
> >
> >       if (f2fs_is_atomic_file(inode)) {
> >               ret = f2fs_commit_atomic_write(inode);
> > -             if (ret)
> > -                     goto unlock_out;
> > -
> > -             ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
> >               if (!ret)
> > -                     f2fs_abort_atomic_write(inode, false);
> > +                     ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
> > +
> > +             f2fs_abort_atomic_write(inode, ret);
> >       } else {
> >               ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
> >       }
> > -unlock_out:
> > +
> >       inode_unlock(inode);
> >       mnt_drop_write_file(filp);
> >       return ret;
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index cde0a3dc80c3..64d7772b4cd9 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -30,6 +30,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
> >       if (f2fs_inode_dirtied(inode, sync))
> >               return;
> >
> > +     if (f2fs_is_atomic_file(inode))
> > +             return;
>
> One question, after f2fs_inode_dirtied(), atomic_file is added to
> inode_list[DIRTY_META], and it will be flushed by checkpoint()
> triggered in between write() and atomic_commit ioctl, is it not
> expected that inode w/ new i_size will be persisted?

Isn't it okay if we move f2fs_is_atomic_file() ahead of f2fs_inode_dirtied()?

>
> Should write_end() skip updating atomic_file's i_size and let
> atomic_commit() update it if there is no error?

In this case, the user can't see the changed i_size while writing an
atomic file.

>
> Thanks,
>
> > +
> >       mark_inode_dirty_sync(inode);
> >   }
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 460048f3c850..abb55cd418c1 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -193,14 +193,17 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
> >       if (!f2fs_is_atomic_file(inode))
> >               return;
> >
> > -     if (clean)
> > -             truncate_inode_pages_final(inode->i_mapping);
> >       clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> >       iput(fi->cow_inode);
> >       fi->cow_inode = NULL;
> >       release_atomic_write_cnt(inode);
> >       clear_inode_flag(inode, FI_ATOMIC_FILE);
> >
> > +     if (clean) {
> > +             truncate_inode_pages_final(inode->i_mapping);
> > +             f2fs_i_size_write(inode, fi->original_i_size);
> > +     }
> > +
> >       spin_lock(&sbi->inode_lock[ATOMIC_FILE]);
> >       sbi->atomic_files--;
> >       spin_unlock(&sbi->inode_lock[ATOMIC_FILE]);
