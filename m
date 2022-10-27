Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D993C61044A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiJ0VV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiJ0VVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:21:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CD85924B;
        Thu, 27 Oct 2022 14:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 438BEB824DD;
        Thu, 27 Oct 2022 21:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2109BC433C1;
        Thu, 27 Oct 2022 21:21:50 +0000 (UTC)
Date:   Thu, 27 Oct 2022 17:22:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org
Subject: Re: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown()
 before freeing timer
Message-ID: <20221027172203.052a2154@gandalf.local.home>
In-Reply-To: <20221027164227.40225b1f@gandalf.local.home>
References: <20221027150525.753064657@goodmis.org>
        <20221027150928.983388020@goodmis.org>
        <Y1rsO2GeGReS0BvU@rowland.harvard.edu>
        <20221027164227.40225b1f@gandalf.local.home>
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

On Thu, 27 Oct 2022 16:42:27 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 27 Oct 2022 16:38:19 -0400
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> > On Thu, Oct 27, 2022 at 11:05:45AM -0400, Steven Rostedt wrote:  
> > > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > > 
> > > Before a timer is freed, del_timer_shutdown() must be called.    
> > 
> > Is this supposed to be true for all timers?  Because the USB subsystem 
> > contains an awful lot more timers than just the two you touched in this 
> > patch.  
> 
> Yes, and this does mean that we are going to have to painstakingly find and
> fix ever one of them. This is why the last patch updates
> DEBUG_OBJECTS_TIMERS to detect cases where I miss.

BTW, as del_timer_shutdown() prevents the timer from being re-armed, there
are lots of timers in the kernel where I did not touch, because I could not
tell if the del_timer_sync() or the buggy del_timer() calls were for it to
be freed, or for some other legitimate reason, and I just stayed well enough
alone.

-- Steve
