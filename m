Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1477B689450
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjBCJsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjBCJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:48:16 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA4929E21
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 01:48:15 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so4436768pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 01:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Di8uxwcyossGWtUe28ylNS6d/iqeqZOSW9Fc0lEwyw=;
        b=KY708oCojclC3sfqe2XOlsqg3+dwwINyrrxL9hMltB4CcVqSut1fgMFdNtDqQAYVEh
         64i/bR69PHgUrKoomqzp+Nr3rmyW6EU7OryjXeUUfm/5XX+MC5U50xmrxd54z2VuvDDs
         7KepZNi/7MXiyJwHz6PXtTgbXQHF3k13x/tsgIHtC1BpH/7FM9a7Q7D0jCAKTImBJcmi
         aJRU+yI3wRDU4cy/xJKCW7acAlre2COvtr+yuCH6hQZMrCoxX6/Dj+4JsdHeW0NESyBr
         cATKTf9uSeeS8cjEm82XyG1VA3kBGwPjC+jlLf6xpvta7dHngmM11NI1CbqbLvNOYJml
         KKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Di8uxwcyossGWtUe28ylNS6d/iqeqZOSW9Fc0lEwyw=;
        b=Iro++PQR8ksH7LgGn/POMbMi7ylv/cKWWBlvNLSiWvdOVPsQ6JFDfdx69JZ9RM6vFA
         1UlogtOsst24OSyVqBYgfeWCmdQEu9GFOY5FRB/B+EuUoORhFFcBtK8RyqdDP3Efto+S
         ksEJUSmNkhP2Br5aWE4uOV5/T0crQMEYNxCbU83V6X5GPfrkwwcBBIF6DxD0cNN+fQGw
         ad+hMvBC62LOloxKd1M2/CHJSxu2FRiiDk8rWl31PHnnbceQURDAtiC5zOyGFO+E48/i
         tcJ+cVFKjh7lR0trGFKauBRODoktWCD50UjEJAUEecKOe84lMyV3NdjDTa+zjkihpQbx
         RvTQ==
X-Gm-Message-State: AO0yUKUsJ+Suuh3p7f6LRz67krok9kereL1cRltqj7LOtTgnrhJFnSr8
        gdHOLGODlHHvCzTon+uRiBa/qzR118GjvQGxT8Y=
X-Google-Smtp-Source: AK7set/aUCqTMuYIbzquzupIRAG3f/VdfWUi7+s1FzynLXy3OY5FGKjIPYfCqrLUG/v3GlF+0QqP2M4IchizYN0jVnA=
X-Received: by 2002:a17:90a:74c4:b0:22b:f34a:1f52 with SMTP id
 p4-20020a17090a74c400b0022bf34a1f52mr1141397pjl.76.1675417695053; Fri, 03 Feb
 2023 01:48:15 -0800 (PST)
MIME-Version: 1.0
References: <20230112071842.819123-1-korantwork@gmail.com>
In-Reply-To: <20230112071842.819123-1-korantwork@gmail.com>
From:   Xinghui Li <korantwork@gmail.com>
Date:   Fri, 3 Feb 2023 17:49:09 +0800
Message-ID: <CAEm4hYX3Db4NW+zkuwPep5CF3=ojXxKHPrEB+erOeA+o8d+4FQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/mmu: Fix an UAF issue in NVKM
To:     bskeggs@redhat.com, kherbst@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Xinghui Li <korantli@tencent.com>,
        loydlv <loydlv@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi all
friendly ping...

<korantwork@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8812=E6=97=A5=E5=91=A8=
=E5=9B=9B 15:18=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Xinghui Li <korantli@tencent.com>
>
> In nvkm_mem_new_host, the mem is be alloced. And mem->memory is
> assigned to pmemory. During this process, the mem will be free if
> the error occurs. But the *pmemory still points to the &mem->memory
> which has been relased.Laterly, the nvkm_memory_unref will put the
> memory which points to the pmemory again.So, we set the *pmemory to
> NULL to avoid UAF issue.
>
> Reported-by: loydlv <loydlv@tencent.com>
> Signed-off-by: Xinghui Li <korantli@tencent.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c b/drivers/gpu/=
drm/nouveau/nvkm/subdev/mmu/mem.c
> index 92e363dbbc5a..ab30eb1fc0a3 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mem.c
> @@ -185,6 +185,7 @@ nvkm_mem_new_host(struct nvkm_mmu *mmu, int type, u8 =
page, u64 size,
>         } else
>         if ( (ret =3D nvif_unvers(ret, &argv, &argc, args->vn))) {
>                 kfree(mem);
> +               *pmemory =3D NULL;
>                 return ret;
>         }
>
> --
> 2.31.1
>
