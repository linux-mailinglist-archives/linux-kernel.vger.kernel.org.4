Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72365EF3B4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiI2Kvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiI2Kvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:51:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83D5E4DB8;
        Thu, 29 Sep 2022 03:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664448709; x=1695984709;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OjqXha7OWcOpKVrRMhyKCiuZBMopPtiGq2YzTsjq/9I=;
  b=PnMEbXxZ5PPazsjAYFB57MZi2f3pHm9+/42DnXrPh+uE/qtVz4Zp+sVD
   Ruf694QaWZMM7Yx3Ng3V7VaPZp5gUM12k1N3R0lg3zRDuNQJmFbVSanUW
   NZCn2Me/IMjQElyD9wqN/PuENpmHcsifOKPvl8lIwN19LpoGsgDTHX3zF
   XSD+IkRSNWWitoiCD+X4SWennCG9w9wi5Gwh5xrzWANJuAFCS2cgm8YAp
   CbF6Z5Bao0SsCh5xEXSKNjouDmxLL+y+kl0sZssPzGwFye3K+nYjLgSJW
   wH8W7fHtOZ4VQ/21L4ZRaJtmW98LT+JwHmqMD8hNwyWqfSf24ACSr9EO2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="301834595"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="301834595"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 03:51:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="624518459"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="624518459"
Received: from pramona-mobl1.ger.corp.intel.com ([10.252.60.139])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 03:51:46 -0700
Date:   Thu, 29 Sep 2022 13:51:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Subject: Re: [PATCH] Revert "serial: fsl_lpuart: Reset prior to
 registration"
In-Reply-To: <20220929085318.5268-1-sherry.sun@nxp.com>
Message-ID: <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022, Sherry Sun wrote:

> This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> 
> commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration")
> causes the lpuart console cannot work any more. Since the console is
> registered in the uart_add_one_port(), the driver cannot identify the
> console port before call uart_add_one_port(), which causes all the uart
> ports including the console port will be global reset.
> So need to revert this patch to avoid breaking the lpuart console.
> 
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 67fa113f77d4..7da46557fcb3 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2722,10 +2722,6 @@ static int lpuart_probe(struct platform_device *pdev)
>  		handler = lpuart_int;
>  	}
>  
> -	ret = lpuart_global_reset(sport);
> -	if (ret)
> -		goto failed_reset;
> -

So the problem with this being so early is uart_console() in 
lpuart_global_reset() that doesn't detect a console because sport->cons is 
not yet assigned? Couldn't that be worked around differently?

Or is there something else in addition to that I'm missing?

-- 
 i.

