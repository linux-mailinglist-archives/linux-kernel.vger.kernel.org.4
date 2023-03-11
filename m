Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A700C6B5ED0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCKRal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCKRaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:30:39 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78945D8A7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:30:36 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id q2so3015579qki.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678555836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uU6dGrt2rIzrhCnJXbaQHOas3xv+F1JDdAfTJ+oW/RQ=;
        b=bvh9trzBAS2l2m1h0HCxqnySScFOuROTEyTiIMTBeF8PQP2OWZqPqWC3cGECLhcwAH
         6anXClkJjl9COgnOAanr4FE3271F1yJqo/9lpTUV6ep6IJQpkiwRWfoU0uoZJCZEqVHi
         ysV2zp6JFgFx+r4XQbRJ435KksJeyyF2JlgJGhe0G5J6XH2E6xs4sYHAMW8XVCqOdMBS
         bW4h09gR02iQfeF+bjjP8LPJqMFDEcHEMWLjSmMSfw+zpO/54/GLaN/qWhXk54lvwbmj
         09Shs0n/oW3/dUfuLdTCzHBKhkqIZZals5Rj5dpXybe/FvZTGTWh3skuEE2aFRyBW20j
         vkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678555836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uU6dGrt2rIzrhCnJXbaQHOas3xv+F1JDdAfTJ+oW/RQ=;
        b=G4bBJ7LutucSEgqcu3pSVbno5ECmNiUEZfNLPIiKNWoFhAqJJkML/6+IbZ7eXp570j
         wHb/UAutt0wxnd6MWFg12TM4MhV3FTLJgElNJRrhzoSXZ0336TgeHLgwH5Aa+LeXYguC
         FowSFlY100qiP0yZ92C3rVxh2KF8Vj2RfCZ8mhR3vnnUIzZBX8RpgXMtSMdyCGA1B2l5
         jC9Tu+Zb0pKzPKWXQMdyvpdtDsXTVOp4+F6HRyEH+IlIINULe7lHg/UJICiABAiRtP0u
         TqDXvmCXnOzWB1jBXhxoW+yr3GsOcxBXgm0sgAODhIDD0ewP02Gm4WHawupX2IT6Qzkv
         Hh7w==
X-Gm-Message-State: AO0yUKVzSG3q1nJD366oRbM70O14NAFFMRY2eFr5w+GgYaEm19fdcbxi
        ALNAd4HIWpEvHvnkqCxvzcgGg9S1MHmHNBnluCOkw17gr8iVaw==
X-Google-Smtp-Source: AK7set+cugWP5zKt6KMIC6m8i+hg8Ut3Qze/upRlJFEFI+Q72RtsBkvvN4MVyja5eqWo2xLoK7aPOAxioOApHIXudEQ=
X-Received: by 2002:a37:64c1:0:b0:72d:4b50:f156 with SMTP id
 y184-20020a3764c1000000b0072d4b50f156mr1491924qkb.14.1678555835734; Sat, 11
 Mar 2023 09:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20230310202619.433269-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20230310202619.433269-1-ivan.orlov0322@gmail.com>
From:   David Kahurani <k.kahurani@gmail.com>
Date:   Sat, 11 Mar 2023 20:30:24 +0300
Message-ID: <CAAZOf27oFt=+DndvUxFLoRM8u_+oUs-Bdtca=yoBT0e-ych3Lw@mail.gmail.com>
Subject: Re: [PATCH] 9P FS: Fix wild-memory-access write in v9fs_get_acl
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, linux-kernel@vger.kernel.org,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com,
        v9fs-developer@lists.sourceforge.net,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 11:28=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.c=
om> wrote:
>
> KASAN reported the following issue:
> [   36.825817][ T5923] BUG: KASAN: wild-memory-access in v9fs_get_acl+0x1=
a4/0x390
> [   36.827479][ T5923] Write of size 4 at addr 9fffeb37f97f1c00 by task s=
yz-executor798/5923
> [   36.829303][ T5923]
> [   36.829846][ T5923] CPU: 0 PID: 5923 Comm: syz-executor798 Not tainted=
 6.2.0-syzkaller-18302-g596b6b709632 #0
> [   36.832110][ T5923] Hardware name: Google Google Compute Engine/Google=
 Compute Engine, BIOS Google 01/21/2023
> [   36.834464][ T5923] Call trace:
> [   36.835196][ T5923]  dump_backtrace+0x1c8/0x1f4
> [   36.836229][ T5923]  show_stack+0x2c/0x3c
> [   36.837100][ T5923]  dump_stack_lvl+0xd0/0x124
> [   36.838103][ T5923]  print_report+0xe4/0x4c0
> [   36.839068][ T5923]  kasan_report+0xd4/0x130
> [   36.840052][ T5923]  kasan_check_range+0x264/0x2a4
> [   36.841199][ T5923]  __kasan_check_write+0x2c/0x3c
> [   36.842216][ T5923]  v9fs_get_acl+0x1a4/0x390
> [   36.843232][ T5923]  v9fs_mount+0x77c/0xa5c
> [   36.844163][ T5923]  legacy_get_tree+0xd4/0x16c
> [   36.845173][ T5923]  vfs_get_tree+0x90/0x274
> [   36.846137][ T5923]  do_new_mount+0x25c/0x8c8
> [   36.847066][ T5923]  path_mount+0x590/0xe58
> [   36.848147][ T5923]  __arm64_sys_mount+0x45c/0x594
> [   36.849273][ T5923]  invoke_syscall+0x98/0x2c0
> [   36.850421][ T5923]  el0_svc_common+0x138/0x258
> [   36.851397][ T5923]  do_el0_svc+0x64/0x198
> [   36.852398][ T5923]  el0_svc+0x58/0x168
> [   36.853224][ T5923]  el0t_64_sync_handler+0x84/0xf0
> [   36.854293][ T5923]  el0t_64_sync+0x190/0x194
>
> Calling '__v9fs_get_acl' method in 'v9fs_get_acl' creates the
> following chain of function calls:
>
> __v9fs_get_acl
>         v9fs_fid_get_acl
>                 v9fs_fid_xattr_get
>                         p9_client_xattrwalk
>
> Function p9_client_xattrwalk accepts a pointer to u64-typed
> variable attr_size and puts some u64 value into it. However,
> after the executing the p9_client_xattrwalk, in some circumstances
> we assign the value of u64-typed variable 'attr_size' to the
> variable 'retval', which we will return. However, the type of
> 'retval' is ssize_t, and if the value of attr_size is larger
> than SSIZE_MAX, we will face the signed type overflow. If the
> overflow occurs, the result of v9fs_fid_xattr_get may be
> negative, but not classified as an error. When we try to allocate
> an acl with 'broken' size we receive an error, but don't process
> it. When we try to free this acl, we face the 'wild-memory-access'
> error (because it wasn't allocated).
>
> This patch will modify the condition in the 'v9fs_fid_xattr_get'
> function, so it will return an error if the 'attr_size' is larger
> than SSIZE_MAX.
>
> Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=3Dfbbef66d9e4d096242f3617de5d1=
4d12705b4659
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  fs/9p/xattr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index 50f7f3f6b55e..d6f7450107a8 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -35,7 +35,7 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const ch=
ar *name,
>                 return retval;
>         }
>         if (attr_size > buffer_size) {
> -               if (!buffer_size) /* request to get the attr_size */
> +               if (!buffer_size && attr_size <=3D (u64) SSIZE_MAX) /* re=
quest to get the attr_size */

I'm not sure what are the rules around here but I prefer to use
brackets more generously.

>
>                         retval =3D attr_size;
>                 else
>                         retval =3D -ERANGE;
> --
> 2.34.1
>
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
