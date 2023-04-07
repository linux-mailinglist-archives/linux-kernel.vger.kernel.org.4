Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E756DB711
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjDGXQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDGXQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:16:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0628011C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680909319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDqv07q4EW3FaIE3tiwTcIZKESozldm9Lvt1N22Zwwk=;
        b=V8C2EaZuiGPlFnAvE9vcgc1M11p89lP12z6RJd+kq+6i9WW9uxYSeZV/m0hb8UQBro+rmn
        sUwhVFTeaTv+oS6MTEU8cA6dX8ZEwsukx/t2XXpImRhIeJ67mF1q1g/OywrrZlEhYZeqqv
        h+o6pFgd6LluYVGQiguDvwHYnZjEvzg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-6LknfumePK-GtO0bz5Er_A-1; Fri, 07 Apr 2023 19:15:18 -0400
X-MC-Unique: 6LknfumePK-GtO0bz5Er_A-1
Received: by mail-qt1-f197.google.com with SMTP id s23-20020a05622a1a9700b003e6578904c3so11093754qtc.17
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 16:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680909318; x=1683501318;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gDqv07q4EW3FaIE3tiwTcIZKESozldm9Lvt1N22Zwwk=;
        b=5/oayW+u5/quVKHdYjjx7Jrnz3H3e6XPvvTyLOIBSyNK98zRVRnQ+iObpvjGimbjNK
         Gt+B9XJC/bXXTh/QUWIiWcB/WTmbo0pxT5nRYgJE8szuBQw+DXdBUktZoyZkfBEPkc+X
         Gd0EueFT7uzmPOcabQZPu7Jg2iVjzT0h91qdItiPQ+I6lPK0KmPpzZgQaCTucwNjgbrm
         TlJCKQO6phnZvYyUzkDdZTCHyGEZHOUuPGi5fUlvaI/1THZgsSMS5fJOrQGS/Z2e4yuJ
         Lx4lGloR7aj3vp77bUN0PeRvvo/GTzAS5cupkM8ru2WZPghttiWUynoBrdQmppcNMCAA
         Rtgg==
X-Gm-Message-State: AAQBX9d0+cj3CDJl0LcHM9mfwQLZXY3YdLvU/pPX2Tg6qcRxrjSsArgm
        24Hvpr2hhPsP7aUwWydYXS3wlpmOe4MlgPJipDHRcJAGcBs+RnE7qV8EDtrsZl/IMw5VVizE5Kr
        SfMnNApCtpqcMwAmkq0rKbu4b
X-Received: by 2002:a05:622a:1818:b0:3db:fba6:53f8 with SMTP id t24-20020a05622a181800b003dbfba653f8mr6591179qtc.25.1680909318260;
        Fri, 07 Apr 2023 16:15:18 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZdgxF2YkJyao35TIkGn0N7Mvwz1VbA4EtERvx/JG60e/RP0fMnaunGlYblEzKjanOkDS6r8Q==
X-Received: by 2002:a05:622a:1818:b0:3db:fba6:53f8 with SMTP id t24-20020a05622a181800b003dbfba653f8mr6591161qtc.25.1680909318047;
        Fri, 07 Apr 2023 16:15:18 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id x78-20020a376351000000b007466432a559sm1632908qkb.86.2023.04.07.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:15:17 -0700 (PDT)
Message-ID: <bcf9a62b87e4d46cabfe7d751882527b10b6b401.camel@redhat.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/fb: add missing sysmen flush
 callbacks
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        dri-devel@lists.freedesktop.org
Date:   Fri, 07 Apr 2023 19:15:15 -0400
In-Reply-To: <20230405110455.1368428-1-kherbst@redhat.com>
References: <20230405110455.1368428-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2023-04-05 at 13:04 +0200, Karol Herbst wrote:
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/203
> Fixes: 5728d064190e1 ("drm/nouveau/fb: handle sysmem flush page from comm=
on code")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c | 1 +
>  drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c | 1 +
>  4 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/fb/gf108.c
> index 76678dd60f93f..c4c6f67af7ccc 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c
> @@ -31,6 +31,7 @@ gf108_fb =3D {
>  	.init =3D gf100_fb_init,
>  	.init_page =3D gf100_fb_init_page,
>  	.intr =3D gf100_fb_intr,
> +	.sysmem.flush_page_init =3D gf100_fb_sysmem_flush_page_init,
>  	.ram_new =3D gf108_ram_new,
>  	.default_bigpage =3D 17,
>  };
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/fb/gk104.c
> index f73442ccb424b..433fa966ba231 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c
> @@ -77,6 +77,7 @@ gk104_fb =3D {
>  	.init =3D gf100_fb_init,
>  	.init_page =3D gf100_fb_init_page,
>  	.intr =3D gf100_fb_intr,
> +	.sysmem.flush_page_init =3D gf100_fb_sysmem_flush_page_init,
>  	.ram_new =3D gk104_ram_new,
>  	.default_bigpage =3D 17,
>  	.clkgate_pack =3D gk104_fb_clkgate_pack,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/fb/gk110.c
> index 45d6cdffafeed..4dc283dedf8b5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c
> @@ -59,6 +59,7 @@ gk110_fb =3D {
>  	.init =3D gf100_fb_init,
>  	.init_page =3D gf100_fb_init_page,
>  	.intr =3D gf100_fb_intr,
> +	.sysmem.flush_page_init =3D gf100_fb_sysmem_flush_page_init,
>  	.ram_new =3D gk104_ram_new,
>  	.default_bigpage =3D 17,
>  	.clkgate_pack =3D gk110_fb_clkgate_pack,
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/fb/gm107.c
> index de52462a92bf0..90bfff616d35b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c
> @@ -31,6 +31,7 @@ gm107_fb =3D {
>  	.init =3D gf100_fb_init,
>  	.init_page =3D gf100_fb_init_page,
>  	.intr =3D gf100_fb_intr,
> +	.sysmem.flush_page_init =3D gf100_fb_sysmem_flush_page_init,
>  	.ram_new =3D gm107_ram_new,
>  	.default_bigpage =3D 17,
>  };

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

