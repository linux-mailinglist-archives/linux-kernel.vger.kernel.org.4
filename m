Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425906A2B29
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBYRqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 12:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYRqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 12:46:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547818B39;
        Sat, 25 Feb 2023 09:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/5CBm8N9ELZpdglQACosB8KeeGXT41+ktmuAUXwDw3c=; b=i4Aj0s8th0/uh4nA0UjLQZW+tB
        LTjINnl7CV9lnsr/YAdXQTzD4L0YnQ74scCFfH6k6Q6QX08Eh37EbeAsUaj6tOeMiLz+Zd6mh89Wd
        urI7iioeUCcnDun6HdcAeUBr+YU2t2UBu6Ol4qidfeG7//DhkoEsrbYSfiOWC4/6odkAKuIlqlVNs
        2hLihKJRoZ/RLkrN3/qx0fLqIrY6Su5kZ2eNV0+LlAbrKDChHnUwtqqVu2/v3iha1xAeiM/ImAdS7
        eEEx2OvVNqNUV3eod1WLllHnhK/311XRAPQcaXkMrzweuunRmqSt0Wl4J5D7OSYG03yANL94o8sDY
        RQAIPRAA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVyd6-0067S7-P2; Sat, 25 Feb 2023 17:46:40 +0000
Message-ID: <0f8a8857-5e18-e49a-0361-197b4bc892ab@infradead.org>
Date:   Sat, 25 Feb 2023 09:46:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230225173949.651311-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230225173949.651311-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/25/23 09:39, Tom Rix wrote:
> A rand config causes this link error
> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
> 
> The rand config has
> CONFIG_SERIAL_CORE=m
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_FSL_LPUART=m
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> 
> SERIAL_FSL_LPUART should have been selected instead of depends on-ed.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 625358f44419..b24d74d389fc 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
>  
>  config SERIAL_FSL_LPUART_CONSOLE
>  	bool "Console on Freescale lpuart serial port"
> -	depends on SERIAL_FSL_LPUART
> +	select SERIAL_FSL_LPUART

Most other _CONSOLE Kconfig have:

	depends on SERIAL_FSL_LPUART=y

e.g.

but I noticed a few others with a similar problem.

>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  	help

-- 
~Randy
