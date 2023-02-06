Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4CCF68C7BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjBFUh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBFUhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:37:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301A43590;
        Mon,  6 Feb 2023 12:37:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 640F1B815D2;
        Mon,  6 Feb 2023 20:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A09CC433D2;
        Mon,  6 Feb 2023 20:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675715868;
        bh=anOfBg4e46TnwdEtBw74YoyQGsjAU1epW9mE5iZ0FL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSqrZP11lgVjfKD4b5SZLJ6f2dMwmCZXBCngtP5JYwybmb55YaAW8qLBP5yBQGryu
         byvEh5Letc5Y3p2Coug9ZrRTX8EJQO90f9baTsjqkcsibzKzu9MkreTpUCrxmI4ene
         IxmPggvthTfFdRo62EB8kbE+DNfDykGT+qSBGQyNTCSVP+5yffnV5c5SVtJMnFfIKP
         QY9ae1FwMYre1v1jUl7z3PzxAfQSDDfH513SDY5o6ExKDTEB0hI5hVUNR1pheKFixF
         E5QhPkGcxInxrNUJFlk98FbjR16HEbB7ma+c7z674TziCmu5KyWsCWskVjZvuGuvfU
         OE5gc58XEaPpQ==
Date:   Mon, 6 Feb 2023 12:40:02 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/4] cpufreq: qcom-nvmem: use SoC ID-s from bindings
Message-ID: <20230206204002.jafbtxei5upxtb2t@ripper>
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-3-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121112947.53433-3-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:29:46PM +0100, Robert Marko wrote:
> SMEM SoC ID-s are now stored in DT bindings so lets use those instead of
> defining them in the driver again.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index c0a7841a56c1..da55d2e1925a 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -30,12 +30,7 @@
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/socinfo.h>
>  
> -enum _msm_id {
> -	MSM8996V3 = 0xF6ul,
> -	APQ8096V3 = 0x123ul,
> -	MSM8996SG = 0x131ul,
> -	APQ8096SG = 0x138ul,
> -};
> +#include <dt-bindings/arm/qcom,ids.h>
>  
>  enum _msm8996_version {
>  	MSM8996_V3,
> @@ -150,12 +145,12 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  		return NUM_OF_MSM8996_VERSIONS;
>  
>  	switch (info->id) {
> -	case MSM8996V3:
> -	case APQ8096V3:
> +	case QCOM_ID_MSM8996:
> +	case QCOM_ID_APQ8096:
>  		version = MSM8996_V3;
>  		break;
> -	case MSM8996SG:
> -	case APQ8096SG:
> +	case QCOM_ID_MSM8996SG:
> +	case QCOM_ID_APQ8096SG:
>  		version = MSM8996_SG;
>  		break;
>  	default:
> -- 
> 2.39.1
> 
