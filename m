Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BFC6DB482
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDGTyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjDGTyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:54:04 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3A2A5D5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:54:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id p15so49957156ybl.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680897241; x=1683489241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrOIisSFZPNWCByFT5woSVh3MP9puEjylwTuN1wcUU0=;
        b=KNs4Z6iST1eCRxlgV0A5AwPGJX3DDaLDsNYwd2WfAM3HWFNS32SMsTzkCUOQDpp8CY
         8pUMDpYy/JCAidaaovrC2qABVmMu/QjM31/RptcubFCgSddMTViQvFBOTbVds13/5ihq
         e45aMntnEPRBOGvROt1ACVTsSMOCDMOrzIMqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897241; x=1683489241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrOIisSFZPNWCByFT5woSVh3MP9puEjylwTuN1wcUU0=;
        b=MwBqskfxb44EPvBWUUAAdbR2Q5ZWQVvtoe383rZLCuQM7VtwiHZ4BPx6vFdj1MAzQw
         7mtrlszBR2ki6/1exYeurRyxT/XR/3WPz6BebbyF/8SkBjzbt0Q/LmM2mOJ4ZbE5c8ny
         46eN19pBi7cyLYrWkQJLVj7MyAMnAFROJG5Mltf8pLdNCygy+5J7USO1OMZSUy5bN4Al
         kjx9zWyLeTNHdmT/1u7V+zJqo1s/muG8fzPMVSwdoB5h9FKx4QedlJcu78DfKTSff8hn
         08vvOLfYf7os2lkCUkse4+ckDJJUOB64gMjF6Wp82dU6kXhCvb7MFD943HALQlcOt58b
         g24g==
X-Gm-Message-State: AAQBX9e62nv/ZN4t6Pqai3ZvOldp2RRKafAacctwEc8Lnc9QRXN5qXSw
        667EeJnefqn3zPg7IwMJvKaL4vIIi7QLEQqrtP4=
X-Google-Smtp-Source: AKy350Z0fBcI6B6h6pcGAB9pWvZ5qdRzXk1yuOxiCYHIbYXBYohSJ0FQChGRzZ5V/MofYVQm6z8PTA==
X-Received: by 2002:a25:aa4c:0:b0:b8d:b209:7ac6 with SMTP id s70-20020a25aa4c000000b00b8db2097ac6mr251441ybi.11.1680897240686;
        Fri, 07 Apr 2023 12:54:00 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id v72-20020a252f4b000000b00b7767ca747csm1304476ybv.25.2023.04.07.12.53.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 12:53:59 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5491fa028adso316521517b3.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:53:59 -0700 (PDT)
X-Received: by 2002:a81:e20a:0:b0:54d:4a49:ba22 with SMTP id
 p10-20020a81e20a000000b0054d4a49ba22mr1345371ywl.7.1680897239277; Fri, 07 Apr
 2023 12:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230323173019.3706069-1-dianders@chromium.org>
 <20230323102605.12.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid> <43b74b3f-e607-ba55-a5fa-326fb4b5519d@linaro.org>
In-Reply-To: <43b74b3f-e607-ba55-a5fa-326fb4b5519d@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 7 Apr 2023 12:53:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VvgbPKQsOirMa-k0PE-KAvjWy+iMWd0TCbysYirwEH7w@mail.gmail.com>
Message-ID: <CAD=FV=VvgbPKQsOirMa-k0PE-KAvjWy+iMWd0TCbysYirwEH7w@mail.gmail.com>
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sc7180: Fix trogdor qspi pin config
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 7, 2023 at 11:11=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/03/2023 18:30, Douglas Anderson wrote:
> > In commit 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial
> > trogdor and lazor dt") we specified the pull settings on the boot SPI
> > (the qspi) data lines as pullups to "park" the lines. This seemed like
> > the right thing to do, but I never really probed the lines to confirm.
> >
>
>
> >  &qup_i2c2_default {
> > @@ -1336,6 +1340,22 @@ p_sensor_int_l: p-sensor-int-l-state {
> >               bias-disable;
> >       };
> >
> > +     qspi_sleep: qspi-sleep-state {
> > +             pins =3D "gpio63", "gpio64", "gpio65", "gpio68";
> > +
> > +             /*
> > +              * When we're not actively transferring we want pins as G=
PIOs
> > +              * with output disabled so that the quad SPI IP block sto=
ps
> > +              * driving them. We rely on the normal pulls configured i=
n
> > +              * the active state and don't redefine them here. Also no=
te
> > +              * that we don't need the reverse (output-enable) in the
> > +              * normal mode since the "output-enable" only matters for
> > +              * GPIO function.
> > +              */
> > +             function =3D "gpio";
> > +             output-disable;
>
> Doug,
>
> I acked some of your patches, but I assumed you tested all this. It
> turns out you never run dtbs_check on the patches you sent.

I'm fairly certain that I ran dtbs_check and confirmed that no new
errors were introduced on the device tree files that this patch series
cleaned up. Did I miss one? I did not try to go through and fix all
examples of people using "input-enable" across all Qualcomm device
trees, though. Those old device trees still work even if they're using
the now-deprecated bindings. When deprecating something my
understanding is that it's not required to go back and immediately
transition all old device tree files.

If having the "input-enable: false" in the bindings is causing huge
problems we could do a blank search-and-replace to rename it to
"output-disable", at least for places under "tlmm". Even if there are
cases where it's superfluous it would at least make the bindings
validate.

-Doug
