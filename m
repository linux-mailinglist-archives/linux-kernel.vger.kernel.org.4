Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAF762437F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiKJNq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiKJNqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:46:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE4C6B219;
        Thu, 10 Nov 2022 05:46:23 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668087981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9gAlgK59K3GYVN1pexux5Shff1JGMx2AGh3/W1sEoo=;
        b=nGrAAys6AP0r4qx6oHZchp43VEZmz20vcT+t1BaNy27TPPFm4TQtF0+nUf15FVU8Z7FDRu
        iVTzsJDR6E8nzaADMzn953RkpQP9GGUuKkJX++fD7VpUoRVKxJikK8zXQCP1LqO13RHYC6
        /FZu+D+KFveJlRPM02AyaOd1HbecEn2XMmnIICNlE3GjsBd6IXROjlPRBQQeYlmbz2OcA1
        +9BO1F/SchFFRyYUeSPx81KvAfQ6NEEYf6xua0LtvI1/1c5ooWpx7XVysd7qgAWvqwL1O2
        s2efj4opntJMieDi/H/q0DjXAiKBEcSW09ZqiYo8kS7zS/x21I+48gl9U3SA8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668087981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W9gAlgK59K3GYVN1pexux5Shff1JGMx2AGh3/W1sEoo=;
        b=J2wQ2EmfTl7/Zy284MB9bR5WsxeYkNSFqUxMX4V5DLw8iHX2H04ziDoqljASf8tQo0C173
        xOtYi20o3hDNtICQ==
To:     Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?utf-8?Q?J=C3=A4rvi?= =?utf-8?Q?nen?= 
        <ilpo.jarvinen@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tony Lindgren <tony@atomide.com>,
        Lukas Wunner <lukas@wunner.de>, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v3 23/40] serial_core: replace
 uart_console_enabled() with uart_console_registered()
In-Reply-To: <Y2z7lLEvQx7iLuuP@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-24-john.ogness@linutronix.de>
 <CAMuHMdXuBh1PznFggpwSanBtHu9=ngJkVCRzdZVnjxWs2+cbxw@mail.gmail.com>
 <Y2z7lLEvQx7iLuuP@alley>
Date:   Thu, 10 Nov 2022 14:52:20 +0106
Message-ID: <87fseq6hxv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-11-10, Petr Mladek <pmladek@suse.com> wrote:
>>> -static inline bool uart_console_enabled(struct uart_port *port)
>>> +/* Variant of uart_console_registered() when the console_list_lock is held. */
>>> +static inline bool uart_console_registered_locked(struct uart_port *port)
>>>  {
>>> -       return uart_console(port) && (port->cons->flags & CON_ENABLED);
>>> +       return uart_console(port) && console_is_registered_locked(port->cons);
>>> +}
>>> +
>>> +static inline bool uart_console_registered(struct uart_port *port)
>>> +{
>>> +       bool ret;
>>> +
>>> +       console_list_lock();
>>> +       ret = uart_console_registered_locked(port);
>>> +       console_list_unlock();
>>> +       return ret;
>> 
>> Perhaps
>> 
>>     return uart_console(port) && console_is_registered();
>> 
>> to avoid locking the list when the first condition is not true?
>
> I do not have strong opinion on this. It is true that the code
> duplication is trivial but it is a code duplication. Either
> way would work for me.

I will go with Geert's suggestion for v4. It is important that we reduce
lock contention for non-console ports.

> The reset of the code looks good. Feel free to use:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Thanks.

John
