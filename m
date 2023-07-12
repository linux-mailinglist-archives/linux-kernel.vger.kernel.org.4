Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDB750AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGLO3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjGLO2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:28:55 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300A91BC1;
        Wed, 12 Jul 2023 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689172130; x=1720708130;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Dzrrn5EIrw6o3x0SNhzJXz19ZnuVag5culodqvUlwH8=;
  b=Z8Zs/jCuPksAW4xyAH8rf2bznVVAWIit2u2DzXrZTV5EbUF6283hTdKE
   09Zava4nboxbACCSd3x7GHEWKYnr2tLQLMuHL/pzCJlrtx8eqwkuUwzfo
   YbCMZzNHeGkSdOXO40pG1mkg3p7R6y3827h3rHsdjO/OMbbaimGMw7DhR
   vXVqzpBA9pdCabMI6vsWBzTVnHK9JD6c0x++FSXJ3q356UHylJJSeMUqu
   /GGXELBQDkyIVy3g7el+WBwZ9hFw9Km8Hvm7pjMrER8iOGZ6wrlb3B08s
   tucIGH4O3XI/cWwa+bNbxROjuAXwUcHpNPYFtgh2MJ7XjAoc9aGcA85Ro
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="362368116"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="362368116"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 07:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="895648398"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="895648398"
Received: from agermosh-mobl1.amr.corp.intel.com ([10.252.43.42])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 07:27:00 -0700
Date:   Wed, 12 Jul 2023 17:26:58 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ruihong Luo <colorsu1922@gmail.com>
cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        luoruihong@xiaomi.com, weipengliang@xiaomi.com,
        wengjinfei@xiaomi.com
Subject: Re: [PATCH v3] serial: 8250_dw: Preserve original value of DLF
 register
In-Reply-To: <20230630003806.66112-1-colorsu1922@gmail.com>
Message-ID: <763104-cf9a-5397-b45c-d288d7cbc899@linux.intel.com>
References: <20230630003806.66112-1-colorsu1922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2023, Ruihong Luo wrote:

> Preserve the original value of the Divisor Latch Fraction (DLF) register.
> When the DLF register is modified without preservation, it can disrupt
> the baudrate settings established by firmware or bootloader, leading to
> data corruption and the generation of unreadable or distorted characters.
> 
> Fixes: 701c5e73b296 ("serial: 8250_dw: add fractional divisor support")

Add also:

Cc: stable@vger.kernel.org

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

The change looks good but I'd prefer the variable to be called old_dlf 
which is inline how 8250_port names its variables does when it preserves a 
registers across some auto-detection write.

-- 
 i.

