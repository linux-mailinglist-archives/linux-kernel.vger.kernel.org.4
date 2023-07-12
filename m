Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C033C74FC56
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 02:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjGLArU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 20:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 20:47:15 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CFB10D4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:47:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b898cfa6a1so9140965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 17:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689122834; x=1689727634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJHEVsPXGWHqsJoWMs2SXGP/dgciG32UfjRi0VGCdeE=;
        b=PZeJ886W/oAqgibJDnI4kMYditvxSoDVVQKUvsrNa6hJC2RciZA4/XDfJbR/GFiJcN
         ziVXQ6rMuYZcDOBUm+002+A8xu5/3nUOR+nkF0SskrybnMXQlzcoOyf9QgVa6gOo7Hr5
         vH+/r53KV/aDbsyM/bey7jiPFwKUvp3X7j2A/TcHXzjYybSjN2nSQBAutTZ4J0md1epR
         d2tTzmRdCc6X06ovP75BVgVzDlBQNm9eHwaMb2fa7UeeHFHzmu3gXWREQuOW1djjmt25
         VongB2IiDsFM//BzOqjvdT6HPbjxrnHtUf35tzLaB3HKf9zQZEZBiU1Ulvty3mlv22fa
         ei8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689122834; x=1689727634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJHEVsPXGWHqsJoWMs2SXGP/dgciG32UfjRi0VGCdeE=;
        b=JVTRtnpS96RC1V9GS1gSUAQHUcKvU4WCqf7i/pSZ0chfBBNfQxLEDqzDjt8rFCDSos
         LmgBTTXJYedhfua8Mb6qcy5GI5RjPAaiN3ResfPijasLM9T9iYQVLQ1tWaEMEjYl+dxm
         Vh+sFvFAR4KwwNysI+ubj8eigTex0WYEIWFVGgS0L1dtn/CicDEnc7wkXrxld+LlULQM
         hfaBhhvvRwGocLNkpsL3A8YrTS3t0Oicotqz2QsjQY1Av09P0BXEizVmj73XX6rMmusT
         Dw1jvr9dxxQFQ0q/ElCoZN8Tp8LOP+k198TuC6ZDlA6I8EFXsqsAjROFZzYnRgjIwDUV
         Tnhg==
X-Gm-Message-State: ABy/qLabme9Nd4j8MEkEEO3QknKvXBLxQ7jtRt4nJU4JugLw5ue+HPs0
        vQAKrYCIJT2tyLakkbKp2x9FIw==
X-Google-Smtp-Source: APBJJlHkC3A+zq7LnnwLbWkAjzljLxsmHgWHDTPfiPM2JKusBK2JcHM6qTyQrQZ+Ys67Lt9qbLklAA==
X-Received: by 2002:a17:902:f68c:b0:1b8:17e8:547e with SMTP id l12-20020a170902f68c00b001b817e8547emr21541502plg.1.1689122834238;
        Tue, 11 Jul 2023 17:47:14 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902b18800b001b694140d96sm2543542plr.170.2023.07.11.17.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 17:47:13 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/7] futex: factor out the futex wake handling
Date:   Tue, 11 Jul 2023 18:47:00 -0600
Message-Id: <20230712004705.316157-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712004705.316157-1-axboe@kernel.dk>
References: <20230712004705.316157-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for having another waker that isn't futex_wake_mark(),
add a wake handler in futex_q. No extra data is associated with the
handler outside of struct futex_q itself. futex_wake_mark() is defined as
the standard wakeup helper, now set through futex_q_init like other
defaults.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/futex/futex.h    | 4 ++++
 kernel/futex/requeue.c  | 3 ++-
 kernel/futex/waitwake.c | 6 +++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index d2949fca37d1..8eaf1a5ce967 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -69,6 +69,9 @@ struct futex_pi_state {
 	union futex_key key;
 } __randomize_layout;
 
+struct futex_q;
+typedef void (futex_wake_fn)(struct wake_q_head *wake_q, struct futex_q *q);
+
 /**
  * struct futex_q - The hashed futex queue entry, one per waiting task
  * @list:		priority-sorted list of tasks waiting on this futex
@@ -98,6 +101,7 @@ struct futex_q {
 
 	struct task_struct *task;
 	spinlock_t *lock_ptr;
+	futex_wake_fn *wake;
 	union futex_key key;
 	struct futex_pi_state *pi_state;
 	struct rt_mutex_waiter *rt_waiter;
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index cba8b1a6a4cc..e892bc6c41d8 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -58,6 +58,7 @@ enum {
 
 const struct futex_q futex_q_init = {
 	/* list gets initialized in futex_queue()*/
+	.wake		= futex_wake_mark,
 	.key		= FUTEX_KEY_INIT,
 	.bitset		= FUTEX_BITSET_MATCH_ANY,
 	.requeue_state	= ATOMIC_INIT(Q_REQUEUE_PI_NONE),
@@ -591,7 +592,7 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 		/* Plain futexes just wake or requeue and are done */
 		if (!requeue_pi) {
 			if (++task_count <= nr_wake)
-				futex_wake_mark(&wake_q, this);
+				this->wake(&wake_q, this);
 			else
 				requeue_futex(this, hb1, hb2, &key2);
 			continue;
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index ba01b9408203..3471af87cb7d 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -174,7 +174,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;
 
-			futex_wake_mark(&wake_q, this);
+			this->wake(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -289,7 +289,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 				ret = -EINVAL;
 				goto out_unlock;
 			}
-			futex_wake_mark(&wake_q, this);
+			this->wake(&wake_q, this);
 			if (++ret >= nr_wake)
 				break;
 		}
@@ -303,7 +303,7 @@ int futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 					ret = -EINVAL;
 					goto out_unlock;
 				}
-				futex_wake_mark(&wake_q, this);
+				this->wake(&wake_q, this);
 				if (++op_ret >= nr_wake2)
 					break;
 			}
-- 
2.40.1

