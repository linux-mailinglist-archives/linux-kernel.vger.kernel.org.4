Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120E36CBB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjC1Jse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjC1Jry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:47:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D566768C;
        Tue, 28 Mar 2023 02:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59C0DB817B1;
        Tue, 28 Mar 2023 09:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1917DC433EF;
        Tue, 28 Mar 2023 09:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679996784;
        bh=8ajMq/ecRK76g5gu4E4Hke78PVvz/W3mGeuAfyX0vh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRQx+J+U54vS2nZr0Qc+K64PPX0BNVrW5suFp5XhbNEUvHY2xQQrzHnBT29WyE5Zr
         6e1I32g+Ers/hUxph2XWmllaCCFG0WKAdxflXOm40Q+mzmg5bVE4tGzLDsU0xJWqEq
         U1rAtYnglJZNmNjFTFVQje0F710FkEP50Aazb+cmMwbTd0A4eMOWUMoROjpkcmDBxa
         7X9e0UghUiAOZ0uHHZwF6zU+drMhtc7PzvDTLSIF4y6cM/Hhe7yVFonC2WiE9LTLr8
         Uos5/otmy/wjKJPOEbqV6HxAPKpajTvK+pl7ESPkadBU75nHCJfOedb9Yt08WLa4Qc
         CqUL3+OQTc0ug==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ph5uW-0004ZG-6j; Tue, 28 Mar 2023 11:46:36 +0200
Date:   Tue, 28 Mar 2023 11:46:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] usb: dwc3: qcom: Allow runtime PM
Message-ID: <ZCK3fGkgowvAd6Dw@hovoldconsulting.com>
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <20230325165217.31069-6-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325165217.31069-6-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:22:17PM +0530, Manivannan Sadhasivam wrote:
> dwc3-qcom driver is capable of doing runtime PM on its own, but currently
> it requires userspace intervention to enable it. But there is no harm in
> letting the driver to enable runtime PM on its own. So let's get rid of the
> "pm_runtime_forbid()" and make sure that the dependency is maintained with
> child devices using "pm_suspend_ignore_children(dev, false)".

Well, the potential harm is that these paths have hardly been tested so
enabling it by default is a risk (e.g. as you noticed when trying to
enable this by default). And especially if we don't address the layering
violations first.

> Also during remove(), the device needs to be waken up first if it was
> runtime suspended. Finally, pm_runtime_allow() can be removed.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index f1059dfcb0e8..5f26bb66274f 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -920,7 +920,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  	qcom->is_suspended = false;
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> -	pm_runtime_forbid(dev);
> +	pm_suspend_ignore_children(dev, false);

There's no need to explicitly disable ignore-children as that is the
default.

>  	return 0;
>  
> @@ -948,6 +948,8 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int i;
>  
> +	pm_runtime_get_sync(dev);

This call needs to be balanced. But this is a fix for a bug in the
current implementation that should go in a separate patch.

> +
>  	device_remove_software_node(&qcom->dwc3->dev);
>  	of_platform_depopulate(dev);
>  
> @@ -960,7 +962,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
>  	dwc3_qcom_interconnect_exit(qcom);
>  	reset_control_assert(qcom->resets);
>  
> -	pm_runtime_allow(dev);
>  	pm_runtime_disable(dev);
>  
>  	return 0;

Johan
