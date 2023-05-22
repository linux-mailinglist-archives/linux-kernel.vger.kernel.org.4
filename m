Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE28E70C320
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEVQR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjEVQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:17:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEF9E9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:17:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d4so62484355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684772273; x=1687364273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjF7AmodWpYPzWumQywJ1RcbwchfRZvgYyZjhVzCXks=;
        b=SsFd3uqH4yfswa8rOzSENP3Y8D+wlZIMXNfRleK0BmAJmZ66QtevHuB68n4x/zg7sk
         oGsUCoFPqureCcGQ7ydT0XG6ZtAZXThnmwlWOMJxi6USShr6ik3mrTr/552oIsCeaR2/
         ZaEWwxT+KNPOG5gsWMUM00+UAykNpMgbiSm4wNX/E/Lcyqxon4/0bQsZg7E6cnhcXBbl
         VVXZouQ/DR1dC0S4Or25SN9A1QEgQgXsoonGwWshmrddQaOskbVI6ku8w/Wzg6Hy59F6
         O8gY5LRWY+o4Uees0t4m1qs9FF+tBAAGUqLGpu07tSy1tfkDoyM3hzZgN5oWHkgQVJS8
         JO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772273; x=1687364273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjF7AmodWpYPzWumQywJ1RcbwchfRZvgYyZjhVzCXks=;
        b=PvBTBHjTxJPMPabzMCVFCc25cYRZkbFafHbtwj/b8tXWlevHsm78VKZ7YCHJIr9d+w
         xJdRUQ4JqNSgXPinU25mlTur1Fnhm3DiX7h7T5SrGJHP9q2+lXpipC8pJQHaSQXUtqbz
         3SrEsVyWCoa860Zxz2zwQu1xVbYl5ffwI9FIApvsaOEbjVdMNMRfbQRQqLSYvMNfzSkq
         B2MbzolfL3xSmsJHAmqjEXOpP5xZ7zVXUloe/Ai60WAQk3jCQlENe4tBTDyGoO0cpOoJ
         qJchfotZB8JFc15lQo5ktr8BApVYnMCObqpg0eXSZr57dLEXU7moiuDgtAitfyNpyQhu
         d6tQ==
X-Gm-Message-State: AC+VfDyMkn7jJSesKIH2cSE3Db6dWaWMB0S7BtKjWGZWE4zj59FafJl9
        P3+1sS997A9vwRPyRQHxc1/WVlwO2C+enT/ohKk=
X-Google-Smtp-Source: ACHHUZ5b3bJQmLpG4qDUw1k45rP7BqnvH6+KN75Gz0nYxOPKhd0/CbLaevEmOX6svyVc6dEF45hjP4VPuV07uPiXHMw=
X-Received: by 2002:a7b:c3ce:0:b0:3f5:db0f:4967 with SMTP id
 t14-20020a7bc3ce000000b003f5db0f4967mr8312478wmj.16.1684772272828; Mon, 22
 May 2023 09:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230509014136.2095900-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230509014136.2095900-1-azeemshaikh38@gmail.com>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Mon, 22 May 2023 12:17:41 -0400
Message-ID: <CADmuW3W9yjZqfCszZvKRGSuPzuriT2gH+3YaPDaUVu=Xvz9+Lg@mail.gmail.com>
Subject: Re: [PATCH] befs: Replace all non-returning strlcpy with strscpy
To:     keescook@google.com, Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping.

On Mon, May 8, 2023 at 9:41=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.co=
m> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated.
> In an effort to remove strlcpy() completely, replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> ---
>  fs/befs/btree.c    |    2 +-
>  fs/befs/linuxvfs.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/befs/btree.c b/fs/befs/btree.c
> index 1b7e0f7128d6..53b36aa29978 100644
> --- a/fs/befs/btree.c
> +++ b/fs/befs/btree.c
> @@ -500,7 +500,7 @@ befs_btree_read(struct super_block *sb, const befs_da=
ta_stream *ds,
>                 goto error_alloc;
>         }
>
> -       strlcpy(keybuf, keystart, keylen + 1);
> +       strscpy(keybuf, keystart, keylen + 1);
>         *value =3D fs64_to_cpu(sb, valarray[cur_key]);
>         *keysize =3D keylen;
>
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index 32749fcee090..eee9237386e2 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -374,7 +374,7 @@ static struct inode *befs_iget(struct super_block *sb=
, unsigned long ino)
>         if (S_ISLNK(inode->i_mode) && !(befs_ino->i_flags & BEFS_LONG_SYM=
LINK)){
>                 inode->i_size =3D 0;
>                 inode->i_blocks =3D befs_sb->block_size / VFS_BLOCK_SIZE;
> -               strlcpy(befs_ino->i_data.symlink, raw_inode->data.symlink=
,
> +               strscpy(befs_ino->i_data.symlink, raw_inode->data.symlink=
,
>                         BEFS_SYMLINK_LEN);
>         } else {
>                 int num_blks;
>
