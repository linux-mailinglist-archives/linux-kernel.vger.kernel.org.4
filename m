Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8A261F1A1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiKGLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiKGLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:15:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6EEDF6B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 03:15:45 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667819744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ks74wjsDzqc1arU7J8lzMZXr87mU8v99qH9Cogt/w/8=;
        b=YsMEj0dTiNNIIQikNlk4tjX2YWmwJIDB1wnDA66PHDsgDcSNQPD6aXoOyXBkQgTY4Yk/qH
        OTYOJOVv+Zbs6d+sKjdG3NHK1ZmjuCF+9s+hQPneIa8N0KPe1rVaSse64jSy2GZ36jXDLU
        kcxQSYi22DVBfYMAXwrWpW0qha8J/ODfYxKvguWRCVcHT5ZqrcsXKYQIMxiyJDppRibaop
        tUykzRsSAgS1wCsWwkosqx1wFcmuBFDskU8U1AjaPJPiw6/GmzuZyxMf0uipe+w358KhT3
        AMpUCn+CytBBrKW8EjZhJAN7xObawvwobOgtL1YYADcXASYQ4lZ5YVEopjWoEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667819744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ks74wjsDzqc1arU7J8lzMZXr87mU8v99qH9Cogt/w/8=;
        b=VveFVbwn7EK7ynKoYzIUt3ey/4moh+S7x7w7FUz3T91KRbKHTV5L5wX2Quq0KcdrHNszzi
        gJSmFKHu3M4DGVDA==
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [for-linus][PATCH 4/5] timers: Add timer_shutdown_sync() and
 timer_shutdown() to be called before freeing timers
In-Reply-To: <87sfivvy91.ffs@tglx>
References: <20221106233037.815236769@goodmis.org>
 <20221106233434.425162916@goodmis.org> <87sfivvy91.ffs@tglx>
Date:   Mon, 07 Nov 2022 12:15:43 +0100
Message-ID: <87mt93vwv4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07 2022 at 11:45, Thomas Gleixner wrote:
> On Sun, Nov 06 2022 at 18:30, Steven Rostedt wrote:
>>
>> Link: https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/
>> Link: https://lkml.kernel.org/r/20221106212702.363575800@goodmis.org
>> Link: https://lore.kernel.org/all/20221105060024.598488967@goodmis.org/
>>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Julia Lawall <Julia.Lawall@inria.fr>
>> Tested-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> And please follow the guidelines of the tip tree for changelogs and tags.
>
> I'll just grab it from the list and let my scripts run over it.

Duh. This thing is unreviewable.

Can you please split it up into pieces which are digestable?

Thanks,

        tglx
