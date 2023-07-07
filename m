Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB1E74B459
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjGGPa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGGPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:30:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979419B7;
        Fri,  7 Jul 2023 08:30:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b895a06484so10773775ad.1;
        Fri, 07 Jul 2023 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688743825; x=1691335825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=23fqDXyoBeUMVhuKSW8F1o5jrSURNCbcDsreKQGADIQ=;
        b=kmY9x4Hl5lou7/neUj4ZHr9FyuqDnV9af9hyxvpWJm1buSQZKqdSb9gXu0elbdK4V+
         X72UwMF7/+5zq4kDO1YzqV0q6Ct+LZFjfEZurY4meI/eVl2x31+5JsjkJK76KZySY4lO
         0GyVnmBjHNeZm5O8J/lViByY3OTtDELeL4TIZtfUGuv/+oKLCj2tSjSVRmZOYCYNadGq
         Hvb3lxCq7iuH+idaF4Tu2O4/1/5L0JuQfFK+pSQjAfGjBI53iTJ/WH7ZnxifQ+gCYAzr
         YuZMdjjQr5vvIj4iH6WrFbrFnly1Mz0hdxrk67sfO+fhAAbGliXFfiDRUZl6WaterdTO
         KejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688743825; x=1691335825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23fqDXyoBeUMVhuKSW8F1o5jrSURNCbcDsreKQGADIQ=;
        b=dCnFCdBXSQPg7V+Z0h163QrqHf6Fn3MB8eLurUu6TA+3++oK/fhMr19PvvMXZEzV6T
         QHXMLLsP1PwSUrAKI1A2KNq2P5LHmkpgxUHlELrKmnKs8vIJasLvJ1GRhMO0hA382uN4
         gjlC+MtBnsIw1qH5bO+++gKyzGpHWJrEuzKfrBgrzJugBKvEGOyZuJK+cBz4lOncJd74
         Pt7VmoFs7FI7GAFTWXRexRKtGEw13kDeQ/0OY0VokwL5/xrnStmELK1lLoOA5re1P+MN
         NPj+0RLI/YZb+rlDUJuGq4xzzNA8PZZRXN2LlyKA8jL2citPgwOU+OiqV3GqV6A1HUsZ
         R0Sw==
X-Gm-Message-State: ABy/qLZfUL/tlcy1EaDoX0onMcIin82WHb4n/ukOYjfSVTJdRC6lV8hl
        TG3wN9liauGijFMalc9eDt6RvvbM1g0=
X-Google-Smtp-Source: APBJJlE4AtjAv83gXgurA1uTa/SFwHaiudMa6q87SvxelfAFeOy0Vi/sG8vfiZj59mHz098I85y6zQ==
X-Received: by 2002:a17:902:b402:b0:1b6:a972:4414 with SMTP id x2-20020a170902b40200b001b6a9724414mr4321648plr.3.1688743824652;
        Fri, 07 Jul 2023 08:30:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001b53c8659fesm3405218plf.30.2023.07.07.08.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 08:30:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ed3afcf-42f2-af72-9837-76c14c9bb3a1@roeck-us.net>
Date:   Fri, 7 Jul 2023 08:30:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d8254cce-a6a6-46b4-ea28-3a1df2760499@roeck-us.net>
 <407492B8-5D9F-41BC-A696-24C421C69F49@physik.fu-berlin.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <407492B8-5D9F-41BC-A696-24C421C69F49@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/23 08:19, John Paul Adrian Glaubitz wrote:
> Hi Guenter!
> 
>> On Jul 7, 2023, at 4:35 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> ﻿On 7/7/23 02:53, John Paul Adrian Glaubitz wrote:
>>> Hi Geert!
>>> On Fri, 2023-07-07 at 10:48 +0200, Geert Uytterhoeven wrote:
>>>>> I can reproduce the issue with rts7751r2dplus_defconfig, but I may
>>>>> not be able to look into it today...
>>>>
>>>> Disabling CONFIG_USB_OHCI_HCD fixes the hang.
>>> I picked rts7751r2dplus_defconfig, disabled CONFIG_USB_OHCI_HCD but it still
>>> hangs for me. Are you sure it's CONFIG_USB_OHCI_HCD and not something else?
>>
>> It seems to be related. With this patch reverted, ohci_irq() gets a single
>> interrupt, and boot continues. With this patch in place, ohci_irq() does
>> not get any interrupts, and boot hangs with qemu at 100% CPU. I confirmed
>> this by disabling CONFIG_MFD_SM501. After that, the hang is no longer seen.
>> Of course, that also means that OHCI and other emulated sm501 functionality
>> no longer works.
>>
>> My suspicion is that something goes wrong with interrupt routing to
>> SM501 and with it to ohci_irq(), but that is just a wild guess.
> 
> Looking at drivers/mfd/sm501.c, sm501_plat_probe() is explicitly requesting IRQ 0 which is no longer supported on SH:
> 
>  > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/sm501.c <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/sm501.c>
> 
> So, we need to shift this by 16, I guess.
> 

It isn't interrupt 0, it is interrupt _index_ 0. See platform_get_irq_optional()
which calls platform_get_resource(dev, IORESOURCE_IRQ, num). There are lots
of calls to platform_get_irq() with index 0 in the kernel.

Guenter

