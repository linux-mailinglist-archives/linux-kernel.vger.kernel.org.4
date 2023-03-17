Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF0F6BEAC8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCQONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjCQON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE1060AAC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679062361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yp87O6wnvt7RQSGAMv2L+yB9U1AJut+1ZDcle+GOMDo=;
        b=IjdzIhqHLgK61VQosMWVWRb8iL1z+zdoG0GTO+0rofqjjmDObGnCRtonBhHZrqP1GmhClV
        GO/zgqiTofs0CDpuhfRQ5D5Ksv7G0VhBtL6SMPISYAFzvENm7PJMpWAmQYV05YQhPQzFPx
        m1qWRR/amPvkcOFUGHN/R8jsymBKAro=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-a_QZWpKSPveRpmeoV6nu2A-1; Fri, 17 Mar 2023 10:12:40 -0400
X-MC-Unique: a_QZWpKSPveRpmeoV6nu2A-1
Received: by mail-lf1-f72.google.com with SMTP id i16-20020ac25b50000000b004b565e69540so2086835lfp.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp87O6wnvt7RQSGAMv2L+yB9U1AJut+1ZDcle+GOMDo=;
        b=DMi0hIfTnXcxg0db7SfrU98DBY0HpOXGhwLfqVuCWqx/Yxnpr7SeVFsZjKbmyhySWf
         3N+BwA/XDbcHYHJonmdcaH3EQLLUA2xMPsq7YH93iu1XuFT+PxXKYoOaFSYkzDZnbgNx
         0JFfprf/f+x1RUvtrX8rJO2gL51kBUQ61xIQT4TU8fguwh8EHUYX2rg4M/6IsInLthFe
         J3gpieszpkYj24hUeJ9kT8IfTRKX0V2auGfkS9zh/U3ufk6sD8x8RbKwnwziM0HRRea6
         af58PYJwqhNZQEEZT2Whviw3rDKrGN+WHh08DA3CWyg2cnNH6eBGylhIklDK5SWt967i
         ZEGQ==
X-Gm-Message-State: AO0yUKVlbQkYCABklqe0Af854LJGluaXEr6+LTCZGED2lUGbUEdN4WGj
        B6vmA53toe3drbqRxkklNq7J31GwCfGpLUZme429hoFdJbjMGeh6AC3BoCfUqUZ5NDg633ILO/E
        9qIa4l5+O0Tkwga9Y3WV3tTQqOGvJrc9/u+H9zxba
X-Received: by 2002:ac2:5f0e:0:b0:4dd:a9e5:aa09 with SMTP id 14-20020ac25f0e000000b004dda9e5aa09mr4264612lfq.11.1679062358652;
        Fri, 17 Mar 2023 07:12:38 -0700 (PDT)
X-Google-Smtp-Source: AK7set+gife62n4XCWkrR4+tagPTjJbFZJF9q30pel5qgQh2IP2UWNPkn6gpFTJqvxpuh0cZgm/VqXngWGM2qrRSjIk=
X-Received: by 2002:ac2:5f0e:0:b0:4dd:a9e5:aa09 with SMTP id
 14-20020ac25f0e000000b004dda9e5aa09mr4264607lfq.11.1679062358352; Fri, 17 Mar
 2023 07:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-32-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-32-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 17 Mar 2023 15:12:26 +0100
Message-ID: <CACO55ttNWZ8=Ma4m+-zFP3yAPpHYqsq3QF6fCd4jYpEK6uwypg@mail.gmail.com>
Subject: Re: [PATCH 31/37] drm/nouveau/dispnv04/crtc: Demote kerneldoc abuses
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau changes up to here are:

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Fri, Mar 17, 2023 at 9:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
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
> 2.40.0.rc1.284.g88254d51c5-goog
>

