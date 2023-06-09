Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B84729928
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjFIMKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbjFIMK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3728A198C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686312583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3YEGdNvp8HrOlSgpTvQVmaRiPOQzGrP0bC+OvJCrwQ=;
        b=ZK3o4OGs5x4PjWSXrc8QPRbVeegBGkDhhaUVMxdrMRswHugw8I1J4nFlFJe6XuoowGdy9h
        SuNr13xeoAMbnEYZ7A6nZjopptpHV0nI2aRDKx0j+lqECDa5RwUYDil6wanYRPJveMYxAm
        JAvPBsKHWnOjqp8TkQDvj5j3Qbf8ssg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-YaJW2m2dMuulwUaMZzShYg-1; Fri, 09 Jun 2023 08:09:41 -0400
X-MC-Unique: YaJW2m2dMuulwUaMZzShYg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so1157491fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312580; x=1688904580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3YEGdNvp8HrOlSgpTvQVmaRiPOQzGrP0bC+OvJCrwQ=;
        b=U5vIPD4kzpWXncwESdggNl+X8O3k93+C35Qc0NUkQ7tBg9JQJeQAoVoSOGLwNEXqLK
         3yztEbhRuJpSAw9DFIN/FxTAxueNXOuPOZCsn+FdvyvvPuTwk08sKf2PEBmlf6AdI2m5
         JwUTqnXB8xqYcE2+LRD29XmT08NQeuhd0WlcplzcpNvJuSjz9tNm0vqJ1yH1hcW32UOr
         oLCTsHWsy0VAlzprDH9IDtNCTm1RpjtLeNiX6ncQblkicTkPzeY7FHqoE44vaPeByXmU
         ZSxuB9WxHZz7giv7I7n9oF0OI22imjxMRB8zRfgDlpOG5EudgblZI1zdI+KbmZeNIEXk
         8BBQ==
X-Gm-Message-State: AC+VfDwHqCqWkXwE75HCsECaSMN7paB3IfbfGm9Nwduq5Jp+n6ZF22L/
        5CwQwq2aed4CW+5E0z55uLiUt+CZN+z27MF5vIMRNX24QU0+K6G45SHWSooTrFWw7+JVjv9C1c3
        gQDQkdfxPbgFQeznE+LqjUm/vfn6/LBoThZjNPDGz
X-Received: by 2002:a2e:aa1c:0:b0:2b1:e724:4d08 with SMTP id bf28-20020a2eaa1c000000b002b1e7244d08mr988056ljb.4.1686312580322;
        Fri, 09 Jun 2023 05:09:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/t2tD8MaFXp12L6CGZR5hbVtX9aWeEyd2gjiDmsXx5pBr/sPbrekf6193BsmLX+ZVCnheOQK5h1GW9Ht/eq8=
X-Received: by 2002:a2e:aa1c:0:b0:2b1:e724:4d08 with SMTP id
 bf28-20020a2eaa1c000000b002b1e7244d08mr988048ljb.4.1686312580168; Fri, 09 Jun
 2023 05:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230609081732.3842341-1-lee@kernel.org> <20230609081732.3842341-11-lee@kernel.org>
In-Reply-To: <20230609081732.3842341-11-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 9 Jun 2023 14:09:29 +0200
Message-ID: <CACO55tuaNOYphHyB9+ygi9AnXVuF49etsW7x2X5K5iEtFNAAyw@mail.gmail.com>
Subject: Re: [RESEND 10/15] drm/nouveau/nvkm/engine/gr/tu102: Staticify local
 function gf100_fifo_nonstall_block()
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:18=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c:210:1: warning: no previo=
us prototype for =E2=80=98tu102_gr_load=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/gr/tu102.c
> index 3b6c8100a2428..10a7e59482a6f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> @@ -206,7 +206,7 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, stru=
ct gf100_gr_pack **ppack)
>         return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
>  }
>
> -int
> +static int
>  tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *=
fwif)
>  {
>         int ret;
> --
> 2.41.0.162.gfafddb0af9-goog
>

