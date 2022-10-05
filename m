Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B735F5678
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJEOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJEOdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48433726BC;
        Wed,  5 Oct 2022 07:33:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D41A761711;
        Wed,  5 Oct 2022 14:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3426CC433D6;
        Wed,  5 Oct 2022 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664980382;
        bh=HdBlfFl8jGo4OuHeYZOj/KRQp4yVBoqYdSXVGWECtEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgCLTQiNARm/2jIWx3ys8DJmqlF4halN1oJ8znoS1tYCBQR3IgWrshV09tuCPZ6iI
         ovGJCcVzhQ7XcNDmrrWl+CjqcNeCS7aXeiWGGDPOVv+kB+lWBolp5cIwWC0aQ4U/tq
         2WMjhqDfSPUUfzwPvejFU2TaX0zeDdiiuNE5BQ1/TpItP8GjmKR1wDWzw1mjjr00ta
         MzryyKhpTVpCxNmr36t7erwx6vKBCeWl9DKsHyyzymzxUf5hvs601teBFgauU/KTLp
         P5FZ0FpethCnlU2UPGEls7ezvUXpdpCzgyJZoQQ3wChsYVeypt1Fas7WyKMCiq5Vq7
         uILtINfOZOOOg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1og5SH-000064-KH; Wed, 05 Oct 2022 16:33:02 +0200
Date:   Wed, 5 Oct 2022 16:33:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Brian Masney <bmasney@redhat.com>
Cc:     andersson@kernel.org, agross@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH v3] arm64: dts: qcom: sc8280xp: correct ref_aux clock for
 ufs_mem_phy
Message-ID: <Yz2VnYHaTHVpiJAM@hovoldconsulting.com>
References: <20220830180120.2082734-1-bmasney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830180120.2082734-1-bmasney@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:01:20PM -0400, Brian Masney wrote:
> The first UFS host controller fails to start on the SA8540P automotive
> board (QDrive3) due to the following errors:
> 
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag: Sending flag query for idn 18 failed, err = 253
>     ufshcd-qcom 1d84000.ufs: ufshcd_query_flag_retry: query attribute, opcode 5, idn 18, failed
>         with error 253 after 3 retries
> 
> The system eventually fails to boot with the warning:
> 
>     gcc_ufs_phy_axi_clk status stuck at 'off'
> 
> This issue can be worked around by adding clk_ignore_unused to the
> kernel command line since the system firmware sets up this clock for us.
> 
> Let's fix this issue by updating the ref clock on ufs_mem_phy. Note
> that the downstream MSM 5.4 sources list this as ref_clk_parent. With
> this patch, the SA8540P is able to be booted without clk_ignore_unused.

You should fix the Subject which still refers to the "ref_aux" clock.

> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Fixes: 152d1faf1e2f3 ("arm64: dts: qcom: add SC8280XP platform")

I can confirm that this is needed also for sc8280xp-crd and sa8295p-adp,
so with Subject fixed:

Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

> ---
> v2 of this patch can be found at
> https://lore.kernel.org/lkml/20220825163755.683843-1-bmasney@redhat.com/T/#u
> 
> v1 of this patch can be found at
> https://lore.kernel.org/lkml/20220623142837.3140680-1-bmasney@redhat.com/T/#u
> 
> Note that there's also a similar issue with the second UFS controller
> (ufs_card_hc) since it separately fails with:
> 
>     ufshcd-qcom 1da4000.ufs: Controller enable failed
>     ufshcd-qcom 1da4000.ufs: link startup failed 1
>     ...
>     gcc_ufs_card_axi_clk status stuck at 'off'
> 
> We are currently disabling the second UFS host controller (ufs_card_hc) in
> our DTS at the moment. I haven't had any luck so far tracking this one
> down and it's particularly tough without docs access.

Yeah, the lack of documentation is a pain. I took a closer look at this
today, and the CRD ACPI tables only appear to enable
GCC_UFS_REF_CLKREF_CLK even if GCC_UFS_1_CARD_CLKREF_CLK is also left
enabled by the boot firmware (note that that's "UFS_1_CARD" and not
"UFS_CARD" as the vendor dts uses for the first controller).

Neither card reference clock appears to be needed for the controllers on
the CRD and ADP so I think we should go with this approach also for the
second controller for now. If it turns out some platform actually needs
the card refclocks we should describe the relationship to
GCC_UFS_REF_CLKREF_CLK in the clock driver instead.

Input from Qualcomm on this would be great too.

>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 49ea8b5612fc..2bdde4b8f72b 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -891,7 +891,7 @@ ufs_mem_phy: phy@1d87000 {
>  			ranges;
>  			clock-names = "ref",
>  				      "ref_aux";
> -			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			clocks = <&gcc GCC_UFS_REF_CLKREF_CLK>,
>  				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>  
>  			resets = <&ufs_mem_hc 0>;

Johan
