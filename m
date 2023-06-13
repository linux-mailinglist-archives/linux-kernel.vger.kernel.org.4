Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0DD72E9FD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjFMRgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMRgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294FAA;
        Tue, 13 Jun 2023 10:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F52B6391D;
        Tue, 13 Jun 2023 17:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108C9C433D9;
        Tue, 13 Jun 2023 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686677775;
        bh=yT/YcUbrOqFENj+tlyHyK738bYhHXlmlxIpioLPwxNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rsKT4uS9AZe+fe56mjdyH4mmF18zXzKHAWTiypuw4L4FlmNcloe/tEO3mgmU8ul+Z
         ycS6v4BBbOoY9vJCs5Nivz20DPB0rQAxO0C4FWbZVgoOrjqpFWj1wNkFQzqVRnaZ3v
         7NcAPUEpf2Vz2o0h979YmL+0fa9+vT8ay5Eym2y0R5BZage9kJJZ5TcnrE3HloHtyB
         oHCv8KWsPajFqsfxtjoq6REYwNFQ+HmsGVXJPcoEi5c8Jkm66SACpJjHy43B847gSB
         KvOU0+/V3L6G02M+zRgLeipDlnY185JSyTaLeo+a/mwBh1NI6AD8DKA8M39RJoXiKO
         5gAtpZkwrATrQ==
Date:   Tue, 13 Jun 2023 10:39:37 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 03/26] phy: qcom: add the SGMII SerDes PHY driver
Message-ID: <20230613173937.fhk2cqcankg6oej6@ripper>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-4-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-4-brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:32AM +0200, Bartosz Golaszewski wrote:
> diff --git a/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c b/drivers/phy/qualcomm/phy-qcom-sgmii-eth.c
[..]
> +static int qcom_dwmac_sgmii_phy_probe(struct platform_device *pdev)
> +{
> +	struct qcom_dwmac_sgmii_phy_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct phy_provider *provider;
> +	struct clk *refclk;
> +	void __iomem *base;
> +	struct phy *phy;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	data->regmap = devm_regmap_init_mmio(dev, base,
> +					     &qcom_dwmac_sgmii_phy_regmap_cfg);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	phy = devm_phy_create(dev, NULL, &qcom_dwmac_sgmii_phy_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	refclk = devm_clk_get_enabled(dev, "sgmi_ref");
> +	if (IS_ERR(refclk))
> +		return PTR_ERR(refclk);
> +
> +	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +	if (IS_ERR(provider))
> +		return PTR_ERR(provider);
> +
> +	phy_set_drvdata(phy, data);
> +	platform_set_drvdata(pdev, data);

You don't use the pdev's dev's drvdata, so I think you can drop the
platform_set_drvdata()

Regards,
Bjorn

> +
> +	return 0;
> +}
