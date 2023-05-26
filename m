Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FE4712D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbjEZTNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjEZTNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:13:13 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AB89F13D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 12:13:10 -0700 (PDT)
Received: (qmail 301648 invoked by uid 1000); 26 May 2023 15:13:09 -0400
Date:   Fri, 26 May 2023 15:13:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Roy Luo <royluo@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, raychi@google.com,
        badhri@google.com,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
Message-ID: <b1327e17-3d69-4f56-89f8-dec73af91977@rowland.harvard.edu>
References: <20230525173818.219633-1-royluo@google.com>
 <2023052600-survey-fondness-27ce@gregkh>
 <CA+zupgzTe7pVhByLPVr4tn-94kCMZbzNHxf_iVyTa3qi6bzvAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+zupgzTe7pVhByLPVr4tn-94kCMZbzNHxf_iVyTa3qi6bzvAQ@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:34:44AM -0700, Roy Luo wrote:
> On Thu, May 25, 2023 at 5:50 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Thu, May 25, 2023 at 01:31:17PM -0700, Roy Luo wrote:
> > > Currently the usb core assumes the usb_device that port_dev->child points
> > > to is enumerated and port_dev->child->dev is registered when
> > > port_dev->child is present. Setting port_dev->child early would break this
> > > fundamental assumption, hence I'm a bit reluctant to go this way.
> >
> > Well, you could remove that assumption by adding a "child_is_registered"
> > flag and explicitly checking it.
> >
> > Alan Stern
> 
> Agree that's doable, with the following overheads:
> 1. We can no longer safely access port_dev->child without checking
>     "child_is_registered", and there are plenty of places in the usb core that
>     touch port_dev->child. The implicit assumption could also hurt code
>     maintainability.

That doesn't sound like a big deal.  Currently you can't safely access 
port_dev->child without checking whether it is non-NULL.  You would just 
have to replace one check with another.

The fact that plenty of places touch port_dev->child indicates someone 
must have given some thought to protection against racing accesses.  
Your modifications should be able to benefit from that thought.

> 2. In the worst case where enumeration keeps failing, the retry loop in
>     hub_port_connect() would frequently hold device_state_lock in order
>     to link/unlink the usb_device to port_dev->child.
> This would definitely make sense if more places need port_dev->child early.
> However, we only need port_dev->child->state at this point, so it does not
> seem like a good deal to me.

Another alternative -- possibly a much simpler one -- is to replicate 
port_dev->child->state in port_dev->state, purely for use by the new 
sysfs routine.  In other words, keep the actual value there instead of a 
pointer to some other location that might get deallocated at any time.

Since presumably you don't care about precise synchronization (that is, 
it doesn't matter if the value shown in the sysfs file is a few tens of 
milliseconds out of date) you could do this without extra locking.  Just 
use WRITE_ONCE() for updates and READ_ONCE() to see what the current 
value is.

Alan Stern
