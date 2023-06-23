Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A347073BE7E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjFWSff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjFWSfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:35:18 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5188A2D56
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:34:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98cd280cf94so103605066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687545260; x=1690137260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2nFjoCVagpUQnGTY4TyMi8H++398zSsVgy7rwLSo8s=;
        b=LFJigGWmb5S+ZXH5JDPX+02ryKp56q4iluFWixab+bauwDbPsIQ6CQNqmuiSYNBNn1
         z4Orf7LrwvGYLKu+nQ64qZwVhxU3HnA7tvCfyuV2TOsHB1Q7QboUZiKotmNYDnFV5193
         gEfH9NrWkcKUo/YV6BGEnBo5adLvw6tRdwgy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687545260; x=1690137260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2nFjoCVagpUQnGTY4TyMi8H++398zSsVgy7rwLSo8s=;
        b=RUJzPfNo1UhG5LQuSI/E+OEcK1z9E+o5qY4O4EbiN6D8UYTz+5pKFPHqUJNF1QmTqB
         z8W7FEY3FVTWOZ8I/3UiwZjVeFiYdGgMPcJ0+H/hn+gQxdaRFOETm+KcJboUntUqyovk
         7iUZCyyt7ssZV3icxgiNaqUh9gmM47dsgH1UgK/w9882QvGw847cumFSuh/3OMMUDQeY
         ExIk9QPYRVWE/J/wZeZINXUWOYOTkTZIgIe4PX5zYxHcf/Xu2yA5bIvf4hZ6siXyLZ3i
         wlKCzejdYvfZcKG2WK4HAWPXqY9CUIbPE1bmw8vbpM+l+YIOMCH2eIHtcqNEIpWvUak6
         Lxmg==
X-Gm-Message-State: AC+VfDwA/sPdVVpUA1ia7/MzdagTthoVhnPtiS2wT3TGiC6E8qiaWOiO
        AIvMO6o9FzT4QLBIQAxnBWUCQ/GjrGLUZoC8bAzL+w==
X-Google-Smtp-Source: ACHHUZ5L9PsZjPfWj7Y92S54EKYGWZVcODX/BZLcZATfuLRGMkfolEoFSWUhaRVgohISP7dAYFOakA==
X-Received: by 2002:a17:906:58ce:b0:988:ffb9:b944 with SMTP id e14-20020a17090658ce00b00988ffb9b944mr11281550ejs.29.1687545260613;
        Fri, 23 Jun 2023 11:34:20 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906185900b009890f2c4cf9sm6369216eje.79.2023.06.23.11.34.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 11:34:17 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51bcf75c4acso1350a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:34:16 -0700 (PDT)
X-Received: by 2002:a50:9f89:0:b0:506:b280:4993 with SMTP id
 c9-20020a509f89000000b00506b2804993mr2667edf.2.1687545256551; Fri, 23 Jun
 2023 11:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-9-krzysztof.kozlowski@linaro.org> <29f6fb78-c122-2b71-61b8-2dc9aa27ad1d@linaro.org>
In-Reply-To: <29f6fb78-c122-2b71-61b8-2dc9aa27ad1d@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 23 Jun 2023 11:34:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UMqrAU9cLy3Ew5o1MJyNDAAG2TY1mvMkY2-8kiw6qpjg@mail.gmail.com>
Message-ID: <CAD=FV=UMqrAU9cLy3Ew5o1MJyNDAAG2TY1mvMkY2-8kiw6qpjg@mail.gmail.com>
Subject: Re: [PATCH 09/15] arm64: dts: qcom: sc7280-crd: add dummy Bluetooth
 VDDIO supply
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi,

On Mon, Jun 19, 2023 at 6:14=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
> On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> > Bluetooth requires VDDIO supply.  Due to lack of schematics provide
> > something dummy to satisfy `dtbs_check`:
> >
> >   sc7280-crd-r3.dtb: bluetooth: 'vddio-supply' is a required property
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> For this:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> +CC Doug to perhaps fix this properly (though I think we should have got
> it through the cros list anyway)
>
> Konrad
> >  arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts b/arch/arm64/bo=
ot/dts/qcom/sc7280-crd-r3.dts
> > index afae7f46b050..b1aa5b0ee95c 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-crd-r3.dts
> > @@ -24,6 +24,13 @@ aliases {
> >       chosen {
> >               stdout-path =3D "serial0:115200n8";
> >       };
> > +
> > +     bt_vddio: regulator-bt-vddio {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "bt-vddio";
> > +             regulator-min-microvolt =3D <1800000>;
> > +             regulator-max-microvolt =3D <1800000>;
> > +     };
> >  };
> >
> >  &apps_rsc {
> > @@ -38,6 +45,10 @@ vreg_s1k_1p0: smps1 {
> >       };
> >  };
> >
> > +&bluetooth {
> > +     vddio-supply =3D <&bt_vddio>;
> > +};
> > +

I would have a hard time believing that the more correct fix wouldn't be:

vddio-supply =3D <&vreg_l18b_1p8>;

Specifically L18B is what we have on the newer CRD (the one that is
considered a "herobrine" and includes Qcard) and also IDP2. In terms
of timeline / similarities, CRD-rev3 falls in between IDP2 and newer
CRD. These both agree on L18B. The only board that uses something
different (L19B) is the very old IDP1.

That being said, Qualcomm has never provided (at least to me)
schematics for any given reference board. Whenever asked, I was always
pointed at schematics that were said to be "close enough". Thus, I
can't really give a definitive answer here. Even so, pointing at L18B
seems to me to be 99% likely to be correct.

If anyone reading actually has schematics, I think you can just look
at what goes to the pad labelled "VDDPX_3". The datasheet I have shows
that as "Pad group 3 (most peripherals)". If nothing else, that powers
the pins connected to the UART that Bluetooth uses (along with a whole
pile of other things in the system).


-Doug
