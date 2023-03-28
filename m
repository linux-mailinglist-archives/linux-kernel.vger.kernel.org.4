Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E501A6CCDE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjC1XJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjC1XJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:09:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7B02109;
        Tue, 28 Mar 2023 16:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=TtAWW+rcRDNEtRaY+5PARKcs7L5jYJy9Gvn5idod+V8=; b=T6qhdSfj75BjrmtNtqPQemMtTQ
        6UA+i8rTanrpWdnc/mgCBuuhh7AwBmjkiGbms4BD9FOndFiKjb6kA5WgXVXSgkpKwB2+sShQt/kb1
        XTRd7QAODPJSm656Vxq5sS1YT8vkGmqQ+sQB80d8+KKwLy7Hzee6ULrbQw7ggnyRnjvLPJXlXH4RW
        xcaosmceEBhUVbuYQQAO5urm238UFDRppDvfp2GJcnUBRTNDjWiFwjPTqSphvfRL57un/8zbOJKpc
        J4TriE2hqlL8eDhplEcKNh3khT12GSBI4NlmbSDLWMfCwdy3+iqBvLEGnYyRNFQlNnzTVC5x2woNL
        c4Fbj3+A==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phIRP-00G5fs-2c;
        Tue, 28 Mar 2023 23:09:23 +0000
Message-ID: <988d7f44-4c4a-982a-90a9-86fc10f2fc15@infradead.org>
Date:   Tue, 28 Mar 2023 16:09:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/msm/a6xx: add CONFIG_PM dependency
To:     Arnd Bergmann <arnd@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sean Paul <sean@poorly.run>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230324095502.3289094-1-arnd@kernel.org>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230324095502.3289094-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/23 02:54, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting CONFIG_PM_GENERIC_DOMAINS causes a build failure when CONFIG_PM
> is not enabled:
> 
> WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
>   Depends on [n]: PM [=n]
>   Selected by [m]:
>   - DRM_MSM [=m] && HAS_IOMEM [=y] && DRM [=m] && (ARCH_QCOM [=y] || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=y] || QCOM_OCMEM [=y]=n) && (QCOM_LLCC [=n] || QCOM_LLCC [=n]=n) && (QCOM_COMMAND_DB [=y] || QCOM_COMMAND_DB [=y]=n) && DEVFREQ_GOV_SIMPLE_ONDEMAND [=y]
> 
> drivers/base/power/domain.c:654:13: error: use of undeclared identifier 'pm_wq'
>         queue_work(pm_wq, &genpd->power_off_work);
>                    ^
> drivers/base/power/domain.c:853:26: error: no member named 'ignore_children' in 'struct dev_pm_info'
>                 if (!dev || dev->power.ignore_children)
>                             ~~~~~~~~~~ ^
> 
> Fixes: c11fa1204fe9 ("drm/msm/a6xx: Use genpd notifier to ensure cx-gdsc collapse")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpu/drm/msm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
> index 1c417ba53b5b..85f5ab1d552c 100644
> --- a/drivers/gpu/drm/msm/Kconfig
> +++ b/drivers/gpu/drm/msm/Kconfig
> @@ -9,6 +9,7 @@ config DRM_MSM
>  	depends on QCOM_OCMEM || QCOM_OCMEM=n
>  	depends on QCOM_LLCC || QCOM_LLCC=n
>  	depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
> +	depends on PM
>  	select IOMMU_IO_PGTABLE
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select REGULATOR

-- 
~Randy
