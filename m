Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD31A712CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243721AbjEZTAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjEZTAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B4D13D;
        Fri, 26 May 2023 12:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE9165144;
        Fri, 26 May 2023 19:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419D9C433EF;
        Fri, 26 May 2023 19:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685127649;
        bh=OwGBBeqTi3pB0gviL0C1z2nfWpb8FMmWo3zLKT7MarI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SNEkqlUUNQ86iDvEAzsq00H0pEF/yG3+MmmM0l37a9cYlJ7BaypvkufQ5YvV5oHOG
         K2Z/hlBTskyHfTXE6HesqqrV3W2CDzNsAS60zHKjWxe4Dx1p52nf2PPjrKdYQau5b7
         uZd+umnarv+G9FF8lCVpOQrrxr3qdcRUi4hBcJDvkCqvA2ClfOritDArzqMpiYPwxv
         s+w96TmLtjOgvZgTCPw0hSulsZ8D5i4MAzeGgQTXkaS9fWFb1MmHCZo+wQsmR+Ewit
         j2AUS4XKzhITSce1JrExpjRw9NlyoYa6VxGjYHPmTyMQS0ZVCTeisKLRYrCCUhzVEt
         qj26cPqCZ/CRw==
Date:   Fri, 26 May 2023 12:04:37 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH v4 3/5] soc: qcom: smem: introduce qcom_smem_get_soc_id()
Message-ID: <20230526190437.yekx5ufpwxkowlrp@ripper>
References: <20230525210214.78235-1-robimarko@gmail.com>
 <20230525210214.78235-3-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525210214.78235-3-robimarko@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 11:02:12PM +0200, Robert Marko wrote:
> Introduce a helper to return the SoC SMEM ID, which is used to identify the
> exact SoC model as there may be differences in the same SoC family.
> 
> Currently, cpufreq-nvmem does this completely in the driver and there has
> been more interest expresed for other drivers to use this information so
> lets expose a common helper to prevent redoing it in individual drivers
> since this field is present on every SMEM table version.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v4:
> * Change helper name to qcom_smem_get_soc_id()
> * Remove len and just pass NULL, that is sufficient here
> 
> Changes in v3:
> * Change export to EXPORT_SYMBOL_GPL
> * Use an argument for returning SoC ID
> * Update kerneldoc
> ---
>  drivers/soc/qcom/smem.c       | 23 +++++++++++++++++++++++
>  include/linux/soc/qcom/smem.h |  2 ++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index bc98520c4969..78cf79ea4924 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -14,6 +14,7 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
> +#include <linux/soc/qcom/socinfo.h>
>  
>  /*
>   * The Qualcomm shared memory system is a allocate only heap structure that
> @@ -772,6 +773,28 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>  }
>  EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>  
> +/**
> + * qcom_smem_get_soc_id() - return the SoC ID
> + * @id:	On success, we return the SoC ID here.
> + *
> + * Look up SoC ID from HW/SW build ID and return it.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +int qcom_smem_get_soc_id(u32 *id)
> +{
> +	struct socinfo *info;
> +
> +	info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, NULL);
> +	if (IS_ERR(info))
> +		return PTR_ERR(info);
> +
> +	*id = info->id;

So just to make the discussion between Konrad and me clear, please wrap
the info->id access in __le32_to_cpu() and the series is ready to go.

Thanks,
Bjorn

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(qcom_smem_get_soc_id);
> +
>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>  {
>  	struct smem_header *header;
> diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> index 86e1b358688a..223db6a9c733 100644
> --- a/include/linux/soc/qcom/smem.h
> +++ b/include/linux/soc/qcom/smem.h
> @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
>  
>  phys_addr_t qcom_smem_virt_to_phys(void *p);
>  
> +int qcom_smem_get_soc_id(u32 *id);
> +
>  #endif
> -- 
> 2.40.1
> 
