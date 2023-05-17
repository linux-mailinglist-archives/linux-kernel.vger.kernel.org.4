Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7DE706D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjEQP7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjEQP7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:59:00 -0400
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6D26596
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 08:58:33 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230517155831b511dab89ce444757d
        for <linux-kernel@vger.kernel.org>;
        Wed, 17 May 2023 17:58:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=I8rIrez1vOp3Ee2KwKlOwpZ0Tbuw1W2GBhq4oZuF5uE=;
 b=U3dT0lEv/7vXDxEa2b4ExjZOaQ6BgZLNqITOvBauRtuUiF7rnDZHSlc9pIhMevI9NSeHua
 7ofnwszIsoQLYl5LcBeC6SW3oQzirPWxoKG+0k1BfwXkMcQ8x7hSKzYvCPXOaVuQWGVkmLcv
 sXiQ3CZlypLDEZ3YbQrI1f1s3NdCQ=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        felix-haase@siemens.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v5 09/10] tty: n_gsm: expose configuration and statistics via proc fs
Date:   Wed, 17 May 2023 17:57:03 +0200
Message-Id: <20230517155704.5701-9-daniel.starke@siemens.com>
In-Reply-To: <20230517155704.5701-1-daniel.starke@siemens.com>
References: <20230517155704.5701-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

The n_gsm mux collects various statistics about the mux and its channels.
These are currently not exposed to the user. There exists already a proc fs
path for tty ldiscs (/proc/tty/ldisc).

Extend this path by an 'n_gsm' node and create a proc file for each mux
instance if active. The file exposes protocol statistics and channel states
and configuration to the user. Mutex based locks are introduced to avoid
inconsistent states.

The following shows an example output:
 tty:ttyS1 flags:
 initiator:1 mode:1 mru:64 mtu:64 t1:10 t2:34 t3:10 n2:3 k:2 wc:0 ka:100
 bad_fcs:0 malformed:0 io_error:0 open_error:0 bad_size:0 unsupported:0

 dlci:0 state:OPEN cl:2 prio:0 i:UIH k:2 mtu:64 tx:35 rx:35

Description:
tty:         The underlying device used by this mux.
flags:       Tty flags relevant to the mux protocol.
initiator:   0 for responder, 1 for initiator.
mode:        0 for basic option mode, 1 for advanced option mode
mru:         Maximum receive unit size.
mtu:         Maximum transmission unit size.
t1:          Acknowledgment timer.
t2:          Response timer for multiplexer control channel.
t3:          Response timer for wake-up procedure.
n2:          Maximum number of retransmissions.
k:           Window size.
wc:          Wait for configuration before starting parameter negotiation?
ka:          Control channel keep-alive timer (0 if disabled).
bad_fcs:     Number of bad FCS.
malformed:   Number of malformed frames.
io_error:    Number of I/O errors on the underlying tty.
open_error:  Number of failed DLCI open attempts.
bad_size:    Number of n_gsm frames with bad size.
unsupported: Number of malformed control frames.
dlci:        Related channel number.
state:       Current channel state. Possible values are CLOSED,
             WAITING_CONFIG, CONFIGURE, OPENING, OPEN and CLOSING.
cl:          Convergence layer type.
prio:        Priority.
i:           Framing. Possible values are UI and UIH.
k:           Window size.
mtu:         Maximum transmission unit size.
tx:          Transmitted payload size in bytes (incl. convergence layer
             type header).
rx:          Received payload size in bytes (incl. convergence layer type
             header).

All timers are in 1/100th of a second units.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 207 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 196 insertions(+), 11 deletions(-)

v4 -> v5:
Newly added patch to expose the collected statistics to the user via proc
fs.

Please note that I cannot response to emails until August 7th. Felix Haase
will take over from our side for questions regarding this patch series or
the n_gsm.

Link: https://lore.kernel.org/all/DB9PR10MB5881A7A09725EAF8FDB5F35BE0789@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 511f22489754..30f73ab2491f 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -46,10 +46,12 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/proc_fs.h>
 #include <linux/bitops.h>
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/module.h>
+#include <linux/stringify.h>
 #include <linux/timer.h>
 #include <linux/tty_flip.h>
 #include <linux/tty_driver.h>
@@ -187,7 +189,7 @@ struct gsm_dlci {
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	struct net_device *net; /* network interface, if created */
 
-	/* Statistics (not currently exposed) */
+	/* Statistics (exposed via proc file) */
 	u64 tx;			/* Data bytes sent on this DLCI */
 	u64 rx;			/* Data bytes received on this DLCI */
 };
@@ -272,6 +274,7 @@ enum gsm_mux_state {
 
 struct gsm_mux {
 	struct tty_struct *tty;		/* The tty our ldisc is bound to */
+	struct proc_dir_entry *proc;	/* Associated proc fs entry */
 	spinlock_t lock;
 	struct mutex mutex;
 	unsigned int num;
@@ -339,7 +342,7 @@ struct gsm_mux {
 	bool wait_config;	/* Wait for configuration by ioctl before DLCI open */
 	u32 keep_alive;		/* Control channel keep-alive in 10ms */
 
-	/* Statistics (not currently exposed) */
+	/* Statistics (exposed via proc file) */
 	unsigned long bad_fcs;
 	unsigned long malformed;
 	unsigned long io_error;
@@ -357,6 +360,7 @@ struct gsm_mux {
 #define MAX_MUX		4			/* 256 minors */
 static struct gsm_mux *gsm_mux[MAX_MUX];	/* GSM muxes */
 static DEFINE_SPINLOCK(gsm_mux_lock);
+static DEFINE_MUTEX(gsm_mux_mutex);
 
 static struct tty_driver *gsm_tty_driver;
 
@@ -3079,6 +3083,153 @@ static void gsm_error(struct gsm_mux *gsm)
 	gsm->io_error++;
 }
 
+/*
+ * Entry to the proc file system in tty/ldisc/n_gsm/
+ */
+
+static struct proc_dir_entry *proc_gsm;
+
+/**
+ * gsm_proc_print_flag	-	check and print termios flag
+ * @m: output handle
+ * @flags: termios flags
+ * @val: flag to check and print
+ * @str: string representation of val
+ * @first: does not need separator?
+ */
+static bool gsm_proc_print_flag(struct seq_file *m, unsigned short flags,
+				int val, const char *str, bool first)
+{
+	if ((flags & val) == 0)
+		return first;
+	if (!first)
+		seq_putc(m, '|');
+	seq_puts(m, str);
+	return false;
+}
+
+#define gsm_proc_print_flag_str(m, flags, val) \
+	(first = gsm_proc_print_flag((m), (flags), (val), __stringify(val), first))
+
+/**
+ * gsm_proc_show	-	output proc file
+ * @m: output handle
+ * @v: result from start
+ *
+ * Handles the output of /proc/tty/ldisc/n_gsm/mux%d
+ */
+static int gsm_proc_show(struct seq_file *m, void *v)
+{
+	struct gsm_mux *gsm = m->private;
+	struct gsm_dlci *dlci = NULL;
+	unsigned short flags;
+	int i;
+	bool first = true;
+	const char *state, *ftype;
+
+	if (!gsm)
+		return -ENODEV;
+
+	/* The proc file may get removed in gsm_cleanup_mux() if the connection
+	 * was closed. Early out here to avoid a deadlock.
+	 */
+	if (!mutex_trylock(&gsm_mux_mutex))
+		return -EBUSY;
+	if (!mutex_trylock(&gsm->mutex)) {
+		mutex_unlock(&gsm_mux_mutex);
+		return -EBUSY;
+	}
+
+	seq_printf(m, "tty:%s flags:", tty_name(gsm->tty));
+	flags = gsm->tty->termios.c_iflag;
+	gsm_proc_print_flag_str(m, flags, IGNBRK);
+	gsm_proc_print_flag_str(m, flags, IXON);
+	gsm_proc_print_flag_str(m, flags, IXOFF);
+	flags = gsm->tty->termios.c_cflag;
+	gsm_proc_print_flag_str(m, flags, CLOCAL);
+	gsm_proc_print_flag_str(m, flags, CRTSCTS);
+	seq_putc(m, '\n');
+
+	seq_printf(m, "initiator:%d mode:%d mru:%u mtu:%u t1:%d t2:%d t3:%d",
+		   gsm->initiator, gsm->encoding, gsm->mru, gsm->mtu, gsm->t1,
+		   gsm->t2, gsm->t3);
+	seq_printf(m, " n2:%d k:%d wc:%d ka:%u", gsm->n2, gsm->k,
+		   gsm->wait_config ? 1 : 0, gsm->keep_alive);
+	if (gsm->dead)
+		seq_puts(m, " DEAD");
+	seq_putc(m, '\n');
+
+	seq_printf(m, "bad_fcs:%lu malformed:%lu io_error:%lu open_error:%lu",
+		   gsm->bad_fcs, gsm->malformed, gsm->io_error,
+		   gsm->open_error);
+	seq_printf(m, " bad_size:%lu unsupported:%lu\n\n", gsm->bad_size,
+		   gsm->unsupported);
+
+	for (i = 0; i < NUM_DLCI; i++) {
+		dlci = gsm->dlci[i];
+		if (!dlci)
+			continue;
+		switch (dlci->state) {
+		case DLCI_CLOSED:
+			state = "CLOSED";
+			break;
+		case DLCI_WAITING_CONFIG:
+			state = "WAITING_CONFIG";
+			break;
+		case DLCI_CONFIGURE:
+			state = "CONFIGURE";
+			break;
+		case DLCI_OPENING:
+			state = "OPENING";
+			break;
+		case DLCI_OPEN:
+			state = "OPEN";
+			break;
+		case DLCI_CLOSING:
+			state = "CLOSING";
+			break;
+		default:
+			state = "???";
+			break;
+		}
+		switch (dlci->ftype) {
+		case UI:
+			ftype = "UI";
+			break;
+		case UIH:
+			ftype = "UIH";
+			break;
+		default:
+			ftype = "???";
+			break;
+		}
+		seq_printf(m, "dlci:%d state:%s cl:%d prio:%d i:%s k:%d mtu:%u",
+			   i, state, dlci->adaption, dlci->prio, ftype, dlci->k,
+			   dlci->mtu);
+		seq_printf(m, " tx:%llu rx:%llu", dlci->tx, dlci->rx);
+		if (dlci->dead)
+			seq_puts(m, " DEAD");
+		seq_putc(m, '\n');
+	}
+
+	mutex_unlock(&gsm->mutex);
+	mutex_unlock(&gsm_mux_mutex);
+
+	return 0;
+}
+
+static int gsm_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, gsm_proc_show, pde_data(inode));
+}
+
+static const struct proc_ops gsm_proc_ops = {
+	.proc_open    = gsm_proc_open,
+	.proc_read    = seq_read,
+	.proc_lseek   = seq_lseek,
+	.proc_release = single_release,
+};
+
 /**
  *	gsm_cleanup_mux		-	generic GSM protocol cleanup
  *	@gsm: our mux
@@ -3131,6 +3282,9 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_data_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_data_list);
+
+	if (gsm->proc)
+		proc_remove(gsm->proc);
 }
 
 /**
@@ -3145,6 +3299,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 static int gsm_activate_mux(struct gsm_mux *gsm)
 {
 	struct gsm_dlci *dlci;
+	char pbuf[8];
 	int ret;
 
 	dlci = gsm_dlci_alloc(gsm, 0);
@@ -3162,6 +3317,9 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
 
 	gsm->has_devices = true;
 	gsm->dead = false;		/* Tty opens are now permissible */
+
+	if (proc_gsm && snprintf(pbuf, sizeof(pbuf), "mux%u", gsm->num) > 0)
+		gsm->proc = proc_create_data(pbuf, 0444, proc_gsm, &gsm_proc_ops, gsm);
 	return 0;
 }
 
@@ -3596,6 +3754,8 @@ static void gsmld_close(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm = tty->disc_data;
 
+	mutex_lock(&gsm_mux_mutex);
+
 	/* The ldisc locks and closes the port before calling our close. This
 	 * means we have no way to do a proper disconnect. We will not bother
 	 * to do one.
@@ -3607,6 +3767,8 @@ static void gsmld_close(struct tty_struct *tty)
 	gsmld_flush_buffer(tty);
 	/* Do other clean up here */
 	mux_put(gsm);
+
+	mutex_unlock(&gsm_mux_mutex);
 }
 
 /**
@@ -3622,14 +3784,20 @@ static void gsmld_close(struct tty_struct *tty)
 static int gsmld_open(struct tty_struct *tty)
 {
 	struct gsm_mux *gsm;
+	int ret = 0;
 
-	if (tty->ops->write == NULL)
-		return -EINVAL;
+	mutex_lock(&gsm_mux_mutex);
+	if (tty->ops->write == NULL) {
+		ret = -EINVAL;
+		goto err_unlock;
+	}
 
 	/* Attach our ldisc data */
 	gsm = gsm_alloc_mux();
-	if (gsm == NULL)
-		return -ENOMEM;
+	if (gsm == NULL) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
 
 	tty->disc_data = gsm;
 	tty->receive_room = 65536;
@@ -3645,7 +3813,9 @@ static int gsmld_open(struct tty_struct *tty)
 	else
 		gsm->receive = gsm1_receive;
 
-	return 0;
+err_unlock:
+	mutex_unlock(&gsm_mux_mutex);
+	return ret;
 }
 
 /**
@@ -3769,17 +3939,24 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 	struct gsm_mux *gsm = tty->disc_data;
 	unsigned int base, addr;
 	struct gsm_dlci *dlci;
+	int ret = 0;
 
 	switch (cmd) {
 	case GSMIOC_GETCONF:
 		gsm_copy_config_values(gsm, &c);
+		mutex_lock(&gsm_mux_mutex);
 		if (copy_to_user((void __user *)arg, &c, sizeof(c)))
-			return -EFAULT;
-		return 0;
+			ret = -EFAULT;
+		mutex_unlock(&gsm_mux_mutex);
+		break;
 	case GSMIOC_SETCONF:
+		mutex_lock(&gsm_mux_mutex);
 		if (copy_from_user(&c, (void __user *)arg, sizeof(c)))
-			return -EFAULT;
-		return gsm_config(gsm, &c);
+			ret = -EFAULT;
+		else
+			ret = gsm_config(gsm, &c);
+		mutex_unlock(&gsm_mux_mutex);
+		break;
 	case GSMIOC_GETFIRST:
 		base = mux_num_to_base(gsm);
 		return put_user(base + 1, (__u32 __user *)arg);
@@ -3824,6 +4001,7 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 	default:
 		return n_tty_ioctl_helper(tty, cmd, arg);
 	}
+	return ret;
 }
 
 /*
@@ -4497,7 +4675,9 @@ static void gsmtty_cleanup(struct tty_struct *tty)
 
 	dlci_put(dlci);
 	dlci_put(gsm->dlci[0]);
+	mutex_lock(&gsm_mux_mutex);
 	mux_put(gsm);
+	mutex_unlock(&gsm_mux_mutex);
 }
 
 /* Virtual ttys for the demux */
@@ -4556,6 +4736,9 @@ static int __init gsm_init(void)
 		status = -EBUSY;
 		goto err_put_driver;
 	}
+
+	proc_gsm = proc_mkdir_mode("tty/ldisc/n_gsm", 0555, NULL);
+
 	pr_debug("gsm_init: loaded as %d,%d.\n",
 			gsm_tty_driver->major, gsm_tty_driver->minor_start);
 	return 0;
@@ -4569,6 +4752,8 @@ static int __init gsm_init(void)
 static void __exit gsm_exit(void)
 {
 	tty_unregister_ldisc(&tty_ldisc_packet);
+	if (proc_gsm)
+		proc_remove(proc_gsm);
 	tty_unregister_driver(gsm_tty_driver);
 	tty_driver_kref_put(gsm_tty_driver);
 }
-- 
2.34.1

