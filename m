Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7663F5B7D2E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiIMWoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIMWoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:44:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218E606BF;
        Tue, 13 Sep 2022 15:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1679615D7;
        Tue, 13 Sep 2022 22:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF31C433C1;
        Tue, 13 Sep 2022 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663109061;
        bh=u+LdKw05eVC8NkkwkIGnnnew5oolemzm7O0U9HcAWEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kFsrrgAM5K/pMbh9DbkdQcJdez3iXO16FF/faMXQPaQxvZ9G+gNAq4MWD4pLbnJfU
         uMAMsrkDGRy1EjpRcrw30Xtp5kDDYuXJDKwZw5z8hBDbvZTxDSQZtRZYAr+dNVg50Z
         KohcyssjUif+mizdcAMzUpXXdIaPhkBMWeo3bAPypHjhh0sLdVfAZ5JK6pVy6pLlAu
         g31+ToD0CaUgPD97Gok5OhrcWWo28+fBeX3cFBRNrLPBJ7mjnv5QERM8QUco3BMF4j
         3cgaUtYnLIoY4FV/5frjl+sW1EMLEu0+1LCqfzOfvKKUCsZ3kxKROXP6Vgw+FsJjY0
         0V4mGSSxEOllw==
Date:   Tue, 13 Sep 2022 17:44:18 -0500
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
Message-ID: <20220913224418.jvvguc66y5le7qjo@builder.lan>
References: <20220909092035.223915-1-krzysztof.kozlowski@linaro.org>
 <20220909092035.223915-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909092035.223915-11-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 11:20:30AM +0200, Krzysztof Kozlowski wrote:
[..]
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index 90a6d4b7605c..ada232bed2c8 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -1189,7 +1189,7 @@ remoteproc_mss: remoteproc@fc880000 {
>  			resets = <&gcc GCC_MSS_RESTART>;
>  			reset-names = "mss_restart";
>  
> -			qcom,halt-regs = <&tcsr_mutex_block 0x1180 0x1200 0x1280>;
> +			qcom,halt-regs = <&tcsr_1 0x180 0x200 0x280>;
>  
>  			qcom,smem-states = <&modem_smp2p_out 0>;
>  			qcom,smem-state-names = "stop";
> @@ -1230,10 +1230,15 @@ smd-edge {
>  
>  		tcsr_mutex_block: syscon@fd484000 {
>  			compatible = "syscon";
> -			reg = <0xfd484000 0x2000>;
> +			reg = <0xfd484000 0x1000>;
>  		};
>  
> -		tcsr: syscon@fd4a0000 {
> +		tcsr_1: syscon@fd485000 {

While the accessed registers look general purpose in nature, I would
prefer that we stick with naming it based on the register blocks - and
this is part of what's named "tcsr_mutex".

Is it not possible to claim that this region is a
"qcom,msm8974-tcsr-mutex" and a "syscon"?

> +			compatible = "qcom,tcsr-msm8974", "syscon";
> +			reg = <0xfd485000 0x1000>;
> +		};
> +
> +		tcsr_2: syscon@fd4a0000 {

And I would like to keep this as "tcsr".

Regards,
Bjorn
