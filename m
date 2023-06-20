Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C9737780
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjFTWbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFTWbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:31:47 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28960DD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:31:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f8777caaa1so2664806e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687300303; x=1689892303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8g7XlJwr5YrB5QgygUhOX+J8ps+0PMCUjpiQSimRqI=;
        b=QQ6wf5t4OPvWtBiXbHi9kFp6xs+igp2FHkxmVTjd/RZzFrBtEyfkzp28dfCKmXFD6b
         2K+ESddjzaKsCoSe3Bbgf9Ac+cbRpLOQfh+RfZVvxmF4PPfHMPq9s7AULasBaWmGi2of
         mgVWUGDrzQUD9rTKRM4rcP1XqCRPkjSrIl++5TEeP0GifQMRugFrPNPAJd9LbrghSoiZ
         3LqytqPB06aRyyuu7cV0T3YUCm3v1E86oSr/MhfjSdi35FwwLtWMqqMbtXWDTVgoYhIU
         eV5GIFjSPJY/UIlPer3Rwosgn8kXLNHfm05dJYEeCeTUaVEtygXWZwAWUw3ujSOvn5ji
         Fnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687300303; x=1689892303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8g7XlJwr5YrB5QgygUhOX+J8ps+0PMCUjpiQSimRqI=;
        b=TDbzRbNKWRQNlT7msanzagZMUGe5aEJNemwfuKrs0qU8ywzO2Glc8oL5E82JTQKyG6
         eYM1aDHG0cZXOubA/+rZrbCkiDP7ZicnFtn99Zg4bPeQr8I/IohCwNYHURAXlS/Gov4E
         eGL1uhqk8WuKQqpFLG0t7FtJvP1dzjxQWp/SfkOTAcGvIct53yuMbg6UFF9d6SHRxjd+
         yp9slNtovrR2/89yv87sSVsHvhuJ7Oy8F8R0n1t/QGQYP3rSlXrMKhEW3e270Ff3Yqwo
         jfKMvtVQRaHjlIdAq+VnHgUcIh+2Lk1oxf8aLUO402qOHmRDgwNfXtUKGg+M+6o8FEAm
         RB9Q==
X-Gm-Message-State: AC+VfDx7Iz9KY1w7gqqufZiy9CG+aMwqI8IoDHv8XHw8acjr/3h/ZLKh
        dGO3WxZPxIVKwP8p31WxckkYKhYOM/8=
X-Google-Smtp-Source: ACHHUZ5Ao1x+QM+m6wssekEtutjiw4nI0b4dmUXXaJSrXCZHUQkgmjFdNnMptISbiZE1sVrciuVvpw==
X-Received: by 2002:a05:6512:551:b0:4f8:675c:3667 with SMTP id h17-20020a056512055100b004f8675c3667mr5191712lfl.21.1687300302951;
        Tue, 20 Jun 2023 15:31:42 -0700 (PDT)
Received: from suse.localnet (host-95-233-134-55.retail.telecomitalia.it. [95.233.134.55])
        by smtp.gmail.com with ESMTPSA id m4-20020a5d56c4000000b003078354f774sm2888992wrw.36.2023.06.20.15.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:31:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>, zhao1.liu@intel.com,
        Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH] drm/gma500: Replace kmap{,_atomic}() with page_address()
Date:   Wed, 21 Jun 2023 00:31:40 +0200
Message-ID: <2565983.Lt9SDvczpP@suse>
In-Reply-To: <20230620180148.GA419134@sumitra.com>
References: <20230620180148.GA419134@sumitra.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 20 giugno 2023 20:01:48 CEST Sumitra Sharma wrote:
> Remove unnecessary calls to kmap{,_atomic}() when acquiring
> pages using GFP_DMA32.
>=20
> The GFP_DMA32 uses the DMA32 zone to satisfy the allocation
> requests. Therefore, pages allocated with GFP_DMA32 cannot
> come from Highmem.
>=20
> Avoid using calls to kmap_local_page() / kunmap_local() and
> kmap() / kunmap() in the psb_mmu_alloc_pd function. Instead,
> utilize page_address().
>=20
> Remove the usage of kmap_atomic() / kunmap_atomic() in the
> psb_mmu_alloc_pt function. Use page_address() instead.
>=20
> Substitute kmap_atomic(pt->p) / kunmap_atomic(pt->v) calls
> in the psb_mmu_pt_alloc_map_lock() and psb_mmu_pt_unmap_unlock()
> functions with page_address(pt->p). This is possible as
> pt =3D psb_mmu_alloc_pt(pd) allocates a page using
> pt->p =3D alloc_page(GFP_DMA32).

Sumitra,

I'm sorry because this patch cannot acked with this commit message.

This commit message is missing two _really_ important information. Therefor=
e,=20
it is not acked. Please check again what I write below and either add the=20
missing information or change the code accordingly...

You should assure everybody that the code between the old kmap_atomic() /=20
kunmap_atomic() doesn't depend either on implicit pagefault_disable() or=20
preempt_disable() calls or both.=20

Please read again the section of the Highmem's documentation regarding=20
kmap_atomic() at https://docs.kernel.org/mm/highmem.html

In particular take care to read and understand what "[] the code between ca=
lls=20
to kmap_atomic() and kunmap_atomic() may implicitly depend on the side effe=
cts=20
of atomic mappings, i.e. disabling page faults or preemption, or both. In t=
hat=20
case, explicit calls to pagefault_disable() or preempt_disable() or both mu=
st=20
be made in conjunction with the use of kmap_local_page().".

Please study carefully also the following patch from Zhao, suggested by Ira=
=20
and reviewed by Ira and I: "[PATCH v2 3/9] drm/i915: Use kmap_local_page() =
in=20
gem/i915_gem_shmem.c". It's not yet reached upstream so you need to find it=
 in=20
lore.kernel.org at https://lore.kernel.org/lkml/20230329073220.3982460-4-zh=
ao1.liu@linux.intel.com/

Please note that, in turn, that patch also contains a link to a patch from =
Ira=20
who too had to disable faults (https://lore.kernel.org/all/
20220813220034.806698-1-ira.weiny@intel.com)

I haven't yet looked at your code. If any sections do depend on those impli=
cit=20
disables, you should act accordingly and add one or both of the above-
mentioned calls, even in cases where you get rid of local mappings.

Instead if the sections don't depend on the mentioned side effects, you sho=
uld=20
write something like what I wrote in "[PATCH] NFS: Convert kmap_atomic() to=
=20
kmap_local_folio()" that you can find at https://lore.kernel.org/lkml/
20230503172411.3356-1-fmdefrancesco@gmail.com/ or, by by using "git show=20
4b71e2416ec4".

Thanks for working on this,

=46abio=20

>=20
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> ---
>  drivers/gpu/drm/gma500/mmu.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
> index a70b01ccdf70..59aa5661e56a 100644
> --- a/drivers/gpu/drm/gma500/mmu.c
> +++ b/drivers/gpu/drm/gma500/mmu.c
> @@ -184,20 +184,15 @@ struct psb_mmu_pd *psb_mmu_alloc_pd(struct
> psb_mmu_driver *driver, pd->invalid_pte =3D 0;
>  	}
>=20
> -	v =3D kmap_local_page(pd->dummy_pt);
> +	v =3D page_address(pd->dummy_pt);
>  	for (i =3D 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
>  		v[i] =3D pd->invalid_pte;
>=20
> -	kunmap_local(v);
> -
> -	v =3D kmap_local_page(pd->p);
> +	v =3D page_address(pd->p);
>  	for (i =3D 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
>  		v[i] =3D pd->invalid_pde;
>=20
> -	kunmap_local(v);
> -
> -	clear_page(kmap(pd->dummy_page));
> -	kunmap(pd->dummy_page);
> +	clear_page(page_address(pd->dummy_page));
>=20
>  	pd->tables =3D vmalloc_user(sizeof(struct psb_mmu_pt *) * 1024);
>  	if (!pd->tables)
> @@ -279,7 +274,7 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct
> psb_mmu_pd *pd)
>=20
>  	spin_lock(lock);
>=20
> -	v =3D kmap_atomic(pt->p);
> +	v =3D page_address(pt->p);
>  	clf =3D (uint8_t *) v;
>  	ptes =3D (uint32_t *) v;
>  	for (i =3D 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
> @@ -293,7 +288,6 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct
> psb_mmu_pd *pd) }
>  		mb();
>  	}
> -	kunmap_atomic(v);
>  	spin_unlock(lock);
>=20
>  	pt->count =3D 0;
> @@ -339,7 +333,7 @@ static struct psb_mmu_pt=20
*psb_mmu_pt_alloc_map_lock(struct
> psb_mmu_pd *pd, atomic_set(&pd->driver->needs_tlbflush, 1);
>  		}
>  	}
> -	pt->v =3D kmap_atomic(pt->p);
> +	pt->v =3D page_address(pt->p);
>  	return pt;
>  }
>=20
> @@ -365,7 +359,6 @@ static void psb_mmu_pt_unmap_unlock(struct psb_mmu_pt=
=20
*pt)
> struct psb_mmu_pd *pd =3D pt->pd;
>  	uint32_t *v;
>=20
> -	kunmap_atomic(pt->v);
>  	if (pt->count =3D=3D 0) {
>  		v =3D kmap_atomic(pd->p);
>  		v[pt->index] =3D pd->invalid_pde;
> --
> 2.25.1




