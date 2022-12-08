Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29280646C07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiLHJht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLHJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:37:46 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1FA12D26;
        Thu,  8 Dec 2022 01:37:46 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id bg10so630954wmb.1;
        Thu, 08 Dec 2022 01:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IE2BRq9L+0PqGquoqVrkYyY0LIMIc6GkCZYnscxNcAw=;
        b=JpDbEKycMR+tvi1qzKUlX9g2eiPXj6nvzeA6bALI4eSZVGiDL47rMHfFtePahVMCM6
         TtRjUHKeXxedgyxLkQVsy41w1GVoLRer6p2fyWOtD+A+KfR0wnczC0iKwZMUfuHJtwaA
         Y4DEJsYP3LBNdOlTjZ9HKVxhCAJJzWiH9NagFsAaDplLudcv5rThaa091I4bmfX55/Qa
         l4C7z6iCeeNj80HikaMf4SNq0D1gShA5DAKa38ZPTtR/pGt2K3MBOVULTH0yrNr/Couz
         MwGbMn/IZYTu8Qp2lhVA/dLQJEICVpkvybUBMiW3RlnXkfwOyxqHMTP0HjdONmzJJYqT
         1E0w==
X-Gm-Message-State: ANoB5pn6YnSmLTxMDhbqfh3tjmUPNwVldHjQ3pGyqV1G7ezk1G9vtQoT
        +Z+0M16scbvOP9V3T6xoikU=
X-Google-Smtp-Source: AA0mqf6DS1fgI6lCdD1AjRyLiwjdw5l88iWUrUlwLzQPxLWVmcQUt3zi03en9VlUVHcUhixYmxMjfQ==
X-Received: by 2002:a05:600c:21d8:b0:3d0:8d48:2993 with SMTP id x24-20020a05600c21d800b003d08d482993mr1655335wmj.36.1670492264474;
        Thu, 08 Dec 2022 01:37:44 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id 6-20020a1c0206000000b003d1e90717ccsm4256666wmc.30.2022.12.08.01.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:37:44 -0800 (PST)
Message-ID: <035f431c-15ee-b604-79be-ec2861b45b86@kernel.org>
Date:   Thu, 8 Dec 2022 10:37:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] serial: earlycon-arm-semihost: Move smh_putc()
 variants in respective arch's semihost.h
Content-Language: en-US
To:     Bin Meng <bmeng@tinylab.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-serial <linux-serial@vger.kernel.org>
Cc:     "catalin.marinas" <catalin.marinas@arm.com>,
        gregkh <gregkh@linuxfoundation.org>,
        linux <linux@armlinux.org.uk>, will <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20221207135352.592556-1-bmeng@tinylab.org>
 <0443d5e9-b2ce-7e6b-c69b-708d67a5bf97@kernel.org>
 <em14380c7e-ee2b-45d5-8879-dde687f03b2b@eea79fc7.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <em14380c7e-ee2b-45d5-8879-dde687f03b2b@eea79fc7.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 12. 22, 10:32, Bin Meng wrote:
>>> +#ifdef CONFIG_THUMB2_KERNEL
>>> +#define SEMIHOST_SWI    "0xab"
>>> +#else
>>> +#define SEMIHOST_SWI    "0x123456"
>>> +#endif
>>> +
>>> +static inline void smh_putc(struct uart_port *port, unsigned char c)
>>
>> 2) port is unused in all implementations. So it should be dropped.
>> 3) can you make "c" an explicit u8?
> 
> The smh_putc function signature is defined by the uart_console_write 
> helper. I don't think we can change it.

Ah. Of course. Then at least forward-declare struct uart_port here. So 
that it works also when someone decides to include the header outside 
serial.

thanks,
-- 
js
suse labs

