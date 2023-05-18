Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B886770898E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjERUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjERUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6C7119
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684441852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UBHXSM6N4oYTfABvCGd3gPEAq2HM572bDIbMq8xh2Y4=;
        b=bCVxijZcQBso49l0Hgr0s5U+ODYERV5/2fLhrnvhsLtJAPsU1MepPndJmjvwEsvaqivEZX
        lrsBT6Rp6zm42/xVasyN/pJVpbmrWcly7hlD+X495moJNfbE+EFIzJsZnXMGPUlt08Ati5
        uSMW8Ntfa4lsIhbuCdFMsiOGjFM6GMo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-awFM8kmlM4aQhzsHMT487Q-1; Thu, 18 May 2023 16:30:51 -0400
X-MC-Unique: awFM8kmlM4aQhzsHMT487Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62384132fe5so15864846d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 13:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684441851; x=1687033851;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBHXSM6N4oYTfABvCGd3gPEAq2HM572bDIbMq8xh2Y4=;
        b=jN1ziKPll0oudTABbQIVDQt33XvsxYN7Vl/Ry1qyKy+kSeVbG41Frr5E9Z3ze68iy5
         upj3y3wmFLm+oIatp6NVeawsmphIdyfhSlSlA5OxglPS4OJdUUH3jjc1idYFAF00h6cN
         Gmp/0tF9mrL67cO33183U+8OMkwqTwT6RR/oKYlNFuydCXF6n4T/NVFXFwOIvmbU+HVX
         xCLJqOUTgNolGxJBut644eB6GcS0zEqrfwRj9WHFNcmNHhL1kfkfQmy49EsKt+NBPRj6
         x3snAnGqw+IDKe/Huj39ULF6uASkWHVO8vfP9xCCPLO4+tF8MpAAEav8OGSQ1vNd+f19
         YDeA==
X-Gm-Message-State: AC+VfDwaVR5CaO+3xCOOPfT7/2ilh4k35GW91gpeE6aoYCdoA17doIym
        oiaBm4hYVl8rJDi5XVYy3vQWcUStlzB7ixWRQeMPnfvbFlj2Q03tXpWiwL97tam0xTnTFwvyz1i
        5ZyBstmO/IhVWJR1jFjNMGbck
X-Received: by 2002:a05:6214:e4d:b0:5c7:d03c:f2b2 with SMTP id o13-20020a0562140e4d00b005c7d03cf2b2mr361305qvc.28.1684441851014;
        Thu, 18 May 2023 13:30:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vnjCpdmwKeoU/jIRT/FUAUaf5A1UGyq52Jfrp1Qr7akRm4t7XVgexBhARVnPncRSkeITgNQ==
X-Received: by 2002:a05:6214:e4d:b0:5c7:d03c:f2b2 with SMTP id o13-20020a0562140e4d00b005c7d03cf2b2mr361277qvc.28.1684441850746;
        Thu, 18 May 2023 13:30:50 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c62:8200::feb? ([2600:4040:5c62:8200::feb])
        by smtp.gmail.com with ESMTPSA id cx3-20020a056214188300b006238f82cde4sm763000qvb.108.2023.05.18.13.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:30:50 -0700 (PDT)
Message-ID: <b07c93bc7cb71a32091794cd97f7c702c34539da.camel@redhat.com>
Subject: Re: [PATCH 3/4] drm/nouveau: stop using is_swiotlb_active
From:   Lyude Paul <lyude@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Date:   Thu, 18 May 2023 16:30:49 -0400
In-Reply-To: <20230518134253.909623-4-hch@lst.de>
References: <20230518134253.909623-1-hch@lst.de>
         <20230518134253.909623-4-hch@lst.de>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

Thanks for getting to this!

On Thu, 2023-05-18 at 15:42 +0200, Christoph Hellwig wrote:
> Drivers have no business looking into dma-mapping internals and check
> what backend is used.  Unfortunstely the DRM core is still broken and
> tries to do plain page allocations instead of using DMA API allocators
> by default and uses various bandaids on when to use dma_alloc_coherent.
>=20
> Switch nouveau to use the same (broken) scheme as amdgpu and radeon
> to remove the last driver user of is_swiotlb_active.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/nouveau/nouveau_ttm.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouv=
eau/nouveau_ttm.c
> index 1469a88910e45d..486f39f31a38df 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -24,9 +24,9 @@
>   */
> =20
>  #include <linux/limits.h>
> -#include <linux/swiotlb.h>
> =20
>  #include <drm/ttm/ttm_range_manager.h>
> +#include <drm/drm_cache.h>
> =20
>  #include "nouveau_drv.h"
>  #include "nouveau_gem.h"
> @@ -265,7 +265,6 @@ nouveau_ttm_init(struct nouveau_drm *drm)
>  	struct nvkm_pci *pci =3D device->pci;
>  	struct nvif_mmu *mmu =3D &drm->client.mmu;
>  	struct drm_device *dev =3D drm->dev;
> -	bool need_swiotlb =3D false;
>  	int typei, ret;
> =20
>  	ret =3D nouveau_ttm_init_host(drm, 0);
> @@ -300,13 +299,10 @@ nouveau_ttm_init(struct nouveau_drm *drm)
>  		drm->agp.cma =3D pci->agp.cma;
>  	}
> =20
> -#if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
> -	need_swiotlb =3D is_swiotlb_active(dev->dev);
> -#endif
> -
>  	ret =3D ttm_device_init(&drm->ttm.bdev, &nouveau_bo_driver, drm->dev->d=
ev,
>  				  dev->anon_inode->i_mapping,
> -				  dev->vma_offset_manager, need_swiotlb,
> +				  dev->vma_offset_manager,
> +				  drm_need_swiotlb(drm->client.mmu.dmabits),
>  				  drm->client.mmu.dmabits <=3D 32);
>  	if (ret) {
>  		NV_ERROR(drm, "error initialising bo driver, %d\n", ret);

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

