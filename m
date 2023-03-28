Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45C6CB96A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjC1Iau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjC1Ias (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:30:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CDFC7;
        Tue, 28 Mar 2023 01:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679992245; x=1711528245;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bzUK80jztzjDzA1SZeBZahUFNGq7t3lGQg15wparD6c=;
  b=rdl7gQjY85k472G5yU9f3vDBzDp0aPaReok335T7UbW5ISk0xpNeJ/34
   4C5WivTyF75B+5FUPROLwKctE4wEsj49Sw6xvjK8Iq3wvzW9IGNXNr06c
   6TX4xoYJus++Z51fJXgzxE2sy8VGfTzJcn7t2ssOiIOwM+83nnIfmeHyq
   dO87/6y0bMJOAs/CAa4ptJap4KgbBtAnTEKmkeIGDjcaLKHoQxDDWTG3j
   sz9ymcr/8jucrS6SHTR6I4pf67D/A4ofezEAkuhMi6OqtEs0qUVE7x+DY
   kOqhhP9PY0njdbJTklFYq2vor7pJOvvQOjZxZcPSpVsqKKKjQAAV8J1JT
   w==;
X-IronPort-AV: E=Sophos;i="5.98,296,1673938800"; 
   d="scan'208";a="144232728"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2023 01:30:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 01:30:42 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 28 Mar 2023 01:30:40 -0700
Message-ID: <7890284f-5809-2f46-9d5f-52e20a3ec327@microchip.com>
Date:   Tue, 28 Mar 2023 10:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH resent] clk: at91: sama7g5: Add two jump labels in
 sama7g5_pmc_setup()
To:     Markus Elfring <Markus.Elfring@web.de>,
        <kernel-janitors@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <5ed1bc78-77a1-8eb8-43f9-6005d7de49c8@web.de>
 <9e3705dc-7a70-c584-916e-ae582c7667b6@web.de>
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <9e3705dc-7a70-c584-916e-ae582c7667b6@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 at 15:05, Markus Elfring wrote:
> Date: Fri, 17 Mar 2023 20:02:34 +0100
> 
> The label “err_free” was used to jump to another pointer check despite of
> the detail in the implementation of the function “sama7g5_pmc_setup”
> that it was determined already that the corresponding variable contained
> a null pointer (because of a failed memory allocation).
> 
> * Thus use additional labels.
> 
> * Delete an extra pointer check at the end which became unnecessary
>    with this refactoring.
> 
> This issue was detected by using the Coccinelle software.

Fine, but I'm sorry that it complexity the function for no real value. 
Other clk drivers have the same pattern so I want them to all stay the same.

This is a NACK, sorry about that.

Regards,
   Nicolas

> Fixes: cb783bbbcf54c36256006895c215e86c5e7266d8 ("clk: at91: sama7g5: add clock support for sama7g5")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/clk/at91/sama7g5.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/at91/sama7g5.c b/drivers/clk/at91/sama7g5.c
> index f135b662f1ff..224b1f2ebef2 100644
> --- a/drivers/clk/at91/sama7g5.c
> +++ b/drivers/clk/at91/sama7g5.c
> @@ -927,25 +927,25 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>                              (ARRAY_SIZE(sama7g5_mckx) + ARRAY_SIZE(sama7g5_gck)),
>                              GFP_KERNEL);
>          if (!alloc_mem)
> -               goto err_free;
> +               goto free_pmc;
> 
>          hw = at91_clk_register_main_rc_osc(regmap, "main_rc_osc", 12000000,
>                                             50000000);
>          if (IS_ERR(hw))
> -               goto err_free;
> +               goto free_alloc_mem;
> 
>          bypass = of_property_read_bool(np, "atmel,osc-bypass");
> 
>          hw = at91_clk_register_main_osc(regmap, "main_osc", mainxtal_name,
>                                          bypass);
>          if (IS_ERR(hw))
> -               goto err_free;
> +               goto free_alloc_mem;
> 
>          parent_names[0] = "main_rc_osc";
>          parent_names[1] = "main_osc";
>          hw = at91_clk_register_sam9x5_main(regmap, "mainck", parent_names, 2);
>          if (IS_ERR(hw))
> -               goto err_free;
> +               goto free_alloc_mem;
> 
>          sama7g5_pmc->chws[PMC_MAIN] = hw;
> 
> @@ -987,7 +987,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>                          }
> 
>                          if (IS_ERR(hw))
> -                               goto err_free;
> +                               goto free_alloc_mem;
> 
>                          if (sama7g5_plls[i][j].eid)
>                                  sama7g5_pmc->chws[sama7g5_plls[i][j].eid] = hw;
> @@ -999,7 +999,7 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>                                            &mck0_layout, &mck0_characteristics,
>                                            &pmc_mck0_lock, CLK_GET_RATE_NOCACHE, 5);
>          if (IS_ERR(hw))
> -               goto err_free;
> +               goto free_alloc_mem;
> 
>          sama7g5_pmc->chws[PMC_MCK] = hw;
> 
> @@ -1128,12 +1128,11 @@ static void __init sama7g5_pmc_setup(struct device_node *np)
>          return;
> 
>   err_free:
> -       if (alloc_mem) {
> -               for (i = 0; i < alloc_mem_size; i++)
> -                       kfree(alloc_mem[i]);
> -               kfree(alloc_mem);
> -       }
> -
> +       for (i = 0; i < alloc_mem_size; i++)
> +               kfree(alloc_mem[i]);
> +free_alloc_mem:
> +       kfree(alloc_mem);
> +free_pmc:
>          kfree(sama7g5_pmc);
>   }
> 
> --
> 2.40.0
> 

-- 
Nicolas Ferre

