Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0386179BE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 10:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiKCJWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 05:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiKCJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 05:21:18 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 02:21:17 PDT
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F00CDF48
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 02:21:16 -0700 (PDT)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202211030920105207e79a08a7b63f20
        for <linux-kernel@vger.kernel.org>;
        Thu, 03 Nov 2022 10:20:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NdDppYDLu8yz6PkPX9FRLqLfAtptQYpIs0pGGCxBVL8=;
 b=DO5NtWW4rxNrbkarvy6/B7aPZMfRPU7LW7rund4kcAHZJvykVWIefbJH3/T/3WDdcrn17p
 k/gwk6/+Fj8ZZI8cKO2fTbFurituA9P4WVpktVAowy0tyhaxrJOUg5dzo/qz4M0PLErVIrMS
 TZtY+fy2b5WikIo8EdCUXnrQOjgDM=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 2/3] tty: n_gsm: add parameters used with parameter negotiation
Date:   Thu,  3 Nov 2022 10:17:42 +0100
Message-Id: <20221103091743.2119-2-daniel.starke@siemens.com>
In-Reply-To: <20221103091743.2119-1-daniel.starke@siemens.com>
References: <20221103091743.2119-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
the newer 27.010 here. Chapter 5.4.6.3.1 describes the encoding of the
parameter negotiation messages.

Add the parameters used there to 'gsm_mux' and 'gsm_dlci' and initialize both
according to the value ranges and recommended defaults defined in chapter 5.7.

Replace the use of the DLC default values from the 'gsm_mux' fields with the DLC
specific values from the 'gsm_dlci' fields where applicable.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 58 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 45 insertions(+), 13 deletions(-)

v2 -> v3:
No changes.

Link: https://lore.kernel.org/all/20221024130114.2070-2-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 570c40a3d78f..c217013b3e16 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -40,6 +40,7 @@
 #include <linux/tty.h>
 #include <linux/ctype.h>
 #include <linux/mm.h>
+#include <linux/math.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
@@ -75,7 +76,12 @@ module_param(debug, int, 0600);
 
 #define T1	10		/* 100mS */
 #define T2	34		/* 333mS */
+#define T3	10		/* 10s */
 #define N2	3		/* Retry 3 times */
+#define K	2		/* outstanding I frames */
+
+#define MAX_T3 255		/* In seconds. */
+#define MAX_WINDOW_SIZE 7	/* Limit of K in error recovery mode. */
 
 /* Use long timers for testing at low speed with debug on */
 #ifdef DEBUG_TIMING
@@ -160,7 +166,12 @@ struct gsm_dlci {
 	int prev_adaption;
 	u32 modem_rx;		/* Our incoming virtual modem lines */
 	u32 modem_tx;		/* Our outgoing modem lines */
+	unsigned int mtu;
 	bool dead;		/* Refuse re-open */
+	/* Configuration */
+	u8 prio;		/* Priority */
+	u8 ftype;		/* Frame type */
+	u8 k;			/* Window size */
 	/* Flow control */
 	bool throttled;		/* Private copy of throttle state */
 	bool constipated;	/* Throttle status for outgoing */
@@ -283,7 +294,9 @@ struct gsm_mux {
 	int adaption;		/* 1 or 2 supported */
 	u8 ftype;		/* UI or UIH */
 	int t1, t2;		/* Timers in 1/100th of a sec */
+	unsigned int t3;	/* Power wake-up timer in seconds. */
 	int n2;			/* Retry count */
+	u8 k;			/* Window size */
 
 	/* Statistics (not currently exposed) */
 	unsigned long bad_fcs;
@@ -1075,12 +1088,12 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 		return 0;
 
 	/* MTU/MRU count only the data bits but watch adaption mode */
-	if ((len + h) > gsm->mtu)
-		len = gsm->mtu - h;
+	if ((len + h) > dlci->mtu)
+		len = dlci->mtu - h;
 
 	size = len + h;
 
-	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+	msg = gsm_data_alloc(gsm, dlci->addr, size, dlci->ftype);
 	if (!msg)
 		return -ENOMEM;
 	dp = msg->data;
@@ -1144,19 +1157,19 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 	len = dlci->skb->len + overhead;
 
 	/* MTU/MRU count only the data bits */
-	if (len > gsm->mtu) {
+	if (len > dlci->mtu) {
 		if (dlci->adaption == 3) {
 			/* Over long frame, bin it */
 			dev_kfree_skb_any(dlci->skb);
 			dlci->skb = NULL;
 			return 0;
 		}
-		len = gsm->mtu;
+		len = dlci->mtu;
 	} else
 		last = 1;
 
 	size = len + overhead;
-	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+	msg = gsm_data_alloc(gsm, dlci->addr, size, dlci->ftype);
 	if (msg == NULL) {
 		skb_queue_tail(&dlci->skb_list, dlci->skb);
 		dlci->skb = NULL;
@@ -1213,7 +1226,7 @@ static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
 		return -EINVAL;
 	}
 
-	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
+	msg = gsm_data_alloc(gsm, dlci->addr, size, dlci->ftype);
 	if (!msg) {
 		pr_err("%s: gsm_data_alloc error", __func__);
 		return -ENOMEM;
@@ -1338,8 +1351,9 @@ static void gsm_dlci_data_kick(struct gsm_dlci *dlci)
 static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 			       int dlen)
 {
-	struct gsm_msg *msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->ftype);
+	struct gsm_msg *msg;
 
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
 	if (msg == NULL)
 		return -ENOMEM;
 
@@ -1365,7 +1379,8 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 					int dlen)
 {
 	struct gsm_msg *msg;
-	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->ftype);
+
+	msg = gsm_data_alloc(gsm, 0, dlen + 2, gsm->dlci[0]->ftype);
 	if (msg == NULL)
 		return;
 	msg->data[0] = (cmd & 0xFE) << 1 | EA;	/* Clear C/R */
@@ -2075,6 +2090,13 @@ static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
 	dlci->gsm = gsm;
 	dlci->addr = addr;
 	dlci->adaption = gsm->adaption;
+	dlci->mtu = gsm->mtu;
+	if (addr == 0)
+		dlci->prio = 0;
+	else
+		dlci->prio = roundup(addr + 1, 8) - 1;
+	dlci->ftype = gsm->ftype;
+	dlci->k = gsm->k;
 	dlci->state = DLCI_CLOSED;
 	if (addr) {
 		dlci->data = gsm_dlci_data;
@@ -2650,7 +2672,9 @@ static struct gsm_mux *gsm_alloc_mux(void)
 
 	gsm->t1 = T1;
 	gsm->t2 = T2;
+	gsm->t3 = T3;
 	gsm->n2 = N2;
+	gsm->k = K;
 	gsm->ftype = UIH;
 	gsm->adaption = 1;
 	gsm->encoding = GSM_ADV_OPT;
@@ -2691,7 +2715,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 	c->initiator = gsm->initiator;
 	c->t1 = gsm->t1;
 	c->t2 = gsm->t2;
-	c->t3 = 0;	/* Not supported */
+	c->t3 = gsm->t3;
 	c->n2 = gsm->n2;
 	if (gsm->ftype == UIH)
 		c->i = 1;
@@ -2700,7 +2724,7 @@ static void gsm_copy_config_values(struct gsm_mux *gsm,
 	pr_debug("Ftype %d i %d\n", gsm->ftype, c->i);
 	c->mru = gsm->mru;
 	c->mtu = gsm->mtu;
-	c->k = 0;
+	c->k = gsm->k;
 }
 
 static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
@@ -2717,12 +2741,16 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 		return -EINVAL;
 	if (c->mru > MAX_MRU || c->mtu > MAX_MTU)
 		return -EINVAL;
+	if (c->t3 > MAX_T3)
+		return -EINVAL;
 	if (c->n2 > 255)
 		return -EINVAL;
 	if (c->encapsulation > 1)	/* Basic, advanced, no I */
 		return -EINVAL;
 	if (c->initiator > 1)
 		return -EINVAL;
+	if (c->k > MAX_WINDOW_SIZE)
+		return -EINVAL;
 	if (c->i == 0 || c->i > 2)	/* UIH and UI only */
 		return -EINVAL;
 	/*
@@ -2770,6 +2798,10 @@ static int gsm_config(struct gsm_mux *gsm, struct gsm_config *c)
 		gsm->t1 = c->t1;
 	if (c->t2)
 		gsm->t2 = c->t2;
+	if (c->t3)
+		gsm->t3 = c->t3;
+	if (c->k)
+		gsm->k = c->k;
 
 	/*
 	 * FIXME: We need to separate activation/deactivation from adding
@@ -3298,9 +3330,9 @@ static int gsm_create_network(struct gsm_dlci *dlci, struct gsm_netconfig *nc)
 		pr_err("alloc_netdev failed\n");
 		return -ENOMEM;
 	}
-	net->mtu = dlci->gsm->mtu;
+	net->mtu = dlci->mtu;
 	net->min_mtu = MIN_MTU;
-	net->max_mtu = dlci->gsm->mtu;
+	net->max_mtu = dlci->mtu;
 	mux_net = netdev_priv(net);
 	mux_net->dlci = dlci;
 	kref_init(&mux_net->ref);
-- 
2.34.1

