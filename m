Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB77164DF5D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiLORKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLORJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:09:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A0F442E4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2TITkz+21gOhfI1DYPLlrOcE0ZQINnBR1iVS5gz6Ok4=; b=vzYHhK2qJ6WlZfBo9195RUu6Q+
        4lBzljsgJ1+Tm6L1tVbU0232DVLxtpYEGMqfNjPyQUwUps7QiNQ4iz1Uc83IQCXF1sngTvPPft9yf
        Xz7Nb/ujHk5Tio+Rg99+2AwwB/gUhT96FUtV+8iI5eQ9ccXvnilWGCSQgY36VuO7kt5pk3q22yclf
        zLgyHYgGqcZxXlVLrM9DE13BXDyqqOTE6Nzp/WbkI9gTt9JgT0Zkwow+i1p5ftUCDnifzB9L8ycgx
        m109hpQZ1LZhelo0EVFEhJAtFljiqCp500GZxTdzeBnOAo79vBHcE6LoqV0IRjN12X43ovICA3j3i
        J0lnsxJA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5riK-00AU4p-Kr; Thu, 15 Dec 2022 17:08:08 +0000
Message-ID: <6c8d0815-a64c-a4ea-4bc9-d38a2b6c3121@infradead.org>
Date:   Thu, 15 Dec 2022 09:08:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] reset: ti-sci: fix compile test dependencies
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nishanth Menon <nm@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20221215170036.2308972-1-arnd@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221215170036.2308972-1-arnd@kernel.org>
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



On 12/15/22 09:00, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The SCI reset driver can be compile testing on targets that
> do not support the SCI firmware, but it fails to link when
> the firmware driver is built as a module, and the reset driver
> is built-in:
> 
> arm-linux-gnueabi-ld: drivers/reset/reset-ti-sci.o: in function `ti_sci_reset_probe':
> reset-ti-sci.c:(.text+0x422): undefined reference to `devm_ti_sci_get_handle'
> 
> Prevent this configuration by limiting the compile test
> to configurations without SCI firmware.
> 
> Fixes: a6af504184c9 ("reset: ti-sci: Allow building under COMPILE_TEST")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

https://lore.kernel.org/lkml/20221030055636.3139-1-rdunlap@infradead.org/

> ---
>  drivers/reset/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index de176c2fbad9..2a52c990d4fe 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -257,7 +257,7 @@ config RESET_SUNXI
>  
>  config RESET_TI_SCI
>  	tristate "TI System Control Interface (TI-SCI) reset driver"
> -	depends on TI_SCI_PROTOCOL || COMPILE_TEST
> +	depends on TI_SCI_PROTOCOL || (COMPILE_TEST && TI_SCI_PROTOCOL=n)
>  	help
>  	  This enables the reset driver support over TI System Control Interface
>  	  available on some new TI's SoCs. If you wish to use reset resources

-- 
~Randy
