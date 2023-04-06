Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785416DA373
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbjDFUii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbjDFUiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:38:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A807FB47B;
        Thu,  6 Apr 2023 13:34:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E014C6471F;
        Thu,  6 Apr 2023 20:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E7CC433D2;
        Thu,  6 Apr 2023 20:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680813275;
        bh=piwLBENh4irhNGFJSxnTnkgU+tz4S7Qx3VDC5mBsLow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKmaeMCgUMeITeDCNa33PhQDb7Ra//T9u6ZrmomOXgtwhrr6fphYxLIU4OQN4QXGe
         KYEDTQUr+Ag83EPbtj7/mOs71LKexZ8aUpqf/3Ds8OM+NRZiCV7Yz9fVJEHG0I5pXG
         4d5T45oQeqHxxxN9mfQT6g+a7MHaryvDunWV91pt9w3XTHSR8o0XjuQKZtRhdepfal
         BJy2EVQTh0hqfLeKXaHaHjRRU1giIX/KarfNTuF3poLm/C5EzASATDPHZOWyphetxl
         QRq7rFce1sH2MOhvQNmVa7pc8pLJBrwbrcpIyun52nycMADa89n+aCJkePKpTxkduL
         mADB0NIRV4Izw==
Date:   Thu, 6 Apr 2023 13:34:32 -0700
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
Subject: Re: [PATCH v5 3/6] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <20230406203432.GC20288@sol.localdomain>
References: <20230403200530.2103099-1-abel.vesa@linaro.org>
 <20230403200530.2103099-4-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403200530.2103099-4-abel.vesa@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:05:27PM +0300, Abel Vesa wrote:
> This takes the already existing duplicated support in both ufs-qcom
> and sdhci-msm drivers and makes it a dedicated driver that can be used
> by both mentioned drivers. The reason for this is because, staring with
> SM8550, the ICE IP block is shared between UFS and SDCC, which means we
> need to probe a dedicated device and share it between those two
> consumers. So let's add the ICE dedicated driver as a soc driver.
> Platforms that already have ICE supported, will use it as a library
> as the of_qcom_ice_get will return an ICE instance created for the
> consumer device. This allows the backwards compatibility with old-style
> devicetree approach. Also, add support to HW version 4.x since it
> works out-of-the-box with the current driver. The 4.x HW version is
> found on SM8550 platform.

Can you please split up long paragraphs like this into multiple paragraphs?

> +	pdev = of_find_device_by_node(node);
> +	if (!pdev) {
> +		dev_err(dev, "Cannot find device node %s\n", node->name);
> +		ice = ERR_PTR(-EPROBE_DEFER);
> +		goto out;
> +	}
> +
> +	ice = platform_get_drvdata(pdev);
> +	if (!ice) {
> +		dev_err(dev, "Cannot get ice instance from %s\n",
> +			dev_name(&pdev->dev));
> +		platform_device_put(pdev);
> +		ice = ERR_PTR(-EPROBE_DEFER);
> +		goto out;
> +	}
> +
> +	ice->link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
> +	if (!ice->link) {
> +		dev_err(&pdev->dev,
> +			"Failed to create device link to consumer %s\n",
> +			dev_name(dev));
> +		ice = ERR_PTR(-EINVAL);
> +	}

Is a call to platform_device_put() missing above?

- Eric
