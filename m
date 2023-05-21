Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861270ACBA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjEUGwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEUGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 02:52:00 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873C2AD;
        Sat, 20 May 2023 23:51:58 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-783fb1d02dcso1428685241.3;
        Sat, 20 May 2023 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684651917; x=1687243917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IKOWcFu5eAcSAAwgRu8IO2TWTltUNxDep0kA83TcgI=;
        b=PVD+EEdkcAJPKn7pdVN5DHkYwCqeqOI/i/kb81PQNTQPKxWLdKRAYNRLW1WBQbgsUJ
         iGLZxBXLj5AmLPyf1zjUV0r32/tXgXUfiRaopWpU6SvSi5giRe/9uiFH3r8kT6C/i7/J
         g3T+vlToBgprURUyze+PpaaMZExOiQBleDZgb0FYUjXj8E8VziG7g0kPzEhr+UnfCrCv
         0suMmnbDbjyzXCSgpSSv7zCSJHDr+QjcL5u5jyrBmCjfETiJCgqGCYLySjVKlSlomuKH
         1xRdqWpunFvvH3762tfjRrZ7nw4s0azAAQFCTZ0u1QVJhLpaoX7lCyNZDQ7qcg51eeK9
         UluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684651917; x=1687243917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IKOWcFu5eAcSAAwgRu8IO2TWTltUNxDep0kA83TcgI=;
        b=I/JqSjjj5x4T/qwPjq+nEZpctG8+M+XZd6kgnf9zNsVARHy8hV6WSS2mbOQlnU/keq
         +Jfx3d29bPZJpWwcKhcAbA/oqgyXNDhmCviHVXnQMX/Sq0odj0zrVnW4f9EtgQbC46+S
         vzEs8QOqB+Z4s2SeVcOZl0QAnpxuZHgzaeVRU85oi8w5nFopphdopW57maXe0cexJ/Sr
         lJEnoNLZU0GU8BcPfQhKM5ZUzjX2ssC2UpGjbpcjZsgLVFEgj3Wq86Bb0coyk+YBb1iR
         Al8gpclPCM9eiEjwifQFtA7wfsvtLTno9VMDT6lPz5M5k063OSrnn/MDiGb+kXoSu7nw
         T3gg==
X-Gm-Message-State: AC+VfDzcstkwZn/7jh4+sOS5gA/y27l15Ht5BswaWHSLNaZFrxC9qfik
        /t+TV6K9Q17dL41c1BqFc+1ME1Fn41YAwDoDEig=
X-Google-Smtp-Source: ACHHUZ4jJcb6PUT3FyKIuCML88FGLyxpurn2wRg89HNyQf/QpKnK7CnOl0PS5AXi9uGO3NXCg7lXqZTmm++KVRJVN/8=
X-Received: by 2002:a67:ee0b:0:b0:42f:fef1:a2bb with SMTP id
 f11-20020a67ee0b000000b0042ffef1a2bbmr1501369vsp.24.1684651917492; Sat, 20
 May 2023 23:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230520184114.77725-1-andrea.righi@canonical.com> <20230520184114.77725-3-andrea.righi@canonical.com>
In-Reply-To: <20230520184114.77725-3-andrea.righi@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 21 May 2023 09:51:46 +0300
Message-ID: <CAOQ4uxh-ApuxzCG57BeSDveg34LQWD48xKHKO9vCX=5NTn647A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ovl: make consistent use of OVL_FS()
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2023 at 9:41=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Always use OVL_FS() to retrieve the corresponding struct ovl_fs from a
> struct super_block.
>
> Moreover, make sure that it is exclusively used with an overlayfs
> superblock when CONFIG_OVERLAY_FS_DEBUG is enabled (otherwise trigger a
> WARN_ON_ONCE).

Seems that you do not mind learning how we usually do things...
so "Moreover", "Also" is usually an indication that this change needs to be
in a separate patch.
I think this is one of those cases.

>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  fs/overlayfs/copy_up.c   |  2 +-
>  fs/overlayfs/export.c    | 10 +++++-----
>  fs/overlayfs/inode.c     |  8 ++++----
>  fs/overlayfs/namei.c     |  2 +-
>  fs/overlayfs/ovl_entry.h | 16 ++++++++++++++++
>  fs/overlayfs/super.c     | 12 ++++++------
>  fs/overlayfs/util.c      | 18 +++++++++---------
>  7 files changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index f658cc8ea492..60aa615820e7 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -905,7 +905,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
>  static bool ovl_need_meta_copy_up(struct dentry *dentry, umode_t mode,
>                                   int flags)
>  {
> -       struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>
>         if (!ofs->config.metacopy)
>                 return false;
> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index defd4e231ad2..f5f0ef8e3ce8 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -182,7 +182,7 @@ static int ovl_connect_layer(struct dentry *dentry)
>   */
>  static int ovl_check_encode_origin(struct dentry *dentry)
>  {
> -       struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>
>         /* Upper file handle for pure upper */
>         if (!ovl_dentry_lower(dentry))
> @@ -434,7 +434,7 @@ static struct dentry *ovl_lookup_real_inode(struct su=
per_block *sb,
>                                             struct dentry *real,
>                                             const struct ovl_layer *layer=
)
>  {
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
>         struct dentry *index =3D NULL;
>         struct dentry *this =3D NULL;
>         struct inode *inode;
> @@ -655,7 +655,7 @@ static struct dentry *ovl_get_dentry(struct super_blo=
ck *sb,
>                                      struct ovl_path *lowerpath,
>                                      struct dentry *index)
>  {
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
>         const struct ovl_layer *layer =3D upper ? &ofs->layers[0] : lower=
path->layer;
>         struct dentry *real =3D upper ?: (index ?: lowerpath->dentry);
>
> @@ -680,7 +680,7 @@ static struct dentry *ovl_get_dentry(struct super_blo=
ck *sb,
>  static struct dentry *ovl_upper_fh_to_d(struct super_block *sb,
>                                         struct ovl_fh *fh)
>  {
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
>         struct dentry *dentry;
>         struct dentry *upper;
>
> @@ -700,7 +700,7 @@ static struct dentry *ovl_upper_fh_to_d(struct super_=
block *sb,
>  static struct dentry *ovl_lower_fh_to_d(struct super_block *sb,
>                                         struct ovl_fh *fh)
>  {
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
>         struct ovl_path origin =3D { };
>         struct ovl_path *stack =3D &origin;
>         struct dentry *dentry =3D NULL;
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 541cf3717fc2..c27823f6e7aa 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -334,7 +334,7 @@ static const char *ovl_get_link(struct dentry *dentry=
,
>
>  bool ovl_is_private_xattr(struct super_block *sb, const char *name)
>  {
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
>
>         if (ofs->config.userxattr)
>                 return strncmp(name, OVL_XATTR_USER_PREFIX,
> @@ -689,7 +689,7 @@ int ovl_set_acl(struct mnt_idmap *idmap, struct dentr=
y *dentry,
>  int ovl_update_time(struct inode *inode, struct timespec64 *ts, int flag=
s)
>  {
>         if (flags & S_ATIME) {
> -               struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
> +               struct ovl_fs *ofs =3D OVL_FS(inode->i_sb);
>                 struct path upperpath =3D {
>                         .mnt =3D ovl_upper_mnt(ofs),
>                         .dentry =3D ovl_upperdentry_dereference(OVL_I(ino=
de)),
> @@ -952,7 +952,7 @@ static inline void ovl_lockdep_annotate_inode_mutex_k=
ey(struct inode *inode)
>
>  static void ovl_next_ino(struct inode *inode)
>  {
> -       struct ovl_fs *ofs =3D inode->i_sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(inode->i_sb);
>
>         inode->i_ino =3D atomic_long_inc_return(&ofs->last_ino);
>         if (unlikely(!inode->i_ino))
> @@ -1284,7 +1284,7 @@ struct inode *ovl_get_trap_inode(struct super_block=
 *sb, struct dentry *dir)
>  static bool ovl_hash_bylower(struct super_block *sb, struct dentry *uppe=
r,
>                              struct dentry *lower, bool index)
>  {
> -       struct ovl_fs *ofs =3D sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(sb);
>
>         /* No, if pure upper */
>         if (!lower)
> diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
> index cfb3420b7df0..d0f196b85541 100644
> --- a/fs/overlayfs/namei.c
> +++ b/fs/overlayfs/namei.c
> @@ -832,7 +832,7 @@ struct dentry *ovl_lookup(struct inode *dir, struct d=
entry *dentry,
>  {
>         struct ovl_entry *oe;
>         const struct cred *old_cred;
> -       struct ovl_fs *ofs =3D dentry->d_sb->s_fs_info;
> +       struct ovl_fs *ofs =3D OVL_FS(dentry->d_sb);
>         struct ovl_entry *poe =3D dentry->d_parent->d_fsdata;
>         struct ovl_entry *roe =3D dentry->d_sb->s_root->d_fsdata;
>         struct ovl_path *stack =3D NULL, *origin_path =3D NULL;
> diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
> index fd11fe6d6d45..0b93b1d9ad79 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -95,8 +95,24 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(st=
ruct ovl_fs *ofs)
>         return mnt_idmap(ovl_upper_mnt(ofs));
>  }
>
> +extern struct file_system_type ovl_fs_type;
> +
> +#ifdef CONFIG_OVERLAY_FS_DEBUG
> +static inline bool is_ovl_fs_sb(struct super_block *sb)
> +{
> +       return sb->s_type =3D=3D &ovl_fs_type;
> +}
> +#else
> +static inline bool is_ovl_fs_sb(struct super_block *sb)
> +{
> +       return true;
> +}
> +#endif
> +
>  static inline struct ovl_fs *OVL_FS(struct super_block *sb)
>  {
> +       WARN_ON_ONCE(!is_ovl_fs_sb(sb));
> +
>         return (struct ovl_fs *)sb->s_fs_info;
>  }
>

IMO, is_ovl_fs_sb() is useful and no reason to hide it under
CONFIG_OVERLAY_FS_DEBUG.
IMO, only the fortification of OVL_FS() needs to be hidden inside
CONFIG_OVERLAY_FS_DEBUG.

With those minor comments fixed you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
