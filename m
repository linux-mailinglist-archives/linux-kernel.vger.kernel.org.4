Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3833568780D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjBBI7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjBBI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:58:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485A177DC2;
        Thu,  2 Feb 2023 00:58:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2FD4B82546;
        Thu,  2 Feb 2023 08:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739F1C433D2;
        Thu,  2 Feb 2023 08:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675328310;
        bh=+/XxH52Y1e5bZ+gbb5oKCp9u/fuUZvs4jZ8JpJkLlAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q+iUTAbQBJkaJrimrz1JtWq4slHLRD53/SihGgn9PPylKDK3FIPJMH6yDOE7UWDJP
         wKS6xSMiMX7+w+tSwLrjqmd4QcxHnMYo48odqAynzDbczs2BmyJdypH3xTVZThaGuQ
         oTR4yI5vBnZlo6OAzZm3LNm+DpG+TcQj/r185I9Is04gWTY2zGmwddLDTd5TrMoiwg
         K8KZ6Yl7+HgvsiCezJ6z0OoPomDTEVXA2o/1yrSuG76Y2I7lLpgWvb8ZBQtWczk+z7
         6e5Xlyssg/T6W7efgr+TuMIv459yxb3jmS/NHVntXhSPmMy2ouJfXYI0DZHIke+yiV
         d45iHNIg+Bd4w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pNVQj-0002M3-9D; Thu, 02 Feb 2023 09:58:54 +0100
Date:   Thu, 2 Feb 2023 09:58:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] soc: qcom: llcc: Fix slice configuration values for
 SC8280XP
Message-ID: <Y9t7Tcw3vg1FU9RZ@hovoldconsulting.com>
References: <20230127144724.1292580-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127144724.1292580-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 04:47:24PM +0200, Abel Vesa wrote:
> These new values are now based on the latest LLCC SC table.

Please expand expand the commit message with details on why this is
needed (e.g. for benefit of people less familiar with this driver that
need to determine whether this should be backported, etc).

You are also only fixing the three slice ids so please mention that
specifically.

> Fixes: ec69dfbdc426 ("soc: qcom: llcc: Add sc8180x and sc8280xp configurations")

After having looked at the code, it seems you're missing a CC stable
tag here.

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v1 is here:
> https://lore.kernel.org/all/20230126171636.2319496-1-abel.vesa@linaro.org/
> 
> Changes since v1:
>  * dropped the LLCC_GPU and LLCC_WRCACHE max_cap changes
>  * took the new values from documentatio this time rather than
>    downstream kernel
> 
>  drivers/soc/qcom/llcc-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 23ce2f78c4ed..26efe12012a0 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -191,9 +191,9 @@ static const struct llcc_slice_config sc8280xp_data[] = {
>  	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
>  	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> -	{ LLCC_CVPFW,    32, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUSS1,   33, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUHWT,   36, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUSS1,   3, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUHWT,   5, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
>  };
>  
>  static const struct llcc_slice_config sdm845_data[] =  {

Johan
