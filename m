Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCB70635B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjEQIx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjEQIxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:53:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA930FA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 117BA643FD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:53:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D3AC433D2;
        Wed, 17 May 2023 08:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684313628;
        bh=bx2DZ08RgdjyeJPrV1iQtRzHClXNmleIF5bL7VOMB4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0UOo0N7XzWHBQ6poTKB922Rq8dxa2N4lKoeQsuONCZ/KLQIyS7tmJnItZvBIRVr78
         wJjs4DtpX0MaYGXsrqrTOa6PbcCUUfuFOyR14sZ1wGYZ/Ua25HS7xIE+mYvc4eCiUE
         BkpjoS6PfBKz+T+RO0MFlZ9EjsjmJW/iEIp2oJvU=
Date:   Wed, 17 May 2023 10:53:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     nikhil.agarwal@amd.com, Nipun.Gupta@amd.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com
Subject: Re: [PATCH 1/1] cdx: Rename MCDI_LOGGING to CDX_MCDI_LOGGING
Message-ID: <2023051703-evident-repaint-52c9@gregkh>
References: <20230517084404.187463-1-abhijit.gangurde@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517084404.187463-1-abhijit.gangurde@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:14:03PM +0530, Abhijit Gangurde wrote:
> MCDI_LOGGING is too generic considering other MCDI users
> SFC_MCDI_LOGGING and SFC_SIENA_MCDI_LOGGING. Rename it to
> CDX_MCDI_LOGGING makes it more domain specific.
> 
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/cdx/controller/Kconfig |  2 +-
>  drivers/cdx/controller/mcdi.c  | 16 ++++++++--------
>  drivers/cdx/controller/mcdi.h  |  2 +-
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cdx/controller/Kconfig b/drivers/cdx/controller/Kconfig
> index c3e3b9ff8dfe..e7014e9819ea 100644
> --- a/drivers/cdx/controller/Kconfig
> +++ b/drivers/cdx/controller/Kconfig
> @@ -18,7 +18,7 @@ config CDX_CONTROLLER
>  
>  	  If unsure, say N.
>  
> -config MCDI_LOGGING
> +config CDX_MCDI_LOGGING

This is fine, but:

>  	bool "MCDI Logging for the CDX controller"
>  	depends on CDX_CONTROLLER
>  	help
> diff --git a/drivers/cdx/controller/mcdi.c b/drivers/cdx/controller/mcdi.c
> index a211a2ca762e..3a1fbc3d409e 100644
> --- a/drivers/cdx/controller/mcdi.c
> +++ b/drivers/cdx/controller/mcdi.c
> @@ -31,7 +31,7 @@ struct cdx_mcdi_copy_buffer {
>  	struct cdx_dword buffer[DIV_ROUND_UP(MCDI_CTL_SDU_LEN_MAX, 4)];
>  };
>  
> -#ifdef CONFIG_MCDI_LOGGING
> +#ifdef CONFIG_CDX_MCDI_LOGGING
>  #define LOG_LINE_MAX		(1024 - 32)
>  #endif
>  
> @@ -119,7 +119,7 @@ int cdx_mcdi_init(struct cdx_mcdi *cdx)
>  	mcdi = cdx_mcdi_if(cdx);
>  	mcdi->cdx = cdx;
>  
> -#ifdef CONFIG_MCDI_LOGGING
> +#ifdef CONFIG_CDX_MCDI_LOGGING
>  	mcdi->logging_buffer = kmalloc(LOG_LINE_MAX, GFP_KERNEL);
>  	if (!mcdi->logging_buffer)
>  		goto fail2;

This mess of #ifdef in the .c files is not ok.

Please move all of this "logging" stuff out into proper .h definitions
so that it's not in the .c code at all.

thanks,

greg k-h
