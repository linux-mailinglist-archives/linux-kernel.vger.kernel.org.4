Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3B5625439
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 08:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbiKKHB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 02:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKHBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:01:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50576586F;
        Thu, 10 Nov 2022 23:01:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8005FB823F7;
        Fri, 11 Nov 2022 07:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE88FC433D6;
        Fri, 11 Nov 2022 07:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668150081;
        bh=F1W/88cKIisGvkI5jZLR7EExVe0GMTcmUxSVV6b6Azo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pnmguo4Za0NkdmYj+MvBrVGYFCN65RoinGoYH12UUjDL7vuZ5AnRny11Z1P+qNBrO
         zvag2Z6KGFL1tHe/qO/behNdsyDOHuTkXhs6nhjcCgGsIzEQJctx0Mu3vw7HQRQvS9
         QUO5I0XWKOP1u1NfeEgT7mqitw7kOnXoB8jRxFikV4tDrTdC1+SEtUksP4K9YF62W3
         Ss7trMIYKoFGr8DUOyN+EqZosZzfrjH1Vv2am4TDy+3EjVrhfzaofv3j5b6tox9ZuY
         FxCXF7fUjWQJqQzZFt1TbjkuFbE+OiMkhxXtHHzvT+zFGs3K92cL/u+IfYRNo/xmgX
         vLHqQzuY3jrRQ==
Date:   Fri, 11 Nov 2022 12:31:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com
Subject: Re: [PATCH v2 02/15] phy: qcom-qmp-ufs: Add support for configuring
 PHY in HS Series B mode
Message-ID: <Y23zO68Bb5R0xLq/@matsya>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031180217.32512-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-10-22, 23:32, Manivannan Sadhasivam wrote:
> Add separate tables_hs_b instance to allow the PHY driver to configure the
> PHY in HS Series B mode. The individual SoC configs need to supply the
> serdes register setting in tables_hs_b and the UFS driver can request the
> Series B mode by calling phy_set_mode() with mode set to PHY_MODE_UFS_HS_B.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index cdfda4e6d575..4c6a2b5afc9a 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -20,6 +20,8 @@
>  #include <linux/reset.h>
>  #include <linux/slab.h>
>  
> +#include <ufs/unipro.h>
> +
>  #include <dt-bindings/phy/phy.h>
>  
>  #include "phy-qcom-qmp.h"
> @@ -549,6 +551,8 @@ struct qmp_phy_cfg {
>  
>  	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
>  	const struct qmp_phy_cfg_tables tables;
> +	/* Additional sequence for HS Series B */
> +	const struct qmp_phy_cfg_tables tables_hs_b;

what am i missing, where was tables_hs_b added?

>  
>  	/* clock ids to be requested */
>  	const char * const *clk_list;
> @@ -582,6 +586,7 @@ struct qmp_phy_cfg {
>   * @rx2: iomapped memory space for second lane's rx (in dual lane PHYs)
>   * @pcs_misc: iomapped memory space for lane's pcs_misc
>   * @qmp: QMP phy to which this lane belongs
> + * @mode: PHY mode configured by the UFS driver
>   */
>  struct qmp_phy {
>  	struct phy *phy;
> @@ -594,6 +599,7 @@ struct qmp_phy {
>  	void __iomem *rx2;
>  	void __iomem *pcs_misc;
>  	struct qcom_qmp *qmp;
> +	u32 mode;
>  };
>  
>  /**
> @@ -983,6 +989,8 @@ static int qmp_ufs_power_on(struct phy *phy)
>  	int ret;
>  
>  	qmp_ufs_serdes_init(qphy, &cfg->tables);
> +	if (qphy->mode == PHY_MODE_UFS_HS_B)
> +		qmp_ufs_serdes_init(qphy, &cfg->tables_hs_b);
>  
>  	qmp_ufs_lanes_init(qphy, &cfg->tables);
>  
> @@ -1070,6 +1078,15 @@ static int qmp_ufs_disable(struct phy *phy)
>  	return qmp_ufs_exit(phy);
>  }
>  
> +static int qmp_ufs_set_mode(struct phy *phy, enum phy_mode mode, int submode)
> +{
> +	struct qmp_phy *qphy = phy_get_drvdata(phy);
> +
> +	qphy->mode = mode;
> +
> +	return 0;
> +}
> +
>  static int qmp_ufs_vreg_init(struct device *dev, const struct qmp_phy_cfg *cfg)
>  {
>  	struct qcom_qmp *qmp = dev_get_drvdata(dev);
> @@ -1105,6 +1122,7 @@ static int qmp_ufs_clk_init(struct device *dev, const struct qmp_phy_cfg *cfg)
>  static const struct phy_ops qcom_qmp_ufs_ops = {
>  	.power_on	= qmp_ufs_enable,
>  	.power_off	= qmp_ufs_disable,
> +	.set_mode	= qmp_ufs_set_mode,
>  	.owner		= THIS_MODULE,
>  };
>  
> -- 
> 2.25.1

-- 
~Vinod
