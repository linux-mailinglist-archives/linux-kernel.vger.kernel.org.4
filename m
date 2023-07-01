Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C427446C3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 07:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGAFYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 01:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGAFYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 01:24:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF94204;
        Fri, 30 Jun 2023 22:24:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b5c231c23aso42708831fa.0;
        Fri, 30 Jun 2023 22:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688189042; x=1690781042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWSfT3e2CdHXT3PPccjwI1PvUkLEKr2RqsUNIeb0KVU=;
        b=dv4BNmhKurSjr4SFlv7PvcW3oxS+o5nRZ0A8lZkOheALgd3YqDXfLTZeSoDO3TwBO4
         HeowMn4na6OlBLRtOwoXYQ9LpIT6ZY/iOzYi2Nn5U0IkAUbGVj/fVT6eU9tM/XYiM68U
         7+00JLc0mja0wzB2ItiXGm0kOMLiyTqLhi6UXs6Eb24uspVLE18y8n8X7jtCqxmDPO9W
         uzMm8WlrJxeJguV4qoXVRw6siOUYOkaKFRN5cXEPz8JN/lUMzKzHr2Lj68wXrp1YJTr7
         rtSrycUqnjmq5hSVc8EzFqhtwWoFfNri+c0UhLgeHAPcxIa1AhcDfjVDdAB8acEuPM8+
         CWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688189042; x=1690781042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWSfT3e2CdHXT3PPccjwI1PvUkLEKr2RqsUNIeb0KVU=;
        b=KgJI3wBoEri1AT0CBoYlk7V+J2zH/956Cce5ZQ9C19cBkR6bLMxS/8ALQq3JP3+mGE
         fOUY3c3iP+kAdMuPvp2wpP054tOOj+/U/C/MFK09ETEjnYL5E3z39GigQWkzcxiDUqq1
         Dy4db4jHYUZzKIloGLHkT0fg7ydYBQAEgmwVbJ7MzRIqeYRVWRPSinsaFlqnT6T2fXoU
         QSodpBfEkArtdyB2SA57J3sZLkRKaQkIFYBwxWBusYGWOMMiLiVeIJNARydSmRczOrr3
         uKjpfib8sbvR+mOOz4lpDKMBKhank+BHpx3Ymk0kGd9oO0cbXFx++a+r7scMe4LK815I
         WGGQ==
X-Gm-Message-State: ABy/qLZllEm2bXdc3hosbrIFJlTm3xH7wKjEFuY6417sUBzAEaxKypEH
        rEm8kgIdrEk2OWPubgmYSCZNmqcHU5dr+oBKI2E=
X-Google-Smtp-Source: APBJJlGmNEZoTcJGC2KNmbJoTnMMgs2JN1FJjXl5qHsHC2/aeL9kSCLBqESKoi5FjagfbSLqnN3Yag9zoRE0fvq0Xs8=
X-Received: by 2002:a2e:88c8:0:b0:2b6:ca1d:ee88 with SMTP id
 a8-20020a2e88c8000000b002b6ca1dee88mr3354057ljk.12.1688189042086; Fri, 30 Jun
 2023 22:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230630113337.123257-1-colin.i.king@gmail.com>
In-Reply-To: <20230630113337.123257-1-colin.i.king@gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 1 Jul 2023 00:23:50 -0500
Message-ID: <CAH2r5mvkWeMO-AoPEpDbeKy8_K5hz3nJL3-BPh+w4Dow0qoOkg@mail.gmail.com>
Subject: Re: [PATCH][next] smb: client: remove redundant pointer 'server'
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

merged into cifs-2.6.git for-next

On Fri, Jun 30, 2023 at 6:35=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> The pointer 'server' is assigned but never read, the pointer is
> redundant and can be removed. Cleans up clang scan build warning:
>
> fs/smb/client/dfs.c:217:3: warning: Value stored to 'server' is
> never read [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/smb/client/dfs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
> index 26d14dd0482e..1403a2d1ab17 100644
> --- a/fs/smb/client/dfs.c
> +++ b/fs/smb/client/dfs.c
> @@ -143,7 +143,6 @@ static int __dfs_mount_share(struct cifs_mount_ctx *m=
nt_ctx)
>         struct smb3_fs_context *ctx =3D mnt_ctx->fs_ctx;
>         char *ref_path =3D NULL, *full_path =3D NULL;
>         struct dfs_cache_tgt_iterator *tit;
> -       struct TCP_Server_Info *server;
>         struct cifs_tcon *tcon;
>         char *origin_fullpath =3D NULL;
>         char sep =3D CIFS_DIR_SEP(cifs_sb);
> @@ -214,7 +213,6 @@ static int __dfs_mount_share(struct cifs_mount_ctx *m=
nt_ctx)
>         } while (rc =3D=3D -EREMOTE);
>
>         if (!rc) {
> -               server =3D mnt_ctx->server;
>                 tcon =3D mnt_ctx->tcon;
>
>                 spin_lock(&tcon->tc_lock);
> --
> 2.39.2
>


--=20
Thanks,

Steve
