Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201463361B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbiKVHo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbiKVHoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:44:38 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E432B8A;
        Mon, 21 Nov 2022 23:44:16 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id z18so19435695edb.9;
        Mon, 21 Nov 2022 23:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xslK4TJ5lzZn3rrEbVLf4tuQt9CQu1qn6KfjRbgvDi4=;
        b=pxZouPYiKmwu4E3IxUVgmKsEDrJ8ySlvd23drAdd3OBUjZjqMJDRbMoeUCltGAtkmZ
         tjJ6ruGPzm/VQ/zIIr6BP7dz3okvObZ54lTEScvFPPezGNqrzzNqp4bTuwalY+en8H9V
         GVyaqwVqPOgc6y4pPywNuIU8KSJoBPlbofyRazwdJReuFJAhE/Lia2U+1R69SjHSqac6
         g/IDigfM81RpIhQCqVkj/4fmjOuUvD9d/xO6no0JBPnINjZxFNwZ1nEmP/VeMqNNC9J0
         1xz8oMcaGbmEsXKgQjPWu6nXmfc+OOcmNxWjN98oP3dgjuq+3IY44hSq0qXi8XvEJCBJ
         McRQ==
X-Gm-Message-State: ANoB5pm/T+5TE5s0s45NzNvoMRoVY2R/9F4jIrmtOHZXMDhX8E0Xqibe
        G3khY+/7wVpsaG3RkuvomkE0o7tHON2UBA==
X-Google-Smtp-Source: AA0mqf7hwgmCIbeCqwe4yJPDQSaQVEUYcQfXgt+JuA2ROovOm5duOrUbmjkOAMC2qrqAfKZnPU/JxA==
X-Received: by 2002:a05:6402:520b:b0:464:718c:b271 with SMTP id s11-20020a056402520b00b00464718cb271mr3639808edd.287.1669103055417;
        Mon, 21 Nov 2022 23:44:15 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id fe4-20020a056402390400b0046856c307d0sm6084847edb.5.2022.11.21.23.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:44:15 -0800 (PST)
Message-ID: <8dd90e39-087e-984c-c289-dbfa766359a8@kernel.org>
Date:   Tue, 22 Nov 2022 08:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 12/14] serial: liteuart: add IRQ support for the RX
 path
Content-Language: en-US
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, kgugala@antmicro.com,
        mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        geert@linux-m68k.org, ilpo.jarvinen@linux.intel.com
References: <20221118145512.509950-1-gsomlo@gmail.com>
 <20221118145512.509950-13-gsomlo@gmail.com>
 <abb7d87a-46c7-fe7f-f943-4287d15a537f@kernel.org>
 <Y3vIi2OF5t4IrCS1@errol.ini.cmu.edu>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Y3vIi2OF5t4IrCS1@errol.ini.cmu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 11. 22, 19:50, Gabriel L. Somlo wrote:
>>>    static void liteuart_timer(struct timer_list *t)
>>>    {
>>>    	struct liteuart_port *uart = from_timer(uart, t, timer);
>>>    	struct uart_port *port = &uart->port;
>>> -	liteuart_rx_chars(port);
>>> -
>>> +	liteuart_interrupt(0, port);
>>
>> Are you sure spin_lock() is safe from this path? I assume so, but have you
>> thought about it?
> 
> I checked and at that point `in_serving_softirq()` is true.
> 
> *However*, after studying spin_lock() and friends for a while, I'm
> not quite clear on whether that unequivocally translates
> to "yes, we're safe" :)

Depends whether some hard irq context is grabbing the port lock too. If 
it does, it will spin forever waiting for this soft irq to finish (never 
happens as it was interrupted).

> As such, I'm inclined to switch to `spin_lock_irqsave()` and
> `spin_unlock_irqrestore()` even in the interrupt handler, which is
> explicitly stated to be "safe from any context":
> https://www.kernel.org/doc/html/v4.15/kernel-hacking/locking.html#cheat-sheet-for-locking



> The alternative could be to set `TIMER_IRQSAFE` in `timer_setup()`,
> but no other tty driver seems to be doing that, so I'd be a bit off
> the beaten path there... :)

Ah, no.

> Please do let me know what you think about this, particularly if you
> consider going the spin_lock_irqsave-everywhere-just-to-be-safe route
> overkill... :)

If you are unsure about the other contexts, irqsave/restore is the way 
to go. It can be lifted later, if someone investigates harder.

thanks,
-- 
js

