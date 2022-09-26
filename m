Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF825EACC5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIZQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiIZQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:40:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672B6143559
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664206046; x=1695742046;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KFoh4HdIcusVJtV9UNqlvNGSfLrtF2yJJGVJryn/W4U=;
  b=TDtEYJabeXpFwZlgoiQtEecgauiBgBiJorsxGpkzlTUGjMDgEXTYsjBs
   75EBwSSkMNmdANRnAjqHWpR20/X8BQyp3l237LwGp+itTrj3FVilUVq4B
   f9ch7K1lkhEDtTy2pV6s0IvK1UShGAt9ETFcTpZvY1S+pCQa0UVZzO+ZS
   TDNlkjhS64rB6lw1msf2HYSQMG33xEqDA3QhCshRpFfmQpbv6TQWduRt3
   OFVV/vcFMrUCDDIP3NUWStEaYPaQ7bG2JiMeJ0NbpqusHeqcSfkf5BXJy
   imW/KA7Ig0OeRKTOZNoWO4+WvP0lagOkknSTmOchFG6f34rZAL3vsiynY
   w==;
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="178939745"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Sep 2022 08:26:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 26 Sep 2022 08:26:55 -0700
Received: from [10.159.205.135] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 26 Sep 2022 08:26:53 -0700
Message-ID: <c694229c-a4cb-eff7-71cd-e6a5b3be9169@microchip.com>
Date:   Mon, 26 Sep 2022 17:26:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] pcmcia: at91_cf: switch to using gpiod API
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
References: <Yy6d7TjqzUwGQnQa@penguin>
 <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
 <Yy7tLRcMaKeet9An@mail.local> <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
 <CACRpkda8Sdr9B8fXzBOPpmPvFeVjkXDFoA47_pmj-JERJBiDHQ@mail.gmail.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <CACRpkda8Sdr9B8fXzBOPpmPvFeVjkXDFoA47_pmj-JERJBiDHQ@mail.gmail.com>
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

On 25/09/2022 at 14:24, Linus Walleij wrote:
> On Sat, Sep 24, 2022 at 4:19 PM Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> 
>> From: Dominik Brodowski <linux@dominikbrodowski.net>
>> Subject: [PATCH] pcmcia: remove AT91RM9200 Compact Flash driver
>>
>> As noted by Arnd Bergmann, "we used to have three drivers for the same
>> hardware (pcmcia, pata and ide), and only the pcmcia driver remained
>> in the tree after drivers/ide/ was removed and pata_at91 did not get
>> converted to DT". "There is no dts file in tree that actually declares
>> either of them, so chances are that nobody is actually using the CF
>> slot on at91 any more."[1]
>>
>> On this rationale, remove the AT91RM9200 Compact Flash driver, which
>> also assists in reaching "the goal of stopping exporting OF-specific
>> APIs of gpiolib".[2]
>>
>> [1] https://lore.kernel.org/lkml/68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com/
>> [2] https://lore.kernel.org/lkml/Yy6d7TjqzUwGQnQa@penguin/
>>
>> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> If someone actually has an AT91 board with this hardware and
> want to be able to use it by converting this driver to device tree,
> this is the time to step up.

Agreed with what was said. If people want reference code to make this 
driver revive, git history is there to help.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Regards,
   Nicolas



-- 
Nicolas Ferre
