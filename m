Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6F5BD60B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 23:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiISVBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 17:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiISVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 17:01:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC314BD15;
        Mon, 19 Sep 2022 14:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8380B82079;
        Mon, 19 Sep 2022 21:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A833EC433C1;
        Mon, 19 Sep 2022 21:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663621280;
        bh=nC6JjfmhqKverqUFYc6+hszN/sAtLAzckdoYygEb4VQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brINUOq51au/UCj+9LYA4nQ28haVSUsCo1HvTepGy/2i+mVmOzTdhfyMCgYCXxR6I
         MLEaz2oisQA28QFIcCL0my/PX/km6jiggO3KdsccPKsb9IODbg3hC8oBdP38hu1sqk
         UYAy40X/6UQ6w32PBLozY1ND/Aq50JhhXmJRPNsN0Bq9ujOLm/CprjVMBeYiYnX8Dn
         nBjohyucnY1yNWr1Ql8JttG641I8XF9ulHavQZyFBeLbzVReFGHcjXWjzY+Q0oxFra
         Wi7KjTFWOeDYRk+6N8v1Nst4vOzUJPG7NKhm5TdvqT1U/QqcN8RDmlFbdsongWJAot
         ZAbBiY6ih6eCQ==
Date:   Mon, 19 Sep 2022 16:01:17 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/15] ARM: dts: qcom: msm8974: split TCSR halt regs
 out of mutex
Message-ID: <20220919210117.gcwv4hc7etvzbju2@builder.lan>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
 <20220909092035.223915-11-krzysztof.kozlowski@linaro.org>
 <20220913224418.jvvguc66y5le7qjo@builder.lan>
 <79889adc-9224-c257-3957-3a02ec55f091@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79889adc-9224-c257-3957-3a02ec55f091@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 03:49:37PM +0100, Krzysztof Kozlowski wrote:
> On 13/09/2022 23:44, Bjorn Andersson wrote:
> > On Fri, Sep 09, 2022 at 11:20:30AM +0200, Krzysztof Kozlowski wrote:
> > [..]
> >> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> >> index 90a6d4b7605c..ada232bed2c8 100644
> >> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> >> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> >> @@ -1189,7 +1189,7 @@ remoteproc_mss: remoteproc@fc880000 {
> >>  			resets = <&gcc GCC_MSS_RESTART>;
> >>  			reset-names = "mss_restart";
> >>  
> >> -			qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
> >> +			qcom,halt-regs = <&tcsr_1 0x180 0x200 0x280>;
> >>  
> >>  			qcom,smem-states = <&modem_smp2p_out 0>;
> >>  			qcom,smem-state-names = "stop";
> >> @@ -1230,10 +1230,15 @@ smd-edge {
> >>  
> >>  		tcsr_mutex_block: syscon@fd484000 {
> >>  			compatible = "syscon";
> >> -			reg = <0xfd484000 0x2000>;
> >> +			reg = <0xfd484000 0x1000>;
> >>  		};
> >>  
> >> -		tcsr: syscon@fd4a0000 {
> >> +		tcsr_1: syscon@fd485000 {
> > 
> > While the accessed registers look general purpose in nature, I would
> > prefer that we stick with naming it based on the register blocks - and
> > this is part of what's named "tcsr_mutex".
> 
> Then everything would be like:
> 
> tcsr_mutex_1: syscon@fd484000
> tcsr_mutex_2: syscon@fd485000
> tcsr: syscon@fd4a0000
> ?
> 
> > 
> > Is it not possible to claim that this region is a
> > "qcom,msm8974-tcsr-mutex" and a "syscon"?
> 
> Hm, yes, that's another approach. We can go this way, but it has one
> drawback - you could have two different devices (mutex and syscon user)
> poking to the same registers. The regmap makes it safe from concurrency
> point of view, but not safe from logic point of view.
> 
> Splitting these makes it sure, that no one touches hwlock registers,
> except the hwlock driver.
> 
> Any preference?
> 

Certainly would be interesting if someone grabs the syscon and pokes at
the mutex registers, but I do prefer to have the DT match the register
regions when possible.

So if you're okay with making the whole tcsr mutex a hwlock and syscon
I prefer that.


PS. I picked all non-8974 patches from the series, just in case that
wasn't clear from the ty-letters.

Thanks,
Bjorn

> > 
> >> +			compatible = "qcom,tcsr-msm8974", "syscon";
> >> +			reg = <0xfd485000 0x1000>;
> >> +		};
> >> +
> >> +		tcsr_2: syscon@fd4a0000 {
> > 
> > And I would like to keep this as "tcsr".
> 
> 
> 
> Best regards,
> Krzysztof
