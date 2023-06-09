Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198B872992A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbjFIMKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbjFIMKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE511BD3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686312597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8K8zOc2VRoAIFNnTvussYfo75dEOYDyNWNKLCNNQoBA=;
        b=S+RSh4fjb9FJoLZpieG2dMjd0gg3po2JsgceZxZCkEjR7dC6OV2/ibxa3fPtHAZdkQ0C5M
        hBunSRcZE/4nMH+xXA9oPzFfD/nmkphGDytTdbOlMFRwuKJPXeynhMJlGCWtC1DLLwTpGE
        eOEKbP59uT5ULVU0//jUChxwR9OoZYE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Q-Njr01HPyef9QQr5UDcJA-1; Fri, 09 Jun 2023 08:09:56 -0400
X-MC-Unique: Q-Njr01HPyef9QQr5UDcJA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2af1cf1a118so2389741fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312595; x=1688904595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8K8zOc2VRoAIFNnTvussYfo75dEOYDyNWNKLCNNQoBA=;
        b=P9Y9UnLeM6quiDAQFc6s3nVX/U9Lf0cP9Pxac7N9lrK/QEi3AjRxpxq2gjxixZ8O5Q
         taNjanvYlDJmm4XHVE4U/mR64FgCKf3pH2c1Z4znvTO/t6Ud15sCkj+UtqUH0V36Vowg
         TaPnEDrQs/tTBoqut+WYlZlK9IcqVk3VU6IN7EG9nEDCJL3Aarn4vUQR/R7SRsNghdIP
         WwDbC2mes2aQW4oq8fuLkiXV87YcXTVvw/7vDTWZICCvRTbUFY8Xvy/Lwq0yOG3O++0U
         DV7ZA3PrGw2bX3P70uKYNvAyrQhPE7jO28WP+bUNYbjODVvHOmvC24eRTqLjGS6rZZyA
         YzHQ==
X-Gm-Message-State: AC+VfDzye+JAIEx481LxHKkUJ7aoUg4SZuE2ZymQ87cn4K4rNBB2XY7C
        TIVm1QC/estlzR/nDfiGWNeUKD79unmupIVajkOlEkU0AOPNYXiszN6KGs16oRg/Q/C6ZG9ajTi
        3z7o0oVMMJMRXtI/NT/Heby26Z2PC0aTXkJQOkHuq
X-Received: by 2002:a2e:b108:0:b0:2b1:dc69:67fd with SMTP id p8-20020a2eb108000000b002b1dc6967fdmr808626ljl.5.1686312594959;
        Fri, 09 Jun 2023 05:09:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5x4JIMK1TQ12rpra/mBTbK0YAIXvw7OKgm1UtrERedLpibE3QvP+XQvRXtwHvlv51+JuJjz8J+mA4OusmOEjA=
X-Received: by 2002:a2e:b108:0:b0:2b1:dc69:67fd with SMTP id
 p8-20020a2eb108000000b002b1dc6967fdmr808618ljl.5.1686312594802; Fri, 09 Jun
 2023 05:09:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230609081732.3842341-1-lee@kernel.org> <20230609081732.3842341-13-lee@kernel.org>
In-Reply-To: <20230609081732.3842341-13-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 9 Jun 2023 14:09:43 +0200
Message-ID: <CACO55tsP+FgJRSZS0gEVpOFx-GgNhGA3kr6KLvURVgmpEmWrFA@mail.gmail.com>
Subject: Re: [RESEND 12/15] drm/nouveau/dispnv04/crtc: Demote kerneldoc abuses
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
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 10:18=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:453: warning: This comment start=
s with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide=
/kernel-doc.rst
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c:629: warning: This comment start=
s with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide=
/kernel-doc.rst
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
>  drivers/gpu/drm/nouveau/dispnv04/crtc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/no=
uveau/dispnv04/crtc.c
> index a6f2e681bde98..7794902df17d5 100644
> --- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> +++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
> @@ -449,7 +449,7 @@ nv_crtc_mode_set_vga(struct drm_crtc *crtc, struct dr=
m_display_mode *mode)
>         regp->Attribute[NV_CIO_AR_CSEL_INDEX] =3D 0x00;
>  }
>
> -/**
> +/*
>   * Sets up registers for the given mode/adjusted_mode pair.
>   *
>   * The clocks, CRTCs and outputs attached to this CRTC must be off.
> @@ -625,7 +625,7 @@ nv_crtc_swap_fbs(struct drm_crtc *crtc, struct drm_fr=
amebuffer *old_fb)
>         return ret;
>  }
>
> -/**
> +/*
>   * Sets up registers for the given mode/adjusted_mode pair.
>   *
>   * The clocks, CRTCs and outputs attached to this CRTC must be off.
> --
> 2.41.0.162.gfafddb0af9-goog
>

