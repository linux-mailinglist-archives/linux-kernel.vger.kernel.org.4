Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6D5F4814
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJDRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDRMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:12:51 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA7F5C9C1
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:12:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 203so17525683ybc.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EmhBd/ixMNCkwruC6kr5MbMa9TbfRNFLbCf68YThMPU=;
        b=FYl2FxaMxfS+0aIiZ41P6XHDbibu9keioiITd+6lHtZI4K9ltTfu1IcwiEwBEzmyyt
         Sj2wTFejQrxknCOCx9FbTPPWvCjbFLc+nSjXsOV+r5O1RoUGUjZN5ZkopEj6Wuy6yTkP
         MpZKxV7HwkxEi3hNbQDwfNqqTSB4nRGw+RjDhMi0YAB5hUAIzGmr0e4clxEUJMKZodVa
         SEzGUEVAsb3CWlFrQSRimb9c2DjA/jR/yRyK0H6DSn5mE7QCCzmnzY4N9m5uC+YcHB3O
         J51aMxDkHw7wuN8u3gDLQZJcsR42+eko6XMgU1g6dEDP9JSs3pt/p9uZp+Flmnhy8M4t
         Juew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EmhBd/ixMNCkwruC6kr5MbMa9TbfRNFLbCf68YThMPU=;
        b=YsVbOifLy0OskGguKAs1yLNK1PieuwPbi/F0xPUjtPUM8ejCEnMmD31rbcFBS/Zn+U
         be5YCsc2zOTa2HmyssVbL/RUItBrfEGDNwreZpUv64OE/v8s6cjlKxnZRCQfGe0zbrb2
         ffNMMPnLEeKSTz/najpocxaQvB2EF6iXwIoYjvBaXcZH3QXXfrNKgHrfTHhmCW8ja2XP
         T1kjJBrxcl6c1L9Wc/E/3xVokEpS3IAR+b+qJq0ECN5FL1f+HVglk/weiDBjeba1MLM9
         DTbOySFNOSSR0dOdx1+qV81/04ALkMLhE/Incn67rKJRvNArzXrxXQbZ3Ah0ChhJTBIy
         YYDg==
X-Gm-Message-State: ACrzQf314OJLyQFns2I47uC0xcZTCqdMEFokezgrICSsMEvZ0xShW9ry
        eA8nusaXA8zf4jM3BvVLQUiEqrHd0vgy82clrnM=
X-Google-Smtp-Source: AMsMyM7UO9jexB/0usH2L3NfpRAol3kYJlpetMOHxNp94Hdw+mMtK0KsLpNu5wRmjm5HdElbWYnG8jo37IurptxqQJg=
X-Received: by 2002:a5b:90:0:b0:68e:26dd:c4a7 with SMTP id b16-20020a5b0090000000b0068e26ddc4a7mr26916194ybp.6.1664903569857;
 Tue, 04 Oct 2022 10:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221004001050.3269377-1-daeho43@gmail.com> <85cc583c-279c-2d65-4cfd-ebd54468c6f5@kernel.org>
In-Reply-To: <85cc583c-279c-2d65-4cfd-ebd54468c6f5@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 4 Oct 2022 10:12:38 -0700
Message-ID: <CACOAw_xR0sr3j=6v+7vqs77Hk=tZ3BqxKBFyKpawe_rpUJsf=Q@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: correct i_size change for atomic writes
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

On Tue, Oct 4, 2022 at 8:41 AM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/10/4 8:10, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We need to make sure i_size doesn't change until atomic write commit is
> > successful and restore it when commit is failed.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v3: make sure inode is clean while atomic writing
> > ---
> >   fs/f2fs/f2fs.h    |  1 +
> >   fs/f2fs/file.c    | 18 +++++++++++-------
> >   fs/f2fs/inode.c   |  3 +++
> >   fs/f2fs/segment.c |  4 +++-
> >   4 files changed, 18 insertions(+), 8 deletions(-)
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
> > +
> >       mark_inode_dirty_sync(inode);
> >   }
> >
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 460048f3c850..143b7ea0fb8e 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -193,8 +193,10 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
> >       if (!f2fs_is_atomic_file(inode))
> >               return;
> >
> > -     if (clean)
> > +     if (clean) {
> >               truncate_inode_pages_final(inode->i_mapping);
> > +             f2fs_i_size_write(inode, fi->original_i_size);
>
> inode has atomic_write flag, it can not be set dirtied here, how
> about writing i_size ater clear_inode_flag(inode, FI_ATOMIC_FILE)?

Oh, right.
Thanks~!

>
> Thanks,
>
> > +     }
> >       clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> >       iput(fi->cow_inode);
> >       fi->cow_inode = NULL;
