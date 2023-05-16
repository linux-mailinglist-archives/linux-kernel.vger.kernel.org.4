Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590E1704C88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 13:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjEPLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjEPLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 07:41:05 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81773588;
        Tue, 16 May 2023 04:41:04 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-435f36ad948so3575835137.3;
        Tue, 16 May 2023 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684237264; x=1686829264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhhn1bylguQnKhsvPVu6RzK7RBkZkZ704VD0zWcdraI=;
        b=BLJuzFJeS+HtLZZwrc3bJint/tA9JolAcI0fBET7eXQAHR59u3OX3hbZNXYZkagwPG
         LTruz+CyOTxzCQtTmb0R+G4PHrNItCtcQHxbngrGvYvdkZg27Ng6gx/XWT/SS2nHvagk
         vTIUb+02Shb5REDow7XFGQFYHb6mEFnCmQVrmp04KYdTWZ55Sae5ewBv6GKharHhCpp4
         SK/hO+TrijfV/Jv/n+R/S346JeOqgKuo4uZd2B9oVQoc8Bo3Ueli2MybCav/hOMfJmXA
         EEMGNRSdf+R6tIV3rYrfwEzTaM17CgDGe9XK4QcgvOyZ5ghL89VbuVLcBYYTmUnc2QyD
         H8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684237264; x=1686829264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhhn1bylguQnKhsvPVu6RzK7RBkZkZ704VD0zWcdraI=;
        b=aU7VudFxpkuv2s3jfzhbQanDySYF9TYHfZkCB+jqE54agyHEkzcrf0G3dIlqbVqX4l
         TYPWnC/qIVwNwQyFHelO3neSorz50FWthznx9f9FOjG2o4M49lI0fcWCv34xP4+//BHS
         TzTY0iyER01zf/KIDtnfjuS6HbERuyX2Qrx/FjKyWGXpJ6re+07eGy3+xnxpTUnJ8yCA
         w7t5DNOT7K9h6x5DTJjA2G2LXelavQQBSwPhosc+OecCHrbySklCcucOksaQGOmwovv2
         GaSKVkjuB01Duk0lgu7ifvrin6tWlw59kF9CMNYc/nJfRMzT+pxeMhYsWJBmlYSxkfRQ
         +gfQ==
X-Gm-Message-State: AC+VfDwuU0sblAHq2YmNu53MBzcL5sMH83GjTPNaDJ8YI9oqaqnRTG3E
        HjEbscbzbFRujs2A2ZebHu3qQWWv3kViwL3KdN0=
X-Google-Smtp-Source: ACHHUZ6cgEwBFxo7272nFrkM4cDS/VvQFcB7BNEP8xuZ4EOSXtL+E/RNSDQs0SRE3y7RGOTk3jRY49s4IK29doaiXoo=
X-Received: by 2002:a67:ee4b:0:b0:435:5148:b0e4 with SMTP id
 g11-20020a67ee4b000000b004355148b0e4mr14019615vsp.7.1684237263874; Tue, 16
 May 2023 04:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230515133629.1974610-1-chengzhihao1@huawei.com> <20230515133629.1974610-3-chengzhihao1@huawei.com>
In-Reply-To: <20230515133629.1974610-3-chengzhihao1@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 14:40:52 +0300
Message-ID: <CAOQ4uxj-j-ugHrvvfS+XF=rzE3NH_NaZgf4_rWBxvaGYO3iN-w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ovl: get_acl: Fix null pointer dereference at
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

On Mon, May 15, 2023 at 4:39=E2=80=AFPM Zhihao Cheng <chengzhihao1@huawei.c=
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
> Fix it by using helper ovl_i_path_realinode() to get realpath and real
> inode after non-nullptr checking.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217404
> Fixes: 332f606b32b6 ("ovl: enable RCU'd ->get_acl()")

Note that this bug is also in 5.15.y, in method ovl_get_acl().
I hope you will be able to follow up with a simple backport for 5.15 -
i.e. only need to add a check for NULL realinode at the beginning.
There was no realpath back then.

AFAICT, both your patches should apply cleanly to 6.1.y, so should
be picked up automatically by stable kernel bots.

Thanks,
Amir.

> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/overlayfs/inode.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index cc3ef5a6666a..b2021eada8be 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -576,20 +576,18 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *=
idmap,
>                                  struct inode *inode, int type,
>                                  bool rcu, bool noperm)
>  {
> -       struct inode *realinode =3D ovl_inode_real(inode);
> +       struct inode *realinode;
>         struct posix_acl *acl;
>         struct path realpath;
> +       int err;
> +
> +       err =3D ovl_i_path_realinode(inode, &realpath, &realinode, rcu);
> +       if (err)
> +               return ERR_PTR(err);
>
>         if (!IS_POSIXACL(realinode))
>                 return NULL;
>
> -       /* Careful in RCU walk mode */
> -       ovl_i_path_real(inode, &realpath);
> -       if (!realpath.dentry) {
> -               WARN_ON(!rcu);
> -               return ERR_PTR(-ECHILD);
> -       }
> -
>         if (rcu) {
>                 /*
>                  * If the layer is idmapped drop out of RCU path walk
> --
> 2.39.2
>
