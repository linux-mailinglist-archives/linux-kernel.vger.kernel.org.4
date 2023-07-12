Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0E74FF8F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGLGml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjGLGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761510F2;
        Tue, 11 Jul 2023 23:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56293616E6;
        Wed, 12 Jul 2023 06:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B492EC433C9;
        Wed, 12 Jul 2023 06:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689144145;
        bh=GFYfNtNLbJlEVMFARX9D95/viTg0poYGqyqRS7iGZIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oZ1wldekR0t0ek/LvRcS1k1M6WxZ0PEZQy+pRkKD2d9FDyitlyTDs4DdqG4CjWdNE
         RDH3g544uw/QjV9wX7idZAZon2ChoBszPFrVha5kDrjP2qLZi+tv+NDMfWY3Zn0KB2
         z55/WUxClIGQaafrymmtXI0Z1KPc1t3AA7XU8NLdB92BarOUBb57/iQT9lA8K+bWrZ
         arJoaU8xzshPCqBuNx5xgYFh0lBNeG6SUDf2SBh/qVNajhSK8R93bgHiQrW0szZf8J
         6sh84rH8HuO1xFG/xRM+JCiU0oqARbORsVzZS5hCQC+jr6JLZ2kKyh+BFs94dA9Lo1
         rzHUC51jE30+w==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 4/4] n_tty: make many tty parameters const
Date:   Wed, 12 Jul 2023 08:42:16 +0200
Message-ID: <20230712064216.12150-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712064216.12150-1-jirislaby@kernel.org>
References: <20230712064216.12150-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In many n_tty functions, the 'tty' parameter is used to either obtain
'ldata', or test the tty flags. So mark 'tty' in them const to make
obvious that it is only read.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/n_tty.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index bab7005ef520..0043cc84b91a 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -164,7 +164,8 @@ static void zero_buffer(const struct tty_struct *tty, u8 *buffer, size_t size)
 		memset(buffer, 0, size);
 }
 
-static void tty_copy(struct tty_struct *tty, void *to, size_t tail, size_t n)
+static void tty_copy(const struct tty_struct *tty, void *to, size_t tail,
+		     size_t n)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t size = N_TTY_BUF_SIZE - tail;
@@ -195,7 +196,7 @@ static void tty_copy(struct tty_struct *tty, void *to, size_t tail, size_t n)
  *  * n_tty_read()/consumer path:
  *	holds non-exclusive %termios_rwsem
  */
-static void n_tty_kick_worker(struct tty_struct *tty)
+static void n_tty_kick_worker(const struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -215,9 +216,9 @@ static void n_tty_kick_worker(struct tty_struct *tty)
 	}
 }
 
-static ssize_t chars_in_buffer(struct tty_struct *tty)
+static ssize_t chars_in_buffer(const struct tty_struct *tty)
 {
-	struct n_tty_data *ldata = tty->disc_data;
+	const struct n_tty_data *ldata = tty->disc_data;
 	ssize_t n = 0;
 
 	if (!ldata->icanon)
@@ -393,7 +394,7 @@ static inline int is_utf8_continuation(unsigned char c)
  * Returns: true if the utf8 character @c is a multibyte continuation character
  * and the terminal is in unicode mode.
  */
-static inline int is_continuation(unsigned char c, struct tty_struct *tty)
+static inline int is_continuation(unsigned char c, const struct tty_struct *tty)
 {
 	return I_IUTF8(tty) && is_utf8_continuation(c);
 }
@@ -913,7 +914,7 @@ static void echo_char_raw(unsigned char c, struct n_tty_data *ldata)
  * This variant tags control characters to be echoed as "^X" (where X is the
  * letter representing the control char).
  */
-static void echo_char(unsigned char c, struct tty_struct *tty)
+static void echo_char(unsigned char c, const struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -951,7 +952,7 @@ static inline void finish_erasing(struct n_tty_data *ldata)
  * Locking: n_tty_receive_buf()/producer path:
  *	caller holds non-exclusive %termios_rwsem
  */
-static void eraser(unsigned char c, struct tty_struct *tty)
+static void eraser(unsigned char c, const struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	enum { ERASE, WERASE, KILL } kill_type;
@@ -1167,7 +1168,7 @@ static void n_tty_receive_break(struct tty_struct *tty)
  * Called from the receive_buf path so single threaded. Does not need locking
  * as num_overrun and overrun_time are function private.
  */
-static void n_tty_receive_overrun(struct tty_struct *tty)
+static void n_tty_receive_overrun(const struct tty_struct *tty)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1191,7 +1192,8 @@ static void n_tty_receive_overrun(struct tty_struct *tty)
  * Locking: n_tty_receive_buf()/producer path:
  * 	caller holds non-exclusive %termios_rwsem
  */
-static void n_tty_receive_parity_error(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_parity_error(const struct tty_struct *tty,
+				       unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1498,8 +1500,8 @@ static void n_tty_lookahead_flow_ctrl(struct tty_struct *tty, const unsigned cha
 }
 
 static void
-n_tty_receive_buf_real_raw(struct tty_struct *tty, const unsigned char *cp,
-			   int count)
+n_tty_receive_buf_real_raw(const struct tty_struct *tty,
+			   const unsigned char *cp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	size_t n, head;
@@ -1900,9 +1902,9 @@ static int n_tty_open(struct tty_struct *tty)
 	return 0;
 }
 
-static inline int input_available_p(struct tty_struct *tty, int poll)
+static inline int input_available_p(const struct tty_struct *tty, int poll)
 {
-	struct n_tty_data *ldata = tty->disc_data;
+	const struct n_tty_data *ldata = tty->disc_data;
 	int amt = poll && !TIME_CHAR(tty) && MIN_CHAR(tty) ? MIN_CHAR(tty) : 1;
 
 	if (ldata->icanon && !L_EXTPROC(tty))
@@ -1929,7 +1931,7 @@ static inline int input_available_p(struct tty_struct *tty, int poll)
  *		caller holds non-exclusive %termios_rwsem;
  *		read_tail published
  */
-static bool copy_from_read_buf(struct tty_struct *tty,
+static bool copy_from_read_buf(const struct tty_struct *tty,
 				      unsigned char **kbp,
 				      size_t *nr)
 
@@ -1984,7 +1986,7 @@ static bool copy_from_read_buf(struct tty_struct *tty,
  *	caller holds non-exclusive %termios_rwsem;
  *	read_tail published
  */
-static bool canon_copy_from_read_buf(struct tty_struct *tty,
+static bool canon_copy_from_read_buf(const struct tty_struct *tty,
 				     unsigned char **kbp,
 				     size_t *nr)
 {
-- 
2.41.0

