Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9370D940
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236141AbjEWJiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjEWJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A55194
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684834647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+TAJ51kmQXr16zT02BkW6TkdFoXJfwtWEG43wr2zqYI=;
        b=Do9We+fewiIzH4JxkuuvUf6WhWR6fRR+uqGsXNwRfs7PsSax7UjwzbcX8VQsAouMK29tOM
        dkX0fFWaL6B6YTSXiztWUEV8vmlRp84nfMfowGe4T5RHlD/E4o/xv1TzQum4Mfbas4UJrZ
        56Aw37yQSs+cCGQASZGB5t3jOmcRpJU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-acP-eFktMCmkABKSf8niZA-1; Tue, 23 May 2023 05:37:26 -0400
X-MC-Unique: acP-eFktMCmkABKSf8niZA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-4f3aada5081so547858e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 02:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684834644; x=1687426644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+TAJ51kmQXr16zT02BkW6TkdFoXJfwtWEG43wr2zqYI=;
        b=BqGQKaUjKdxsz1wr+t27GpPxTonLTOkILTEHeE67UaRdE2sE+tb5dArj5M7Vcv/TQB
         6j1DRQvJekCnVZMQbCko1CJjyPcOd4H1xagQ0Q332WzKlz8ZGCKW6YdzMPoJWAPMjcK3
         +yPYi+U4Pi5OnwbpL67Ca++8z4+C6b97FZmIQpmXJD06khzVL+bLlTMcYj0aa24w8BK5
         fVN/oCfEUqxjvATfkxbShIvfMsMuiQiS5u98lDWHKvFsuShtkm11iPKMLSFGbZxusEoq
         gIvD3g0cstq9aNP3fpznYVU7leNWqBusDHYCwfvphhszgu5qc+kzyFu7gyqVynhxgIwT
         RncQ==
X-Gm-Message-State: AC+VfDzv885sITKugkSzZR8gIdJnw8by0n6sRoOVdNSOPeM6XyDJNdQW
        0hJgFnlpef0xtBg7kMaL2lt7bH36rhzr0OSOPHLDDO4Srf4H9rx5iJz1kUOyZWKf7jGpWCCxZSS
        9Kpo2pFmA80vJCEe6LGLzEsY36sFIo4sIUM2xgcJmKBKG5MHu
X-Received: by 2002:a2e:b543:0:b0:2b0:2214:f817 with SMTP id a3-20020a2eb543000000b002b02214f817mr1806093ljn.3.1684834644383;
        Tue, 23 May 2023 02:37:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6wfUxvYYMlMNYwsAxAvtMPY98o1s7TG750zKkGUBhjjl6rfxJ9Oo5E13RWKqWTlG86vS4OkxKnbLDWvHZB7oY=
X-Received: by 2002:a2e:b543:0:b0:2b0:2214:f817 with SMTP id
 a3-20020a2eb543000000b002b02214f817mr1806084ljn.3.1684834644065; Tue, 23 May
 2023 02:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230522201838.1496622-1-kherbst@redhat.com>
In-Reply-To: <20230522201838.1496622-1-kherbst@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Tue, 23 May 2023 11:37:13 +0200
Message-ID: <CACO55tuZeJZ6GTA+ooaXsSgde2Zy70qpe8Cg_AEfZRXtmd2LWA@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/acr: Abort loading ACR if no firmware was found
To:     linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gourav Samaiya <gsamaiya@nvidia.com>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 10:18=E2=80=AFPM Karol Herbst <kherbst@redhat.com> =
wrote:
>
> This fixes a NULL pointer access inside nvkm_acr_oneinit in case necessar=
y
> firmware files couldn't be loaded.
>
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/212
> Fixes: 4b569ded09fd ("drm/nouveau/acr/ga102: initial support")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c b/drivers/gpu=
/drm/nouveau/nvkm/subdev/acr/base.c
> index 795f3a649b12..6388234c352c 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c
> @@ -224,7 +224,7 @@ nvkm_acr_oneinit(struct nvkm_subdev *subdev)
>         u64 falcons;
>         int ret, i;
>
> -       if (list_empty(&acr->hsfw)) {
> +       if (list_empty(&acr->hsfw) || !acr->func->wpr_layout) {

Now thinking about this, it should probably also check acr->func...

>                 nvkm_debug(subdev, "No HSFW(s)\n");
>                 nvkm_acr_cleanup(acr);
>                 return 0;
> --
> 2.40.1
>

