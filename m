Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8BE611949
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJ1R2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJ1R2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:28:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D29C1DD8BB;
        Fri, 28 Oct 2022 10:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A142629DD;
        Fri, 28 Oct 2022 17:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C145C433D6;
        Fri, 28 Oct 2022 17:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666978124;
        bh=jT5rZEE6y+PXjgFd1192RTwBkHZ3W7K2exfQwkqp5s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkfovKxxnRrnYNPYtCgcC6ZmL3f/A2ILV5eU7Hh1LkxQReOWtQuX1z90izLuCmwVq
         xj6vW74Ka82Z44L5TxRJ6f4gkarToWZM5GM3aG+6oa3GZaDg1r8nABS/C477isWyjG
         xQumJbfCp5jvRDUgS3Xn2mQSVHxIMmNMWtiFilo7cRQnlU80v0H3rdFkl/vkaA1nyh
         G5isAcpzgySvfDjQZh6WoRMNAqeNSue2mnImsxArRJaN8CtxKZZmftcwl7V8x8lun0
         icpmpqdI2cs5wbRjadXUTDT56S3xayy2viy9D82KRcxVn0jkskp3vy8PPttC1xPrLb
         kWLtL+tfCeTHQ==
Date:   Fri, 28 Oct 2022 22:58:36 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     quic_hemantk@quicinc.com, loic.poulain@linaro.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        mrana@quicinc.com
Subject: Re: [PATCH] bus: mhi: host: Use mhi_soc_reset() API in place of
 register write
Message-ID: <20221028172836.GF13880@thinkpad>
References: <1665376324-34258-1-git-send-email-quic_qianyu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1665376324-34258-1-git-send-email-quic_qianyu@quicinc.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:32:04PM +0800, Qiang Yu wrote:
> Currently, a direct register write is used when ramdump collection
> in panic path occurs. Replace that with new mhi_soc_reset() API
> such that a controller defined reset() function is exercised if
> one is present and the regular SOC reset is done if it is not.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/host/boot.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index 26d0edd..1c69fee 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -118,9 +118,7 @@ static int __mhi_download_rddm_in_panic(struct mhi_controller *mhi_cntrl)
>  			/* Hardware reset so force device to enter RDDM */
>  			dev_dbg(dev,
>  				"Did not enter RDDM, do a host req reset\n");
> -			mhi_write_reg(mhi_cntrl, mhi_cntrl->regs,
> -				      MHI_SOC_RESET_REQ_OFFSET,
> -				      MHI_SOC_RESET_REQ);
> +			mhi_soc_reset(mhi_cntrl);
>  			udelay(delayus);
>  		}
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
மணிவண்ணன் சதாசிவம்
