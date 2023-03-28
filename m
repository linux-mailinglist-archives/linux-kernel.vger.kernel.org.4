Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAEF6CBA69
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbjC1JXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjC1JX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:23:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA6423A;
        Tue, 28 Mar 2023 02:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A39AB81BD0;
        Tue, 28 Mar 2023 09:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D266AC433EF;
        Tue, 28 Mar 2023 09:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679995401;
        bh=V73OwOijyghiIZHH02OXNarVU22urwxS1fjmBBDAzFE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUDWsY3a4lZHcPsvDQsE/TxGVASbGPvYzkKAsr/+sqDuFyRmeOy9oN5x62QhrmVup
         j3sh23QeLFmkHZvtqRyTTk+b5y944fMtpouwaf9ryPMMotEksqj3idhl0G3HkyQWgf
         oJ9xi/0mI8+2Sc5JlE96UHcVTgiE/R6TMxWlunz0WAIzbBTZcE9wLNCpuAvC8/fNme
         Dt04rlnezRXM2vQRhWPnn3GdIC5lKoqXgGBHXrq7uFfOwhk7jPTUfKSSZgxitwOras
         R2c72tfrKbU03/cVvQp0bzeeaDDVgURY9jG+KXfDXY0JF+b/ZxQSrGqKxS0s95f+vQ
         jkb2E8GpWCF1w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ph5YC-0004C0-V1; Tue, 28 Mar 2023 11:23:33 +0200
Date:   Tue, 28 Mar 2023 11:23:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, Thinh.Nguyen@synopsys.com,
        gregkh@linuxfoundation.org, mathias.nyman@intel.com,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] usb: dwc3: qcom: Fix null ptr access during
 runtime_suspend()
Message-ID: <ZCKyFEc087xoypdo@hovoldconsulting.com>
References: <20230325165217.31069-1-manivannan.sadhasivam@linaro.org>
 <20230325165217.31069-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230325165217.31069-4-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:22:15PM +0530, Manivannan Sadhasivam wrote:
> When runtime PM is enabled during probe, the PM core suspends this driver
> before probing the dwc3 driver. Due to this, the dwc3_qcom_is_host()
> function dereferences the driver data of the dwc platform device which
> will only be set if the dwc driver has been probed. This causes null
> pointer dereference during boot time.

So this does not really appear to be an issue before your later patch
which enables runtime PM at probe.

But the layering violations we have in this driver are indeed fragile
and should be fixed properly at some point.

> So let's add a check for dwc drvdata in the callers of dwc3_qcom_is_host()
> such as dwc3_qcom_suspend() and dwc3_qcom_resume() functions. There is no
> need to add the same check in another caller dwc3_qcom_resume_irq() as the
> wakeup IRQs will only be enabled at the end of dwc3_qcom_suspend().
> 
> Note that the check should not be added to dwc3_qcom_is_host() function
> itself, as there is no provision to pass the context to callers.
> 
> Fixes: a872ab303d5d ("usb: dwc3: qcom: fix use-after-free on runtime-PM wakeup")

This is not the right fixes tag in any case as this layering violation
was first added by:

6895ea55c385 ("usb: dwc3: qcom: Configure wakeup interrupts during suspend")

which started accessing the dwc3 platform data and xhci host data from
the glue driver (and broke gadget mode).

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 959fc925ca7c..bbf67f705d0d 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -411,10 +411,11 @@ static void dwc3_qcom_enable_interrupts(struct dwc3_qcom *qcom)
>  
>  static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>  {
> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>  	u32 val;
>  	int i, ret;
>  
> -	if (qcom->is_suspended)
> +	if (qcom->is_suspended || !dwc)
>  		return 0;

I think we should try to keep the layering violations confined to the
helper functions. So how about amending dwc3_qcom_is_host() and check
for NULL before dereferencing the xhci pointer?

If the dwc3 driver hasn't probed yet, we're clearly not in host mode
either...

Johan
