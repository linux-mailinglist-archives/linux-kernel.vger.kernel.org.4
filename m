Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A7750157
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjGLIXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjGLIWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:22:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDC4421D;
        Wed, 12 Jul 2023 01:18:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9C81616DA;
        Wed, 12 Jul 2023 08:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA18C433C8;
        Wed, 12 Jul 2023 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689149908;
        bh=Ci3nRAs35p4iqwTNouGnDja3Fdyihy2hLFK9/UOdi0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve2HDbqBkJFugEVGTp+DU5ufx78fAZlMogYPKGzPvJjLqRROjjYSV4dNQp14fW5Ey
         q41aHA34c47yw2I9AETg9HSxeWTxIlFoKSduMosTEZ4t3BhLDGUvcSWl4h2TkK1Bqt
         TPiSKWBg8IUo0cNJq1HRnyuWVpqcxHSrCwUrPh/U6vGq0tlMdpO1JZJO7m5zBt9ClJ
         o7y+9Ya8s33VRnQm6o7h/hPoA7dBu498JzV90Gq1GJhFi91H1a9tfSU/XLCfUWPzk3
         K5LrYxz6N70sbLUpb74Vvb74J4Z4nWQor3eWjMFUaPya/ocIiWlsM3xYTc/kxo/xBv
         npPGxaEpoiDmg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 05/10] serial: convert uart sysrq handling to u8
Date:   Wed, 12 Jul 2023 10:18:06 +0200
Message-ID: <20230712081811.29004-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712081811.29004-1-jirislaby@kernel.org>
References: <20230712081811.29004-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Propagate u8 from the sysrq code further up to serial's
uart_handle_sysrq_char() and friends.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/serial_core.c |  4 ++--
 include/linux/serial_core.h      | 16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d033611e6..7e37db9adbd4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3505,7 +3505,7 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
 EXPORT_SYMBOL_GPL(uart_insert_char);
 
 #ifdef CONFIG_MAGIC_SYSRQ_SERIAL
-static const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
+static const u8 sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
 
 static void uart_sysrq_on(struct work_struct *w)
 {
@@ -3528,7 +3528,7 @@ static DECLARE_WORK(sysrq_enable_work, uart_sysrq_on);
  * Returns: %false if @ch is out of enabling sequence and should be
  * handled some other way, %true if @ch was consumed.
  */
-bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch)
+bool uart_try_toggle_sysrq(struct uart_port *port, u8 ch)
 {
 	int sysrq_toggle_seq_len = strlen(sysrq_toggle_seq);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 6d58c57acdaa..14dd85ee849e 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -569,7 +569,7 @@ struct uart_port {
 	struct serial_port_device *port_dev;		/* serial core port device */
 
 	unsigned long		sysrq;			/* sysrq timeout */
-	unsigned int		sysrq_ch;		/* char for sysrq */
+	u8			sysrq_ch;		/* char for sysrq */
 	unsigned char		has_sysrq;
 	unsigned char		sysrq_seq;		/* index in sysrq_toggle_seq */
 
@@ -910,9 +910,9 @@ void uart_xchar_out(struct uart_port *uport, int offset);
 #ifdef CONFIG_MAGIC_SYSRQ_SERIAL
 #define SYSRQ_TIMEOUT	(HZ * 5)
 
-bool uart_try_toggle_sysrq(struct uart_port *port, unsigned int ch);
+bool uart_try_toggle_sysrq(struct uart_port *port, u8 ch);
 
-static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
+static inline int uart_handle_sysrq_char(struct uart_port *port, u8 ch)
 {
 	if (!port->sysrq)
 		return 0;
@@ -931,7 +931,7 @@ static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch
 	return 0;
 }
 
-static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+static inline int uart_prepare_sysrq_char(struct uart_port *port, u8 ch)
 {
 	if (!port->sysrq)
 		return 0;
@@ -952,7 +952,7 @@ static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int c
 
 static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 {
-	int sysrq_ch;
+	u8 sysrq_ch;
 
 	if (!port->has_sysrq) {
 		spin_unlock(&port->lock);
@@ -971,7 +971,7 @@ static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port,
 		unsigned long flags)
 {
-	int sysrq_ch;
+	u8 sysrq_ch;
 
 	if (!port->has_sysrq) {
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -987,11 +987,11 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
 		handle_sysrq(sysrq_ch);
 }
 #else	/* CONFIG_MAGIC_SYSRQ_SERIAL */
-static inline int uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
+static inline int uart_handle_sysrq_char(struct uart_port *port, u8 ch)
 {
 	return 0;
 }
-static inline int uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
+static inline int uart_prepare_sysrq_char(struct uart_port *port, u8 ch)
 {
 	return 0;
 }
-- 
2.41.0

