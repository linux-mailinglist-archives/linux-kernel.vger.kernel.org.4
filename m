Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4916AD5BC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCGDbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCGDbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:31:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE82DE43;
        Mon,  6 Mar 2023 19:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678159896; x=1709695896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YOD5nQRRW+7Jh57Qsig/N2Wmv9BwmnlOQex/intAGlw=;
  b=is8kX2mX1ziLnGAbPuFX6L+rmD8YjNxPG2mdtlYqZxO34k4E9lnjofWy
   9f3Xxe4bp7dvwKOPAeZdahAUgpUtAiOuUyyIMpqHbVfA+Hq/OMY6Ira/f
   gFHFThZE3JUTELREYOdkwTEVm/tr9TajXdHkZaFvEsYHlcGFxpK76csCL
   uqG7xO/6thInOIY7TxxbNOtVWGBf5cBYP81cLGGBbw8HB/Nz+Qvo0+eQt
   G8z3yJNEFfi8XwMui6t5s5HGyr2/ZP6Fdj2BRFcqZCc8LenirwhcfTSbg
   DSkF8Xv2861dAcUcz65YUBTU+sPr/fM5HMPqoo/kxWW4w1vps/iPaD2NE
   A==;
X-IronPort-AV: E=Sophos;i="5.98,238,1673938800"; 
   d="scan'208";a="200283118"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 20:31:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 20:31:28 -0700
Received: from [10.40.24.46] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 20:31:25 -0700
Message-ID: <3b16b932-da02-30b4-2eae-29c26b3453a1@microchip.com>
Date:   Tue, 7 Mar 2023 09:01:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] pinctrl: at91: Make the irqchip immutable
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230216-gpio-at91-immutable-v1-0-44f52f148ab9@kernel.org>
 <20230216-gpio-at91-immutable-v1-1-44f52f148ab9@kernel.org>
 <CACRpkdbeVw1vBikYi3RimOO8K-KKLOpO=9O_yZFBt4oORi=Wgg@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CACRpkdbeVw1vBikYi3RimOO8K-KKLOpO=9O_yZFBt4oORi=Wgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 at 18:50, Linus Walleij wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Thu, Feb 16, 2023 at 4:49 PM Mark Brown <broonie@kernel.org> wrote:
> 
>> To help gpiolib not fiddle around with the internals of the irqchip
>> flag the chip as immutable, adding the calls into the gpiolib core
>> required to do so.
>>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> 1) I'm impressed that you're using AT91 hardware

I'm delighted that you're using AT91 hardware ;-)

Thanks for your help Mark!

Regards,
   Nicolas

> 2) Can you respin this on top of my pinctrl devel branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel
> There are some Andy-cleanups already queued for AT91 so I am a bit
> worried of collisions. (If you feel confident they are orthogonal just
> use v6.3-rc1)
> 
> Yours,
> Linus Walleij

-- 
Nicolas Ferre

