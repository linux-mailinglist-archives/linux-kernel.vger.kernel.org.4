Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781EA739797
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjFVGo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjFVGoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:44:55 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E39B1BCD;
        Wed, 21 Jun 2023 23:44:51 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4715cbe0422so2086297e0c.3;
        Wed, 21 Jun 2023 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687416290; x=1690008290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLj587xVoRgqRKhRrCaStNTVfSpf62GN7fanQWD11SU=;
        b=pAYd6nAPjPRzKeYBogRAlKwoLK8J7LQEL1liFk+ROKA8FpeX30A32TuvQupOzDgJIq
         k2eS2rI+bikqGPN6YOuK12NdohOKlsiWggSznnqOp4RUDaL479dBdqtILEVuxBJmDj52
         GgWehiWyVo9dlXpUZmF3SrZMBtRYbRwOvgUDgbPo2TJlfYDZIYVr7rgM14VhSiv4Mo5L
         eZVnkce3ml2MPUyy+lD9vHgf7QF+fVJGs6WqCi4C/2ok6yNJwbgyH5YlZRIR/B8LfcNG
         S6we4Joo6eF2y+maoJBmKuyZKM7i5ORrsqll3ksncuvSCUsVJSoE7BfjHAxoxXCblpj3
         txVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687416290; x=1690008290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLj587xVoRgqRKhRrCaStNTVfSpf62GN7fanQWD11SU=;
        b=MQdPNlnRIdgECOnOzxeaPfPCOguhVSiqBNoOHrRm81By7gDu0wzEojkz7F6akujpI7
         f2B6vktdQqYG+gbfE7vvnTSNcKJ7Thj136Tjw6a1rpwZlpHDSyF14LRmU93OW6Wt/Xrx
         ZCyw7mlgIwlsagLAVomuImTFs3rWyA0IUi8oEcRS26M5R9eVVeAo/A9aLT1wXDCSnqUS
         sO+S8orv/FLrdoq1g17FuUW7QL/ZnpcpvOd6FzNZ0mbSmgPoblPSuAKPp0/h7armIh7s
         Snt/pAyvfPKaRnHKTNu0rueBzL+2qByNCgKJb+iUq9INOLyXklA6biqo3ifdz51qM1U3
         En0w==
X-Gm-Message-State: AC+VfDw1/daNLT+sVCoJGDjqQxswNXAa2pve9+fjlyK4NAHl1fysurEJ
        vBhlOgyl35k5Ubt3DyAL4n5AYvv/cdXtflGZL1c=
X-Google-Smtp-Source: ACHHUZ6rnsFBpiN9nme7mbbJP0DhYYv9kGoecSxJkmZCIm0Cd88zxgPwHK0ei7ug07hVTVmYXUzYCvJEUHGdHz5gbWg=
X-Received: by 2002:a1f:c14e:0:b0:46e:8724:5dbb with SMTP id
 r75-20020a1fc14e000000b0046e87245dbbmr6011900vkf.2.1687416290370; Wed, 21 Jun
 2023 23:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230621144507.55591-1-jlayton@kernel.org> <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-53-jlayton@kernel.org>
In-Reply-To: <20230621144735.55953-53-jlayton@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 22 Jun 2023 09:44:39 +0300
Message-ID: <CAOQ4uxi=KhEQT6nvKga7T8wJ5M8E8owO30KeE8C_E4hmmoUtyA@mail.gmail.com>
Subject: Re: [PATCH 54/79] overlayfs: switch to new ctime accessors
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
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

On Wed, Jun 21, 2023 at 5:54=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Looks ok.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>  fs/overlayfs/file.c | 7 +++++--
>  fs/overlayfs/util.c | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 21245b00722a..b47013d4bd4e 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -239,6 +239,7 @@ static loff_t ovl_llseek(struct file *file, loff_t of=
fset, int whence)
>  static void ovl_file_accessed(struct file *file)
>  {
>         struct inode *inode, *upperinode;
> +       struct timespec64 ct, uct;
>
>         if (file->f_flags & O_NOATIME)
>                 return;
> @@ -249,10 +250,12 @@ static void ovl_file_accessed(struct file *file)
>         if (!upperinode)
>                 return;
>
> +       ct =3D inode_ctime_peek(inode);
> +       uct =3D inode_ctime_peek(upperinode);
>         if ((!timespec64_equal(&inode->i_mtime, &upperinode->i_mtime) ||
> -            !timespec64_equal(&inode->i_ctime, &upperinode->i_ctime))) {
> +            !timespec64_equal(&ct, &uct))) {
>                 inode->i_mtime =3D upperinode->i_mtime;
> -               inode->i_ctime =3D upperinode->i_ctime;
> +               inode_ctime_set(inode, uct);
>         }
>
>         touch_atime(&file->f_path);
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 7ef9e13c404a..e3746f9a202f 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -1202,6 +1202,6 @@ void ovl_copyattr(struct inode *inode)
>         inode->i_mode =3D realinode->i_mode;
>         inode->i_atime =3D realinode->i_atime;
>         inode->i_mtime =3D realinode->i_mtime;
> -       inode->i_ctime =3D realinode->i_ctime;
> +       inode_ctime_set(inode, inode_ctime_peek(realinode));
>         i_size_write(inode, i_size_read(realinode));
>  }
> --
> 2.41.0
>
