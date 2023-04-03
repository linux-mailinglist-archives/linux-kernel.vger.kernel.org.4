Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F6B6D3CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 07:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjDCFnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 01:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjDCFnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 01:43:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ED449F3;
        Sun,  2 Apr 2023 22:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2847614B9;
        Mon,  3 Apr 2023 05:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D334FC433EF;
        Mon,  3 Apr 2023 05:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680500580;
        bh=ZupK0l3cB3VCTOwmj+1AJKB2C+iX2Q5daRefZNj6JU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jf9X8Y0weBEc6m6A1Ht/20AhuVQdHYBdvzi2qUXKOzq6UFkie9v/pRHrLB0SFIWq0
         gxiwtFlzUZVLTy1zqI8x5xL+5sHpQr/xDXNOxn5yu1moPheveSACLlfT+vNVMhyWVf
         vwPgwzI5S6I66cRMjbIIM9bEe4Dus+r4QfdPRzmA/bxr4tINX7YDwmFZRXxqMxzYg6
         h8zSEbOVt3LzWDHcuCoIDkh6tl1h9AAU8u8dBvqhpExWeGmtZ1x98Rstq5zmO+CxR9
         uMWB+thGQi0n2BI9oC5a3pJYV29FMcKZG6h/hvsN0XOExvhNgdJL8kCBZiV0Kv2KRy
         ssvnSDbwiMHtQ==
Date:   Mon, 3 Apr 2023 11:12:55 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bus: mhi: host: Use mhi_tryset_pm_state() for
 setting fw error state
Message-ID: <20230403054255.GJ4627@thinkpad>
References: <1674597444-24543-1-git-send-email-quic_jhugo@quicinc.com>
 <1674597444-24543-3-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1674597444-24543-3-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 02:57:24PM -0700, Jeffrey Hugo wrote:
> If firmware loading fails, the controller's pm_state is updated to
> MHI_PM_FW_DL_ERR unconditionally.  This can corrupt the pm_state as the
> update is not done under the proper lock, and also does not validate
> the state transition.  The firmware loading can fail due to a detected
> syserr, but if MHI_PM_FW_DL_ERR is unconditionally set as the pm_state,
> the handling of the syserr can break when it attempts to transition from
> syserr detect, to syserr process.
> 
> By grabbing the lock, we ensure we don't race with some other pm_state
> update.  By using mhi_try_set_pm_state(), we check that the transition
> to MHI_PM_FW_DL_ERR is valid via the state machine logic.  If it is not
> valid, then some other transition is occurring like syserr processing, and
> we assume that will resolve the firmware loading error.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

This looks like a legitimate fix. So please add the fixes tag and CC stable
for backporting (please add a hint on how far this patch has to be backported).

With that,

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>
> ---
>  drivers/bus/mhi/host/boot.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index 1c69fee..d2a19b07 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -391,6 +391,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  {
>  	const struct firmware *firmware = NULL;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	enum mhi_pm_state new_state;
>  	const char *fw_name;
>  	void *buf;
>  	dma_addr_t dma_addr;
> @@ -508,14 +509,18 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	}
>  
>  error_fw_load:
> -	mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
> -	wake_up_all(&mhi_cntrl->state_event);
> +	write_lock_irq(&mhi_cntrl->pm_lock);
> +	new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
> +	write_unlock_irq(&mhi_cntrl->pm_lock);
> +	if (new_state == MHI_PM_FW_DL_ERR)
> +		wake_up_all(&mhi_cntrl->state_event);
>  }
>  
>  int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
>  {
>  	struct image_info *image_info = mhi_cntrl->fbc_image;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> +	enum mhi_pm_state new_state;
>  	int ret;
>  
>  	if (!image_info)
> @@ -526,8 +531,11 @@ int mhi_download_amss_image(struct mhi_controller *mhi_cntrl)
>  			       &image_info->mhi_buf[image_info->entries - 1]);
>  	if (ret) {
>  		dev_err(dev, "MHI did not load AMSS, ret:%d\n", ret);
> -		mhi_cntrl->pm_state = MHI_PM_FW_DL_ERR;
> -		wake_up_all(&mhi_cntrl->state_event);
> +		write_lock_irq(&mhi_cntrl->pm_lock);
> +		new_state = mhi_tryset_pm_state(mhi_cntrl, MHI_PM_FW_DL_ERR);
> +		write_unlock_irq(&mhi_cntrl->pm_lock);
> +		if (new_state == MHI_PM_FW_DL_ERR)
> +			wake_up_all(&mhi_cntrl->state_event);
>  	}
>  
>  	return ret;
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
