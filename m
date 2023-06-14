Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84AF72F3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 06:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbjFNE6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 00:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjFNE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 00:58:02 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FEB122;
        Tue, 13 Jun 2023 21:58:01 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5183101690cso7278085a12.0;
        Tue, 13 Jun 2023 21:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686718680; x=1689310680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVqjech6rehqYVc76kP00nVY02sE+W+4Mbw+HMfqJs0=;
        b=Thcyv3QWdwJGWETB8lfAa9kBrJ2ZtyTVrc5Z3F2XFS3cUpRlDwhB2OHvV7SiHvJEVY
         7MchZaXrA6LAjxrbNxHVkiwkjtHIRvacz1T+B/oZG/cho15ieM7JB/Ir0ltE7kfxZ4/r
         UTSX61aGJVkEiuQZXLsg3t0qB/iCf+dZy9IywZgDUMQYeWEdFZImf2Fw7wgaQxeEB9IM
         bs8OuoS37p3cxajagnkHE8U44ivtj0TLB7n8Rv5cRF1LeyAUByf2xlvUIsZB3Y/WfJuZ
         YPcKhi010xcvAx3rryM7uBeKbDfqCBkYmOgffWAzWnleDIJzaiJbTTHbAVyukdnjMiVh
         BAxQ==
X-Gm-Message-State: AC+VfDxr90wYI4swRG3UP4ukMr8J01MofnjS9BPcPY2/SoIZonD/yuwI
        D4QzHFRf/dNmHRYqtDGqwcw=
X-Google-Smtp-Source: ACHHUZ66MPHDLCxi4nWcCRjbBaPXVXW2hh68IAC/e+uTnvNGyZwoL0gPajf4l9a7mqMeV31MsL6ocQ==
X-Received: by 2002:a17:907:7e9a:b0:977:d468:827 with SMTP id qb26-20020a1709077e9a00b00977d4680827mr453941ejc.17.1686718679529;
        Tue, 13 Jun 2023 21:57:59 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id ha19-20020a170906a89300b0097d77a5f033sm5974327ejb.24.2023.06.13.21.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 21:57:58 -0700 (PDT)
Message-ID: <11b0f59e-7cca-1b50-9c34-f38e6b6fc0f9@kernel.org>
Date:   Wed, 14 Jun 2023 06:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver
 support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacky Huang <ychuang570808@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        soc@kernel.org, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061338-lunchbox-snorkel-e6a9@gregkh>
 <f8eb6114-8248-8886-b301-c2886e50e016@gmail.com>
 <2023061356-matchbook-footwear-d142@gregkh>
 <35e768ad-7f15-48a4-9c38-09570026cf71@app.fastmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <35e768ad-7f15-48a4-9c38-09570026cf71@app.fastmail.com>
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

On 13. 06. 23, 17:44, Arnd Bergmann wrote:
> On Tue, Jun 13, 2023, at 16:49, Greg KH wrote:
>> On Tue, Jun 13, 2023 at 06:58:32PM +0800, Jacky Huang wrote:
>>>
>>> On 2023/6/13 下午 06:28, Greg KH wrote:
>>>> On Mon, Jun 12, 2023 at 02:53:55AM +0000, Jacky Huang wrote:
>>>>> From: Jacky Huang <ychuang3@nuvoton.com>
>>>>>
>>>>> This adds UART and console driver for Nuvoton ma35d1 Soc.
>>>>> It supports full-duplex communication, FIFO control, and
>>>>> hardware flow control.
>>>> You get a full 72 columns for your changelog :)
>>>>
>>>>> --- a/include/uapi/linux/serial_core.h
>>>>> +++ b/include/uapi/linux/serial_core.h
>>>>> @@ -279,4 +279,7 @@
>>>>>    /* Sunplus UART */
>>>>>    #define PORT_SUNPLUS	123
>>>>> +/* Nuvoton MA35 SoC */
>>>>> +#define PORT_MA35	124
>>>>> +
>>>> Why is this change needed?  What userspace code is going to rely on it?
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> Because the serial driver requires a port->type, and almost all serial
>>> drivers defined their port type here. We follow the practice of most serial
>>> drivers here.
>>> If we don't do it this way, we would have to directly assign a value to
>>> port->type. However, such modifications were questioned in the past,
>>> which is why we changed it back to defining the port type in serial_core.h.
>>
>> I really really want to get rid of this list, as it's a UAPI that no one
>> uses.  So please don't use it, it doesn't help anything, and while the
>> serial driver might require it, it doesn't actually do anything with
>> that field, right?  So why don't we just set all of the values to the
>> same one?
> 
> I don't see how Jacky can come up with a patch to do this correctly
> without more specific guidance to what exactly you are looking for,
> after the last 123 people that added support for a new port got
> that merged.
> 
> I checked debian codesearch and found only three obscure packages that
> accidentally include this header instead of including linux/serial.h,
> a couple of lists of all kernel headers, and none that include it on
> purpose. I agree that this header should really not exist in uapi,
> but the question is what exactly to do about it.
> 
> Possible changes would be:
> 
> - add a special value PORT_* constant other than PORT_UNKNOWN that
>    can be used by serial drivers instead of a unique value, and
>    ensure that the serial core can handle drivers using it.
> 
> - move all values used by the 8250 driver from serial_core.h
>    to serial.h, as this driver actually uses the constants.
> 
> - Move the remaining contents of uapi/linux/serial.h into the
>    non-uapi version.
> 
> - Change all drivers that only reference a single PORT_*
>    value to use the generic one.

Hmm, we are looping :).

https://lore.kernel.org/all/75375f8d-e157-a364-3da5-9c8d5b832927@kernel.org/

regards,
-- 
js
suse labs

