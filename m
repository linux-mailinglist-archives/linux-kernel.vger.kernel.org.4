Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9181374415E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjF3RgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjF3Rfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:35:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1BC3A87;
        Fri, 30 Jun 2023 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688146517; x=1719682517;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uNu3SsF/Wf4Wk2qmSnwBD4NMQQ172nyVXwTGK7AQiDI=;
  b=Ce0AMrKuzgYX41FoeYcJVkSmrS8vlnQNtlFELVuH71ds7pPoP0tZQT74
   aYbM5PUqfSgh38YvKaN7pMnBUwXVns+Pm5q9DVSsd6don70lyv/u95wcX
   Hg1x0EAaqaA/7jM7yuXsKR0DfXfXc5r3hV4rg6xhOX2lR2l8ARgrgzjnG
   iveKD0/C1oTjYJD0i14rw5RWOWwsfkS+CdnbYFV+qM3I1p7AZsp4/iAZI
   hc4YDyt9+kgzPTCfaWDfYUVwy/1sgqblJqY7upkSxdP4spMkboeRPyq5m
   1nsfAEj/pRC01+dohAIX39mkxL/8gI3YOzGNbhDq0mKTbuv+KxJBDWDNO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="393176029"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="393176029"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:34:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="807851576"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="807851576"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jun 2023 10:34:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qFI11-001APM-1q;
        Fri, 30 Jun 2023 20:34:39 +0300
Date:   Fri, 30 Jun 2023 20:34:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ruihong Luo <colorsu1922@gmail.com>
Cc:     gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, luoruihong@xiaomi.com,
        weipengliang@xiaomi.com, wengjinfei@xiaomi.com
Subject: Re: [PATCH v3] serial: 8250_dw: Preserve original value of DLF
 register
Message-ID: <ZJ8SL61eYKK3Xwhj@smile.fi.intel.com>
References: <20230630003806.66112-1-colorsu1922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630003806.66112-1-colorsu1922@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 08:38:08AM +0800, Ruihong Luo wrote:
> Preserve the original value of the Divisor Latch Fraction (DLF) register.
> When the DLF register is modified without preservation, it can disrupt
> the baudrate settings established by firmware or bootloader, leading to
> data corruption and the generation of unreadable or distorted characters.

Eventually it gets to the point of clean and good fix, thank you!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Note, you are not supposed to do anything. Either Greg will pick this up after
merge window closes, or he will comment on the issues he finds, if any.
The process might take a few weeks (2 weeks of merge window + Greg's backlog
size, which is huge).

> Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")
> Signed-off-by: Ruihong Luo <colorsu1922@gmail.com>
> ---
> v3:
> - modify the commit message
> - use personal email to sign
>  drivers/tty/serial/8250/8250_dwlib.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dwlib.c b/drivers/tty/serial/8250/8250_dwlib.c
> index 75f32f054ebb..d30957722da8 100644
> --- a/drivers/tty/serial/8250/8250_dwlib.c
> +++ b/drivers/tty/serial/8250/8250_dwlib.c
> @@ -244,7 +244,7 @@ void dw8250_setup_port(struct uart_port *p)
>  	struct dw8250_port_data *pd = p->private_data;
>  	struct dw8250_data *data = to_dw8250_data(pd);
>  	struct uart_8250_port *up = up_to_u8250p(p);
> -	u32 reg;
> +	u32 reg, orig;
>  
>  	pd->hw_rs485_support = dw8250_detect_rs485_hw(p);
>  	if (pd->hw_rs485_support) {
> @@ -270,9 +270,11 @@ void dw8250_setup_port(struct uart_port *p)
>  	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
>  		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
>  
> +	/* Preserve value written by firmware or bootloader  */
> +	orig = dw8250_readl_ext(p, DW_UART_DLF);
>  	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
>  	reg = dw8250_readl_ext(p, DW_UART_DLF);
> -	dw8250_writel_ext(p, DW_UART_DLF, 0);
> +	dw8250_writel_ext(p, DW_UART_DLF, orig);
>  
>  	if (reg) {
>  		pd->dlf_size = fls(reg);
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


