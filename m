Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B91E6113D8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiJ1OAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiJ1OAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:00:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6359FB7F42;
        Fri, 28 Oct 2022 07:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 000BA6289B;
        Fri, 28 Oct 2022 14:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF4FC433C1;
        Fri, 28 Oct 2022 14:00:36 +0000 (UTC)
Date:   Fri, 28 Oct 2022 10:00:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221028100052.2e392127@gandalf.local.home>
In-Reply-To: <20221028061422.139c54a7@gandalf.local.home>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.983388020@goodmis.org>
        <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
        <20221028061422.139c54a7@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022 06:14:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 27 Oct 2022 22:23:06 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
 > 
> > A similar call to INIT_DELAYED_WORK() around line 1085 needs the same change.
> > 
> > It would be great if that can somehow be hidden in INIT_DELAYED_WORK().  
> 
> I agree, but the delayed work is such a special case, I'm struggling to
> find something that works sensibly. :-/
>

OK, I diagnosed the issue here. The problem is that delayed work also has no
"shutdown" method when it's done. Which means there's no generic way to
call the work->timer shutdown method. So we have two options to handle
delayed work timers:

  1) Add special initialization for delayed work so that it can just go back
     to the old checking (activating on arming, deactivating by any
     del_timer*).

  2) Implement a shutdown state for the work queues as well. There could
     definitely be the same types of bugs as with timers, where a delayed
     work could be pending on something that's been freed. That's probably
     why there's a DEBUG_OBJECTS_WORK too.

Ideally, I would like to have #2, but realistically, I'm going for #1 for
now. We could always add the work queue shutdown state later if we want.

The problem with timers with respect to delayed work queues, is that there's
no place to add the "shutdown" before its no longer in use. Worse yet,
there's code that caches descriptors that have delayed work instead of
freeing them. (See block/blk-mq.c and drivers/scsi/scsi_lib.c with the queuelist).
Where it just calls del_timer(), and then sends it back to the free store
for reuse later. Perhaps we should add DEBUG_OBJECTS checking to these too?

Anyway, I'll make it where the INIT_DELAYED_WORK will call
__timer_init_work() that will set the debug state in the timer to
TIMER_DEBUG_WORK, were it will activate and deactivate the debug object on
add_timer() and del_timer() and hope that it's not one of the bugs we are
hitting :-/

-- Steve
