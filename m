Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25AB5E651D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiIVOZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiIVOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:25:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618D158DC9;
        Thu, 22 Sep 2022 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663856700; x=1695392700;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ARk50nWXWyObGidZckz6eAqj0QSirGWy2R8pPXJ1WXI=;
  b=Ev9XQtrtJuD/Ct5WGbnOo6HoOAbO1v6zLPSJKt3PW+NH2MBqO4CZ4603
   bOCU3a5gtteSWa0wx7RtqA5b87ppjF4GHauiVdiDEu3AAA3q0YVI0xQZh
   dWtxyvFtp4g69v/1fO7xhdBj+wN3XSIfmYYMCSJCas1ydu3DzquQhrQM+
   pSP33+peiKafsDjUhFL31Coho3YjLyeb8Y9leFZFo7Muzhb0GXT29ajgZ
   P3jlifkHv5Jar3p1qeU4a7O+9Cn9Fg6uhwfwpp5zA0NWTmvBoL/K4BQVJ
   PMYQ0VecJ1xnpnBGC1StbeM1kXV2m9ztiCM9B2/LyLuHBmrBcZSSST/Rf
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="283362300"
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="283362300"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 07:24:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,335,1654585200"; 
   d="scan'208";a="762201309"
Received: from lsundin-mobl.ger.corp.intel.com ([10.252.58.180])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 07:24:58 -0700
Date:   Thu, 22 Sep 2022 17:24:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
In-Reply-To: <Yyxs8o7tB6BVS0Kt@kroah.com>
Message-ID: <1ae6a32c-9f3d-ee56-a26a-7a90b4ee2bfe@linux.intel.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com> <Yyxs8o7tB6BVS0Kt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022, Greg Kroah-Hartman wrote:

> On Fri, Sep 09, 2022 at 12:11:02PM +0300, Andy Shevchenko wrote:
> > uart_xmit_advance() provides a common way on how to advance
> > the Tx queue. Use it for the sake of unification and robustness.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/tty/serial/8250/8250_dma.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> > index d99020fd3427..b85c82616e8c 100644
> > --- a/drivers/tty/serial/8250/8250_dma.c
> > +++ b/drivers/tty/serial/8250/8250_dma.c
> > @@ -26,9 +26,7 @@ static void __dma_tx_complete(void *param)
> >  
> >  	dma->tx_running = 0;
> >  
> > -	xmit->tail += dma->tx_size;
> > -	xmit->tail &= UART_XMIT_SIZE - 1;
> > -	p->port.icount.tx += dma->tx_size;
> > +	uart_xmit_advance(&p->port, dma->tx_size);
> >  
> >  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> >  		uart_write_wakeup(&p->port);
> > -- 
> > 2.35.1
> > 
> 
> Breaks the build :(

I'd guess it's because uart_xmit_advance() is current only in tty-linus, 
not in tty-next.

-- 
 i.

