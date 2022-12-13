Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860A564B3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 12:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiLMLMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 06:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiLMLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 06:11:35 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3CCFA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 03:11:22 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5B01F3F664;
        Tue, 13 Dec 2022 12:11:20 +0100 (CET)
Date:   Tue, 13 Dec 2022 12:11:19 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350-sagami: Rectify GPIO keys
Message-ID: <20221213111119.g3lzt5heevfarvf7@SoMainline.org>
References: <20221210133850.3664-1-konrad.dybcio@linaro.org>
 <20221213090349.bvatkmozbf5tjsxc@SoMainline.org>
 <0c6bad50-500c-00b0-30c3-853b0c0a6d5e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6bad50-500c-00b0-30c3-853b0c0a6d5e@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-13 11:23:12, Konrad Dybcio wrote:
> 
> 
> On 13.12.2022 10:03, Marijn Suijten wrote:
> > On 2022-12-10 14:38:50, Konrad Dybcio wrote:
> >> With enough pins set properly, the hardware buttons now also work
> >> like a charm.
> >>
> >> Fixes: c2721b0c23d9 ("arm64: dts: qcom: Add support for Xperia 1 III / 5 III")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > 
> > Tested-by: Marijn Suijten <marijn.suijten@somainline.org> # On Xperia 5 III
> > 
> > However I also tested this on Xperia 1 III, and...
> > 
> >> ---
> >>  .../qcom/sm8350-sony-xperia-sagami-pdx214.dts | 24 ++++++++++
> >>  .../dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 47 ++++++++++++++++++-
> >>  2 files changed, 70 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
> >> index e6824c8c2774..6fa830bdc6bd 100644
> >> --- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
> >> +++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami-pdx214.dts
> >> @@ -10,6 +10,20 @@
> >>  / {
> >>  	model = "Sony Xperia 5 III";
> >>  	compatible = "sony,pdx214-generic", "qcom,sm8350";
> >> +
> >> +	gpio-keys {
> >> +		pinctrl-names = "default";
> >> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &g_assist_n>;
> >> +
> >> +		key-google-assist {
> >> +			label = "Google Assistant Key";
> >> +			gpios = <&pm8350_gpios 9 GPIO_ACTIVE_LOW>;
> >> +			linux,code = <KEY_LEFTMETA>;
> >> +			debounce-interval = <15>;
> >> +			linux,can-disable;
> >> +			gpio-key,wakeup;
> >> +		};
> >> +	};
> > 
> > ... please move this to board DTS.  Xperia 1 III would also like to have
> > it mapped.  Downstream DT indicates, and my local testing confirms, that
> > it is identical to Xperia 5 III (i.e. common to the Sagami board).
> > 
> > The other buttons work great on both devices!
> While I'd agree that having it like that would be nice for completeness,
> it's:
> 
> - not necessary, as the button is not physically there, so the user will
> never come into contact with it

I have the device in my hand right now and, unless I take an angle
grinder to it, it has this button.

How else did you expect me to successfully test it?

Maybe you are confused with Xperia 1 IV, which does _not_ have the
button.  Nor does Xperia 1 II, for that matter.

- Marijn

> - it will leak power, the plan is to park all unused pins after we get
> "good enough" support for our devices (not now, so as not to mess with
> ourselves in the dev process)
> 
> Konrad
