Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152D16C8CE7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 10:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjCYJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCYJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:17:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98664EC5B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:17:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w4so3933096plg.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679735834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJpIXu9tlf2Gu4D95jY9X2YoHbkoJ6/PZq6kehT2lyI=;
        b=X5/UuRHfQcNqxm8pRv93hP3LY/wEcu/s/2KLDeXgpChaPWdVC6mtl6TNoGhXOfOHRI
         uL4/xxoaFT8dYHMld05dV2hcxyVHi5k6yOEDd3o15KzIvSBKtH921w4pjdQhomTp1Uoa
         6J+VQvduvFX0vIlvxFYsj1dtb8+ggOWKDtUc5JZQCzzVOhRO+XxVyQoN2rim6c2hVkBC
         V35xCAeceVQqJ17cRoyDHH1XHd8lpekEPKXX8jy+MqdgU4xUDJOkoAYWWW7AfG/bkLub
         W4v98Z3hwNK290OLO4eHDKuheJA9e93nimomwC1WpBPx1qOOhm3lL0Irhf61f8XXqEDj
         4v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679735834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJpIXu9tlf2Gu4D95jY9X2YoHbkoJ6/PZq6kehT2lyI=;
        b=q9eEl9Mj56i3f1eDtsT4bLEiIbGzJm6uq82KQr9gWUPlpctuIJdISAfgqBs+oaUBw1
         bzNFL2ZwP0+z8OguTxHG2aqLPxVBIl1atxPW+s7IZLo7uZElIMfZBOfh8itaeUyX4QOB
         rmmeTtvjHvhx6WLlWzPhLgP6d2iQ1P6hTICdQ5kILdOL0PfLTgAbEo5PgvzAC7LyKIGA
         ZJoZRSdLs04y7siZb3CsBe1OmXiNthswVJP43I96E+JSODqr8oluH6lUr7cfJytgN3eH
         5jFSMiaYgpMDq0IIEQM5yuerMq/C2m6NQWpD3HOpk7AYffJoYV1hnMmX/gu6oioUgYXJ
         Nbgg==
X-Gm-Message-State: AAQBX9d1ZC3hmgB9FZBFcSt1u/Rkt5w9VDtw6je1w2Shi+UyLxVv3HKP
        LmDKuzZ+k2wl1+F6oqKqayykmcytGbg=
X-Google-Smtp-Source: AKy350YSY+yLrMXngrhU4OppEO85gGV+mQ3qhd9YLeT2ePtMLuAy4aTQwH4X/InP1Gm8KjCbAJdvJQ==
X-Received: by 2002:a17:90b:1647:b0:237:50b6:7835 with SMTP id il7-20020a17090b164700b0023750b67835mr5913828pjb.20.1679735833700;
        Sat, 25 Mar 2023 02:17:13 -0700 (PDT)
Received: from Dommie-Laptop.. ([180.217.16.141])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b0019a88c1cf63sm15495670plp.180.2023.03.25.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 02:17:12 -0700 (PDT)
From:   Yan-Jie Wang <yanjiewtw@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yan-Jie Wang <yanjiewtw@gmail.com>
Subject: [PATCH] lib/list_sort: reduce if-statements
Date:   Sat, 25 Mar 2023 17:16:54 +0800
Message-Id: <20230325091654.106040-1-yanjiewtw@gmail.com>
X-Mailer: git-send-email 2.34.1
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
 lib/list_sort.c       | 51 +++++++++++--------------------------------
 tools/lib/list_sort.c | 51 +++++++++++--------------------------------
 2 files changed, 26 insertions(+), 76 deletions(-)

diff --git a/lib/list_sort.c b/lib/list_sort.c
index 0fb59e92ca2d..393fcb9948c5 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -16,28 +16,15 @@ __attribute__((nonnull(2,3,4)))
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
-	struct list_head *head, **tail = &head;
+	struct list_head *head, **tail = &head, **node;
 
-	for (;;) {
+	for (node = NULL; a && b; *node = (*node)->next) {
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
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		*tail = *node;
+		tail = &(*node)->next;
 	}
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
+	for (node = NULL; a && b; *node = (*node)->next) {
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
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		tail->next = *node;
+		(*node)->prev = tail;
+		tail = *node;
 	}
+	b = (struct list_head *) ((uintptr_t) a | (uintptr_t) b);
 
 	/* Finish linking remainder of list b on to tail */
 	tail->next = b;
diff --git a/tools/lib/list_sort.c b/tools/lib/list_sort.c
index 10c067e3a8d2..5b1baa6a67d9 100644
--- a/tools/lib/list_sort.c
+++ b/tools/lib/list_sort.c
@@ -15,28 +15,15 @@ __attribute__((nonnull(2,3,4)))
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
-	struct list_head *head, **tail = &head;
+	struct list_head *head, **tail = &head, **node;
 
-	for (;;) {
+	for (node = NULL; a && b; *node = (*node)->next) {
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
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		*tail = *node;
+		tail = &(*node)->next;
 	}
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
+	for (node = NULL; a && b; *node = (*node)->next) {
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
+		node = cmp(priv, a, b) <= 0 ? &a : &b;
+		tail->next = *node;
+		(*node)->prev = tail;
+		tail = *node;
 	}
+	b = (struct list_head *) ((uintptr_t) a | (uintptr_t) b);
 
 	/* Finish linking remainder of list b on to tail */
 	tail->next = b;

base-commit: 65aca32efdcb0965502d3db2f1fa33838c070952
-- 
2.34.1

