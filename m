Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A634470848B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjERPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjERPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:03:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABAF10E6
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/PsrRoXt0fCE1B+ae6bMKsmUl/yUier/hb1SvHC6KqI=; b=C1dRx4FmGoZCKHoKaUDGZAZh2X
        HRVkRx2Tl/0xsMi3IlD+56yI/PdKq+zPldK8ZV2Dti/rphlTlacnc29uc25Qe41lGKIBJyirUKYB7
        ARlIkrYopLZLzqCoKRdwzA3mPA0/BH355pqfhPro3qNK4mzh4cC1dcrjFSHfxVxUfxJHankFT5BIO
        ftUroEMBtroUGAz+A/BgRLxCUN+Em5LFY5z1Z2sMekTSvy2oPayehplf9fijusZvZArQWNj8Bax0i
        Ut9RkRexNdr8wIS/weZphwiyIYjDNqpEg3aKY+tNTjMBM7dHps/octAYa/r+AhxjfiuiIyS+8DNDb
        Yd7Fs/sg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzfA6-00DGRo-1Z;
        Thu, 18 May 2023 15:03:26 +0000
Message-ID: <4668efed-8c2a-47c6-fc8e-5fba1e176218@infradead.org>
Date:   Thu, 18 May 2023 08:03:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "serial: allow COMPILE_TEST for some drivers"
 partially
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230518055620.29957-1-jirislaby@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230518055620.29957-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/23 22:56, Jiri Slaby (SUSE) wrote:
> This reverts commit e3e7b13bffae85e2806c73e3ccacd4447bcb19ed partially.
> It turns out, the image does not link for CPM:
>   powerpc-linux-ld: drivers/tty/serial/cpm_uart/cpm_uart_core.o: in function `cpm_uart_release_port':
>   cpm_uart_core.c:(.text+0x598): undefined reference to `cpm_uart_freebuf'
> 
> So do not allow compile testing on this driver.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/tty/serial/Kconfig             | 2 +-
>  drivers/tty/serial/cpm_uart/cpm_uart.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 398e5aac2e77..3e3fb377d90d 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -762,7 +762,7 @@ config SERIAL_PMACZILOG_CONSOLE
>  
>  config SERIAL_CPM
>  	tristate "CPM SCC/SMC serial port support"
> -	depends on CPM2 || CPM1 || (PPC32 && COMPILE_TEST)
> +	depends on CPM2 || CPM1
>  	select SERIAL_CORE
>  	help
>  	  This driver supports the SCC and SMC serial ports on Motorola 
> diff --git a/drivers/tty/serial/cpm_uart/cpm_uart.h b/drivers/tty/serial/cpm_uart/cpm_uart.h
> index 0577618e78c0..46c03ed71c31 100644
> --- a/drivers/tty/serial/cpm_uart/cpm_uart.h
> +++ b/drivers/tty/serial/cpm_uart/cpm_uart.h
> @@ -19,8 +19,6 @@ struct gpio_desc;
>  #include "cpm_uart_cpm2.h"
>  #elif defined(CONFIG_CPM1)
>  #include "cpm_uart_cpm1.h"
> -#elif defined(CONFIG_COMPILE_TEST)
> -#include "cpm_uart_cpm2.h"
>  #endif
>  
>  #define SERIAL_CPM_MAJOR	204

-- 
~Randy
