Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA56679F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239926AbjALP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjALPzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:55:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089032EA4;
        Thu, 12 Jan 2023 07:46:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0BBEB81EA3;
        Thu, 12 Jan 2023 15:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A71C433D2;
        Thu, 12 Jan 2023 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673538358;
        bh=iVDRSaiL1SV1gIg3rI/gRJbp33B+9oKnazXw2LxQG3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqN/+ilmPSN/TmR0Xp7mxNYQ/NaT5gO61irxzKDo8a5Bnl0vCtAIe8rlXw4JgPiXR
         7HTSVsX9rp/u88c5rz9pTI1leIEz9HvkPY2Lk0kGAT22m2YsdmbAnpM+pxsDmaezGT
         ojcdZZfjzAOpgQxeT/UhVdwehMlOiqxDAUF4oUmTi1qJWprZLKU2lQs8kEuul/uLC/
         2vmWIMK3AJfbbgGCChPemxzwP8nBav+uRffJfdIOjAoOU2DgnjenHIG4K1wFu48vm1
         4l/ITxKKJI+CWBoz2JEvKraJMNFT1qWiEurzFnQ0jB6vw+grukHGtgtd05mKDxl8FN
         ZqSfExKogT4tg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFzmH-0002RG-VL; Thu, 12 Jan 2023 16:46:06 +0100
Date:   Thu, 12 Jan 2023 16:46:05 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Use MMCX for all DP
 controllers
Message-ID: <Y8ArPbvjnBYW3UDi@hovoldconsulting.com>
References: <20230112135055.3836555-1-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112135055.3836555-1-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:50:55AM -0800, Bjorn Andersson wrote:
> While MDSS_GDSC is a subdomain of MMCX, Linux does not respect this
> relationship and sometimes invokes sync_state on the rpmhpd (MMCX)
> before the DisplayPort controller has had a chance to probe.
> 
> The result when this happens is that the power is lost to the multimedia
> subsystem between the probe of msm_drv and the DisplayPort controller -
> which results in an irrecoverable state.
> 
> While this is an implementation problem, this aligns the power domain
> setting of the one DP instance with that of all the others.
> 
> Fixes: 57d6ef683a15 ("arm64: dts: qcom: sc8280xp: Define some of the display blocks")
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 4f4353f84cba..4511fd939c91 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -2533,7 +2533,7 @@ mdss0_dp3: displayport-controller@aea0000 {
>  				interrupts = <15>;
>  				phys = <&mdss0_dp3_phy>;
>  				phy-names = "dp";
> -				power-domains = <&dispcc0 MDSS_GDSC>;
> +				power-domains = <&rpmhpd SC8280XP_MMCX>;
>  
>  				assigned-clocks = <&dispcc0 DISP_CC_MDSS_DPTX3_LINK_CLK_SRC>,
>  						  <&dispcc0 DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC>;

Looks good as a temporary remedy:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
