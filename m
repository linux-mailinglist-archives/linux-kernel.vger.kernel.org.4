Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1F71588A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjE3IbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjE3IbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:31:03 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9981AA8;
        Tue, 30 May 2023 01:31:00 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-456d534f403so2710102e0c.2;
        Tue, 30 May 2023 01:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685435459; x=1688027459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAlYUMVoTgINlE2ocSHP8Vr62dJ4pHluRJc9g9INcEU=;
        b=D47tqMBFjsl7TeJNaoYnAx0DNSZPSt4iFNajnB+Qh43GFOewu5Lr8jW30kJreXspQK
         xOQb7Y0Y8e/Cpg7RTKEbv4zppgP0XUxK4a2zO7ybOOXO2VuycuYtYhmGhE+U8hCINRLa
         extr6N2yXJdI7IzPgUotVJ/f879fBC9Y6PkMlmSkMI3jUaaMori4u3jo//QpMD0yE4qm
         nzPnskNMm/RRtjkmaDdvBT2GomzMdZHsWE9q9is5kqcVV6dPcI+9PHHefEZj6qeClcog
         uxq2MZfHdU5i4vK5t5E+W/LsZVvvV1aAyI9QFqlYv8DRisy2D2s1GH2lhtvL79p3kDnf
         USHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685435459; x=1688027459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAlYUMVoTgINlE2ocSHP8Vr62dJ4pHluRJc9g9INcEU=;
        b=VbH8k16zAlAf5VovPLRCr7AM+JJx61gWZyC2nR8bbixNKImHUoWjIt+8nj1ZoLJkro
         Ox2MGmHZmTxvYgoUjY3yCFSrTIDXnnmWNmVNNgXe1nWcjhYBm4V1JoLUfXUpwrX5oM1F
         958uS/Cp0NjR94yjF78x5w6nKAraA+YF4yE8vTzJ2puiB8y3AKXRnVFM78v9fQOL7tTk
         M2Qh5xgC+Y93jY6eMTH+kH4G+X7zaKzcchWUfM2q0cTR2fVfHCXCfHtw7AqdgEWzCLBz
         PnWkebP55R8Pspq4jvD1k2HBVYmb+Dk4KVZozA1wvPG6AlD5U3TXtHi9kTvgARpJuVeR
         WxTA==
X-Gm-Message-State: AC+VfDwtANECLu6WifuYuuqN8vM2EUSXt3WLJLGCKlgKBhjuL5rwftaS
        u08MTsBMOqh5Jvcpn6wcNyoH1e9079lk5wJeeWg=
X-Google-Smtp-Source: ACHHUZ7U5uvuaRU2XQx3fWPq48tXSMo+4gvRAtJWWGsNOucGTPfPvzlMCOGgwinW52VweuMJvCobK+Kc5tdm+cWSWa4=
X-Received: by 2002:a67:ff08:0:b0:439:4284:3f74 with SMTP id
 v8-20020a67ff08000000b0043942843f74mr460985vsp.16.1685435459529; Tue, 30 May
 2023 01:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230530022917.18574-1-listdansp@mail.ru> <20230530022917.18574-2-listdansp@mail.ru>
In-Reply-To: <20230530022917.18574-2-listdansp@mail.ru>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 May 2023 11:30:48 +0300
Message-ID: <CAOQ4uxgCizoAT1fWLKy6hytdhBiCwV0nSwkqzyVckozx5EACPA@mail.gmail.com>
Subject: Re: [PATCH 5.10 1/1] ovl: fail on invalid uid/gid mapping at copy up
To:     Danila Chernetsov <listdansp@mail.ru>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>
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

On Tue, May 30, 2023 at 5:44=E2=80=AFAM Danila Chernetsov <listdansp@mail.r=
u> wrote:
>
> From: Miklos Szeredi <mszeredi@redhat.com>
>
> commit  4f11ada10d0ad3fd53e2bd67806351de63a4f9c3 upstream.
>
> If st_uid/st_gid doesn't have a mapping in the mounter's user_ns, then
> copy-up should fail, just like it would fail if the mounter task was doin=
g
> the copy using "cp -a".
>
> There's a corner case where the "cp -a" would succeed but copy up fail: i=
f
> there's a mapping of the invalid uid/gid (65534 by default) in the user
> namespace.  This is because stat(2) will return this value if the mapping
> doesn't exist in the current user_ns and "cp -a" will in turn be able to
> create a file with this uid/gid.
>
> This behavior would be inconsistent with POSIX ACL's, which return -1 for
> invalid uid/gid which result in a failed copy.
>
> For consistency and simplicity fail the copy of the st_uid/st_gid are
> invalid.
>
> Fixes: 459c7c565ac3 ("ovl: unprivieged mounts")
> Cc: <stable@vger.kernel.org> # v5.11
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Reviewed-by: Seth Forshee <sforshee@kernel.org>
> Signed-off-by: Danila Chernetsov <listdansp@mail.ru>
> ---
>  fs/overlayfs/copy_up.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index e466c58f9ec4..fd33abc0edc0 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -882,6 +882,10 @@ static int ovl_copy_up_one(struct dentry *parent, st=
ruct dentry *dentry,
>         if (err)
>                 return err;
>
> +       if (!kuid_has_mapping(current_user_ns(), ctx.stat.uid) ||
> +           !kgid_has_mapping(current_user_ns(), ctx.stat.gid))
> +               return -EOVERFLOW;
> +
>         ctx.metacopy =3D ovl_need_meta_copy_up(dentry, ctx.stat.mode, fla=
gs);
>
>         if (parent) {
> --
> 2.25.1
>

You are requesting to backport to kernel 5.10.y a fix to a bug that is tagg=
ed as
introduced in 5.11 with overlayfs unprivileged mounts.

IOW, in kernel 5.10, current_user_ns() would always be init_user_ns.

Am I missing something?

Thanks,
Amir.
