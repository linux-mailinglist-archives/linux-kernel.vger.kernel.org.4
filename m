Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E146672F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjASCdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:33:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B27A24E;
        Wed, 18 Jan 2023 18:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59D69B81EC9;
        Thu, 19 Jan 2023 02:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B5AC433D2;
        Thu, 19 Jan 2023 02:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674095620;
        bh=5Smc6C7tydtzL5d24F63+rI88PVmmAbhfxmvAcF59tU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRXeWuxzVsNLeP+aIOe/gOF5eRjeHUtApWMcX1LDesp50/PmZrWx9IT3NTozGNp/e
         DqXilXk3l7QSEZNgxa/213Vh6JOjnqgn9cbxLS2hkpRjgiGATJOYkfnc34Ifg05Kgc
         Lfs11ZcmEURbcB6TlWtwKFxU26fxujofhH6xE3h0qfQTFPebxxetnrviFCUdS7sUj8
         KXreMxzk5rLahGa0CUOwECRNRigTm6qa4mlJvzaYz2s/QqsuPIrDEqXoKBGKjUDQAw
         Wc6xwBToKJmOURBy/5epJFr6o+/DqKD7mw4KG163QsM4gSGrWMe3SHpmEf21y1IFu1
         dqjemBy3M4Ilw==
Date:   Wed, 18 Jan 2023 20:33:37 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8226: add clocks and clock-names to
 gcc node
Message-ID: <20230119023337.h6a7f56lizhv4tcy@builder.lan>
References: <20230118180852.351143-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118180852.351143-1-rayyan@ansari.sh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 06:08:52PM +0000, Rayyan Ansari wrote:
> Add the XO and Sleep Clock sources to the GCC node.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
> index 4cba25dad8d6..c261fdfbe116 100644
> --- a/arch/arm/boot/dts/qcom-msm8226.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
> @@ -370,6 +370,11 @@ gcc: clock-controller@fc400000 {
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
>  			#power-domain-cells = <1>;
> +
> +			clocks = <&xo_board>,

If I read the downstream sources [1] correctly, we're missing XO_CLK_SRC
among the 8974 rpm clocks. But that's what "xo" in &gcc should refer to.

Can you please define this clock and use it instead?

[1] https://source.codeaurora.org/quic/la/kernel/msm/tree/arch/arm/mach-msm/clock-8974.c?h=msm-3.4#n715

Regards,
Bjorn

> +				 <&sleep_clk>;
> +			clock-names = "xo",
> +				      "sleep_clk";
>  		};
>  
>  		mmcc: clock-controller@fd8c0000 {
> -- 
> 2.39.0
> 
