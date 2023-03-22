Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20466C48EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCVLTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVLTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:19:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8CC51F8F;
        Wed, 22 Mar 2023 04:19:17 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679483954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8iNfo1m/FarSv7GkJ5SVeTd4C8nZ1UThrkCcn6d7go=;
        b=xRPFRqOcQwj0x7CZwFXTqkcrau0R08zsjRTPwuu1d/Xxz2kfvm5zuBmnz4/v8Ri/vsRzOn
        wk61NzFFcu2s1x2GWsVkNHOEOFD7DoY07gYBwswgdEs6x267M/Eie3lI5fZPKB/1+goOqg
        aGopr7PRRn8n/hfC06h0oGTaGMmrvhAxSGaGDEe9ygQOavocpWrNu1l8RYNG83BXipB4lg
        z/gWI5b2QmZMW7yv2IzT7heIkJU6+F4AuOSasNAsUqiHuaqLkWiClpb4AEu4WY6HvfUrun
        DifB28GTmn2OZRL5iRFizMbHIHsmzoj31Jzs8VbHgG2LKqGNo9fCb3ohn6CP8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679483954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z8iNfo1m/FarSv7GkJ5SVeTd4C8nZ1UThrkCcn6d7go=;
        b=wnWxfucKn+aqvYau4Onr7kaM+oZEiF4G3hAO80v+8yR3nKEdPeW/BunL9KGRas8zSsWCYb
        cZhTc/W96e/YLEDA==
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ross Zwisler <zwisler@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] tracing: Trace instrumentation begin and end
In-Reply-To: <20230321215121.71b339c5@gandalf.local.home>
References: <20230321215121.71b339c5@gandalf.local.home>
Date:   Wed, 22 Mar 2023 12:19:14 +0100
Message-ID: <87y1np824t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven!

On Tue, Mar 21 2023 at 21:51, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> produces:
>
>  2)   0.764 us    |  exit_to_user_mode_prepare();
>  2)               |  /* page_fault_user: address=0x7fadaba40fd8 ip=0x7fadaba40fd8 error_code=0x14 */
>  2)   0.581 us    |  down_read_trylock();
>
> The "page_fault_user" event is not encapsulated around any function, which
> means it probably triggered and went back to user space without any trace
> to know how long that page fault took (the down_read_trylock() is likely to
> be part of the page fault function, but that's besides the point).
>
> To help bring back the old functionality, two trace points are added. One
> just after instrumentation begins, and one just before it ends. This way,
> we can see all the time that the kernel can do something meaningful, and we
> will trace it.

Seriously? That's completely insane. Have you actually looked how many
instrumentation_begin()/end() pairs are in the affected code pathes?

Obviously not. It's a total of _five_ for every syscall and at least
_four_ for every interrupt/exception from user mode.

The number #1 design rule for instrumentation is to be as non-intrusive as
possible and not to be as lazy as possible.

instrumentation_begin()/end() is solely meant for objtool validation and
nothing else.

There are clearly less horrible ways to retrieve the #PF duration, no?

Thanks,

        tglx



