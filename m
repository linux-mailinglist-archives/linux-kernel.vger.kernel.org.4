Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AA6108A1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 05:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiJ1DRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 23:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbiJ1DRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 23:17:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DCA59E9B;
        Thu, 27 Oct 2022 20:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4D975CE1346;
        Fri, 28 Oct 2022 03:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01D7C433D6;
        Fri, 28 Oct 2022 03:17:11 +0000 (UTC)
Date:   Thu, 27 Oct 2022 23:17:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221027231727.4469d81c@gandalf.local.home>
In-Reply-To: <20221028021815.3130-1-hdanton@sina.com>
References: <20221027150525.753064657@goodmis.org>
        <20221028021815.3130-1-hdanton@sina.com>
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

On Fri, 28 Oct 2022 10:18:15 +0800
Hillf Danton <hdanton@sina.com> wrote:

> On 27 Oct 2022 11:05:45 -0400 Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -1261,6 +1261,9 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
> >  
> >  		/* Don't do a long sleep inside a workqueue routine */
> >  		if (type == HUB_INIT2) {
> > +			/* Timers must be shutdown before they are re-initialized */
> > +			if (hub->init_work.work.func)
> > +				del_timer_shutdown(&hub->init_work.timer);  
> 
> This is not needed in the workqueue callback as the timer in question
> is not pending.

This was added because of the updates to DEBUG_OBJECTS_TIMERS that changed
it to require a shutdown to remove the activation of the timer. This is to
detect the possibility that a timer may become active just before freeing
(there's way too many bugs that show that code logic is not enough).

This code in particular is troubling because it re-initializes an already
initialized timer with a new function. This causes the debug-objects to
trigger an "object activated while initializing" warning.

I originally added the "shutdown" to deactivate the object before you
re-initialize it. But I have since updated the code to keep track of if it
was ever activated, and if so, not to call the init code again, so this may
not be required anymore.

I'm still trying to work out the kinks as the users of timers have become
adapted to the implementation, and may need to add some other helpers to
make this work.

-- Steve


> 
> >  			INIT_DELAYED_WORK(&hub->init_work, hub_init_func3);
> >  			queue_delayed_work(system_power_efficient_wq,
> >  					&hub->init_work,  

