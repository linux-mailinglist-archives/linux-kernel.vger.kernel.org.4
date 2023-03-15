Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2646BAE43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCOKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCOKzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:55:14 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BC39290
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:55:10 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230315105507a1b335c31292b7e11b
        for <linux-kernel@vger.kernel.org>;
        Wed, 15 Mar 2023 11:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZbVL3/moeGwSQA11hDTPtVbF3jWsDP4S28417aJ9KLc=;
 b=mKu+y+tplOeq+yydpRX5HuTN6sq3FFIQ8Z1XO+qhBr6zcsBieijVW6MrF8nTMnUVDNrWED
 ASeSChyFTXowQ98pjjw7ct4wR+Y73wES1vPP5Vyb1BGXrndP7/vReNfdXclS2GkDd+zBzMgU
 UIDkVGZTXbSJ2QXflDa56CwOSX5wU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/3] tty: n_gsm: add ioctl for DLC specific parameter configuration
Date:   Wed, 15 Mar 2023 11:53:52 +0100
Message-Id: <20230315105354.6234-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Parameter negotiation has been introduced with
commit 92f1f0c3290d ("tty: n_gsm: add parameter negotiation support")

However, means to set individual parameters per DLCI are not yet
implemented. Furthermore, it is currently not possible to keep a DLCI half
open until the user application sets the right parameters for it. This is
required to allow a user application to set its specific parameters before
the underlying link is established. Otherwise, the link is opened and
re-established right afterwards if the user application sets incompatible
parameters. This may be an unexpected behavior for the peer.

Add parameter 'wait_config' to 'gsm_config' to support setups where the
DLCI specific user application sets its specific parameters after open()
and before the link gets fully established. Setting this to zero disables
the user application specific DLCI configuration option.

Add the ioctls 'GSMIOC_GETCONF_DLCI' and 'GSMIOC_SETCONF_DLCI' for the
ldisc and virtual ttys. This gets/sets the DLCI specific parameters and may
trigger a reconnect of the DLCI if incompatible values have been set. Only
the parameters for the DLCI associated with the virtual tty can be set or
retrieved if called on these.

Add remark within the documentation to introduce the new ioctls.

Link: https://lore.kernel.org/oe-kbuild-all/202302281856.S9Lz4gHB-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 Documentation/driver-api/tty/n_gsm.rst |   4 +
 drivers/tty/n_gsm.c                    | 192 ++++++++++++++++++++++++-
 include/uapi/linux/gsmmux.h            |  17 ++-
 3 files changed, 207 insertions(+), 6 deletions(-)

v1 -> v2:
Removed variable `dlci` in gsmld_ioctl() as reported by the kernel test
robot. This is added again in patch 3/3.
Removed casts in parameter range checks in gsm_dlci_config() according to
the review remarks. Explicit casts in gsm_dlci_copy_config_values() remain
as mentioned in the link below.
Changed check of dlci->mtu to dc->mtu in gsm_dlci_config() according to the
review remarks.

Link: https://lore.kernel.org/all/DB9PR10MB58815DECFF54F6D69E738ED8E0AC9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM/

diff --git a/Documentation/driver-api/tty/n_gsm.rst b/Documentation/driver-api/tty/n_gsm.rst
index 9447b8a3b8e2..c2624546fb8f 100644
--- a/Documentation/driver-api/tty/n_gsm.rst
+++ b/Documentation/driver-api/tty/n_gsm.rst
@@ -29,6 +29,8 @@ Config Initiator
 
 #. Configure the mux using ``GSMIOC_GETCONF``/``GSMIOC_SETCONF`` ioctl.
 
+#. Configure DLCs using ``GSMIOC_GETCONF_DLCI``/``GSMIOC_SETCONF_DLCI`` ioctl for non-defaults.
+
 #. Obtain base gsmtty number for the used serial port.
 
    Major parts of the initialization program
@@ -120,6 +122,8 @@ Config Requester
 
 #. Configure the mux using ``GSMIOC_GETCONF``/``GSMIOC_SETCONF`` ioctl.
 
+#. Configure DLCs using ``GSMIOC_GETCONF_DLCI``/``GSMIOC_SETCONF_DLCI`` ioctl for non-defaults.
+
 #. Obtain base gsmtty number for the used serial port::
 
         #include <stdio.h>
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7aa05ebed8e1..9d0e7701ffd4 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -128,6 +128,7 @@ struct gsm_msg {
 
 enum gsm_dlci_state {
 	DLCI_CLOSED,
+	DLCI_WAITING_CONFIG,	/* Waiting for DLCI configuration from user */
 	DLCI_CONFIGURE,		/* Sending PN (for adaption > 1) */
 	DLCI_OPENING,		/* Sending SABM not seen UA */
 	DLCI_OPEN,		/* SABM/UA complete */
@@ -330,6 +331,7 @@ struct gsm_mux {
 	unsigned int t3;	/* Power wake-up timer in seconds. */
 	int n2;			/* Retry count */
 	u8 k;			/* Window size */
+	bool wait_config;	/* Wait for configuration by ioctl before DLCI open */
 	u32 keep_alive;		/* Control channel keep-alive in 10ms */
 
 	/* Statistics (not currently exposed) */
@@ -451,6 +453,7 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 								u8 ctrl);
 static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg);
+static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr);
 static void gsmld_write_trigger(struct gsm_mux *gsm);
 static void gsmld_write_task(struct work_struct *work);
 
@@ -2280,6 +2283,7 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 
 	switch (dlci->state) {
 	case DLCI_CLOSED:
+	case DLCI_WAITING_CONFIG:
 	case DLCI_CLOSING:
 		dlci->retries = gsm->n2;
 		if (!need_pn) {
@@ -2311,6 +2315,7 @@ static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
 {
 	switch (dlci->state) {
 	case DLCI_CLOSED:
+	case DLCI_WAITING_CONFIG:
 	case DLCI_CLOSING:
 		dlci->state = DLCI_OPENING;
 		break;
@@ -2319,6 +2324,24 @@ static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
 	}
 }
 
+/**
+ * gsm_dlci_set_wait_config	-	wait for channel configuration
+ * @dlci: DLCI to configure
+ *
+ * Wait for a DLCI configuration from the application.
+ */
+static void gsm_dlci_set_wait_config(struct gsm_dlci *dlci)
+{
+	switch (dlci->state) {
+	case DLCI_CLOSED:
+	case DLCI_CLOSING:
+		dlci->state = DLCI_WAITING_CONFIG;
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  *	gsm_dlci_begin_close	-	start channel open procedure
  *	@dlci: DLCI to open
@@ -2453,6 +2476,128 @@ static void gsm_kick_timer(struct timer_list *t)
 		pr_info("%s TX queue stalled\n", __func__);
 }
 
+/**
+ * gsm_dlci_copy_config_values	-	copy DLCI configuration
+ * @dlci: source DLCI
+ * @dc: configuration structure to fill
+ */
+static void gsm_dlci_copy_config_values(struct gsm_dlci *dlci, struct gsm_dlci_config *dc)
+{
+	memset(dc, 0, sizeof(*dc));
+	dc->channel = (u32)dlci->addr;
+	dc->adaption = (u32)dlci->adaption;
+	dc->mtu = (u32)dlci->mtu;
+	dc->priority = (u32)dlci->prio;
+	if (dlci->ftype == UIH)
+		dc->i = 1;
+	else
+		dc->i = 2;
+	dc->k = (u32)dlci->k;
+}
+
+/**
+ * gsm_dlci_config	-	configure DLCI from configuration
+ * @dlci: DLCI to configure
+ * @dc: DLCI configuration
+ * @open: open DLCI after configuration?
+ */
+static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, int open)
+{
+	struct gsm_mux *gsm;
+	bool need_restart = false;
+	bool need_open = false;
+	unsigned int i;
+
+	/*
+	 * Check that userspace doesn't put stuff in here to prevent breakages
+	 * in the future.
+	 */
+	for (i = 0; i < ARRAY_SIZE(dc->reserved); i++)
+		if (dc->reserved[i])
+			return -EINVAL;
+
+	if (!dlci)
+		return -EINVAL;
+	gsm = dlci->gsm;
+
+	/* Stuff we don't support yet - I frame transport */
+	if (dc->adaption != 1 && dc->adaption != 2)
+		return -EOPNOTSUPP;
+	if (dc->mtu > MAX_MTU || dc->mtu < MIN_MTU || dc->mtu > gsm->mru)
+		return -EINVAL;
+	if (dc->priority >= 64)
+		return -EINVAL;
+	if (dc->i == 0 || dc->i > 2)  /* UIH and UI only */
+		return -EINVAL;
+	if (dc->k > 7)
+		return -EINVAL;
+
+	/*
+	 * See what is needed for reconfiguration
+	 */
+	/* Framing fields */
+	if (dc->adaption != dlci->adaption)
+		need_restart = true;
+	if (dc->mtu != dlci->mtu)
+		need_restart = true;
+	if (dc->i != dlci->ftype)
+		need_restart = true;
+	/* Requires care */
+	if (dc->priority != dlci->prio)
+		need_restart = true;
+
+	if ((open && gsm->wait_config) || need_restart)
+		need_open = true;
+	if (dlci->state == DLCI_WAITING_CONFIG) {
+		need_restart = false;
+		need_open = true;
+	}
+
+	/*
+	 * Close down what is needed, restart and initiate the new
+	 * configuration.
+	 */
+	if (need_restart) {
+		gsm_dlci_begin_close(dlci);
+		wait_event_interruptible(gsm->event, dlci->state == DLCI_CLOSED);
+		if (signal_pending(current))
+			return -EINTR;
+	}
+	/*
+	 * Setup the new configuration values
+	 */
+	dlci->adaption = (int)dc->adaption;
+
+	if (dc->mtu)
+		dlci->mtu = (unsigned int)dc->mtu;
+	else
+		dlci->mtu = gsm->mtu;
+
+	if (dc->priority)
+		dlci->prio = (u8)dc->priority;
+	else
+		dlci->prio = roundup(dlci->addr + 1, 8) - 1;
+
+	if (dc->i == 1)
+		dlci->ftype = UIH;
+	else if (dc->i == 2)
+		dlci->ftype = UI;
+
+	if (dc->k)
+		dlci->k = (u8)dc->k;
+	else
+		dlci->k = gsm->k;
+
+	if (need_open) {
+		if (gsm->initiator)
+			gsm_dlci_begin_open(dlci);
+		else
+			gsm_dlci_set_opening(dlci);
+	}
+
+	return 0;
+}
+
 /*
  *	Allocate/Free DLCI channels
  */
@@ -3078,6 +3223,7 @@ static struct gsm_mux *gsm_alloc_mux(void)
 	gsm->mru = 64;	/* Default to encoding 1 so these should be 64 */
 	gsm->mtu = 64;
 	gsm->dead = true;	/* Avoid early tty opens */
+	gsm->wait_config = false; /* Disabled */
 	gsm->keep_alive = 0;	/* Disabled */
 
 	/* Store the instance to the mux array or abort if no space is
@@ -3218,6 +3364,7 @@ static void gsm_copy_config_ext_values(struct gsm_mux *gsm,
 				       struct gsm_config_ext *ce)
 {
 	memset(ce, 0, sizeof(*ce));
+	ce->wait_config = gsm->wait_config ? 1 : 0;
 	ce->keep_alive = gsm->keep_alive;
 }
 
@@ -3233,7 +3380,12 @@ static int gsm_config_ext(struct gsm_mux *gsm, struct gsm_config_ext *ce)
 		if (ce->reserved[i])
 			return -EINVAL;
 
+	/*
+	 * Setup the new configuration values
+	 */
+	gsm->wait_config = ce->wait_config ? true : false;
 	gsm->keep_alive = ce->keep_alive;
+
 	return 0;
 }
 
@@ -3436,6 +3588,14 @@ static int gsmld_open(struct tty_struct *tty)
 	gsm->encoding = GSM_ADV_OPT;
 	gsmld_attach_gsm(tty, gsm);
 
+	/* The mux will not be activated yet, we wait for correct
+	 * configuration first.
+	 */
+	if (gsm->encoding == GSM_BASIC_OPT)
+		gsm->receive = gsm0_receive;
+	else
+		gsm->receive = gsm1_receive;
+
 	return 0;
 }
 
@@ -4008,7 +4168,6 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	struct tty_port *port = &dlci->port;
-	struct gsm_mux *gsm = dlci->gsm;
 
 	port->count++;
 	tty_port_tty_set(port, tty);
@@ -4018,10 +4177,15 @@ static int gsmtty_open(struct tty_struct *tty, struct file *filp)
 	   a DM straight back. This is ok as that will have caused a hangup */
 	tty_port_set_initialized(port, true);
 	/* Start sending off SABM messages */
-	if (gsm->initiator)
-		gsm_dlci_begin_open(dlci);
-	else
-		gsm_dlci_set_opening(dlci);
+	if (!dlci->gsm->wait_config) {
+		/* Start sending off SABM messages */
+		if (dlci->gsm->initiator)
+			gsm_dlci_begin_open(dlci);
+		else
+			gsm_dlci_set_opening(dlci);
+	} else {
+		gsm_dlci_set_wait_config(dlci);
+	}
 	/* And wait for virtual carrier */
 	return tty_port_block_til_ready(port, tty, filp);
 }
@@ -4142,6 +4306,7 @@ static int gsmtty_ioctl(struct tty_struct *tty,
 {
 	struct gsm_dlci *dlci = tty->driver_data;
 	struct gsm_netconfig nc;
+	struct gsm_dlci_config dc;
 	int index;
 
 	if (dlci->state == DLCI_CLOSED)
@@ -4165,6 +4330,23 @@ static int gsmtty_ioctl(struct tty_struct *tty,
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 		return 0;
+	case GSMIOC_GETCONF_DLCI:
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
+			return -EFAULT;
+		if (dc.channel != dlci->addr)
+			return -EPERM;
+		gsm_dlci_copy_config_values(dlci, &dc);
+		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
+			return -EFAULT;
+		return 0;
+	case GSMIOC_SETCONF_DLCI:
+		if (copy_from_user(&dc, (void __user *)arg, sizeof(dc)))
+			return -EFAULT;
+		if (dc.channel >= NUM_DLCI)
+			return -EINVAL;
+		if (dc.channel != 0 && dc.channel != dlci->addr)
+			return -EPERM;
+		return gsm_dlci_config(dlci, &dc, 1);
 	case TIOCMIWAIT:
 		return gsm_wait_modem_change(dlci, (u32)arg);
 	default:
diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index a703780aa095..eb67884e5f38 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -43,10 +43,25 @@ struct gsm_config_ext {
 	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
 				 * second (0 to disable)
 				 */
-	__u32 reserved[7];	/* For future use, must be initialized to zero */
+	__u32 wait_config;	/* Wait for DLCI config before opening virtual link? */
+	__u32 reserved[6];	/* For future use, must be initialized to zero */
 };
 
 #define GSMIOC_GETCONF_EXT	_IOR('G', 5, struct gsm_config_ext)
 #define GSMIOC_SETCONF_EXT	_IOW('G', 6, struct gsm_config_ext)
 
+/* Set channel accordingly before calling GSMIOC_GETCONF_DLCI. */
+struct gsm_dlci_config {
+	__u32 channel;		/* DLCI (0 for the associated DLCI) */
+	__u32 adaption;		/* Convergence layer type */
+	__u32 mtu;		/* Maximum transfer unit */
+	__u32 priority;		/* Priority (0 for default value) */
+	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
+	__u32 k;		/* Window size (0 for default value) */
+	__u32 reserved[8];	/* For future use, must be initialized to zero */
+};
+
+#define GSMIOC_GETCONF_DLCI	_IOWR('G', 7, struct gsm_dlci_config)
+#define GSMIOC_SETCONF_DLCI	_IOW('G', 8, struct gsm_dlci_config)
+
 #endif
-- 
2.34.1

