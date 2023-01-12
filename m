Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5C667991
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbjALPje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240585AbjALPiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:38:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93648CD8;
        Thu, 12 Jan 2023 07:29:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C733EB81E80;
        Thu, 12 Jan 2023 15:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ABFC4331E;
        Thu, 12 Jan 2023 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673537392;
        bh=Cq23KtcmQz9xHoe58xQGkU8aQBrNL1EzV+wnxOxWaWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uMg74hnEejDy5JFcZyqwD6aDOWWmya1Ryl/solxI+yRQEwQe7Tex1LFAgtiybFHHa
         Q4cIqEX66Myx8uBLZkd6p4rYQpOcbyz0eiP1p6bbj+7Zd8+yNXvCxvcHiOFGXh9u4k
         8rmsYhyLIz+8z2MpAUAVRAmSPEOpqYqnM51O1Cj3Evk3MjoEO2UMivWr+m9JmaCxEn
         wZI1tiOjfUOks8mravauRYEntZuV2bvqh9AN66F/LAcilPWhpCS0uPUaGq3Q6dKWa/
         9uguyNqEAADCuHKONTFzo1JnoXzr62AAo/kp0O94n7iT8sDP94gXuOzn24OY1tUEig
         KnQukf0ae8BKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFzWh-0000Yv-PM; Thu, 12 Jan 2023 16:29:59 +0100
Date:   Thu, 12 Jan 2023 16:29:59 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] phy: qcom-qmp-ufs: Add SM8550 support
Message-ID: <Y8And9VVvpnSInlj@hovoldconsulting.com>
References: <20230112130542.1399921-1-abel.vesa@linaro.org>
 <20230112130542.1399921-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112130542.1399921-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:05:42PM +0200, Abel Vesa wrote:
> Add SM8550 specific register layout and table configs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 100 ++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 5936a3a05002..a9b666f32f59 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -95,6 +95,13 @@ static const unsigned int sm8150_ufsphy_regs_layout[QPHY_LAYOUT_SIZE] = {
>  	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
>  };
>  
 
> +static const char * const sm8550_ufs_phy_clk_l[] = {
> +	"qref", "ref",
> +};

These clocks would to be added to the binding too, but based on:

	https://lore.kernel.org/r/20230112135926.1572191-1-abel.vesa@linaro.org

you really don't need these at all and what you call 'qref'
(GCC_UFS_PHY_PHY_AUX_CLK) is just 'ref_aux' below.

> +
>  static const char * const sdm845_ufs_phy_clk_l[] = {
>  	"ref", "ref_aux",
>  };

> @@ -721,6 +787,15 @@ static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 = {
>  	.rx2		= 0xa00,
>  };
>  
> +static const struct qmp_ufs_offsets qmp_ufs_offsets_v6 = {
> +	.serdes		= 0,
> +	.pcs		= 0x400,

Zero pad .pcs to 4 digits?

> +	.tx		= 0x1000,
> +	.rx		= 0x1200,
> +	.tx2		= 0x1800,
> +	.rx2		= 0x1a00,
> +};

Johan
