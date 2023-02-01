Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418E068611C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjBAIDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjBAIDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:03:11 -0500
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582CCDBC8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 00:03:06 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202302010803040276ac9c295431dc68
        for <linux-kernel@vger.kernel.org>;
        Wed, 01 Feb 2023 09:03:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=uIC7wmtM876zS1feMXVcrIfYaMgU0Q3UqvmHnO01y6Y=;
 b=O2u9ft1yxfdTxZQA9nNo0NnO3ioyzSgxYzVJls+h4GVMPuK6EJGWExnF+UlNBcEXPpcFUP
 HqaMr6UEtNq6QtP8mHhQyD/lU9AkGweDQVLM8F2qNmqTx6jV6dfGraONpwBsaxSzYAupChqj
 24rg5yORQen+qJd0p0M8R3OQ/2tXE=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 3/3] tty: n_gsm: add TIOCMIWAIT support
Date:   Wed,  1 Feb 2023 09:01:51 +0100
Message-Id: <20230201080151.2068-3-daniel.starke@siemens.com>
In-Reply-To: <20230201080151.2068-1-daniel.starke@siemens.com>
References: <20230201080151.2068-1-daniel.starke@siemens.com>
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

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 118511c1fa37..48fb7dad44cd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -1542,6 +1542,7 @@ static void gsm_process_modem(struct tty_struct *tty, struct gsm_dlci *dlci,
 	if (brk & 0x01)
 		tty_insert_flip_char(&dlci->port, 0, TTY_BREAK);
 	dlci->modem_rx = mlines;
+	wake_up_interruptible(&dlci->gsm->event);
 }
 
 /**
@@ -3848,6 +3849,35 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 	return -EPROTONOSUPPORT;
 }
 
+/**
+ * gsm_wait_modem_change	-	wait for modem status line change
+ * @dlci: channel
+ * @mask: modem status line bits
+ */
+
+static int gsm_wait_modem_change(struct gsm_dlci *dlci, u32 mask)
+{
+	struct gsm_mux *gsm = dlci->gsm;
+	u32 old = dlci->modem_rx & mask;
+	int ret;
+
+	if (gsm->dead)
+		return -ENODEV;
+
+	do {
+		ret = wait_event_interruptible(gsm->event, gsm->dead
+					      || old ^ (dlci->modem_rx & mask));
+		if (ret)
+			return ret;
+		if (dlci->state != DLCI_OPEN)
+			return -EL2NSYNC;
+		if (gsm->dead)
+			return -ENODEV;
+	} while ((old ^ (dlci->modem_rx & mask)) == 0);
+
+	return 0;
+}
+
 static bool gsm_carrier_raised(struct tty_port *port)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
@@ -4107,6 +4137,8 @@ static int gsmtty_ioctl(struct tty_struct *tty,
 		gsm_destroy_network(dlci);
 		mutex_unlock(&dlci->mutex);
 		return 0;
+	case TIOCMIWAIT:
+		return gsm_wait_modem_change(dlci, arg);
 	default:
 		return -ENOIOCTLCMD;
 	}
-- 
2.34.1

