Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDE70BB97
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjEVLUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjEVLTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:19:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495B030EE
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684753997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kd+PsvNileg5XRg62rxcYULjvxE2s9HN/H5lXiFohgM=;
        b=ZldgP6g1wMg9ZwUuT0LFCDkYESJO3o/KRPCubhQuBeTXIOeVnC7XA6v/cJVR6RyDBMdCjM
        tqUxwbBQRoarQB4oxE5I3UL5jI3/HpJK7EP0NM/7+2FEn5+tLH2b5GQROC4sSFKkRTxl/V
        wA+T+lamGN8Zjiah/JSOJ+FP70H9CGg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-fH3_xup-PK2y2WIktY1xcw-1; Mon, 22 May 2023 07:13:15 -0400
X-MC-Unique: fH3_xup-PK2y2WIktY1xcw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f24f491835so235741e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753994; x=1687345994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kd+PsvNileg5XRg62rxcYULjvxE2s9HN/H5lXiFohgM=;
        b=TwaOxQ6eAYoWcswT2J1eXGDVN4eNR/VSktCPBBkXg2UqvFSLmdCfkh5dlUDO0nKIm7
         CnEdKEKuYBoHv1hyyqLMLghJUuWiuN8Ry7YUgchHXq6TPDLv0akSuAojsda8zc+nqwpg
         7ZidZx2FCDMJlLwkjhiY/WmjpqgK5XRHfxOOQ3QdCEIJvVhVKY35qqCDLBhu+3NgVMF+
         4aSn7D/m4HajI4QZrdY1G6Vreiik9jOZfg3+lAkYQRol51uZHQOeGXiwsM9BC6As3bXh
         4tXVBA1PO8be21vMvl84rALlOR+lz/m9YnMs4f1iyrW9bUeq7JNd5toL+UZQk6AyJ17O
         iODw==
X-Gm-Message-State: AC+VfDxgW69w/srtC23+4L69R0bTrpW3QbS9i9xQ8S0LZ0brgzdvEzTn
        JjJgSZpt6zRv7tlyw4WWmYaGchovpeF/8RQ0kZlw5jO0gAo6qmgD0TV9pgUO3qLgnpzbUNMuh7A
        ZlmxRMsm3vA93lq9c1faKDPMKIf3d+rlJtbOmVEOH
X-Received: by 2002:a2e:a37a:0:b0:2af:150f:d421 with SMTP id i26-20020a2ea37a000000b002af150fd421mr3749244ljn.5.1684753994431;
        Mon, 22 May 2023 04:13:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4+vYH0Nc1ESK4QTZEtrWsGcanm7ymTNCOr4z8IJm7Iru4aBRqsqfYh/jPAqeDcjuMGqcwQ1DLogJOpk7PIIHY=
X-Received: by 2002:a2e:a37a:0:b0:2af:150f:d421 with SMTP id
 i26-20020a2ea37a000000b002af150fd421mr3749226ljn.5.1684753994119; Mon, 22 May
 2023 04:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230517133112.873856-1-trix@redhat.com>
In-Reply-To: <20230517133112.873856-1-trix@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 22 May 2023 13:13:02 +0200
Message-ID: <CACO55tvx_45D6Jnj_HhL0H9DQ-=PezGqucDQ-=-6JD9s_aAZMg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acr/ga102: set variable ga102_gsps
 storage-class-specifier to static
To:     Tom Rix <trix@redhat.com>
Cc:     bskeggs@redhat.com, lyude@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch, gsamaiya@nvidia.com,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Wed, May 17, 2023 at 3:31=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> smatch reports
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c:49:1: warning: symbol
>   'ga102_gsps' was not declared. Should it be static?
>
> This variable is only used in its defining file, so it should be static
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c b/drivers/gp=
u/drm/nouveau/nvkm/subdev/gsp/ga102.c
> index 525267412c3e..a3996ceca995 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c
> @@ -45,7 +45,7 @@ ga102_gsp_nofw(struct nvkm_gsp *gsp, int ver, const str=
uct nvkm_gsp_fwif *fwif)
>         return 0;
>  }
>
> -struct nvkm_gsp_fwif
> +static struct nvkm_gsp_fwif
>  ga102_gsps[] =3D {
>         { -1, ga102_gsp_nofw, &ga102_gsp },
>         {}
> --
> 2.27.0
>

