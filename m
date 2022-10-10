Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F15F9BAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiJJJLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiJJJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:11:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFD47649;
        Mon, 10 Oct 2022 02:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665393099; x=1696929099;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4WBG/EEGnGO8x02FwyBxn8tRxeg2BOAXncCbx/12x24=;
  b=tHo+bqwtyiqdd2CFjDn0JMzqunmIf9VLW1+rgafDjT3VJo4FhU4zNb7v
   jMOhkqhyDJDtdeR9NFT4KJcd3UXKuL232Bc2xqMfiy63CAKB8jF0upjmU
   LDsrhko7QRLSGD3WO1VGm+rD8JLb0UkLQXV6Y8OLMFfDr3x3gaW3ejO8y
   ATUaKEXVkf8zYDKoZ9cKBvw0AyrasVC9AGnsqCdUGTZf5VoMPy5CiiQp2
   VSFDfgWrLrSfX5BdwA4WkGQ56H5ttnk/onUxAxAHESbBJC4Ajgv8cRCjj
   1QaMWgO/ORzJjNT3W8qwsAOZOZ6P4v+nFCPndn+iahpiZh60nlY8PWIcD
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="181302735"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Oct 2022 02:11:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 10 Oct 2022 02:11:38 -0700
Received: from [10.12.72.60] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 10 Oct 2022 02:11:36 -0700
Message-ID: <982997c9-d357-d57c-c2e6-335fd2d7634f@microchip.com>
Date:   Mon, 10 Oct 2022 11:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] pinctrl:at91-pio4:add support for pullup/down
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <ludovic.desroches@microchip.com>,
        <linus.walleij@linaro.org>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221007151647.98222-1-Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221007151647.98222-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 at 17:16, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> This patch set adds support for pull up/down pinctl configuration.
> The implementation is based off of other pinctl drivers that have
> implemented line bias configurations.
> 
> The second patch addes a case for PIN_CONFIG_PERSIST_STATE
> this shows up becuse the gpiod api passes this into the new config_set
> function that was just implemented. Looking at other drivers like TI
> driver, added the ENOTSUPP to the switch case for that state flag.
> 
> How this was tested was by using a gpio program that I created to test
> configuration from userspace. This program was run in the

Tested using the ioctl GPIO_V2_GET_LINE_IOCTL and with the configs flags:
GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN, GPIO_V2_LINE_FLAG_BIAS_PULL_UP and 
GPIO_V2_LINE_FLAG_BIAS_DISABLED.

> background using & then using gpioinfo function checked if the change
> has been detected by the gpiod api. Then using devmem reading the
> regester making sure that the correct bit was set. The registers where
> checked before and during the program is being run, making sure the
> change happens.
> 
> In the program Pin 127 would be passed into the test program. Before
> the program was ran devmem for pin 127 config register. After
> the progam is running in the background devmem for the same status
> register is called, the result is showing the change in pinconfig.
> The device used to test was the SAMA5D27_som1_ek.

Same here, on sama5d27 som1 ek board:
Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> 
> Ryan Wanner (2):
>    pinctrl: at91-pio4: Add configuration to userspace
>    pinctrl: at91-pio4: Add persist state case in config
> 
>   drivers/pinctrl/pinctrl-at91-pio4.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 


-- 
Nicolas Ferre
