Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1268C7B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBFUgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBFUgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:36:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17204EDB;
        Mon,  6 Feb 2023 12:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DE5260F33;
        Mon,  6 Feb 2023 20:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393DFC433D2;
        Mon,  6 Feb 2023 20:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675715761;
        bh=sQvioVNroLYZbZP6kYyFNgj62DExtljLCs9UmJr/96c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=puprCIQdrg3fvSw5FcPUmYpEZEUd5s4aVouPHIIfOmxlTpojTvqQK9hwDwadAqTnm
         vmRfFqZoDJFL3QUArfgm+r0eIRzOSIclsPcacn2oi6YPE2wTpex6rn69adsvg/hSQO
         wSmE2tFd1XvU/hwh2GZvwvj2jaQU4n06eFs1tJMrOeEapavq5PIe33KqKq5rVsfC2z
         O42e7drOkko3sqs6Vuz7hiL0l5a4wb9/FzqL4b3TUAZkcS+jD5Bno4dRyIgYhFJVsS
         APgvJrafZgjHjz3CS1Wu1pd02enFnHKIJ0enHdq3nuEH5qjbvFLnst8FviQpRApSh5
         Z1B3tSZUCqxfQ==
Date:   Mon, 6 Feb 2023 12:38:16 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] cpufreq: qcom-nvmem: reuse socinfo SMEM item struct
Message-ID: <20230206203816.afexndkiqhpk6e7b@ripper>
References: <20230121112947.53433-1-robimarko@gmail.com>
 <20230121112947.53433-2-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121112947.53433-2-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:29:45PM +0100, Robert Marko wrote:
> Now that socinfo SMEM item struct and defines have been moved to a header
> so we can utilize that instead.
> 
> Now the SMEM value can be accesed directly, there is no need for defining
> the ID for the SMEM request as well.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Rafael, @Viresh, would you mind providing an Ack for me to take these 3
patches, together with patch 1, through the Qualcomm tree? I have staged
changes for 6.3, so we'll otherwise end up with conflicts on the move of
the struct.

Thanks,
Bjorn

> ---
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index a577586b23be..c0a7841a56c1 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -28,8 +28,7 @@
>  #include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
> -
> -#define MSM_ID_SMEM	137
> +#include <linux/soc/qcom/socinfo.h>
>  
>  enum _msm_id {
>  	MSM8996V3 = 0xF6ul,
> @@ -143,17 +142,14 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>  static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>  {
>  	size_t len;
> -	u32 *msm_id;
> +	struct socinfo *info;
>  	enum _msm8996_version version;
>  
> -	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
> -	if (IS_ERR(msm_id))
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
> +	if (IS_ERR(info))
>  		return NUM_OF_MSM8996_VERSIONS;
>  
> -	/* The first 4 bytes are format, next to them is the actual msm-id */
> -	msm_id++;
> -
> -	switch ((enum _msm_id)*msm_id) {
> +	switch (info->id) {
>  	case MSM8996V3:
>  	case APQ8096V3:
>  		version = MSM8996_V3;
> -- 
> 2.39.1
> 
