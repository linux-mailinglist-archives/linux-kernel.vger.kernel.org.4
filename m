Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE3689C33
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjBCOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjBCOus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:50:48 -0500
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBA573058
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:50:45 -0800 (PST)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230203145043e8dbe453e4aaf29f1c
        for <linux-kernel@vger.kernel.org>;
        Fri, 03 Feb 2023 15:50:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=soWeu6gkV3NEcYNRrfIYl154ZKDvANaWKtl+GG89qaE=;
 b=Zoq+elDa54uNPWIqcLTvhC6h8SEmYAp7+CC2tc+BukBRK8JfKgI6Lc6sKWeADUWMCy979s
 mK2dnRwPYk5zS953sx2RfMHa+lhFKXzeRrj/cbjY7ymzsk84F7gMo3+IejoLYtCOI1CJ/e/l
 k/v9BOA0ogvP2xpqH6oJyjLHgPsIs=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 4/4] tty: n_gsm: add TIOCMIWAIT support
Date:   Fri,  3 Feb 2023 15:50:23 +0100
Message-Id: <20230203145023.6012-4-daniel.starke@siemens.com>
In-Reply-To: <20230203145023.6012-1-daniel.starke@siemens.com>
References: <20230203145023.6012-1-daniel.starke@siemens.com>
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

Add support for the TIOCMIWAIT ioctl on the virtual ttys. This enables the
user to wait for virtual modem signals like RING.

More work is needed to support also TIOCGICOUNT.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

v2 -> v3:
Added appropriate cast of arg in gsm_wait_modem_change() call as remarked
in the review.
No other changes.

Link: https://lore.kernel.org/all/Y9vZOsAuzKjBNArJ@kroah.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index cf1ab7d619d9..aa3488280f1b 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1542,6 +1542,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	if (brk & 0x01)
 		tty_insert_flip_char(&dlci->port, 0, TTY_BREAK);
 	dlci->modem_rx = mlines;
+	wake_up_interruptible(&dlci->gsm->event);
 }
 
 /**
@@ -2129,7 +2130,7 @@ static void gsm_dlci_close(struct gsm_dlci *dlci)
 	/* A DLCI 0 close is a MUX termination so we need to kick that
 	   back to userspace somehow */
 	gsm_dlci_data_kick(dlci);
-	wake_up(&dlci->gsm->event);
+	wake_up_all(&dlci->gsm->event);
 }
 
 /**
@@ -2339,6 +2340,7 @@ static void gsm_dlci_begin_close(struct gsm_dlci *dlci)
 	dlci->state = DLCI_CLOSING;
 	gsm_command(dlci->gsm, dlci->addr, DISC|PF);
 	mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
+	wake_up_interruptible(&gsm->event);
 }
 
 /**
@@ -3877,6 +3879,33 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 	return -EPROTONOSUPPORT;
 }
 
+/**
+ * gsm_wait_modem_change - wait for modem status line change
+ * @dlci: channel
+ * @mask: modem status line bits
+ *
+ * The function returns if:
+ * - any given modem status line bit changed
+ * - the wait event function got interrupted (e.g. by a signal)
+ * - the underlying DLCI was closed
+ * - the underlying ldisc device was removed
+ */
+static int gsm_wait_modem_change(struct gsm_dlci *dlci, u32 mask)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	u32 old = dlci->modem_rx;
+	int ret;
+
+	ret = wait_event_interruptible(gsm->event, gsm->dead ||
+				       dlci->state != DLCI_OPEN ||
+				       (old ^ dlci->modem_rx) & mask);
+	if (gsm->dead)
+		return -ENODEV;
+	if (dlci->state != DLCI_OPEN)
+		return -EL2NSYNC;
+	return ret;
+}
+
 static bool gsm_carrier_raised(struct tty_port *port)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
@@ -4136,6 +4165,8 @@ static int gsmtty_ioctl(struct tty_struct *tty,
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 		return 0;
+	case TIOCMIWAIT:
+		return gsm_wait_modem_change(dlci, (u32)arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.34.1

