Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B396AFE3F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 06:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjCHFVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 00:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCHFVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 00:21:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0CCA0F0C;
        Tue,  7 Mar 2023 21:21:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF0E861689;
        Wed,  8 Mar 2023 05:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433C5C433EF;
        Wed,  8 Mar 2023 05:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678252874;
        bh=za1Q16N+OKXL1B8Fsh9XF7M5Y5D0OFnawDBveqfsM6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDaAIu1ThDvVYCUo/dl7gDw8bAKGfvzpE/etz4q+6fhRTG9kPX2PxZ5GXe4vWPjty
         qmD9gucVgghFw6vvNntTbvEqcQscnexMQeXPrrDVvUFXyubWKURVNy/L8z9/y19ISQ
         SJH88FzFTwULj1egNf98pGML27XjeyrRh9HlDX1m3J9J0TfLykICcEZrIcYBukEIPw
         ed3NdgwZITCC+Ria7SlklapDj954Eq4NmePz5ARTAnWSoRWJx2LuXRn65+le+78n/L
         +VpFw95rjWCdULqoRi4mXHP/mLiCiyeeVToFjjxTn+U9BCyVlUsIcqguJOBZRmTXcg
         7UMEXY3Ma8BjA==
Date:   Wed, 8 Mar 2023 10:51:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Drop redundant
 pci_enable_pcie_error_reporting()
Message-ID: <20230308052108.GA5124@thinkpad>
References: <20230307201625.879567-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230307201625.879567-1-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 02:16:25PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> pci_enable_pcie_error_reporting() enables the device to send ERR_*
> Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting when AER is
> native"), the PCI core does this for all devices during enumeration, so the
> driver doesn't need to do it itself.
> 
> Remove the redundant pci_enable_pcie_error_reporting() call from the
> driver.  Also remove the corresponding pci_disable_pcie_error_reporting()
> from the driver .remove() path.
> 
> Note that this only controls ERR_* Messages from the device.  An ERR_*
> Message may cause the Root Port to generate an interrupt, depending on the
> AER Root Error Command register managed by the AER service driver.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/pci_generic.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index f39657f71483..6e13c43a84d1 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -8,7 +8,6 @@
>   * Copyright (C) 2020 Linaro Ltd <loic.poulain@linaro.org>
>   */
>  
> -#include <linux/aer.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/mhi.h>
> @@ -903,11 +902,9 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_pdev->pci_state = pci_store_saved_state(pdev);
>  	pci_load_saved_state(pdev, NULL);
>  
> -	pci_enable_pcie_error_reporting(pdev);
> -
>  	err = mhi_register_controller(mhi_cntrl, mhi_cntrl_config);
>  	if (err)
> -		goto err_disable_reporting;
> +		return err;
>  
>  	/* MHI bus does not power up the controller by default */
>  	err = mhi_prepare_for_power_up(mhi_cntrl);
> @@ -941,8 +938,6 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	mhi_unprepare_after_power_down(mhi_cntrl);
>  err_unregister:
>  	mhi_unregister_controller(mhi_cntrl);
> -err_disable_reporting:
> -	pci_disable_pcie_error_reporting(pdev);
>  
>  	return err;
>  }
> @@ -965,7 +960,6 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>  		pm_runtime_get_noresume(&pdev->dev);
>  
>  	mhi_unregister_controller(mhi_cntrl);
> -	pci_disable_pcie_error_reporting(pdev);
>  }
>  
>  static void mhi_pci_shutdown(struct pci_dev *pdev)
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
