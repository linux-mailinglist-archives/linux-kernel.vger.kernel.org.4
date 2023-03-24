Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B4A6C810B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 16:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjCXPUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 11:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjCXPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 11:19:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06B87EE6;
        Fri, 24 Mar 2023 08:19:56 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OD7ZMZ030610;
        Fri, 24 Mar 2023 08:19:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=Q2kGjIMhBFd/DPycP247SzcKqxUhvUtSrbx/CaMj/qU=;
 b=dGQPnZIJ7x5macjoUqa2Y+nHkE++W25zIzQmidaBZOFdyCB7l6QHLN7UqMaKO84stnJ4
 Gkgl9WALvc/F8LnpO6I1H8HglFE5Vl8bHxIpkyFnGG0XZd2P0m3EG39FxDtkbnPOhx2L
 NSBcKNOSM2eOJBjEx/U40v67YqvAbZAIhIfjtb8bPxwMO7/IyZcD7XTlNp5dyIXAReZ0
 iD3HtM1q8fOlo8vJSDl52tJ9jZv8rNlHtzGw0FJUK19nbGy66hINPnQCLofkWGAMRxYG
 NHL/q2CVA0a6g6Na0GqsIGikzywnlJs+G77Bxc69vKcF+1ga0ZsiL5f5OQoaYWVDohG5 FA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3pgxmfjx9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 08:19:49 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Mar
 2023 08:19:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Fri, 24 Mar 2023 08:19:46 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 8B08E3F7067;
        Fri, 24 Mar 2023 08:19:46 -0700 (PDT)
Date:   Fri, 24 Mar 2023 08:19:46 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <yamada.masahiro@socionext.com>, <devicetree@vger.kernel.org>,
        <jannadurai@marvell.com>, <cchavva@marvell.com>,
        Dhananjay Kangude <dkangude@cadence.com>
Subject: Re: [PATCH v3 2/6] mmc: sdhci-cadence: Restructure the code
Message-ID: <20230324151946.GC462@Dell2s-9>
References: <20230227183151.27912-1-pmalgujar@marvell.com>
 <20230227183151.27912-3-pmalgujar@marvell.com>
 <e77b9471-806c-7603-7351-76422c42df88@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e77b9471-806c-7603-7351-76422c42df88@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: zJtG4ghDSG5oghhmFoP-6Sol5h5vpW4w
X-Proofpoint-ORIG-GUID: zJtG4ghDSG5oghhmFoP-6Sol5h5vpW4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_09,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

Thanks for the review comments.

On Fri, Mar 03, 2023 at 10:36:30AM +0200, Adrian Hunter wrote:
> On 27/02/23 20:31, Piyush Malgujar wrote:
> > From: Dhananjay Kangude <dkangude@cadence.com>
> > 
> > Restructured the code, added new structures and functions for
> > SD4 operations. Also this adds some abstraction to the code
> > which will make it modular and adaptable for further SD6 operations.
> > 
> > Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> > Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
> > Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> > Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> > ---
> >  drivers/mmc/host/sdhci-cadence.c | 100 ++++++++++++++++++++++++-------
> >  1 file changed, 80 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> > index 5276cdbc652f7faac13bb0244af4926b63dc119a..4f7e63c90e3d68da338b8964f08b7c65ebaf1ffd 100644
> > --- a/drivers/mmc/host/sdhci-cadence.c
> > +++ b/drivers/mmc/host/sdhci-cadence.c
> > @@ -59,16 +59,28 @@
> >   */
> >  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
> >  
> > +struct sdhci_cdns_priv;
> > +
> >  struct sdhci_cdns_sd4_phy_param {
> >  	u8 addr;
> >  	u8 data;
> >  };
> >  
> > +struct sdhci_cdns_data {
> > +	int (*phy_init)(struct sdhci_cdns_priv *priv);
> > +	int (*set_tune_val)(struct sdhci_host *host, unsigned int val);
> > +};
> > +
> > +struct sdhci_cdns_sd4_phy {
> > +	unsigned int nr_phy_params;
> > +	struct sdhci_cdns_sd4_phy_param phy_params[];
> > +};
> > +
> >  struct sdhci_cdns_priv {
> >  	void __iomem *hrs_addr;
> >  	bool enhanced_strobe;
> > -	unsigned int nr_phy_params;
> > -	struct sdhci_cdns_sd4_phy_param phy_params[];
> > +	const struct sdhci_cdns_data *cdns_data;
> 
> Simpler if there is just a pointer to struct sdhci_cdns_of_data
> and get rid of struct sdhci_cdns_data.
> 

Sure, will take care of this.

> > +	void *phy;
> >  };
> >  
> >  struct sdhci_cdns_sd4_phy_cfg {
> > @@ -76,6 +88,13 @@ struct sdhci_cdns_sd4_phy_cfg {
> >  	u8 addr;
> >  };
> >  
> > +struct sdhci_cdns_of_data {
> > +	const struct sdhci_pltfm_data *pltfm_data;
> 
> Kernel style is not to unnecessarily have structures that point to
> other structures or contain other structures.
> 
> Here, please just put the struct not a pointer i.e.
> 
> 	struct sdhci_pltfm_data *pltfm_data;
> 

Ok, so, to use 

	struct sdhci_pltfm_data pltfm_data;

> > +	const struct sdhci_cdns_data *cdns_data;
> 
> Please get rid of struct sdhci_cdns_data. Instead just put its members here
> 

Ok, will modify in next version.

> > +	int (*phy_probe)(struct platform_device *pdev,
> > +			 struct sdhci_cdns_priv *priv);
> > +};
> > +
> >  static const struct sdhci_cdns_sd4_phy_cfg sdhci_cdns_sd4_phy_cfgs[] = {
> >  	{ "cdns,phy-input-delay-sd-highspeed", SDHCI_CDNS_PHY_DLY_SD_HS, },
> >  	{ "cdns,phy-input-delay-legacy", SDHCI_CDNS_PHY_DLY_SD_DEFAULT, },
> > @@ -135,9 +154,9 @@ static unsigned int sdhci_cdns_sd4_phy_param_count(struct device_node *np)
> >  }
> >  
> >  static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
> > -					   struct sdhci_cdns_priv *priv)
> > +					   struct sdhci_cdns_sd4_phy *phy)
> >  {
> > -	struct sdhci_cdns_sd4_phy_param *p = priv->phy_params;
> > +	struct sdhci_cdns_sd4_phy_param *p = phy->phy_params;
> >  	u32 val;
> >  	int ret, i;
> >  
> > @@ -156,10 +175,11 @@ static void sdhci_cdns_sd4_phy_param_parse(struct device_node *np,
> >  static int sdhci_cdns_sd4_phy_init(struct sdhci_cdns_priv *priv)
> >  {
> >  	int ret, i;
> > +	struct sdhci_cdns_sd4_phy *phy = priv->phy;
> >  
> > -	for (i = 0; i < priv->nr_phy_params; i++) {
> > -		ret = sdhci_cdns_sd4_write_phy_reg(priv, priv->phy_params[i].addr,
> > -						   priv->phy_params[i].data);
> > +	for (i = 0; i < phy->nr_phy_params; i++) {
> > +		ret = sdhci_cdns_sd4_write_phy_reg(priv, phy->phy_params[i].addr,
> > +						   phy->phy_params[i].data);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -202,6 +222,27 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
> >  	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
> >  }
> >  
> > +static int sdhci_cdns_sd4_phy_probe(struct platform_device *pdev,
> > +				    struct sdhci_cdns_priv *priv)
> > +{
> > +	unsigned int nr_phy_params;
> > +	struct sdhci_cdns_sd4_phy *phy;
> > +	struct device *dev = &pdev->dev;
> > +
> > +	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
> > +	phy = devm_kzalloc(dev, struct_size(phy, phy_params, nr_phy_params),
> > +			   GFP_KERNEL);
> > +	if (!phy)
> > +		return -ENOMEM;
> > +
> > +	phy->nr_phy_params = nr_phy_params;
> > +
> > +	sdhci_cdns_sd4_phy_param_parse(dev->of_node, phy);
> > +	priv->phy = phy;
> > +
> > +	return 0;
> > +}
> > +
> >  static int sdhci_cdns_sd4_set_tune_val(struct sdhci_host *host, unsigned int val)
> >  {
> >  	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
> > @@ -323,10 +364,25 @@ static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
> >  	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> >  };
> >  
> > +static const struct sdhci_cdns_of_data sdhci_cdns_uniphier_of_data = {
> > +	.pltfm_data = &sdhci_cdns_uniphier_pltfm_data,
> > +};
> > +
> >  static const struct sdhci_pltfm_data sdhci_cdns_sd4_pltfm_data = {
> >  	.ops = &sdhci_cdns_sd4_ops,
> >  };
> >  
> > +static const struct sdhci_cdns_data sdhci_cdns_sd4_data = {
> > +	.phy_init = sdhci_cdns_sd4_phy_init,
> > +	.set_tune_val = sdhci_cdns_sd4_set_tune_val,
> > +};
> > +
> > +static const struct sdhci_cdns_of_data sdhci_cdns_sd4_of_data = {
> > +	.pltfm_data = &sdhci_cdns_sd4_pltfm_data,
> > +	.cdns_data = &sdhci_cdns_sd4_data,
> > +	.phy_probe = sdhci_cdns_sd4_phy_probe,
> > +};
> > +
> >  static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> >  					     struct mmc_ios *ios)
> >  {
> > @@ -350,11 +406,10 @@ static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
> >  static int sdhci_cdns_probe(struct platform_device *pdev)
> >  {
> >  	struct sdhci_host *host;
> > -	const struct sdhci_pltfm_data *data;
> > +	const struct sdhci_cdns_of_data *data;
> >  	struct sdhci_pltfm_host *pltfm_host;
> >  	struct sdhci_cdns_priv *priv;
> >  	struct clk *clk;
> > -	unsigned int nr_phy_params;
> >  	int ret;
> >  	struct device *dev = &pdev->dev;
> >  	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
> > @@ -368,12 +423,12 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
> >  		return ret;
> >  
> >  	data = of_device_get_match_data(dev);
> > -	if (!data)
> > -		data = &sdhci_cdns_sd4_pltfm_data;
> > +	if (!data) {
> > +		ret = -EINVAL;
> > +		goto disable_clk;
> > +	}
> >  
> > -	nr_phy_params = sdhci_cdns_sd4_phy_param_count(dev->of_node);
> > -	host = sdhci_pltfm_init(pdev, data,
> > -				struct_size(priv, phy_params, nr_phy_params));
> > +	host = sdhci_pltfm_init(pdev, data->pltfm_data, sizeof(*priv));
> >  	if (IS_ERR(host)) {
> >  		ret = PTR_ERR(host);
> >  		goto disable_clk;
> > @@ -383,9 +438,9 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
> >  	pltfm_host->clk = clk;
> >  
> >  	priv = sdhci_pltfm_priv(pltfm_host);
> > -	priv->nr_phy_params = nr_phy_params;
> >  	priv->hrs_addr = host->ioaddr;
> >  	priv->enhanced_strobe = false;
> > +	priv->cdns_data = data->cdns_data;
> >  	host->ioaddr += SDHCI_CDNS_SRS_BASE;
> >  	host->mmc_host_ops.hs400_enhanced_strobe =
> >  				sdhci_cdns_hs400_enhanced_strobe;
> > @@ -398,9 +453,11 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		goto free;
> >  
> > -	sdhci_cdns_sd4_phy_param_parse(dev->of_node, priv);
> > +	ret = data->phy_probe(pdev, priv);
> > +	if (ret)
> > +		goto free;
> >  
> > -	ret = sdhci_cdns_sd4_phy_init(priv);
> > +	ret = priv->cdns_data->phy_init(priv);
> 
> As was pointed out last time, you are dereferncing cdns_data unconditionally
> when it could be NULL e.g. in the case of sdhci_cdns_uniphier_of_data
> 
> >  	if (ret)
> >  		goto free;
> >  
> > @@ -429,7 +486,7 @@ static int sdhci_cdns_resume(struct device *dev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = sdhci_cdns_sd4_phy_init(priv);
> > +	ret = priv->cdns_data->phy_init(priv);
> >  	if (ret)
> >  		goto disable_clk;
> >  
> > @@ -453,9 +510,12 @@ static const struct dev_pm_ops sdhci_cdns_pm_ops = {
> >  static const struct of_device_id sdhci_cdns_match[] = {
> >  	{
> >  		.compatible = "socionext,uniphier-sd4hc",
> > -		.data = &sdhci_cdns_uniphier_pltfm_data,
> > +		.data = &sdhci_cdns_uniphier_of_data,
> > +	},
> > +	{
> > +		.compatible = "cdns,sd4hc",
> > +		.data = &sdhci_cdns_sd4_of_data,
> >  	},
> > -	{ .compatible = "cdns,sd4hc" },
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, sdhci_cdns_match);
> 

Rest of the comments will take care in next version.

Thanks,
Piyush
