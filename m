Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D576CA142
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbjC0KYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbjC0KYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:24:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9D95584;
        Mon, 27 Mar 2023 03:24:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 812F9B80EAC;
        Mon, 27 Mar 2023 10:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DDAC433D2;
        Mon, 27 Mar 2023 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679912650;
        bh=hcQE71Jvx8KIyqm7WTbycXq2YmJt3VrPaHDQ+soP+t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByNXDIp1IsDxJc902OilRAg5Kz+6s2qF1EUalQPyHqIC5vJhNHk8Wg9EUd8a2OwAt
         l75zb3zgsMRrzLR1azq24o2dlRYXLamzsIHOmG5wuT/DQioCEuNvcUU8rteZ8BO9wE
         sg91VzCWrqqWyT7sjYNoD9J21G3TvtQkPOecuz5k82WywAA319o7sHqmMNLN/7f9Iy
         Kdjmj0q+/oyNHVK1odjwfc4B0MeJC1LKDxN4pK7v12Lp9gJ/zdtmxXadbySekktqOl
         l9ET+OhVYJnJKRBeka4++syR2XBbfGxQtUvFyKFwshkmbDSdxlc2QWuM/Ny8Tj6h3u
         yGfyX8Lc4uYaw==
Date:   Mon, 27 Mar 2023 15:53:58 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mhi: host: Use ERANGE for BHIOFF/BHIEOFF range check
Message-ID: <20230327102358.GD16424@thinkpad>
References: <1679674860-28229-1-git-send-email-quic_jhugo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1679674860-28229-1-git-send-email-quic_jhugo@quicinc.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 10:21:00AM -0600, Jeffrey Hugo wrote:
> If the BHIOFF or BHIEOFF range checks fail, they return EINVAL.  ERANGE
> is a better error code since it implies an out of range condition.
> 
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
> 
> This feels more like a style change than fixing a bug, so I'm being
> conservative and intentionally not listing a fixes tag.
> 
>  drivers/bus/mhi/host/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> index b46a082..f72fcb6 100644
> --- a/drivers/bus/mhi/host/init.c
> +++ b/drivers/bus/mhi/host/init.c
> @@ -1112,7 +1112,7 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  	if (bhi_off >= mhi_cntrl->reg_len) {
>  		dev_err(dev, "BHI offset: 0x%x is out of range: 0x%zx\n",
>  			bhi_off, mhi_cntrl->reg_len);
> -		ret = -EINVAL;
> +		ret = -ERANGE;
>  		goto error_reg_offset;
>  	}
>  	mhi_cntrl->bhi = mhi_cntrl->regs + bhi_off;
> @@ -1129,7 +1129,7 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  			dev_err(dev,
>  				"BHIe offset: 0x%x is out of range: 0x%zx\n",
>  				bhie_off, mhi_cntrl->reg_len);
> -			ret = -EINVAL;
> +			ret = -ERANGE;
>  			goto error_reg_offset;
>  		}
>  		mhi_cntrl->bhie = mhi_cntrl->regs + bhie_off;
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
