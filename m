Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73C362D62D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiKQJNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbiKQJNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:13:33 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E72B197
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:13:28 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ovaxP-0005PI-W9; Thu, 17 Nov 2022 10:13:16 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ovaxP-0007Fb-E1; Thu, 17 Nov 2022 10:13:15 +0100
Date:   Thu, 17 Nov 2022 10:13:15 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH] ARM: mxs: fix memory leak in mxs_machine_init()
Message-ID: <20221117091315.wwojwl7vhp43k63v@pengutronix.de>
References: <20221117062011.84602-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117062011.84602-1-zhengyongjun3@huawei.com>
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

On 22-11-17, Zheng Yongjun wrote:
> If of_property_read_string() failed, 'soc_dev_attr' should be
> freed before return. Otherwise there is a memory leak.
> 
> Fixes: 2046338dcbc6 ("ARM: mxs: Use soc bus infrastructure")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  arch/arm/mach-mxs/mach-mxs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index 25c9d184fa4c..1c57ac401649 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -393,8 +393,10 @@ static void __init mxs_machine_init(void)
> 
>  	root = of_find_node_by_path("/");
>  	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
> -	if (ret)
> +	if (ret) {
> +		kfree(soc_dev_attr);
>  		return;
> +	}
> 
>  	soc_dev_attr->family = "Freescale MXS Family";
>  	soc_dev_attr->soc_id = mxs_get_soc_id();
> --
> 2.17.1
> 
> 
> 
