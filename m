Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9B658616
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiL1SxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiL1SxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:53:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6DB164A4;
        Wed, 28 Dec 2022 10:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E94CE615C1;
        Wed, 28 Dec 2022 18:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E59C43443;
        Wed, 28 Dec 2022 18:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672253577;
        bh=GggqvW56hqP5giaXMF1PFdcPUhB/iNitytWm50VhHhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UMVmFTzF5iHby6jilsOdb26LClsue1AbtokgRV7uo7josPXc9Ll3tMa3/ZmtSXLyJ
         s5rPlu1V2K1TYyw8+QHgZIwLpzFso4Ke03xNdsVvLmPu97GujYVO8LdyKPg85RQbUK
         2AaVDdgb2Zw1Y8JHZuNUgUTO5z33y2HFBq4QeXU+kFRKnzOmkeemGq/6NqGi7POi2T
         EgIgMC1f8zeVeEUrT0OABD8/Jctelaxut3MgGyARxrcs6LjqT6o5XKeB3KCZw6u5xk
         eVzg8o7Z/x3TAw81s4eln5G7k9RNwOR4AQgZsXu/HAq+WkpEui/y6hY1HUmWEF7vHv
         zhlqAZQlLn64g==
Date:   Wed, 28 Dec 2022 12:52:54 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 4/5] clk: qcom: rpmh: Add support for SM8550 rpmh
 clocks
Message-ID: <20221228185254.4acnjchbyq4krblb@builder.lan>
References: <20221206224515.1495457-1-abel.vesa@linaro.org>
 <20221206224515.1495457-5-abel.vesa@linaro.org>
 <6fc64fae-e616-2038-0424-34ce0cb7e16d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fc64fae-e616-2038-0424-34ce0cb7e16d@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 06:25:01PM +0200, Dmitry Baryshkov wrote:
> On 07/12/2022 00:45, Abel Vesa wrote:
> > Adds the RPMH clocks present in SM8550 SoC.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> >   drivers/clk/qcom/clk-rpmh.c | 110 +++++++++++++++++++++++++++++-------
> >   1 file changed, 90 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> > index 2c2ef4b6d130..ce81c76ed0fd 100644
> > --- a/drivers/clk/qcom/clk-rpmh.c
> > +++ b/drivers/clk/qcom/clk-rpmh.c
> > @@ -130,6 +130,34 @@ static DEFINE_MUTEX(rpmh_clk_lock);
> >   		},							\
> >   	}
> > +#define DEFINE_CLK_FIXED_FACTOR(_name, _parent_name, _div)		\
> > +	static struct clk_fixed_factor clk_fixed_factor##_##_name = {	\
> > +		.mult = 1,						\
> > +		.div = _div,						\
> > +		.hw.init = &(struct clk_init_data){			\
> > +			.ops = &clk_fixed_factor_ops,			\
> > +			.name = #_name,					\
> > +			.parent_data =  &(const struct clk_parent_data){ \
> > +				.fw_name = #_parent_name,		\
> > +				.name = #_parent_name,			\
> > +			},						\
> > +			.num_parents = 1,				\
> > +		},							\
> > +	};								\
> > +	static struct clk_fixed_factor clk_fixed_factor##_##_name##_ao = { \
> > +		.mult = 1,						\
> > +		.div = _div,						\
> > +		.hw.init = &(struct clk_init_data){			\
> > +			.ops = &clk_fixed_factor_ops,			\
> > +			.name = #_name "_ao",				\
> > +			.parent_data =  &(const struct clk_parent_data){ \
> > +				.fw_name = #_parent_name "_ao",		\
> > +				.name = #_parent_name "_ao",		\
> > +			},						\
> > +			.num_parents = 1,				\
> > +		},							\
> > +	}
> > +
> >   static inline struct clk_rpmh *to_clk_rpmh(struct clk_hw *_hw)
> >   {
> >   	return container_of(_hw, struct clk_rpmh, hw);
> > @@ -345,6 +373,8 @@ DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 2);
> >   DEFINE_CLK_RPMH_ARC(bi_tcxo, "xo.lvl", 0x3, 4);
> >   DEFINE_CLK_RPMH_ARC(qlink, "qphy.lvl", 0x1, 4);
> > +DEFINE_CLK_FIXED_FACTOR(bi_tcxo_div2, bi_tcxo, 2);
> > +
> >   DEFINE_CLK_RPMH_VRM(ln_bb_clk1, _a2, "lnbclka1", 2);
> >   DEFINE_CLK_RPMH_VRM(ln_bb_clk2, _a2, "lnbclka2", 2);
> >   DEFINE_CLK_RPMH_VRM(ln_bb_clk3, _a2, "lnbclka3", 2);
> > @@ -366,6 +396,16 @@ DEFINE_CLK_RPMH_VRM(rf_clk2, _d, "rfclkd2", 1);
> >   DEFINE_CLK_RPMH_VRM(rf_clk3, _d, "rfclkd3", 1);
> >   DEFINE_CLK_RPMH_VRM(rf_clk4, _d, "rfclkd4", 1);
> > +DEFINE_CLK_RPMH_VRM(clk1, _a1, "clka1", 1);
> > +DEFINE_CLK_RPMH_VRM(clk2, _a1, "clka2", 1);
> > +DEFINE_CLK_RPMH_VRM(clk3, _a1, "clka3", 1);
> > +DEFINE_CLK_RPMH_VRM(clk4, _a1, "clka4", 1);
> > +DEFINE_CLK_RPMH_VRM(clk5, _a1, "clka5", 1);
> > +
> > +DEFINE_CLK_RPMH_VRM(clk6, _a2, "clka6", 2);
> > +DEFINE_CLK_RPMH_VRM(clk7, _a2, "clka7", 2);
> > +DEFINE_CLK_RPMH_VRM(clk8, _a2, "clka8", 2);
> > +
> >   DEFINE_CLK_RPMH_VRM(div_clk1, _div2, "divclka1", 2);
> >   DEFINE_CLK_RPMH_BCM(ce, "CE0");
> > @@ -576,6 +616,33 @@ static const struct clk_rpmh_desc clk_rpmh_sm8450 = {
> >   	.num_clks = ARRAY_SIZE(sm8450_rpmh_clocks),
> >   };
> > +static struct clk_hw *sm8550_rpmh_clocks[] = {
> > +	[RPMH_CXO_PAD_CLK]      = &clk_rpmh_bi_tcxo_div2.hw,
> > +	[RPMH_CXO_PAD_CLK_A]    = &clk_rpmh_bi_tcxo_div2_ao.hw,
> > +	[RPMH_CXO_CLK]		= &clk_fixed_factor_bi_tcxo_div2.hw,
> > +	[RPMH_CXO_CLK_A]	= &clk_fixed_factor_bi_tcxo_div2_ao.hw,
> > +	[RPMH_LN_BB_CLK1]	= &clk_rpmh_clk6_a2.hw,
> > +	[RPMH_LN_BB_CLK1_A]	= &clk_rpmh_clk6_a2_ao.hw,
> > +	[RPMH_LN_BB_CLK2]	= &clk_rpmh_clk7_a2.hw,
> > +	[RPMH_LN_BB_CLK2_A]	= &clk_rpmh_clk7_a2_ao.hw,
> > +	[RPMH_LN_BB_CLK3]	= &clk_rpmh_clk8_a2.hw,
> > +	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_clk8_a2_ao.hw,
> > +	[RPMH_RF_CLK1]		= &clk_rpmh_clk1_a1.hw,
> > +	[RPMH_RF_CLK1_A]	= &clk_rpmh_clk1_a1_ao.hw,
> > +	[RPMH_RF_CLK2]		= &clk_rpmh_clk2_a1.hw,
> > +	[RPMH_RF_CLK2_A]	= &clk_rpmh_clk2_a1_ao.hw,
> > +	[RPMH_RF_CLK3]		= &clk_rpmh_clk3_a1.hw,
> > +	[RPMH_RF_CLK3_A]	= &clk_rpmh_clk3_a1_ao.hw,
> > +	[RPMH_RF_CLK4]		= &clk_rpmh_clk4_a1.hw,
> > +	[RPMH_RF_CLK4_A]	= &clk_rpmh_clk4_a1_ao.hw,
> > +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
> > +};
> > +
> > +static const struct clk_rpmh_desc clk_rpmh_sm8550 = {
> > +	.clks = sm8550_rpmh_clocks,
> > +	.num_clks = ARRAY_SIZE(sm8550_rpmh_clocks),
> > +};
> > +
> >   static struct clk_hw *sc7280_rpmh_clocks[] = {
> >   	[RPMH_CXO_CLK]      = &clk_rpmh_bi_tcxo_div4.hw,
> >   	[RPMH_CXO_CLK_A]    = &clk_rpmh_bi_tcxo_div4_ao.hw,
> > @@ -683,29 +750,31 @@ static int clk_rpmh_probe(struct platform_device *pdev)
> >   		name = hw_clks[i]->init->name;
> > -		rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > -		res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > -		if (!res_addr) {
> > -			dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > -				rpmh_clk->res_name);
> > -			return -ENODEV;
> > -		}
> > +		if (hw_clks[i]->init->ops != &clk_fixed_factor_ops) {
> 
> We discussed this separately, the fixed factor clocks will be moved to the
> child nodes, leaving rpmhcc with only cmd-db based clocks.
> 

Are you saying that you will represent bi_tcxo as a fixed-factor-clock
under /clocks with RPMH_CXO_PAD_CLK as parent and a clock-div = <2>; ?

If so that sounds reasonable to me, but adding Mike for his
input/information.

Regards,
Bjorn

> > +			rpmh_clk = to_clk_rpmh(hw_clks[i]);
> > +			res_addr = cmd_db_read_addr(rpmh_clk->res_name);
> > +			if (!res_addr) {
> > +				dev_err(&pdev->dev, "missing RPMh resource address for %s\n",
> > +					rpmh_clk->res_name);
> > +				return -ENODEV;
> > +			}
> > -		data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > -		if (IS_ERR(data)) {
> > -			ret = PTR_ERR(data);
> > -			dev_err(&pdev->dev,
> > -				"error reading RPMh aux data for %s (%d)\n",
> > -				rpmh_clk->res_name, ret);
> > -			return ret;
> > -		}
> > +			data = cmd_db_read_aux_data(rpmh_clk->res_name, &aux_data_len);
> > +			if (IS_ERR(data)) {
> > +				ret = PTR_ERR(data);
> > +				dev_err(&pdev->dev,
> > +					"error reading RPMh aux data for %s (%d)\n",
> > +					rpmh_clk->res_name, ret);
> > +				return ret;
> > +			}
> > -		/* Convert unit from Khz to Hz */
> > -		if (aux_data_len == sizeof(*data))
> > -			rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> > +			/* Convert unit from Khz to Hz */
> > +			if (aux_data_len == sizeof(*data))
> > +				rpmh_clk->unit = le32_to_cpu(data->unit) * 1000ULL;
> > -		rpmh_clk->res_addr += res_addr;
> > -		rpmh_clk->dev = &pdev->dev;
> > +			rpmh_clk->res_addr += res_addr;
> > +			rpmh_clk->dev = &pdev->dev;
> > +		}
> >   		ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
> >   		if (ret) {
> > @@ -741,6 +810,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
> >   	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
> >   	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
> >   	{ .compatible = "qcom,sm8450-rpmh-clk", .data = &clk_rpmh_sm8450},
> > +	{ .compatible = "qcom,sm8550-rpmh-clk", .data = &clk_rpmh_sm8550},
> >   	{ .compatible = "qcom,sc7280-rpmh-clk", .data = &clk_rpmh_sc7280},
> >   	{ }
> >   };
> 
> -- 
> With best wishes
> Dmitry
> 
