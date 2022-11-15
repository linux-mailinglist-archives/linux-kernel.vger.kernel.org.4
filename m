Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A20629F31
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiKOQkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiKOQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:40:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3317727CF1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:40:44 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668530441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/xR+jrAqBn0QmtFB6L1W7zGcypE9YglefwWtVgrPSgA=;
        b=aNjUKlEK6R/6i9SxWa/ZTCuVjX5ILDtArd/mahUfVl/3Zaw4zXjlXKVFaBx9r08rfjvsq0
        /HPK9hJ8KghUCFNowia2H9aVvn/4Sj0bO9GjkbezjKPW557iodZhD86XuUg2y/Cn+ReTPe
        YXYbwZfL9fU+RlrJoxgrLrKRx+06ZxSRDJPRj161713GihNkI31dasOBIcQKBwrCTHDikL
        diZuaV33nvuXjPoB0lujyCBBcxwh30G2Uf4PBXzbhlAGqfR9pCk7UAM+Mo0COVl6QRbLrw
        rs0wH6d6nHszyAgfBgJ5UwHN/hoOOBjQ/1oeKTQNrlJ7vpTzWYWPKsupVTRYJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668530441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/xR+jrAqBn0QmtFB6L1W7zGcypE9YglefwWtVgrPSgA=;
        b=18yaXQKTblvTGshcgQDnEySBGpX6O1eGKiu5M8sioCHa9GEB1KU1ToAyI0MYbmlcWyJTFR
        DXbvKLlm9vNjeVAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
In-Reply-To: <Y3Oxck0/LAHFLYip@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley>
Date:   Tue, 15 Nov 2022 17:47:12 +0106
Message-ID: <87tu30maqf.fsf@jogness.linutronix.de>
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
> On Mon 2022-11-14 17:35:31, John Ogness wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3334,6 +3330,11 @@ void register_console(struct console *newcon)
>>  		 * boot console that is the furthest behind.
>>  		 */
>>  		if (bootcon_registered && !keep_bootcon) {
>> +			/*
>> +			 * Hold the console_lock to guarantee safe access to
>> +			 * console->seq.
>> +			 */
>> +			console_lock();
>>  			for_each_console(con) {
>>  				if ((con->flags & CON_BOOT) &&
>>  				    (con->flags & CON_ENABLED) &&
>> @@ -3341,6 +3342,7 @@ void register_console(struct console *newcon)
>>  					newcon->seq = con->seq;
>>  				}
>>  			}
>> +			console_unlock();
>
> Thinking more about it. This console_unlock() will actually cause
> flushing the boot consoles. A solution would be to call
> console_flush_all() here.

console_flush_all() requires the console_lock, so I don't think it would
be different.

The correct solution would be to recognize if nextcon is taking over a
bootcon. If yes, that bootcon could be unregistered right here with
unregister_console_locked() and then seq for nextcon set appropriately
to perfectly take over.

But we will need to think about how we could recognize the same
device. I was thinking about if consoles hat some attribute showing
their io-membase or something so that it could be clear that the two are
the same hardware.

> And we could/should solve this in a separate patch. This code was not
> locked before. It is a corner case. It could be solved later.

Agreed.

John
