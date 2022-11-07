Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE2A61E7C3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 01:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiKGAAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 19:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiKGAAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 19:00:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961B0BC2D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 16:00:06 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667779203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goShG6wyU/D9tjdtJUjQxGyx2rUEPMylm2lkHgrimug=;
        b=UOxRQJBJ1D/kWbdQJg4p/blAktOCHIbP7nStu9Nnvj1OG/btcLtpLFq0MPnM0D6Gl8Y6gQ
        6aAuLXdYF8XI5f66a5CPV29JpnR0C0PtR2pBX+nYrhmOhDwzcMXPLPsQQGAyaxvJDheykt
        3PIJIaNBPOGMV4ND74kY6hECtG9ecFy673p+56+Zv7Jk9Nshfqg0ONfjvCYrcmt5RWep90
        vnr8ZdzveYcW4fY3fcDIGTE+26fFD9OnvA+phNPoZFK2w333I/bHDTYhJC50ygAyldWzbs
        Cq5B3CnOagjz7tzUpfWNo2C/wy5YJeTpHBU9nvEGawQkQyzbeZt587ssa8FpgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667779203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goShG6wyU/D9tjdtJUjQxGyx2rUEPMylm2lkHgrimug=;
        b=Jz379XAVJygAYInTKAwUUOzG3nWJJ5pxnRdUoa69w8/sgEiQBZWLflBGfXmDZ3uubHEpg/
        B5DM9gKgvzKRUADQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 27/38] printk: console_flush_all: use srcu
 console list iterator
In-Reply-To: <Y1f+Izra36qQ4ae6@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-28-john.ogness@linutronix.de>
 <Y1f+Izra36qQ4ae6@alley>
Date:   Mon, 07 Nov 2022 01:06:02 +0106
Message-ID: <87a6534osd.fsf@jogness.linutronix.de>
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

On 2022-10-25, Petr Mladek <pmladek@suse.com> wrote:
>>   console_lock()
>>   | mutex_acquire(&console_lock_dep_map)       <-- console lock
>>   |
>>   console_unlock()
>>   | console_flush_all()
>>   | | srcu_read_lock(&console_srcu)            <-- srcu lock
>>   | | console_emit_next_record()
>>   | | | console_lock_spinning_disable_and_check()
>>   | | | | srcu_read_unlock(&console_srcu)      <-- srcu unlock
>>   | | | | mutex_release(&console_lock_dep_map) <-- console unlock
>>
>> @@ -2819,12 +2827,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>>  				/* Extended consoles do not print "dropped messages". */
>>  				progress = console_emit_next_record(con, &text[0],
>>  								    &ext_text[0], NULL,
>> -								    handover);
>> +								    handover, cookie);
>>  			} else {
>>  				progress = console_emit_next_record(con, &text[0],
>>  								    NULL, &dropped_text[0],
>> -								    handover);
>> +								    handover, cookie);
>>  			}
>> +
>> +			/*
>> +			 * If a handover has occurred, the SRCU read lock
>> +			 * is already released.
>> +			 */
>>  			if (*handover)
>>  				return false;
>
> Please, release the SRCU read lock here:
>
> 			if (*handover) {
> 				console_srcu_read_unlock(cookie);
> 				return false;
> 			}
>
> The lock should be released in the same function where it was taken.
> It does not require passing the cookie and looks more straightforward.

It looks more straight forward, but it is incorrect from a locking
perspective.

The locking order was:

console_lock()
console_srcu_read_lock()

But for a handover at this point in code, console_emit_next_record() has
already released the console_lock (to the spinning context). The
console_srcu_read_lock should have been released first.

> We actually do the same when abandon_console_lock_in_panic()
> returns true. We could share the code:
>
> handover_abandon:
> 	console_srcu_read_unlock(cookie);
> 	return false;

This case is different. Here the console_lock was not released yet so it
is fine to perform the console_srcu_read_unlock() here.

John Ogness
