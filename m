Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D739D729922
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbjFIMKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 08:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238146AbjFIMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 08:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE776172E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 05:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686312563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NeKki35R3nHZloLkDG1ZCPTX7wZF5l/41ruoekgsNnQ=;
        b=MIp/R7qBa7mfk5AdPUkR1diGngRi0SFK/m439cnjaFPwLf+NphUUp+6LIWe7YNi+IMam3O
        U1NxhBrtq6134c/ZEiCpPmapnIE0HpP6Sf5tZukzjvLBSzqh19G/CC+cCHk294VD2mdg1v
        5fg2tV+xBAzKpzCSO0/S1Kre9oG0wzA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-iuYXl7NePCe6RRDG1_m84A-1; Fri, 09 Jun 2023 08:09:22 -0400
X-MC-Unique: iuYXl7NePCe6RRDG1_m84A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so1156961fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 05:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686312560; x=1688904560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeKki35R3nHZloLkDG1ZCPTX7wZF5l/41ruoekgsNnQ=;
        b=O972AqBkG4IYm6SE06dhmjfZAjFxhq9DtKP9f7Q05uRQi4d21vaJiTi9PPTXepXkSp
         tuObWMhESVBpc8Sym77I5IOPrfprczRjmWB0NI8X8mHopBxEQPK5oLQ9p/HhNrXYnhkT
         g9EHLRir/yWZVvr1NAO6l/xMqd3IdzBGetUYnpXfn/REZJ0XNbWIHt4T0ukepPs7mc/r
         zpbKzYrrgYuPWC1NQHp3YaXpBTf6g+9uBvcxwVahUrnF+AEtaaiKlguzQhI5IeNv+Slm
         s9oTq/wK6EEC7KxlCLLg3KVkNcWta/JrhP4TaLsGaSxVhr+26N2C7CY7jzB1eIchCRav
         pwsg==
X-Gm-Message-State: AC+VfDyUEr9XmSQn3XuO8GM4lU3DxEFtlFVXggHows09A6vcyeru+PIW
        u3ZVODsYYOVGUU8OMwo/ZSAG0OT7KkwUh62wrn9S/QfQihLK+DyWZNd+RAj4UOc36mh4mxyWA0D
        qsjdAFV3vawT5pe2Y3ZphH9z0yqnX5Xbkim09NCZuLby6pssN/CY=
X-Received: by 2002:a2e:b10a:0:b0:2b1:dc69:67fa with SMTP id p10-20020a2eb10a000000b002b1dc6967famr905439ljl.0.1686312560205;
        Fri, 09 Jun 2023 05:09:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4sGvitz6MAqdd6tZ18gCtAtzFKKnM7SaCsBhMqHlpY5riWAgGlYFCIjNbTYVkKWuGGwpXgGW07vlqLixzWvUU=
X-Received: by 2002:a2e:b10a:0:b0:2b1:dc69:67fa with SMTP id
 p10-20020a2eb10a000000b002b1dc6967famr905434ljl.0.1686312559950; Fri, 09 Jun
 2023 05:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230609081732.3842341-1-lee@kernel.org> <20230609081732.3842341-10-lee@kernel.org>
In-Reply-To: <20230609081732.3842341-10-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 9 Jun 2023 14:09:09 +0200
Message-ID: <CACO55ttX2efbweyUMoTQj4_aCmT6z_ke4_0vScoYUjtrzSaprw@mail.gmail.com>
Subject: Re: [RESEND 09/15] drm/nouveau/nvkm/engine/gr/gf100: Demote kerneldoc abuse
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
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:1044: warning: This comme=
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
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/gr/gf100.c
> index 5f20079c3660f..7d4c2264d3c05 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
> @@ -1040,7 +1040,7 @@ gf100_gr_zbc_init(struct gf100_gr *gr)
>         }
>  }
>
> -/**
> +/*
>   * Wait until GR goes idle. GR is considered idle if it is disabled by t=
he
>   * MC (0x200) register, or GR is not busy and a context switch is not in
>   * progress.
> --
> 2.41.0.162.gfafddb0af9-goog
>

