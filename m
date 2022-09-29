Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB6C5F017A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 01:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiI2Xic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 19:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiI2Xi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 19:38:28 -0400
Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [IPv6:2001:4b7a:2000:18::164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF88614F8E7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 16:38:26 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id BC2EF1F5E1;
        Fri, 30 Sep 2022 01:38:23 +0200 (CEST)
Message-ID: <48af9193-452f-ffb8-39c7-0d17068af658@somainline.org>
Date:   Fri, 30 Sep 2022 01:38:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] clk: gcc-sc8280xp: use retention for USB power domains
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220929161124.18138-1-johan+linaro@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220929161124.18138-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.09.2022 18:11, Johan Hovold wrote:
> Since commit d399723950c4 ("clk: qcom: gdsc: Fix the handling of
> PWRSTS_RET support) retention mode can be used on sc8280xp to maintain
> state during suspend instead of leaving the domain always on.
> 
> This is needed to eventually allow the parent CX domain to be powered
> down during suspend.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  drivers/clk/qcom/gcc-sc8280xp.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> While we're not yet able to fully test this (since we're not hitting CX
> power down) this can still go in as we'll need it in some form
> eventually.
> 
> Note that the PCIe domains should remain always-on until we have driver
> support for suspend in place.
> 
> Johan
> 
> 
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc8280xp.c
> index 7768e6901dcc..a18ed88f3b82 100644
> --- a/drivers/clk/qcom/gcc-sc8280xp.c
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -6843,17 +6843,12 @@ static struct gdsc ufs_phy_gdsc = {
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> -/*
> - * The Qualcomm DWC3 driver suspend implementation appears to be incomplete
> - * for sc8280xp so keep the USB power domains always-on for now.
> - */
>  static struct gdsc usb30_mp_gdsc = {
>  	.gdscr = 0xab004,
>  	.pd = {
>  		.name = "usb30_mp_gdsc",
>  	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = ALWAYS_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>  };
>  
>  static struct gdsc usb30_prim_gdsc = {
> @@ -6861,8 +6856,7 @@ static struct gdsc usb30_prim_gdsc = {
>  	.pd = {
>  		.name = "usb30_prim_gdsc",
>  	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = ALWAYS_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>  };
>  
>  static struct gdsc usb30_sec_gdsc = {
> @@ -6870,8 +6864,7 @@ static struct gdsc usb30_sec_gdsc = {
>  	.pd = {
>  		.name = "usb30_sec_gdsc",
>  	},
> -	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = ALWAYS_ON,
> +	.pwrsts = PWRSTS_RET_ON,
>  };
>  
>  static struct clk_regmap *gcc_sc8280xp_clocks[] = {
