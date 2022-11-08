Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAB4621199
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiKHM5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbiKHM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:57:40 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7812D14033;
        Tue,  8 Nov 2022 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667912258; x=1699448258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xSK23YgmWbIwWWCN8dNWUK/G0TelxDekE8oSOLxEO5o=;
  b=MqnOC1mKI3xQaATx1++88QHGg5Wy8o4d4t4iBN4XNpULW5HDV/Lnw2HD
   RkKQlicUnVGOJdy9qlWlR173jo1R8qTMx+SIUPPF1MrayW+W4YfD0ZRta
   Uq5jknvJw2dpWd6V/DWpIopunVJ6AJqhlM4B1uY+y5PwQcW7WCdGYkB16
   evdXBbjUOw+Yqb4WTck7Fica/4458H3cjxVlIrTvCT9Qjbrvyfy5h489i
   rkzh9qVdCZyHTq4N9KpVo/sUxLqibwW7S/hPdWVRn9qYQ7U1MkADsdQ7/
   oVtPiQWpEuWTjifXwHUQcQasm0mOJPFqIryAg8eX3/uoA/tYDoLVFNOQH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="310684135"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="310684135"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 04:57:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="669538018"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="669538018"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 08 Nov 2022 04:57:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1osOAY-0098S5-1J;
        Tue, 08 Nov 2022 14:57:34 +0200
Date:   Tue, 8 Nov 2022 14:57:34 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gilles BULOZ <gilles.buloz@kontron.com>
Subject: Re: [PATCH 1/1] serial: 8250_dma: Rearm DMA Rx if more data is
 pending
Message-ID: <Y2pSPspgnx+YkBJH@smile.fi.intel.com>
References: <20221107102126.56481-1-ilpo.jarvinen@linux.intel.com>
 <Y2jsqNHQ5KhYISb3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2jsqNHQ5KhYISb3@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:31:52PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 07, 2022 at 12:21:26PM +0200, Ilpo Järvinen wrote:

...

> Yep, I used to have something like draft of the below change locally.
> Thanks for putting it in shape and upstreamimg!
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> > -static void __dma_rx_complete(void *param)
> > +static void __dma_rx_complete(struct uart_8250_port *p)
> >  {
> > -	struct uart_8250_port	*p = param;
> >  	struct uart_8250_dma	*dma = p->dma;

Btw, looking into my patch in archives I noticed that dma can also be passed as
a parameter...

...

> > +static void dma_rx_complete(void *param)
> > +{
> > +	struct uart_8250_port *p = param;

> > +	struct uart_8250_dma *dma = p->dma;

...since you have it already here.

> > +	unsigned long flags;
> > +
> > +	__dma_rx_complete(p);

-- 
With Best Regards,
Andy Shevchenko


