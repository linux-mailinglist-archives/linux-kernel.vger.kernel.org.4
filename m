Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001545E7D88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiIWOtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbiIWOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:49:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB816173
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:49:32 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663944569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6vWV1NcdsRT1G0MkTaLGR8EOz2Gy1O+tFM9kXzKnCA=;
        b=2B0ML79ULrTrCXYGVxfZlXQlg/bWv6Oe/6n7YfZZRm5tchsC81j/GhTnsqnLScyZSfir9P
        1nZdQdK368kNz4pWdlwAkFTOOMCqqzNOi3SijstQpwtlgCwjjg+PxZXBTNujGme1jtg71x
        5q1k1YjR650k9fLDNRjG0e5rq6Qobp/KL2VIGqy1FAN+d/KmfmjW5WDKzG9dcNSwJhTqgB
        XF5pSiyglAU4C+qntSKCNC1zN1wD5gCC+sgpNm8ubg1EpL6Fkme6av9fdVXCt/z5cvtNAQ
        R7hJa4ENPcYMEmGx6/HlOpHjqVV3LS1erIK/lcraqAsdpuw2/3gs/ZQRs7pXjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663944569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q6vWV1NcdsRT1G0MkTaLGR8EOz2Gy1O+tFM9kXzKnCA=;
        b=mcCUidEUwuH7VNWJ/nrqvswAbJUDsLUtEBhti+33YssyXHNm3dVzX3P3ovjCt1Bc1oQENd
        M3NnRHNpDphaCnDQ==
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        John Kacur <jkacur@redhat.com>,
        "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: printk meeting at LPC 2022
In-Reply-To: <87h71cr1gb.fsf@jogness.linutronix.de>
References: <20220910221947.171557773@linutronix.de>
 <87h71cr1gb.fsf@jogness.linutronix.de>
Date:   Fri, 23 Sep 2022 16:55:28 +0206
Message-ID: <875yheqh6v.fsf@jogness.linutronix.de>
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

Hi,

On 2022-09-12, John Ogness <john.ogness@linutronix.de> wrote:
> We now have a room/timeslot [0] where Thomas and I will be presenting
> and discussing this new approach [1] for bringing kthread and atomic
> console printing to the kernel.

Thanks to everyone who attended the meeting (in person and virtually)!
It was a productive and fun discussion that left me thinking we will get
the printk threading right this time.

Here are the main points that I took away from the meeting:

- Printing the backlog is important! If some emergency situation occurs,
  make sure the backlog gets printed.

- When an emergency occurs, put the full backtrace into the ringbuffer
  before flushing any backlog. This ensures that the backtrace makes it
  into the ringbuffer in case a panic occurs while flushing the backlog.

- A newline should be added when an atomic console takes over from a
  threaded console. This improves readability. We may decide later that
  the atomic console prints some extra information upon takeover, or
  that it completes the line the threaded console was printing. But for
  now we will just use a newline to keep things simple.

- It should be visible to users and in crash reports if legacy consoles
  were in use. It was suggested that a new TAINT flag could be used for
  this.

- There will need to be new console flags introduced so that safe
  printing decisions can be made in emergency and panic situations.

  For example, upon panic, intially only the consoles marked RELIABLE
  would be used. If any of the RELIABLE consoles required a hostile
  takeover, they would only be used if they are labeled to support safe
  hostile takeovers.

  All other consoles could then be tried as a "last hope" at the very
  end of panic(), after all records have been flushed to reliable
  consoles and when it no longer matters if a console kills the CPU. For
  non-panic emergencies (warn, rcu stalls, etc), there may be other
  flags that would be needed.

  Initially we do not plan to have any such flags. We can add them on an
  as-needed basis as console drivers are moved over to the new
  thread/atomic interface.

If I have missed anything relevant, please let me know.

John Ogness

> [0] https://lpc.events/event/16/contributions/1394/
> [1] https://lore.kernel.org/all/20220910221947.171557773@linutronix.de/
