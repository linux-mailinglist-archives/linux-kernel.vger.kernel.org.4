Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5CA5EACF4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiIZQrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiIZQqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:46:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696112477B;
        Mon, 26 Sep 2022 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664206636; x=1695742636;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=p1AnJWXRzUzKOoto4sBMgcTv9RELTIBHZTO2mWpPdk8=;
  b=OamwnlCM9CjDpb5a9PpcBXo64XejIgiRxeSTgoxnX0INquSRvDZx6jXo
   NXBbN6J1R9svjmdhVyuOIsY3r6HtYlAn6J4kqvKSPo6IbmXPkqp0gm6ZO
   RTUdtLOJXDuNUMTbtN9h9rSxLdNv5UjHq45upguM7SnkMJVBaP4d5Ct4J
   Ej3gI6NBvk5koWZeerScIDGG08nSoQRoowTcaANR4BAz56CesmL9qUFjH
   WpYoRkmlaTF3DfRX2XWnmt/asD5g7PwEZ6d5QtID0eE8fW1kbY/3/WwDt
   QOihtUCs62PX/uxlPNiSR5qPeJ3jdPj03TKRcxquBTUDmqtqLcM88RKjr
   g==;
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="115446950"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2022 08:37:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 26 Sep 2022 08:37:15 -0700
Received: from [10.159.205.135] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 26 Sep 2022 08:37:13 -0700
Message-ID: <47b7352e-153d-22e0-6bb6-5a7b17b6a081@microchip.com>
Date:   Mon, 26 Sep 2022 17:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: serial: atmel: Add COMMON_CLK dependency to
 SERIAL_ATMEL
Content-Language: en-US
To:     Sergiu Moga <sergiu.moga@microchip.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <claudiu.beznea@microchip.com>, <richard.genoud@gmail.com>,
        <linux-serial@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
References: <20220926143244.485578-1-sergiu.moga@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220926143244.485578-1-sergiu.moga@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 at 16:32, Sergiu Moga wrote:
> Now that the driver makes use of `__clk_is_enabled()` in order to
> know whether a `clk_disable_unprepare()` is needed or not on the
> GCLK, a new dependency has been introduced: COMMON_CLK. If this
> `CONFIG_COMMON_CLK` is not enabled, whatever config may have this
> driver enabled without COMMON_CLK then an undefined reference to
> `__clk_is_enabled()` will be issued by the linker.
> 
> Thus, make sure that, unless `CONFIG_COMMON_CLK` is enabled, this
> driver is not compiled.
> 
> Fixes: 5e3ce1f26129 ("tty: serial: atmel: Make the driver aware of the existence of GCLK")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/tty/serial/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index a18dd525e42b..1aec3cf002f7 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -127,6 +127,7 @@ config SERIAL_SB1250_DUART_CONSOLE
>   
>   config SERIAL_ATMEL
>   	bool "AT91 on-chip serial port support"
> +	depends on COMMON_CLK
>   	depends on ARCH_AT91 || COMPILE_TEST
>   	select SERIAL_CORE
>   	select SERIAL_MCTRL_GPIO if GPIOLIB


-- 
Nicolas Ferre
