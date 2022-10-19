Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1A6040A0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJSKHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJSKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:06:35 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308E37FBF;
        Wed, 19 Oct 2022 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666172706; x=1697708706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uzmWH6BVJnji7ty8wQYZD2FSX6+VKQm7vy7t4xf+g2Y=;
  b=iOURUV7EvbOnDdjxdfSqx1totlS/irBVF1YdbF4iz3H9lp8gySLY28g7
   TeRGkBbScFYujh8E/kWQRQxkAwpgGXBIyic4M6YU1MZkynCEOFF9eGbuQ
   4y5NlNoMmsz/FxmhY3UVUaQGs0LPXRflXgfMKIK9r9ZJwXMzhdS6ZCxdA
   xP/abeGsvqhpKxe1Pf/wT2fPPFb0c7cYv/HupwwHWhZIUaFM6OkeLdTon
   ztiURZgh8/8+jtNJa4ZGHhIqGZATQBZih/nwnt41BwKhmD+z9+gZTtk+V
   61B82kPKL/nF7AOrXEWOlYRX71hnl+9wvZlq0Uo1zRDJMxJCPjZCeIZCF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="305097153"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="305097153"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:42:50 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="631584363"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="631584363"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:42:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] tty: Convert tty_buffer flags to bool
Date:   Wed, 19 Oct 2022 12:42:39 +0300
Message-Id: <20221019094241.10870-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct tty_buffer has flags which is only used for storing TTYB_NORMAL.
There is also a few quite confusing operations for checking the presense
of TTYB_NORMAL. Simplify things by converting flags to bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_buffer.c   | 28 ++++++++++++++--------------
 include/linux/tty_buffer.h |  5 +----
 include/linux/tty_flip.h   |  4 ++--
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5e287dedce01..be3431575a19 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -107,7 +107,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 	p->commit = 0;
 	p->lookahead = 0;
 	p->read = 0;
-	p->flags = 0;
+	p->flags = true;
 }
 
 /**
@@ -249,7 +249,7 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
  * __tty_buffer_request_room	-	grow tty buffer if needed
  * @port: tty port
  * @size: size desired
- * @flags: buffer flags if new buffer allocated (default = 0)
+ * @flags: buffer flags if new buffer allocated
  *
  * Make at least @size bytes of linear space available for the tty buffer.
  *
@@ -260,19 +260,19 @@ void tty_buffer_flush(struct tty_struct *tty, struct tty_ldisc *ld)
  * Returns: the size we managed to find.
  */
 static int __tty_buffer_request_room(struct tty_port *port, size_t size,
-				     int flags)
+				     bool flags)
 {
 	struct tty_bufhead *buf = &port->buf;
 	struct tty_buffer *b, *n;
 	int left, change;
 
 	b = buf->tail;
-	if (b->flags & TTYB_NORMAL)
+	if (!b->flags)
 		left = 2 * b->size - b->used;
 	else
 		left = b->size - b->used;
 
-	change = (b->flags & TTYB_NORMAL) && (~flags & TTYB_NORMAL);
+	change = !b->flags && flags;
 	if (change || left < size) {
 		/* This is the slow path - looking for new buffers to use */
 		n = tty_buffer_alloc(port, size);
@@ -300,7 +300,7 @@ static int __tty_buffer_request_room(struct tty_port *port, size_t size,
 
 int tty_buffer_request_room(struct tty_port *port, size_t size)
 {
-	return __tty_buffer_request_room(port, size, 0);
+	return __tty_buffer_request_room(port, size, true);
 }
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
@@ -320,17 +320,17 @@ int tty_insert_flip_string_fixed_flag(struct tty_port *port,
 		const unsigned char *chars, char flag, size_t size)
 {
 	int copied = 0;
+	bool flags = flag != TTY_NORMAL;
 
 	do {
 		int goal = min_t(size_t, size - copied, TTY_BUFFER_PAGE);
-		int flags = (flag == TTY_NORMAL) ? TTYB_NORMAL : 0;
 		int space = __tty_buffer_request_room(port, goal, flags);
 		struct tty_buffer *tb = port->buf.tail;
 
 		if (unlikely(space == 0))
 			break;
 		memcpy(char_buf_ptr(tb, tb->used), chars, space);
-		if (~tb->flags & TTYB_NORMAL)
+		if (tb->flags)
 			memset(flag_buf_ptr(tb, tb->used), flag, space);
 		tb->used += space;
 		copied += space;
@@ -393,13 +393,13 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
 int __tty_insert_flip_char(struct tty_port *port, unsigned char ch, char flag)
 {
 	struct tty_buffer *tb;
-	int flags = (flag == TTY_NORMAL) ? TTYB_NORMAL : 0;
+	bool flags = flag != TTY_NORMAL;
 
 	if (!__tty_buffer_request_room(port, 1, flags))
 		return 0;
 
 	tb = port->buf.tail;
-	if (~tb->flags & TTYB_NORMAL)
+	if (tb->flags)
 		*flag_buf_ptr(tb, tb->used) = flag;
 	*char_buf_ptr(tb, tb->used++) = ch;
 
@@ -424,13 +424,13 @@ EXPORT_SYMBOL(__tty_insert_flip_char);
 int tty_prepare_flip_string(struct tty_port *port, unsigned char **chars,
 		size_t size)
 {
-	int space = __tty_buffer_request_room(port, size, TTYB_NORMAL);
+	int space = __tty_buffer_request_room(port, size, false);
 
 	if (likely(space)) {
 		struct tty_buffer *tb = port->buf.tail;
 
 		*chars = char_buf_ptr(tb, tb->used);
-		if (~tb->flags & TTYB_NORMAL)
+		if (tb->flags)
 			memset(flag_buf_ptr(tb, tb->used), TTY_NORMAL, space);
 		tb->used += space;
 	}
@@ -492,7 +492,7 @@ static void lookahead_bufs(struct tty_port *port, struct tty_buffer *head)
 			unsigned char *p, *f = NULL;
 
 			p = char_buf_ptr(head, head->lookahead);
-			if (~head->flags & TTYB_NORMAL)
+			if (head->flags)
 				f = flag_buf_ptr(head, head->lookahead);
 
 			port->client_ops->lookahead_buf(port, p, f, count);
@@ -509,7 +509,7 @@ receive_buf(struct tty_port *port, struct tty_buffer *head, int count)
 	const char *f = NULL;
 	int n;
 
-	if (~head->flags & TTYB_NORMAL)
+	if (head->flags)
 		f = flag_buf_ptr(head, head->read);
 
 	n = port->client_ops->receive_buf(port, p, f, count);
diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 1796648c2907..6ceb2789e6c8 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -17,14 +17,11 @@ struct tty_buffer {
 	int commit;
 	int lookahead;		/* Lazy update on recv, can become less than "read" */
 	int read;
-	int flags;
+	bool flags;
 	/* Data points here */
 	unsigned long data[];
 };
 
-/* Values for .flags field of tty_buffer */
-#define TTYB_NORMAL	1	/* buffer has no flags buffer */
-
 static inline unsigned char *char_buf_ptr(struct tty_buffer *b, int ofs)
 {
 	return ((unsigned char *)b->data) + ofs;
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 483d41cbcbb7..bfaaeee61a05 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -25,9 +25,9 @@ static inline int tty_insert_flip_char(struct tty_port *port,
 	struct tty_buffer *tb = port->buf.tail;
 	int change;
 
-	change = (tb->flags & TTYB_NORMAL) && (flag != TTY_NORMAL);
+	change = !tb->flags && (flag != TTY_NORMAL);
 	if (!change && tb->used < tb->size) {
-		if (~tb->flags & TTYB_NORMAL)
+		if (tb->flags)
 			*flag_buf_ptr(tb, tb->used) = flag;
 		*char_buf_ptr(tb, tb->used++) = ch;
 		return 1;
-- 
2.30.2

