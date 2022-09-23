Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0C95E720D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 04:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbiIWCoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 22:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiIWCoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 22:44:23 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB5BE36A8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 19:44:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a26so25105853ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 19:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=O8NMEpN3FFPzEihahYZPGW20+5lL+Rum80lfffeoCZ0=;
        b=dF8+zT+HF1mg/MUT4wTisgLsurVdTIHcj73r6X7JWft4YCI7DQK2uxtZ2FAH+cNCVf
         EVTzfLbeRsjuVQ6kPs5f63xoxviPyndZ7vwqf9MD8cnFSLnNr8RzHneAaZR6wt9WVwXx
         TASBfCgJCTBY9zLXTSBLucpxB7Q249zOtf1oYnYwZaf9nfVVvosKQguCVo9AKLA+P+Da
         rVRdhzVz4PygyN/w24b4lAXXqJLUZATcPUh7HTcaXZRNWkkGeXB+v4/h+RTxRPUVGPuQ
         xQcZLnIL2d7db3SxcUln9lANfk3x5HY59isoQXvzhM3bJRDZwqF10TZyKA8uQ6Npmopt
         wD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=O8NMEpN3FFPzEihahYZPGW20+5lL+Rum80lfffeoCZ0=;
        b=rXFFqbEq7LecCW+d/KOfJvgLO0j33hXxhxGr1HNPRpWL1ZFYBr4743iHKOjiQkMYwk
         I5KXj5AfsqwYg8WG7qlUEWdWuKQB2JDVkFhb5vAiKW87DhXdttNSMY48zt/5oQ/H7OLG
         Tz07Iej7arhu6IUfdJQ1rz8tHd1lNXEgCIfvZMAr1e5I9B+r3OiMaad3Wk01KVyQQOdJ
         kzaXaigirFetEzSY9AwSOXtnW4eBnuXWnvsS1eAxawnLpQf8RkFbO1YTs7nxYp9pS2p+
         wrCBjPruH9yO9E3/0IpwU0HxhsMyKLx47icKyh8Kg5dURLZqJr2QHxcj/1Avm42JzCBE
         HR0w==
X-Gm-Message-State: ACrzQf01YqmGThNVID3TcSyKxNgqFGsyjHzMe8xtrkJEcOF0HwZ3eEuO
        PcLKElDHY1xy7OQjdsVXI9+mXGNvo3S3uCve1GqsXrXDPTWrxbwyDu8=
X-Google-Smtp-Source: AMsMyM5KYAcQmTv+8KLcqCN6tfmynfygQSmIBBy27edK3Nl1HVS4+I22wec6PfajjsXKVGUO1I6VUbXNigKoFE6TR5E=
X-Received: by 2002:a17:907:a042:b0:77b:a279:fc00 with SMTP id
 gz2-20020a170907a04200b0077ba279fc00mr5175720ejc.616.1663901059806; Thu, 22
 Sep 2022 19:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
Date:   Fri, 23 Sep 2022 10:44:08 +0800
Message-ID: <CAP4dvsf5r7_gOrmkfy7E_4aq0Mj5DjVy2jen1pL2kXoKsh65hQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: Use ovl mounter's fsuid and fsgid in ovl_link()
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, brauner@kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Miklos,

Gentle ping...

Thanks,
Tianci

On Thu, Sep 1, 2022 at 4:29 PM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> There is a wrong case of link() on overlay:
>   $ mkdir /lower /fuse /merge
>   $ mount -t fuse /fuse
>   $ mkdir /fuse/upper /fuse/work
>   $ mount -t overlay /merge -o lowerdir=/lower,upperdir=/fuse/upper,\
>     workdir=work
>   $ touch /merge/file
>   $ chown bin.bin /merge/file // the file's caller becomes "bin"
>   $ ln /merge/file /merge/lnkfile
>
> Then we will get an error(EACCES) because fuse daemon checks the link()'s
> caller is "bin", it denied this request.
>
> In the changing history of ovl_link(), there are two key commits:
>
> The first is commit bb0d2b8ad296 ("ovl: fix sgid on directory") which
> overrides the cred's fsuid/fsgid using the new inode. The new inode's
> owner is initialized by inode_init_owner(), and inode->fsuid is
> assigned to the current user. So the override fsuid becomes the
> current user. We know link() is actually modifying the directory, so
> the caller must have the MAY_WRITE permission on the directory. The
> current caller may should have this permission. This is acceptable
> to use the caller's fsuid.
>
> The second is commit 51f7e52dc943 ("ovl: share inode for hard link")
> which removed the inode creation in ovl_link(). This commit move
> inode_init_owner() into ovl_create_object(), so the ovl_link() just
> give the old inode to ovl_create_or_link(). Then the override fsuid
> becomes the old inode's fsuid, neither the caller nor the overlay's
> mounter! So this is incorrect.
>
> Fix this bug by using ovl mounter's fsuid/fsgid to do underlying
> fs's link().
>
> v1: https://lore.kernel.org/all/20220817102952.xnvesg3a7rbv576x@wittgenstein/T
> v2: https://lore.kernel.org/lkml/20220825130552.29587-1-zhangtianci.1997@bytedance.com/t
>
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/overlayfs/dir.c | 46 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 6b03457f72bb..c3032cef391e 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -592,28 +592,42 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
>                         goto out_revert_creds;
>         }
>
> -       err = -ENOMEM;
> -       override_cred = prepare_creds();
> -       if (override_cred) {
> +       if (!attr->hardlink) {
> +               err = -ENOMEM;
> +               override_cred = prepare_creds();
> +               if (!override_cred)
> +                       goto out_revert_creds;
> +               /*
> +                * In the creation cases(create, mkdir, mknod, symlink),
> +                * ovl should transfer current's fs{u,g}id to underlying
> +                * fs. Because underlying fs want to initialize its new
> +                * inode owner using current's fs{u,g}id. And in this
> +                * case, the @inode is a new inode that is initialized
> +                * in inode_init_owner() to current's fs{u,g}id. So use
> +                * the inode's i_{u,g}id to override the cred's fs{u,g}id.
> +                *
> +                * But in the other hardlink case, ovl_link() does not
> +                * create a new inode, so just use the ovl mounter's
> +                * fs{u,g}id.
> +                */
>                 override_cred->fsuid = inode->i_uid;
>                 override_cred->fsgid = inode->i_gid;
> -               if (!attr->hardlink) {
> -                       err = security_dentry_create_files_as(dentry,
> -                                       attr->mode, &dentry->d_name, old_cred,
> -                                       override_cred);
> -                       if (err) {
> -                               put_cred(override_cred);
> -                               goto out_revert_creds;
> -                       }
> +               err = security_dentry_create_files_as(dentry,
> +                               attr->mode, &dentry->d_name, old_cred,
> +                               override_cred);
> +               if (err) {
> +                       put_cred(override_cred);
> +                       goto out_revert_creds;
>                 }
>                 put_cred(override_creds(override_cred));
>                 put_cred(override_cred);
> -
> -               if (!ovl_dentry_is_whiteout(dentry))
> -                       err = ovl_create_upper(dentry, inode, attr);
> -               else
> -                       err = ovl_create_over_whiteout(dentry, inode, attr);
>         }
> +
> +       if (!ovl_dentry_is_whiteout(dentry))
> +               err = ovl_create_upper(dentry, inode, attr);
> +       else
> +               err = ovl_create_over_whiteout(dentry, inode, attr);
> +
>  out_revert_creds:
>         revert_creds(old_cred);
>         return err;
> --
> 2.32.1 (Apple Git-133)
>
