Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46C662D90E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiKQLJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbiKQLIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:08:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55BD69DEF;
        Thu, 17 Nov 2022 03:08:14 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668683293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fM6pYfjkvRx7D7oK5QPuCSEfKgQ75z+OzhgRrY5Yew0=;
        b=NHfM5e69zJKKBVggrBKMdzCfCQ/i0woaUHO1FuTmngDf6Enqb3JsIZ5OslxwnAjQaI5YnF
        2fyOkINghdiSpnDop2rk5F1FCadPVLEiYjRD9shRNBjzEBkQe3pKtMakInkjLEubdyfadX
        CKnygxiBuqGR+qkcO4YIDgFUo/67kb8yc+FazMktocPrN2HR65KngYoBpFmoKT4x3yLobC
        hlZAt0vuzLQw2tsfrQ+sHg+U4NwpsJBjSM8eWRaQfJqvD1TsbI5Gk/3Y+AxIjjAQeK1Wf6
        vG7s1rP4bMgrdVKNWHYnpfPlh1STzAphJo3fL84enaSIWWmhZpnfSENZNSXeZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668683293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fM6pYfjkvRx7D7oK5QPuCSEfKgQ75z+OzhgRrY5Yew0=;
        b=2VKA10Ovb0d8YDLPtBnjaYd9pwyjhK6e+g1zXJWgFLQB0TUpM7kQQM/siDEKLe9NLpdKQX
        1C2bbwpsn4uPCEAw==
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
Subject: Re: [PATCH printk v5 38/40] tty: serial: kgdboc: use
 console_list_lock to trap exit
In-Reply-To: <CAD=FV=VouG3ihFCg4gC3dNFs7TqzpDgowHd38y8fR8qiTfRw_A@mail.gmail.com>
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-39-john.ogness@linutronix.de>
 <CAD=FV=VouG3ihFCg4gC3dNFs7TqzpDgowHd38y8fR8qiTfRw_A@mail.gmail.com>
Date:   Thu, 17 Nov 2022 12:14:09 +0106
Message-ID: <87mt8pon3a.fsf@jogness.linutronix.de>
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

On 2022-11-16, Doug Anderson <dianders@chromium.org> wrote:
>>         /*
>> -        * Hold the console_lock to guarantee that no consoles are
>> +        * Hold the console_list_lock to guarantee that no consoles are
>>          * unregistered until the kgdboc_earlycon setup is complete.
>>          * Trapping the exit() callback relies on exit() not being
>>          * called until the trap is setup. This also allows safe
>>          * traversal of the console list and race-free reading of @flags.
>>          */
>> -       console_lock();
>> +       console_list_lock();
>>         for_each_console(con) {
>>                 if (con->write && con->read &&
>>                     (con->flags & (CON_BOOT | CON_ENABLED)) &&
>
> Officially don't we need both the list lock and normal lock here since
> we're reaching into the consoles?

AFAICT the only synchronization we need here is iterating the console
list, reading con->flags of a registered console, and modifying
con->exit of a registered console. The console_list_lock provides
synchronization for all of these things. By the end of this series the
console_lock does not provide synchronization for any of these things.

Is there something else that requires synchronization here?

After this series the console_lock is still responsible for:

- serializing console->write() callbacks
- stopping console->write() callbacks
- stopping console->device() callbacks
- synchronizing console->seq
- synchronizing console->dropped
- synchronizing the global @console_suspended
- providing various unclear protection for vt consoles
- some bizarre misuses in bcache

The scope may be larger than the above list. The investigation is still
ongoing.

John
