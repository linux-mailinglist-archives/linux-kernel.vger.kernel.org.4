Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F2672F61
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjASDF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjASDFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:05:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0EB3803A;
        Wed, 18 Jan 2023 19:05:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECC4ACE2019;
        Thu, 19 Jan 2023 03:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BB4C433EF;
        Thu, 19 Jan 2023 03:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674097516;
        bh=/7NZO+eNjezMVSczrtOiyCfSUTdU+G5FtJU4hgZgVdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oQGHV6HMkNhqAFK0CGFPZMow8KBbtsCHl2IdPf0uvAjfbCZ5mYfe2WHN/DlMwmD74
         pJ8odHKi0PdSkK4a/tQ6R1YdJrgPy6xb9oCArrq6BRjhzTycBF/RsqV8wQAZ2nSAWH
         A7drFeVhqqn9D40M1X2/nt5ZmcxVCrPJYVOQ2jdt+bnUsZu1KUWHGkXhMkKMKLei/8
         6XwtOz4WWMH+3hneT/rX+OUSPPjvCvT05htc80Q8rXFtVMJQz2yBV0Dr8p3Fgj/pmf
         LqF8YJQNlEX8513QNHIql+tLLDRADBjemRwefvyb0NwCu3skObhjA6HB/3A/cKMm4B
         hHHeBYBMXJ3wg==
Date:   Wed, 18 Jan 2023 21:05:13 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] thermal/drivers/qcom/lmh: Use driver data as flags
 instead of bool
Message-ID: <20230119030513.eyj3o2b7yugisvqy@builder.lan>
References: <20230113031401.2336157-1-konrad.dybcio@linaro.org>
 <20230113031401.2336157-2-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031401.2336157-2-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:14:00AM +0100, Konrad Dybcio wrote:
> Currently the OF driver data is used to determine whether to manually
> enable the LMH algorithms through secure calls. In preparation for
> introducing support for SoCs with a configuration that differs from
> both SDM845 and SM8150, convert this to a set of bitflags for more
> flexibility.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/thermal/qcom/lmh.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> index 4122a51e9874..5e8ff196c9a6 100644
> --- a/drivers/thermal/qcom/lmh.c
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -28,7 +28,7 @@
>  
>  #define LMH_REG_DCVS_INTR_CLR		0x8
>  
> -#define LMH_ENABLE_ALGOS		1
> +#define LMH_ENABLE_ALGOS		BIT(0)

Looks perfectly fine, but please include a patch in the same series that
adds another bit. And don't forget to update the .data in the
of_match_id listing.

Regards,
Bjorn

>  
>  struct lmh_hw_data {
>  	void __iomem *base;
> @@ -92,9 +92,11 @@ static int lmh_probe(struct platform_device *pdev)
>  	struct device_node *cpu_node;
>  	struct lmh_hw_data *lmh_data;
>  	int temp_low, temp_high, temp_arm, cpu_id, ret;
> -	unsigned int enable_alg;
> +	unsigned int flags;
>  	u32 node_id;
>  
> +	flags = (uintptr_t)of_device_get_match_data(dev);
> +
>  	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
>  	if (!lmh_data)
>  		return -ENOMEM;
> @@ -144,9 +146,7 @@ static int lmh_probe(struct platform_device *pdev)
>  	if (!qcom_scm_lmh_dcvsh_available())
>  		return -EINVAL;
>  
> -	enable_alg = (uintptr_t)of_device_get_match_data(dev);
> -
> -	if (enable_alg) {
> +	if (flags & LMH_ENABLE_ALGOS) {
>  		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>  					 LMH_NODE_DCVS, node_id, 0);
>  		if (ret)
> -- 
> 2.39.0
> 
