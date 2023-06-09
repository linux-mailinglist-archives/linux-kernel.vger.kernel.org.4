Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11AE729069
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238189AbjFIGwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjFIGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:52:13 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFA26AD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:52:11 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-43b28436ebeso436331137.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686293530; x=1688885530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oPjVT2mzKDJ4waTXYPCRAi/fQfEeCZ1ToGp8WVCS1k=;
        b=AMrDv5qSazUL2j9KAPL4GXg47Jkk/zOqzKIynvCYX5v5HadY75+w9uGzjD8to31JYc
         ahJNr3XMFzLPfZHnCcFbVCcAp9G6NToocd3vN96uhW1uc92U4f6OxUEguwIYqf1yOVSb
         f9FbF6bCQ0gss7cJZ2iBSWFsExGEahkcIyk8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686293530; x=1688885530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oPjVT2mzKDJ4waTXYPCRAi/fQfEeCZ1ToGp8WVCS1k=;
        b=GsQW7IsqNusPZ0pyMh4lvMpx7fsv0lmrNApoUsvzsgl322c92SkPo5ca5GgRZrn8Y2
         /Ur2PqkQpDMI9oueXkRiYwJJyW+VmXQ7xi8Dk8atIv3szI1DjIOaQaplSXM4ohE0gK9J
         j2a4bZ/wXwWjg7dfAUq0LrAeEuapBnz06+PD1+VNBCZFlmqkwKyKqVkEXJnwJvdpxtZ4
         nTc99kfWKtjCGUgvj4HsXAkm0iCEFqtcPX4RLUsBC1tPk6cn8fIDd3lvauRAlTjX6E9r
         zTUXOs82um9PZqzIqhbyFTXVJ8MazVRO6IgC62OUnHakjxCjzMSLFsFCDiw5H426Pmnt
         RVGg==
X-Gm-Message-State: AC+VfDy6RiHlQWDiZUlqbcpiY3X969SBDjZ/RqVYIuztJlpdYovW00zt
        V8obz57GnIBVUNZo0oBXfnM4ovmLBNZbDWXjKgDhGQ==
X-Google-Smtp-Source: ACHHUZ5H0G+uDcpI9jSsgYQKUgPLvaqMo4qiM23ihIc/d00wCvHFaicn6AUMr4I7DJdUtBq/dv6BaaDq9XQepbS62H8=
X-Received: by 2002:a67:f457:0:b0:434:70b4:b356 with SMTP id
 r23-20020a67f457000000b0043470b4b356mr340620vsn.28.1686293530393; Thu, 08 Jun
 2023 23:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230607090653.2468317-1-wenst@chromium.org> <20230607090653.2468317-3-wenst@chromium.org>
 <6d5bd11c-6f57-adc9-b35c-78cb80882d52@collabora.com>
In-Reply-To: <6d5bd11c-6f57-adc9-b35c-78cb80882d52@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 9 Jun 2023 14:51:59 +0800
Message-ID: <CAGXv+5HnrYtMimwddNwf0723N_ihiQ_+WA=yCNWnxEneXwCo1Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: mediatek: mt8186: Wire up CPU
 frequency/voltage scaling
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 10:19=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/06/23 11:06, Chen-Yu Tsai ha scritto:
> > This adds clocks, dynamic power coefficients, and OPP tables for the CP=
U
> > cores, so that everything required at the SoC level for CPU freqency an=
d
> > voltage scaling is available.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 274 ++++++++++++++++++++++=
+
> >   1 file changed, 274 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8186.dtsi
> > index 1b754f7a0725..6735c1feb26d 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> > @@ -136,6 +136,240 @@ cci_opp_15: opp-1400000000 {
> >               };
> >       };
> >
> > +     cluster0_opp: opp-table-cluster0 {
> > +             compatible =3D "operating-points-v2";
> > +             opp-shared;
> > +
> > +             opp-500000000 {
> > +                     opp-hz =3D /bits/ 64 <500000000>;
> > +                     opp-microvolt =3D <600000>;
> > +                     opp-level =3D <15>;
>
> As far as I remember we don't need opp-level, can you please recheck that
> and in case remove the levels from all OPPs?

Looks like we don't need it for any of the DVFS stuff. I'll remove it from
all the OPP tables in all the patches.

ChenYu
