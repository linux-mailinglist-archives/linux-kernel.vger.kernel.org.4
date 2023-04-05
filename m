Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFA16D73EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjDEFtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236913AbjDEFsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:48:45 -0400
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E1273F
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:48:42 -0700 (PDT)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230405054840887ac844a56bd988a8
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Apr 2023 07:48:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=Zt+CBmSJELOiEDRewmYEmnsb90fmgUF3XjBBaB7lybI=;
 b=ZLwSkHl7t6441wzo0AjhjdUIRi7ulepI+nyh8xze81f3d75+5vGxkGjmyK13z8/pFqDDqk
 nw1PzS6U3fOJzY9nKMt8MUeELtOIbXFWv7/CfzAglp4ijzSmJcbCFGDEmrFMuiudeexOxxxx
 1ztS4+2ixXR+dR0il1FOln+hDKpJw=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 5/9] tty: n_gsm: add open_error counter to gsm_mux
Date:   Wed,  5 Apr 2023 07:47:26 +0200
Message-Id: <20230405054730.3850-5-daniel.starke@siemens.com>
In-Reply-To: <20230405054730.3850-1-daniel.starke@siemens.com>
References: <20230405054730.3850-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Extend the n_gsm link statistics by a failed link open counter in
preparation for an upcoming patch which will expose these.
This counter is increased whenever an attempt to open the control channel
failed.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d42b92cbae88..9f6669686c59 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -338,6 +338,7 @@ struct gsm_mux {
 	unsigned long bad_fcs;
 	unsigned long malformed;
 	unsigned long io_error;
+	unsigned long open_error;
 	unsigned long bad_size;
 	unsigned long unsupported;
 };
@@ -1729,25 +1730,32 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	struct gsm_dlci *dlci;
 	struct gsm_dlci_param_bits *params;
 
-	if (dlen < sizeof(struct gsm_dlci_param_bits))
+	if (dlen < sizeof(struct gsm_dlci_param_bits)) {
+		gsm->open_error++;
 		return;
+	}
 
 	/* Invalid DLCI? */
 	params = (struct gsm_dlci_param_bits *)data;
 	addr = FIELD_GET(PN_D_FIELD_DLCI, params->d_bits);
-	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr])
+	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr]) {
+		gsm->open_error++;
 		return;
+	}
 	dlci = gsm->dlci[addr];
 
 	/* Too late for parameter negotiation? */
-	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN)
+	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN) {
+		gsm->open_error++;
 		return;
+	}
 
 	/* Process the received parameters */
 	if (gsm_process_negotiation(gsm, addr, cr, params) != 0) {
 		/* Negotiation failed. Close the link. */
 		if (debug & DBG_ERRORS)
 			pr_info("%s PN failed\n", __func__);
+		gsm->open_error++;
 		gsm_dlci_close(dlci);
 		return;
 	}
@@ -1767,6 +1775,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	} else {
 		if (debug & DBG_ERRORS)
 			pr_info("%s PN in invalid state\n", __func__);
+		gsm->open_error++;
 	}
 }
 
@@ -2220,6 +2229,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->retries--;
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 		break;
@@ -2235,6 +2245,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 
@@ -2756,12 +2767,16 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	switch (gsm->control) {
 	case SABM|PF:
-		if (cr == 1)
+		if (cr == 1) {
+			gsm->open_error++;
 			goto invalid;
+		}
 		if (dlci == NULL)
 			dlci = gsm_dlci_alloc(gsm, address);
-		if (dlci == NULL)
+		if (dlci == NULL) {
+			gsm->open_error++;
 			return;
+		}
 		if (dlci->dead)
 			gsm_response(gsm, address, DM|PF);
 		else {
@@ -3754,8 +3769,10 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 		dlci = gsm->dlci[dc.channel];
 		if (!dlci) {
 			dlci = gsm_dlci_alloc(gsm, dc.channel);
-			if (!dlci)
+			if (!dlci) {
+				gsm->open_error++;
 				return -ENOMEM;
+			}
 		}
 		gsm_dlci_copy_config_values(dlci, &dc);
 		if (copy_to_user((void __user *)arg, &dc, sizeof(dc)))
@@ -3769,8 +3786,10 @@ static int gsmld_ioctl(struct tty_struct *tty, unsigned int cmd,
 		dlci = gsm->dlci[dc.channel];
 		if (!dlci) {
 			dlci = gsm_dlci_alloc(gsm, dc.channel);
-			if (!dlci)
+			if (!dlci) {
+				gsm->open_error++;
 				return -ENOMEM;
+			}
 		}
 		return gsm_dlci_config(dlci, &dc, 0);
 	default:
-- 
2.34.1

