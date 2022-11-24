Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C7A637B95
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 15:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiKXOnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 09:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXOm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:42:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F7363BA5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 06:42:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 85E301F8B3;
        Thu, 24 Nov 2022 14:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669300974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tnDrkdSii3PCQmNaq62QSyqQxDKrs3bL6M/dlK4fjjs=;
        b=o+cE67B786QAeQFF+VBHFx7k+oB8iBjL7yJM2rLqmSCzSAdmqcUFuX91X8rXvBXQZebcnP
        AVBMdNtngGxyyHM7XEPRuCvESQWw7bfWbc0LhWREbEQF/OdLSzO8ci7Lfqw0NvEDr9+aP8
        OpKHU9QRq69fpHCa1bLu9QcOQ2PjuRY=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5507B2C142;
        Thu, 24 Nov 2022 14:42:54 +0000 (UTC)
Date:   Thu, 24 Nov 2022 15:42:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/7] printk: Move buffer size defines
Message-ID: <Y3+C7Znahs3q83wh@alley>
References: <20221123231400.614679-1-john.ogness@linutronix.de>
 <20221123231400.614679-2-john.ogness@linutronix.de>
 <Y39Q5TjoHUUKXC1S@alley>
 <87zgcgttmi.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgcgttmi.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-11-24 13:44:29, John Ogness wrote:
> On 2022-11-24, Petr Mladek <pmladek@suse.com> wrote:
> >> Move the buffer size defines to console.h in preparation of adding a
> >> buffer structure. The new buffer structure will be embedded within
> >> struct console. Therefore console.h was chosen as the new home for
> >> these defines.
> >
> > The buffers are not embedded into struct console in this patchset.
> > Are they going to be added directly or via pointer, please?
> 
> By "embedded" I mean added directly. The buffers need to be available
> immediately and cannot be allocated or assigned dynamically. The console
> struct is generally defined by drivers with:
> 
> static struct console my_console = {
>    ...
> };
> 
> I could think of no way to statically define the buffers but keep their
> sizes hidden.
> 
> > IMHO, it is always better to hide these implementation details
> > in an internal header or source file. It will be possible
> > if struct console contained on a pointer to the buffers.
> 
> The problem is not pointers, it is static definition (without knowing
> the size of the thing that is statically defined). The new thread/atomic
> consoles run in parallel, so they cannot share the single static buffer
> like we do now.

Let me to play a devil advocate first:

Well, allocation is possible long before scheduling is
possible. It is actually available even before early parameters
are proceed where the boot consoles are registered. At least
it is used when setup_log_buf(1) is called in setup_arch() on x86.

The motivation is that only thread/atomic consoles would need
the console-specific buffer. The other consoles might share
the global one.

It would be useful even for atomic consoles. IMHO, most users
use generic kernels that support a variety of hardware. They
would provide static buffers for many console drivers but
only one or two would be used in the end.

Also the atomic consoles would need these buffers for each context.
It might be even more useful to allocate them dynamically.

Or do I miss something, please?


That said:

I do not have any numbers at hands to show how this
is important. Also I do not know if the early allocations
have some limits.

The static buffers might be acceptable for simplicity and
reliability after all.

Feel free to keep them static. I would ack the next version
of this patch after making the CONSOLE_EXT_LOG_MAX dependent
on CONFIG_PRINTK.

Best Regards,
Petr
