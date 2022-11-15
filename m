Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA76762978A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiKOLei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbiKOLeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:34:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3AD27FE3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:33:21 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668511998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84NxScZ/MpXsb6BzINZ3D5GdsaYfcLEsVFFGhZDaqNs=;
        b=ts5xpgloRXL6Bunef+ZM/bPFUqmdLJR9Fj0gjVcG20l9/BfANk1rz82SZRCUgQBgX//850
        Ap8HafTsPFCj2AZHXPDPDECyWxITIwYNjLlyZjk+vNMGyA6YiXfGcyISY7CF+L74gx8zjF
        4vIZkUAgwW+wI3Mxq2O4of7SB6H3KQV6gjlB02xGpAwHEYy+OVvZNvV7J2jnfwQZQN/hsm
        jEB9UlqjTJ+5sI917o0GbbI6iSCAxrzY594W+Usbq0C4XkPco6HrTnk/seqmXyYJOPgwGz
        FD8Wl6tTIwTT395I1vX0WbWGVFAPljWiELKwlWH3JJebNigzm9l/v5W9A4dsOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668511998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=84NxScZ/MpXsb6BzINZ3D5GdsaYfcLEsVFFGhZDaqNs=;
        b=fDpUTw9c7fbDdNnYcH2Vuqv+sl7xjT616YBgKGInE1iEr7jAFZA1j8ks1dC3zwkU+1T7Lr
        2PYhwVIbuP7HqNAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH printk v4 03/39] printk: Prepare for SRCU console list
 protection
In-Reply-To: <Y3Nu+Bd/SWsYn8Sp@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-4-john.ogness@linutronix.de>
 <Y3Nu+Bd/SWsYn8Sp@alley>
Date:   Tue, 15 Nov 2022 12:39:18 +0106
Message-ID: <875yfgo3k1.fsf@jogness.linutronix.de>
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

On 2022-11-15, Petr Mladek <pmladek@suse.com> wrote:
> On Mon 2022-11-14 17:34:56, John Ogness wrote:
>> Provide an NMI-safe SRCU protected variant to walk the console list.
>> 
>> Note that all console fields are now set before adding the console
>> to the list to avoid the console becoming visible by SCRU readers
>> before being fully initialized.
>> 
>> This is a preparatory change for a new console infrastructure which
>> operates independent of the console BKL.
>> 
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3254,7 +3303,7 @@ int unregister_console(struct console *console)
>>  		return -ENODEV;
>>  	}
>>  
>> -	hlist_del_init(&console->node);
>> +	hlist_del_init_rcu(&console->node);
>
> This should be hlist_del_rcu() here so that a list walker that it just
> processing this console could see the rest of the list.

hlist_del_init_rcu() does not prevent the rest of the list from being
seen. It only unlinks @pprev for future iterators.

> It seems that hlist_unhashed() checks only node.pprev pointer
> so that we even do not need to initialize it.
>
> We discussed this in v3 in the patch implementing
> console_force_preferred_locked(), see
> https://lore.kernel.org/r/Y20aBwNWT19YDeib@alley.
> I forgot that unregister_console() might have the same problem.

For console_force_preferred_locked() it was about making sure that the
console always appears registered, even though it is temporarily removed
from the console list.

For unregister_console() we want it to be seen as removed from the
console list.

John
