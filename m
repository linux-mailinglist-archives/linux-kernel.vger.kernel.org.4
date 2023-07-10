Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D4B74CA42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 05:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGJDOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 23:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGJDOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 23:14:03 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19441FE
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 20:13:54 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-76c64da0e46so122171439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 20:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688958833; x=1691550833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0f/movtZorEjzM+r+LRTHIo16m8aSFE9mANkKWC//k=;
        b=no2y0TQ4/yKxX0RXyXuSTxFQfu3EbpAm10/8WV5Ukh+ZB5dfVOzBujk3dzyE2Tq7CM
         YDRJnq0KLmpf9cELtrHZ9T7/MxX/f3mk0kT2SAs0HGG8LAGIM3m+XsFTJqzfnL6UGg2M
         XibZ9NF+tjCbFU5EK3wmrAnGpBzlw6RRTNWgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688958833; x=1691550833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0f/movtZorEjzM+r+LRTHIo16m8aSFE9mANkKWC//k=;
        b=SEN3YnhxomZiIXXoAXsro0l651RszZIdYRzWsuj3TE694YBjNrD7bLxxUkj6qRG3SR
         ByqTv440ZQjkqEuZK7E+5iW1EmgybAKqiahM3huaL5jEy5/DlBQRTcKnifRHI4kYdsTu
         n7nTnaq+EO2uGTHG0aU1ZqH2xT8GqDCnLi1PkNqkSZwZv3qqtwz9bcFFoddl7nkkMtXI
         k9Y6PFdAvNzSmRM9JH+Nb3fEn3leFbgnN3y/tP1NZAeux2+M9+yfxqA2wxPANUjmjnPk
         ELAep+CrVuXbVO72SPOrmYkn9QIp5WrKcm09wuUrtkyXLujjCSn2vw1MrnZVdzz8mPgH
         +QNQ==
X-Gm-Message-State: ABy/qLZTnQCrLARr1kgviBFJmNkBMHM/IGfY/WMW5PdGIgTHVcc4Md9R
        eQ5yK5iwXpU/nQpmogGmMEIrdWxBObSsbruPK6M=
X-Google-Smtp-Source: APBJJlHg/BWPphdJkZH4z+FJJGST+7TNcekCbka3yAu+Cdp/fchR2m0wXJ4/WgVi3nC3m8/D+bvfMA==
X-Received: by 2002:a6b:e813:0:b0:787:8d2:f15 with SMTP id f19-20020a6be813000000b0078708d20f15mr2099329ioh.8.1688958833268;
        Sun, 09 Jul 2023 20:13:53 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id eq28-20020a0566384e3c00b0042b16c005e9sm3084604jab.124.2023.07.09.20.13.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 20:13:52 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7835e2286c4so122074939f.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 20:13:52 -0700 (PDT)
X-Received: by 2002:a5d:8f89:0:b0:783:63d6:4c5 with SMTP id
 l9-20020a5d8f89000000b0078363d604c5mr436352iol.12.1688958832360; Sun, 09 Jul
 2023 20:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230709162641.6405-1-jason-jh.lin@mediatek.com> <20230709162641.6405-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20230709162641.6405-3-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 10 Jul 2023 11:13:16 +0800
X-Gmail-Original-Message-ID: <CAC=S1njmD1+12dS5x20XLR650nkRpkyM-dKjaierSLknuTPRuw@mail.gmail.com>
Message-ID: <CAC=S1njmD1+12dS5x20XLR650nkRpkyM-dKjaierSLknuTPRuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/mediatek: Fix iommu fault during crtc enabling
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Jul 10, 2023 at 12:27=E2=80=AFAM Jason-JH.Lin <jason-jh.lin@mediate=
k.com> wrote:
>
> OVL layer should not be enabled before crtc is enabled.
> The plane_state of drm_atomic_state is not sync to
> the plane_state stored in mtk_crtc during crtc enabling,
> so just set all planes to disabled.
>
Please add the "Fixes" tag before your S-o-b.

Regards,
Fei
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/me=
diatek/mtk_drm_crtc.c
> index d40142842f85..51d10e65004e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -410,6 +410,9 @@ static int mtk_crtc_ddp_hw_init(struct mtk_drm_crtc *=
mtk_crtc)
>                 unsigned int local_layer;
>
>                 plane_state =3D to_mtk_plane_state(plane->state);
> +
> +               /* should not enable layer before crtc enabled */
> +               plane_state->pending.enable =3D false;
>                 comp =3D mtk_drm_ddp_comp_for_plane(crtc, plane, &local_l=
ayer);
>                 if (comp)
>                         mtk_ddp_comp_layer_config(comp, local_layer,
> --
> 2.18.0
>
>
