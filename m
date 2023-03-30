Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82286D0DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjC3Sb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC3Sby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:31:54 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A735A2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:31:53 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id g9so14456539uam.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680201111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bmgWM4VeyB5ih4GlZbThd/2eiyQX/X/Evx0/5WbwLA=;
        b=n7Fbcx5kLC5PQCrKOLLphRB+Qj+CJ1V2n+6VE2q9x8tgdTfNT/TvljT9Ud5D0Sev+I
         jSx0/mE5wPBJBUslQrVt+msUKR8oj3psvddiRCxHXDNcC7JwUdR4++FURzyQa2lH2oPP
         QrylpyoNqKGTbaDitz5XTgPk8P5ruj9xa1qC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680201111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bmgWM4VeyB5ih4GlZbThd/2eiyQX/X/Evx0/5WbwLA=;
        b=0UvjUmRJtyo6pg+e20egV0P8wkKa2FpYR8ueaOFHL6dcP75hxMhJfJvGhgmAOwHKKE
         dpCeVDXpUTn+AVa8pXif5WMCL5cKO+uh6k2AdcD7TgsOkug4mHTU9zu5Do9T5z9DJL2c
         deIAML9wxDsC/IDF4DCnT0AUjvrn/FA2kTFeU1b5TmMKWBBAtQ1DptS0eSt1wkxRJOi5
         k2CDT+oPTGbzA5ca5a/Dwhz/Y1eeT4ynMbPRHoWoGzY+VAlAJCqINUSFV4ftSWaiZlFV
         Nt3hS4YNV5yh6GCDx30Zft6MnnDIiIo2pcfC21EPHDbV7ON6TrNU1iut1bxpja3bws7x
         qmFA==
X-Gm-Message-State: AAQBX9d6QH+lP85lWmdB2CKJ5WJ9XNJoryvJWy/66enFP0IqwsvRTZgl
        flLuPxlYRu6x9SuS9Ib7b1MyebKmqbsAQcC4cuU=
X-Google-Smtp-Source: AKy350aACrcFTbR3lPTu6vlqkLjAL0MkJAs60OamVoMZ0EhPcDJCVd26cehJivCctgna8JCl38bw7Q==
X-Received: by 2002:a1f:b696:0:b0:432:2c6f:f246 with SMTP id g144-20020a1fb696000000b004322c6ff246mr8951249vkf.3.1680201111138;
        Thu, 30 Mar 2023 11:31:51 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 2-20020a1f1102000000b0041280d4601asm89275vkr.51.2023.03.30.11.31.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 11:31:50 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id b6so13814128vsu.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:31:50 -0700 (PDT)
X-Received: by 2002:a67:c18a:0:b0:425:cf00:e332 with SMTP id
 h10-20020a67c18a000000b00425cf00e332mr13402479vsj.7.1680201109830; Thu, 30
 Mar 2023 11:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230324195555.3921170-1-markyacoub@google.com> <20230324195555.3921170-10-markyacoub@google.com>
In-Reply-To: <20230324195555.3921170-10-markyacoub@google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Mar 2023 11:31:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xvu++Bvkkq+xORUB0OWq_49nupFgCqsbX0XJz8vgy0Zw@mail.gmail.com>
Message-ID: <CAD=FV=Xvu++Bvkkq+xORUB0OWq_49nupFgCqsbX0XJz8vgy0Zw@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] arm64: dts: qcom: sc7180: Add support for HDCP
 in dp-controller
To:     Mark Yacoub <markyacoub@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        seanpaul@chromium.org, suraj.kandpal@intel.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Mar 24, 2023 at 12:56=E2=80=AFPM Mark Yacoub <markyacoub@chromium.o=
rg> wrote:
>
> From: Sean Paul <seanpaul@chromium.org>
>
> Add the register ranges required for HDCP key injection and
> HDCP TrustZone interaction as described in the dt-bindings for the
> sc7180 dp controller.
>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
>
> ---
> Changes in v3:
> -Split off into a new patch containing just the dts change (Stephen)
> -Add hdcp compatible string (Stephen)
> Changes in v4:
> -Rebase on Bjorn's multi-dp patchset
> Changes in v5:
> -Put the tz register offsets in trogdor dtsi (Rob C)
> Changes in v6:
> -Rebased: Removed modifications in sc7180.dtsi as it's already upstream
> Changes in v7:
> -Change registers offset
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/bo=
ot/dts/qcom/sc7180-trogdor.dtsi
> index 47f39c547c41a..63183ac9c3c48 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -816,6 +816,14 @@ &mdss_dp {
>         status =3D "okay";
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&dp_hot_plug_det>;
> +
> +       reg =3D <0 0x0ae90000 0 0x200>,
> +             <0 0x0ae90200 0 0x200>,
> +             <0 0x0ae90400 0 0xc00>,
> +             <0 0x0ae91000 0 0x400>,
> +             <0 0x0ae91400 0 0x400>,
> +             <0 0x0aed1000 0 0x174>,
> +             <0 0x0aee1000 0 0x2c>;

Reviewed-by: Douglas Anderson <dianders@chromium.org>
