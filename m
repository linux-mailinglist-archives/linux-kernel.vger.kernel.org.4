Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE5A71F66D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjFAXOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjFAXOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:14:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214AD13D;
        Thu,  1 Jun 2023 16:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hZO2CzatNKqaF+sFsPdBkHEKuGEv+e/Uk5jIqidmBvs=; b=F4YHdv50odrj+Cwax9Xttvns5v
        NdHeZuM+epXqxo5wyUxuQwThN0e0rk52+7BozYYcTIlYpqh5adWybjy24BkE8zFE/T9jATShrJNvH
        DRF1ot7SRzJdBDK+wwZRQLO9uWgDMEKzi/oJ2giNXyftfqEF823JYpqHAlpkEeMZnH0+uNu0HI59m
        SZm+haiguH+ssXV0XWVlX7odihoh6gITM/bIK6ErBRhYN7XGVf8YgH2vpdnYkLMXGuIdnuowak/Rw
        cZdjNFGAxGwPpxrxxhqwGp9RDQJdedGooHvnWQiOsn5F1WFPUwdeAzfT29EhoOY+mdAhaH1/XkfJk
        CfKNPDHw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4rUT-005DAO-0u;
        Thu, 01 Jun 2023 23:13:57 +0000
Message-ID: <1868cc20-fd69-f5db-9c49-30d87e74355b@infradead.org>
Date:   Thu, 1 Jun 2023 16:13:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 -next] tty: serial: add panic serial helper
Content-Language: en-US
To:     Hongyu Xie <xiehongyu1@kylinos.cn>, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
References: <20230531081737.423737-1-xiehongyu1@kylinos.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230531081737.423737-1-xiehongyu1@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/31/23 01:17, Hongyu Xie wrote:
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 3e3fb377d90d..70d0d2e4b827 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -198,6 +198,31 @@ config SERIAL_KGDB_NMI
>  
>  	  If unsure, say N.
>  
> +config PANIC_SERIAL_HELPER
> +	tristate "debug through uart after panic"

	                        UART

> +	depends on PANIC_TIMEOUT=0
> +	select CONSOLE_POLL
> +	help
> +	  This is a debug module that allows you to get all kernel logs
> +	  after panic.
> +
> +	  Normally you need to attach a USB-to-UART tool or enable kdump
> +	  before panic happens to get log from kernel after panic. If you
> +	  didn't do that and kdump is not working, you can't get any log to
> +	  know what happened before panic. If you have a USB-to-UART tool
> +	  and the uart port on your computer is working, this module helps

	          UART

> +	  you to get all kernel log after panic() is called.
> +
> +	  This module uses serial port in poll mode, so it's more stable
> +	  than other debugging methods.
> +
> +	  Read <file:Documentation/dev-tools/panic_serial_helper.rst> for
> +	  usage.
> +
> +	  Say Y if you have an UART port that is working. If unsure, say N.
> +	  Say M if you want add this as a module driver.
> +	  The module will be called panic_serial_helper.

thanks.
-- 
~Randy
