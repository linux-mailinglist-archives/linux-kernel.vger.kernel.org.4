Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09326F41EE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbjEBKnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBKns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F2193;
        Tue,  2 May 2023 03:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 645066136F;
        Tue,  2 May 2023 10:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D3C433D2;
        Tue,  2 May 2023 10:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683024225;
        bh=5PcTT+Mp2phj0AGBO4adQ2h/a2T5CGjfMzj/n4Uwgzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZ560cJnwCTkC6eAn5fQX/YYVE0IeaXkS+LYCPdcMD+0S1IOu+cBBqwxWcf8PVV3m
         zwtI8FLnTbK4qfP7a7cVIT08y7JvQ5iRnxM4fD9fdwSrIK8vxszHCGjk36GcZvlec5
         8WqXGDrX0hp/qPwkk3DhB323vo4MMcLr3ZrQtdEmrhZiTi88TaHhZV1gFyQ0/ElXCt
         JYdu1LXpgn59JluFra1UBwhLgVZCy5J2vPs5UvVjLhB1u1MEUvG623ey9QanbhE9Ka
         /MZo9hFICk6nJPyOun8GIr2jGM9oYDHDTy405ZVvb7whr4HC7IrpHxETjPq67lrXA1
         L2DHtHv9cx+iw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ptnU4-0003Bn-Jh; Tue, 02 May 2023 12:43:48 +0200
Date:   Tue, 2 May 2023 12:43:48 +0200
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
Subject: Re: [PATCH 2/7] phy: qcom-qmp-combo: Move phy_mutex out of
 com_init/exit
Message-ID: <ZFDpZMBSM4fXWzB2@hovoldconsulting.com>
References: <20230425034010.3789376-1-quic_bjorande@quicinc.com>
 <20230425034010.3789376-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425034010.3789376-3-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 08:40:05PM -0700, Bjorn Andersson wrote:
> With the upcoming introduction of USB Type-C orientation switching the
> region of mutual exclusion needs to be extended to cover both the common
> init/exit as well as the individual functions.
> 
> So move the phy_mutex one step up the stack.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 51 +++++++++++++----------
>  1 file changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 6850e04c329b..7280f7141961 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2463,16 +2463,13 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
>  	void __iomem *com = qmp->com;
>  	int ret;
>  
> -	mutex_lock(&qmp->phy_mutex);
> -	if (qmp->init_count++) {
> -		mutex_unlock(&qmp->phy_mutex);
> +	if (qmp->init_count++)
>  		return 0;
> -	}
>  
>  	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
>  	if (ret) {
>  		dev_err(qmp->dev, "failed to enable regulators, err=%d\n", ret);
> -		goto err_unlock;
> +		goto err;

I was going to say that you can just return ret directly but then
realised we have a counter imbalance here that should be fixed.

I've just sent a couple of fixes which you could rebase on:

	https://lore.kernel.org/r/20230502103810.12061-1-johan+linaro@kernel.org

>  	}
>  
>  	ret = reset_control_bulk_assert(cfg->num_resets, qmp->resets);
> @@ -2514,16 +2511,13 @@ static int qmp_combo_com_init(struct qmp_combo *qmp)
>  	qphy_setbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
>  			SW_PWRDN);
>  
> -	mutex_unlock(&qmp->phy_mutex);
> -
>  	return 0;
>  
>  err_assert_reset:
>  	reset_control_bulk_assert(cfg->num_resets, qmp->resets);
>  err_disable_regulators:
>  	regulator_bulk_disable(cfg->num_vregs, qmp->vregs);
> -err_unlock:
> -	mutex_unlock(&qmp->phy_mutex);
> +err:
>  
>  	return ret;
>  }
 
> @@ -2686,14 +2683,19 @@ static int qmp_combo_usb_init(struct phy *phy)
>  	struct qmp_combo *qmp = phy_get_drvdata(phy);
>  	int ret;
>  
> +	mutex_lock(&qmp->phy_mutex);

Nit: I think adding a newline here would improve readability.

>  	ret = qmp_combo_com_init(qmp);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
>  	ret = qmp_combo_usb_power_on(phy);
> -	if (ret)
> +	if (ret) {
>  		qmp_combo_com_exit(qmp);
> +		goto out_unlock;
> +	}
>  
> +out_unlock:
> +	mutex_unlock(&qmp->phy_mutex);

Same here.

>  	return ret;
>  }
>  
> @@ -2702,11 +2704,18 @@ static int qmp_combo_usb_exit(struct phy *phy)
>  	struct qmp_combo *qmp = phy_get_drvdata(phy);
>  	int ret;
>  
> +	mutex_lock(&qmp->phy_mutex);

And here.

>  	ret = qmp_combo_usb_power_off(phy);
>  	if (ret)
> -		return ret;
> +		goto out_unlock;
>  
> -	return qmp_combo_com_exit(qmp);
> +	ret = qmp_combo_com_exit(qmp);
> +	if (ret)
> +		goto out_unlock;
> +
> +out_unlock:
> +	mutex_unlock(&qmp->phy_mutex);

And here.

> +	return ret;
>  }
>  
>  static int qmp_combo_usb_set_mode(struct phy *phy, enum phy_mode mode, int submode)

Looks good otherwise: 

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Johan
