Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC2B696377
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjBNM15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjBNM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:27:54 -0500
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4B46BE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:27:50 -0800 (PST)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2023021412274730ae9e277d87c874bd
        for <linux-kernel@vger.kernel.org>;
        Tue, 14 Feb 2023 13:27:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WyvIloy6hDaD3Su7Y9NAYR3qXdw1PuJe14Bxbv5KI3k=;
 b=W8zn4bxJcjVzzXOw3fzs9tBQx5qCTzIe1Uhaw0tD8WDV3vndgonZfaM+RSXu3hFClm3rMu
 /F+zFnucv2+bgHN4ir7Xv5ZE3J9frDlWZj1GspWG1siO8+PCxyoz5Kms2Z/6MmbKUB1FXYqS
 zCH7dmLcEtLEFvyzuuwEOxUbmgPE4=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, m.brock@vanmierlo.com,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 1/1] tty: n_gsm: add keep alive support
Date:   Tue, 14 Feb 2023 13:27:37 +0100
Message-Id: <20230214122737.1976-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapters 5.4.6.3.4 and 5.1.8.1.3 describe the test
command which can be used to test the mux connection between both sides.

Currently, no algorithm is implemented to make use of this command. This
requires that each multiplexed upper layer protocol supervises the
underlying muxer connection to handle possible connection losses.

Introduce ioctl commands and functions to optionally enable keep alive
handling via the test command as described in chapter 5.4.6.3.4. A single
incrementing octet "ka_num" is being used for unique identification of each
single keep alive packet. Retries will use the same "ka_num" value as the
original packet. Retry count and interval are taken from the general
parameters N2 and T2.

Add usage description and basic example for the new ioctl to the n_gsm
documentation.

Note that support for the test command is mandatory and already present in
the muxer implementation since the very first version.
Also note that the previous ioctl structure gsm_config cannot be extended
due to missing checks against zero of the field "unused".

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 Documentation/driver-api/tty/n_gsm.rst |  19 +++++
 drivers/tty/n_gsm.c                    | 106 ++++++++++++++++++++++++-
 include/uapi/linux/gsmmux.h            |  10 +++
 3 files changed, 133 insertions(+), 2 deletions(-)

v5 -> v6:
Fixed comment on the "keep_alive" field in gsm_mux as remarked in the
review.

Link: https://lore.kernel.org/all/DB9PR10MB5881C08001D7FA76D6E2C06CE0DD9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/Documentation/driver-api/tty/n_gsm.rst b/Documentation/driver-api/tty/n_gsm.rst
index 35d7381515b0..9447b8a3b8e2 100644
--- a/Documentation/driver-api/tty/n_gsm.rst
+++ b/Documentation/driver-api/tty/n_gsm.rst
@@ -25,6 +25,8 @@ Config Initiator
 #. Switch the serial line to using the n_gsm line discipline by using
    ``TIOCSETD`` ioctl.
 
+#. Configure the mux using ``GSMIOC_GETCONF_EXT``/``GSMIOC_SETCONF_EXT`` ioctl if needed.
+
 #. Configure the mux using ``GSMIOC_GETCONF``/``GSMIOC_SETCONF`` ioctl.
 
 #. Obtain base gsmtty number for the used serial port.
@@ -42,6 +44,7 @@ Config Initiator
 
       int ldisc = N_GSM0710;
       struct gsm_config c;
+      struct gsm_config_ext ce;
       struct termios configuration;
       uint32_t first;
 
@@ -62,6 +65,12 @@ Config Initiator
       /* use n_gsm line discipline */
       ioctl(fd, TIOCSETD, &ldisc);
 
+      /* get n_gsm extended configuration */
+      ioctl(fd, GSMIOC_GETCONF_EXT, &ce);
+      /* use keep-alive once every 5s for modem connection supervision */
+      ce.keep_alive = 500;
+      /* set the new extended configuration */
+      ioctl(fd, GSMIOC_SETCONF_EXT, &ce);
       /* get n_gsm configuration */
       ioctl(fd, GSMIOC_GETCONF, &c);
       /* we are initiator and need encoding 0 (basic) */
@@ -106,6 +115,9 @@ Config Requester
 #. Switch the serial line to using the *n_gsm* line discipline by using
    ``TIOCSETD`` ioctl.
 
+#. Configure the mux using ``GSMIOC_GETCONF_EXT``/``GSMIOC_SETCONF_EXT``
+   ioctl if needed.
+
 #. Configure the mux using ``GSMIOC_GETCONF``/``GSMIOC_SETCONF`` ioctl.
 
 #. Obtain base gsmtty number for the used serial port::
@@ -119,6 +131,7 @@ Config Requester
 
 	int ldisc = N_GSM0710;
 	struct gsm_config c;
+	struct gsm_config_ext ce;
 	struct termios configuration;
 	uint32_t first;
 
@@ -132,6 +145,12 @@ Config Requester
 	/* use n_gsm line discipline */
 	ioctl(fd, TIOCSETD, &ldisc);
 
+	/* get n_gsm extended configuration */
+	ioctl(fd, GSMIOC_GETCONF_EXT, &ce);
+	/* use keep-alive once every 5s for peer connection supervision */
+	ce.keep_alive = 500;
+	/* set the new extended configuration */
+	ioctl(fd, GSMIOC_SETCONF_EXT, &ce);
 	/* get n_gsm configuration */
 	ioctl(fd, GSMIOC_GETCONF, &c);
 	/* we are requester and need encoding 0 (basic) */
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 58ea30fd6576..7aa05ebed8e1 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -318,6 +318,11 @@ struct gsm_mux {
 	struct gsm_control *pending_cmd;/* Our current pending command */
 	spinlock_t control_lock;	/* Protects the pending command */
 
+	/* Keep-alive */
+	struct timer_list ka_timer;	/* Keep-alive response timer */
+	u8 ka_num;			/* Keep-alive match pattern */
+	signed int ka_retries;		/* Keep-alive retry counter, -1 if not yet initialized */
+
 	/* Configuration */
 	int adaption;		/* 1 or 2 supported */
 	u8 ftype;		/* UI or UIH */
@@ -325,6 +330,7 @@ struct gsm_mux {
 	unsigned int t3;	/* Power wake-up timer in seconds. */
 	int n2;			/* Retry count */
 	u8 k;			/* Window size */
+	u32 keep_alive;		/* Control channel keep-alive in 10ms */
 
 	/* Statistics (not currently exposed) */
 	unsigned long bad_fcs;
@@ -1903,11 +1909,13 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 						const u8 *data, int clen)
 {
 	struct gsm_control *ctrl;
+	struct gsm_dlci *dlci;
 	unsigned long flags;
 
 	spin_lock_irqsave(&gsm->control_lock, flags);
 
 	ctrl = gsm->pending_cmd;
+	dlci = gsm->dlci[0];
 	command |= 1;
 	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
@@ -1922,6 +1930,53 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 	/* Or did we receive the PN response to our PN command */
 	} else if (command == CMD_PN) {
 		gsm_control_negotiation(gsm, 0, data, clen);
+	/* Or did we receive the TEST response to our TEST command */
+	} else if (command == CMD_TEST && clen == 1 && *data == gsm->ka_num) {
+		gsm->ka_retries = -1; /* trigger new keep-alive message */
+		if (dlci && !dlci->dead)
+			mod_timer(&gsm->ka_timer, jiffies + gsm->keep_alive * HZ / 100);
+	}
+	spin_unlock_irqrestore(&gsm->control_lock, flags);
+}
+
+/**
+ * gsm_control_keep_alive	-	check timeout or start keep-alive
+ * @t: timer contained in our gsm object
+ *
+ * Called off the keep-alive timer expiry signaling that our link
+ * partner is not responding anymore. Link will be closed.
+ * This is also called to startup our timer.
+ */
+
+static void gsm_control_keep_alive(struct timer_list *t)
+{
+	struct gsm_mux *gsm = from_timer(gsm, t, ka_timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&gsm->control_lock, flags);
+	if (gsm->ka_num && gsm->ka_retries == 0) {
+		/* Keep-alive expired -> close the link */
+		if (debug & DBG_ERRORS)
+			pr_debug("%s keep-alive timed out\n", __func__);
+		spin_unlock_irqrestore(&gsm->control_lock, flags);
+		if (gsm->dlci[0])
+			gsm_dlci_begin_close(gsm->dlci[0]);
+		return;
+	} else if (gsm->keep_alive && gsm->dlci[0] && !gsm->dlci[0]->dead) {
+		if (gsm->ka_retries > 0) {
+			/* T2 expired for keep-alive -> resend */
+			gsm->ka_retries--;
+		} else {
+			/* Start keep-alive timer */
+			gsm->ka_num++;
+			if (!gsm->ka_num)
+				gsm->ka_num++;
+			gsm->ka_retries = (signed int)gsm->n2;
+		}
+		gsm_control_command(gsm, CMD_TEST, &gsm->ka_num,
+				    sizeof(gsm->ka_num));
+		mod_timer(&gsm->ka_timer,
+			  jiffies + gsm->t2 * HZ / 100);
 	}
 	spin_unlock_irqrestore(&gsm->control_lock, flags);
 }
@@ -2067,8 +2122,10 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 		/* Ensure that gsmtty_open() can return. */
 		tty_port_set_initialized(&dlci->port, false);
 		wake_up_interruptible(&dlci->port.open_wait);
-	} else
+	} else {
+		del_timer(&dlci->gsm->ka_timer);
 		dlci->gsm->dead = true;
+	}
 	/* A DLCI 0 close is a MUX termination so we need to kick that
 	   back to userspace somehow */
 	gsm_dlci_data_kick(dlci);
@@ -2084,6 +2141,8 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 
 static void gsm_dlci_open(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
+
 	/* Note that SABM UA .. SABM UA first UA lost can mean that we go
 	   open -> open */
 	del_timer(&dlci->t1);
@@ -2093,8 +2152,15 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 	if (debug & DBG_ERRORS)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
-	if (dlci->addr)
+	if (dlci->addr) {
 		gsm_modem_update(dlci, 0);
+	} else {
+		/* Start keep-alive control */
+		gsm->ka_num = 0;
+		gsm->ka_retries = -1;
+		mod_timer(&gsm->ka_timer,
+			  jiffies + gsm->keep_alive * HZ / 100);
+	}
 	gsm_dlci_data_kick(dlci);
 	wake_up(&dlci->gsm->event);
 }
@@ -2847,6 +2913,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	/* Finish outstanding timers, making sure they are done */
 	del_timer_sync(&gsm->kick_timer);
 	del_timer_sync(&gsm->t2_timer);
+	del_timer_sync(&gsm->ka_timer);
 
 	/* Finish writing to ldisc */
 	flush_work(&gsm->tx_work);
@@ -2994,6 +3061,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	INIT_LIST_HEAD(&gsm->tx_data_list);
 	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+	timer_setup(&gsm->ka_timer, gsm_control_keep_alive, 0);
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
 	init_waitqueue_head(&gsm->event);
 	spin_lock_init(&gsm->control_lock);
@@ -3010,6 +3078,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
 	gsm->mtu = 64;
 	gsm->dead = true;	/* Avoid early tty opens */
+	gsm->keep_alive = 0;	/* Disabled */
 
 	/* Store the instance to the mux array or abort if no space is
 	 * available.
@@ -3145,6 +3214,29 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 	return 0;
 }
 
+static void gsm_copy_config_ext_values(struct gsm_mux *gsm,
+				       struct gsm_config_ext *ce)
+{
+	memset(ce, 0, sizeof(*ce));
+	ce->keep_alive = gsm->keep_alive;
+}
+
+static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
+{
+	unsigned int i;
+
+	/*
+	 * Check that userspace doesn't put stuff in here to prevent breakages
+	 * in the future.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ce->reserved); i++)
+		if (ce->reserved[i])
+			return -EINVAL;
+
+	gsm->keep_alive = ce->keep_alive;
+	return 0;
+}
+
 /**
  *	gsmld_output		-	write to link
  *	@gsm: our mux
@@ -3463,6 +3555,7 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 		       unsigned long arg)
 {
 	struct gsm_config c;
+	struct gsm_config_ext ce;
 	struct gsm_mux *gsm = tty->disc_data;
 	unsigned int base;
 
@@ -3479,6 +3572,15 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 	case GSMIOC_GETFIRST:
 		base = mux_num_to_base(gsm);
 		return put_user(base + 1, (__u32 __user *)arg);
+	case GSMIOC_GETCONF_EXT:
+		gsm_copy_config_ext_values(gsm, &ce);
+		if (copy_to_user((void __user *)arg, &ce, sizeof(ce)))
+			return -EFAULT;
+		return 0;
+	case GSMIOC_SETCONF_EXT:
+		if (copy_from_user(&ce, (void __user *)arg, sizeof(ce)))
+			return -EFAULT;
+		return gsm_config_ext(gsm, &ce);
 	default:
 		return n_tty_ioctl_helper(tty, cmd, arg);
 	}
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index 785d6b253f6d..a703780aa095 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -39,4 +39,14 @@ struct gsm_netconfig {
 /* get the base tty number for a configured gsmmux tty */
 #define GSMIOC_GETFIRST		_IOR('G', 4, __u32)
 
+struct gsm_config_ext {
+	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
+				 * second (0 to disable)
+				 */
+	__u32 reserved[7];	/* For future use, must be initialized to zero */
+};
+
+#define GSMIOC_GETCONF_EXT	_IOR('G', 5, struct gsm_config_ext)
+#define GSMIOC_SETCONF_EXT	_IOW('G', 6, struct gsm_config_ext)
+
 #endif
-- 
2.34.1

