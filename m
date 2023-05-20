Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEDC70A825
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjETMdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjETMdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 08:33:46 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D3BEE;
        Sat, 20 May 2023 05:33:44 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-437e2e0a5c7so826798137.0;
        Sat, 20 May 2023 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684586024; x=1687178024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yf84jDrozMrVV1oSYdPXMslyu1qqK1BqRWzZfbaK148=;
        b=mhC8RSqOMipd/H+QQ7X/H5lG97+eN3kQcqDo4ll/2O1NjwbY+Ym8IidvgesuRLmMHC
         VS3tnrq51JnysqdyfLAZofABlVIfNnQF4QMJgxTWIIyj7hFEhCBPKPamKJOpVgPnUNaC
         pKWS5JToSm6UrCbASXJEvaLIT3EPBKtf8wBesHoAaefzeNAuqXnmFO5YQ5YOGVRoT7G6
         fP+SJ3DIYqEXTZkvvZfVdQdWBWWul978WFjFVjYQ5XqJkI5GDlSKdHYqGBtYrTaLqDpN
         FmIZZsry4xe7joi54JZ1c5wixbz8NGYl3Bbid6qGvOHc6RN91lULv9QHfS6uJ9cCiN7e
         L86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684586024; x=1687178024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yf84jDrozMrVV1oSYdPXMslyu1qqK1BqRWzZfbaK148=;
        b=bgcurzoFKFSGajBXEzXnuR8OMb+TVd6w3L3R3WG8NtVqVVCan/Bhhpv3RFTOThSEKW
         qFhd4jCHo0/4qJkPS5//jpIhrtVJiuRRN93vbNXXlYEPwzRgHIUPzU4rV2n90c0/QBed
         pDEl/pmFASkQDFCdu4Gaab8roJuYX8jki/QxFQ0xwRgFk3Ha7J9PUxajzWjeBn9p2r7H
         YowuniyE8dkPlRi8v2RZaMsrn+85S45fsoa2r0nlcQA8U1kiIjjurXXcMfxCUDQ6FMCg
         pPRoUTBvRB1ddpKiY3SMaXS3USS+MkeJxxjFjsKpCt9Dl258C1x59yUg/u/SQTycxZ9X
         ywjQ==
X-Gm-Message-State: AC+VfDxYUFW11Q+mE0eE69mtO3S62bFtpqS4pDUVYcTQZCbCK95xFBpB
        CC51Drb2fhOJ4aBkHMq7/1kUssMAC+HM+0ODxdM=
X-Google-Smtp-Source: ACHHUZ6O99wAxftOjtNLOfQmUxEfN/7H5XRgGxtF695mB/3s6/+Mjm9D+Wo/pNvXyyIo9zmtfUK2284RT9Lm+0Q/UPU=
X-Received: by 2002:a05:6102:e46:b0:434:5359:61b1 with SMTP id
 p6-20020a0561020e4600b00434535961b1mr820666vst.19.1684586023789; Sat, 20 May
 2023 05:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230520120528.339680-1-andrea.righi@canonical.com>
In-Reply-To: <20230520120528.339680-1-andrea.righi@canonical.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 20 May 2023 15:33:32 +0300
Message-ID: <CAOQ4uxjOgWDqufLcabkkPcxvFcrehzoDuO0d6kdJZuoiRBKStw@mail.gmail.com>
Subject: Re: [PATCH] ovl: make consistent use of OVL_FS()
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

On Sat, May 20, 2023 at 3:20=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Always use OVL_FS() to retrieve the corresponding struct ovl_fs from a

I don't mind this cleanup, but...

> struct super_block and make sure that it is exclusively used with an
> overlayfs superblock (otherwise, trigger a BUG).
>
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  fs/overlayfs/copy_up.c   |  2 +-
>  fs/overlayfs/export.c    | 10 +++++-----
>  fs/overlayfs/inode.c     |  8 ++++----
>  fs/overlayfs/namei.c     |  2 +-
>  fs/overlayfs/ovl_entry.h |  4 ++++
>  fs/overlayfs/super.c     | 10 +++++-----
>  fs/overlayfs/util.c      | 18 +++++++++---------
>  7 files changed, 29 insertions(+), 25 deletions(-)
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
> index fd11fe6d6d45..b91b3694ae26 100644
> --- a/fs/overlayfs/ovl_entry.h
> +++ b/fs/overlayfs/ovl_entry.h
> @@ -5,6 +5,8 @@
>   * Copyright (C) 2016 Red Hat, Inc.
>   */
>
> +#include <uapi/linux/magic.h>
> +
>  struct ovl_config {
>         char *lowerdir;
>         char *upperdir;
> @@ -97,6 +99,8 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(str=
uct ovl_fs *ofs)
>
>  static inline struct ovl_fs *OVL_FS(struct super_block *sb)
>  {
> +       /* Make sure OVL_FS() is always used with an overlayfs superblock=
 */
> +       BUG_ON(sb->s_magic !=3D OVERLAYFS_SUPER_MAGIC);

1. Adding new BUG_ON to kernel code is not acceptable - if anything
    you can add WARN_ON_ONCE()
2. If anything, you should check s_type =3D=3D s_ovl_fs_type, not s_magic
3. It is very unclear to me that this check has that much value and OVL_FS(=
)
    macro is very commonly used inside internal helpers, so please add a
    "why" to your patch - why do you think that it is desired and/or valuab=
le
    to fortify OVL_FS() like this?

Thanks,
Amir.
