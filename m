Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8416067BE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbjAYVdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbjAYVdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:33:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085D3C3B
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674682303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qRS2ehMggqO+o2eZ0zGKoRgHGdALNRhCshcFwwykUYU=;
        b=EQyc8wg90nkKbXDlWhVB+2CUFgA/eKkBnOYlPSJhK3s3QssUAiIklmZ4+ytaMSQJdY2oRq
        R61PlJ4ncWquygy8RSchxfNksIFYv4/hmOhlunVMYkdbemVWiKlUt8uBGkvZGnRRNjRRRL
        G7zejRPzWQlpDpC8dSwIZhY5adlMvBY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-575-Gkv1uYcIOnqyyOCUbhDWcQ-1; Wed, 25 Jan 2023 16:31:41 -0500
X-MC-Unique: Gkv1uYcIOnqyyOCUbhDWcQ-1
Received: by mail-qv1-f71.google.com with SMTP id y10-20020a056214016a00b0053545fd8b7fso5411qvs.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qRS2ehMggqO+o2eZ0zGKoRgHGdALNRhCshcFwwykUYU=;
        b=koaq0WehTITfMFy7p1ZaQVdjgR6Pz5zuA/HLfeA0MRkffex7vO1B5uknG3oaAdufYB
         a95DbOCFYu046mhjfqEgX9VHdwXwOC1BuAlUkl8K3JavktK9CadTFwLiM8eqR/PNXuHC
         TM2R8IQGuVtgt91xRkudMC9wB6HB1c/7xhUtufwu5/A+CdLxNeG0TIy4JgpY9JXUWJEq
         D55xgZHH/SoG7ebu80DCZUm7cLd6JQRdbc6/lZ2VBNJMqYf425fbXA10vUaAtfkiMO3R
         gZdKCDqk97GH3aHqnJtxFqFD4Z0iBPWE/p5nPoUWJ9nhUNg54H8DIwAtj192a8iNvdE2
         dR2A==
X-Gm-Message-State: AFqh2kqicKUC7i6RDPwm878teai3H5098U6FhXSmuqjUr6q00ZSGXcVL
        OrbL+Ibi2X5K+5HytJ9Yr7LQ1NPUiXgYWf0GqW/qSylhgXz7NiVP0VO1hlFSCYRLEIsvR8qzHRJ
        rzoW1yoXswOJ7J4gXtQGhE9uK
X-Received: by 2002:ac8:688d:0:b0:3b6:2fba:3d46 with SMTP id m13-20020ac8688d000000b003b62fba3d46mr51528076qtq.42.1674682301035;
        Wed, 25 Jan 2023 13:31:41 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvCi56dy8VVfBpgc75HmZZNf+4zqovM2MEt4ZNej0KIGvI9+NrOEyIFXQRXqAzTofmmCkZO/g==
X-Received: by 2002:ac8:688d:0:b0:3b6:2fba:3d46 with SMTP id m13-20020ac8688d000000b003b62fba3d46mr51528040qtq.42.1674682300678;
        Wed, 25 Jan 2023 13:31:40 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id i2-20020ac813c2000000b003b635a5d56csm3972925qtj.30.2023.01.25.13.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:31:40 -0800 (PST)
Message-ID: <c1bb4fa6cea38493e6ccff21f5f5fea39a0393e6.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/devinit: Convert function disable() to be
 void
From:   Lyude Paul <lyude@redhat.com>
To:     Deepak R Varma <drv@mailo.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Date:   Wed, 25 Jan 2023 16:31:39 -0500
In-Reply-To: <Y9FFoooIXjlr+UP1@ubun2204.myguest.virtualbox.org>
References: <Y9FFoooIXjlr+UP1@ubun2204.myguest.virtualbox.org>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push upstream in a moment

On Wed, 2023-01-25 at 20:37 +0530, Deepak R Varma wrote:
> The current design of callback function disable() of struct
> nvkm_devinit_func is defined to return a u64 value. In its implementation
> in the driver modules, the function always returns a fixed value 0. Hence
> the design and implementation of this function should be enhanced to retu=
rn
> void instead of a fixed value. This change also eliminates untouched
> return variables.
>=20
> The change is identified using the returnvar.cocci Coccinelle semantic
> patch script.
>=20
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---
> Please note: The change is compile build tested only.
>=20
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/base.c  | 3 ++-
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g84.c   | 5 +----
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c   | 4 +---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c | 4 +---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c | 4 +---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c | 4 +---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c | 4 +---
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.c  | 5 +----
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h  | 2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h  | 2 +-
>  10 files changed, 11 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/base.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/devinit/base.c
> index dd4981708fe4..3d9319c319c6 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/base.c
> @@ -51,7 +51,8 @@ u64
>  nvkm_devinit_disable(struct nvkm_devinit *init)
>  {
>  	if (init && init->func->disable)
> -		return init->func->disable(init);
> +		init->func->disable(init);
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g84.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/devinit/g84.c
> index c224702b7bed..00df7811dd10 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g84.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g84.c
> @@ -26,13 +26,12 @@
>  #include <subdev/bios.h>
>  #include <subdev/bios/init.h>
> =20
> -static u64
> +static void
>  g84_devinit_disable(struct nvkm_devinit *init)
>  {
>  	struct nvkm_device *device =3D init->subdev.device;
>  	u32 r001540 =3D nvkm_rd32(device, 0x001540);
>  	u32 r00154c =3D nvkm_rd32(device, 0x00154c);
> -	u64 disable =3D 0ULL;
> =20
>  	if (!(r001540 & 0x40000000)) {
>  		nvkm_subdev_disable(device, NVKM_ENGINE_MPEG, 0);
> @@ -47,8 +46,6 @@ g84_devinit_disable(struct nvkm_devinit *init)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_BSP, 0);
>  	if (!(r00154c & 0x00000040))
>  		nvkm_subdev_disable(device, NVKM_ENGINE_CIPHER, 0);
> -
> -	return disable;
>  }
> =20
>  static const struct nvkm_devinit_func
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/devinit/g98.c
> index 8977483a9f42..54bee499b982 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c
> @@ -26,7 +26,7 @@
>  #include <subdev/bios.h>
>  #include <subdev/bios/init.h>
> =20
> -static u64
> +static void
>  g98_devinit_disable(struct nvkm_devinit *init)
>  {
>  	struct nvkm_device *device =3D init->subdev.device;
> @@ -45,8 +45,6 @@ g98_devinit_disable(struct nvkm_devinit *init)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_MSVLD, 0);
>  	if (!(r00154c & 0x00000040))
>  		nvkm_subdev_disable(device, NVKM_ENGINE_SEC, 0);
> -
> -	return 0ULL;
>  }
> =20
>  static const struct nvkm_devinit_func
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> index 5b7cb1fe7897..5368e705e7fd 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c
> @@ -63,7 +63,7 @@ gf100_devinit_pll_set(struct nvkm_devinit *init, u32 ty=
pe, u32 freq)
>  	return ret;
>  }
> =20
> -static u64
> +static void
>  gf100_devinit_disable(struct nvkm_devinit *init)
>  {
>  	struct nvkm_device *device =3D init->subdev.device;
> @@ -85,8 +85,6 @@ gf100_devinit_disable(struct nvkm_devinit *init)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_CE, 0);
>  	if (r022500 & 0x00000200)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_CE, 1);
> -
> -	return 0ULL;
>  }
> =20
>  void
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c
> index 8955af2704c7..7bcbc4895ec2 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c
> @@ -26,7 +26,7 @@
>  #include <subdev/bios.h>
>  #include <subdev/bios/init.h>
> =20
> -u64
> +void
>  gm107_devinit_disable(struct nvkm_devinit *init)
>  {
>  	struct nvkm_device *device =3D init->subdev.device;
> @@ -39,8 +39,6 @@ gm107_devinit_disable(struct nvkm_devinit *init)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_CE, 2);
>  	if (r021c04 & 0x00000001)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_DISP, 0);
> -
> -	return 0ULL;
>  }
> =20
>  static const struct nvkm_devinit_func
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c
> index 3d0ab86c3115..dbca92318baf 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c
> @@ -62,7 +62,7 @@ gt215_devinit_pll_set(struct nvkm_devinit *init, u32 ty=
pe, u32 freq)
>  	return ret;
>  }
> =20
> -static u64
> +static void
>  gt215_devinit_disable(struct nvkm_devinit *init)
>  {
>  	struct nvkm_device *device =3D init->subdev.device;
> @@ -80,8 +80,6 @@ gt215_devinit_disable(struct nvkm_devinit *init)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_MSVLD, 0);
>  	if (!(r00154c & 0x00000200))
>  		nvkm_subdev_disable(device, NVKM_ENGINE_CE, 0);
> -
> -	return 0ULL;
>  }
> =20
>  static u32
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c b/driver=
s/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
> index a9cdf2411187..a24bd2e7d7ce 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c
> @@ -26,7 +26,7 @@
>  #include <subdev/bios.h>
>  #include <subdev/bios/init.h>
> =20
> -static u64
> +static void
>  mcp89_devinit_disable(struct nvkm_devinit *init)
>  {
>  	struct nvkm_device *device =3D init->subdev.device;
> @@ -46,8 +46,6 @@ mcp89_devinit_disable(struct nvkm_devinit *init)
>  		nvkm_subdev_disable(device, NVKM_ENGINE_VIC, 0);
>  	if (!(r00154c & 0x00000200))
>  		nvkm_subdev_disable(device, NVKM_ENGINE_CE, 0);
> -
> -	return 0;
>  }
> =20
>  static const struct nvkm_devinit_func
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.c b/drivers=
/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.c
> index 380995d398b1..07ed8fd778b2 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.c
> @@ -77,17 +77,14 @@ nv50_devinit_pll_set(struct nvkm_devinit *init, u32 t=
ype, u32 freq)
>  	return 0;
>  }
> =20
> -static u64
> +static void
>  nv50_devinit_disable(struct nvkm_devinit *init)
>  {
>  	struct nvkm_device *device =3D init->subdev.device;
>  	u32 r001540 =3D nvkm_rd32(device, 0x001540);
> -	u64 disable =3D 0ULL;
> =20
>  	if (!(r001540 & 0x40000000))
>  		nvkm_subdev_disable(device, NVKM_ENGINE_MPEG, 0);
> -
> -	return disable;
>  }
> =20
>  void
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h b/drivers=
/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h
> index 987a7f478b84..8de409c084c1 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h
> @@ -23,7 +23,7 @@ int  gf100_devinit_ctor(struct nvkm_object *, struct nv=
km_object *,
>  int  gf100_devinit_pll_set(struct nvkm_devinit *, u32, u32);
>  void gf100_devinit_preinit(struct nvkm_devinit *);
> =20
> -u64  gm107_devinit_disable(struct nvkm_devinit *);
> +void  gm107_devinit_disable(struct nvkm_devinit *);
> =20
>  int gm200_devinit_post(struct nvkm_devinit *, bool);
>  void gm200_devinit_preos(struct nv50_devinit *, bool);
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h b/drivers=
/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h
> index dd8b038a8cee..a648482d06e9 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h
> @@ -12,7 +12,7 @@ struct nvkm_devinit_func {
>  	u32  (*mmio)(struct nvkm_devinit *, u32);
>  	void (*meminit)(struct nvkm_devinit *);
>  	int  (*pll_set)(struct nvkm_devinit *, u32 type, u32 freq);
> -	u64  (*disable)(struct nvkm_devinit *);
> +	void (*disable)(struct nvkm_devinit *);
>  };
> =20
>  void nvkm_devinit_ctor(const struct nvkm_devinit_func *, struct nvkm_dev=
ice *,

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

