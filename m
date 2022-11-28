Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25263A683
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiK1K71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiK1K7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:59:24 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB2812AEC;
        Mon, 28 Nov 2022 02:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669633163; x=1701169163;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nG8vAVvrG6D6LC8ebeOkxEt0G/Epw+RgSwZ++d7qqoA=;
  b=x0QOeJ3CLIX+OUnAiTAV7/3qs+PUshpIZPuDPLaSbNv98OAPu47Ogn/T
   n/xoTCeL8kkdMQx2lM6f97J/zgNuE1KK/HwFxAzKfrdoZTuUOuHiXg6xg
   nkokMOawHQDLEensa+v7bw80uo0KX516nVvsTuL+mLR2LUd1YIuIMDXC3
   3aTi5TqhzSugA3wnHSzIZYmcX26Gt0PcRF8G8JK/RrcjYwGjM3dx6g9is
   I8D8JY5m6yZiqCHWGjrE23h8ZrdLFpztoJwpvyBht3EjlEY1dVRJCWoYE
   YzY5Hy6lM+9JYSohs5+MZdEZow3MuKyZKlCfNtCaLNnHb+sqPMpASJvIz
   A==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="201651230"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2022 03:59:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 28 Nov 2022 03:59:23 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 28 Nov 2022 03:59:21 -0700
Message-ID: <717e921f-af8f-f235-e2f8-e2fae2b31e9a@microchip.com>
Date:   Mon, 28 Nov 2022 11:59:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] usb: gadget: udc: drop obsolete dependencies on
 COMPILE_TEST
Content-Language: en-US
To:     Jean Delvare <jdelvare@suse.de>, <linux-usb@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michal Simek <michal.simek@xilinx.com>
References: <20221125170444.36620123@endymion.delvare>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221125170444.36620123@endymion.delvare>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 at 17:04, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>

Fine with me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Jean. Best regards,
   Nicolas

> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> ---
>   drivers/usb/gadget/udc/Kconfig |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-6.0.orig/drivers/usb/gadget/udc/Kconfig
> +++ linux-6.0/drivers/usb/gadget/udc/Kconfig
> @@ -33,7 +33,7 @@ menu "USB Peripheral Controller"
>   config USB_AT91
>          tristate "Atmel AT91 USB Device Port"
>          depends on ARCH_AT91
> -       depends on OF || COMPILE_TEST
> +       depends on OF
>          help
>             Many Atmel AT91 processors (such as the AT91RM2000) have a
>             full speed USB Device Port with support for five configurable
> @@ -430,7 +430,7 @@ config USB_EG20T
>   config USB_GADGET_XILINX
>          tristate "Xilinx USB Driver"
>          depends on HAS_DMA
> -       depends on OF || COMPILE_TEST
> +       depends on OF
>          help
>            USB peripheral controller driver for Xilinx USB2 device.
>            Xilinx USB2 device is a soft IP which supports both full
> 
> 
> --
> Jean Delvare
> SUSE L3 Support

-- 
Nicolas Ferre

