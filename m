Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58855FD335
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJMCVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMCVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:21:12 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81D64AD65
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:21:10 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id l1so540862pld.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O8NMEpN3FFPzEihahYZPGW20+5lL+Rum80lfffeoCZ0=;
        b=WWLngWJxU7p45kcLgXcpHZ3r+v7sIBkXrp2lthww5Iw04paSf/LLCPXQXstA+Oh6Dl
         ivNUYPsqffqRhGPXtKnilfD/vbU9IIVcu0MAxXnIt3pfrpg5pfj6tiTno4H72icQySWj
         qumy0Y6PSwsK0/uNUYtY6RoFs8NhFoxNPuvYv1ynC7uwVC+i7QtwAeNSI+Thlk7VxMvi
         stNiEfUjRiidVsr/EpQn2MmNpVaL2umIyNkqkNYbOzDszM68SCbz0aUTdzTtvKGfTRFn
         SAtfrqGWRcHvsloMgxm8dOGiRy9aI1H9Jhoz+kKnYkcCVHrdL43s6iiu80Lkv6b82oRq
         BsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8NMEpN3FFPzEihahYZPGW20+5lL+Rum80lfffeoCZ0=;
        b=Yrz4+42aJXPX8EtIKoDni2GHwsqClFdrwlPgxYQW9VymfHV8p+Ds5V46xdrFe5x6XC
         /7/Bqs/ZGFc6XflCOUnj1ryYs1JQMZ4TUHvZlE7IzjaYMRQCW6jd+PllR8wYCGqG3khc
         bqQqD7nf2U+1XANFDftrjcXs60HlLOvvwSDJGq/HZoIx1q7apGuhB3HdOeAgjfX5I1oM
         tR7Dvspr6tFr9xsjaW/YM/RH8+FDKYDlCdhzM7pGWSEu0KU7O7sHlR1amDZfoNf7/RQA
         2IJSnYMFtvXt8smrEq2kADX5AMYT4/SZEo6QO93rRa2reJ0UYc7851avnM19ir9/s4B3
         vqog==
X-Gm-Message-State: ACrzQf3B6nIUzmwKeI7XQ+kpFK2/YQnuktPOIyMqik4zJzKLO1zkcEwJ
        OElT29xwVIsNKRP/ylLY7NBvh69qmdcdPglI/dDtbw==
X-Google-Smtp-Source: AMsMyM7+ee0xIyaUZ1dYU1RhxDA9lzHKEFVGBye3OkcM6pCI8F5XYPLh35V1bjMJCVmrHR6yVI7XZyWDi5dW5acldGk=
X-Received: by 2002:a17:90a:f3ca:b0:20a:d4ee:3859 with SMTP id
 ha10-20020a17090af3ca00b0020ad4ee3859mr8557485pjb.70.1665627670000; Wed, 12
 Oct 2022 19:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20220901082929.66831-1-zhangtianci.1997@bytedance.com>
From:   Zhang Tianci <zhangtianci.1997@bytedance.com>
Date:   Thu, 13 Oct 2022 10:20:58 +0800
Message-ID: <CAP4dvsct-B-fdG=8EoOsm+e3zv9rYfMW+1xRr_Nzs4y61XBajg@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: Use ovl mounter's fsuid and fsgid in ovl_link()
To:     miklos@szeredi.hu
Cc:     linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        amir73il@gmail.com, brauner@kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
