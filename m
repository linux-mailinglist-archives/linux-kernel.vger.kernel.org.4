Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8367250C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjARReA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjARRdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:33:55 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1892366A5;
        Wed, 18 Jan 2023 09:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674063230; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nTyGx3IBUOThxA5UW0x6SQXKNxe0UVidwVF/ILH8Y9+Z8S/daiPL2o626+Fkxqy74f
    iHQedwsTJLaXhKWInWV8u+S+7mmAwoPbCuyOK2XUSFGlrE0igHnghxzO/GY5bGVC7DC/
    tFMp4VkJlHruTj/0fe/XzLZk/Z7o2mUgS/YMExga8aaSnF33BWrYphVRlRtzyZ84UM7e
    57Sb9t1ZR+V7v0muO3kl9avVn6odH6sgnH543nWHLpE8/U2FWOROWAZJNmfMWTJXI5T6
    +hpjSFy6hPrUvresjKpaN60JpCBao33fMFzUjM9L1DQLV/lfOhkb5pSk5DMyx+uBCp8y
    7/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674063230;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=LhU3r4sZfO0h84dSgJ90dRQ0Xnm8CosoxMUeoX+kEY0=;
    b=lW/71BGfGza5oHKJsBp33AZyRlVgdG/iyY9Pe9427uUbb397iE9fQfYagFJTB89H3v
    2gn2FCSczSy0uaZ+Zbs18CK33++GP/XNt/3LlWz98aFGLLnxYBNudPV/7cQjdFZrda9X
    vVf7isZ+BeCWKUMqZsSJDZnCdt/aPBKZ9t0HymbQadjX13k53BlGk5ltrELjTrejI6SR
    nZqOv+n7ktpKIiEo23vtWuLx4HalbbmsDwEZi1hmE79/I2TV5r1Ld/IbtC+sb6HTCvL9
    mLywnqVdcHHEGH4Gsa1KhLor3uAH/hV5I/h2mOKaJFUMxPkbKuiqYvEur8lNv/4WykCt
    zIWg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674063230;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=LhU3r4sZfO0h84dSgJ90dRQ0Xnm8CosoxMUeoX+kEY0=;
    b=WC4S4Oj5/ADgdtmFtA1J6VT9/XbEfYWTL4w2GFuB6epZnTMWb2d80U4JEfaEWN9d9/
    B1qNou0E5/wxwsy5RIuw3sAcfGN0hyGfDI3HfUCyUDtCuzP5yJotwksxsdYcS1IjnDpH
    Zx24quTGTwH2UNOo7QOqpV2n1ur74ykZUyPvRIwpCRCD91vipEMqPOOPQxvs9+3KONzx
    TvuUOeCErGdkSLM/MCTh4RgSeZQtz7jaGx54/2jkMkogDqU7itsWW2WJBmY64W09B5X0
    FX1mPiDq/WHylv7qEhhZcXNJ/XeNT49Gq3i651Tz2JMZE/K5lYPqHMc4VWrtyp2cfcoK
    7ejw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWx/bI"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.0.0 DYNA|AUTH)
    with ESMTPSA id 92895dz0IHXn0Q6
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 18 Jan 2023 18:33:49 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:33:42 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org, Jun Nie <jun.nie@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Max Chen <mchen@squareup.com>, Zac Crosby <zac@squareup.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH v3 5/8] arm64: dts: qcom: Add msm8939 SoC
Message-ID: <Y8gtdpDnMLIwfj+3@gerhold.net>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-6-bryan.odonoghue@linaro.org>
 <Y8fC/GCHfENQmBNC@gerhold.net>
 <cf4920e6-c007-20a5-ba3a-5005b22f891b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf4920e6-c007-20a5-ba3a-5005b22f891b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:50:20AM +0000, Bryan O'Donoghue wrote:
> On 18/01/2023 09:59, Stephan Gerhold wrote:
> > On Tue, Jan 17, 2023 at 02:48:43AM +0000, Bryan O'Donoghue wrote:
> [...]
> > > +		mdss: display-subsystem@1a00000 {
> > > +			compatible = "qcom,mdss";
> > > +			reg = <0x01a00000 0x1000>,
> > > +			      <0x01ac8000 0x3000>;
> > > +			reg-names = "mdss_phys", "vbif_phys";
> > > +
> > > +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> > > +			interrupt-controller;
> > > +
> > > +			clocks = <&gcc GCC_MDSS_AHB_CLK>,
> > > +				 <&gcc GCC_MDSS_AXI_CLK>,
> > > +				 <&gcc GCC_MDSS_VSYNC_CLK>;
> > > +			clock-names = "iface",
> > > +				      "bus",
> > > +				      "vsync";
> > > +
> > > +			power-domains = <&gcc MDSS_GDSC>;
> > > +
> > > +			#address-cells = <1>;
> > > +			#size-cells = <1>;
> > > +			#interrupt-cells = <1>;
> > > +			ranges;
> > > +
> > > +			mdp: display-controller@1a01000 {
> > > +				compatible = "qcom,mdp5";
> > > +				reg = <0x01a01000 0x89000>;
> > > +				reg-names = "mdp_phys";
> > > +
> > > +				interrupt-parent = <&mdss>;
> > > +				interrupts = <0>;
> > > +
> > > +				clocks = <&gcc GCC_MDSS_AHB_CLK>,
> > > +					 <&gcc GCC_MDSS_AXI_CLK>,
> > > +					 <&gcc GCC_MDSS_MDP_CLK>,
> > > +					 <&gcc GCC_MDSS_VSYNC_CLK>,
> > > +					 <&gcc GCC_MDP_TBU_CLK>,
> > > +					 <&gcc GCC_MDP_RT_TBU_CLK>;
> > > +				clock-names = "iface",
> > > +					      "bus",
> > > +					      "core",
> > > +					      "vsync",
> > > +					      "tbu",
> > > +					      "tbu_rt";
> > > +
> > > +				iommus = <&apps_iommu 4>;
> > > +
> > > +				interconnects = <&snoc_mm MASTER_MDP_PORT0 &bimc SLAVE_EBI_CH0>,
> > > +						<&snoc_mm MASTER_MDP_PORT1 &bimc SLAVE_EBI_CH0>,
> > > +						<&pcnoc MASTER_SPDM &snoc SLAVE_IMEM>;
> > > +				interconnect-names = "mdp0-mem", "mdp1-mem", "register-mem";
> > 
> > As I mentioned a already in a direct email at some point, AFAIU adding
> > interconnects should be an [almost-] all or nothing step. If you only
> > add interconnects for MDP then everything else that needs bandwidth will
> > either break or only continue working as a mere side effect of MDP
> > voting for permanent high bandwidth.
> 
> We did discuss that. You'll also recall we concluded we would have to revert
> this patch to make that happen.
> 
> commit 76a748e2c1aa976d0c7fef872fa6ff93ce334a8a
> Author: Leo Yan <leo.yan@linaro.org>
> Date:   Sat Apr 16 09:26:34 2022 +0800
> 
>     interconnect: qcom: msm8939: Use icc_sync_state
> 
> but then why not revert for all of these SoCs too ?
> 
> drivers/interconnect/qcom/msm8939.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/msm8974.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/msm8996.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/osm-l3.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sc7180.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sc7280.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sc8180x.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sc8280xp.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sdm845.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sdx55.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sdx65.c:		.sync_state = icc_sync_state,
> drivers/interconnect/qcom/sm6350.c:		.sync_state = icc_sync_state,
> 
> until such time as we have an all or nothing interconnect setup for each of
> those SoCs ?
> 
> Yes I take your point "some peripherals will appear to work only as a result
> of the AHB vote the MDP casts here" but, that is a bug in the definition of
> that hypothetical peripheral.
> 
> The MDP/display won't run without the interconnect here and the only way to
> pull it is to remove sync_state which begs the question why not pull
> sync_state for all SoCs without a perfect interconnect description ?
> 
> I think that would be a retrograde step.
> 

Most of the SoCs you list do have "interconnects" defined for most
components, which means the situation for them is quite a different
level. It's probably not necessary to have the interconnect setup
absolutely perfect before enabling it. However to avoid frustration for
people with slightly different board setups it should at the very least
cover more than one component.

Should the icc_sync_state() change be reverted for some of these SoCs?
If you ask me: Yes!

Perhaps a real example makes my concern more understandable: As I
mentioned, you rely on MDP providing the necessary bandwidth for the
entire system. This works fine in your case, but it can happen easily
that MDSS/MDP is not enabled at all, e.g.:

 - On a board without display.
 - During early bring-up: I usually start with UART, USB and SDHCI
   before I even think about enabling the display.

I simulated this on the BQ Aquaris M5 (MSM8939) that has most
functionality set up already in postmarketOS. First the results without
any changes (interconnects enabled like in your patch here):

 -> Boots into rootfs in about *18 seconds*, feels fine

Now I just disable MDSS in the device tree and boot again:

	&mdss {
		status = "disabled";
	};

 -> Boots into rootfs in about *80 seconds*, everything feels sluggish

This is 4 times the normal boot time, and nothing in dmesg tells me that
it's because I don't have display enabled. Someone porting a new device,
especially without UART, might have given up already before waiting so
long. Plus, what would I do to fix this on a board without display? :/

Now I try removing icc_sync_state:

 -> Boots into rootfs in about 17 seconds, feels fine

IMO it is clear that adding icc_sync_state() too early is a bad idea,
and *will* break some setups.

Thanks,
Stephan
