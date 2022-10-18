Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3126602600
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJRHlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJRHlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 03:41:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FECC5004F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 00:41:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C01E91F9C5;
        Tue, 18 Oct 2022 07:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666078859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TSAE+c+dsC5XjlOC5IqazzYSnBRPPiiAmvwbhK4wdxE=;
        b=WgzzRjSOd3P0Z2MlpBQ5DMO0OFuNMkf+8kmuZxz2+gKJeSSsQ53UGpaVbGt2LbmpbP32gI
        nl5Wv1ZR9H8YuJOAYfyZ6HrSt+eYRMD1In1wRGTqSwd7Fp6jx5oIqncTgCjNMRuWNJanI8
        PIOWXE+aH0veENzPXxyfmoFf29LwroM=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6B1452C141;
        Tue, 18 Oct 2022 07:40:59 +0000 (UTC)
Date:   Tue, 18 Oct 2022 09:40:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] vsprintf: protect kernel from panic due to
 non-canonical pointer dereference
Message-ID: <Y05Yi7xJ3E8EjnTj@alley>
References: <20221017194447.2579441-1-jane.chu@oracle.com>
 <Y026l2PZgvt+G6p0@smile.fi.intel.com>
 <71c9bce7-cd93-eb2f-5b69-de1a9ffe48b5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71c9bce7-cd93-eb2f-5b69-de1a9ffe48b5@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-10-17 21:12:04, Jane Chu wrote:
> On 10/17/2022 1:27 PM, Andy Shevchenko wrote:
> > On Mon, Oct 17, 2022 at 01:44:47PM -0600, Jane Chu wrote:
> >> While debugging a separate issue, it was found that an invalid string
> >> pointer could very well contain a non-canical address, such as
> > 
> > non-canical?
> 
> Sorry, typo, will fix.
> 
> > 
> >> 0x7665645f63616465. In that case, this line of defense isn't enough
> >> to protect the kernel from crashing due to general protection fault
> >>
> >> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> >>                  return "(efault)";
> >>
> >> So run one more round of check via kern_addr_valid(). On architectures
> >> that provide meaningful implementation, this line of check effectively
> >> catches non-canonical pointers, etc.
> > 
> > OK, but I don't see how this is useful in the form of returning efault here.
> > Ideally we should inform user that the pointer is wrong and how it's wrong.
> > But. It will crash somewhere else at some point, right? 
> Broadly speaking, yes.  It's not a perfect line of defense, but again, 
> the bug scenario is a "cat" of some sysfs attributes that leads to 
> panic. Does it make sense for kernel to protect itself against panic 
> triggered by a "cat" from user if it could?

From my view, the check might be useful. I agree with Andy that the
broken pointer would cause crash later anyway. But the check
in vsprintf() would allow to see a message that the pointer was
wrong before the system crashes.

That said, this was much more important in the past when printk()
called vsprintf() under logbuf_lock. Nested printk() calls
were redirected to per-CPU buffers and eventually lost.

It works better now when printk() uses lockless ringbuffer and
vsprintf() is called twice there. The first call is used
to get the string length so that it could reserve the needed
space in the ring buffer. If vsprintf() crashes during the 1st call
then it would be possible to print the nested Oops messages.


> I mean that there
> > is no guarantee that kernel has protection in every single place against
> > dangling / invalid pointers. One way or another it will crash.
> > 
> > That said, honestly I have no idea how this patch may be considered
> > anything but band-aid. OTOH, I don't see a harm. Perhaps others will
> > share their opinions.
> > 
> 
> 3+ years ago, commit 3e5903eb9cff7 ("vsprintf: Prevent crash when 
> dereferencing invalid pointers") provided the similar level of 
> protection as this patch.  But it was soon revised by commit 
> 2ac5a3bf7042a ("vsprintf: Do not break early boot with probing 
> addresses"), and that's why the string() utility no longer detects 
> non-canonical string pointer.
> 
> I only thought that kern_addr_valid() is less of a heavy hammer, and 
> could be safely deployed.

Hmm, I see that kern_addr_valid() is available (defined) only on some
architectures. This patch would break build on architectures where it
is not defined.

Also it is used only when reading /proc/kcore. It means that it is not
tested during early boot. I wonder if it actually works during
the very early boot.

Result:

The patch is not usable as is.

IMHO, it is not worth the effort to get it working. Especially when
printk() should be able to show Oops inside vsprintf() these days.

Regards,
Petr
