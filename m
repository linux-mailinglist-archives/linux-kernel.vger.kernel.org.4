Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3496044E8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiJSMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJSMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:17:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71C18E10;
        Wed, 19 Oct 2022 04:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666180400; x=1697716400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=anzZUGCfTwAlBfRA91Aooisw1s4dE8/imhQ0dPjnDfo=;
  b=QQk3HaPhrenq6PrnRE+o7sSp4fQ6BsDNvx+z7S0iIu6tzyhETuNFb1bC
   aBS8Sl9ei6Gm1Zr8a9lpb3NxZWrQ8Q+bcuPlrnQSw+alEMf1N1MjtlJ8Z
   3k3ce1JhKDoBWae+d475r9STLGgn+pj5XuPdRDXaj+z6YEIkOsTQpM68i
   /OsjQnCOoOOVl5q1kijMs7zNWCZ1+/QujbubAkWornFHynOFpVpgMeDxk
   PXRWhQ89unoNAoR/goyge57doHCBOPwu+AbJweu0qojohfQ+kF6vY5QEx
   iK+41AaMi0Dsz3PfOe9G6zYe8bQRss2cXeCB1d0jrPkFPzXr03axnXezp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="305114287"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305114287"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 04:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="958287210"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="958287210"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 19 Oct 2022 04:12:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol707-009pCY-12;
        Wed, 19 Oct 2022 14:12:43 +0300
Date:   Wed, 19 Oct 2022 14:12:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/44] serial: 8250: Use uart_xmit_advance()
Message-ID: <Y0/bq/CySLFjFRAl@smile.fi.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-8-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019091151.6692-8-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:11:14PM +0300, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index fe8662cd9402..b94e60e75326 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1842,8 +1842,7 @@ void serial8250_tx_chars(struct uart_8250_port *up)
>  			 */
>  			serial_in(up, UART_SCR);
>  		}
> -		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> -		port->icount.tx++;
> +		uart_xmit_advance(port, 1);
>  		if (uart_circ_empty(xmit))
>  			break;
>  		if ((up->capabilities & UART_CAP_HFIFO) &&
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


