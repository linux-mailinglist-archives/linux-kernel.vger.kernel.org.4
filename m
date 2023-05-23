Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F95F70D1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbjEWC4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjEWC4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:56:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA29E6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:56:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so444415966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1684810589; x=1687402589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6o0pldmtPNZczHK6kfIrJdzD+PEWsvSqi4EjRqmT/Y=;
        b=e11dfn1JU9wXqIahkfF02Gf522PcNJQDKa2O7j7arpRNtAJ2Ix/FSqXIyTXApmyvpG
         xqvhZzMdbmyVbhaRlObPxzUge+C9oKx9Itqzwj4DNrXdFAv7kp+WvdGB3xE435lw7jFT
         lvi9pyaA8BQwwKnlMZbu2TcDjX1UkrFPiQO3C69lV78eRrsIeb7XactRS/+o2X6ds4Oq
         CifFeC8clqH8fHML5SIM/QY/85h3UAk2L1JwLDiHe79MTvP7VzfAmkruCWIZ+EVDvHan
         BQI2rTQ4F2c7bs5TAbu7rXfFX5jDWOEcGuxgoNYBfTHM+VE3nfXJKmrjVe9cyfPhhrBy
         /oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684810589; x=1687402589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6o0pldmtPNZczHK6kfIrJdzD+PEWsvSqi4EjRqmT/Y=;
        b=W2fI3ARQJIOMO4ROA0qDDvA8ajKY6RDdMGyVfwRfpVTkF+OjcuyNnPinlmNqv1D8Bb
         vGnygcxuaujeWnZCsXWW9l58Kc2/AgLruhDLnPGkx7DchsC7ggUWva/Ciz+a/fwZGeaZ
         ESzcmH0/WGI3vbj5urAAf9K64vnmL4pAiSpBCO36axlWR8XYT2Bdyd/wieP+Shq5hZpo
         lvzuZwhlu8tarwCKtcIvGWiFMw6phxobXKERHvs2qUcfCBbo+5fuVJWXNIkYb+bGF02F
         TKeuGNpjwd5wBFZfkYRzBJK4Ad56LrHRDqpnysEkv9XSbVdStgaBpVgVz8iZO8i1jLq/
         YmLw==
X-Gm-Message-State: AC+VfDzamTJHczIN9P4p2DTXtsUVzUhEPBLNNrs8G3sG/4WRxV8cRUXQ
        08mbLt3GPfDpZx9FkuucyK0E4TjslV+kL++nV/BAsw==
X-Google-Smtp-Source: ACHHUZ4Zm9Cx7sVlYhjjvAXSE1TSetEayzYnn2DXi0k6UasemtiYelBRWj9ZoL5JMF+LnmHGv/vUswTO23KNbH0i4+A=
X-Received: by 2002:a17:907:9716:b0:970:19a2:7303 with SMTP id
 jg22-20020a170907971600b0097019a27303mr2892607ejc.19.1684810589345; Mon, 22
 May 2023 19:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230523011522.65351-1-quic_bjorande@quicinc.com>
In-Reply-To: <20230523011522.65351-1-quic_bjorande@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Mon, 22 May 2023 21:56:18 -0500
Message-ID: <CAKXuJqjgRdr-16h3G_7u1KDfKBnfu2cmB9FsNYdKOpzOKawU=g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/msm/adreno: GPU support on SC8280XP
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, johan@kernel.org, mani@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 8:15=E2=80=AFPM Bjorn Andersson
<quic_bjorande@quicinc.com> wrote:
>
> This series introduces support for A690 in the DRM/MSM driver and
> enables it for the two SC8280XP laptops.
>
> Bjorn Andersson (3):
>   drm/msm/adreno: Add Adreno A690 support
>   arm64: dts: qcom: sc8280xp: Add GPU related nodes
>   arm64: dts: qcom: sc8280xp: Enable GPU related nodes
>
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  26 +++
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  26 +++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 169 ++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 113 +++++++++++-
>  drivers/gpu/drm/msm/adreno/a6xx_hfi.c         |  33 ++++
>  drivers/gpu/drm/msm/adreno/adreno_device.c    |  14 ++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  11 +-
>  7 files changed, 387 insertions(+), 5 deletions(-)
>
> --
> 2.39.2
>
Tested here on my X13s with GNOME 44.1 and using Wayland.

Tested-by: Steev Klimaszewski <steev@kali.org>
