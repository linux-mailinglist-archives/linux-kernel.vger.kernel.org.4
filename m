Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603D06A69D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCAJbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCAJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:31:12 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86BB3A85A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 01:31:04 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pXIne-0005xM-HZ; Wed, 01 Mar 2023 10:31:02 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pXIne-0004RG-47; Wed, 01 Mar 2023 10:31:02 +0100
Date:   Wed, 1 Mar 2023 10:31:02 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jindong Yue <jindong.yue@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, peng.fan@nxp.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        l.stach@pengutronix.de
Subject: Re: [PATCH v2 1/7] soc: imx: imx8mp-blk-ctrl: Use
 dev_pm_domain_attach_by_name
Message-ID: <20230301093102.f76wulx4mo7435qz@pengutronix.de>
References: <20230301030042.2357706-1-jindong.yue@nxp.com>
 <20230301030042.2357706-2-jindong.yue@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301030042.2357706-2-jindong.yue@nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the patch.

On 23-03-01, Jindong Yue wrote:
> The genpd_dev_pm_attach_by_name() is not exported, it should not be used
> by consumer driver.
> Use dev_pm_domain_attach_by_name() instead.

I'm not sure if this is the correct reason. If it wouldn't be allowed to
be used by consumers it would/should be private. Instead you should
mention here that you need the symbol for possible module builds. Same
applies to the other patches.

Regards,
  Marco

> 
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
> index a0592db8fa86..1892c2c78831 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -642,7 +642,7 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
>  	if (!bc->onecell_data.domains)
>  		return -ENOMEM;
>  
> -	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
> +	bc->bus_power_dev = dev_pm_domain_attach_by_name(dev, "bus");
>  	if (IS_ERR(bc->bus_power_dev))
>  		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
>  				     "failed to attach bus power domain\n");
> -- 
> 2.36.0
> 
> 
> 
