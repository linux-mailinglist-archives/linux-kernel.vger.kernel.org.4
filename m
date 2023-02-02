Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B516880E3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBBPA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjBBPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:00:56 -0500
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEA7234D5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:00:52 -0800 (PST)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230202150049e6a85b5c5536ee66ec
        for <linux-kernel@vger.kernel.org>;
        Thu, 02 Feb 2023 16:00:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=TmNKWQTw0AoAXvhAuQ5lR2bAljisCn7vFHIBxeWBZsk=;
 b=IP3xyubL3mkYcXQKBU4+FIypIv6VNds8tfQJaGltq9hzqOYEstHv8ybTNsTohxDeZU15QC
 wS2vHMSZyBJFifJbvyak+VtgiaUMq1EgiZKvYCoXzdZ4lXkB+dbSRCO4Imr7LQ9ivCx6m5/k
 Hi0tNAXeW+UQgyfpfo1tPSzf07Uuk=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v2 1/3] tty: n_gsm: add keep alive support
Date:   Thu,  2 Feb 2023 15:59:32 +0100
Message-Id: <20230202145934.22641-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Introduce an ioctl commands and functions to optionally enable keep alive
handling via the test command as described in chapter 5.4.6.3.4. A single
incrementing octet is being used to distinguish between multiple retries.
Retry count and interval are taken from the general parameters N2 and T2.

Note that support for the test command is mandatory and already present in
the muxer implementation since the very first version.
Also note that the previous ioctl structure gsm_config cannot be extended
due to missing checks against zero of the field "unused".

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c         | 106 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/gsmmux.h |  17 ++++--
 2 files changed, 117 insertions(+), 6 deletions(-)

v1 -> v2:
The "unused" fields of "gsm_config" and "gsm_netconfig" have been marked as
unusable due to missing checks against zero. See review comments.
New ioctl commands GSMIOC_GETCONF_EXT and GSMIOC_SETCONF_EXT together with
the structure gsm_config_ext have been added. Reserved fields are included
for possible future extensions. Proper check against zero is done.
Setting a different value for "keep_alive" via ioctl does not reset the
already open DLCI anymore. This is not needed as there is no impact at the
peer.
gsm_control_keep_alive() has been changed to call spin_unlock_irqrestore()
properly in every case.

Link: https://lore.kernel.org/all/Y9pfrFPngFVgQUN7@kroah.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 5783801d6524..d068df1cf2fd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -318,6 +318,11 @@ struct gsm_mux {
 	struct gsm_control *pending_cmd;/* Our current pending command */
 	spinlock_t control_lock;	/* Protects the pending command */
 
+	/* Keep-alive */
+	struct timer_list ka_timer;	/* Keep-alive response timer */
+	u8 ka_num;			/* Keep-alive match pattern */
+	int ka_retries;			/* Keep-alive retry counter */
+
 	/* Configuration */
 	int adaption;		/* 1 or 2 supported */
 	u8 ftype;		/* UI or UIH */
@@ -325,6 +330,7 @@ struct gsm_mux {
 	unsigned int t3;	/* Power wake-up timer in seconds. */
 	int n2;			/* Retry count */
 	u8 k;			/* Window size */
+	u32 keep_alive;		/* Control channel keep-alive in ms */
 
 	/* Statistics (not currently exposed) */
 	unsigned long bad_fcs;
@@ -1897,11 +1903,13 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
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
@@ -1916,6 +1924,54 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 	/* Or did we receive the PN response to our PN command */
 	} else if (command == CMD_PN) {
 		gsm_control_negotiation(gsm, 0, data, clen);
+	/* Or did we receive the TEST response to our TEST command */
+	} else if (command == CMD_TEST && clen == 1 && *data == gsm->ka_num) {
+		gsm->ka_retries = -1; /* trigger new keep-alive message */
+		if (dlci && !dlci->dead)
+			mod_timer(&gsm->ka_timer,
+				  jiffies + gsm->keep_alive * HZ / 100);
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
+			pr_info("%s keep-alive timed out\n", __func__);
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
+			gsm->ka_retries = gsm->n2;
+		}
+		gsm_control_command(gsm, CMD_TEST, &gsm->ka_num,
+				    sizeof(gsm->ka_num));
+		mod_timer(&gsm->ka_timer,
+			  jiffies + gsm->t2 * HZ / 100);
 	}
 	spin_unlock_irqrestore(&gsm->control_lock, flags);
 }
@@ -2061,8 +2117,10 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
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
@@ -2078,6 +2136,8 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 
 static void gsm_dlci_open(struct gsm_dlci *dlci)
 {
+	struct gsm_mux *gsm = dlci->gsm;
+
 	/* Note that SABM UA .. SABM UA first UA lost can mean that we go
 	   open -> open */
 	del_timer(&dlci->t1);
@@ -2087,8 +2147,15 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
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
@@ -2840,6 +2907,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	/* Finish outstanding timers, making sure they are done */
 	del_timer_sync(&gsm->kick_timer);
 	del_timer_sync(&gsm->t2_timer);
+	del_timer_sync(&gsm->ka_timer);
 
 	/* Finish writing to ldisc */
 	flush_work(&gsm->tx_work);
@@ -2987,6 +3055,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	INIT_LIST_HEAD(&gsm->tx_data_list);
 	timer_setup(&gsm->kick_timer, gsm_kick_timer, 0);
 	timer_setup(&gsm->t2_timer, gsm_control_retransmit, 0);
+	timer_setup(&gsm->ka_timer, gsm_control_keep_alive, 0);
 	INIT_WORK(&gsm->tx_work, gsmld_write_task);
 	init_waitqueue_head(&gsm->event);
 	spin_lock_init(&gsm->control_lock);
@@ -3003,6 +3072,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
 	gsm->mtu = 64;
 	gsm->dead = true;	/* Avoid early tty opens */
+	gsm->keep_alive = 0;	/* Disabled */
 
 	/* Store the instance to the mux array or abort if no space is
 	 * available.
@@ -3138,6 +3208,28 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
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
+	gsm->keep_alive = ce->keep_alive;
+	/*
+	 * Check that userspace doesn't put stuff in here to prevent breakages
+	 * in the future.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ce->reserved); i++)
+		if (ce->reserved[i])
+			return -EINVAL;
+	return 0;
+}
+
 /**
  *	gsmld_output		-	write to link
  *	@gsm: our mux
@@ -3456,6 +3548,7 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 		       unsigned long arg)
 {
 	struct gsm_config c;
+	struct gsm_config_ext ce;
 	struct gsm_mux *gsm = tty->disc_data;
 	unsigned int base;
 
@@ -3472,6 +3565,15 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
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
index cb8693b39cb7..98de2570d79b 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -19,8 +19,7 @@ struct gsm_config
 	unsigned int mtu;
 	unsigned int k;
 	unsigned int i;
-	unsigned int unused[8];		/* Padding for expansion without
-					   breaking stuff */
+	unsigned int unused[8];	/* Can not be used */
 };
 
 #define GSMIOC_GETCONF		_IOR('G', 0, struct gsm_config)
@@ -29,9 +28,9 @@ struct gsm_config
 struct gsm_netconfig {
 	unsigned int adaption;  /* Adaption to use in network mode */
 	unsigned short protocol;/* Protocol to use - only ETH_P_IP supported */
-	unsigned short unused2;
+	unsigned short unused2;	/* Can not be used */
 	char if_name[IFNAMSIZ];	/* interface name format string */
-	__u8 unused[28];        /* For future use */
+	__u8 unused[28];        /* Can not be used */
 };
 
 #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
@@ -40,4 +39,14 @@ struct gsm_netconfig {
 /* get the base tty number for a configured gsmmux tty */
 #define GSMIOC_GETFIRST		_IOR('G', 4, __u32)
 
+struct gsm_config_ext {
+	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
+				 * second (0 to disable)
+				 */
+	__u32 reserved[7];	/* For future use */
+};
+
+#define GSMIOC_GETCONF_EXT	_IOR('G', 5, struct gsm_config_ext)
+#define GSMIOC_SETCONF_EXT	_IOW('G', 6, struct gsm_config_ext)
+
 #endif
-- 
2.34.1

