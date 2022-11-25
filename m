Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB8C638B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiKYNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiKYNhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:37:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54A5F73
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B133B82ABC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812E5C433D6;
        Fri, 25 Nov 2022 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669383448;
        bh=YFnzICYwYE02ku4GDz5bDZqCn0purKRO5AmdK14XXzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kAxqAXFDYR/CKr29EHHHk9SuAKCVmSOirOnHmcDf6PjOvMwqXtWo9FJm8ort8DTeY
         n2XW6Di6plj88gm67lOoemK/8D7T0jPNSlYFGZjF4upbBqyYQm3pFk4qQ/rKI5cFUa
         JSaWrWKfdlArNV0B9JYF3rbR8kzEmuJjDLvJz7JmCjxoVJwFpzVdttJenq4Oy3P8f8
         MC6tuXb4Qs7ZCvDJT/3bCX0ivycsPFTOkyuImUH6YV4ee9d2sAwQeEEwxlSVaUVIu7
         zC2AcPLJ4FQgo5oV+A3zbXzxXNGZzRAwbIkICuFVnNEr8mqVXysUYhKdfOFlXj71Tn
         n1kR0JT2HYgGg==
Date:   Fri, 25 Nov 2022 22:37:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip] x86/kprobes: Handle removed INT3 in do_int3()
Message-Id: <20221125223724.3c338a81ace95c7fbbca4378@kernel.org>
In-Reply-To: <Y4Bxnw1xev8r7gJY@hirez.programming.kicks-ass.net>
References: <166933854220.2683864.10006153553442313230.stgit@devnote3>
        <Y4Bxnw1xev8r7gJY@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Nov 2022 08:41:19 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Nov 25, 2022 at 10:09:02AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since x86 doesn't use stop_machine() to patch the kernel text,
> > there is a small chance that the another CPU removes the INT3
> > during do_int3(). In this case, if no INT3 notifier callbacks
> > handled that, the kernel calls die() because of a stray INT3.
> 
> Please clarify; how would that happen? Should not everybody modifying
> text take text_mutex ?

The text_mutex doesn't stop executing do_int3() since do_int3() is
an exception and must not be blocked. That mutex is only blocking
the other kernel text modifiers, not INT3 handling.

If there is only kprobe using INT3, this must not happen because
kprobe_int3_handler() always find a struct kprobe corresponding
to the INT3 address. (from this reason, the current code is wrong too)

However, if there are other INT3 callbacks (e.g. alternatives and
ftrace via text_poke_bp*()) managing the INT3, this can happen.
The possible scenario is here;

1. CPU0 hits an INT3 which is managed by text_poke_bp().

2. CPU1 removes the INT3 from the text and *start* calling
   text_poke_sync(). (note that text_poke_sync() will sync core to
    serialize pipeline, thus the memory and dcache already updated)

3. CPU0 calls kprobe_int3_handler(), but it can not find the
   corresponding kprobe from the address. Thus it reads the instruction
   at the address, and find it is not INT3 anymore.

4. CPU0's kprobe_int3_handler() sets the address to the regs->ip,
   and returns 1, which means "this INT3 is handled".

5. CPU0 returns from do_int3() and exit the exception, then it
   handles the do_sync_core() via IPI.

6. CPU1 finish the text_poke_sync().

This works fine, but it is not handled by the INT3 owner's callback.

Oh! maybe we don't need to handle remove INT3 case, because all
callback MUST handle its own INT3. This can be done simply using
text_poke_sync() because it use an IPI, and the IPI is not handled
until all running INT3 handlers exit.

OK, let me update the patch to just drop the removed INT3 handling
from kprobes.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
