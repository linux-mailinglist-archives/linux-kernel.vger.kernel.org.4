Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965DA6D1EB6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCaLIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjCaLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:08:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF2FA21A95;
        Fri, 31 Mar 2023 04:06:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C886C2F4;
        Fri, 31 Mar 2023 04:07:17 -0700 (PDT)
Received: from [10.57.54.53] (unknown [10.57.54.53])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9D423F6C4;
        Fri, 31 Mar 2023 04:06:30 -0700 (PDT)
Message-ID: <d995fec6-1d3f-df37-724e-67d929e9e0db@arm.com>
Date:   Fri, 31 Mar 2023 12:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH V2 3/5] coresight: etm4x: Drop pid argument from
 etm4_probe()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     scclevenger@os.amperecomputing.com,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230327050537.30861-1-anshuman.khandual@arm.com>
 <20230327050537.30861-4-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230327050537.30861-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 06:05, Anshuman Khandual wrote:
> Coresight device pid can be retrieved from its iomem base address, which is
> stored in 'struct etm4x_drvdata'. This drops pid argument from etm4_probe()
> and 'struct etm4_init_arg'. Instead etm4_check_arch_features() derives the
> coresight device pid with a new helper coresight_get_pid(), right before it
> is consumed in etm4_hisi_match_pid().
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   .../coresight/coresight-etm4x-core.c          | 21 +++++++------------
>   include/linux/coresight.h                     | 12 +++++++++++
>   2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 5d77571a8df9..3521838ab4fb 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -66,7 +66,6 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>   static enum cpuhp_state hp_online;
>   
>   struct etm4_init_arg {
> -	unsigned int		pid;
>   	struct device		*dev;
>   	struct csdev_access	*csa;
>   };
> @@ -370,8 +369,10 @@ static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
>   }
>   
>   static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
> -				      unsigned int id)
> +				     struct csdev_access *csa)
>   {
> +	unsigned int id = coresight_get_pid(csa);
> +

This throws up the following error on an ETE.

ete: trying to read unsupported register @fe0

So, I guess this must be performed only for iomem based
devices. System instruction based device must be identified
by MIDR_EL1/REVIDR_EL1 if needed for specific erratum.
This is not required now. So, we could bail out early
if we are system instruction based device.


>   	if (etm4_hisi_match_pid(id))
>   		set_bit(ETM4_IMPDEF_HISI_CORE_COMMIT, drvdata->arch_features);
>   }
> @@ -385,7 +386,7 @@ static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
>   }
>   
>   static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
> -				     unsigned int id)
> +				     struct csdev_access *csa)
>   {
>   }
>   #endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
> @@ -1165,7 +1166,7 @@ static void etm4_init_arch_data(void *info)
>   	etm4_os_unlock_csa(drvdata, csa);
>   	etm4_cs_unlock(drvdata, csa);
>   
> -	etm4_check_arch_features(drvdata, init_arg->pid);
> +	etm4_check_arch_features(drvdata, csa);
>   
>   	/* find all capabilities of the tracing unit */
>   	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
> @@ -2048,7 +2049,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
>   	return 0;
>   }
>   
> -static int etm4_probe(struct device *dev, u32 etm_pid)
> +static int etm4_probe(struct device *dev)
>   {
>   	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
>   	struct csdev_access access = { 0 };
> @@ -2077,7 +2078,6 @@ static int etm4_probe(struct device *dev, u32 etm_pid)
>   
>   	init_arg.dev = dev;
>   	init_arg.csa = &access;
> -	init_arg.pid = etm_pid;
>   
>   	/*
>   	 * Serialize against CPUHP callbacks to avoid race condition
> @@ -2124,7 +2124,7 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
>   
>   	drvdata->base = base;
>   	dev_set_drvdata(dev, drvdata);
> -	ret = etm4_probe(dev, id->id);
> +	ret = etm4_probe(dev);
>   	if (!ret)
>   		pm_runtime_put(&adev->dev);
>   
> @@ -2146,12 +2146,7 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
>   	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   
> -	/*
> -	 * System register based devices could match the
> -	 * HW by reading appropriate registers on the HW
> -	 * and thus we could skip the PID.
> -	 */
> -	ret = etm4_probe(&pdev->dev, 0);
> +	ret = etm4_probe(&pdev->dev);
>   
>   	pm_runtime_put(&pdev->dev);
>   	return ret;
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index f19a47b9bb5a..f85b041ea475 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -370,6 +370,18 @@ static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
>   	return csa->read(offset, true, false);
>   }
>   
> +#define CORESIGHT_PIDRn(i)	(0xFE0 + ((i) * 4))
> +
> +static inline u32 coresight_get_pid(struct csdev_access *csa)
> +{
> +	u32 i, pid = 0;
> +
> +	for (i = 0; i < 4; i++)
> +		pid |= csdev_access_relaxed_read32(csa, CORESIGHT_PIDRn(i)) << (i * 8);

Given the above, we could make this iomem specific.

Suzuki


> +
> +	return pid;
> +}
> +
>   static inline u64 csdev_access_relaxed_read_pair(struct csdev_access *csa,
>   						 u32 lo_offset, u32 hi_offset)
>   {

