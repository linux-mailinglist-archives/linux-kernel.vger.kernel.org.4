Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36706CEBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjC2OjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjC2Oi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8079AF0A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:35:38 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680100535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8HCoWe26WB6mYdY1Qj5FxD340fO9b4OxYYITS6CTEU=;
        b=h+OmzYbxL4GiZRmmHXw58FkZsn9ciSiEgMvKxCmb94YhWN2ftaTWv946prncpJcBkwBSNr
        kjIC7Kt8o/EjzSS85itVXvBMEszTvYO1sR+urk8knbLmlGf9lA2/x7D4VlpAHHNctLJ9PJ
        SbprbnTpEdf9W4a77pT93zK8YDO3f+z725a5s2mOpwrLF54OhdL5CvNr5M2LySOfETWZPr
        9ure0+iS0ProDo8fIaUTrwMseuUJW8nP+hAoeIHWbJOM8wUtyheHScIXGpOVjy93cIReoc
        ake0AjHh+D+2rrEoU29vCRQG2ZsP9c5uI14ghvWtbmrZmIzh1c677NKYVGxuBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680100535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i8HCoWe26WB6mYdY1Qj5FxD340fO9b4OxYYITS6CTEU=;
        b=5YCU47N9ZfouEO0MVDVgvYD0fx7wYKzk9kWmsBV/G+RmrqBCwqG7ftpo+jBPcMO0xr3cY1
        /hxo+YMd4yndHiBg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: buffer write race: Re: [PATCH printk v1 09/18] printk: nobkl:
 Add print state functions
In-Reply-To: <ZCRD7oOcTzOM5cXe@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-10-john.ogness@linutronix.de>
 <ZCRD7oOcTzOM5cXe@alley>
Date:   Wed, 29 Mar 2023 16:39:54 +0206
Message-ID: <87edp7pqy5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-29, Petr Mladek <pmladek@suse.com> wrote:
>> +/**
>> + * console_can_proceed - Check whether printing can proceed
>> + * @wctxt:	The write context that was handed to the write function
>> + *
>> + * Returns:	True if the state is correct. False if a handover
>> + *		has been requested or if the console was taken
>> + *		over.
>> + *
>> + * Must be invoked after the record was dumped into the assigned record
>> + * buffer
>
> The word "after" made me think about possible races when the record
> buffer is being filled. The owner might loose the lock a hostile
> way during this action. And we should prevent using the same buffer
> when the other owner is still modifying the content.
>
> It should be safe when the same buffer might be used only by nested
> contexts. It does not matter if the outer context finishes writing
> later. The nested context should not need the buffer anymore.
>
> But a problem might happen when the same buffer is shared between
> more non-nested contexts. One context might loose the lock a hostile way.
> The other context might get the access after the hostile context
> released the lock.

Hostile takeovers _only occur during panic_.

> NORMAL and PANIC contexts are safe. These priorities have only
> one context and both have their own buffers.
>
> A problem might be with EMERGENCY contexts. Each CPU might have
> its own EMERGENCY context. We might prevent this problem if
> we do not allow to acquire the lock in EMERGENCY (and NORMAL)
> context when panic() is running or after the first hostile
> takeover.

A hostile takeover means a CPU took ownership with PANIC priority. No
CPU can steal ownership from the PANIC owner. Once the PANIC owner
releases ownership, the panic message has been output to the atomic
consoles. Do we really care what happens after that?

John
