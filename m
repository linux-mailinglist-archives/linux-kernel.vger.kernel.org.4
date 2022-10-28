Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB17611D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 00:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJ1Wfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 18:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ1Wfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 18:35:52 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B39B18E8;
        Fri, 28 Oct 2022 15:35:51 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.50.127])
        by linux.microsoft.com (Postfix) with ESMTPSA id 276AB20B929B;
        Fri, 28 Oct 2022 15:35:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 276AB20B929B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1666996551;
        bh=FjTYwYG/yT38BJ0HRwf1aqY9FAL/BiaQsrP111E+fBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHaQB8Ld1l0l3pxblItKrUBqrLpTKIbf1Z5EZp30OFgQZhpoQFMW0pS9YKTVzdmhH
         EFMHsjnDQzMiYVZJLYUTD718LZ0qIFgMp6+A9Vijt0ZoudDXvkYcoZAWmukjjTcSZ+
         5NGbEITmq4eAjodp/l3RYYhxHtK3bBL8BRsQadUo=
Date:   Fri, 28 Oct 2022 15:35:45 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        dcook@linux.microsoft.com, alanau@linux.microsoft.com,
        linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing/user_events: Fixup enable faults asyncly
Message-ID: <20221028223545.GA182@W11-BEAU-MD.localdomain>
References: <20221027224011.2075-1-beaub@linux.microsoft.com>
 <20221027224011.2075-3-beaub@linux.microsoft.com>
 <7697b674-1dab-4995-9589-9dfb2a65bb73@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7697b674-1dab-4995-9589-9dfb2a65bb73@efficios.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 06:07:34PM -0400, Mathieu Desnoyers wrote:
> On 2022-10-27 18:40, Beau Belgrave wrote:
> > When events are enabled within the various tracing facilities, such as
> > ftrace/perf, the event_mutex is held. As events are enabled pages are
> > accessed. We do not want page faults to occur under this lock. Instead
> > queue the fault to a workqueue to be handled in a process context safe
> > way without the lock.
> 
> Good stuff! On my end, I've progressed on the "side" userspace
> instrumentation library prototype. It implements the static instrumentation
> layer to which a simple userspace printf-based tracer connects (for testing
> purposes). All moving parts are wired up now, including the type system and
> RCU to protect callback iteration against concurrent userspace tracer
> registration/unregistration.
> 

Cool!

> The top bit of the "enable" words are reserved for user events. So you can
> see the "TODO" where the user events ioctl/writev would be expected:
> 
> https://github.com/compudj/side
> 

I'll check this out!

> I'm still slightly unsure about using "uint32_t" for enable check, or going
> for "unsigned long". The core question there is whether a 32-bit word test
> would cause partial register stalls on 64-bit architectures. Going for
> unsigned long would require that user events receives information about the
> bitness of the word as input from userspace. (bit=63 rather than 31).
> Perhaps this is something the user events ABI should accommodate by
> reserving more than 5 bits to express the target bit ?
> 

Yeah, I thought about this. From the user side you can actually use any
arbitrary bits you want by passing a 32-bit aligned value. So you could
take the lower or top half of a 64-bit value. The reason I limit to 0-31
bits is to ensure no page straddling occurs. Futex also does this, check
out get_futex_key() in kernel/futex/core.c.

I would recommend trying out uint64 but give the upper half to
user_events ABI and checking if that works for you if you want say 63
bits to user space. You'd tell the ABI bit 31, but in user space it
would be bit 63.

> > 
> > The enable address is disabled while the async fault-in occurs. This
> > ensures that we don't attempt fault-in more than is necessary. Once the
> > page has been faulted in, the address write is attempted again. If the
> > page couldn't fault-in, then we wait until the next time the event is
> > enabled to prevent any potential infinite loops.
> 
> So if the page is removed from the page cache between the point where it is
> faulted in and the moment the write is re-attempted, that will not trigger
> another attempt at paging in the page, am I correct ?
> 

If we fault and the fixup user fault fails still with retries, then we
give up until the next enablement of that site.

However, if we fault and the fixup user fault with retries works, and
then we fault again trying to write, that will retry.

> I would think this is unexpected. I would expect that failing to fault in
> the page would stop any further attempts, but simply failing to pin the page
> after faulting it in should simply try again.
> 

The issue I repro is mmap() register the enable at that location, then
unmap(). All the faulting errors just tell you -EFAULT in this case,
even though it was maliciously removed. In this case you could get the
kernel to infinite loop trying to page it in.

> Thoughts ?
> 

We need to have some sanity toward giving up faulting in data that never
will make it. The code currently assigns that line to if
fixup_user_fault with retries fails, we give up. pin_user_pages_remote
will not stop it from being attempted again.

> Thanks,
> 
> Mathieu
> 

Thanks,
-Beau
