Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A56C62A00A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKORNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiKORNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:13:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23316EE08;
        Tue, 15 Nov 2022 09:13:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25D7EB81A2F;
        Tue, 15 Nov 2022 17:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDA0C433D6;
        Tue, 15 Nov 2022 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668532425;
        bh=E2Ix0booTdpUdUIVDbuoAPq8iFBqUQnyUJ0GGMyLTVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eB2SkQegJqT9LR5HkZTMj5ejtasKn/azCQj5kmf9jqf1Ev+F33SZVEot+fWkQVd8r
         bq9Lim3hEmna0Djtks3LcjqrQU3ZDpgZi3axc7UNkMOF0k3xZD7yedNJV6LgrTulpS
         0XNxc3fxCEtmWnbOjTQMDFcydJSo/wFTbK9OFCwwtBdD3zvZyLB0ksZapq4cdFOIW9
         eiQuSLDWKls+qdC8xfQNgOaSSS9+5+9yEztCSOUMmW9+qoZ6ct7CUTwO0O84F152CH
         QE1ZFkb6I9rmk1ceGjtsY+F4f5EYD4T+5SHaPScvXjsQn84yhiGW6sz+dkif2iyyCh
         Sp8owc0MKTEhA==
Date:   Tue, 15 Nov 2022 11:13:42 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>, sboyd@kernel.org
Cc:     johan@kernel.org, bmasney@redhat.com, agross@kernel.org,
        mturquette@baylibre.com, ahalaney@redhat.com,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] clk: qcom: gcc-sc8280xp: add cxo as parent for three
 ufs ref clks
Message-ID: <20221115171342.v37vq4cqe7pxatlk@builder.lan>
References: <20221115152956.21677-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115152956.21677-1-quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 08:59:56PM +0530, Shazad Hussain wrote:
> The three UFS reference clocks, gcc_ufs_ref_clkref_clk for external
> UFS devices, gcc_ufs_card_clkref_clk and gcc_ufs_1_card_clkref_clk for
> two PHYs are all sourced from CXO.
> 
> Added parent_data for all three reference clocks described above to
> reflect that all three clocks are sourced from CXO to have valid
> frequency for the ref clock needed by UFS controller driver.
> 
> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.com/
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
> Reviewed-by: Reviewed-by: Brian Masney <bmasney@redhat.com>

Really-really-reviewed-by? ;)


Reviewed-by: Bjorn Andersson <andersson@kernel.org>


@Stephen, could you please pick this for clk-fixes?

Thanks,
Bjorn

> ---
> Changes since v2:
> -  Tweaked commit message and added R-b T-b from v2
> 
> v2 of this patch can be found at
> https://lore.kernel.org/all/20221115102217.6381-1-quic_shazhuss@quicinc.com/
> 
> v1 of this patch can be found at
> https://lore.kernel.org/all/20221030142333.31019-1-quic_shazhuss@quicinc.com/
> 
> used below patches for verification on next-20221114
> https://lore.kernel.org/lkml/20221104092045.17410-2-johan+linaro@kernel.org/
> https://lore.kernel.org/lkml/20221104092045.17410-3-johan+linaro@kernel.org/
> https://lore.kernel.org/lkml/20221111113732.461881-1-thierry.reding@gmail.com/
> 
>  drivers/clk/qcom/gcc-sc8280xp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index a18ed88f3b82..b3198784e1c3 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -5364,6 +5364,8 @@ static struct clk_branch gcc_ufs_1_card_clkref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_1_card_clkref_clk",
> +			.parent_data = &gcc_parent_data_tcxo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -5432,6 +5434,8 @@ static struct clk_branch gcc_ufs_card_clkref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_card_clkref_clk",
> +			.parent_data = &gcc_parent_data_tcxo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> @@ -5848,6 +5852,8 @@ static struct clk_branch gcc_ufs_ref_clkref_clk = {
>  		.enable_mask = BIT(0),
>  		.hw.init = &(const struct clk_init_data) {
>  			.name = "gcc_ufs_ref_clkref_clk",
> +			.parent_data = &gcc_parent_data_tcxo,
> +			.num_parents = 1,
>  			.ops = &clk_branch2_ops,
>  		},
>  	},
> -- 
> 2.38.0
> 
