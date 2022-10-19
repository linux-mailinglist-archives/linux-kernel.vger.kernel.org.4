Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAD06044E3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiJSMRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiJSMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:17:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AE61C39DE;
        Wed, 19 Oct 2022 04:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666180392; x=1697716392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9lof7h+dJuOhTRYhOSVZmRonaoMBK895SVZFbgmQEpE=;
  b=myomo4VHr96geCM6QOq3UUqkc6sEHixhMDiSAH2sW8rwG2rFCMyfgWOo
   SU+WSm3GBtuhK63bLZVoj3b2OS2GTJNvrhtETcUHTRUTRf80s5A9bq2xt
   RuAPYDklS0HL6Z4L6PqjiWOJ+Z3UswVuFGN4Ae7gV923s0nCmDw6NN/Ti
   oYsaSZC47LtSf/8ZZXMgLD4ySq5Ik1Kh/m46psMZ9HGQAkcoyXhWojPu/
   QZTscY3BO5pjhV9G55x5Lp2p6zaxCAQOVs6T85g+2QvFawXKUNx/UvhRV
   MNmy1t2bZJV6zhSUEc30ReinJJP7Ef+jE9H12eym7gvG7kKWYtnpJFdPl
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="305113736"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="305113736"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 04:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="698023575"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="698023575"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2022 04:10:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ol6xj-009p8g-1K;
        Wed, 19 Oct 2022 14:10:15 +0300
Date:   Wed, 19 Oct 2022 14:10:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/44] serial: max310x: Use uart_xmit_advance()
Message-ID: <Y0/bF886gWZOXh9X@smile.fi.intel.com>
References: <20221019091151.6692-1-ilpo.jarvinen@linux.intel.com>
 <20221019091151.6692-22-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019091151.6692-22-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:11:28PM +0300, Ilpo Järvinen wrote:
> Take advantage of the new uart_xmit_advance() helper.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/max310x.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index fbf6e2b3161c..4eb24e3407f8 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -787,10 +787,7 @@ static void max310x_handle_tx(struct uart_port *port)
>  		} else {
>  			max310x_batch_write(port, xmit->buf + xmit->tail, to_send);
>  		}
> -
> -		/* Add data to send */
> -		port->icount.tx += to_send;
> -		xmit->tail = (xmit->tail + to_send) & (UART_XMIT_SIZE - 1);
> +		uart_xmit_advance(port, to_send);
>  	}
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> -- 
> 2.30.2
> 

-- 
With Best Regards,
Andy Shevchenko


