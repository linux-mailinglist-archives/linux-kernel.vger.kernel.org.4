Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D51663131
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjAIUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbjAIUP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:15:57 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 86E66FF1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:15:52 -0800 (PST)
Received: (qmail 648577 invoked by uid 1000); 9 Jan 2023 15:15:51 -0500
Date:   Mon, 9 Jan 2023 15:15:51 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com>,
        WeitaoWang-oc@zhaoxin.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, khalid.masum.92@gmail.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in __usb_hcd_giveback_urb (2)
Message-ID: <Y7x19w/sEvQyfi9C@rowland.harvard.edu>
References: <0000000000002fc8dc05ef267a9f@google.com>
 <Y49h3MX8iXEO/na+@rowland.harvard.edu>
 <cac60598-5080-5876-d28d-e8caab8b9b0f@suse.com>
 <Y5IhgenNzQXzbWqT@rowland.harvard.edu>
 <8e60fa70-15f5-e438-cb49-d3d2281bc975@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e60fa70-15f5-e438-cb49-d3d2281bc975@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning to an old discussion...

On Mon, Dec 12, 2022 at 01:29:24PM +0100, Oliver Neukum wrote:
> 
> 
> On 08.12.22 18:40, Alan Stern wrote:
> > On Thu, Dec 08, 2022 at 03:36:45PM +0100, Oliver Neukum wrote:
> > > On 06.12.22 16:38, Alan Stern wrote:
> 
> > It's hard to tell what's really going on.  Looking at
> > xpad_stop_output(), you see that it doesn't do anything if xpad->type is
> > XTYPE_UNKNOWN.  Is that what happened here?
> 
> The output anchor in xpad was used. So I have to answer that in the negative.
> > I can't figure out where the underlying race is.  Maybe it's not
> > directly connected with anchors after all.
> > 
> > > As far as I can tell the order we decrease use_count is correct. But:
> > > 
> > > 6ec4147e7bdbd (Hans de Goede             2013-10-09 17:01:41 +0200 1674)        usb_anchor_resume_wakeups(anchor);
> > > 94dfd7edfd5c9 (Ming Lei                  2013-07-03 22:53:07 +0800 1675)        atomic_dec(&urb->use_count);
> > > 
> > > Do we need to guarantee memory ordering here?
> > 
> > I don't think we need to do anything more.  usb_kill_urb() is careful to
> > wait for completion handlers to finish, and we already have
> 
> By checking use_count
> 
> > smp_mb__after_atomic() barriers in the appropriate places to ensure
> > proper memory ordering.
> 
> Do we? Looking at __usb_hcd_giveback_urb():
> 
>         usb_unanchor_urb(urb);
> 
> This is an implicit memory barrier
> 
>         if (likely(status == 0))
>                 usb_led_activity(USB_LED_EVENT_HOST);
> 
>         /* pass ownership to the completion handler */
>         urb->status = status;
>         /*
>          * This function can be called in task context inside another remote
>          * coverage collection section, but kcov doesn't support that kind of
>          * recursion yet. Only collect coverage in softirq context for now.
>          */
>         kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
>         urb->complete(urb);
>         kcov_remote_stop_softirq();
> 
>         usb_anchor_resume_wakeups(anchor);
>         atomic_dec(&urb->use_count);
>         /*
>          * Order the write of urb->use_count above before the read
>          * of urb->reject below.  Pairs with the memory barriers in
>          * usb_kill_urb() and usb_poison_urb().
>          */
>         smp_mb__after_atomic();
> 
> That is the latest time use_count can go to zero.
> But what is the earliest time the CPU could reorder setting use_count to zero?
> Try as I might the last certain memory barrier I can find in this function
> is usb_unanchor_urb().
> That means another CPU can complete usb_kill_urb() before usb_anchor_resume_wakeups()
> runs.
> 
>         usb_anchor_resume_wakeups(anchor);
> 
> I think we need a memory barrier here, too.
> 
>         atomic_dec(&urb->use_count);

Please comment on the proposed patch below.

Alan Stern


Index: usb-devel/drivers/usb/core/hcd.c
===================================================================
--- usb-devel.orig/drivers/usb/core/hcd.c
+++ usb-devel/drivers/usb/core/hcd.c
@@ -1563,13 +1563,19 @@ int usb_hcd_submit_urb (struct urb *urb,
 		usbmon_urb_submit_error(&hcd->self, urb, status);
 		urb->hcpriv = NULL;
 		INIT_LIST_HEAD(&urb->urb_list);
-		atomic_dec(&urb->use_count);
 		/*
-		 * Order the write of urb->use_count above before the read
-		 * of urb->reject below.  Pairs with the memory barriers in
-		 * usb_kill_urb() and usb_poison_urb().
+		 * urb->use_count acts like a refcount, so decrementing it to
+		 * 0 must be ordered after earlier accesses (pairs with the
+		 * implicit control dependencies in the wait conditions of
+		 * usb_kill_urb() and usb_poison_urb()).  Also, the decrement
+		 * must be ordered before the read of urb->reject below
+		 * (pairs with the memory barriers in those same routines).
+		 *
+		 * Get the effect of full memory barriers before and after
+		 * the decrement by using atomic_dec_return() instead of a
+		 * simple atomic_dec().
 		 */
-		smp_mb__after_atomic();
+		atomic_dec_return(&urb->use_count);
 
 		atomic_dec(&urb->dev->urbnum);
 		if (atomic_read(&urb->reject))
@@ -1672,13 +1678,19 @@ static void __usb_hcd_giveback_urb(struc
 	kcov_remote_stop_softirq();
 
 	usb_anchor_resume_wakeups(anchor);
-	atomic_dec(&urb->use_count);
 	/*
-	 * Order the write of urb->use_count above before the read
-	 * of urb->reject below.  Pairs with the memory barriers in
-	 * usb_kill_urb() and usb_poison_urb().
+	 * urb->use_count acts like a refcount, so decrementing it to
+	 * 0 must be ordered after earlier accesses (pairs with the
+	 * implicit control dependencies in the wait conditions of
+	 * usb_kill_urb() and usb_poison_urb()).  Also, the decrement
+	 * must be ordered before the read of urb->reject below
+	 * (pairs with the memory barriers in those same routines).
+	 *
+	 * Get the effect of full memory barriers before and after
+	 * the decrement by using atomic_dec_return() instead of a
+	 * simple atomic_dec().
 	 */
-	smp_mb__after_atomic();
+	atomic_dec_return(&urb->use_count);
 
 	if (unlikely(atomic_read(&urb->reject)))
 		wake_up(&usb_kill_urb_queue);
Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -726,6 +726,10 @@ void usb_kill_urb(struct urb *urb)
 
 	usb_hcd_unlink_urb(urb, -ENOENT);
 	wait_event(usb_kill_urb_queue, atomic_read(&urb->use_count) == 0);
+	/*
+	 * The test of urb->use_count creates a control dependency
+	 * ordering the wait_event() call against any later writes.
+	 */
 
 	atomic_dec(&urb->reject);
 }
@@ -776,6 +780,10 @@ void usb_poison_urb(struct urb *urb)
 
 	usb_hcd_unlink_urb(urb, -ENOENT);
 	wait_event(usb_kill_urb_queue, atomic_read(&urb->use_count) == 0);
+	/*
+	 * The test of urb->use_count creates a control dependency
+	 * ordering the wait_event() call against any later writes.
+	 */
 }
 EXPORT_SYMBOL_GPL(usb_poison_urb);
 
