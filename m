Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BACE3700A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbjELOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 10:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241018AbjELOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 10:16:25 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A15613C02
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:56 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-3352b8b9b70so64404875ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683900954; x=1686492954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFiBEzqnUEk+6sTrPSpLHjEFJM2vHqqsIpaf2EaeOcM=;
        b=X5G/DP5NCCgDLszF2RNRyjcsxPMMC7fXDno2nviHR5RNymZa2KGp4mNpVhQzJJSAVK
         wB22ZhaAyIp37axpo58k2WVR8R65CPM6QpHDGfOC26CveBbs/iGBSrEyAB4/9I9jLYky
         O95+J7riNRPv821ae68G74Kp4rxO+fxunbzQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683900954; x=1686492954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFiBEzqnUEk+6sTrPSpLHjEFJM2vHqqsIpaf2EaeOcM=;
        b=DMX5gz3NBGWsIApVz3BnKibfehVu01Ata84r9EKiZG2Al46UCw/Ab588kuyedBpgcz
         XDV7Ewj+LNztzU0ggBIdpdpXFeuMyMRgBBtC45WJohk+vpt6nikAVUsjz+kHaVjpkgy9
         rMNjgTj3fhELKXlfNlwu4fzkFHykoqdzLhwGESVhwHZLHe813u64kxjeTYWXcODeRHt5
         qdekF3aM4E0WiuKcTg6hs2Y4PaD68Yq+V7XvWUEVMggH2yec02dr/h4/irx+1pR9Swhe
         okbpIMahD9+6Xo8wuD7Nyn/ZjbNJyj6po1/B9F6kd7YLnCunY5prX8wKrz6GHSFaVSpG
         lWSw==
X-Gm-Message-State: AC+VfDxn5+OWYW+yG88tU4/jMG5NB9U2TrRbTtb7ZUc+wu71SRdn4Uli
        nxnl7+7dz7nJhGfwPujimfdlkklSywUMspkg6Sg=
X-Google-Smtp-Source: ACHHUZ7vsXNkIEoAe45Sb+bBs/gykGWEfIa4DEF014pK3ZGxuo8JJQUVb0ESaDKbevNk6Llo9gbibA==
X-Received: by 2002:a92:3652:0:b0:335:b2b2:6710 with SMTP id d18-20020a923652000000b00335b2b26710mr6562476ilf.15.1683900954501;
        Fri, 12 May 2023 07:15:54 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id f5-20020a02a805000000b00411a1373aa5sm4873218jaj.155.2023.05.12.07.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 07:15:54 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33164ec77ccso709495ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 07:15:54 -0700 (PDT)
X-Received: by 2002:a05:622a:1188:b0:3ef:a55:7f39 with SMTP id
 m8-20020a05622a118800b003ef0a557f39mr473643qtk.12.1683900932805; Fri, 12 May
 2023 07:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.3.I525a2ed4260046d43c885ee1275e91707743df1c@changeid> <86ttwim0h9.wl-maz@kernel.org>
In-Reply-To: <86ttwim0h9.wl-maz@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 12 May 2023 07:15:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U63oWO+jSdSPN9ruRyyaFKQOMPOGHwio5+6j4vvygS-Q@mail.gmail.com>
Message-ID: <CAD=FV=U63oWO+jSdSPN9ruRyyaFKQOMPOGHwio5+6j4vvygS-Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: mediatek: mt8183: Add mediatek,gicr-save-quirk
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>, jwerner@chromium.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 1:13=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Thu, 11 May 2023 23:05:37 +0100,
> Douglas Anderson <dianders@chromium.org> wrote:
> >
> > Firmware shipped on mt8183 Chromebooks is affected by the GICR
> > save/restore issue as described by the patch ("dt-bindings:
> > interrupt-controller: arm,gic-v3: Add quirk for Mediatek SoCs w/
> > broken FW"). Add the quirk property.
> >
> > Fixes: e526c9bc11f8 ("arm64: dts: Add Mediatek SoC MT8183 and evaluatio=
n board dts and Makefile")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8183.dtsi
> > index 5169779d01df..39545172fce5 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -709,6 +709,7 @@ gic: interrupt-controller@c000000 {
> >                             <0 0x0c400000 0 0x2000>,   /* GICC */
> >                             <0 0x0c410000 0 0x1000>,   /* GICH */
> >                             <0 0x0c420000 0 0x2000>;   /* GICV */
> > +                     mediatek,gicr-save-quirk;
>
> Is that something you can safely generalise at the SoC level? Are
> these SoC solely used on Chromebooks, and/or

Hmmm, I thought I checked to make sure that the only users of these
upstream were Chromebooks, but I just double-checked and I obviously
was blind yesterday. You're right that I need to fix this. I will move
these to:

mt8195-cherry.dtsi
mt8192-asurada.dtsi
mt8183-kukui.dtsi

...it looks as if the common "baseboard" dtsi for mt8186 Chromebooks
hasn't been upstreamed yet, so we'll have to keep an eye on that and
make sure it gets the property.

When I spin this series early next week I'll make that change.


> without any hope of
> seeing any alternative FW being already in use?

I haven't seen anyone try to fully replace the firmware of a
Chromebook in the past. It would be a lot of work, certainly. More
common, I'd think, would be someone chaining an extra level of loader
between the existing firmware and the OS. I _think_ I've seen people
use a stripped down U-Boot for this. However, the "resident" firmware
would still be the one that the Chromebook ships with.

Certainly someone could prove me wrong and re-implement the firmware
on one of these Chromebooks. That person would need to follow the same
convention or accept that their kernel won't be enabling pseudoNMIs.

-Doug
