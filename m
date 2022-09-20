Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB225BDC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiITFVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiITFUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A14DB7A;
        Mon, 19 Sep 2022 22:20:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 917321F889;
        Tue, 20 Sep 2022 05:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rG/RuZqj0s6o1zZB075A45sdYsusSoWW/nWCKNRy+j4=;
        b=0TndwT8Irvaz65JK4PQuLXA1r9Or8dZzulSYgk2LY2iwFTvi19BGbyyDQYc00DxXR8FV4e
        V0UcEoDgnI+REjHvJ99LV/EFyoDCG8/+RAwfZJ6GDQ5eKEq7G+rra3bQYsPuaItDkh7lJw
        oEsXw5lAULbrQZ3jeh0S9PEjplNBIuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rG/RuZqj0s6o1zZB075A45sdYsusSoWW/nWCKNRy+j4=;
        b=PfuLgrKsT+5LTJiq5qsWX4ileX2mTCDLaxn0ajGoYDfynzGLB4suDo083oJ0IvMz4hn2Aj
        p6tfxM5GAjIclJCA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5BB6B2C142;
        Tue, 20 Sep 2022 05:20:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 01/10] tty: serial: move and cleanup vt8500_tx_empty()
Date:   Tue, 20 Sep 2022 07:20:41 +0200
Message-Id: <20220920052049.20507-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920052049.20507-1-jslaby@suse.cz>
References: <20220920052049.20507-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make vt8500_tx_empty() more readable by introducing a new local variable
and move the function before handle_tx(). That way we can reuse it in
there too.

Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v3] this is new in v3 -- extracted as a separate change from later
         patches

 drivers/tty/serial/vt8500_serial.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 508ad7afa6de..10fbdb09965f 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -187,6 +187,13 @@ static void handle_rx(struct uart_port *port)
 	tty_flip_buffer_push(tport);
 }
 
+static unsigned int vt8500_tx_empty(struct uart_port *port)
+{
+	unsigned int idx = vt8500_read(port, VT8500_URFIDX) & 0x1f;
+
+	return idx < 16 ? TIOCSER_TEMT : 0;
+}
+
 static void handle_tx(struct uart_port *port)
 {
 	struct circ_buf *xmit = &port->state->xmit;
@@ -201,7 +208,7 @@ static void handle_tx(struct uart_port *port)
 		return;
 	}
 
-	while ((vt8500_read(port, VT8500_URFIDX) & 0x1f) < 16) {
+	while (vt8500_tx_empty(port)) {
 		if (uart_circ_empty(xmit))
 			break;
 
@@ -260,12 +267,6 @@ static irqreturn_t vt8500_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static unsigned int vt8500_tx_empty(struct uart_port *port)
-{
-	return (vt8500_read(port, VT8500_URFIDX) & 0x1f) < 16 ?
-						TIOCSER_TEMT : 0;
-}
-
 static unsigned int vt8500_get_mctrl(struct uart_port *port)
 {
 	unsigned int usr;
-- 
2.37.3

