Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D56987A3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBOWIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBOWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:08:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5853442DFF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:08:07 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676498885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTmEv4aGo/PI71SmLeT4LQDrYsrb3Vc5IGwIPoutFNU=;
        b=0gCI02PipQ8Ad2Jt7byZ3YPtfzjsr1/1iBFWK0f+59zp8tbFhZywb4bEMAAtrVq1IGpX6Z
        OMMyHB8PDMmNjJLXme7wV3ZNv4+ERI/GwtEK/BU8Tkwuq7lT3TfpD27CUgrqlbTd/zkgl8
        ahNYFs649oR8fS9S67yOMXkesvQZvp1IBpkGAUTaYynMcMAsupYHWDzFeHKE1qWFjqxelH
        14kfzXmAcRKQYqkM0iiR+kPjQkEuZgcJ67swC+v8Ne7VcV8yy6Aj+Q+R+1meo2ixtxGSaJ
        Z69WDVvVbJ89fujY3XlSi05kNnUgXl33t53tsuqUYIvAi2vjgnwx8xXGmrmkvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676498885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTmEv4aGo/PI71SmLeT4LQDrYsrb3Vc5IGwIPoutFNU=;
        b=mjmp4iYmKPKbpIXs8z4/1RUt96sooqbRXUN0H+kFd9bzb4Vdgp3eVng/xS9dv3oDS6gtnm
        EXkWqYuyPGyllfCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tty: ttynull: implement console write
In-Reply-To: <Y+0EnQ/Ujtq+nEFf@alley>
References: <20230214115921.399608-1-michael.thalmeier@hale.at>
 <Y+zEAA1hp+3guGxT@axis.com> <Y+ztReOGJwAbpv52@alley>
 <87y1oz7y9s.fsf@jogness.linutronix.de> <Y+0EnQ/Ujtq+nEFf@alley>
Date:   Wed, 15 Feb 2023 23:12:52 +0106
Message-ID: <87bklu37nn.fsf@jogness.linutronix.de>
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

On 2023-02-15, Petr Mladek <pmladek@suse.com> wrote:
> I agree that the current code is not that bad. But still, the call
> chain is:
>
>   + console_flush_all()
>     + console_emit_next_record()
>       + call_console_driver()
>         + con->write()

Currently in linux-next it is:

   + console_flush_all()
     + console_emit_next_record()
       + con->write()

> I could imagine another code that would call call_console_driver()
> or console_emit_next_record() directly. We might just hope that
> it would check console_is_usable() or con->write pointer before.

It needs to call console_is_usable() for many reasons, not just the NULL
write() pointer check. call_console_driver() is already gone in
linux-next and calling console_emit_next_record() without first checking
if the console is allowed to print would be a clear bug. Perhaps we
should add kerneldoc to console_emit_next_record() mentioning that the
function assumes it is allowed to call con->write() (based on the many
checks in console_is_usable()).

The check for console usability was left outside of
console_emit_next_record() because that is important information needed
by console_flush_all(), not by console_emit_next_record(). In this case
console_is_usable() is being called not only to know if it can call
console_emit_next_record(), but also to know if any usable console
exists at all.

(Perhaps you want ttynull to be considered "usable"? But even if the
answer to that is "yes", then I would move the NULL check out of
console_is_usable() and into console_emit_next_record() so that it
reports success without performing any string-printing.)

> Also, as you say, con->write is immutable. All real consoles have it
> defined. It does not make sense to check it again and again.
> I would leave console_is_usable() for checks that might really
> change at runtime.

Checking a NULL pointer is a lot cheaper than string-printing a console
message to a buffer to send to a dummy function that does not even use
it.

> IMHO, normal console drivers would be useless without write()
> callback.

When atomic consoles are introduced there will be a second
write_atomic() function. Indeed, in the proposed code it is allowed for
either to be NULL because a console driver might be atomic-only or not
support atomic.

> It sounds perfectly fine to reject useless console
> drivers at all. And it sounds like a reasonable check
> in register_console() that would reject bad console drivers.

It is common practice in most subsystems for callback functions that are
not implemented to be initialized to NULL. ttynull shows that there are
valid use cases. With atomic consoles there may be more. I would be more
inclined to NACK a driver with a dummy write()/write_atomic() callback
because it is misleading the subsystem and wasting real CPU cycles.

John Ogness
