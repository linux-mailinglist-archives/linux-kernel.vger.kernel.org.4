Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B045BDC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 07:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiITFVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 01:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiITFUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:20:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8651A24;
        Mon, 19 Sep 2022 22:20:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 13F511F8B3;
        Tue, 20 Sep 2022 05:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663651253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnYIsxCL+KbExG01vZ8PgWu6CAjR2xXdwTGwXQEtYhU=;
        b=vYAQ9qHAJjYWYZhZQvUrQzJO9nZAoMwTMR/2MHuc2zp7HHSk8+QgEPFKL7QVN5OsfC6DIm
        ZKgUGpitBcu0lBJhXO456MOEAWP+ODFih4vkF2J4e9Kn//YFUUor4cL7Tf5eKTf9KMapAT
        vjxsiDMtxODIROS1MPEWhtPKCdQZzwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663651253;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YnYIsxCL+KbExG01vZ8PgWu6CAjR2xXdwTGwXQEtYhU=;
        b=g9HauGzSZE9U5I1ImnQ5E7W3Yz3hhXntN4tYDbZkVbU+6flvuzwp4cjbThWueAn9wP6oxq
        t3n2G0/4nN5byjDQ==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CA2612C141;
        Tue, 20 Sep 2022 05:20:52 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v4 08/10] tty: serial: introduce transmit helpers
Date:   Tue, 20 Sep 2022 07:20:48 +0200
Message-Id: <20220920052049.20507-9-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920052049.20507-1-jslaby@suse.cz>
References: <20220920052049.20507-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many serial drivers do the same thing:
* send x_char if set
* keep sending from the xmit circular buffer until either
  - the loop reaches the end of the xmit buffer
  - TX is stopped
  - HW fifo is full
* check for pending characters and:
  - wake up tty writers to fill for more data into xmit buffer
  - stop TX if there is nothing in the xmit buffer

The only differences are:
* how to write the character to the HW fifo
* the check of the end condition:
  - is the HW fifo full?
  - is limit of the written characters reached?

So unify the above into two helpers:
* uart_port_tx_limited() -- it performs the above taking the written
  characters limit into account, and
* uart_port_tx() -- the same as above, except it only checks the HW
  readiness, not the characters limit.

The HW specific operations (as stated as "differences" above) are passed
as arguments to the macros. They are:
* tx_ready -- returns true if HW can accept more data.
* put_char -- write a character to the device.
* tx_done -- when the write loop is done, perform arbitrary action
  before potential invocation of ops->stop_tx() happens.

Note that the above are macros. This means the code is generated in
place and the above 3 arguments are "inlined". I.e. no added penalty by
generating call instructions for every single character. Nor any
indirect calls. (As in some previous versions of this patchset.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---

Notes:
    [v4] switch from helper generators to helpers similar to wait_event()
         [Arnd]

 Documentation/driver-api/serial/driver.rst |  3 +
 include/linux/serial_core.h                | 80 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 23c6b956cd90..98d268555dcc 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -78,6 +78,9 @@ Other functions
            uart_get_lsr_info uart_handle_dcd_change uart_handle_cts_change
            uart_try_toggle_sysrq uart_get_console
 
+.. kernel-doc:: include/linux/serial_core.h
+   :identifiers: uart_port_tx_limited uart_port_tx
+
 Other notes
 -----------
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index de992585ea64..b8338a0a52ee 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -663,6 +663,86 @@ struct uart_driver {
 
 void uart_write_wakeup(struct uart_port *port);
 
+#define __uart_port_tx(uport, ch, tx_ready, put_char, tx_done, for_test,      \
+		for_post)						      \
+({									      \
+	struct uart_port *__port = (uport);				      \
+	struct circ_buf *xmit = &__port->state->xmit;			      \
+	unsigned int pending;						      \
+									      \
+	for (; (for_test) && (tx_ready); (for_post), __port->icount.tx++) {   \
+		if (__port->x_char) {					      \
+			(ch) = __port->x_char;				      \
+			(put_char);					      \
+			__port->x_char = 0;				      \
+			continue;					      \
+		}							      \
+									      \
+		if (uart_circ_empty(xmit) || uart_tx_stopped(__port))	      \
+			break;						      \
+									      \
+		(ch) = xmit->buf[xmit->tail];				      \
+		(put_char);						      \
+		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;		      \
+	}								      \
+									      \
+	(tx_done);							      \
+									      \
+	pending = uart_circ_chars_pending(xmit);			      \
+	if (pending < WAKEUP_CHARS) {					      \
+		uart_write_wakeup(__port);				      \
+									      \
+		if (pending == 0)					      \
+			__port->ops->stop_tx(__port);			      \
+	}								      \
+									      \
+	pending;							      \
+})
+
+/**
+ * uart_port_tx_limited -- transmit helper for uart_port with count limiting
+ * @port: uart port
+ * @ch: variable to store a character to be written to the HW
+ * @count: a limit of characters to send
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ * @tx_done: function to call after the loop is done
+ *
+ * This helper transmits characters from the xmit buffer to the hardware using
+ * @put_char(). It does so until @count characters are sent and while @tx_ready
+ * evaluates to true.
+ *
+ * Returns: the number of characters in the xmit buffer when done.
+ *
+ * The expression in macro parameters shall be designed as follows:
+ *  * **tx_ready:** should evaluate to true if the HW can accept more data to
+ *    be sent. This parameter can be %true, which means the HW is always ready.
+ *  * **put_char:** shall write @ch to the device of @port.
+ *  * **tx_done:** when the write loop is done, this can perform arbitrary
+ *    action before potential invocation of ops->stop_tx() happens. If the
+ *    driver does not need to do anything, use e.g. ({}).
+ *
+ * For all of them, @port->lock is held, interrupts are locally disabled and
+ * the expressions must not sleep.
+ */
+#define uart_port_tx_limited(port, ch, count, tx_ready, put_char, tx_done) ({ \
+	unsigned int __count = (count);					      \
+	__uart_port_tx(port, ch, tx_ready, put_char, tx_done, __count,	      \
+			__count--);					      \
+})
+
+/**
+ * uart_port_tx -- transmit helper for uart_port
+ * @port: uart port
+ * @ch: variable to store a character to be written to the HW
+ * @tx_ready: can HW accept more data function
+ * @put_char: function to write a character
+ *
+ * See uart_port_tx_limited() for more details.
+ */
+#define uart_port_tx(port, ch, tx_ready, put_char)			\
+	__uart_port_tx(port, ch, tx_ready, put_char, ({}), true, ({}))
+
 /*
  * Baud rate helpers.
  */
-- 
2.37.3

