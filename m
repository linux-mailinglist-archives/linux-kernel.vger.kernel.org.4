Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D23A705674
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjEPS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEPS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:56:33 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1AF93F9;
        Tue, 16 May 2023 11:56:17 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7837bbf690eso3049241.1;
        Tue, 16 May 2023 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263377; x=1686855377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FhQD7vn2HCQWI5IgqkMMg4ydFZajhICViGAYvUtjvBQ=;
        b=hEUjrTQi7f1BGqguTEkhgDG1ckm/DVmc6ap8R/loQ01EvrLzKP0QquOB3Bp7aBRmEE
         iMFRg5N+8LXq0uDYpkciRvxrWiA0YBD6t5kf18u7SEv8rkwU7285ChhorsNK37ig7fVO
         C1jnh8NQLlwTlW6zzHUKEMj++xjioUI5a46JfIlbXmXWKnoOza/rH3lEvMfpeT1xepfu
         rIZHX9++ZDBryEMsIEkhVsWZiRrJPm+W8llrEKFqX5Jt41CXqfm1/kaDf3c8jccz3B9G
         1lYS8MYbbQw8lNyPfE5yB1wqqODzMhapfXtG0XmIX9MpSpQ+ZjPnaPbFyx2vYeOsz9lC
         3NvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263377; x=1686855377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhQD7vn2HCQWI5IgqkMMg4ydFZajhICViGAYvUtjvBQ=;
        b=BBfyD7K3AJzSNLTXVsG6w1gS+/0UYPA5dC4NvZoElcA7Vhi13yD5r9VxlUpMPKcmfV
         yn/LryXjtkuygqg968sj0Y4+ffL+1KOiUzO+UQ2rgGeB3vNL4NtcVi70cIRoFfJAi+Uc
         QgUsbroBO/RRgfouQHgndxULLOEFt8q2cPDYtJ9MvEegE8IhdDgc8mfedQ+03I7y9jUN
         K6tOtWhsFxTtJfBmkYYM0KSn8PHAkpxU2IgIVyDjQPQD1m9xPzFoxS+xFC6owBvHRzf1
         Rrl8vqFzp048LpKF3zBP0IRKzYX8IJZCsAnLwA609RZtXjoSHM6gkSsfkcdBlS2e7/w5
         821A==
X-Gm-Message-State: AC+VfDwWLp7aM7eWDOCewmOpzj/G9eza49z604HRw7B5SuYFLc4m4e7v
        y5gBrOLvgOVwG20BxLXg1H+HE3WtiWjkI2DoEJZrkrOccJg=
X-Google-Smtp-Source: ACHHUZ5HG2Snj9bkiX41/MWu3KLrdh9BiieWSrcqMya0ogFoJxZWcMhKIRrN2pwmLAhwDn5J5ALgy6oed9E+iBlimko=
X-Received: by 2002:a67:eecb:0:b0:436:4dda:ee60 with SMTP id
 o11-20020a67eecb000000b004364ddaee60mr4752161vsp.11.1684263376866; Tue, 16
 May 2023 11:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230516141619.2160800-1-chengzhihao1@huawei.com> <20230516141619.2160800-3-chengzhihao1@huawei.com>
In-Reply-To: <20230516141619.2160800-3-chengzhihao1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 21:56:05 +0300
Message-ID: <CAOQ4uxhHZiCSYKC3Kh8r_jK0pD_Bubeturc0k78-GyV83=czWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ovl: ovl_permission: Fix null pointer dereference
 at realinode in rcu-walk mode
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
> Following process:
>           P1                     P2
>  path_lookupat
>   link_path_walk
>    inode_permission
>     ovl_permission
>       ovl_i_path_real(inode, &realpath)
>         path->dentry =3D ovl_i_dentry_upper(inode)
>                           drop_cache
>                            __dentry_kill(ovl_dentry)
>                             iput(ovl_inode)
>                              ovl_destroy_inode(ovl_inode)
>                               dput(oi->__upperdentry)
>                                dentry_kill(upperdentry)
>                                 dentry_unlink_inode
>                                  upperdentry->d_inode =3D NULL
>       realinode =3D d_inode(realpath.dentry) // return NULL
>       inode_permission(realinode)
>        inode->i_sb  // NULL pointer dereference
> , will trigger an null pointer dereference at realinode:
>   [  335.664979] BUG: kernel NULL pointer dereference,
>                  address: 0000000000000002
>   [  335.668032] CPU: 0 PID: 2592 Comm: ls Not tainted 6.3.0
>   [  335.669956] RIP: 0010:inode_permission+0x33/0x2c0
>   [  335.678939] Call Trace:
>   [  335.679165]  <TASK>
>   [  335.679371]  ovl_permission+0xde/0x320
>   [  335.679723]  inode_permission+0x15e/0x2c0
>   [  335.680090]  link_path_walk+0x115/0x550
>   [  335.680771]  path_lookupat.isra.0+0xb2/0x200
>   [  335.681170]  filename_lookup+0xda/0x240
>   [  335.681922]  vfs_statx+0xa6/0x1f0
>   [  335.682233]  vfs_fstatat+0x7b/0xb0
>
> Fetch a reproducer in [Link].
>
> Use the helper ovl_i_path_realinode() to get realinode and then do
> non-nullptr checking.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217405
> Fixes: 4b7791b2e958 ("ovl: handle idmappings in ovl_permission()")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/inode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 541cf3717fc2..ca56b1328a2c 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -288,8 +288,8 @@ int ovl_permission(struct mnt_idmap *idmap,
>         int err;
>
>         /* Careful in RCU walk mode */
> -       ovl_i_path_real(inode, &realpath);
> -       if (!realpath.dentry) {
> +       realinode =3D ovl_i_path_real(inode, &realpath);
> +       if (!realinode) {
>                 WARN_ON(!(mask & MAY_NOT_BLOCK));
>                 return -ECHILD;
>         }
> @@ -302,7 +302,6 @@ int ovl_permission(struct mnt_idmap *idmap,
>         if (err)
>                 return err;
>
> -       realinode =3D d_inode(realpath.dentry);
>         old_cred =3D ovl_override_creds(inode->i_sb);
>         if (!upperinode &&
>             !special_file(realinode->i_mode) && mask & MAY_WRITE) {
> --
> 2.39.2
>
