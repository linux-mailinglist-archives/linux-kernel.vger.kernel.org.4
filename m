Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887635B68C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 09:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiIMHj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 03:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIMHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 03:39:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C564F2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ti8c823NopLlwRG+ncpb0fxu6N8C0vk3Ny10bJFiLBI=; b=lcyq30Uf8aui/bAWcaBMZR/Wd1
        A4N7kf99PfwF7DdjBqL8PWMlQR2HZap98jVwfkTmerZcRZx3+OjQ2GVraaq5EcFD7jtFpz/9bw8mQ
        p1wqUouhHYRRSLIzxmCY8xlV3+Jz3kmFiMAoyH5Qvrq+u67GOa2apJAMUvc8ojWjistszH+ssHD8b
        OhYKFjdRsOJbnR6UoUmgLr7b7n3xPbz7aEIG4q9QphCkXDSqFurNa7DW1+UbneUTputdvK0zQrk9a
        RXUjckN38lprQ07bAATijfl+MIaxug0sfaz9GjxzXS6GzzFYaiEvM5XFtPKgnBUKQtYdg7OBMhZ63
        j/IAav5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34282)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oY0W4-0002ZG-2w; Tue, 13 Sep 2022 08:39:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oY0W2-0000VT-Tu; Tue, 13 Sep 2022 08:39:30 +0100
Date:   Tue, 13 Sep 2022 08:39:30 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx: fix error check in imx8mp_blk_ctrl_probe()
Message-ID: <YyAzsl72LzMTdoDF@shell.armlinux.org.uk>
References: <20220913073434.7252-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913073434.7252-1-tangbin@cmss.chinamobile.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 03:34:34PM +0800, Tang Bin wrote:
> In the function imx8mp_blk_ctrl_probe(),
> dev_pm_domain_attach_by_name() may return NULL in some cases,
> so IS_ERR() doesn't meet the requirements. Thus fix it.
> 
> Fixes: 556f5cf9568a ("soc: imx: add i.MX8MP HSIO blk-ctrl")
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
> index ccb30c6cd..ed8557eaf 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -597,11 +597,11 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
>  
>  		domain->power_dev =
>  			dev_pm_domain_attach_by_name(dev, data->gpc_name);
> -		if (IS_ERR(domain->power_dev)) {
> +		if (IS_ERR_OR_NULL(domain->power_dev)) {
>  			dev_err_probe(dev, PTR_ERR(domain->power_dev),
>  				      "failed to attach power domain %s\n",
>  				      data->gpc_name);
> -			ret = PTR_ERR(domain->power_dev);
> +			ret = PTR_ERR(domain->power_dev) ? : -ENODATA;
>  			goto cleanup_pds;
>  		}
>  		dev_set_name(domain->power_dev, "%s", data->name);

Checking for NULL in this case is likely a good idea, as if
domain->power_dev is NULL, then dev_set_name() will probably oops the
kernel. Whether returning -ENODATA and causing a failure, or whether
moving on to the next domain is a question that the maintainers of
this code need to answer, bearing in mind that NULL here means that
the device doesn't need a power domain.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
