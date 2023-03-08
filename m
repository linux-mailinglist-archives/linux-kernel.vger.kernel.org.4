Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD706B128E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCHUBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCHUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:01:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4725CE967;
        Wed,  8 Mar 2023 12:01:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51CEEB81DEF;
        Wed,  8 Mar 2023 20:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CA9C433EF;
        Wed,  8 Mar 2023 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678305704;
        bh=AkqRrQZvitrDRxlLCdBGZF5qiD811jL2TzZPP/iKUno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VQXVlmxqltM5l/JMngR1vQzCicyHmGinHxmGV4RoO46t/Eo/oRmkWeyv0nx+uCLtf
         lbzThSIo93UB5w8AB27wXclmx9VxSfaW47tiHPeOCP7FkBwIq7lu3auhagWZwqwU8y
         evM3HFOE2bzJue6V1uL2LQS8vU+pbtC201aEapZ+PpLfFP3UMpKcLP9BZ+mJlin513
         LB4li9yB+8rSMZN8z5N0AL7fyd2SOzUN4W5tmJGNJMmHwea4jLwkUTc28Ma4F4AKPI
         DnWurixaLo6mErZGmksqEHgjzrrwAqHUcNmAQHaOf9YKYiLHcsGBuuKqIX1Q2EAgab
         /W1M6s5x/MNIw==
Date:   Wed, 8 Mar 2023 12:01:41 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/7] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <ZAjppY2K0/XPBHxG@sol.localdomain>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-5-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308155838.1094920-5-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 05:58:35PM +0200, Abel Vesa wrote:
>  * Switched QCOM_INLINE_CRYPTO_ENGINE to tristate and made it built-in
>    if any of the UFS or the SDHC drivers are built-in. This is to allow
>    the API to be available even if the built-in driver doesn't have
>    crypto enabled.
[...]
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index a8f283086a21..c584369e9810 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -275,4 +275,10 @@ config QCOM_ICC_BWMON
>  	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
>  	  memory throughput even with lower CPU frequencies.
>  
> +config QCOM_INLINE_CRYPTO_ENGINE
> +	tristate
> +	depends on SCSI_UFS_CRYPTO || MMC_CRYPTO
> +	default y if SCSI_UFS_QCOM=y || MMC_SDHCI_MSM=y
> +	select QCOM_SCM

What are the "depends on" and "default y" lines above for?

You're already selecting this from SCSI_UFS_QCOM and MSM_SDHCI_MSM, as I had
suggested.  Isn't that enough?

- Eric
