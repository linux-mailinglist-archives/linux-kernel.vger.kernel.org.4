Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521E56679BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbjALPom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbjALPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:43:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA559F90;
        Thu, 12 Jan 2023 07:34:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF122B81E75;
        Thu, 12 Jan 2023 15:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553CCC433EF;
        Thu, 12 Jan 2023 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673537675;
        bh=BUcuaVN1bRlSTtFmUhQKry4ihlvLc4KU6TjaGg0vh9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g3X7LQM0zhyM1qXTqa1ysCRHR9QnWLWwOx8/A85fjhNY/Og2T0v08W79b8fhcuXdQ
         jVp0kCF73J69Nrugy6ZzzrR0Rt1jag5TvqZAi81EJOa8kcAZw+yfqSNxXHoSR/xqVB
         3yPlNVv5o9wTiwFWuqnBk9UNUUvfGK0v2nUOqgwZg2xBR8l/FrvHCDB7PFPS78sS3N
         7Z/AZYwTYX8lhL/612qvEnM7wcfEL+TUMzHwNvEjykKaJAOStvkK2J2IsCqfvYlSut
         7afgC59VulzVbERrLxWlge5sNRq1D1d6keFLhkprHoaFMYvVdyEZcq2VYFJr9bo2eJ
         D0f15+jEu/eoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFzbG-0000fQ-RA; Thu, 12 Jan 2023 16:34:42 +0100
Date:   Thu, 12 Jan 2023 16:34:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8550: Add UFS host controller
 and phy nodes
Message-ID: <Y8AokqLmbH/eC+Ye@hovoldconsulting.com>
References: <20230112135926.1572191-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112135926.1572191-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:59:25PM +0200, Abel Vesa wrote:
> Add UFS host controller and PHY nodes.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v1:
>  * dropped ufs_mem_phy_lanes child node, like Johan suggested
>  * addressed Konrad comments.
 
> @@ -1571,6 +1571,78 @@ crypto: crypto@1de0000 {
>  			interconnect-names = "memory";
>  		};
>  
> +		ufs_mem_phy: phy@1d80000 {
> +			compatible = "qcom,sm8550-qmp-ufs-phy";
> +			reg = <0x0 0x01d80000 0x0 0x2000>;
> +			clock-names = "ref", "qref";
> +			clocks = <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
> +				 <&tcsr TCSR_UFS_CLKREF_EN>;

So as I just mentioned elsewhere, this should probably be 'ref' and
'ref_aux' (in reverse order).

> +
> +			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
> +
> +			resets = <&ufs_mem_hc 0>;
> +			reset-names = "ufsphy";
> +
> +			#address-cells = <2>;
> +			#size-cells = <2>;

These two should not be here.

> +
> +			#phy-cells = <0>;
> +

You can drop the newline here.

> +			#clock-cells = <1>;

Could be moved above '#phy-cells' to have the provider cells nodes
sorted alphabetically.

> +
> +			ranges;

Drop this one too.

> +
> +			status = "disabled";
> +		};

Johan
