Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34FC6D73FA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbjDEFub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbjDEFuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:50:24 -0400
X-Greylist: delayed 72 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Apr 2023 22:49:56 PDT
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81D21FF9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:49:56 -0700 (PDT)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023040505484232e1a29472174f0976
        for <linux-kernel@vger.kernel.org>;
        Wed, 05 Apr 2023 07:48:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lIFBSLziB/EDCfodaoQXEaZEnI8/9GXyz3jkwj8YkEw=;
 b=pbc5yB8pE+GCO3pUf+8d5AbLtbu1Xf85ojZhCLQIgW8VcU5fGYIscrknhGJin/Cq4gbq9R
 uv0l5XN8o23yGO3vDwsWWvRTSbkzkUmaOIC162iNXzuuMNFW49h+g4F7YAhnvaldwUsgnvTc
 vrOxgFrpC59XaVSFQcglrksBjiRYs=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 8/9] tty: n_gsm: add DLCI specific rx/tx statistics
Date:   Wed,  5 Apr 2023 07:47:29 +0200
Message-Id: <20230405054730.3850-8-daniel.starke@siemens.com>
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

Add counters for the number of data bytes received/transmitted per DLCI in
for preparation for an upcoming patch which will expose these values to the
user.

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 49cb2dbfa233..61f9825fde3c 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -185,6 +185,9 @@ struct gsm_dlci {
 	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	struct net_device *net; /* network interface, if created */
+	/* Statistics (not currently exposed) */
+	u64 tx;			/* Data bytes sent on this DLCI */
+	u64 rx;			/* Data bytes received on this DLCI */
 };
 
 /*
@@ -1215,6 +1218,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 	tty_port_tty_wakeup(&dlci->port);
 
 	__gsm_data_queue(dlci, msg);
+	dlci->tx += len;
 	/* Bytes of data we used up */
 	return size;
 }
@@ -1459,6 +1463,7 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(gsm->dlci[0], msg);
+	gsm->dlci[0]->tx += dlen;
 
 	return 0;
 }
@@ -1485,6 +1490,7 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(gsm->dlci[0], msg);
+	gsm->dlci[0]->tx += dlen;
 }
 
 /**
@@ -1849,10 +1855,13 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
 						const u8 *data, int clen)
 {
 	u8 buf[1];
+	struct gsm_dlci *dlci = gsm->dlci[0];
+
+	if (dlci)
+		dlci->rx += clen;
 
 	switch (command) {
 	case CMD_CLD: {
-		struct gsm_dlci *dlci = gsm->dlci[0];
 		/* Modem wishes to close down */
 		if (dlci) {
 			dlci->dead = true;
@@ -1931,6 +1940,8 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
 	ctrl = gsm->pending_cmd;
 	dlci = gsm->dlci[0];
+	if (dlci)
+		dlci->rx += clen;
 	command |= 1;
 	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
@@ -2295,6 +2306,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 			need_pn = true;
 	}
 
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2327,6 +2341,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2346,6 +2363,9 @@ static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_wait_config(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_CLOSING:
@@ -2422,6 +2442,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 		fallthrough;
 	case 1:		/* Line state will go via DLCI 0 controls only */
 	default:
+		dlci->rx += clen;
 		tty_insert_flip_string(port, data, clen);
 		tty_flip_buffer_push(port);
 	}
@@ -2782,6 +2803,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 			gsm->open_error++;
 			return;
 		}
+		dlci->rx += gsm->len;
 		if (dlci->dead)
 			gsm_response(gsm, address, DM|PF);
 		else {
-- 
2.34.1

