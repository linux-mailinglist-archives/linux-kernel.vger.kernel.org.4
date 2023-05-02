Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04026F432B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjEBL4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjEBL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:56:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF73149E7;
        Tue,  2 May 2023 04:56:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C04C6237E;
        Tue,  2 May 2023 11:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE964C433EF;
        Tue,  2 May 2023 11:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683028600;
        bh=HpKSpELOWNdWBj9XGoPNd6tC2Zd/X7t8z+ryj93CYcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g6CW36skukYug+T1O3vdX8pTS/YAuHjFDSYN6tA5wGPF1BRcNqwquUpT8Al8hUzFz
         cF3XE+ZMuAVyIj2kBs2GwJI9rx0/4t6H0Ge+xkEdTjNhcbZxZFqB39QlpLEuLhsoM9
         qcdL6TDK14fZlFG2kv0QDdmSbG54tuwk33ktpGq/TKJazKXJGYada1/LggvqsgvAZ/
         y7hGaAHIA45GiTXe2ta8CuAmgA1jtiLq4AeQIHQqa/9CST5OJzmRWTgb8pci8IOw/Y
         0wHUcoHHl3617BbS8Fwxv9Y15Y67eK6DLZ7++olc1DJ1HuNRQ/sVBHhqcduxi29ANS
         VbNrdUqaD1fEA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ptocd-0003Za-03; Tue, 02 May 2023 13:56:43 +0200
Date:   Tue, 2 May 2023 13:56:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] phy: qcom-qmp-combo: Introduce orientation switching
Message-ID: <ZFD6evxxzjqqaCZk@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-5-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-5-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:40:07PM -0700, Bjorn Andersson wrote:
> The data lanes of the QMP PHY is swapped in order to handle changing
> orientation of the USB Type-C cable. Register a typec_switch device to
> allow a TCPM to configure the orientation.
> 
> The newly introduced orientation variable is adjusted based on the
> request, and the initialized components are brought down and up again.
> To keep track of what parts needs to be cycled new variables to keep
> track of the individual init_count is introduced.
> 
> Both the USB and the DisplayPort altmode signals are properly switched.
> For DisplayPort the controller will after the TCPM having established
> orientation power on the PHY, so this is not done implicitly, but for
> USB the PHY typically is kept initialized across the switch, and must
> therefor then be reinitialized.
> 
> This is based on initial work by Wesley Cheng.
> 
> Link: https://lore.kernel.org/r/20201009082843.28503-3-wcheng@codeaurora.org/
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 92 ++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 6748f31da7a3..5d6d6ef3944b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c

> @@ -2567,8 +2573,9 @@ static int qmp_combo_dp_exit(struct phy *phy)
>  
>  	mutex_lock(&qmp->phy_mutex);
>  
> -	qmp_combo_com_exit(qmp);
> +	qmp_combo_com_exit(qmp, false);
>  
> +	qmp->dp_init_count--;

Nit: add a newline for symmetry.

>  	mutex_unlock(&qmp->phy_mutex);
>  
>  	return 0;

> @@ -3351,6 +3362,65 @@ static struct phy *qmp_combo_phy_xlate(struct device *dev, struct of_phandle_arg
>  	return ERR_PTR(-EINVAL);
>  }
>  
> +#if IS_ENABLED(CONFIG_TYPEC)
> +static int qmp_combo_typec_switch_set(struct typec_switch_dev *sw,
> +				      enum typec_orientation orientation)
> +{
> +	struct qmp_combo *qmp = typec_switch_get_drvdata(sw);
> +	const struct qmp_phy_cfg *cfg = qmp->cfg;
> +
> +	if (orientation == qmp->orientation || orientation == TYPEC_ORIENTATION_NONE)
> +		return 0;
> +
> +	mutex_lock(&qmp->phy_mutex);
> +	qmp->orientation = orientation;
> +
> +	if (qmp->init_count) {
> +		if (qmp->usb_init_count)
> +			qmp_combo_usb_power_off(qmp->usb_phy);
> +		qmp_combo_com_exit(qmp, true);
> +
> +		qmp_combo_com_init(qmp, true);
> +		if (qmp->usb_init_count)
> +			qmp_combo_usb_power_on(qmp->usb_phy);
> +		if (qmp->dp_init_count)
> +			cfg->dp_aux_init(qmp);
> +	}
> +	mutex_unlock(&qmp->phy_mutex);
> +
> +	return 0;
> +}
> +
> +static void qmp_combo_typec_unregister(void *data)
> +{
> +	struct qmp_combo *qmp = data;
> +
> +	typec_switch_unregister(qmp->sw);
> +}
> +
> +static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
> +{
> +	struct typec_switch_desc sw_desc = {};
> +	struct device *dev = qmp->dev;
> +
> +	sw_desc.drvdata = qmp;
> +	sw_desc.fwnode = dev->fwnode;
> +	sw_desc.set = qmp_combo_typec_switch_set;

Nit: I'd add a newline here for readability.

> +	qmp->sw = typec_switch_register(dev, &sw_desc);
> +	if (IS_ERR(qmp->sw)) {
> +		dev_err(dev, "Unable to register typec switch: %pe\n", qmp->sw);
> +		return PTR_ERR(qmp->sw);
> +	}
> +
> +	return devm_add_action_or_reset(dev, qmp_combo_typec_unregister, qmp);
> +}
> +#else
> +static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
> +{
> +	return 0;
> +}
> +#endif

Perhaps you can move the type-c block after qmp_combo_register_clocks()
above to keep the type-c and later added bridge functions together and
better reflect the probe init order (e.g. keeping the dt-functions just
above probe()).

> +
>  static int qmp_combo_probe(struct platform_device *pdev)
>  {
>  	struct qmp_combo *qmp;
> @@ -3385,6 +3455,10 @@ static int qmp_combo_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = qmp_combo_typec_switch_register(qmp);
> +	if (ret)
> +		return ret;
> +
>  	/* Check for legacy binding with child nodes. */
>  	usb_np = of_get_child_by_name(dev->of_node, "usb3-phy");
>  	if (usb_np) {

Looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
