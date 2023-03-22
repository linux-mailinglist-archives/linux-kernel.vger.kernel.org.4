Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6496C40D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCVDQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCVDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:16:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249412884E;
        Tue, 21 Mar 2023 20:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA3861F24;
        Wed, 22 Mar 2023 03:16:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB1AC433D2;
        Wed, 22 Mar 2023 03:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679454976;
        bh=bnAyPFcvfn3yjJZ4/00BRfbbJTpOw/6izVsNwBXCpbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K29+pa7naURrYEosVvSHCQ3LqsBJA1T3maQuMRW4ZSb3xEtDOMByKpd3z+WKfv8OR
         VPlZbyMEd9M7y1uI+zZGOJSzs6CTHlui4QYp/etKwuDOLDP6gEvlSafZey4CEJMrj/
         2+T3X9IsyeGtZcdpDlOa8WOQBeIa98sFFKD+wjmjtDJmXEQtGcrFgJTYwPuF+0zAKd
         JU/T3/cn+3I1Em1qxZL5K9Dn8tZFFS3oh2/ugtOQjoyoTVKdly2PIuF5NFm5pxQYur
         IOhwiEvHScUjHCVKBDoKWJj5E2W4p7zrjV+i2WeZ3X+Dm40mt4i7UprbN1gRfD2gO4
         UI1J2OP4eeTgA==
Date:   Tue, 21 Mar 2023 20:19:28 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RFT v2 11/14] clk: qcom: smd-rpm: Hook up PCNoC_0
 keep_alive
Message-ID: <20230322031928.vugzh4de2yecd5j2@ripper>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-11-ae80a325fe94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-11-ae80a325fe94@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 10:35:27PM +0100, Konrad Dybcio wrote:
> 14 [1] of our 18 supported platforms need an active keepalive vote on
> PCNoC_0 so as not to cause havoc on the entire SoC. Guarantee that.
> 

Given that these are all clocks for peripheral (or peripheral & config)
noc clocks, doesn't this just ensure that the running CPU is able to
reach something on the peripheral bus?

That is, are you encoding a active-only keep-alive interconnect path?
Could we somehow express that using the interconnect driver on top
instead?

Regards,
Bjorn

> [1] there are 13 changes to driver data, but 8226 reuses 8974.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 8e25b3d7d30c..a44b52bd0c83 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -500,6 +500,7 @@ DEFINE_CLK_SMD_RPM(aggre1_noc, QCOM_SMD_RPM_AGGR_CLK, 1);
>  DEFINE_CLK_SMD_RPM(aggre2_noc, QCOM_SMD_RPM_AGGR_CLK, 2);
>  
>  DEFINE_CLK_SMD_RPM_BUS(pcnoc, 0);
> +DEFINE_CLK_SMD_RPM_BUS_KEEP_ALIVE(pcnoc, 0);
>  DEFINE_CLK_SMD_RPM_BUS(snoc, 1);
>  DEFINE_CLK_SMD_RPM_BUS(sysmmnoc, 2);
>  DEFINE_CLK_SMD_RPM_BUS(cnoc, 2);
> @@ -558,7 +559,7 @@ DEFINE_CLK_SMD_RPM_XO_BUFFER(div_clk3, 13, 19200000);
>  
>  static struct clk_smd_rpm *msm8909_clks[] = {
>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
> @@ -592,7 +593,7 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8909 = {
>  
>  static struct clk_smd_rpm *msm8916_clks[] = {
>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
> @@ -626,7 +627,7 @@ static struct clk_smd_rpm *msm8936_clks[] = {
>  	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
>  	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
> @@ -660,7 +661,7 @@ static const struct rpm_smd_clk_desc rpm_clk_msm8936 = {
>  
>  static struct clk_smd_rpm *msm8974_clks[] = {
>  	[RPM_SMD_PNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_CNOC_CLK]		= &clk_smd_rpm_bus_2_cnoc_clk,
> @@ -712,7 +713,7 @@ static struct clk_smd_rpm *msm8976_clks[] = {
>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
> @@ -746,7 +747,7 @@ static struct clk_smd_rpm *msm8992_clks[] = {
>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_OCMEMGX_CLK] = &clk_smd_rpm_ocmemgx_clk,
>  	[RPM_SMD_OCMEMGX_A_CLK] = &clk_smd_rpm_ocmemgx_a_clk,
>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
> @@ -804,7 +805,7 @@ static struct clk_smd_rpm *msm8994_clks[] = {
>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_OCMEMGX_CLK] = &clk_smd_rpm_ocmemgx_clk,
>  	[RPM_SMD_OCMEMGX_A_CLK] = &clk_smd_rpm_ocmemgx_a_clk,
>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
> @@ -864,7 +865,7 @@ static struct clk_smd_rpm *msm8996_clks[] = {
>  	[RPM_SMD_XO_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo,
>  	[RPM_SMD_XO_A_CLK_SRC] = &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
> @@ -918,7 +919,7 @@ static struct clk_smd_rpm *qcs404_clks[] = {
>  	[RPM_SMD_QDSS_CLK] = &clk_smd_rpm_qdss_clk,
>  	[RPM_SMD_QDSS_A_CLK] = &clk_smd_rpm_qdss_a_clk,
>  	[RPM_SMD_PNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
> @@ -948,7 +949,7 @@ static struct clk_smd_rpm *msm8998_clks[] = {
>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>  	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
>  	[RPM_SMD_PCNOC_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK] = &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK] = &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
> @@ -1010,7 +1011,7 @@ static struct clk_smd_rpm *sdm660_clks[] = {
>  	[RPM_SMD_CNOC_CLK] = &clk_smd_rpm_bus_2_cnoc_clk,
>  	[RPM_SMD_CNOC_A_CLK] = &clk_smd_rpm_bus_2_cnoc_a_clk,
>  	[RPM_SMD_CNOC_PERIPH_CLK] = &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_CNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_CNOC_PERIPH_A_CLK] = &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_BIMC_CLK] = &clk_smd_rpm_bimc_clk,
>  	[RPM_SMD_BIMC_A_CLK] = &clk_smd_rpm_bimc_a_clk,
>  	[RPM_SMD_MMSSNOC_AXI_CLK] = &clk_smd_rpm_mmssnoc_axi_rpm_clk,
> @@ -1052,7 +1053,7 @@ static struct clk_smd_rpm *mdm9607_clks[] = {
>  	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
>  	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
>  	[RPM_SMD_BIMC_A_CLK]		= &clk_smd_rpm_bimc_a_clk,
>  	[RPM_SMD_QPIC_CLK]		= &clk_smd_rpm_qpic_clk,
> @@ -1074,7 +1075,7 @@ static struct clk_smd_rpm *msm8953_clks[] = {
>  	[RPM_SMD_XO_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo,
>  	[RPM_SMD_XO_A_CLK_SRC]		= &clk_smd_rpm_branch_bi_tcxo_a,
>  	[RPM_SMD_PCNOC_CLK]		= &clk_smd_rpm_bus_0_pcnoc_clk,
> -	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_clk,
> +	[RPM_SMD_PCNOC_A_CLK]		= &clk_smd_rpm_bus_0_pcnoc_a_keep_alive_clk,
>  	[RPM_SMD_SNOC_CLK]		= &clk_smd_rpm_bus_1_snoc_clk,
>  	[RPM_SMD_SNOC_A_CLK]		= &clk_smd_rpm_bus_1_snoc_a_clk,
>  	[RPM_SMD_BIMC_CLK]		= &clk_smd_rpm_bimc_clk,
> 
> -- 
> 2.39.2
> 
