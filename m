Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12356AF9A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCGW4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjCGWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:54:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A66B78B5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678229352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jpiPjWQVLrWJQByXN7/QqMdv5LfiV5aMULGXTdQqSWA=;
        b=bNADT/NS1vCHM4ejLbz7j+ccDTaEEuH/fMAxk9gKPuLCYi1lcML3JXFYcXKpNYQGv518hn
        eQ9pDd5IUYIol+Dn656AspkfKif3G5AAqSuDqF1JoC1nV/+/kKeqggERkms6acDFsjwq03
        Tec5FUcY7wnyAzKTW/fcKrx+VFTL2kg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-uBA5tdMHMjGhizclHQWW3w-1; Tue, 07 Mar 2023 17:49:11 -0500
X-MC-Unique: uBA5tdMHMjGhizclHQWW3w-1
Received: by mail-qt1-f198.google.com with SMTP id z1-20020ac87ca1000000b003ba2a2c50f9so8044418qtv.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:49:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678229350;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpiPjWQVLrWJQByXN7/QqMdv5LfiV5aMULGXTdQqSWA=;
        b=7Wy2Lo9xnif7TK4SvY1igQ1rZe1sOLbXMLvtAkUug+qT/O/sMViwrXezumi8s6JeZB
         rOyrC7Z7Dj5q+H3fxKz9if7zC6BNh26ynBudy7vHf5JFDMMZfgixDKA8Q2fcMpbfvy+j
         WeKKJgYU799vu5y8+M5bAkmeg+UFhFIQesYgXhUw7Z1mXraY77tJTpa2qp3C0Atk+Lg0
         itakAs7GN7F7LoRkUyNT+XqSaP+xn3sdUkmtyT4uMWLvX/nvziU9UvKDhIhqO45d5wxr
         yIu6pujE3IVjKbdjZ/tzMhkXmAjynAUQljuXpgFi9xXLBXs8y/UoK0TuSjzegWJHyi3q
         2bQQ==
X-Gm-Message-State: AO0yUKXFfaNI+5cYj1+OsT6zrHqLMcAVmkjmqBuzd3mjZAJGRQVw+23c
        4L84Tk7RwlhTHS6T0/H/t5Umnor9GyfdkcyUJ3d6dBUZKkGDqeM3kS4sxXgKlMcu93iFnm5e871
        R3mnThg75xi2nEH5f/Zad9O/D
X-Received: by 2002:a05:622a:15c6:b0:3bf:e39f:a9aa with SMTP id d6-20020a05622a15c600b003bfe39fa9aamr29975760qty.27.1678229350745;
        Tue, 07 Mar 2023 14:49:10 -0800 (PST)
X-Google-Smtp-Source: AK7set8D0kt0w8UWfWFSmc8IGR59KwpNAYdDZegDL5U+4w/82o/iSmt73NW03WYqKFasWTrX/rU/LA==
X-Received: by 2002:a05:622a:15c6:b0:3bf:e39f:a9aa with SMTP id d6-20020a05622a15c600b003bfe39fa9aamr29975745qty.27.1678229350506;
        Tue, 07 Mar 2023 14:49:10 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id 191-20020a370cc8000000b007416c11ea03sm10364394qkm.26.2023.03.07.14.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:49:09 -0800 (PST)
Message-ID: <361fb10adaa1cb3ff5360cbb0e36a3c1e99fe3e8.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/device: avoid usage of list iterator
 after loop
From:   Lyude Paul <lyude@redhat.com>
To:     Jakob Koschel <jkl820.git@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Date:   Tue, 07 Mar 2023 17:49:08 -0500
In-Reply-To: <20230301-drm-nouveau-avoid-iter-after-loop-v1-1-0702ec23f970@gmail.com>
References: <20230301-drm-nouveau-avoid-iter-after-loop-v1-0-0702ec23f970@gmail.com>
         <20230301-drm-nouveau-avoid-iter-after-loop-v1-1-0702ec23f970@gmail.com>
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

On Wed, 2023-03-01 at 18:25 +0100, Jakob Koschel wrote:
> If potentially no valid element is found, 'pstate' would contain an
> invalid pointer past the iterator loop. To ensure 'pstate' is always
> valid, we only set it if the correct element was found. That allows
> adding a BUG_ON in case the code works incorrectly, exposing currently
> undetectable potential bugs.
>=20
> Additionally, Linus proposed to avoid any use of the list iterator
> variable after the loop, in the attempt to move the list iterator
> variable declaration into the marcro to avoid any potential misuse after
> the loop [1].
>=20
> Link: https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXP=
wr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c b/drivers/=
gpu/drm/nouveau/nvkm/engine/device/ctrl.c
> index ce774579c89d..7c9dd91e98ee 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
> @@ -72,7 +72,7 @@ nvkm_control_mthd_pstate_attr(struct nvkm_control *ctrl=
, void *data, u32 size)
>  	} *args =3D data;
>  	struct nvkm_clk *clk =3D ctrl->device->clk;
>  	const struct nvkm_domain *domain;
> -	struct nvkm_pstate *pstate;
> +	struct nvkm_pstate *pstate =3D NULL, *iter;
>  	struct nvkm_cstate *cstate;
>  	int i =3D 0, j =3D -1;
>  	u32 lo, hi;
> @@ -103,11 +103,14 @@ nvkm_control_mthd_pstate_attr(struct nvkm_control *=
ctrl, void *data, u32 size)
>  		return -EINVAL;
> =20
>  	if (args->v0.state !=3D NVIF_CONTROL_PSTATE_ATTR_V0_STATE_CURRENT) {
> -		list_for_each_entry(pstate, &clk->states, head) {
> -			if (i++ =3D=3D args->v0.state)
> +		list_for_each_entry(iter, &clk->states, head) {
> +			if (i++ =3D=3D args->v0.state) {
> +				pstate =3D iter;
>  				break;
> +			}
>  		}
> =20
> +		BUG_ON(!pstate);

Let's replace this with

		if (WARN_ON_ONCE(!pstate))
			return -EINVAL;

>  		lo =3D pstate->base.domain[domain->name];
>  		hi =3D lo;
>  		list_for_each_entry(cstate, &pstate->list, head) {
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

