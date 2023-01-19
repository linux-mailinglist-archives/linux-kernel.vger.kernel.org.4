Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6E672F31
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjASCoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjASCoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:44:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7312B47E;
        Wed, 18 Jan 2023 18:44:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82D0661820;
        Thu, 19 Jan 2023 02:44:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01323C433D2;
        Thu, 19 Jan 2023 02:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674096244;
        bh=/ooiXw4/TeXyRVI9MhpEYH6uu8sflJ5g7j//DaFMV28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iw3sXneEUvlyCCABFs7eOdEIwFK6jl4R7YpvO6MxeamqQ7p7NihfdWy+LO6sJdoct
         6pRsEUgk3XGl5oHF1q2wO9rB1Kv67oEZsyu6qeNNY+aczmiQCpthvQ+uEoxmUxM/yl
         /Es1xCdt6FCv25ECTQ7mbHQ6mFaNegTocFNka0ilGtp014ae+5rMVuy4iJeGOYmij+
         ZpvihOTMVEd/ASjdQIbShbL2duBYyOS14wGnqFsy2fW/Md8z8q2qOjn/rXz1T86BHP
         B7nyxKfVPRpnCiSTrMjOVzth7M3bFg7IrM1YYa9teXbO4wentbOS8Xub16NDOiFHkz
         KWmbXuObI10rg==
Date:   Wed, 18 Jan 2023 20:44:02 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] clk: qcom: Add QDU1000 and QRU1000 GCC support
Message-ID: <20230119024402.yfiekwp6grl3kn6q@builder.lan>
References: <20230112204446.30236-1-quic_molvera@quicinc.com>
 <20230112204446.30236-3-quic_molvera@quicinc.com>
 <8ecb84b5-93a5-691d-4a7d-5daed0e432e4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ecb84b5-93a5-691d-4a7d-5daed0e432e4@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 11:15:57PM +0200, Dmitry Baryshkov wrote:
> On 12/01/2023 22:44, Melody Olvera wrote:
> > From: Taniya Das <quic_tdas@quicinc.com>
> > 
> > Add Global Clock Controller (GCC) support for QDU1000 and QRU1000 SoCs.
> > 
> > Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> > Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/clk/qcom/Kconfig       |    8 +
> >   drivers/clk/qcom/Makefile      |    1 +
> >   drivers/clk/qcom/gcc-qdu1000.c | 2653 ++++++++++++++++++++++++++++++++
> >   3 files changed, 2662 insertions(+)
> >   create mode 100644 drivers/clk/qcom/gcc-qdu1000.c
> > 
> 
> [skipped the rest]
> 
> > +};
> > +
> > +static struct clk_regmap_mux gcc_pcie_0_pipe_clk_src = {
> > +	.reg = 0x9d064,
> > +	.shift = 0,
> > +	.width = 2,
> > +	.parent_map = gcc_parent_map_7,
> > +	.clkr = {
> > +		.hw.init = &(const struct clk_init_data) {
> > +			.name = "gcc_pcie_0_pipe_clk_src",
> > +			.parent_data = gcc_parent_data_7,
> > +			.num_parents = ARRAY_SIZE(gcc_parent_data_7),
> > +			.ops = &clk_regmap_mux_closest_ops,
> 
> I think this should use clk_regmap_phy_mux_ops.
> 

I believe so too. So I updated this as I applied the patch.

@Melody, please send a fix if bringing up PCIe shows this to be wrong.

Thanks,
Bjorn

> > +		},
> > +	},
> > +};
> > +--
> With best wishes
> Dmitry
> 
