Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF48C601563
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbiJQRai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiJQRaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:30:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863973332;
        Mon, 17 Oct 2022 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666027817; x=1697563817;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YZZqcz+hTM5irvObor60il2HCgMD8ArpMwlnBmFroRU=;
  b=D9RBU1xpDlzpeAXNHGwTLJ98VliD23dni+dXtutnv1CNqEoUuvjQ5KX0
   MR8v+LZ4IehnVAtEnzN64zqnkK0ni61onOEQPsc18cyC3sWqCytAal3Ez
   yNhLNOoeCtIUcGABnsQDfOvd5tXar+Wf9ImLR7cVTC+FQwOivs0JhEvKh
   56d8XzqQjCQnZlQw7OXHAWfppEEnJdlMBiVqqD15/212/YAc99UFgGpUV
   0zI7QGhY7r5sDOk3GfrdcVCJgKMq21NoFX3JvSrcnwtED3Ejl0EPzw6sd
   lxNFItHP1CqTmReqGH2daxMRFk7yRVcSZ6ZtMhShnhvono5qLzyAYl+jb
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="307524295"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="307524295"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:27:15 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10503"; a="717574487"
X-IronPort-AV: E=Sophos;i="5.95,192,1661842800"; 
   d="scan'208";a="717574487"
Received: from ohoehne-mobl4.ger.corp.intel.com ([10.251.213.173])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2022 10:27:13 -0700
Date:   Mon, 17 Oct 2022 20:27:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: 8250_core: Use str_enabled_disabled()
 helper
In-Reply-To: <20221017171633.65275-1-andriy.shevchenko@linux.intel.com>
Message-ID: <2755edbb-7fe2-fbad-f67b-1a2679ef4b3@linux.intel.com>
References: <20221017171633.65275-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2129481153-1666027634=:5493"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2129481153-1666027634=:5493
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 17 Oct 2022, Andy Shevchenko wrote:

> Use str_enabled_disabled() helper instead of open coding the same.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 94fbf0add2ce..80a2fc2fbd4d 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -32,6 +32,7 @@
>  #include <linux/nmi.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> +#include <linux/string_helpers.h>
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
>  #ifdef CONFIG_SPARC
> @@ -1175,8 +1176,8 @@ static int __init serial8250_init(void)
>  
>  	serial8250_isa_init_ports();
>  
> -	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %sabled\n",
> -		nr_uarts, share_irqs ? "en" : "dis");
> +	pr_info("Serial: 8250/16550 driver, %d ports, IRQ sharing %s\n",
> +		nr_uarts, str_enabled_disabled(share_irqs));
>  
>  #ifdef CONFIG_SPARC
>  	ret = sunserial_register_minors(&serial8250_reg, UART_NR);
> 

Looks ok.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-2129481153-1666027634=:5493--
