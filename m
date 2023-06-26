Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72A073D782
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFZGFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZGE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:04:59 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA51E43;
        Sun, 25 Jun 2023 23:04:57 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b6a0e36d42so6783831fa.0;
        Sun, 25 Jun 2023 23:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687759496; x=1690351496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRzA00mW8CNPeSjOYnfOo/k2tz+feJKv1fb5abFoakE=;
        b=LW5BAvIGgoZTymEBol9h5hWrvrVzCM1d41P8v5PcNMGy2gs5Bf/hLBTfrrgzCoPvDr
         ADZmahrsfN3IrzzT8BTrFZOd3Et0lgIYPxDssoSzaIanaeW2NcPo2t/ID6AKv2/ZYpAf
         XDQm4/f+LnV9BHNQ77wNBMoNBkBRZGfZGETHbi4A41B92bLxmhARTvZeXzKR02t4izx0
         K2XMHf0DBsxL1YaRjFJhcVVdlq/bdfjdCgRk42zWQWwrbQ6Ggtj+krSdYGDcEe2Ogi2+
         S+/jaVQVd4zTyx1ksmmFXRTnqgC7ftdzV50IWQjixg7u+dFDsJ3DSQ5cGOtwaBg4ubaR
         PAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687759496; x=1690351496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRzA00mW8CNPeSjOYnfOo/k2tz+feJKv1fb5abFoakE=;
        b=jNYgfSAuquG9BF+9luzKJ00CgmYDNL2jNP70klEBPzXqA63CXciReFa3Yly2h53jS0
         ovsWSyOHUiA6edjG33jhZ9s4I05r8ER88XKf30xZ7gPsTxFsVhZHVgA3OIqbziNfB/IX
         8hjaWc4ITqrwZDG7kv76dVl2pNqkrGBLQVmbXvQPIgrFlwgPkPwlGGE9jveE5G5GdBeW
         Y6nW+mlDZvGfJheKaxgYcUVwrRhC5eRYP+94bowOjVKgKcRy26Z3iRqxD8oczgrhmFKl
         m90MKKChzcOhVQ/CCqv5vFMCmi4+YMDcNS4Q2aytfbF8WXTrl3RAKRSb8sIBsqPZl/zY
         uiiQ==
X-Gm-Message-State: AC+VfDxjXxM1+s56GXyrbTxz6z5QNLFjKQTLypb4YG0bmJk5BF56/XHY
        2cWUCxSPZ+NQTmspFPEhvgCry3E/q+jW/hi5T7OP2y7MOidqraak
X-Google-Smtp-Source: ACHHUZ6Yanpf7c1LHl9o4QfReVS9VuvFFMvtOM/KU28kWJ8zcPyY5B918xS0PiaKa7+L0J1Tv2PAIOG9PAMt9NYfjyo=
X-Received: by 2002:a05:6512:2206:b0:4f9:7330:66ef with SMTP id
 h6-20020a056512220600b004f9733066efmr2399491lfu.25.1687759495953; Sun, 25 Jun
 2023 23:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230623213406.5596-1-risbhat@amazon.com> <20230623213406.5596-4-risbhat@amazon.com>
In-Reply-To: <20230623213406.5596-4-risbhat@amazon.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Mon, 26 Jun 2023 11:34:44 +0530
Message-ID: <CANT5p=o3KqnxfLEuJ+veVaK1EdYJapevP60oCSS76-UhuQ101w@mail.gmail.com>
Subject: Re: [PATCH 5.4 3/5] cifs: Introduce helpers for finding TCP connection
To:     Rishabh Bhatnagar <risbhat@amazon.com>
Cc:     gregkh@linuxfoundation.org, pc@cjr.nz, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
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

On Sat, Jun 24, 2023 at 3:14=E2=80=AFAM Rishabh Bhatnagar <risbhat@amazon.c=
om> wrote:
>
> From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>
>
> commit 345c1a4a9e09dc5842b7bbb6728a77910db69c52 upstream.
>
> Add helpers for finding TCP connections that are good candidates for
> being used by DFS refresh worker.
>
> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> Reviewed-by: Aurelien Aptel <aaptel@suse.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
> ---
>  fs/cifs/dfs_cache.c | 44 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
> index 3ca65051b55c..31b3dc09e109 100644
> --- a/fs/cifs/dfs_cache.c
> +++ b/fs/cifs/dfs_cache.c
> @@ -1305,6 +1305,30 @@ static char *get_dfs_root(const char *path)
>         return npath;
>  }
>
> +static inline void put_tcp_server(struct TCP_Server_Info *server)
> +{
> +       cifs_put_tcp_session(server, 0);
> +}
> +
> +static struct TCP_Server_Info *get_tcp_server(struct smb_vol *vol)
> +{
> +       struct TCP_Server_Info *server;
> +
> +       server =3D cifs_find_tcp_session(vol);
> +       if (IS_ERR_OR_NULL(server))
> +               return NULL;
> +
> +       spin_lock(&GlobalMid_Lock);
> +       if (server->tcpStatus !=3D CifsGood) {
> +               spin_unlock(&GlobalMid_Lock);
> +               put_tcp_server(server);
> +               return NULL;
> +       }
> +       spin_unlock(&GlobalMid_Lock);

We've moved away from using GlobalMid_Lock for anything other than MIDs.
Please use server->srv_lock instead.

> +
> +       return server;
> +}
> +
>  /* Find root SMB session out of a DFS link path */
>  static struct cifs_ses *find_root_ses(struct vol_info *vi,
>                                       struct cifs_tcon *tcon,
> @@ -1347,13 +1371,8 @@ static struct cifs_ses *find_root_ses(struct vol_i=
nfo *vi,
>                 goto out;
>         }
>
> -       server =3D cifs_find_tcp_session(&vol);
> -       if (IS_ERR_OR_NULL(server)) {
> -               ses =3D ERR_PTR(-EHOSTDOWN);
> -               goto out;
> -       }
> -       if (server->tcpStatus !=3D CifsGood) {
> -               cifs_put_tcp_session(server, 0);
> +       server =3D get_tcp_server(&vol);
> +       if (!server) {
>                 ses =3D ERR_PTR(-EHOSTDOWN);
>                 goto out;
>         }
> @@ -1451,19 +1470,18 @@ static void refresh_cache_worker(struct work_stru=
ct *work)
>         mutex_lock(&vol_lock);
>
>         list_for_each_entry(vi, &vol_list, list) {
> -               server =3D cifs_find_tcp_session(&vi->smb_vol);
> -               if (IS_ERR_OR_NULL(server))
> +               server =3D get_tcp_server(&vi->smb_vol);
> +               if (!server)
>                         continue;
> -               if (server->tcpStatus !=3D CifsGood)
> -                       goto next;
> +
>                 get_tcons(server, &list);
>                 list_for_each_entry_safe(tcon, ntcon, &list, ulist) {
>                         refresh_tcon(vi, tcon);
>                         list_del_init(&tcon->ulist);
>                         cifs_put_tcon(tcon);
>                 }
> -next:
> -               cifs_put_tcp_session(server, 0);
> +
> +               put_tcp_server(server);
>         }
>         queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
>         mutex_unlock(&vol_lock);
> --
> 2.40.1
>


--=20
Regards,
Shyam
