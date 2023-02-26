Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DA96A327D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 16:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBZPpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 10:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBZPpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 10:45:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCABB84;
        Sun, 26 Feb 2023 07:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qmO9lzZ4MS7EZaIs9OPtETyRveNVpBW6Vbdp3opA79A=; b=YT8opoOmLjUOcxi7k8KZ4QGVfN
        xuxgfcv5kGV4Un3nT96rQHcT64BXXKP7gG5l3ZlE78bhrYdv3GPD0qHhIVocrt8vKaAKZeLu7QJsH
        W+1UVGm4wnpGIvNhtzeVQ3w4fDYX4lR94rRnn1Y9asf8P+00ibnqmXiWCfiDjVtXEAFStCVg6WEtH
        cGAvZG9H/YsEss21DcepRleK+aD5vrIE5fS4p10JihfJCXPgveWwbNhwQ8XELKQXC3vU8cYVB6RJO
        AppRKBgSY3I6Md26CRAInQIezv+biSx2Yxq34Q+J9v0jSfk4LGbSZAJ9rptbkxLLJw0TX7JyDP484
        YYbCju7g==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWJCv-007WpU-EM; Sun, 26 Feb 2023 15:45:01 +0000
Message-ID: <89b8e519-7e93-6367-6cd1-efe6c0dced57@infradead.org>
Date:   Sun, 26 Feb 2023 07:44:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] tty: serial: fsl_lpuart: select SERIAL_FSL_LPUART for
 SERIAL_FSL_LPUART_CONSOLE
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jindong Yue <jindong.yue@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
References: <20230226145441.3150640-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230226145441.3150640-1-trix@redhat.com>
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

Hi Tom,

[adding the recent commit signers]

On 2/26/23 06:54, Tom Rix wrote:
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
> After applying the configs are
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_FSL_LPUART=y
> CONFIG_SERIAL_FSL_LPUART_CONSOLE=y

This works, but I thought that the point of the recent patch was to make the driver modular.

You said:
"commit 5779a072c248db7a40cfd0f5ea958097fd1d9a30 removed the =y. so it could be built as a module."

That's not the same as what is happening here.

I think it would be better to revert the commit mentioned above.

> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v2: Add how the configs changed to commit log
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
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  	help

-- 
~Randy
