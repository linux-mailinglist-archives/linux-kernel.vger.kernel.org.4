Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3132B705676
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjEPS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjEPS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:57:01 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94120FC;
        Tue, 16 May 2023 11:56:54 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-4361113bdd1so3085328137.0;
        Tue, 16 May 2023 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684263413; x=1686855413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS523aYbO4e916ChocjeGla7otigiG6oGRH6aerVi6E=;
        b=IQ+G+l3pqZxLYOX8IPggT6ikOIQeNcOW0MgCIFe9V7ZCiC0Ck2LrMTyo3mb2VVor3v
         IubVAT590MXAU93bKMoVo29KuFxW8dj+S5hgDcT1NF9nhQdFBvOMsUaQ1a3whUNJ63Nr
         y5Wsb+LZcxVu3VXV9tu3g3IN2dqisJsh51uuZHB7tPMkSAZWedmTz0DPsKQ3GM6rw04u
         ZjaLo7voiI5VfdhB4RqgOf1wON1a6imNFnZ193hHTL6SjMbGYSIdAhCXxxUJmozren/z
         vuNZ6792hOLtrZwqz2Lc+Ds8M4claO0ud4LP3uXhHYYZHvd/Mr1tV4y3R+nawsI8XM+Y
         I4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684263413; x=1686855413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cS523aYbO4e916ChocjeGla7otigiG6oGRH6aerVi6E=;
        b=g+tH0Z3X+oUyyibKRMqEeWWkhlvOYUCL5u1lGiHeH68rOcbsIOnbTAFZ6EILtgq9Xf
         WmNapvOC+XoiYdpS6GbgtDMw4GN9oUIRW37Ryr+yMw78RX75FxugVbexEYguN4OBopT3
         F26ZKPK5f+dg430LiIbWGi1qd9Q1SjZbeUbLy+qhoEGLZ7qXMUNdkn/HlpwdiGsw97fx
         sTIypkzuDX0eAGSoO7PEqLLyQFH9anBvZ9QKMg6l5/sUibG+ckD6avzkVzUdKZUsYtLu
         u/8Uprn/267U3FQdTJ9c7vl4Hqr4eBZGG11s5jv95SpCSjLaVCDBNg5pgZj7TJwCXBK8
         /Z4g==
X-Gm-Message-State: AC+VfDwQri3CyoRuz52QxSOgZt25ZdZVzirk0fNDQICvaBgz1ZF669R0
        NB854CgUjvcOxds4yEEiCm+MpKtNnLp3eLf86i8=
X-Google-Smtp-Source: ACHHUZ5jFpCHIZ5yA4Z5hqg6vsxFMrT0cTzv0u6bSfJBG+ebdIT1uItMAzxNrsht6ggMQzMyCPgRjhUTu32c3spDEZc=
X-Received: by 2002:a67:ff15:0:b0:434:7003:8b55 with SMTP id
 v21-20020a67ff15000000b0043470038b55mr16871299vsp.21.1684263413438; Tue, 16
 May 2023 11:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230516141619.2160800-1-chengzhihao1@huawei.com> <20230516141619.2160800-4-chengzhihao1@huawei.com>
In-Reply-To: <20230516141619.2160800-4-chengzhihao1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 21:56:42 +0300
Message-ID: <CAOQ4uxj32Vuxb+8WwwnK4+2e5VXsscfRkja+paktP=HNTJeL3w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ovl: get_acl: Fix null pointer dereference at
 realinode in rcu-walk mode
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
>          P1                     P2
>  path_openat
>   link_path_walk
>    may_lookup
>     inode_permission(rcu)
>      ovl_permission
>       acl_permission_check
>        check_acl
>         get_cached_acl_rcu
>          ovl_get_inode_acl
>           realinode =3D ovl_inode_real(ovl_inode)
>                               drop_cache
>                                __dentry_kill(ovl_dentry)
>                                 iput(ovl_inode)
>                                  ovl_destroy_inode(ovl_inode)
>                                   dput(oi->__upperdentry)
>                                    dentry_kill(upperdentry)
>                                     dentry_unlink_inode
>                                      upperdentry->d_inode =3D NULL
>             ovl_inode_upper
>              upperdentry =3D ovl_i_dentry_upper(ovl_inode)
>              d_inode(upperdentry) // returns NULL
>           IS_POSIXACL(realinode) // NULL pointer dereference
> , will trigger an null pointer dereference at realinode:
>   [  205.472797] BUG: kernel NULL pointer dereference, address:
>                  0000000000000028
>   [  205.476701] CPU: 2 PID: 2713 Comm: ls Not tainted
>                  6.3.0-12064-g2edfa098e750-dirty #1216
>   [  205.478754] RIP: 0010:do_ovl_get_acl+0x5d/0x300
>   [  205.489584] Call Trace:
>   [  205.489812]  <TASK>
>   [  205.490014]  ovl_get_inode_acl+0x26/0x30
>   [  205.490466]  get_cached_acl_rcu+0x61/0xa0
>   [  205.490908]  generic_permission+0x1bf/0x4e0
>   [  205.491447]  ovl_permission+0x79/0x1b0
>   [  205.491917]  inode_permission+0x15e/0x2c0
>   [  205.492425]  link_path_walk+0x115/0x550
>   [  205.493311]  path_lookupat.isra.0+0xb2/0x200
>   [  205.493803]  filename_lookup+0xda/0x240
>   [  205.495747]  vfs_fstatat+0x7b/0xb0
>
> Fetch a reproducer in [Link].
>
> Use the helper ovl_i_path_realinode() to get realinode and then do
> non-nullptr checking.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217404
> Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/overlayfs/inode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index ca56b1328a2c..e7e888dea634 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -558,20 +558,20 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *=
idmap,
>                                  struct inode *inode, int type,
>                                  bool rcu, bool noperm)
>  {
> -       struct inode *realinode =3D ovl_inode_real(inode);
> +       struct inode *realinode;
>         struct posix_acl *acl;
>         struct path realpath;
>
> -       if (!IS_POSIXACL(realinode))
> -               return NULL;
> -
>         /* Careful in RCU walk mode */
> -       ovl_i_path_real(inode, &realpath);
> -       if (!realpath.dentry) {
> +       realinode =3D ovl_i_path_real(inode, &realpath);
> +       if (!realinode) {
>                 WARN_ON(!rcu);
>                 return ERR_PTR(-ECHILD);
>         }
>
> +       if (!IS_POSIXACL(realinode))
> +               return NULL;
> +
>         if (rcu) {
>                 /*
>                  * If the layer is idmapped drop out of RCU path walk
> --
> 2.39.2
>
