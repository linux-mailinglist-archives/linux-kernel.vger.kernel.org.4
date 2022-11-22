Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC40E633D53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiKVNPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbiKVNPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:15:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FF63154;
        Tue, 22 Nov 2022 05:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76BE2616F9;
        Tue, 22 Nov 2022 13:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830FFC433D6;
        Tue, 22 Nov 2022 13:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669122944;
        bh=WM+iRdqzMuNOpZH02f5VGpRug8d7nHfgsrCMsJ+cyFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIaMG9Lt6nlTmX0jyKVZ2U/SHOqYXjWoz0/K3oxDGjGtw2TeWRhx+SNOhc46LZgQ9
         d8ToJoMwc0BedGXgKBnM7ZL5TDhHjdy5+uoWo4+odB1dyosZuRlPPtcXvAohub2FGo
         oFv5ulf1wF0BIE0oSLklruwZgcrl6wlIReQkHLq8fWOy9vFkGLMv4B6YCgMjLpC5uc
         6ooWzgLtitdqu1qPlyEAI8o4a8W4AXe4V84YCaU3KfkpoEiNhO44ST2CqizYHcmhzl
         wnZoCiufjAjuPEUKHL4QDXpMFMLEGUVw1KkVQJZgdC0gTzzN3mgb7sf5+/BOGMtazA
         2uONIoryR+xrw==
Date:   Tue, 22 Nov 2022 18:45:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cpufreq: qcom-hw: Fix memory leak in
 qcom_cpufreq_hw_driver_probe()
Message-ID: <20221122131536.GA157542@thinkpad>
References: <20221122124627.174403-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122124627.174403-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:46:27PM +0800, Xiu Jianfeng wrote:
> If devm_clk_hw_register() fails, clk_init.name should be freed before
> return error, otherwise will cause memory leak issue, fix it.
> 
> Fixes: 84063a1cbe9e ("cpufreq: qcom-hw: Add CPU clock provider support")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 1bd1e9ae5308..340fed35e45d 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -723,6 +723,7 @@ static int qcom_cpufreq_hw_driver_probe(struct platform_device *pdev)
>  		ret = devm_clk_hw_register(dev, &data->cpu_clk);
>  		if (ret < 0) {
>  			dev_err(dev, "Failed to register clock %d: %d\n", i, ret);
> +			kfree(clk_init.name);
>  			return ret;
>  		}
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
