Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77E268C7C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBFUjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjBFUju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:39:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7353AA3;
        Mon,  6 Feb 2023 12:39:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0499361003;
        Mon,  6 Feb 2023 20:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3C4C433EF;
        Mon,  6 Feb 2023 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675715988;
        bh=or1c/qY0q70nvMFTuwULQPzHJ8Ha8hJkCTbJR2BH4Po=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QcS1uAxdM+drzjccwX9k2OuceMyYBh30LRHscIpuTEwlrqgUcAAU4np8AGEUEhnB+
         rWyhRQ7psuRBY/olQ09wF6Z3Ey5x2oBK2HziWpnzO1vytUCm25FiA1uaMK8CaY0I8O
         3pxUjMIdQsX/Kg1qKclKql6D7Z62XBMlJ+8DvH7P8+Jy+e9rENa9OkJ34+rNUVhsK8
         9LoVJKTKhYnnfYYqC6MEEOmWgmTUgdlnjhZYEUpM45vTbRQ7F+KrnnBabU/o9oOVDS
         ENk2qjia5HdvGU9wL+tx1ceASQII+bpaN7FCCIz2j8Pa8ekKTDivdqfDxpgTlsj1D9
         +yHm6Dr2921Hw==
Date:   Mon, 6 Feb 2023 12:42:02 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
Message-ID: <20230206204202.3pqte7ynyybezv5g@ripper>
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-4-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121112947.53433-4-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:29:47PM +0100, Robert Marko wrote:
> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
> after getting it via SMEM call but instead uses an enum to encode the
> matched SMEM ID to 2 variants of MSM8996 which are then used in
> qcom_cpufreq_kryo_name_version() to set the supported version.
> 
> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
> more than its name suggests, so lets make it just return the SoC ID
> directly which allows matching directly on the SoC ID and removes the need
> for msm8996_version enum which simplifies the driver.
> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
>  1 file changed, 12 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index da55d2e1925a..9deaf9521d6d 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -32,12 +32,6 @@
>  
>  #include <dt-bindings/arm/qcom,ids.h>
>  
> -enum _msm8996_version {
> -	MSM8996_V3,
> -	MSM8996_SG,
> -	NUM_OF_MSM8996_VERSIONS,
> -};
> -
>  struct qcom_cpufreq_drv;
>  
>  struct qcom_cpufreq_match_data {
> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>  	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>  }
>  
> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> +static int qcom_cpufreq_get_msm_id(void)
>  {
>  	size_t len;
>  	struct socinfo *info;
> -	enum _msm8996_version version;
>  
>  	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
>  	if (IS_ERR(info))
> -		return NUM_OF_MSM8996_VERSIONS;
> +		return PTR_ERR(info);
>  
> -	switch (info->id) {
> -	case QCOM_ID_MSM8996:
> -	case QCOM_ID_APQ8096:
> -		version = MSM8996_V3;
> -		break;
> -	case QCOM_ID_MSM8996SG:
> -	case QCOM_ID_APQ8096SG:
> -		version = MSM8996_SG;
> -		break;
> -	default:
> -		version = NUM_OF_MSM8996_VERSIONS;
> -	}
> -
> -	return version;
> +	return info->id;
>  }
>  
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
> @@ -166,25 +146,25 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct qcom_cpufreq_drv *drv)
>  {
>  	size_t len;
> +	int msm_id;
>  	u8 *speedbin;
> -	enum _msm8996_version msm8996_version;
>  	*pvs_name = NULL;
>  
> -	msm8996_version = qcom_cpufreq_get_msm_id();
> -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> -		return -ENODEV;
> -	}
> +	msm_id = qcom_cpufreq_get_msm_id();
> +	if (msm_id < 0)
> +		return msm_id;
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  	if (IS_ERR(speedbin))
>  		return PTR_ERR(speedbin);
>  
> -	switch (msm8996_version) {
> -	case MSM8996_V3:
> +	switch (msm_id) {
> +	case QCOM_ID_MSM8996:
> +	case QCOM_ID_APQ8096:
>  		drv->versions = 1 << (unsigned int)(*speedbin);
>  		break;
> -	case MSM8996_SG:
> +	case QCOM_ID_MSM8996SG:
> +	case QCOM_ID_APQ8096SG:
>  		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
>  		break;
>  	default:
> -- 
> 2.39.1
> 
