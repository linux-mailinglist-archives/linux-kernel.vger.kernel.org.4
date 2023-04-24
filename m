Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73166EC77A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjDXHyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjDXHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:54:40 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B60410D7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:54:38 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230424075435b12437b73e3922ee85
        for <linux-kernel@vger.kernel.org>;
        Mon, 24 Apr 2023 09:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ULLYgmbG/ykB1RRdK7/F/RuI/3VzvVuXKuXWTjBDDSs=;
 b=J5DfR/zRamnMR2A/mdk89g4pEaRG1IP+wLnRwMuVMv24OT2IBtHlltQ/FEW9HL4Hp238qs
 BuZyf/OhbT+b5S6GkZ89IuDCths74oqPh1aG8RHTTkaVAeJiWlppk9w9EcPK5h+b8/9s3cj3
 QvaweLxZDH9Pv8dsVIMoM5+XNar+A=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v3 4/8] tty: n_gsm: add open_error counter to gsm_mux
Date:   Mon, 24 Apr 2023 09:52:47 +0200
Message-Id: <20230424075251.5216-4-daniel.starke@siemens.com>
In-Reply-To: <20230424075251.5216-1-daniel.starke@siemens.com>
References: <20230424075251.5216-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Extend the n_gsm link statistics by a failed link open counter in
preparation for an upcoming patch which will expose these.
This counter is increased whenever an attempt to open the control channel
failed. This is true in the following cases:
- new DLCI allocation failed
- connection request (SAMB) with invalid CR flag has been received
- connection response (UA) timed out
- parameter negotiation timed out or failed

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

v2 -> v3:
Merged
commit 2b3174c96696 ("n_gsm: Use array_index_nospec() with index that comes from userspace")
No other changes.

Link: https://lore.kernel.org/all/20230420085017.7314-5-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 9a2cf3e14678..6b6fafb1098a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -339,6 +339,7 @@ struct gsm_mux {
 	unsigned long bad_fcs;
 	unsigned long malformed;
 	unsigned long io_error;
+	unsigned long open_error;
 	unsigned long bad_size;
 	unsigned long unsupported;
 };
@@ -1730,25 +1731,32 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
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
@@ -1768,6 +1776,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	} else {
 		if (debug & DBG_ERRORS)
 			pr_info("%s PN in invalid state\n", __func__);
+		gsm->open_error++;
 	}
 }
 
@@ -2221,6 +2230,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->retries--;
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 		break;
@@ -2236,6 +2246,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 
@@ -2757,12 +2768,16 @@ static void gsm_queue(struct gsm_mux *gsm)
 
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
-- 
2.34.1

