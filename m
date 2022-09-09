Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD3F5B3343
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiIIJRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiIIJRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:17:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7567E128C3B;
        Fri,  9 Sep 2022 02:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662715027; x=1694251027;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dhw2jhCuJW+jka0cep0s3bFZ08dxRspNbt2WscRo39c=;
  b=dDPmGkykmzA72XMUJvQmejkdet2cvT//1VVGGppQSNGO+jpKXm4x178I
   x7bGg/c3+uSC4p4/YzyvEXjW/L8i4kuN6/SFehgFGSUcj07Ujhn4HXlKM
   c9755DGR68yGjgoG1AxR2nyrG1ARjRFEV7Tsxv8qvztqPd5ah2+pTpgKy
   2eb3HZ1PpzJxo21ElwYOyEEjELrIYYW4xjRNZu8QtwpTpbDo8bpam0sy1
   LU2PyqmLyvPqYKzXGWChWIU1x6dJ0a9LqVnXqcPC7qEVsuCZxkbK+E8Gq
   7fj3+sfmd7jmAlBkgH1nlTsSWJK+THPVOTJ474ugjkCWSLJaG9yk9H85X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280459202"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="280459202"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 02:17:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="677089043"
Received: from ppogotov-mobl.ger.corp.intel.com ([10.249.45.197])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 02:17:04 -0700
Date:   Fri, 9 Sep 2022 12:16:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_dma: Convert to use
 uart_xmit_advance()
In-Reply-To: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
Message-ID: <81acf91-ba43-f276-fca7-ac9c9e721a88@linux.intel.com>
References: <20220909091102.58941-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1445102681-1662715026=:1967"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1445102681-1662715026=:1967
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 9 Sep 2022, Andy Shevchenko wrote:

> uart_xmit_advance() provides a common way on how to advance
> the Tx queue. Use it for the sake of unification and robustness.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index d99020fd3427..b85c82616e8c 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -26,9 +26,7 @@ static void __dma_tx_complete(void *param)
>  
>  	dma->tx_running = 0;
>  
> -	xmit->tail += dma->tx_size;
> -	xmit->tail &= UART_XMIT_SIZE - 1;
> -	p->port.icount.tx += dma->tx_size;
> +	uart_xmit_advance(&p->port, dma->tx_size);
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(&p->port);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Please note though that I already have patches for almost all these but 
I've not just submitted the remaining ones yet.


-- 
 i.

--8323329-1445102681-1662715026=:1967--
