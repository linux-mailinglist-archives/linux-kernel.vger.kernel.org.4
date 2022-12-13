Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C972764AC6D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 01:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiLMA00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 19:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiLMAZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 19:25:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706041D0FD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 16:25:00 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670891098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eh5JVjTixRTjJ2DH8YQeyvQFY3GjnYfOh3qLFH+fJyA=;
        b=arLWzn63jNX2hAyhzqN3ACCBLpyfoKKeuFnsEd4jElzZaYw9saOfMsl3+PZFLfwtFU2tPj
        duPtCsuqrHtgd+RaCXZhNfNPyF8N+w0sZixm0mi+6t6AwmA0N+pFCQi+7ENuozn5bKawiL
        SQ1Xw+TNe9Bg8GalI9OMVo5CbHPfhjaITwRUyRw9j9B2O2bw8rlA4KnxFKgZgHMath1LA1
        XPssmhhai8RQ+pYkTPPt3HjjG04JLYqXWkicxlx/dY3MpJPhJ/SyFzCFvnJUDrPZYFDnT7
        C9FvE3urTk5SMLqTQl5NV3oPjYYQ9MgcmJJ+0fQKQbjmYMlIJ/WdYLaJuF8jvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670891098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eh5JVjTixRTjJ2DH8YQeyvQFY3GjnYfOh3qLFH+fJyA=;
        b=DiHIH8v7f8GxUFqrDCGAIZ9ciUGsjJJKia7IM77kJrONdtc/+ZmdhPQL1FnUkvDi4wPkwO
        ssDenLG+9wm0OaAw==
To:     stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, luto@kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: strange behavior with sigreturn() to 32bit
In-Reply-To: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
References: <85ca9ae1-d319-ee77-4a71-bc9c7874f2cb@yandex.ru>
Date:   Tue, 13 Dec 2022 01:24:57 +0100
Message-ID: <87zgbsno9y.ffs@tglx>
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

On Sat, Dec 10 2022 at 14:08, stsp wrote:

Can you please Cc LKML on such mails? x86_64@vger.kernel.org is not used
by any x86 maintainer as you can figure out from looking at the
MAINTAINERS file in the kernel.

> I am playing with 32bit compatibility segments, and I am observing
> something very strange.  To demonstrate the problem, I did the change
> to the kernel sigreturn test-case, and it is attached.  The change
> just moves the magic value to EAX and calls an interrupt that produces
> a SIGSEGV.  The SIGSEGV handler prints the needed regs.  This patch
> intentionally adds 0x100000000 to the RIP register, because AFAIK the
> high part or 64bit regs are irrelevant in compatibility mode.
>
> Now with high part of RIP non-zero, we see this:
> $ ./sigreturn_64
> err=0 trapno=d ax=0 ip=100000003

I just applied the patch and on a 6.1 kernel I get:

# ./sigreturn_64 
[OK]	set_thread_area refused 16-bit data
[OK]	set_thread_area refused 16-bit data
[RUN]	Valid sigreturn: 64-bit CS (33), 32-bit SS (2b, GDT)
[OK]	all registers okay
[RUN]	Valid sigreturn: 32-bit CS (23), 32-bit SS (2b, GDT)
[NOTE]	SP: 8badf00d5aadc0de -> 5aadc0de
[OK]	all registers okay
[RUN]	Valid sigreturn: 16-bit CS (37), 32-bit SS (2b, GDT)

  err=0 trapno=d ax=a5f3 ip=6

Let's look at the disassmbly:

0000000000403000 <int3>:
  403000:       8c d1                   mov    %ss,%ecx
  403002:       cc                      int3

0000000000403003 <int31>:
  403003:       b8 f3 a5 00 00          mov    $0xa5f3,%eax
  403008:       cd 31                   int    $0x31

which is expected and correct:

trapno = 0xd = 13 = #GP
ax     = the magic value
ip     = 6 (Offset to the 'int3:' label in the 16bit CS)
err    = 0

Both 'ip' and 'err' are completely correct here. Why?

The #GP's on 403006. Because in 16bit mode the CPU the disassmbly looks
like this:

  403003:       b8 f3 a5	        mov    $0xa5f3,%eax
  403006:	00 00                   add    %al, (%bx, %si)

so 403006 which is offset 6 into the 16bit CS translates to:

      bx[si] += al;

so in my case:

      bx=0x0 si=0x2903e6d0

which is clearly outside of the DS segment limit resulting in a #GP with
error code == 0.

Your observation that running this under GDB changes the behaviour of
the error is completely correct because BX/SI are subject to context. So
depending where the combo points to it results in random behaviour.

So nothing strange to see here, really. You got what you asked for:

> I am playing with ....

Thanks,

        tglx
