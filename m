Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0C6EEFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239763AbjDZIFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240107AbjDZIFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:05:04 -0400
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050124481
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 01:04:36 -0700 (PDT)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230426080333613b1a8ebe0ca6762f
        for <linux-kernel@vger.kernel.org>;
        Wed, 26 Apr 2023 10:03:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=lC6w6yfdqndEz513xywOwMNVxUGFN+4gfRNRaxuBxcE=;
 b=NV7Vm5uIsTst6KZMgfww/S0vuoLU6RshrikuGmbEbRXyJHXfZ6xhUASUAjBxxveZVKrxA/
 qgliGtYy2TAaXn69LsBR18MbtD5XMdIqcHibqCh0idvmIcknjoYQMETjGXXoMAJjS+EzZW/8
 R9XdKoBj3rDBYXY0lN7sNWtjFXpiU=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 8/8] tty: n_gsm: add DLCI specific rx/tx statistics
Date:   Wed, 26 Apr 2023 10:03:15 +0200
Message-Id: <20230426080315.7595-8-daniel.starke@siemens.com>
In-Reply-To: <20230426080315.7595-1-daniel.starke@siemens.com>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/tty/n_gsm.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

v3 -> v4:
No changes.

Link: https://lore.kernel.org/all/20230424075251.5216-8-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 62bff4474b57..2e2e1dafcf40 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -186,6 +186,9 @@ struct gsm_dlci {
 	void (*data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	void (*prev_data)(struct gsm_dlci *dlci, const u8 *data, int len);
 	struct net_device *net; /* network interface, if created */
+	/* Statistics (not currently exposed) */
+	u64 tx;			/* Data bytes sent on this DLCI */
+	u64 rx;			/* Data bytes received on this DLCI */
 };
 
 /*
@@ -1216,6 +1219,7 @@ static int gsm_dlci_data_output(struct gsm_mux *gsm, struct gsm_dlci *dlci)
 	tty_port_tty_wakeup(&dlci->port);
 
 	__gsm_data_queue(dlci, msg);
+	dlci->tx += len;
 	/* Bytes of data we used up */
 	return size;
 }
@@ -1283,6 +1287,7 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 	memcpy(dp, dlci->skb->data, len);
 	skb_pull(dlci->skb, len);
 	__gsm_data_queue(dlci, msg);
+	dlci->tx += len;
 	if (last) {
 		dev_kfree_skb_any(dlci->skb);
 		dlci->skb = NULL;
@@ -1461,6 +1466,7 @@ static int gsm_control_command(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 
 	return 0;
 }
@@ -1488,6 +1494,7 @@ static void gsm_control_reply(struct gsm_mux *gsm, int cmd, const u8 *data,
 	msg->data[1] = (dlen << 1) | EA;
 	memcpy(msg->data + 2, data, dlen);
 	gsm_data_queue(dlci, msg);
+	dlci->tx += dlen;
 }
 
 /**
@@ -1852,10 +1859,13 @@ static void gsm_control_message(struct gsm_mux *gsm, unsigned int command,
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
@@ -1934,6 +1944,8 @@ static void gsm_control_response(struct gsm_mux *gsm, unsigned int command,
 
 	ctrl = gsm->pending_cmd;
 	dlci = gsm->dlci[0];
+	if (dlci)
+		dlci->rx += clen;
 	command |= 1;
 	/* Does the reply match our command */
 	if (ctrl != NULL && (command == ctrl->cmd || command == CMD_NSC)) {
@@ -2298,6 +2310,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
 			need_pn = true;
 	}
 
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2330,6 +2345,9 @@ static void gsm_dlci_begin_open(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_WAITING_CONFIG:
@@ -2349,6 +2367,9 @@ static void gsm_dlci_set_opening(struct gsm_dlci *dlci)
  */
 static void gsm_dlci_set_wait_config(struct gsm_dlci *dlci)
 {
+	dlci->tx = 0;
+	dlci->rx = 0;
+
 	switch (dlci->state) {
 	case DLCI_CLOSED:
 	case DLCI_CLOSING:
@@ -2425,6 +2446,7 @@ static void gsm_dlci_data(struct gsm_dlci *dlci, const u8 *data, int clen)
 		fallthrough;
 	case 1:		/* Line state will go via DLCI 0 controls only */
 	default:
+		dlci->rx += clen;
 		tty_insert_flip_string(port, data, clen);
 		tty_flip_buffer_push(port);
 	}
@@ -2785,6 +2807,7 @@ static void gsm_queue(struct gsm_mux *gsm)
 			gsm->open_error++;
 			return;
 		}
+		dlci->rx += gsm->len;
 		if (dlci->dead)
 			gsm_response(gsm, address, DM|PF);
 		else {
-- 
2.34.1

