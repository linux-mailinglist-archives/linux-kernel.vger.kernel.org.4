Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25966C8DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCYMSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYMSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:18:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A48AF27
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:18:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c18so4148070ple.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679746729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxvSwPgZ9mdBeiC0c/HcPW8UW0lRZApzxjjtDgHZ9yA=;
        b=FzLD4lTNFywGNKfqVGFBIbEyzhMvrJwvIySG14ZYOAOKRhO9oFX2f0M3Q2LLSZ8A+p
         Vr3zg81L8+nmdy2oSELw4elvzrik5TpOEHoSWErb++SxHMsFaoslsTh9L/yAt+P8exTL
         PMHqzKSHWZ0HeWhc/uTHakOkXLQyUGbYS3xkGA8GA3HD5aLGa1LPx5lpNKHtySZswRi6
         s8YVFomco9Bj5oOnksvzldHJRSsRnvmesvhyODUiPyls82rHlh+22IXlH0jWUEBW2Dwh
         +UFtjzBSPsyK8u9k2mm4QPn/PbnVsK3+EHQGq8w2tHsnQP6pbjZY6nnRRhFiap6kWHLW
         eGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679746729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxvSwPgZ9mdBeiC0c/HcPW8UW0lRZApzxjjtDgHZ9yA=;
        b=e7ClJbpDlV0q2oWFEG+556LfnplcOUE7c7ANgyYoJhCUGOnBfT1E2aNw4lnz7VewJp
         ztOtwA6VV+/Irirxqdu9a9Zn71syjz9duafn8i6fjQ/POlZSb09Xm27pwaACsbyyKR5w
         TNlq2AcASgyjorNf8OJFR9Rc1mCzfe4aXEbJXKxXzm+9mYh5iU2zAKRS/3+eIanUG2gl
         jgaV86eGxuw7b2hxG3geok9vpEdpxzXAlkPU23t6c7xTHpRi3q8UzXIBNC6V9pCNHrvY
         pK/onKM18Jor8f5s64KTWgS+Iwf/iUXFRknX/GFe5+LDC+0usrgxIQBEwIk2RBIXR0Fa
         Bs3A==
X-Gm-Message-State: AAQBX9fuNUTWxj75O6TvDShp2bGqufTZlsxv/5rmn0ccqMhxmT8ZNQSv
        Z1Ubpf5F6T4pAcCp/sWTAfFV7KlFSx4=
X-Google-Smtp-Source: AKy350aF6j6MZxQ8uqANN7BDaCF+v7PstgfX5DVcV9Zfts66ppnfy+GLtM/9Ix91D0ptRUIMB/SGKQ==
X-Received: by 2002:a17:90b:3846:b0:236:6a28:f781 with SMTP id nl6-20020a17090b384600b002366a28f781mr6259361pjb.22.1679746729403;
        Sat, 25 Mar 2023 05:18:49 -0700 (PDT)
Received: from Dommie-Laptop.. (111-248-124-24.dynamic-ip.hinet.net. [111.248.124.24])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090a551200b0023d1976cd34sm4527779pji.17.2023.03.25.05.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 05:18:49 -0700 (PDT)
From:   Yan-Jie Wang <yanjiewtw@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yan-Jie Wang <yanjiewtw@gmail.com>
Subject: [PATCH v2] lib/list_sort: reduce if-statements
Date:   Sat, 25 Mar 2023 20:18:24 +0800
Message-Id: <20230325121824.220576-1-yanjiewtw@gmail.com>
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
index 0fb59e92ca2d..4744332c2aca 100644
--- a/lib/list_sort.c
+++ b/lib/list_sort.c
@@ -16,28 +16,15 @@ __attribute__((nonnull(2,3,4)))
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
-	struct list_head *head, **tail = &head;
+	struct list_head *head, **tail = &head, **node = NULL;
 
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
+	struct list_head *tail = head, **node = NULL;
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
index 10c067e3a8d2..fac6e9a9bbff 100644
--- a/tools/lib/list_sort.c
+++ b/tools/lib/list_sort.c
@@ -15,28 +15,15 @@ __attribute__((nonnull(2,3,4)))
 static struct list_head *merge(void *priv, list_cmp_func_t cmp,
 				struct list_head *a, struct list_head *b)
 {
-	struct list_head *head, **tail = &head;
+	struct list_head *head, **tail = &head, **node = NULL;
 
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
+	struct list_head *tail = head, **node = NULL;
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

