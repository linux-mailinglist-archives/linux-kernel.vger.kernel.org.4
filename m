Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDEB6F1EC3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346458AbjD1Tdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjD1Td3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:33:29 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB12D5A;
        Fri, 28 Apr 2023 12:33:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517c840f181so90265a12.3;
        Fri, 28 Apr 2023 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682710406; x=1685302406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=t6juQwA15NUCSEex4/GXlT1BJpoxPwqFx7XKlO4+Bj8=;
        b=fCHjj3fybunvRiPgY0lHTYbwv7QUavKsqGLbhd+i0UTBPnaK91MbeISe+9MaSyUDxr
         qe9h5BsjSZEr16yr2xTLUVgd6N2pUzMFk+PVBSkMODWsQgwy9P+8CU+B/8aLbPZN6cGQ
         yl93JSNL/I3e6caxvX0iUAgFIcLzCCVGjeIVm2UWA9j6LymBluwVn3g3AYqoYe7rJ2y+
         unZzjroEDZr4PsY0sEQ6ACVNKT754y2lj4Z6tLrdkl4KjUh+U2mUuxUiHq0JnpFPgkOq
         vsAmqSH4A/NsXL1n7Pm/VJAiVwuNEm59WtbNChcTvvygo+DKgUeFGxFkS1dC7qJ5dLKJ
         jlfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682710406; x=1685302406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t6juQwA15NUCSEex4/GXlT1BJpoxPwqFx7XKlO4+Bj8=;
        b=WbZrApt3A0GHy3tqtCdJkmcudIfwDm6Lvqdrjcu2y6kK9RmMTTZGUjH/aihm3Vv1gd
         RiLYxXClLDdTpKto+jAgBthdyIbD28ALrfaGIhC1TqdLEQkbukKj8DCUTNM0fCLq8wAH
         VBNr9/ApVkXOMW01L3WXZ9rh02rpG1MK6+7H4IM9WovO1Kq0499Hel8L6Pjm+e5m5uW5
         KoCFo18pDJyRY+aVjyrOtBU25UTRwZPDu81Ozop51qkiTJv7ltR6k/Mx3K8Om1kLI1oW
         67R/s7Rk99/BDDQvgga456rMO+hfbP5bZjNaSpCBI05bGbD/a6jTfM9WVRgoJJKcLWU5
         FCOQ==
X-Gm-Message-State: AC+VfDyQ9pBVzunDc34IcZHf69VooP5lMQqSor+7poqe7tXeu/ub5RVN
        1mRC/XJ2kvwbR1GaGKeuY5X7LaCb/Ag=
X-Google-Smtp-Source: ACHHUZ6aULQ9gM7GWmI1thqOp4n9Q3c8Y8AWUTo3V/bSTBS9pjjF9B4cwmulObrpSBWFKkB6h7TlvQ==
X-Received: by 2002:a17:90b:4aca:b0:24b:7550:d3b4 with SMTP id mh10-20020a17090b4aca00b0024b7550d3b4mr6558916pjb.10.1682710406161;
        Fri, 28 Apr 2023 12:33:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090ac24f00b0024779068491sm1815912pjx.26.2023.04.28.12.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 12:33:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fc2989ce-82aa-aa70-cb11-c2cc2fefefcd@roeck-us.net>
Date:   Fri, 28 Apr 2023 12:33:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add AYANEO 2 and Geek models
Content-Language: en-US
To:     Joaquin Aramendia <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426184420.99945-1-samsagax@gmail.com>
 <720c2b48-ca48-4ee3-9158-f453e48cb012@roeck-us.net>
 <CABgtM3i+HZJDearvBK-sBrWnfqdrsuNCDYfxASC3QVsn8rAy-Q@mail.gmail.com>
 <dfcd56d1-102d-ace6-c8b3-8f668e5f6872@roeck-us.net>
 <CABgtM3gydDb7gv-GQvu6mMku0KLAM+DSXqd4+FQDsk9jcXV3YA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CABgtM3gydDb7gv-GQvu6mMku0KLAM+DSXqd4+FQDsk9jcXV3YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 12:15, Joaquin Aramendia wrote:
>>> I don't know why but the compiler would complain with the casting from
>>> enum to void*.
>>
>> Really ? I tried with both 32 bit and 64 bit targets, and the above worked
>> just fine (with W=1). I tried with gcc 10.3 as well as 11.3. What is
>> your compiler version, what exactly is the warning/error message you
>> observed, and how exactly did your code look like ?
> 
> Said something about an invalid cast of an lvalue? I can´t remember exactly

Like this, maybe ?

drivers/hwmon/oxp-sensors.c:63:26: error: lvalue required as unary ‘&’ operand

That would have been something along the line of

	.driver_data = (void *)&aok_zoe_a1,

or
	driver_data = &aok_zoe_a1,

> and couldn't reproduce it again. Will change all to your form after
> this patch gets
> merged if you like, just to keep things atomic.
> 

Please do.

Thanks,
Guenter

>>
>>> Found out that explicitly casting the enum literal before casting it
>>> to void* works and
>>> the compiler stopped complaining so I went with it.
>>>
>>
>> You are not casting the enum literal, but a pointer to it.
> 
> Yes. I'm taking an enum literal and taking its pointer to cast it to a void*.
> A little cumbersome, but maybe it can be avoided by using your proposed
> form directly and after making sure it works.
> 

