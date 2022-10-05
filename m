Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392865F5891
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJEQrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJEQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:47:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9187E325
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:47:18 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id 13so36746952ejn.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4CwWMo2JGRY1sMiWNR7k+Ale2KMVO8Hjg3Kq/pxZMJY=;
        b=O6/3blg4wsZVwKDgWn9jP7CdlMdOeT7PFyrDnu5lkaB6/VWh3mr+PbMj2x4WjOqZz/
         DdcJOO95ZVEVZAmGlbkeXkpBV3PJPv+ITijJCcfk0s+IrB/5ZBR2PwPNl0h7vTT5+XEQ
         9ll+thaq8/DoCwd1CJfKwWOwBvzIE6vpvnGTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CwWMo2JGRY1sMiWNR7k+Ale2KMVO8Hjg3Kq/pxZMJY=;
        b=Pe17ooCknlkyXPR98LNd5Pe8XZ704a2t4To5kTIq++/TNIBIriDWl5VhWbYsrLFYen
         n9QzDHs2fJl9/ay/4w0wlIOn7Q511EvsIjF0eYAXkqCiNQEojtrSmF9cQPJyg3005uZi
         V+/NL0IF1o4BC188NcjIpdTIHxYisvd9nG/grKE2CWzqLdpbQNc8W71MfQtEUZFnxAFV
         w64Tp8nXxwEYDztSJyBE3+X3gBmtxxI+W/VN8oglSU4UeJpIoIvHzsxaqjTqAIIE/10q
         X2d+5wtP/MQfcJfooSd/BqPsHRQgQL0dbpZVVY5cXv7Mo44eti+xX1qtDS/awiYJTvRz
         8x7A==
X-Gm-Message-State: ACrzQf2zK8VgsFiIolEWt48gwoKr7PtRkXl0Qul91OC+kPmw0jn5wZ2b
        dGAbZAuOiGgeq3PcxwNix7q/N29ZRLnC9sz7
X-Google-Smtp-Source: AMsMyM5DWgXHoIs14r4eWzQ8IW0lfH53GbqJuN5/t5U1B0dHmsLddu1H/RaAvPUec7EhYCGT2mse/w==
X-Received: by 2002:a17:907:2cd3:b0:77c:3e23:7bec with SMTP id hg19-20020a1709072cd300b0077c3e237becmr422485ejc.380.1664988437103;
        Wed, 05 Oct 2022 09:47:17 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090653ce00b00781d411a63csm8850134ejo.151.2022.10.05.09.47.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:47:16 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id l8so11146717wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:47:16 -0700 (PDT)
X-Received: by 2002:a05:600c:19cf:b0:3b4:c8b6:15c6 with SMTP id
 u15-20020a05600c19cf00b003b4c8b615c6mr4040185wmq.85.1664988436259; Wed, 05
 Oct 2022 09:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221003102735.39028-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221003182637.v6.3.I50d04dcbe735dda69995cf1078824d671501869e@changeid>
In-Reply-To: <20221003182637.v6.3.I50d04dcbe735dda69995cf1078824d671501869e@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 5 Oct 2022 09:47:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VT88P3SbN6GhKE6_RwLM6P9oKh0Mro7P614YfzDoid_w@mail.gmail.com>
Message-ID: <CAD=FV=VT88P3SbN6GhKE6_RwLM6P9oKh0Mro7P614YfzDoid_w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: Add touchscreen and touchpad
 support for evoker
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 3, 2022 at 3:28 AM Sheng-Liang Pan
<sheng-liang.pan@quanta.corp-partner.google.com> wrote:
>
> Change touchpad and touchscreen node for evoker
> Touchpad: SA461D-1011
> Touchscreen: GT7986U
>
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
>
> Changes in v6:
> - add removed pinctrl and align touchscreen label with herobrine board
>
> Changes in v5:
> - Touchscreen / trackpad patch new for v5
>
>  .../boot/dts/qcom/sc7280-herobrine-evoker.dtsi    | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> index e78072159d54b..d1723fbffae67 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-evoker.dtsi
> @@ -23,16 +23,15 @@ ap_tp_i2c: &i2c0 {
>         status = "okay";
>         clock-frequency = <400000>;
>
> -       trackpad: trackpad@2c {
> -               compatible = "hid-over-i2c";
> -               reg = <0x2c>;
> +       trackpad: trackpad@15 {
> +               compatible = "elan,ekth3000";
> +               reg = <0x15>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&tp_int_odl>;
>
>                 interrupt-parent = <&tlmm>;
>                 interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>
> -               hid-descr-addr = <0x20>;
>                 vcc-supply = <&pp3300_z1>;
>
>                 wakeup-source;
> @@ -43,9 +42,9 @@ ts_i2c: &i2c13 {
>         status = "okay";
>         clock-frequency = <400000>;
>
> -       ap_ts: touchscreen@10 {
> -               compatible = "elan,ekth6915";
> -               reg = <0x10>;
> +       ap_ts: touchscreen@5d {
> +               compatible = "goodix,gt7375p";
> +               reg = <0x5d>;

You silently ignored my feedback here:

[1] https://lore.kernel.org/r/CAD=FV=XHr9Y6oQR19wVVHC6jzcd82hf1bHNbr62n89vuTbme9Q@mail.gmail.com

Did you not see it? Did you ignore it for a reason?

-Doug
