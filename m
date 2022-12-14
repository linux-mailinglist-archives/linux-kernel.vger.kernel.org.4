Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB164C868
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 12:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiLNLu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 06:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238006AbiLNLu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 06:50:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD76F4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 03:50:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF51B81699
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 11:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22861C433EF;
        Wed, 14 Dec 2022 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671018622;
        bh=+zUK+5Ccx7OA/sbrGTpucZaSMPnJKac+XaPp6XkqbTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JbYjaOMAjlb8oZBIOdRhyCLIaXubCjKes+Gs7fA61EPqRAsT5WNRtEiQ8A/mOeIZu
         f3PqFP7uTZL/8Kg+f2GTJ32Ka62MwDrPJxU9nX2u5VoQVprNVXYVGgTxgDbKztO+80
         f7bty+w783UC1Dost6uGY307xF4YjASg10pnUWkE=
Date:   Wed, 14 Dec 2022 12:50:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: Re: staging: vme_user: Replace the "<<" with BIT macro
Message-ID: <Y5m4e3+ZZ+mxQEBP@kroah.com>
References: <Y5m1CvaAc2Z8LO2k@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5m1CvaAc2Z8LO2k@li-27defe4c-32e1-11b2-a85c-e202e9981075.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 05:05:38PM +0530, Abhirup Deb wrote:
> Replace the "<<" operator with BIT macro, in accordance to the
> checkpatch.pl script and Linux kernel coding-style guidelines.
> Issues reported by checkpatch.pl:
> 	CHECK: Prefer using the BIT macro
> 
> Signed-off-by: Abhirup Deb <abhirupdeb@linux.vnet.ibm.com>
> ---
>  drivers/staging/vme_user/vme.h | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
> index 98da8d039d60..faa9816046a9 100644
> --- a/drivers/staging/vme_user/vme.h
> +++ b/drivers/staging/vme_user/vme.h
> @@ -2,6 +2,8 @@
>  #ifndef _VME_H_
>  #define _VME_H_
>  
> +#include <linux/bitops.h>
> +
>  /* Resource Type */
>  enum vme_resource_type {
>  	VME_MASTER,
> @@ -54,20 +56,20 @@ enum vme_resource_type {
>  #define VME_R_ROBIN_MODE	0x1
>  #define VME_PRIORITY_MODE	0x2
>  
> -#define VME_DMA_PATTERN			(1<<0)
> -#define VME_DMA_PCI			(1<<1)
> -#define VME_DMA_VME			(1<<2)
> +#define VME_DMA_PATTERN		BIT(0)
> +#define VME_DMA_PCI			BIT(1)
> +#define VME_DMA_VME			BIT(2)
>  
> -#define VME_DMA_PATTERN_BYTE		(1<<0)
> -#define VME_DMA_PATTERN_WORD		(1<<1)
> -#define VME_DMA_PATTERN_INCREMENT	(1<<2)
> +#define VME_DMA_PATTERN_BYTE		BIT(0)
> +#define VME_DMA_PATTERN_WORD		BIT(1)
> +#define VME_DMA_PATTERN_INCREMENT	BIT(2)
>  
> -#define VME_DMA_VME_TO_MEM		(1<<0)
> -#define VME_DMA_MEM_TO_VME		(1<<1)
> -#define VME_DMA_VME_TO_VME		(1<<2)
> -#define VME_DMA_MEM_TO_MEM		(1<<3)
> -#define VME_DMA_PATTERN_TO_VME		(1<<4)
> -#define VME_DMA_PATTERN_TO_MEM		(1<<5)
> +#define VME_DMA_VME_TO_MEM		BIT(0)
> +#define VME_DMA_MEM_TO_VME		BIT(1)
> +#define VME_DMA_VME_TO_VME		BIT(2)
> +#define VME_DMA_MEM_TO_MEM		BIT(3)
> +#define VME_DMA_PATTERN_TO_VME		BIT(4)
> +#define VME_DMA_PATTERN_TO_MEM		BIT(5)
>  
>  struct vme_dma_attr {
>  	u32 type;
> -- 
> 2.31.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
