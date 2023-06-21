Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CB7738F93
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjFUTDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjFUTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:03:36 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3ED1728
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 12:03:06 -0700 (PDT)
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AA11F200EF;
        Wed, 21 Jun 2023 21:02:41 +0200 (CEST)
Date:   Wed, 21 Jun 2023 21:02:40 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sm6115p-j606f: Hook up display
Message-ID: <e6zn3kqewck56qlmqysny7ntfmmgeoiu3oggbbsxfz4mngjip5@4f525mauepge>
References: <20230620-topic-gpu_tablet_disp-v1-0-7bb02bec8dc0@linaro.org>
 <20230620-topic-gpu_tablet_disp-v1-2-7bb02bec8dc0@linaro.org>
 <c9ed9e06-3a94-e8ee-7fb6-8ff66c41a32e@linaro.org>
 <02ee3320-4ff6-f713-3020-c2c82deb674a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02ee3320-4ff6-f713-3020-c2c82deb674a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-20 21:02:20, Konrad Dybcio wrote:
> On 20.06.2023 17:52, Dmitry Baryshkov wrote:
> > On 20/06/2023 16:17, Konrad Dybcio wrote:
> >> Enable the required nodes, add the required pins and tweak a
> >> regulator to enable non-simplefb display on the Tab P11.
> >>
> >> Do note that there exists a second SKU with a different panel+touch
> >> combo, but due to insufficient information, that will need to be
> >> handled separately.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>   arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts | 57 +++++++++++++++++++++--
> >>   1 file changed, 52 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> >> index 81fdcaf48926..a10ce676bd44 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
> >> @@ -65,9 +65,41 @@ ramoops@ffc00000 {
> >>       };
> >>   };
> >>   -&dispcc {
> >> -    /* HACK: disable until a panel driver is ready to retain simplefb */
> >> -    status = "disabled";
> >> +&mdss {
> >> +    status = "okay";
> >> +};
> >> +
> >> +&mdss_dsi0 {
> >> +    vdda-supply = <&pm6125_l18>;
> >> +    status = "okay";
> >> +
> >> +    panel: panel@0 {
> >> +        compatible = "lenovo,j606f-boe-nt36523w", "novatek,nt36523w";
> >> +        reg = <0>;
> >> +
> >> +        reset-gpios = <&tlmm 82 GPIO_ACTIVE_LOW>;
> >> +        vddio-supply = <&pm6125_l9>;
> >> +
> >> +        pinctrl-names = "default";
> >> +        pinctrl-0 = <&te_active &sde_dsi_active>;
> >> +
> >> +        rotation = <180>; /* Yep, it's mounted upside down! */
> >> +
> >> +        port {
> >> +            panel_in: endpoint {
> >> +                remote-endpoint = <&mdss_dsi0_out>;
> >> +            };
> >> +        };
> >> +    };
> >> +};
> >> +
> >> +&mdss_dsi0_out {
> >> +    data-lanes = <0 1 2 3>;
> >> +    remote-endpoint = <&panel_in>;
> >> +};
> >> +
> >> +&mdss_dsi0_phy {
> >> +    status = "okay";
> >>   };
> >>     &pm6125_gpios {
> >> @@ -212,8 +244,9 @@ pm6125_l17: l17 {
> >>           };
> >>             pm6125_l18: l18 {
> >> -            regulator-min-microvolt = <1104000>;
> >> -            regulator-max-microvolt = <1312000>;
> >> +            /* 1.104V-1.312V fixed @ 1.232V for DSIPHY */
> >> +            regulator-min-microvolt = <1232000>;
> >> +            regulator-max-microvolt = <1232000>;
> >>           };
> >>             pm6125_l19: l19 {
> >> @@ -282,6 +315,20 @@ sdc2_gate_pin: sdc2-gate-state {
> >>           bias-pull-up;
> >>           output-high;
> >>       };
> >> +
> >> +    te_active: te-active-state {
> >> +        pins = "gpio81";
> >> +        function = "mdp_vsync";
> >> +        drive-strength = <2>;
> >> +        bias-pull-down;
> >> +    };
> >> +
> >> +    sde_dsi_active: te-active-state {
> > 
> > mdss_dsi_active? Or just dsi_active?
> mdss is ok
> 
> Also Marijn pointed out in private that this node overwrites
> the previous one.. Thankfully video mode panels don't care about
> TE! :D

You're welcome!

(Why set this pin to mdp_vsync if the MDP won't read it, though?)

- Marijn

> 
> Konrad
> > 
> >> +        pins = "gpio82";
> >> +        function = "gpio";
> >> +        drive-strength = <8>;
> >> +        bias-disable;
> >> +    };
> >>   };
> >>     &ufs_mem_hc {
> >>
> > 
