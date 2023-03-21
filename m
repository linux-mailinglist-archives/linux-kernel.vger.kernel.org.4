Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6276C310A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjCUL5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjCUL5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:57:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD7634681
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:56:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2F9AD7;
        Tue, 21 Mar 2023 04:57:31 -0700 (PDT)
Received: from [10.163.89.43] (unknown [10.163.89.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F6E73F71E;
        Tue, 21 Mar 2023 04:56:44 -0700 (PDT)
Message-ID: <c1b23a12-5fb7-4e70-f4c3-4cdf2b13f392@arm.com>
Date:   Tue, 21 Mar 2023 17:26:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] coresight: etm4x: Do not access TRCIDR1 for
 identification
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        coresight@lists.linaro.org
Cc:     mike.leach@linaro.org, james.clark@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steve Clevenger <scclevenger@os.amperecomputing.com>
References: <20230321104530.1547136-1-suzuki.poulose@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230321104530.1547136-1-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/23 16:15, Suzuki K Poulose wrote:
> CoreSight ETM4x architecture clearly provides ways to identify a device
> via registers in the "Management" class, TRCDEVARCH and TRCDEVTYPE. These
> registers can be accessed without the Trace domain being powered on.
> We additionally added TRCIDR1 as fallback in order to cover for any
> ETMs that may not have implemented TRCDEVARCH. So far, nobody has
> reported hitting a WARNING we placed to catch such systems.
> 
> Also, more importantly it is problematic to access TRCIDR1, which is a
> "Trace" register via MMIO access, without clearing the OSLK. But we cannot
> mess with the OSLK until we know for sure that this is an ETMv4 device.
> Thus, this kind of creates a chicken and egg problem unnecessarily for
> systems "which are compliant" to the ETMv4 architecture.
> 
> Let us remove the TRCIDR1 fall back check and rely only on TRCDEVARCH.
> 
> Reported-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> Link: https://lore.kernel.org/all/143540e5623d4c7393d24833f2b80600d8d745d2.1677881753.git.scclevenger@os.amperecomputing.com/
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Fixes: 8b94db1edaee ("coresight: etm4x: Use TRCDEVARCH for component discovery")
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Reviewed-by: Mike Leach <mike.leach@linaro.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
> 
> Changes since v2:
>  - Remove unused etm_tridr_to_arch() helper
>  - Add comment to explain why TRCIDR1 cannot be used.
> 
> ---
>  .../coresight/coresight-etm4x-core.c          | 22 ++++++++-----------
>  drivers/hwtracing/coresight/coresight-etm4x.h | 20 +++++------------
>  2 files changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 104333c2c8a3..4c15fae534f3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1070,25 +1070,21 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
>  				   struct csdev_access *csa)
>  {
>  	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
> -	u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
>  
>  	/*
>  	 * All ETMs must implement TRCDEVARCH to indicate that
> -	 * the component is an ETMv4. To support any broken
> -	 * implementations we fall back to TRCIDR1 check, which
> -	 * is not really reliable.
> +	 * the component is an ETMv4. Even though TRCIDR1 also
> +	 * contains the information, it is part of the "Trace"
> +	 * register and must be accessed with the OSLK cleared,
> +	 * with MMIO. But we cannot touch the OSLK until we are
> +	 * sure this is an ETM. So rely only on the TRCDEVARCH.
>  	 */
> -	if ((devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH) {
> -		drvdata->arch = etm_devarch_to_arch(devarch);
> -	} else {
> -		pr_warn("CPU%d: ETM4x incompatible TRCDEVARCH: %x, falling back to TRCIDR1\n",
> -			smp_processor_id(), devarch);
> -
> -		if (ETM_TRCIDR1_ARCH_MAJOR(idr1) != ETM_TRCIDR1_ARCH_ETMv4)
> -			return false;
> -		drvdata->arch = etm_trcidr_to_arch(idr1);
> +	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH) {
> +		pr_warn_once("TRCDEVARCH doesn't match ETMv4 architecture\n");
> +		return false;
>  	}
>  
> +	drvdata->arch = etm_devarch_to_arch(devarch);
>  	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
>  	return true;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 434f4e95ee17..27c8a9901868 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -753,14 +753,12 @@
>   * TRCDEVARCH	- CoreSight architected register
>   *                - Bits[15:12] - Major version
>   *                - Bits[19:16] - Minor version
> - * TRCIDR1	- ETM architected register
> - *                - Bits[11:8] - Major version
> - *                - Bits[7:4]  - Minor version
> - * We must rely on TRCDEVARCH for the version information,
> - * however we don't want to break the support for potential
> - * old implementations which might not implement it. Thus
> - * we fall back to TRCIDR1 if TRCDEVARCH is not implemented
> - * for memory mapped components.
> + *
> + * We must rely only on TRCDEVARCH for the version information. Even though,
> + * TRCIDR1 also provides the architecture version, it is a "Trace" register
> + * and as such must be accessed only with Trace power domain ON. This may
> + * not be available at probe time.
> + *
>   * Now to make certain decisions easier based on the version
>   * we use an internal representation of the version in the
>   * driver, as follows :
> @@ -786,12 +784,6 @@ static inline u8 etm_devarch_to_arch(u32 devarch)
>  				ETM_DEVARCH_REVISION(devarch));
>  }
>  
> -static inline u8 etm_trcidr_to_arch(u32 trcidr1)
> -{
> -	return ETM_ARCH_VERSION(ETM_TRCIDR1_ARCH_MAJOR(trcidr1),
> -				ETM_TRCIDR1_ARCH_MINOR(trcidr1));
> -}
> -
>  enum etm_impdef_type {
>  	ETM4_IMPDEF_HISI_CORE_COMMIT,
>  	ETM4_IMPDEF_FEATURE_MAX,
