Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A80613D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJaShV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJaShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:37:20 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9912626
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:37:19 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 185so14740587ybc.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uYvB3MdHGb4WqcG5KWsuFiuDCNd6Mkda7w7kVNhi+P8=;
        b=a4U2ZgrYOij8m1lXlDkkiecnJRNlYfS96MWm78NAox/Il5678GohDKdDHWGlszW6Iy
         plnq8tYSj8qcrvVPxEjYuavvrrWSiB4hqZFoMYJ/+wntH+Zfy0ckC1zSnZ4gIwqIDUgr
         Mg2QJEv5YGQlOzK7ipb3qzTw3vjLGT3zvyOBgWChzydA4doJ35ralelspo5luQhYajD+
         nevuDjxyB7ECVPY/NeXEj08d3eWoAmsKrh9qA7SSCid0pJnLoTyOb3/Uu5MRq6KOihJU
         PTrNnBn3FsUgjI59Shlh6YpqekBUwAELSNBg8DJePwd+EoLwpyk/OVaxK8+R/3uCjLsq
         Bf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYvB3MdHGb4WqcG5KWsuFiuDCNd6Mkda7w7kVNhi+P8=;
        b=4xKnTSspvaKCJJ7H21iElenfRdpuyh2v8ssIL0c6KdreMcNmFIQTqBh7RFAcfUc+hC
         GPqtoBOnvvqtZV6Z29AH6DVVfy6XMQZtsfGF4ebEIfQ7mwirkkV7R8SKys7bVhiSVMcE
         NitJfpCkltYijdzhAnBssw+FPsrjybWSxGrgz2u/R3vjkChE6F8ANQwneXtwElz6KitU
         MQyIXeWJ5OmTklYkUO+Ducia+U68oxfNShVZdC5l5qUCnIicSSYugAVT5gc5ipGchwqt
         2wbSjSTtEV47iurVqh17uXkR9EjB+xPB+CmoZSPmXWQIqFxdF2Dei/E5ci7/JvpEW9HB
         cARA==
X-Gm-Message-State: ACrzQf0whoIHgxivoO00R1+kMIAfLQ+VifHXeNPxlLQM9VRLSI84WRAf
        nsH+R4++v3pyGKw3w42lgIWjVxYdWFwmZKqNVxI=
X-Google-Smtp-Source: AMsMyM40F+9hLV6kHwc6e4BnozkJVXLAS8bG+Kzkej67VudzhaWzpSLx4XJzBD0tB7NAfLUY4XtqCshm6RjHB6CRvmw=
X-Received: by 2002:a5b:842:0:b0:6a3:cf26:755d with SMTP id
 v2-20020a5b0842000000b006a3cf26755dmr13030281ybq.608.1667241438095; Mon, 31
 Oct 2022 11:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221018170017.672824-1-daeho43@gmail.com> <4bbefd79-7f01-efc3-7c7e-339a8d5d9952@kernel.org>
In-Reply-To: <4bbefd79-7f01-efc3-7c7e-339a8d5d9952@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 31 Oct 2022 11:37:07 -0700
Message-ID: <CACOAw_x+FNUAoYPw4BoRd+SHErV0QZi=UTgDDNPRkeS3n6P6wA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: correct i_size change for atomic writes
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

On Fri, Oct 28, 2022 at 7:48 PM Chao Yu <chao@kernel.org> wrote:
>
> On 2022/10/19 1:00, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > We need to make sure i_size doesn't change until atomic write commit is
> > successful and restore it when commit is failed.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v5: prevent only i_size update for atomic files when dirtying inode
> > v4: move i_size update after clearing atomic file flag in
> >      f2fs_abort_atomic_write()
> > v3: make sure inode is clean while atomic writing
> > ---
> >   fs/f2fs/f2fs.h    |  8 ++++++++
> >   fs/f2fs/file.c    | 18 +++++++++++-------
> >   fs/f2fs/inode.c   |  5 ++++-
> >   fs/f2fs/segment.c | 14 ++++++++++----
> >   4 files changed, 33 insertions(+), 12 deletions(-)
> >
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index e7e750e6b332..68d2a3383c38 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -764,6 +764,7 @@ enum {
> >       FI_COMPRESS_RELEASED,   /* compressed blocks were released */
> >       FI_ALIGNED_WRITE,       /* enable aligned write */
> >       FI_COW_FILE,            /* indicate COW file */
> > +     FI_ATOMIC_COMMIT,       /* indicate atomic commit completed except disk sync */
>
> How about FI_ATOMIC_WRITTEN or FI_ATOMIC_COMMITTED? which may be
> more readable?

Sounds reasonable. I will take FI_ATOMIC_COMMITTED.

>
> >       FI_MAX,                 /* max flag, never be used */
> >   };
> >
> > @@ -822,6 +823,7 @@ struct f2fs_inode_info {
> >       unsigned int i_cluster_size;            /* cluster size */
> >
> >       unsigned int atomic_write_cnt;
> > +     loff_t original_i_size;         /* original i_size before atomic write */
> >   };
> >
> >   static inline void get_extent_info(struct extent_info *ext,
> > @@ -3072,6 +3074,8 @@ static inline void f2fs_i_blocks_write(struct inode *inode,
> >               set_inode_flag(inode, FI_AUTO_RECOVER);
> >   }
> >
> > +static inline bool f2fs_is_atomic_file(struct inode *inode);
> > +
> >   static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
> >   {
> >       bool clean = !is_inode_flag_set(inode, FI_DIRTY_INODE);
> > @@ -3081,6 +3085,10 @@ static inline void f2fs_i_size_write(struct inode *inode, loff_t i_size)
> >               return;
> >
> >       i_size_write(inode, i_size);
> > +
> > +     if (f2fs_is_atomic_file(inode))
> > +             return;
> > +
> >       f2fs_mark_inode_dirty_sync(inode, true);
> >       if (clean || recover)
> >               set_inode_flag(inode, FI_AUTO_RECOVER);
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index ec9ee0f6d502..7ce629c95f4a 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1991,6 +1991,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
> >       struct f2fs_inode_info *fi = F2FS_I(inode);
> >       struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >       struct inode *pinode;
> > +     loff_t isize;
> >       int ret;
> >
> >       if (!inode_owner_or_capable(mnt_userns, inode))
> > @@ -2049,7 +2050,12 @@ static int f2fs_ioc_start_atomic_write(struct file *filp)
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
> >       stat_inc_atomic_inode(inode);
> >
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
> > index 9f0d3864d9f1..044f132b87bc 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -621,9 +621,12 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
> >       ri->i_uid = cpu_to_le32(i_uid_read(inode));
> >       ri->i_gid = cpu_to_le32(i_gid_read(inode));
> >       ri->i_links = cpu_to_le32(inode->i_nlink);
> > -     ri->i_size = cpu_to_le64(i_size_read(inode));
> >       ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
> >
> > +     if (!f2fs_is_atomic_file(inode) ||
> > +                     is_inode_flag_set(inode, FI_ATOMIC_COMMIT))
> > +             ri->i_size = cpu_to_le64(i_size_read(inode));
>
> So we expect that below flow can update i_size correctly, right?

Yes, right.

Thanks,

>
> - f2fs_ioc_commit_atomic_write
>   - f2fs_do_sync_file
>    - f2fs_skip_inode_update
>    - f2fs_write_inode
>     - f2fs_update_inode_page
>      - f2fs_update_inode
>
> Thanks,
>
> > +
> >       if (et) {
> >               read_lock(&et->lock);
> >               set_raw_extent(&et->largest, &ri->i_ext);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 289bcb7ca300..264b4e352319 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -192,14 +192,18 @@ void f2fs_abort_atomic_write(struct inode *inode, bool clean)
> >       if (!f2fs_is_atomic_file(inode))
> >               return;
> >
> > -     if (clean)
> > -             truncate_inode_pages_final(inode->i_mapping);
> >       clear_inode_flag(fi->cow_inode, FI_COW_FILE);
> >       iput(fi->cow_inode);
> >       fi->cow_inode = NULL;
> >       release_atomic_write_cnt(inode);
> > +     clear_inode_flag(inode, FI_ATOMIC_COMMIT);
> >       clear_inode_flag(inode, FI_ATOMIC_FILE);
> >       stat_dec_atomic_inode(inode);
> > +
> > +     if (clean) {
> > +             truncate_inode_pages_final(inode->i_mapping);
> > +             f2fs_i_size_write(inode, fi->original_i_size);
> > +     }
> >   }
> >
> >   static int __replace_atomic_write_block(struct inode *inode, pgoff_t index,
> > @@ -335,10 +339,12 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
> >       }
> >
> >   out:
> > -     if (ret)
> > +     if (ret) {
> >               sbi->revoked_atomic_block += fi->atomic_write_cnt;
> > -     else
> > +     } else {
> >               sbi->committed_atomic_block += fi->atomic_write_cnt;
> > +             set_inode_flag(inode, FI_ATOMIC_COMMIT);
> > +     }
> >
> >       __complete_revoke_list(inode, &revoke_list, ret ? true : false);
> >
