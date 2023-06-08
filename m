Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC34727B29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjFHJZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234107AbjFHJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FF71FCC;
        Thu,  8 Jun 2023 02:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B3E64B4B;
        Thu,  8 Jun 2023 09:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CFDC433D2;
        Thu,  8 Jun 2023 09:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686216309;
        bh=96pyaT392lWLRv2jhrQ7OqU9kNa5PjVzAfVKuIvhzwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CT7/WJFuC521sAaVjPZmzV7eb/VVqM4NKYHTKp2nSTsABVXpwve/3J2fuvzmvxdl1
         ZvfsiwiiyiPIUYyeQ6xtEzcyeSEKOUW+YaAAOy87QFz4V37XEUK6XxF2uXJI0XzU2S
         AsBd8rVl1QKvSaXgqNHo1JI3LZEmbpb4eEox5CbfWuHB/lriw61LPGQJhXBGojAgTQ
         P8TOrboS7A+8GhiZr2gR++gp5E/Xsp25KqXO2/u3vawZO3LtMRKfdQBRgAger8Re3i
         lEHXQBjlzBzW4wQUcyiOjrQvf170tOUX8dslCQf6/q37ObGOQ43XNZOfCGgcslvd5y
         Ke1K3VAKTIcqw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7Bte-00043e-1e; Thu, 08 Jun 2023 11:25:34 +0200
Date:   Thu, 8 Jun 2023 11:25:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: PROBLEM: kernel NULL pointer dereference when yanking ftdi
 usb-serial during BREAK
Message-ID: <ZIGejjOfsWkwjB2s@hovoldconsulting.com>
References: <CADyTPExB2kYOOwkO0JqGhKaYVDqO9uS9WCw0J=MCTdVhcGOogA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADyTPExB2kYOOwkO0JqGhKaYVDqO9uS9WCw0J=MCTdVhcGOogA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:20:31PM -0400, Nick Bowler wrote:

> I just hit an oops when unplugging my usb serial adapter.  So naturally,
> I tried it again, and found if I use minicom to send BREAK and then
> quickly yank the cable, I can reliably cause this oops every single
> time.

Well, don't do that then. ;)

I ran into this a couple of years ago myself but ended up preempted
before I could finish the fix I was working on.

The problem is that the tty layer happily calls back into the driver to
disable the break state after the device is gone.

Something like the below fixes it. I'll revisit this in a couple of
weeks.

Johan


From 14d3b01c02760979ede01d064fb1700d48c3ee68 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 18 Oct 2021 09:43:38 +0200
Subject: [PATCH] tty: fix break race

TCSBRK and TCSBRKP can race with hangup and end up calling into a tty
driver for a device that is already gone.

FIXME: expand

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/tty_io.c | 68 ++++++++++++++++++++++++++++++--------------
 include/linux/tty.h  |  1 +
 2 files changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c84be40fb8df..85fe52135f4b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -630,6 +630,8 @@ static void __tty_hangup(struct tty_struct *tty, int exit_session)
 
 	tty_ldisc_hangup(tty, cons_filp != NULL);
 
+	wake_up_interruptible(&tty->break_wait);
+
 	spin_lock_irq(&tty->ctrl.lock);
 	clear_bit(TTY_THROTTLED, &tty->flags);
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
@@ -1757,10 +1759,10 @@ int tty_release(struct inode *inode, struct file *filp)
 
 	/*
 	 * Sanity check: if tty->count is going to zero, there shouldn't be
-	 * any waiters on tty->read_wait or tty->write_wait.  We test the
-	 * wait queues and kick everyone out _before_ actually starting to
-	 * close.  This ensures that we won't block while releasing the tty
-	 * structure.
+	 * any waiters on tty->read_wait, tty->write_wait or tty->break_wait.
+	 * We test the wait queues and kick everyone out _before_ actually
+	 * starting to close.  This ensures that we won't block while
+	 * releasing the tty structure.
 	 *
 	 * The test for the o_tty closing is necessary, since the master and
 	 * slave sides may close in any order.  If the slave side closes out
@@ -1780,6 +1782,10 @@ int tty_release(struct inode *inode, struct file *filp)
 				wake_up_poll(&tty->write_wait, EPOLLOUT);
 				do_sleep++;
 			}
+			if (waitqueue_active(&tty->break_wait)) {
+				wake_up(&tty->break_wait);
+				do_sleep++;
+			}
 		}
 		if (o_tty && o_tty->count <= 1) {
 			if (waitqueue_active(&o_tty->read_wait)) {
@@ -2461,6 +2467,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * send_break	-	performed time break
  * @tty: device to break on
  * @duration: timeout in mS
+ * @file: file object
  *
  * Perform a timed break on hardware that lacks its own driver level timed
  * break functionality.
@@ -2468,30 +2475,46 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * Locking:
  *	@tty->atomic_write_lock serializes
  */
-static int send_break(struct tty_struct *tty, unsigned int duration)
+static int send_break(struct file *file, struct tty_struct *tty, unsigned int duration)
 {
+	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	int retval;
 
 	if (tty->ops->break_ctl == NULL)
 		return 0;
 
 	if (tty->driver->flags & TTY_DRIVER_HARDWARE_BREAK)
-		retval = tty->ops->break_ctl(tty, duration);
-	else {
-		/* Do the work ourselves */
-		if (tty_write_lock(tty, 0) < 0)
-			return -EINTR;
-		retval = tty->ops->break_ctl(tty, -1);
-		if (retval)
-			goto out;
-		if (!signal_pending(current))
-			msleep_interruptible(duration);
-		retval = tty->ops->break_ctl(tty, 0);
-out:
-		tty_write_unlock(tty);
-		if (signal_pending(current))
-			retval = -EINTR;
+		return tty->ops->break_ctl(tty, duration);
+
+	if (tty_write_lock(tty, 0) < 0)
+		return -EINTR;
+
+	add_wait_queue(&tty->break_wait, &wait);
+
+	if (signal_pending(current)) {
+		retval = -EINTR;
+		goto out;
+	}
+
+	if (tty_hung_up_p(file)) {
+		retval = -EIO;
+		goto out;
 	}
+
+	retval = tty->ops->break_ctl(tty, -1);
+	if (retval)
+		goto out;
+
+	wait_woken(&wait, TASK_INTERRUPTIBLE, msecs_to_jiffies(duration) + 1);
+
+	retval = tty->ops->break_ctl(tty, 0);
+out:
+	remove_wait_queue(&tty->break_wait, &wait);
+	tty_write_unlock(tty);
+
+	if (signal_pending(current))
+		retval = -EINTR;
+
 	return retval;
 }
 
@@ -2739,10 +2762,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		 * This is used by the tcdrain() termios function.
 		 */
 		if (!arg)
-			return send_break(tty, 250);
+			return send_break(file, tty, 250);
 		return 0;
 	case TCSBRKP:	/* support for POSIX tcsendbreak() */
-		return send_break(tty, arg ? arg*100 : 250);
+		return send_break(file, tty, arg ? arg * 100 : 250);
 
 	case TIOCMGET:
 		return tty_tiocmget(tty, p);
@@ -3105,6 +3128,7 @@ struct tty_struct *alloc_tty_struct(struct tty_driver *driver, int idx)
 	init_ldsem(&tty->ldisc_sem);
 	init_waitqueue_head(&tty->write_wait);
 	init_waitqueue_head(&tty->read_wait);
+	init_waitqueue_head(&tty->break_wait);
 	INIT_WORK(&tty->hangup_work, do_tty_hangup);
 	mutex_init(&tty->atomic_write_lock);
 	spin_lock_init(&tty->ctrl.lock);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e8d5d9997aca..49b0e3b82901 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -235,6 +235,7 @@ struct tty_struct {
 	struct fasync_struct *fasync;
 	wait_queue_head_t write_wait;
 	wait_queue_head_t read_wait;
+	wait_queue_head_t break_wait;
 	struct work_struct hangup_work;
 	void *disc_data;
 	void *driver_data;
-- 
2.39.3

