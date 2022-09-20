Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C315BE981
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiITPBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiITPBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:01:09 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702CF2F67C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:01:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hy2so3155409ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bgEx5Kq7VOtgOD4buse7/uZ+x/Y62IUaR73vqEIPjzY=;
        b=cTVeOnTCemK2eDtJ48pOWoYFEU595KeXCZLrFWFtGsVITlGRdvZds+c5nNbbI8rj6M
         2u1nbBOGh718+CaQ2CgFoQqVOhezMg2ARLOyfFbUhVnpnSyuz/ToLYbVuaIrkfsClTDb
         IF9bBTAX/ESuuaxx750IS7TnhoSL3/F32uS+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bgEx5Kq7VOtgOD4buse7/uZ+x/Y62IUaR73vqEIPjzY=;
        b=Sc5CHWphjc00X+zXjsdHWTIfUy+AKTGh+QqdnHC2yWIgug8521UY+sBF6hocJgqjNA
         z6JFQrteYFhUTC1XPtqHBeGT4tv1Dn9lol+4rgpN64MU7Yu3lYQXMl5N82k3I/paijcQ
         tQp8W/+1yu6+4+Iu5MlElJmC6HFo7IMtDWIDr1l0W9guH4faQHR0uIMTaX/wB5oGPNao
         zVh3X69qzuI4j63qFctLTQkiONyfuLh3fsKf3xsRda7a7asKr9Dq5mKmVbmScf44LHY0
         fNA+CMGYgQoMBs2+7nCe8T+HBXUqzuu+FiKEmvmG5HFG1YknXMwucCK4le+08/Vb4tgN
         r+uw==
X-Gm-Message-State: ACrzQf1vU3Kx08+X6v/edkuup7h9EGhYHU8SAFHvQsvVJyq2wICb40Gp
        lI/p1+UBpgF86C93KmJNjF/8ktKIwj1DV6FJ
X-Google-Smtp-Source: AMsMyM5rItk7ij86aHTHm7P2SKtlg8NNf4XHiusqvv9kzFnBY7Ew+AjfEOJbfv3r7gHpwwm1De7krA==
X-Received: by 2002:a17:906:4fd2:b0:781:320f:b779 with SMTP id i18-20020a1709064fd200b00781320fb779mr9401567ejw.59.1663686064755;
        Tue, 20 Sep 2022 08:01:04 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id z17-20020a170906669100b007420aaba67esm18782ejo.36.2022.09.20.08.01.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:01:02 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id b5so4758956wrr.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:01:02 -0700 (PDT)
X-Received: by 2002:a5d:522f:0:b0:228:dc7f:b9a8 with SMTP id
 i15-20020a5d522f000000b00228dc7fb9a8mr15014256wra.617.1663686062063; Tue, 20
 Sep 2022 08:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220916040330.1.Ia3be91283bd937d08e7321140c89e4a0e2b78cf6@changeid>
In-Reply-To: <20220916040330.1.Ia3be91283bd937d08e7321140c89e4a0e2b78cf6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Sep 2022 08:00:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMmF2J-DQwa+o3aMUtajDtPkNfQEeruwL8cO1Nfv=hhA@mail.gmail.com>
Message-ID: <CAD=FV=XMmF2J-DQwa+o3aMUtajDtPkNfQEeruwL8cO1Nfv=hhA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add touchscreen for pazquel360
To:     Yunlong Jia <ecs.beijing2022@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dmitry Torokhov <dtor@chromium.org>
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

On Thu, Sep 15, 2022 at 9:04 PM Yunlong Jia <ecs.beijing2022@gmail.com> wrote:
>
> The model used is elan ekth3915, compatible with ekth3500.

If I wanted to be very purist about this I'd probably argue that we
should include both compatibles, the true one and the fallback one,
AKA:

compatible = "elan,ekth3915", "elan,ekth3500";

...which would, of course, require a bindings update as well. In
practice everyone that uses the ekth3500 compatible is ignoring this
and it seems unlikely to make a huge difference. As long as the power
sequencing is fine then the elan driver can discover and account for
any differences at runtime. Thus, I won't insist.


> Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>
>
> ---
>
>  .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 22 +++++++++++++++++++

The file you're modifying doesn't exist yet. Bjorn landed a bunch of
patches recently but he seems to have missed yours, AKA the two
patches that include:

https://lore.kernel.org/r/20220901024827.v3.2.Iea2d2918adfff2825b87d428b5732717425c196f@changeid/

You should have mentioned this dependency "after the cut". Since you
use patman that would involve using "Commit-notes:" to mention the
dependency.

Another (probably better) option would have just been to send a v4 of
your unlanded series and add the touchscreen in there.


>  1 file changed, 22 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> index 5702325d0c7b..14ea94ce90c1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
> @@ -14,6 +14,28 @@
>         realtek,dmic-clk-rate-hz = <2048000>;
>  };
>
> +ap_ts_pen_1v8: &i2c4 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       ap_ts: touchscreen@10 {
> +               compatible = "elan,ekth3500";
> +               reg = <0x10>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
> +
> +               interrupt-parent = <&tlmm>;
> +               interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
> +
> +               hid-descr-addr = <0x0001>;
> +
> +               vcc33-supply = <&pp3300_ts>;
> +               vccio-supply = <&pp1800_l10a>;
> +               reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
> +       };
> +};
> +
> +
>  &keyboard_controller {

nit: Only one blank line between nodes here, not two. Please spin the
patch for this. Once you do then feel free to add my Reviewed-by tag.

So in summary you have two options and I'm OK with either:

1. Spin a v4 of your original "pazquel360" patch series and just
squash this one into it.

2. Leave the original "pazquel360" patch series alone and send a v2 of
this patch series. In your v2 you'd remove the extra blank line and
use "Commit-notes:" to mention your dependency on the other series.

I suspect Bjorn would prefer #1 but he's free to correct me.
