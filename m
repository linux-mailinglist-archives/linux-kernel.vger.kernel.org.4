Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96BD16CACE4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjC0STl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjC0STj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495AF1BF1;
        Mon, 27 Mar 2023 11:19:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E57AF613CA;
        Mon, 27 Mar 2023 18:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A254C433D2;
        Mon, 27 Mar 2023 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679941177;
        bh=jxWcGcpioNQejKk8I7hJg+OhLTSHRqbJl49uuhHYivo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zc8sMCdKqOks3JUZN+McYVEWMcU8JNsdhkPNeC1XxCSKRjOLWQ4BkZgrK37KeNxsG
         R3fcqJvW+ikEcFOM+WimhkTemMG3zc4nLBuHPfsEchkgMCfgcJjjJCVb/rX/HziQ1x
         WY+4rzGx/Ba5PCPfLEtYG6/PfhOA0WBF9ucxR+s1hDcmtCIBGKmmDiP6SL7G2Fdy/4
         bE0L2kW3TR3mn0y5S7Vh3htid6fEXPRNCo7DXgkACBclfQmNYg/9DZbrB6fajjP6zA
         W1Cct7By/QiKd8W2XTgRPHaRRKZqZbcYmr6XiDV+yLn17LK+UmWhbSiEdBRcfL1hVJ
         4Wp5Du2EAMRjg==
Date:   Mon, 27 Mar 2023 11:19:34 -0700
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
Subject: Re: [PATCH v4 5/7] scsi: ufs: ufs-qcom: Switch to the new ICE API
Message-ID: <20230327181934.GD1882@sol.localdomain>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-6-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327134734.3256974-6-abel.vesa@linaro.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Mon, Mar 27, 2023 at 04:47:32PM +0300, Abel Vesa wrote:
> Now that there is a new dedicated ICE driver, drop the ufs-qcom-ice and
> use the new ICE api provided by the Qualcomm soc driver ice. The platforms
> that already have ICE support will use the API as library since there will
> not be a devicetree node, but instead they have reg range. In this case,
> the of_qcom_ice_get will return an ICE instance created for the consumer's
> device. But if there are platforms that do not have ice reg in the
> consumer devicetree node and instead provide a dedicated ICE devicetree
> node, the of_qcom_ice_get will look up the device based on qcom,ice
> property and will get the ICE instance registered by the probe function
> of the ice driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

I am still worried about the ICE clock.  Are you sure it is being managed
correctly?  With your patch, the ICE clock gets enabled in ufs_qcom_ice_resume
and disabled in ufs_qcom_ice_suspend, which hopefully pair up.  But it also gets
enabled in ufs_qcom_ice_enable which isn't paired with anything.  Also, this all
happens at a different time from the existing UFS clocks being enabled/disabled.

I wonder if the ICE clock should be enabled/disabled in ufs_qcom_setup_clocks()
instead of what you are doing currently?

> +static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
> +{
> +	struct ufs_hba *hba = host->hba;
> +	struct device *dev = hba->dev;
> +
> +	host->ice = of_qcom_ice_get(dev);
> +	if (host->ice == ERR_PTR(-EOPNOTSUPP)) {
> +		dev_warn(dev, "Disabling inline encryption support\n");
> +		hba->caps &= ~UFSHCD_CAP_CRYPTO;
> +		host->ice = NULL;
> +	}
> +
> +	if (IS_ERR(host->ice))
> +		return PTR_ERR(host->ice);
> +
> +	return 0;
> +}

This is still sometimes leaving UFSHCD_CAP_CRYPTO set in cases where ICE is
unsupported.

Moving the *setting* of UFSHCD_CAP_CRYPTO into here would fix that.

It is also hard to understand how the -EOPNOTSUPP case differs from the NULL
case.  Can you add a comment?  Or just consider keeping the original behavior,
which did not distinguish between these cases (as long as MASK_CRYPTO_SUPPORT
was set in REG_CONTROLLER_CAPABILITIES, which was checked first).

- Eric
