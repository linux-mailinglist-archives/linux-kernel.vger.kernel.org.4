Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F89605499
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJTAvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJTAvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:51:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F02140E7B;
        Wed, 19 Oct 2022 17:51:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0143161846;
        Thu, 20 Oct 2022 00:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC6EC433C1;
        Thu, 20 Oct 2022 00:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666227093;
        bh=+TEDTEQh8wfO5ZvO5TOR+gKPPLDgjveN6xby83dLwgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ln+P9ANNtDhLdvHjiZsF4YPLsOfH3kYDNkdMiNnZ9z60VCuRxERbRNyaZfyjJ+gOX
         7Uqkm6/o5HjCV1Ld3HJALGe3/FaHhlAQR6fcsmxyzhJMp3OruTs/QF03S+e4DnBJcZ
         S1AS6OvvnWNhpoPYs8feBQnKy4Etphzl8JTVxdzAo1hFW3jDjg2j4CqiD4v9prDLmK
         xtSLl634x0fpgg2HNEhJImALz54SJHLUPRaE90ALBko5aPHbc3A9T0kn+/+HN047E+
         HpSXYgkbzu690CEFVnhYQWgDo+JzSqj64016gHtfF2iaHswrtFkGArHIyF89sBlOuE
         iHCB+D/VPgABg==
Date:   Wed, 19 Oct 2022 19:51:30 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: [PATCH 1/2] venus: kconfig: Fix compile-testing on x86 platforms
Message-ID: <20221020005130.w633hs5pnnwxxkpp@builder.lan>
References: <20220713110351.827446-1-stanimir.varbanov@linaro.org>
 <20220713110351.827446-2-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713110351.827446-2-stanimir.varbanov@linaro.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:03:50PM +0300, Stanimir Varbanov wrote:
> Fix Venus driver COMPILE_TEST compilation on x86 platform by
> adding a dependacy on V4L_PLATFORM_DRIVERS and select QCOM_SMEM
> instead of depending on it.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
> index bfd50e8f3421..95814b175c3e 100644
> --- a/drivers/media/platform/qcom/venus/Kconfig
> +++ b/drivers/media/platform/qcom/venus/Kconfig
> @@ -1,12 +1,14 @@
>  config VIDEO_QCOM_VENUS
>  	tristate "Qualcomm Venus V4L2 encoder/decoder driver"
> +	depends on V4L_PLATFORM_DRIVERS
>  	depends on V4L_MEM2MEM_DRIVERS
> -	depends on VIDEO_DEV && QCOM_SMEM
> +	depends on VIDEO_DEV
>  	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select QCOM_SCM
>  	select VIDEOBUF2_DMA_CONTIG
>  	select V4L2_MEM2MEM_DEV
> +	select QCOM_SMEM

QCOM_SMEM is user selectable, and it's a fairly broadly used API. So I
would prefer that we introduce stub functions in linux/soc/qcom/smem.h.

Regards,
Bjorn

>  	help
>  	  This is a V4L2 driver for Qualcomm Venus video accelerator
>  	  hardware. It accelerates encoding and decoding operations
> -- 
> 2.25.1
> 
