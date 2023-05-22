Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064FB70BB43
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjEVLL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjEVLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:11:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E00A30D1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684753540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MX/s9CqqCW6cH2AMqyMMQv3ISbYNht7FksP6LmQ8hqw=;
        b=MOHjv5uvdxxNDK3aUEpZ5RMULs6RXugEl5UbKU5c8OtXI697XoLHApZoxHWcylhXWZ44t+
        x/8116pVIGmdWkOwOFL18N7dxEUf6JNhV2oQMvIE5frYBMhhMa3CRcY45F6QEZwSdru2Vx
        7F8T0UbCaDIuT0qHwjOXP/AEN9nsllw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-a7sS70ezPRShdx3SVMuagw-1; Mon, 22 May 2023 07:05:39 -0400
X-MC-Unique: a7sS70ezPRShdx3SVMuagw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f24f491835so234908e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:05:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753537; x=1687345537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MX/s9CqqCW6cH2AMqyMMQv3ISbYNht7FksP6LmQ8hqw=;
        b=PhaXhiqe471Gkbj5KKJ2imz2bc1erNdkhFNmmvtaXhZeSw5NB/Vyv4CQCvCcuiGdhi
         8BJ5WJLtA/MtpNR1eIb/bFQ3lW3QE1vn+d5riQ4AG6UthO0dcceKk/tomcM1U4Qyv0Fz
         VLy4Z9iHJv/bcapWLVQYD7iVSHG5yF3HzMPR8ELjqrk9CDX1DOZ6mS7i8RR9AyI/RnTJ
         1MsAYLC6Knx6NT2r/hI/yTtZZGxo4g09aQcknIlEI3YVV1DNCNv4bjAZWbMKIlGhn1A+
         K2I2L5Kuvf5B1xNtKUdv/X0s6rxMr8/GuFosm7Uy48t2oVtfYWeTroa8PrvSbta7K95s
         KZvg==
X-Gm-Message-State: AC+VfDzCVDDoRbi9c5z611YAyt9aHUVDXNZUNPH1Kod6cdIitXIWJR+S
        shhRVd37BnRvqCerZLBNpdBDeh0wqbiavVi+JteW03C/uQLer5tV8atfNJi4RwyCcvOsWn5wEvw
        D+vFLNfaJG/J2LcfElOo7pips1pjoLwZvuRukQISC
X-Received: by 2002:a2e:a4ba:0:b0:2af:237c:c335 with SMTP id g26-20020a2ea4ba000000b002af237cc335mr3549912ljm.3.1684753537762;
        Mon, 22 May 2023 04:05:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6x3VG32WQUaO2EyREF1ehIOVQgkJqkNFu6Egwvvu/4sFAXjJoytU/NPjAcnvx2WnEdpXLHgR+ABojRY1WCGjE=
X-Received: by 2002:a2e:a4ba:0:b0:2af:237c:c335 with SMTP id
 g26-20020a2ea4ba000000b002af237cc335mr3549902ljm.3.1684753537479; Mon, 22 May
 2023 04:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230417210329.2469722-1-arnd@kernel.org>
In-Reply-To: <20230417210329.2469722-1-arnd@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 22 May 2023 13:05:26 +0200
Message-ID: <CACO55tuL06jff8WnvU5e-rjwWx+smyYriET7DZDPgNM5e-0UFw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: dispnv50: fix missing-prototypes warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>,
        nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>
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

will merge soon

On Mon, Apr 17, 2023 at 11:03=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> nv50_display_create() is declared in another header, along with
> a couple of declarations that are now outdated:
>
> drivers/gpu/drm/nouveau/dispnv50/disp.c:2517:1: error: no previous protot=
ype for 'nv50_display_create'
>
> Fixes: ba801ef068c1 ("drm/nouveau/kms: display destroy/init/fini hooks ca=
n be static")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/disp.c | 1 +
>  drivers/gpu/drm/nouveau/nv50_display.h  | 4 +---
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 5bb777ff1313..9b6824f6b9e4 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -64,6 +64,7 @@
>  #include "nouveau_connector.h"
>  #include "nouveau_encoder.h"
>  #include "nouveau_fence.h"
> +#include "nv50_display.h"
>
>  #include <subdev/bios/dp.h>
>
> diff --git a/drivers/gpu/drm/nouveau/nv50_display.h b/drivers/gpu/drm/nou=
veau/nv50_display.h
> index fbd3b15583bc..60f77766766e 100644
> --- a/drivers/gpu/drm/nouveau/nv50_display.h
> +++ b/drivers/gpu/drm/nouveau/nv50_display.h
> @@ -31,7 +31,5 @@
>  #include "nouveau_reg.h"
>
>  int  nv50_display_create(struct drm_device *);
> -void nv50_display_destroy(struct drm_device *);
> -int  nv50_display_init(struct drm_device *);
> -void nv50_display_fini(struct drm_device *);
> +
>  #endif /* __NV50_DISPLAY_H__ */
> --
> 2.39.2
>

