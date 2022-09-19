Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83355BD599
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiISURy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiISURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:17:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3524333A;
        Mon, 19 Sep 2022 13:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4ABEAB8116D;
        Mon, 19 Sep 2022 20:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FDCC433D6;
        Mon, 19 Sep 2022 20:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663618662;
        bh=eLnSfNg94p3dmevcszHxKEUBtga5UOC1oT5V7Ff96ic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AnmhoQiqIWssaceXNzxDmMLpVCMK+Wn2cIOPOF542JbKO4urTK9eJf3vQnBnSsJRt
         JkOjNMaUaIEL6wawwBZD4Mun1WuZj34fcvRZZg4Gv6bWDk2kqU4qPTOJFsh6zHK2+v
         wbJePqHOOBa0+U5kvmSKqYVHyt65OzP2BUMXefVRtWkOagBc1mFloSZ+EG9aKLRmP8
         DG6GuUW7T0uKyuMRe/rfRinszwIqwSRcB+WO+5CJOElakfMb2DUJ2WjzB3IMPVbmpM
         P0HAxbf6OMkTdzD/wnZarPq1Xdube0eB7IQW42DmXgzMCaVInYCQJ3+NoPcF0CSvQh
         q4DnDFqw5WMMw==
Date:   Mon, 19 Sep 2022 15:17:38 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bryan.odonoghue@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom: tsens-v0_1: Fix MSM8939 fourth sensor
 hw_id
Message-ID: <20220919201738.wkdzizmj5lhq2hk2@builder.lan>
References: <20220811105014.7194-1-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811105014.7194-1-vincent.knecht@mailoo.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 12:50:14PM +0200, Vincent Knecht wrote:
> Reading temperature from this sensor fails with 'Invalid argument'.
> 
> Looking at old vendor dts [1], its hw_id should be 3 instead of 4.
> Change this hw_id accordingly.
> 
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/master/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L511
> 
> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for MSM8939")
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
> Fixes reading GPU temperature on msm8939 idol3 with current WIP dtsi
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index f136cb350238..327f37202c69 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -604,7 +604,7 @@ static const struct tsens_ops ops_8939 = {
>  struct tsens_plat_data data_8939 = {
>  	.num_sensors	= 10,
>  	.ops		= &ops_8939,
> -	.hw_ids		= (unsigned int []){ 0, 1, 2, 4, 5, 6, 7, 8, 9, 10 },
> +	.hw_ids		= (unsigned int []){ 0, 1, 2, 3, 5, 6, 7, 8, 9, 10 },
>  
>  	.feat		= &tsens_v0_1_feat,
>  	.fields	= tsens_v0_1_regfields,
> -- 
> 2.37.1
> 
> 
> 
