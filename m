Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06B45B6A91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiIMJUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiIMJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:20:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B93140A7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:20:04 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1oY25I-0001Z1-22; Tue, 13 Sep 2022 11:20:00 +0200
Message-ID: <6b070f8d-83aa-e816-6c1c-0d084888f9da@pengutronix.de>
Date:   Tue, 13 Sep 2022 11:19:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Defer probe if 'bus' genpd is
 not yet ready
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220913090655.39778-1-benjamin.gaignard@collabora.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220913090655.39778-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Benjamin,

On 13.09.22 11:06, Benjamin Gaignard wrote:
> Depending of the boot sequence 'bus' genpd could be probed after imx8m-blk-ctrl
> which led driver probe to fail. Change the returned error to allow
> to defer the probe in this case.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/soc/imx/imx8m-blk-ctrl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index dff7529268e4..99f5226a465b 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -215,8 +215,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
>  
>  	bc->bus_power_dev = genpd_dev_pm_attach_by_name(dev, "bus");
>  	if (IS_ERR(bc->bus_power_dev))
> -		return dev_err_probe(dev, PTR_ERR(bc->bus_power_dev),
> -				     "failed to attach power domain \"bus\"\n");
> +		return -EPROBE_DEFER;

If probe is deferred indefinitely, you lose the very helpful probe error message.
Please translate error code instead and keep the dev_err_probe call.

Cheers,
Ahmad

>  
>  	for (i = 0; i < bc_data->num_domains; i++) {
>  		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
