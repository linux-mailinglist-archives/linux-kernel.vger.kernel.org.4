Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9844731421
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbjFOJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbjFOJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:36:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB3D2943;
        Thu, 15 Jun 2023 02:35:29 -0700 (PDT)
Received: from [IPV6:2405:201:0:21ea:e49:10dd:40c0:e842] (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2192F6606F5B;
        Thu, 15 Jun 2023 10:34:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686821683;
        bh=2hM4ekbqC5QTsJaZ3P1qOS1Mh4ihLkLJSUAeTxsOFGc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Oll1uxJlXWEW4dCLhFcQPmwxTx6Qpo8TEwBRMQQcTmnWp+pUNKJ5uJB2QyoDCuwYV
         ylxqvNnmsWJEOJGFs4Cqcvg/wTTw4GBfK6kej7+GKKQ2o0dD9AI0pV/WFBKAEw1DOY
         NuRHJUwVH9hMvsUdBViiW3jqYv6NLel8gAOi98jF1+imwQxEji3jQbm5NR2N2CWnJd
         ySPVhMvHp74uG8oJ4Ppixppe1ivfrmLioLkjUfVts6J2KL6T3CBQtmHFw4aE26fyQ8
         apfkatmHLbIbNlFCzQoZODuK7VhWPRFvZlW7ScpkwgjU4lDtaqLDjMkmx79svcZCu7
         7Mio0upqt8/Dw==
Message-ID: <1ff6db73-926f-f4cb-958f-e72482fb0840@collabora.com>
Date:   Thu, 15 Jun 2023 15:04:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jiawen Wu <jiawenwu@trustnetic.com>, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230607081803.778223-1-jiawenwu@trustnetic.com>
 <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com>
 <15e2fc098a1e63317368f4812290ca35@walle.cc>
From:   Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <15e2fc098a1e63317368f4812290ca35@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/06/23 14:56, Michael Walle wrote:
> Am 2023-06-07 16:12, schrieb Andy Shevchenko:
>> +Cc: Michael
>>
>> On Wed, Jun 7, 2023 at 11:20 AM Jiawen Wu <jiawenwu@trustnetic.com> 
>> wrote:
>>>
>>> In case of gpio-regmap, IRQ chip is added by regmap-irq and 
>>> associated with
>>> GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag 
>>> was not
>>> added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to 
>>> return
>>> -EPROBE_DEFER.
>>
>> Makes sense to me.
>> FWIW,
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>
>> But it would be nice to hear from Michael about this.
>
> Thanks for bringing this to my attention. In fact, currently
> my sl28cpld is broken due to this. So:
>

Sorry about your sl28cpld.
Seems like I ended up breaking other boards while fixing this issue for 
steam deck :(


Regards,
Shreeya Patel


> Reviewed-by: Michael Walle <michael@walle.cc>
> Tested-by: Michael Walle <michael@walle.cc> # on kontron-sl28
>
>>> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members 
>>> before initialization")
>>> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
>
> -michael
