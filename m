Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC4C62D715
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbiKQJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239778AbiKQJcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:32:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97C776149;
        Thu, 17 Nov 2022 01:32:12 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668677530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFIVJDRzYLM8JlLFrtE2EgsFESyY1Nn5OMC4RLGV2yY=;
        b=iO+tJagEFHt9sg3fABlDdYAV9ylNd2aGmxyQcShKySENThGFArqJQ8hgUGOE+R4GBPMfkg
        ImEl/eK0b6L/3MgkJEM2JaXlERewhhZemcHyk+o6A9rQxWGx4iKCWDl0X+Z/OVHiZNoYMx
        3nrH9Qr5h6bw8fCufJv+zAYIZkMqQXDiIeyRpTCPIrphe5LW29+Bd5T18kmjvyN4K1DovK
        vjQlkpgXI0+6G+E7K92dwR7/eoDunyq4Lu1Ual/ioE57tvDkwgVEuvKBlDtXSm/VNLTI50
        FkVxBD8AANMCAw3eKLoEOYgAiY8DDLzoaZGqiO2uz+SlM6Di6wkpUm3d0aN9VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668677530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iFIVJDRzYLM8JlLFrtE2EgsFESyY1Nn5OMC4RLGV2yY=;
        b=4rm3sbLF/dC1nwbgx05ZOnnr6IRULStcUsiZpVrNglmTpyFibpYbmeCw1oeyHc8QZtkC1B
        XEAeOafHqjKRM1Bw==
To:     Doug Anderson <dianders@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org
Subject: Re: [PATCH printk v5 35/40] tty: serial: kgdboc: use srcu console
 list iterator
In-Reply-To: <CAD=FV=WHEjpL1VYnLRp9Vy300Xd3Tu=u3MOo_rvHCABDTsQFPA@mail.gmail.com>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-36-john.ogness@linutronix.de>
 <CAD=FV=WHEjpL1VYnLRp9Vy300Xd3Tu=u3MOo_rvHCABDTsQFPA@mail.gmail.com>
Date:   Thu, 17 Nov 2022 10:38:07 +0106
Message-ID: <87tu2yncyw.fsf@jogness.linutronix.de>
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

Hi Doug,

On 2022-11-16, Doug Anderson <dianders@chromium.org> wrote:
>> @@ -463,9 +464,14 @@ static void kgdboc_earlycon_pre_exp_handler(void)
>>          * serial drivers might be OK with this, print a warning once per
>>          * boot if we detect this case.
>>          */
>> -       for_each_console(con)
>> +       cookie = console_srcu_read_lock();
>> +       for_each_console_srcu(con) {
>>                 if (con == kgdboc_earlycon_io_ops.cons)
>> -                       return;
>> +                       break;
>> +       }
>> +       console_srcu_read_unlock(cookie);
>> +       if (con)
>> +               return;
>
> Is there truly any guarantee that "con" will be NULL if
> for_each_console_srcu() finishes naturally (AKA without a "break"
> being executed)?

Right now it is true because @con becoming NULL is the exit criteria for
the loop.

> It looks as if currently this will be true but nothing in the comments
> of for_each_console_srcu() nor hlist_for_each_entry_srcu() (which it
> calls) guarantees this, right? It would be nice if that was
> documented, but I guess it's not a huge deal.

Yes, if it is frowned upon that the iterator is used outside the loop,
it would be nice if the for_each macros explicitly provided some hints
in their documentation.

> Also: wasn't there just some big issue about people using loop
> iteration variables after the loop finished?
>
> https://lwn.net/Articles/885941/

Thanks for referencing that article! Indeed if the macros are changed so
that the iterator is defined in the loop, then code like this will
break. But I would expect that making such macro changes will also
require updating the call sites to avoid unused variables outside the
loops. And then this code could receive the appropriate fixup.

I feel like if I add extra code to guarantee a NULL without relying on
the macro implementation, I'll get more resistance due to unnecessarily
adding code and variables. But I may be wrong.

> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks.

John
