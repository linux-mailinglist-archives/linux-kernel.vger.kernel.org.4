Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB83D6B816F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjCMTIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCMTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:08:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C81A2E0D1;
        Mon, 13 Mar 2023 12:08:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11715B811C0;
        Mon, 13 Mar 2023 19:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3E6C4339E;
        Mon, 13 Mar 2023 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678734501;
        bh=UxmK1Rh5GkCgRmvK7nqy0FXnK5ohwNUzJuIxLBCLKU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mx9YabRVEPtpQa/6LUWQ5j67vTxjTOuk47icPMo+oNFr1Fp9VkHT4IuLXqNOZdJsF
         27jpGLPgap/NCCxXgTDKvOTzDHCSs2ETj9CAAACGHDODLpl09I+p2qttJyG/cKlOIs
         dDe/DlUo4TH1bA6oc/9DubtKITSW+a3VGhQ41VDLed2knCUixFggmim5LH5RqF/Y3s
         L+N8TmiAzy7ehfWVTkKIh1nLl4/LaB8y5BB5r5jeM2SNnq8XlAteRsjTpJNVU1mvsZ
         RKrvXm7fln09QUpXfDacikqPJTre4NGLffXcC7vNLlMfhCbSLP64CVZYJSMX+ZmufD
         h5O0Hngy8BGkQ==
Date:   Mon, 13 Mar 2023 12:08:19 -0700
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
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v3 5/7] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <ZA90o0K6fBHe0Q74@sol.localdomain>
References: <20230313115202.3960700-1-abel.vesa@linaro.org>
 <20230313115202.3960700-6-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313115202.3960700-6-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 01:52:00PM +0200, Abel Vesa wrote:
> diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
> index d7c5bf7fa512..081b332fe7ce 100644
> --- a/drivers/ufs/host/Makefile
> +++ b/drivers/ufs/host/Makefile
> @@ -5,7 +5,6 @@ obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) += tc-dwc-g210-pltfrm.o ufshcd-dwc.o tc-d
>  obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
>  obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
>  ufs_qcom-y += ufs-qcom.o
> -ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
>  obj-$(CONFIG_SCSI_UFS_EXYNOS) += ufs-exynos.o
>  obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
>  obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o

Now that ufs-qcom will be single-file again, maybe this should go back to the
original approach of just:

	obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o

(Note the dash instead of underscore)

> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index a02cd866e2f8..8f8581dbe09a 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -15,6 +15,8 @@
>  #include <linux/reset-controller.h>
>  #include <linux/devfreq.h>
>  
> +#include <soc/qcom/ice.h>
> +
>  #include <ufs/ufshcd.h>
>  #include "ufshcd-pltfrm.h"
>  #include <ufs/unipro.h>
> @@ -55,6 +57,85 @@ static struct ufs_qcom_host *rcdev_to_ufs_host(struct reset_controller_dev *rcd)
>  	return container_of(rcd, struct ufs_qcom_host, rcdev);
>  }
>  
> +#ifdef CONFIG_SCSI_UFS_CRYPTO
> +
> +static inline void ufs_qcom_ice_enable(struct ufs_qcom_host *host)
> +{
> +	qcom_ice_enable(host->ice);
> +}
> +
> +static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
> +{
> +	struct ufs_hba *hba = host->hba;
> +	struct device *dev = hba->dev;
> +
> +	host->ice = of_qcom_ice_get(dev);
> +	if (IS_ERR(host->ice))
> +		return PTR_ERR(host->ice);
> +
> +	return 0;
> +}

What happens if ICE is not supported?  I believe we should continue allowing UFS
to work with crypto support, as was the case before.

Note these lines of code in the original version:

	dev_warn(dev, "Disabling inline encryption support\n");
	hba->caps &= ~UFSHCD_CAP_CRYPTO;

It's important to clear UFSHCD_CAP_CRYPTO, otherwise the driver will think that
ICE is supported.

- Eric
