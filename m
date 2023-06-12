Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6789272B75A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 07:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjFLFb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 01:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjFLFbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 01:31:23 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF689B;
        Sun, 11 Jun 2023 22:31:22 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so5649743a12.1;
        Sun, 11 Jun 2023 22:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686547881; x=1689139881;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xJAmHyGGTpWDgHJ+ARPR2wWzsDJroc+Lg7/oN0MLilI=;
        b=bwZPyTSrrppMRK6o8RcBW+EHeYaZlLAX1ma+cXRClUvMkxNZvakUbLvhNvo2nTooDJ
         YDyUhCnaz+Zvb8oTEuTPpmxPhus25GIuxYOgvd9iPw8xsUr9tLzAqw9YKHJ86PZEYZrV
         /B68FW54o+WBYIeqrVpkrLPCCbLq8s7w/Co74vKQGCUWQVX60SBGndrgfiLXLMOQZHUZ
         BZE+AfJHRTgeK0IlS5FiuSenVH5vLavlJnVrgQ0ZR0KFGIsCOMfFfX/jMOfzvegouBi3
         cHhL2MezZgG3aZMD+5dpaf01iXh3TJVVLQYI1pj/VhJhzqL1K6AkfidGPyI4AVkosm2A
         j3Ng==
X-Gm-Message-State: AC+VfDzlRom6ty65FGC2OcyX3lk2uA1++dm/fxlClRf80WiX5RUEBAfx
        3c6ZyEeYZQx0bu1nBrf4zJY=
X-Google-Smtp-Source: ACHHUZ7xV/WRWf4pMR6icQkrWG/ZXgHjOJ952X4vfb8grTR31A1OJ/27jdkBMAhbeNwTgRR1AL4AEg==
X-Received: by 2002:a05:6402:31f3:b0:514:9eae:b0a7 with SMTP id dy19-20020a05640231f300b005149eaeb0a7mr3653904edb.17.1686547880528;
        Sun, 11 Jun 2023 22:31:20 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id g25-20020a50ee19000000b0050bfeb15049sm4510591eds.60.2023.06.11.22.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 22:31:20 -0700 (PDT)
Message-ID: <524b5587-4099-0f5f-40c6-cfc6e4c20274@kernel.org>
Date:   Mon, 12 Jun 2023 07:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] tty: serial: samsung_tty: Use abs() to simplify
 some code
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Walter Harms <wharms@bfs.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org
References: <e4baf6039368f52e5a5453982ddcb9a330fc689e.1686412569.git.christophe.jaillet@wanadoo.fr>
 <7bd165e82ed3675d4ddee343ab373031e995a126.1686412569.git.christophe.jaillet@wanadoo.fr>
 <69054d03-39e5-8c42-a9a9-8934ab4bf6c9@kernel.org>
In-Reply-To: <69054d03-39e5-8c42-a9a9-8934ab4bf6c9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 06. 23, 7:13, Jiri Slaby wrote:
> On 10. 06. 23, 17:59, Christophe JAILLET wrote:
>> Use abs() instead of hand-writing it.
>>
>> Suggested-by: Walter Harms <wharms@bfs.de>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> v2: new patch
>> ---
>>   drivers/tty/serial/samsung_tty.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung_tty.c 
>> b/drivers/tty/serial/samsung_tty.c
>> index 0b37019820b4..b29e9dfd81a6 100644
>> --- a/drivers/tty/serial/samsung_tty.c
>> +++ b/drivers/tty/serial/samsung_tty.c
>> @@ -24,6 +24,7 @@
>>   #include <linux/dmaengine.h>
>>   #include <linux/dma-mapping.h>
>>   #include <linux/slab.h>
>> +#include <linux/math.h>
>>   #include <linux/module.h>
>>   #include <linux/ioport.h>
>>   #include <linux/io.h>
>> @@ -1485,9 +1486,7 @@ static unsigned int s3c24xx_serial_getclk(struct 
>> s3c24xx_uart_port *ourport,
>>           }
>>           quot--;
>> -        calc_deviation = req_baud - baud;
>> -        if (calc_deviation < 0)
>> -            calc_deviation = -calc_deviation;
>> +        calc_deviation = abs(req_baud - baud);
> 
> Does this work provided req_baud and baud are unsigned?

Oh, yes, it does, _hopefully_. A bit unexpectedly for me, but:
  * abs - return absolute value of an argument
  * @x: the value.  If it is unsigned type, it is converted to signed 
type first.

So:

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

It would help noting this in the commit log.

> thanks,-- 
js
suse labs

