Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3076BEACE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 15:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCQOOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 10:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjCQOOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 10:14:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F692943B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679062427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3t3amNCtDqC/lfWvkx2OeWsv1F0lpA23KA/QFJT56c=;
        b=hSApxDA3UP5R0j1fjSr7bLYGMPlPMZuBmfI0wqfe7BNQSdICB2r5Ov0qlNO1X4St7/tmu3
        d6uYTvvlZbqK/Yz10DYC0ZhrJFecjr80IjiJ9a0TGlwSN/UhLswCmKrFzMpRkgYhi0ESkT
        SYrLpRKHreWqwqXaBsdVRBlQ0Bnhkgs=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-6JOQ4LpkNdq1FHtobfEWzg-1; Fri, 17 Mar 2023 10:13:46 -0400
X-MC-Unique: 6JOQ4LpkNdq1FHtobfEWzg-1
Received: by mail-lf1-f71.google.com with SMTP id j20-20020a056512345400b004dc807c2948so2061779lfr.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 07:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679062425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3t3amNCtDqC/lfWvkx2OeWsv1F0lpA23KA/QFJT56c=;
        b=PviAR7QfnKzT4LoHOAwT+IgiEKb4JNB5obcQ38xiEUUK8Jh/EzO4r+/wrnrBzqsQFn
         ZOsSfWAqmXbJ6kIZWgBgkp0392KIlhoYcPs/aesmOzK+DC7YJF0cKV3n0Btz2gL4VW1Q
         TnTUSVw0DKOy6n5903myoIiLoK5XWLG8J1Wx/d+2vuXtxBLywrdj6lhG33kxTGMrGU7T
         P4G7Euqj3/z8zQk46ppN7nAltBinoLdADjNpy8lgMftNiMAojGHDd5vBJbGeJLFcjdp1
         lkSiqLQHOpktF+BhZN6jNkaIsSrjGSkqcw5Mn98DYohnl3gTuiNaePLu4rnCMS6P9M5c
         XYYg==
X-Gm-Message-State: AO0yUKWp1bgh6OR/8yVnLxFEFUpTB/j7pkK3quN3oCEKRIasYAL+J6yF
        EUvX1mlHsau637N5HagP/YhHchWGpq+7SC/MQiIhgMmqVB1KvrRVusuvNzxtnhKQFmtcrH8pon6
        q7eaqaHwUPTfUKOFZZC8M4ugBi0qfvTJg/x2+QQLo
X-Received: by 2002:a2e:7219:0:b0:299:a9db:9c with SMTP id n25-20020a2e7219000000b00299a9db009cmr1892446ljc.9.1679062425124;
        Fri, 17 Mar 2023 07:13:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set/UVaZlNRO6LvO15jv6aTQnuB6SzJ0szl6fC+WBTGAbN3WhmLWh7oNZLb7TFuLt94eePQ6MUGSYqhV29x+safI=
X-Received: by 2002:a2e:7219:0:b0:299:a9db:9c with SMTP id n25-20020a2e7219000000b00299a9db009cmr1892428ljc.9.1679062424881;
 Fri, 17 Mar 2023 07:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230317081718.2650744-1-lee@kernel.org> <20230317081718.2650744-35-lee@kernel.org>
In-Reply-To: <20230317081718.2650744-35-lee@kernel.org>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 17 Mar 2023 15:13:33 +0100
Message-ID: <CACO55tuhLEdRxGGnpMwfvj0s4E2kR74xyYdGfeokD4xSR3G7cg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAzNC8zN10gZHJtL25vdXZlYXUvbnZrbS9lbmdpbmUvZ3IvdHUxMDI6IA==?=
        =?UTF-8?B?Q29tcGxldGVseSByZW1vdmUgdW51c2VkIGZ1bmN0aW9uIOKAmHR1MTAyX2dyX2xvYWTigJk=?=
To:     Lee Jones <lee@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, nouveau@lists.freedesktop.org
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

On Fri, Mar 17, 2023 at 9:23=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c:210:1: warning: =E2=80=98=
tu102_gr_load=E2=80=99 defined but not used [-Wunused-function]
>

mhh, this looks a little fishy and might be a mistake not using this functi=
on.

Ben, is it safe to remove it? The code seems to be slightly different
things, but also looks like it needs to be rewritten a little anyway.

> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c b/drivers/gpu=
/drm/nouveau/nvkm/engine/gr/tu102.c
> index 10a7e59482a6f..a7775aa185415 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c
> @@ -206,19 +206,6 @@ tu102_gr_av_to_init_veid(struct nvkm_blob *blob, str=
uct gf100_gr_pack **ppack)
>         return gk20a_gr_av_to_init_(blob, 64, 0x00100000, ppack);
>  }
>
> -static int
> -tu102_gr_load(struct gf100_gr *gr, int ver, const struct gf100_gr_fwif *=
fwif)
> -{
> -       int ret;
> -
> -       ret =3D gm200_gr_load(gr, ver, fwif);
> -       if (ret)
> -               return ret;
> -
> -       return gk20a_gr_load_net(gr, "gr/", "sw_veid_bundle_init", ver, t=
u102_gr_av_to_init_veid,
> -                                &gr->bundle_veid);
> -}
> -
>  static const struct gf100_gr_fwif
>  tu102_gr_fwif[] =3D {
>         {  0, gm200_gr_load, &tu102_gr, &gp108_gr_fecs_acr, &gp108_gr_gpc=
cs_acr },
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>

