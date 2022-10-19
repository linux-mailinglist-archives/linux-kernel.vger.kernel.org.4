Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7E0604368
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJSLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiJSLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:37:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F21108273;
        Wed, 19 Oct 2022 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178121; x=1697714121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IM/miqYiKsUKovYDNaQ0wtYbr7tjTO2nvi5P+UfcMOA=;
  b=gynb6KYtZQiEjGcaaJ5vMLqVPuAm7bB5tayluvB5ejyQDlX9sMli+bT8
   W9fQbIOei4OYqHNfNRZeNBTwd02NGtz5Jii+o7fk5ULYi2RIbyzYKei5n
   5r3IJ+brDETCq+FlW2grk39pA3CNj0Vpwk1BZhlJ+2sTGTiSeC4otVZ96
   SbRm5onEvO9ZWe8eY6NOX0c+KbL8/FZILeNFPQltBdIpRNowgZfFMMe3t
   Gff8Md2nGF6fsjHW4pqFAQGarY7RFTEQdmmcjWJ4DtUrK3eV9VD0SMk79
   XE1tBhZSf8+gmorUTfDXxYWLsC1jlOB1YBL70o2FqfRisx11S/7fBwxx2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="303996254"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="303996254"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 04:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="580289133"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="580289133"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2022 04:11:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol6yz-009pAZ-2E;
        Wed, 19 Oct 2022 14:11:33 +0300
Date:   Wed, 19 Oct 2022 14:11:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/44] serial: sc16is7xx: Use uart_xmit_advance()
Message-ID: <Y0/bZV/fdrqVcWqt@smile.fi.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019091151.6692-6-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:11:12PM +0300, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/sc16is7xx.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index 524921360ca7..39f92eb1e698 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -686,13 +686,10 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
>  		}
>  		to_send = (to_send > txlen) ? txlen : to_send;
>  
> -		/* Add data to send */
> -		port->icount.tx += to_send;
> -
>  		/* Convert to linear buffer */
>  		for (i = 0; i < to_send; ++i) {
>  			s->buf[i] = xmit->buf[xmit->tail];
> -			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +			uart_xmit_advance(port, 1);
>  		}
>  
>  		sc16is7xx_fifo_write(port, to_send);
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


