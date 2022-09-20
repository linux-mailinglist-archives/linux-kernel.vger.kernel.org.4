Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2462E5BDC47
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiITFVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiITFUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB354DB6B;
        Mon, 19 Sep 2022 22:20:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DEC3921CAC;
        Tue, 20 Sep 2022 05:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2j1gKQOr1uxxBIOy9FBMHSzPifjlvk0WSprmVOm5tI=;
        b=TB7ValD4tq+6lrfOsEL0XqCBFMmyTXcYJGM/cYGpmLtabu2/N57LTU0spObr9aYBFMMxu2
        AT7j8uex3oSCejgHHIGoQgGC5XPPjc4Y7i+b+wDlR+tARQzNC5H30e7OOU6AEtdMt1SzO0
        02xGH3PetX1OJLJEgd5wKxQNGtvdko8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651250;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q2j1gKQOr1uxxBIOy9FBMHSzPifjlvk0WSprmVOm5tI=;
        b=D8Y0qdcScKEcRODpwYokfEoxpfZGW7JThdHdxmBa0miUSeQsQJgy7P/oJoET3gLEReVFIN
        e3aM9fkl06IFiDBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9C90B2C141;
        Tue, 20 Sep 2022 05:20:50 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH v4 02/10] tty: serial: clean up stop-tx part in altera_uart_tx_chars()
Date:   Tue, 20 Sep 2022 07:20:42 +0200
Message-Id: <20220920052049.20507-3-jslaby@suse.cz>
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

The "stop TX" path in altera_uart_tx_chars() is open-coded, so:
* use uart_circ_empty() to check if the buffer is empty, and
* when true, call altera_uart_stop_tx().

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v4] this is new in v4 -- extracted as a separate change

 drivers/tty/serial/altera_uart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index a38db2cb8dc1..4170e66601ec 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -272,10 +272,8 @@ static void altera_uart_tx_chars(struct altera_uart *pp)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (xmit->head == xmit->tail) {
-		pp->imr &= ~ALTERA_UART_CONTROL_TRDY_MSK;
-		altera_uart_update_ctrl_reg(pp);
-	}
+	if (uart_circ_empty(xmit))
+		altera_uart_stop_tx(port);
 }
 
 static irqreturn_t altera_uart_interrupt(int irq, void *data)
-- 
2.37.3

