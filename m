Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E818265D0A7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 11:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbjADK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 05:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjADK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 05:27:13 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D17272C
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 02:27:11 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1672828029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brMP1WN/E8RUikW0QwpyJ7uyqWjl8zCp5XI5LfxzgPw=;
        b=WJYSAkoViI/7aE/Acylyu9mxN/4yVZaRfCNrP6fLlWz7liQ6v68g3r1Ha1k1i98gs21eki
        Jvc91okqIkI5r6d+Oc0+4vtUBotqZ3uk41jIG2urD8eHxjvGzJAVqKbl/GX9rYCZQEtS/H
        V5hGi/75ylK2AA9igG/NZtVmaocFRPUTky3Ktnkw3dkuQ3NgofKFoqtkGDPGy0Xg8sbKz8
        kb/0kNYHXZPYCGMvjky0vtFvGPadJTHKSycKXGUQyuRX6cnXygBaC0wF8lAP6qeCpQc4yV
        ++1jjaYyCdXHwirdVS0bncc8jq2lqnA8qemQG/W+V+9Nx4ukXQfcEd95gbDhmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1672828029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=brMP1WN/E8RUikW0QwpyJ7uyqWjl8zCp5XI5LfxzgPw=;
        b=JkhczA2M+yu5MCSfnbb7B2J01remHchqrAAy29HJF5HrBmV/JAmiJJ/hYtNbIfQSjA0Xue
        MLYKo04Kv1YwMpBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 5/6] printk: introduce
 console_get_next_message() and console_message
In-Reply-To: <Y7RP5zuALa552AHY@alley>
References: <20221221202704.857925-1-john.ogness@linutronix.de>
 <20221221202704.857925-6-john.ogness@linutronix.de>
 <87bknva1jg.fsf@jogness.linutronix.de> <Y7Q2B+p1gxJ1WCdj@alley>
 <87ilhnd5te.fsf@jogness.linutronix.de> <Y7RP5zuALa552AHY@alley>
Date:   Wed, 04 Jan 2023 11:32:30 +0106
Message-ID: <871qoafve1.fsf@jogness.linutronix.de>
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

On 2023-01-03, Petr Mladek <pmladek@suse.com> wrote:
>> The current atomic console proposal allocates 1x cbuf per-cpu and 4x
>> meta-data per-cpu. Different contexts of a cpu will have different
>> meta-data, but all the contexts of a cpu will share the same cbuf.
>>
>> If cbufs become embedded in cmsg, then we would allocate 1x cmsg
>> per-cpu. But the atomic consoles would still need their own 4x per-cpu
>> meta-data.
>
> Do we really need 4x the meta data?

Having per-context meta-data helps minimize data clobbering. For
example, the message-formatting functions would not need to worry about
@cmsg->len changing underneath them. This can be solved with a
READ_ONCE() to a local variable and the function only using the local
copy, but it will mean more copying of variables.

> The metadata describe the state of the buffer. Using the buffer in one
> context invalidates the metadata in the other context.

Yes, but the message-formatting functions are the ones preparing that
meta-data. They must then be able to handle an interrupting context
changing that meta-data.

>> For v4 I will drop the console_buffers struct. I will use your
>> suggestion.
>
> Please, do not do it just to make me happy. My intention
> is to keep things simple. And keeping the two structures
> synced needs an extra code.
>
> If you are sure that the separation will really be needed
> in the future then feel free to keep the two structures.

Currently the message-formatting functions do not care about clobbering
of the text buffers. They blindly just move things around using the
meta-data as safety boundaries. This can lead to a formatted-buffer that
contains garbage, but an interrupted context will not print that buffer
in the end. The important thing is that the garbage was created safely.

Avoiding a separate console_buffers structure may simplify the
structures, but it requires robustifying the message-formatting
functions to be tolerant for meta-data clobbering.

I am currently implementing such changes to see if it is feasible.

John
