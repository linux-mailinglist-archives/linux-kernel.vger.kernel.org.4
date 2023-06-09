Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A370729924
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbjFIMKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240168AbjFIMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466631BFF
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686312547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZR6reQCNcnuFfexOGBu5QAKgIdPCDJoW0kdpvy5S78=;
        b=FgL+GMbx99llw55V9IJx3yEt2gX9QsOCpdkEmN2F634tHhGO95JOjrkpXM+cx9YcX+8mrr
        Kx8FU61W8fiYQpzNIc3jG8pXT/3mEAmuWAcDKqESZPfQVhkYNFaMcSAu3xJ+SvPDAvEUou
        OrAthAMdk6++4rFd3s8vRuEjFSjjea8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-OKFfo6xmPBWkQbELgXooYw-1; Fri, 09 Jun 2023 08:09:05 -0400
X-MC-Unique: OKFfo6xmPBWkQbELgXooYw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2af1cf1a118so2388311fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:09:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312544; x=1688904544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZR6reQCNcnuFfexOGBu5QAKgIdPCDJoW0kdpvy5S78=;
        b=adHOEt4RrmPKiyjNL6jpFgGsgXqAjioJaEpbEZNFv/cyRrxNgvyDrstsAw6TkAnBTC
         70bBigCroek86H+MJOMtYXDgegFDeTYzrKh4NWQ2bXhGYQ7YnrA7RpFi/FFBWqA3qqIe
         YgboGMMehKPPhlgj7DHJMiFUMVz8vy+qp/Wd4JELjSGlJkqiWxhMgbj030lo3cMMJ5k9
         KlxGoP85qWL14YDa5AOZrTf+ms8NfQY/OGgtUmgL/G+XfBzM7BqvBPW1wlOQ68NIvazk
         ufaxV1iXKDzUatZDBStrdJ7gtf+pSSX0tPYNahO5KOl76FkDha2fuXeU2GBspm7zHeZu
         vkcg==
X-Gm-Message-State: AC+VfDwk0pBBCJQ+lZDBtuuR2JzJrHT8W+I/XNm/xJAMrtrbNL9j+97w
        X50jLGDxi4s+QtjRqiViE6sMn00jMEbdnp/UhyhzGqfwsdrK5PGjuRkuBH9vqr7Ae1HzznCBrKx
        yLlVl8vS/AWH8jTpN/LJJAJrOmwzFKbovcF0PJQMp
X-Received: by 2002:a2e:b5dc:0:b0:2b1:c184:9afe with SMTP id g28-20020a2eb5dc000000b002b1c1849afemr882677ljn.4.1686312544288;
        Fri, 09 Jun 2023 05:09:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5aYnP4o6U74L5gjhqD1XkB3Wdjtyd80ogwjUXJ8HiSsGCkFoeBk+bdCktf2s1Lm6D5wtU5M2VftptBu7vekhE=
X-Received: by 2002:a2e:b5dc:0:b0:2b1:c184:9afe with SMTP id
 g28-20020a2eb5dc000000b002b1c1849afemr882669ljn.4.1686312544004; Fri, 09 Jun
 2023 05:09:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230609081732.3842341-1-lee@kernel.org> <20230609081732.3842341-9-lee@kernel.org>
In-Reply-To: <20230609081732.3842341-9-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 9 Jun 2023 14:08:53 +0200
Message-ID: <CACO55tt_ivgVYCbVpGRp4BcsC-CNB5i7Cy=wiMPKUSuXKsOgNg@mail.gmail.com>
Subject: Re: [RESEND 08/15] drm/nouveau/nvkm/subdev/volt/gk20a: Demote
 kerneldoc abuses
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
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:49: warning: This comme=
nt starts with '/**', but isn't a kernel-doc comment. Refer Documentation/d=
oc-guide/kernel-doc.rst
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c:62: warning: This comme=
nt starts with '/**', but isn't a kernel-doc comment. Refer Documentation/d=
oc-guide/kernel-doc.rst
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
>  drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c b/drivers/g=
pu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> index 8c2faa9645111..ccac88da88648 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c
> @@ -45,7 +45,7 @@ static const struct cvb_coef gk20a_cvb_coef[] =3D {
>         /* 852 */ { 1608418, -21643, -269,     0,    763,  -48},
>  };
>
> -/**
> +/*
>   * cvb_mv =3D ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0)
>   */
>  static inline int
> @@ -58,7 +58,7 @@ gk20a_volt_get_cvb_voltage(int speedo, int s_scale, con=
st struct cvb_coef *coef)
>         return mv;
>  }
>
> -/**
> +/*
>   * cvb_t_mv =3D
>   * ((c2 * speedo / s_scale + c1) * speedo / s_scale + c0) +
>   * ((c3 * speedo / s_scale + c4 + c5 * T / t_scale) * T / t_scale)
> --
> 2.41.0.162.gfafddb0af9-goog
>

