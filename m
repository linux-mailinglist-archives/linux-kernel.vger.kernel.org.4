Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB276E5B95
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjDRIGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjDRIF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01E072BA;
        Tue, 18 Apr 2023 01:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AC8B62E54;
        Tue, 18 Apr 2023 08:04:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120D8C433EF;
        Tue, 18 Apr 2023 08:04:14 +0000 (UTC)
Message-ID: <695e9f88-5a79-7ca4-645f-047b78495a80@xs4all.nl>
Date:   Tue, 18 Apr 2023 10:04:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: nxp: ignore unused suspend operations
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Guoniu Zhou <guoniu.zhou@nxp.com>,
        Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230418071605.2971866-1-arnd@kernel.org>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230418071605.2971866-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 18/04/2023 09:15, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about some functions being unused when CONFIG_PM is
> disabled:

???

The Kconfig has a:

        depends on HAS_DMA && PM

So how can this be compiled with CONFIG_PM not set?

Am I missing something?

	Hans

> 
> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:328:12: error: 'mxc_isi_pm_resume' defined but not used [-Werror=unused-function]
>   328 | static int mxc_isi_pm_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~
> drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c:314:12: error: 'mxc_isi_pm_suspend' defined but not used [-Werror=unused-function]
>   314 | static int mxc_isi_pm_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~
> 
> Use the modern SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers in place
> of the old SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS() ones, and add
> a pm_ptr() check to ensure they get dropped by the compiler.
> 
> Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> index 238521622b75..253e77189b69 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> @@ -378,8 +378,8 @@ static int mxc_isi_runtime_resume(struct device *dev)
>  }
>  
>  static const struct dev_pm_ops mxc_isi_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(mxc_isi_pm_suspend, mxc_isi_pm_resume)
> -	SET_RUNTIME_PM_OPS(mxc_isi_runtime_suspend, mxc_isi_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(mxc_isi_pm_suspend, mxc_isi_pm_resume)
> +	RUNTIME_PM_OPS(mxc_isi_runtime_suspend, mxc_isi_runtime_resume, NULL)
>  };
>  
>  /* -----------------------------------------------------------------------------
> @@ -528,7 +528,7 @@ static struct platform_driver mxc_isi_driver = {
>  	.driver = {
>  		.of_match_table = mxc_isi_of_match,
>  		.name		= MXC_ISI_DRIVER_NAME,
> -		.pm		= &mxc_isi_pm_ops,
> +		.pm		= pm_ptr(&mxc_isi_pm_ops),
>  	}
>  };
>  module_platform_driver(mxc_isi_driver);

