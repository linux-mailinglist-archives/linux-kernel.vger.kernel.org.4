Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03AD5F4107
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJDKtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJDKti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:49:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE36BB8C;
        Tue,  4 Oct 2022 03:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97E70B819BB;
        Tue,  4 Oct 2022 10:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196F3C43470;
        Tue,  4 Oct 2022 10:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664880573;
        bh=MSUEy0p5m4xPtjCwyAZnyJ9BO8infGUnOQEUbRQhxTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SLGEI7c63EuP5e4QAS/HpoAWRmS4U5s7BGd2DKLafgoQSmykRyFG4062sqLNg7X59
         kkDNbdW4GYcdZO62xyQA10d95OZCZO3/HDyKBUom/xa0u6ebtAlw9o21pR18OOZDnC
         BQXQykavAJ+YvWXqM0/rY5oyQCtnRrEK+Oc2J2/MQr2EBBjBMoQ1/eNUQ78+LQJxui
         iOTfwsLr3+Uorc2EkWVjx4PiARhWGRDoEdL/F7yvMvV0lTGs9Ut2nxNwBYPnxRrUEG
         f8bpbe7RSKXQPIbtRLS+k5EiOfWuKTXgfmGVeVcJnq3FwDiioc7w/uDm3OGLLjTF0H
         djyOOIvAxUWPw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 1/3] tty: serial: introduce transmit helpers
Date:   Tue,  4 Oct 2022 12:49:25 +0200
Message-Id: <20221004104927.14361-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004104927.14361-1-jirislaby@kernel.org>
References: <20221004104927.14361-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
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
index d657f2a42a7b..dbbc4408bb19 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -664,6 +664,86 @@ struct uart_driver {
 
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

