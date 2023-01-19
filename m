Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C27672F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 04:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjASDEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 22:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjASDEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:04:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B480728C;
        Wed, 18 Jan 2023 19:04:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F06619D7;
        Thu, 19 Jan 2023 03:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11F4C433EF;
        Thu, 19 Jan 2023 03:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674097465;
        bh=mwkB2aneBPFZNRJUDE7/r1kut2mOkMQuBEVcO7S7Xkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deMBBjDGyDzSNneUG4Dx3nR9cecJtbcOxy/l4OhPaG/3qXYS2ZTYhhQHJqWVj4xr5
         aV7qLDR6IzQutPbLZNyZKb8ypfn5ThUmcjOg0dZOAsnqWx9Sbp+OLkjwW3FhrqrG1U
         YbiPHYJ68FrO6bIDeE3NG7az+IKwB+J5XmvJYEPOxAzS79xAixjAuORMz2AtAKfpH5
         bZZGcWortO2aG4zvSFmAtbj8z8JifuaVlAp5iRntTZzcCaF5JHajSVXh+m+s8NLJwG
         vJHYfQG3zt1qSsteS5LQt6Hfp0K29VVUOVQa6bmnsxW4gwelFroQpZiNEE8BMjttGk
         ipmvINeDKewSA==
Date:   Wed, 18 Jan 2023 21:04:22 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: qcom_scm: Fully implement
 qcom_scm_lmh_dcvsh()
Message-ID: <20230119030422.askkliovlyonurvz@builder.lan>
References: <20230113031401.2336157-1-konrad.dybcio@linaro.org>
 <20230113031401.2336157-3-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113031401.2336157-3-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 04:14:01AM +0100, Konrad Dybcio wrote:
> The qcom_scm_lmh_dcvsh call can actually pass two values to the
> secure world. The second value is used for example with the
> LMH_FREQ_CAP function, which limits the maximum achievable frequency
> directly from LMh. Add the missing arguments, handle them and update
> the current usages of this function.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/firmware/qcom_scm.c | 13 ++++++++-----
>  drivers/thermal/qcom/lmh.c  | 28 ++++++++++++++--------------
>  include/linux/qcom_scm.h    |  5 +++--
>  3 files changed, 25 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index cdbfe54c8146..58a19a47e442 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1252,12 +1252,13 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
>  }
>  EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
>  
> -int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
> -		       u64 limit_node, u32 node_id, u64 version)
> +int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val0,
> +		       u32 payload_val1, u64 limit_node, u32 node_id,
> +		       u64 version, bool has_val1)

Rather than always passing a dummy payload_val1 and then having has_val1
to indicate if it should be considered or not... how about moving the
payload last in the call, as a va_list with a "count" before that?

I.e:

int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u64 limit_node, u32 node_id,
		       u64 version, unsigned int payload_count, ...)

>  {
>  	dma_addr_t payload_phys;
>  	u32 *payload_buf;
> -	int ret, payload_size = 5 * sizeof(u32);
> +	int ret, payload_size = (5 + has_val1) * sizeof(u32);

allocate 4 + payload_count

>  
>  	struct qcom_scm_desc desc = {
>  		.svc = QCOM_SCM_SVC_LMH,
> @@ -1278,8 +1279,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>  	payload_buf[0] = payload_fn;
>  	payload_buf[1] = 0;
>  	payload_buf[2] = payload_reg;
> -	payload_buf[3] = 1;
> -	payload_buf[4] = payload_val;
> +	payload_buf[3] = has_val1 ? 2 : 1;
> +	payload_buf[4] = payload_val0;
> +	if (has_val1)
> +		payload_buf[5] = payload_val1;

Something like:

payload_buf[3] = payload_count;
va_start(ap, payload_count);
for (i = 0; i < payload_count; i++)
	payload_buf[4 + i] = va_arg(ap, uint32_t);
va_end(ap);



That said, I don't see a single "true" below. Perhaps I'm missing it? I
would expect some code in the same series use the newly introduced
logic.

Thanks,
Bjorn

>  
>  	desc.args[0] = payload_phys;
>  
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> index 5e8ff196c9a6..d2b5ea8322eb 100644
> --- a/drivers/thermal/qcom/lmh.c
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -147,23 +147,23 @@ static int lmh_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  
>  	if (flags & LMH_ENABLE_ALGOS) {
> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
> -					 LMH_NODE_DCVS, node_id, 0);
> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1, 0,
> +					 LMH_NODE_DCVS, node_id, 0, false);
>  		if (ret)
>  			dev_err(dev, "Error %d enabling current subfunction\n", ret);
>  
> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
> -					 LMH_NODE_DCVS, node_id, 0);
> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1, 0,
> +					 LMH_NODE_DCVS, node_id, 0, false);
>  		if (ret)
>  			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>  
> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
> -					 LMH_NODE_DCVS, node_id, 0);
> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1, 0,
> +					 LMH_NODE_DCVS, node_id, 0, false);
>  		if (ret)
>  			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>  
> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
> -					 LMH_NODE_DCVS, node_id, 0);
> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1, 0,
> +					 LMH_NODE_DCVS, node_id, 0, false);
>  		if (ret) {
>  			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>  			return ret;
> @@ -177,22 +177,22 @@ static int lmh_probe(struct platform_device *pdev)
>  	}
>  
>  	/* Set default thermal trips */
> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
> -				 LMH_NODE_DCVS, node_id, 0);
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm, 0,
> +				 LMH_NODE_DCVS, node_id, 0, false);
>  	if (ret) {
>  		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
> -				 LMH_NODE_DCVS, node_id, 0);
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high, 0,
> +				 LMH_NODE_DCVS, node_id, 0, false);
>  	if (ret) {
>  		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
> -				 LMH_NODE_DCVS, node_id, 0);
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low, 0,
> +				 LMH_NODE_DCVS, node_id, 0, false);
>  	if (ret) {
>  		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>  		return ret;
> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
> index 1e449a5d7f5c..9fd798d17fdd 100644
> --- a/include/linux/qcom_scm.h
> +++ b/include/linux/qcom_scm.h
> @@ -117,8 +117,9 @@ extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>  extern int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
>  extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
>  
> -extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
> -			      u64 limit_node, u32 node_id, u64 version);
> +extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val0,
> +			      u32 payload_val1, u64 limit_node, u32 node_id,
> +			      u64 version, bool has_val1);
>  extern int qcom_scm_lmh_profile_change(u32 profile_id);
>  extern bool qcom_scm_lmh_dcvsh_available(void);
>  
> -- 
> 2.39.0
> 
