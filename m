Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DDF643887
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 23:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiLEW5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 17:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiLEW4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 17:56:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E61DA69;
        Mon,  5 Dec 2022 14:56:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10AD0614B0;
        Mon,  5 Dec 2022 22:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA92C433D6;
        Mon,  5 Dec 2022 22:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670281009;
        bh=1mZCIf5ENhXlr1qJHpaedp8oREKPjSeeu6Yd6niAndA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lII5HtZ55slsDCIsNmXLNzVkN/1dpN2DzeCKXL67zi2XWQxcpSRewsA9zW+3LnSwm
         swou+WG7nse8aTAxJGmjNeFtnSbZFp+WahFo+hxfk+3Rq2mpzu2z1W3xHOhuSqnnB9
         vikpPLelyonDPSHzNIBRK6nk8FkBn0mOKcL6V7bgDwDx9fGvkzKike/PV7FoGoM1JX
         mGfg/ntDuOwRTpkbQP1XWUp33wGQlCgxUdY76ku3+jvS7ohQPm1W9tk27Byjncl7JB
         ByixR3fN2oxRmyZ9oV+i/NTUtO34ic4KEk7RyFE7OaAdP/nsrZo7J0+XnYo4EdaXCN
         Hx0yce4Go5M+g==
Date:   Mon, 5 Dec 2022 16:56:46 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Alex Elder <elder@linaro.org>
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        konrad.dybcio@linaro.org, agross@kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: rpmh: add support for SM6350 rpmh IPA clock
Message-ID: <20221205225646.gtwhakd4lxh6vlfc@builder.lan>
References: <20221202221240.225720-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202221240.225720-1-elder@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:12:40PM -0600, Alex Elder wrote:
> From: Luca Weiss <luca.weiss@fairphone.com>
> 
> The IPA core clock is required for SM6350.  Define it.
> 
> [elder@linaro.org: rebased with Dmitry's changes]
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Thanks for rebasing this Alex. But as you're handling the patch you need
to add your S-o-b; which will make sure your [] makes sense as well.

Regards,
Bjorn

> ---
> v2: This is now based on qualcomm/for-next.
> 
>  drivers/clk/qcom/clk-rpmh.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 2c2ef4b6d130e..586a810c682ca 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -606,6 +606,7 @@ static struct clk_hw *sm6350_rpmh_clocks[] = {
>  	[RPMH_LN_BB_CLK3_A]	= &clk_rpmh_ln_bb_clk3_g4_ao.hw,
>  	[RPMH_QLINK_CLK]	= &clk_rpmh_qlink_div4.hw,
>  	[RPMH_QLINK_CLK_A]	= &clk_rpmh_qlink_div4_ao.hw,
> +	[RPMH_IPA_CLK]		= &clk_rpmh_ipa.hw,
>  };
>  
>  static const struct clk_rpmh_desc clk_rpmh_sm6350 = {
> -- 
> 2.34.1
> 
