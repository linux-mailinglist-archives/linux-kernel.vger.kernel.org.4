Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0498570566B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjEPSzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjEPSz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:55:28 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CD0AD01;
        Tue, 16 May 2023 11:55:23 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7835b0bd5c8so7184241.0;
        Tue, 16 May 2023 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263322; x=1686855322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5qqL0tI2dOiejDyZ7VOmiOl9EqxMnzWMLa7+ZUk7zQ=;
        b=OQx6RZCSTh4bwlJyOUTd4kkGy68lRBiDUlsumPXl7jiqWr18N0lu2RexJX51DWX9R5
         MqEgxeSx1Z7oq00GP6F+Jl+Z+hVK++nbaAS5BRnr9bdK2iohj3jrv/QEUnZvEG1/pZZW
         fBQVra50SWImHr7Zz5CIufqXH4s/zoj9T2hx7xLrwrHKphjA3n7PpeL68eA+wQL0S3LX
         D6o7OfkAjPJB6QF6DBrvoKTKUaVvgY35qx3LXvwJMe8DcjZLHQBSmgOK2x8FLLA8uGPE
         VcNEGLRaLcckHtH0WZyIWsJSbwkGGCSs9Ucxddz20EVZCZuAS6BcRXjRm10fwi/MpusY
         v6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263322; x=1686855322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5qqL0tI2dOiejDyZ7VOmiOl9EqxMnzWMLa7+ZUk7zQ=;
        b=VTxcUZ09fBpFJQR9Gotkh/LT13WyhnXA4CoylqdkbslIb2IXlqe+EvXkJ4afe+yiLY
         YwGKK+MA1/W4wiw2lGo0IaicNh18MeCup6i8mUsRwFICa4KMJdKeA8mdy4fNPx35SCgQ
         51miCGr6ifWOi3oIQ3H6A/TyWc6Etp3Bwb14tveDtDKn32V4O/VUwyk8I0IY6kP6MEyK
         0CxgFLEaImR0SZ/23JnzSc/r0fZJoCq6z+UbjReYSC0VFKVBBHVoPBBZhad7SsHv8t9o
         QkvlE7rnP65XLuuus2b30S6aOKVnI28g0L0Tdgl8GbqR0OUNPnZtEvtQDg8288x4NvwC
         iEfQ==
X-Gm-Message-State: AC+VfDxGoETPZC8VIvnZtUgSpBOf4/SpYLnus7Cv/TqGDF7aerJbpyDt
        4v1xE14UYXsmslZeItBOEgwieiWJKiCV7ywQdte31ZoyN9E=
X-Google-Smtp-Source: ACHHUZ6/TqNLRL+Ri2Y2ySNMuGzksVGdGAioRrWgJSiyvNU506uQAIoKr7YgO5hnHxf1MyE7lA3JmIST57/8/7aaS10=
X-Received: by 2002:a05:6102:3a56:b0:42f:e9be:5921 with SMTP id
 c22-20020a0561023a5600b0042fe9be5921mr15386001vsu.12.1684263322056; Tue, 16
 May 2023 11:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230516141619.2160800-1-chengzhihao1@huawei.com> <20230516141619.2160800-2-chengzhihao1@huawei.com>
In-Reply-To: <20230516141619.2160800-2-chengzhihao1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 21:55:10 +0300
Message-ID: <CAOQ4uxjpz=ha9Q_1vmpXZqRKiWLsF-CAM0hg_5byDKoY4jCt7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ovl: Let helper ovl_i_path_real() return the realinode
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     miklos@szeredi.hu, brauner@kernel.org,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, May 16, 2023 at 5:19=E2=80=AFPM Zhihao Cheng <chengzhihao1@huawei.c=
om> wrote:
>
> Let helper ovl_i_path_real() return the realinode to prepare for
> checking non-null realinode in rcu walking path.
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/overlayfs.h | 2 +-
>  fs/overlayfs/util.c      | 7 ++++---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
> index 4d0b278f5630..7398de332527 100644
> --- a/fs/overlayfs/overlayfs.h
> +++ b/fs/overlayfs/overlayfs.h
> @@ -382,7 +382,7 @@ enum ovl_path_type ovl_path_type(struct dentry *dentr=
y);
>  void ovl_path_upper(struct dentry *dentry, struct path *path);
>  void ovl_path_lower(struct dentry *dentry, struct path *path);
>  void ovl_path_lowerdata(struct dentry *dentry, struct path *path);
> -void ovl_i_path_real(struct inode *inode, struct path *path);
> +struct inode *ovl_i_path_real(struct inode *inode, struct path *path);
>  enum ovl_path_type ovl_path_real(struct dentry *dentry, struct path *pat=
h);
>  enum ovl_path_type ovl_path_realdata(struct dentry *dentry, struct path =
*path);
>  struct dentry *ovl_dentry_upper(struct dentry *dentry);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 923d66d131c1..00d31e38b57d 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -250,7 +250,7 @@ struct dentry *ovl_i_dentry_upper(struct inode *inode=
)
>         return ovl_upperdentry_dereference(OVL_I(inode));
>  }
>
> -void ovl_i_path_real(struct inode *inode, struct path *path)
> +struct inode *ovl_i_path_real(struct inode *inode, struct path *path)
>  {
>         path->dentry =3D ovl_i_dentry_upper(inode);
>         if (!path->dentry) {
> @@ -259,6 +259,8 @@ void ovl_i_path_real(struct inode *inode, struct path=
 *path)
>         } else {
>                 path->mnt =3D ovl_upper_mnt(OVL_FS(inode->i_sb));
>         }
> +
> +       return path->dentry ? d_inode(path->dentry) : NULL;
>  }
>
>  struct inode *ovl_inode_upper(struct inode *inode)
> @@ -1105,8 +1107,7 @@ void ovl_copyattr(struct inode *inode)
>         vfsuid_t vfsuid;
>         vfsgid_t vfsgid;
>
> -       ovl_i_path_real(inode, &realpath);
> -       realinode =3D d_inode(realpath.dentry);
> +       realinode =3D ovl_i_path_real(inode, &realpath);
>         real_idmap =3D mnt_idmap(realpath.mnt);
>
>         vfsuid =3D i_uid_into_vfsuid(real_idmap, realinode);
> --
> 2.39.2
>
