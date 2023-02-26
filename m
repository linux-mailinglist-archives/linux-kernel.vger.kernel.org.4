Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7645B6A34CB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 23:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjBZWpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 17:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 17:45:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BD5CC0E;
        Sun, 26 Feb 2023 14:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qWnDKBNh35K+ganeqMEvc7orr2tqqQPr3nUxaAl0qYs=; b=edHC6/cA8EGZHvetsmv5VVqAhR
        RKBBjjSeCp1k5i858eNYHM1xgAsVD37Y/HBvxByEDpbZZjbxzBOOgxLTK/xKmoUIKlGmtht7TNe49
        N0Ch4UpHLSryJe8P57LbRA4Ch/TrwrouDcikCuzLydUBAWflO4YGYMXTij+Nn8a38B2Yt4rwxYGRW
        aXcYPDxSvijS6l+6hY57n4eIKSuFbWfXsHgK8tGpGJLyelIajyrZXUzj9QyOSCtT2oD8jIdY6fiLb
        qGo/XY/WmTnRigAbz1p6iQj0ZkNDCV3PLY1ZmFlNTgTAnPzS7FF7eQeqWbg4VbpDzEsKwdFBwv6JZ
        L25wy4Sg==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWPld-007wJD-AX; Sun, 26 Feb 2023 22:45:17 +0000
Message-ID: <c32f8b2b-7137-c15e-9786-601b94a4ada4@infradead.org>
Date:   Sun, 26 Feb 2023 14:45:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] Revert "tty: serial: fsl_lpuart: adjust
 SERIAL_FSL_LPUART_CONSOLE config dependency"
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, sherry.sun@nxp.com, jindong.yue@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230226173846.236691-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230226173846.236691-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/23 09:38, Tom Rix wrote:
> This reverts commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30.
> 
> This results in a link error of
> 
> ld: drivers/tty/serial/earlycon.o: in function `parse_options':
> drivers/tty/serial/earlycon.c:99: undefined reference to `uart_parse_earlycon'
> 
> When the config is in this state
> 
> CONFIG_SERIAL_CORE=m
> CONFIG_SERIAL_CORE_CONSOLE=y
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_FSL_LPUART=m
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> 
> Fixes: 5779a072c248 ("tty: serial: fsl_lpuart: adjust SERIAL_FSL_LPUART_CONSOLE config dependency")
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 625358f44419..0072892ca7fc 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1313,7 +1313,7 @@ config SERIAL_FSL_LPUART
>  
>  config SERIAL_FSL_LPUART_CONSOLE
>  	bool "Console on Freescale lpuart serial port"
> -	depends on SERIAL_FSL_LPUART
> +	depends on SERIAL_FSL_LPUART=y
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  	help

-- 
~Randy
