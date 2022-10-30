Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE6612B54
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 16:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJ3PsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 11:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJ3PsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 11:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E22B1FC;
        Sun, 30 Oct 2022 08:48:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BC65B80EC1;
        Sun, 30 Oct 2022 15:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0402C433D6;
        Sun, 30 Oct 2022 15:48:11 +0000 (UTC)
Date:   Sun, 30 Oct 2022 11:48:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Guenter Roeck <linux@roeck-us.net>
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
        linux-usb@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221030114828.58fdd5d0@gandalf.local.home>
In-Reply-To: <5ee0b72c-3942-8981-573f-73d97ea7ef08@roeck-us.net>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.983388020@goodmis.org>
        <4e61935b-b06b-1f2d-6c2b-79bdfd569cd6@roeck-us.net>
        <20221028140129.040d9acc@gandalf.local.home>
        <20221028141007.05f5c490@gandalf.local.home>
        <20221028195959.GA1073367@roeck-us.net>
        <20221029145241.GA3296895@roeck-us.net>
        <20221029151952.076821f2@gandalf.local.home>
        <5ee0b72c-3942-8981-573f-73d97ea7ef08@roeck-us.net>
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

On Sat, 29 Oct 2022 15:56:25 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> >> WARNING: CPU: 0 PID: 9 at lib/debugobjects.c:502 debug_print_object+0xd0/0x100
> >> ODEBUG: free active (active state 0) object type: timer_list hint: neigh_timer_handler+0x0/0x480
> >>
> >> That happens with almost every test, so I may have missed some others
> >> in the noise.  
> > 
> > Can you add this?
> >   
> 
> It doesn't make a difference.

Ah, it also requires this (I have other debugging in that file, so it may
only apply with some fuzzing):

-- Steve


diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ac2e8beb4235..f2ccf24a8448 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1282,6 +1296,11 @@ int __del_timer(struct timer_list *timer, bool free)
 			debug_timer_deactivate(timer, true);
 		}
 		raw_spin_unlock_irqrestore(&base->lock, flags);
+	} else if (free) {
+		base = lock_timer_base(timer, &flags);
+		timer->function = NULL;
+		debug_timer_deactivate(timer, true);
+		raw_spin_unlock_irqrestore(&base->lock, flags);
 	}
 
 	return ret;
