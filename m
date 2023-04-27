Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D96F088C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbjD0Pnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbjD0Png (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:43:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7D2D72
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:43:33 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682610211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awrbgIW45PNieWkz8I2v7ZUyJUo+zTbm6E/Z9tnMn0Y=;
        b=feyS+KwuzOzf3l1QlKmNBa+DlMCV0miXNy63x5rqsVwf7XZoSGiGdbp7rUpFcvI9Y8r/UD
        /waqBEWpBSSs1Gkf6w2eO1dXbJHRUiSfvxRh2dDQir7bAnQ3mT1qv6lsBWSIw0INEbiNbj
        HHQsBfwpHR70DRS3bI6AYnj1PjM66iFjKYiVaSnlPIld0k2gcOfM4whmNdfC7OA5a5GZEP
        v4g9wKNmAxY7BwX7VR7Z+pQn45SM7wRi+vivtGQlFU9xtPJpjnI7JKNfY474ZkMRKiOSzT
        g8sNd+i+HPq9exLbaqaVQKv756lWM9HYHlhe9U0f9xp7kqchdTt3kQyl5S92+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682610211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=awrbgIW45PNieWkz8I2v7ZUyJUo+zTbm6E/Z9tnMn0Y=;
        b=v42dA3cWhm79e2PenfciUfCffPUm8apaRhrt1hq1oUNUBvl/z6iAVOE6fP4tuBNIfW4EzH
        ODC/YnjDEClxFNAg==
To:     Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v5 2/2] printk: console: Support console-specific loglevels
In-Reply-To: <ZEp9dXwHCYNPidjC@alley>
References: <cover.1682427812.git.chris@chrisdown.name>
 <4d3846bf2543de20aa071b2a12de924eea3e9574.1682427812.git.chris@chrisdown.name>
 <ZEp9dXwHCYNPidjC@alley>
Date:   Thu, 27 Apr 2023 17:47:26 +0206
Message-ID: <87v8hhs57d.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-27, Petr Mladek <pmladek@suse.com> wrote:
>> @@ -2764,7 +2982,8 @@ static void console_prepend_dropped(struct printk_message *pmsg, unsigned long d
>>   * of @pmsg are valid. (See the documentation of struct printk_message
>>   * for information about the @pmsg fields.)
>>   */
>> -static bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>> +static bool printk_get_next_message(struct printk_message *pmsg,
>> +				    struct console *con, u64 seq,
>>  				    bool is_extended, bool may_suppress)
>
> @is_extended has to match @con->flags & CON_EXTENDED. It would be
> ugly if the API is not used correctly and they do not match.
>
> Also the "may_suppress" value might be guessed from @con.
>
> I see two solutions:
>
> 1. If we pass @con then @is_extended and @may_suppress parameters
>    are not needed. The values might be guessed. The logic is
>    the following:
>
> 	if (con) {
> 		is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> 		may_suppress = true;
> 	} else {
> 		/* Used only by devkmsg_read(). */
> 		is_extended = true;
> 		may_suppress = false;
> 	}

This is correct, but we also need to keep in mind that the caller of
printk_get_next_message() also needs to know if it is extended, so that
it can know if it should prepend the dropped messages. Although I guess
it doesn't matter if the caller is also reading @con->flags to get the
extended status.

I don't want to move console_prepend_dropped() inside
printk_get_next_message() because then printk_get_next_message() would
be modifying @dropped. The main purpose of printk_get_next_message() was
to locklessly get formatted text, thus simplifying the atomic console
implementation.

>    The drawback is that @con->seq and @seq values might still
>    be inconsistent. But the @seq value must be passed explicitly
>    when called from dev_kmsg() and @con is NULL. Also the explicit
>    @seq parameter will most likely useful also for the
>    con->atomic_write() callback added by John's patchset.
>    The atomic consoles will not use con->seq at all.

Correct. @flags and @loglevel are the _only_ fields that may be read
locklessly.

> 2. We could pass @con_loglevel instead of @con. And pass it to
>    suppress_message_printing() instead of @con as well.
>
>    It is probably cleaner solution but the many parameters suck.

We would need to pass console_effective_loglevel(). But yes, 3 separate
parameters when they could be determined from 1 sucks.

> I would personally use the 1st proposal and live with the fact
> that the function would ignore con->seq and use the passed
> @seq instead.

Whitelist: only @flags and @level may be read

I agree that we should go with your 1st proposal. But I would like to
see some comments added into printk_get_next_message() that only @flags
and @level may be considered valid.

John
