Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0442F682C50
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjAaMLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjAaMLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:11:33 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EA245BC2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:11:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p19-20020a25d813000000b0080b78270db5so16026410ybg.15
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=epkWVsTjN+Zr3lw8HyawPlURfWhDUej7yTmuN0bxxtQ=;
        b=Yg7zDNJcofuxAL7B2Zqi1aoU+82S5ZanM52KyHuxMoY9U8h1sfygVNQhRdaIxTXzGs
         +kI+aj9hnTbBH7N8KQJD5YvtTi6v/aGPdyjnp1hJ8+9QDmXq4TXBRixo8IKwqbVD93Lp
         2Doo1HO/QpwcT89nxklTi35WlGsTAwZWP7FL9K9ET9dW3A1bsgHCJXA8TVXQqJ6kNJkP
         Y2WCDNLDSEtEuKT3n1nJh3XXZirMvzxQaki/ynnDQVTOiVWQsrA5f+6PxbEacB1g7eNh
         bEtNOxFqVfmH4GNtlwe3lk150+keBI4NBYX8hOCqv0gLsGWReOVEvorfh/feZXJObNLE
         xXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=epkWVsTjN+Zr3lw8HyawPlURfWhDUej7yTmuN0bxxtQ=;
        b=KihO9olZlDjz5MnQTu05j8Q+mKYJ5n3P+7HmfCsYIjGWKLNs11TMhD0YcCVg0ZxwQy
         fVBzWk3TRkB3Wt1xOMvJtrwl3VdX9hXQdNOuxOEAKxXMdm1EbnD8sRNRFlde5tGBEFoO
         M6/YPD0iZBGsI6y6qQ+CHoA7zmArB93ozSAG+T6WnmL3FHkpi9VqG4cp7lvN3/7YvWh4
         f3hOyI/MP2EskrBdHBjtsWaMvMYwXFo0+RMA/mY8g7Tnr1+u7+5m8L3AUdbn+eULzH8/
         8jlm5bZVvRhMVoairqa/Fb2Hw9wve7WiNDd3vXVwD7WEc6NkxsjPTwm1jJ3yVnm4U2lC
         fK1A==
X-Gm-Message-State: AFqh2kp3JIjL7r+sWIrezm+UNs1SqQ7dj7ZScKniRrmMg4LzAJf/BMiz
        VMj62bXso1LLMClP3TGyI3lGzqujyx9U
X-Google-Smtp-Source: AMrXdXvX9GhxS/ati3RDazQMdA2bTySyNUm1RfWYXlAnJSCwEFWNc6mhG9DHSOaPCSI2q2a0NA564iZQnv2b
X-Received: from localhost ([2a00:79e0:9d:6:8477:8f3f:5b11:3eb9])
 (user=wiktorg job=sendgmr) by 2002:a81:1751:0:b0:501:abfc:b927 with SMTP id
 78-20020a811751000000b00501abfcb927mr4815110ywx.129.1675167091502; Tue, 31
 Jan 2023 04:11:31 -0800 (PST)
Date:   Tue, 31 Jan 2023 13:11:27 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131121127.466443-1-wiktorg@google.com>
Subject: [PATCH RESEND] pipe: avoid creating empty pipe buffers
From:   Wiktor Garbacz <wiktorg@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wiktor Garbacz <wiktorg@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pipe_write cannot be called on notification pipes so
post_one_notification cannot race it.
Locking and second pipe_full check are thus redundant.

This fixes an issue where pipe write could unexpectedly block:
  // Assume there is no reader or reader polls and uses FIONREAD ioctl
  // to read all the available bytes.
  for (int i = 0; i < PIPE_DEF_BUFFERS+1; ++i) {
    write(pipe_fd, buf_that_efaults, PAGE_SIZE);
  }
  // Never reached

Fixes: a194dfe6e6f6 ("pipe: Rearrange sequence in pipe_write() to preallocate slot")
Cc: stable@vger.kernel.org
Signed-off-by: Wiktor Garbacz <wiktorg@google.com>
---
 fs/pipe.c | 35 +++++++++--------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2db..87356a2823cf 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -501,43 +501,26 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				pipe->tmp_page = page;
 			}
 
-			/* Allocate a slot in the ring in advance and attach an
-			 * empty buffer.  If we fault or otherwise fail to use
-			 * it, either the reader will consume it or it'll still
-			 * be there for the next write.
-			 */
-			spin_lock_irq(&pipe->rd_wait.lock);
-
-			head = pipe->head;
-			if (pipe_full(head, pipe->tail, pipe->max_usage)) {
-				spin_unlock_irq(&pipe->rd_wait.lock);
-				continue;
+			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
+			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
+				if (!ret)
+					ret = -EFAULT;
+				break;
 			}
-
-			pipe->head = head + 1;
-			spin_unlock_irq(&pipe->rd_wait.lock);
+			ret += copied;
 
 			/* Insert it into the buffer array */
-			buf = &pipe->bufs[head & mask];
 			buf->page = page;
 			buf->ops = &anon_pipe_buf_ops;
 			buf->offset = 0;
-			buf->len = 0;
+			buf->len = copied;
 			if (is_packetized(filp))
 				buf->flags = PIPE_BUF_FLAG_PACKET;
 			else
 				buf->flags = PIPE_BUF_FLAG_CAN_MERGE;
 			pipe->tmp_page = NULL;
-
-			copied = copy_page_from_iter(page, 0, PAGE_SIZE, from);
-			if (unlikely(copied < PAGE_SIZE && iov_iter_count(from))) {
-				if (!ret)
-					ret = -EFAULT;
-				break;
-			}
-			ret += copied;
-			buf->offset = 0;
-			buf->len = copied;
+			head++;
+			pipe->head = head;
 
 			if (!iov_iter_count(from))
 				break;
-- 
2.39.1.456.gfc5497dd1b-goog

