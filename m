Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D656C8E33
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCYMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCYMcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:32:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6710AA8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:32:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f22so65490plr.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679747569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rch3xYeG6DW9krPGWOTHk/HlZRTT0Lo7FDRCIHvxzBM=;
        b=iA6Dbjd9N731A7vonAEnSIfWCUqbLY9wEJDMC+7U/sB4Rwz6WAsT04sEvBo38q+YuH
         xWOYYPDCLYcCso4jv3/7BCVFkzzJmwjA55ixMMU9rdz99xpveX8aX9aeLXSL/wiifBu3
         JE7keyQkrz8wjiUBtbq0AXWbAQJLkg6XvqkGwPmg50x4vhAaeJlZbKeB4LZfvT5hO7BG
         EExy5W4ThSYz9b1kGtwlfto7GDSSK1u0LYs+SFx0O4PRNUMzWBSu5IUQ81xDTIF7FWI3
         CJZvWX2TrMtVzumxtiuI7C/DUz//HPaxxj04+xLd//2YIyBOqf8TX3VoeYlD6ekI53JS
         0hLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679747569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rch3xYeG6DW9krPGWOTHk/HlZRTT0Lo7FDRCIHvxzBM=;
        b=yAZLsiY5iWQRVSpR2tqtIxftGfICPYfpd2syKw/ObM5pDvpykMVC6fMdKUbZ2ZkK8A
         hJQdV/B/73pYfBBiB5LHcyXjLb3MYh1H3PEOpGm5QY7ZNEyoHyuZI6jgiKbYagVXfsqU
         oZqdryHtgoFUuSpNckhCU+r9KY2YjdcKmsMer23xiaoNXF2r81BG6A5yxDg4DglnsPB5
         B3NQyO/jT/23U5oSFBDTt5R2XTevCNDW/CS13uBqYxAea+mIC65ztJY+8m/JSbkrVXu9
         /GdPxKhsfk9IvifH2mALEhrE27mDsuRUwCVjkda5oyUQUaibKEhRE/ldY5T3Bg/U13s4
         s9Dg==
X-Gm-Message-State: AAQBX9eJtENEEoukicEdPZM06XliQ4OyVjqi08+ivIEemOFcNoirQsFV
        5CpWMqA7oUxCAk4KmTcAvCo/s2y9B4w=
X-Google-Smtp-Source: AKy350ZnRk0irYtRxvgTqRS9Bhou8b3jvF/ZcJZgoLfDeil+OxYjWvaFMsIMsZZD1rYvA+GOD+UwtA==
X-Received: by 2002:a17:902:ba88:b0:19e:25b4:7740 with SMTP id k8-20020a170902ba8800b0019e25b47740mr5173078pls.28.1679747569394;
        Sat, 25 Mar 2023 05:32:49 -0700 (PDT)
Received: from Dommie-Laptop.. (111-248-124-24.dynamic-ip.hinet.net. [111.248.124.24])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b0019468fe44d3sm15807134plk.25.2023.03.25.05.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:32:49 -0700 (PDT)
From:   Yan-Jie Wang <yanjiewtw@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yan-Jie Wang <yanjiewtw@gmail.com>
Subject: [PATCH v3] lib/list_sort: reduce if-statements
Date:   Sat, 25 Mar 2023 20:32:16 +0800
Message-Id: <20230325123216.226120-1-yanjiewtw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230325091654.106040-1-yanjiewtw@gmail.com>
References: <20230325091654.106040-1-yanjiewtw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce if-statements in merge and merge_final functions by using
indirect pointers and bitwise operations.

This will make the code more elegant and reduce the number of branch
instructions in compiled code.

Signed-off-by: Yan-Jie Wang <yanjiewtw@gmail.com>
---
Changes since v2:
 * Remove unnecessory assignments to the variable, node.

Changes since v1:
 * Use do-while instead of for-loop to avoid an unnecessory check at
   the beginning of the loop.
 * After moving *node to the next node, just check whether *node is
   NULL or not instead of checking both a && b to determine whether to
   continue.
 * Above changes further reduces the compiled code size and branch
   instructions.

 lib/list_sort.c       | 55 ++++++++++++-------------------------------
 tools/lib/list_sort.c | 55 ++++++++++++-------------------------------
 2 files changed, 30 insertions(+), 80 deletions(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 0fb59e92ca2d..9a2745a1a44b 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -16,28 +16,15 @@ __attribute__((nonnull(2,3,4)))
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
-	struct list_head *head, **tail = &head;
+	struct list_head *head, **tail = &head, **node;
 
-	for (;;) {
+	do {
 		/* if equal, take 'a' -- important for sort stability */
-		if (cmp(priv, a, b) <= 0) {
-			*tail = a;
-			tail = &a->next;
-			a = a->next;
-			if (!a) {
-				*tail = b;
-				break;
-			}
-		} else {
-			*tail = b;
-			tail = &b->next;
-			b = b->next;
-			if (!b) {
-				*tail = a;
-				break;
-			}
-		}
-	}
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		*tail = *node;
+		tail = &(*node)->next;
+	} while ((*node = (*node)->next));
+	*tail = (struct list_head *) ((uintptr_t) a | (uintptr_t) b);
 	return head;
 }
 
@@ -52,29 +39,17 @@ __attribute__((nonnull(2,3,4,5)))
 static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
 			struct list_head *a, struct list_head *b)
 {
-	struct list_head *tail = head;
+	struct list_head *tail = head, **node;
 	u8 count = 0;
 
-	for (;;) {
+	do {
 		/* if equal, take 'a' -- important for sort stability */
-		if (cmp(priv, a, b) <= 0) {
-			tail->next = a;
-			a->prev = tail;
-			tail = a;
-			a = a->next;
-			if (!a)
-				break;
-		} else {
-			tail->next = b;
-			b->prev = tail;
-			tail = b;
-			b = b->next;
-			if (!b) {
-				b = a;
-				break;
-			}
-		}
-	}
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		tail->next = *node;
+		(*node)->prev = tail;
+		tail = *node;
+	} while ((*node = (*node)->next));
+	b = (struct list_head *) ((uintptr_t) a | (uintptr_t) b);
 
 	/* Finish linking remainder of list b on to tail */
 	tail->next = b;
diff --git a/tools/lib/list_sort.c b/tools/lib/list_sort.c
index 10c067e3a8d2..5054b2196981 100644
--- a/tools/lib/list_sort.c
+++ b/tools/lib/list_sort.c
@@ -15,28 +15,15 @@ __attribute__((nonnull(2,3,4)))
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
-	struct list_head *head, **tail = &head;
+	struct list_head *head, **tail = &head, **node;
 
-	for (;;) {
+	do {
 		/* if equal, take 'a' -- important for sort stability */
-		if (cmp(priv, a, b) <= 0) {
-			*tail = a;
-			tail = &a->next;
-			a = a->next;
-			if (!a) {
-				*tail = b;
-				break;
-			}
-		} else {
-			*tail = b;
-			tail = &b->next;
-			b = b->next;
-			if (!b) {
-				*tail = a;
-				break;
-			}
-		}
-	}
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		*tail = *node;
+		tail = &(*node)->next;
+	} while ((*node = (*node)->next));
+	*tail = (struct list_head *) ((uintptr_t) a | (uintptr_t) b);
 	return head;
 }
 
@@ -51,29 +38,17 @@ __attribute__((nonnull(2,3,4,5)))
 static void merge_final(void *priv, list_cmp_func_t cmp, struct list_head *head,
 			struct list_head *a, struct list_head *b)
 {
-	struct list_head *tail = head;
+	struct list_head *tail = head, **node;
 	u8 count = 0;
 
-	for (;;) {
+	do {
 		/* if equal, take 'a' -- important for sort stability */
-		if (cmp(priv, a, b) <= 0) {
-			tail->next = a;
-			a->prev = tail;
-			tail = a;
-			a = a->next;
-			if (!a)
-				break;
-		} else {
-			tail->next = b;
-			b->prev = tail;
-			tail = b;
-			b = b->next;
-			if (!b) {
-				b = a;
-				break;
-			}
-		}
-	}
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		tail->next = *node;
+		(*node)->prev = tail;
+		tail = *node;
+	} while ((*node = (*node)->next));
+	b = (struct list_head *) ((uintptr_t) a | (uintptr_t) b);
 
 	/* Finish linking remainder of list b on to tail */
 	tail->next = b;

base-commit: 65aca32efdcb0965502d3db2f1fa33838c070952
-- 
2.34.1

