Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6865964FE64
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiLRKSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 05:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiLRKSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 05:18:50 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89097DED0;
        Sun, 18 Dec 2022 02:18:46 -0800 (PST)
Received: from SoMainline.org (94-209-172-39.cable.dynamic.v4.ziggo.nl [94.209.172.39])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 5BBB21F7B6;
        Sun, 18 Dec 2022 11:18:43 +0100 (CET)
Date:   Sun, 18 Dec 2022 11:18:41 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6125-seine: Clean up gpio-keys
 (volume down)
Message-ID: <20221218101841.mjsmnwtfzbmazfys@SoMainline.org>
Mail-Followup-To: Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221217100455.52593-1-marijn.suijten@somainline.org>
 <11174eb6-0a9d-7df1-6f06-da4010f76453@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11174eb6-0a9d-7df1-6f06-da4010f76453@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-17 16:04:17, Konrad Dybcio wrote:
> On 17.12.2022 11:04, Marijn Suijten wrote:
> > [..]
> > @@ -270,6 +270,16 @@ &sdhc_1 {
> >  
> >  &tlmm {
> >  	gpio-reserved-ranges = <22 2>, <28 6>;
> > +
> > +	gpio_keys_state: gpio-keys-state {
> > +		key-volume-down-pins {
> I see no need for defining a wrapper node.
> The other changes look good!

I did the same for sm6350-lena, which we should flatten out then too.

For these uses I'm not sure when it's clearer/better to use:

    thing@x {
        pinctrl-0 = <&thing_state>;
        ...
    };

    thing_state: thing-state {
        specific-pin {
            ...
        };

        other-specific-pin ...
        ...
    };

Or separate out the pins with their own state and instead use:

    thing@x {
        pinctrl-0 = <&specific_pin1_state &specific_pin2_state>;
        ...
    };

If I had to guess the former groups related pins together (as we finally
do now for SDC...) which should all be toggled at once.  In this
specific gpio-keys case, irrespective of whether it has one or more
keys, the pins aren't related apart from representing keys, and should
thus better be individual pinctrl nodes and individually referenced in
pinctrl-X.

Did I sympathize that correctly?

(side-note: the SDC pinctrl groups typically get extended with a
 card-detect pin in board DTS or in some likely-erroneous cases directly
 in SoC DTSI.  This may also count as unrelated pins being grouped
 together only because that is how the hardware/DTS node consumes them,
 but it is rather concise/readable/convenient though...)

- Marijn
