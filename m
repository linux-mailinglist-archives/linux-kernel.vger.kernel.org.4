Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A810E7051F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjEPPUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjEPPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:19:58 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07875FCF;
        Tue, 16 May 2023 08:19:56 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34GFJqWt046666;
        Tue, 16 May 2023 10:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684250392;
        bh=ZtK7bitluym8dquTleK8XBZNEctGa+MQrAshFu2wJYI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=BKTo913v/xrQIY6Yw5sihWIYeFGfe6UhhcpA6GTesCI0tlROadOWA4f1APxz7sgQW
         1VqOQr7NByKaaxkbBu9fheyqoYp51rpgPn/fgsjSWDWW5qGWJ4ngsVePIrzwtLu9ps
         /cd0gxOpxhdx8/DrCGI5yQks5tHhSOHQ1V/YT9do=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34GFJqrn103503
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 May 2023 10:19:52 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 16
 May 2023 10:19:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 16 May 2023 10:19:52 -0500
Received: from [10.250.35.184] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34GFJpk4059866;
        Tue, 16 May 2023 10:19:52 -0500
Message-ID: <b2ca9df3-6c02-d68d-3a85-acfc4d22217b@ti.com>
Date:   Tue, 16 May 2023 10:19:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230515174224.494631-1-afd@ti.com>
 <CAHp75Veu-HbANATV2trD=wAkNx4zia2L8Y+roLQ9k9VA_Vxu3Q@mail.gmail.com>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <CAHp75Veu-HbANATV2trD=wAkNx4zia2L8Y+roLQ9k9VA_Vxu3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 4:08 PM, Andy Shevchenko wrote:
> On Mon, May 15, 2023 at 8:42 PM Andrew Davis <afd@ti.com> wrote:
>>
>> Use devm version of gpiochip add function to handle removal for us.
> 
> ...version of gpiochip_add() function...
> 
> ...
> 
>> +               err = devm_gpiochip_add_data(&pdev->dev, &block->chip, block);
>>                  if (err < 0) {
>>                          dev_err(&pdev->dev,
>>                                  "Could not register gpiochip, %d\n", err);
>> -                       goto exit_err;
>> +                       return err;
> 
> With this applied you can consider a followup to have this be converted to use
> 
>      return dev_err_probe(...);
> 
> here and in other ->probe() related pieces.
> 

Sure, I can add that cleanup to my list.

Or maybe Coccinelle can help do this everywhere, will have to look into that.

Andrew

>>                  }
> 
