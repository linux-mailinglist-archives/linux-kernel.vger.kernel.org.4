Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15960689A0B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCNtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjBCNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:49:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433DD49022;
        Fri,  3 Feb 2023 05:49:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0D6C61F24;
        Fri,  3 Feb 2023 13:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C3EC433EF;
        Fri,  3 Feb 2023 13:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675432166;
        bh=iaPYASL71iby6A+UP40u7xoSoq/l1VQRbHBGy6Rg+a0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qbc5NeqTVtIQhkiiLvbx1fOi7YVKIu43zsRy7/uyTZVpzGHUos7ybdN3bB9ujZ1yl
         og+WAd2ugPMLTjusGMuD0lrRwgs6hw1uzzhyZe9QU+1fdsVW3Qmp6XRMefKti5092l
         WY/2LAsHhwLsWGpxTKzoLFK6qFx27i3QJT673n2fEZK1xZqx+BlMILDZ7lJ0jM7WiE
         vZkrrpZgijEAE7773G6FvIBsNOt9fbl/iAjllHP5cgftk4+KNLaYL9acxiJPS3K3CU
         6pDAjISwW5abmiKTu+SsfuLoyZOwZzBxgUaf3ArltpMK/ZohcJR4orMQj1bq5RS4ZX
         3ft+NoZFhEU5g==
Date:   Fri, 3 Feb 2023 19:19:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v3 5/7] phy: qcom: phy-qcom-snps-eusb2: Add support for
 eUSB2 repeater
Message-ID: <Y90Q4rDYw9kcXmCQ@matsya>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
 <20230202133816.4026990-6-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202133816.4026990-6-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-02-23, 15:38, Abel Vesa wrote:
> From: Neil Armstrong <neil.armstrong@linaro.org>
> 
> For USB 2.0 compliance, eUSB2 needs a repeater. The PHY needs to
> initialize and reset it. So add repeater support
> 
> Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> index 23ec162cc3bd..8d972d49732b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
> @@ -128,6 +128,8 @@ struct qcom_snps_eusb2_hsphy {
>  	struct regulator_bulk_data vregs[EUSB2_NUM_VREGS];
>  
>  	enum phy_mode mode;
> +
> +	struct phy *repeater;
>  };
>  
>  static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int submode)
> @@ -136,7 +138,7 @@ static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int
>  
>  	phy->mode = mode;
>  
> -	return 0;
> +	return phy_set_mode_ext(phy->repeater, mode, submode);
>  }
>  
>  static void qcom_snps_eusb2_hsphy_write_mask(void __iomem *base, u32 offset,
> @@ -235,6 +237,12 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
>  	if (ret)
>  		return ret;
>  
> +	ret = phy_init(phy->repeater);
> +	if (ret) {
> +		dev_err(&p->dev, "repeater init failed. %d\n", ret);
> +		goto disable_vreg;
> +	}
> +
>  	ret = clk_prepare_enable(phy->ref_clk);
>  	if (ret) {
>  		dev_err(&p->dev, "failed to enable ref clock, %d\n", ret);
> @@ -342,6 +350,8 @@ static int qcom_snps_eusb2_hsphy_exit(struct phy *p)
>  
>  	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
>  
> +	phy_exit(phy->repeater);
> +
>  	return 0;
>  }
>  
> @@ -386,6 +396,12 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "failed to get regulator supplies\n");
> +
> +	phy->repeater = devm_phy_get(dev, "eusb2-repeater");
> +	if (IS_ERR(phy->repeater))
> +		return dev_err_probe(dev, PTR_ERR(phy->repeater),
> +				     "failed to get repeater\n");

That implies repeater is assumed to be there for all designs, how about
older devices, they may not have a repeater?

> +
>  	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_eusb2_hsphy_ops);
>  	if (IS_ERR(generic_phy)) {
>  		dev_err(dev, "failed to create phy %d\n", ret);
> -- 
> 2.34.1

-- 
~Vinod
