Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AB96D0ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbjC3T2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjC3T2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:28:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB68FF2F;
        Thu, 30 Mar 2023 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hSsnOko9sGhkX9GeGg7lRAXU38w+ZJny3hsOl+XpUFI=; b=Az7EnUEBQ0lDG3OS4izH9AEY5X
        pCtOwKJ09t5440CpQF/K+16nluRB59Z6erAqx4yLXXN8M1b74e7zvGqVlVa2CnhiL7oLZCWHcMjBR
        aptzDwOSSsCkR6m9uYyai5JKHDTZOYtHAbbbLCydbX1xa6CWqvvlKKDKWaO6dFEXJqq7sgZRJxT/o
        WXeW0hVoGES7aTSdY1MRDl0mJo7Pks5wUW/JY5rdZr5Cl/+iHhaGOOkeS6Kwv62CdWnADvxg+Fa+b
        nMRahIf3avBY32LiXzBSOHJn+pGW/Nz7GvUgNVb96ltkOAgmrWiDdV6IOcLOjHXIUjsQi5PTxjsQQ
        9j8kWmnw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phxwH-004vIK-0g;
        Thu, 30 Mar 2023 19:28:01 +0000
Message-ID: <97d745be-afb4-dfc0-5eeb-20d86e407cf4@infradead.org>
Date:   Thu, 30 Mar 2023 12:28:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 7/7] serial: allow COMPILE_TEST for some drivers
Content-Language: en-US
To:     Jiri Slaby <jslaby@suse.cz>, gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220421101708.5640-1-jslaby@suse.cz>
 <20220421101708.5640-8-jslaby@suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220421101708.5640-8-jslaby@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/21/22 03:17, Jiri Slaby wrote:
> Some more serial drivers can be compile-tested under certain
> circumstances (when building a specific architecture). So allow for
> that.
> 
> This reduces the need of zillion mach/subarch-specific configs. And
> since the 0day bot has only allmodconfig's for some archs, this
> increases build coverage there too.
> 
> Note that cpm needs a minor update in the header, so that it drags in
> at least some defines (CPM2 ones).
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  drivers/tty/serial/Kconfig             | 6 +++---
>  drivers/tty/serial/cpm_uart/cpm_uart.h | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 20cb103972fa..2d3eed53b43e 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -782,7 +782,7 @@ config SERIAL_PMACZILOG_CONSOLE
>  
>  config SERIAL_CPM
>  	tristate "CPM SCC/SMC serial port support"
> -	depends on CPM2 || CPM1
> +	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)


This patch (now commit e3e7b13bffae) causes build errors
when neither CPM1 nor CPM2 is set but PPC32=y and COMPILE_TEST=y:

ERROR: modpost: "cpm_uart_freebuf" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
ERROR: modpost: "cpm_uart_allocbuf" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
ERROR: modpost: "cpm_line_cr_cmd" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
ERROR: modpost: "__cpm2_setbrg" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
ERROR: modpost: "cpm_uart_unmap_pram" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!
ERROR: modpost: "cpm_uart_map_pram" [drivers/tty/serial/cpm_uart/cpm_uart.ko] undefined!

>  	select SERIAL_CORE
>  	help
>  	  This driver supports the SCC and SMC serial ports on Motorola 
> @@ -806,7 +806,7 @@ config SERIAL_CPM_CONSOLE
>  
>  config SERIAL_PIC32
>  	tristate "Microchip PIC32 serial support"
> -	depends on MACH_PIC32
> +	depends on MACH_PIC32 || (MIPS && COMPILE_TEST)
>  	select SERIAL_CORE
>  	help
>  	  If you have a PIC32, this driver supports the serial ports.
> @@ -1246,7 +1246,7 @@ config SERIAL_XILINX_PS_UART_CONSOLE
>  
>  config SERIAL_AR933X
>  	tristate "AR933X serial port support"
> -	depends on HAVE_CLK && ATH79
> +	depends on (HAVE_CLK && ATH79) || (MIPS && COMPILE_TEST)
>  	select SERIAL_CORE
>  	select SERIAL_MCTRL_GPIO if GPIOLIB
>  	help
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
> index 6113b953ce25..8c582779cf22 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart.h
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
> @@ -19,6 +19,8 @@ struct gpio_desc;
>  #include "cpm_uart_cpm2.h"
>  #elif defined(CONFIG_CPM1)
>  #include "cpm_uart_cpm1.h"
> +#elif defined(CONFIG_COMPILE_TEST)
> +#include "cpm_uart_cpm2.h"
>  #endif
>  
>  #define SERIAL_CPM_MAJOR	204

-- 
~Randy
