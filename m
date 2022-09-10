Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26DB5B4AD7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 01:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiIJXZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 19:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIJXZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 19:25:51 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054473DF15
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:25:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662852347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IWRb6xubtC5pF+wzMkdOEJAm7Xvs8Cx6RhZM8IbyZTw=;
        b=LvJIOhNPyu76a4uuIsCCjsnS77ayOwWWa+hN9QddZOvAmkw+dpc8lkf143cwvcymlkAmEl
        Cg2CqDDG7lry6W3W/v/73F1EpR+wS7TcD7iXEtoSRtlArg/jyqJblH6zy3ER/r+3SBBjq2
        QIbBV7wr30aRNhM5elILWP1eN1hS8OU=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan: better invalid/double-free report header
Date:   Sun, 11 Sep 2022 01:25:30 +0200
Message-Id: <fce40f8dbd160972fe01a1ff39d0c426c310e4b7.1662852281.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Update the report header for invalid- and double-free bugs to contain
the address being freed:

BUG: KASAN: invalid-free in kfree+0x280/0x2a8
Free of addr ffff00000beac001 by task kunit_try_catch/99

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c         | 23 ++++++++++++++++-------
 mm/kasan/report_generic.c |  3 ++-
 mm/kasan/report_tags.c    |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 39e8e5a80b82..df3602062bfd 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -175,17 +175,14 @@ static void end_report(unsigned long *flags, void *addr)
 
 static void print_error_description(struct kasan_report_info *info)
 {
-	if (info->type == KASAN_REPORT_INVALID_FREE) {
-		pr_err("BUG: KASAN: invalid-free in %pS\n", (void *)info->ip);
-		return;
-	}
+	pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
 
-	if (info->type == KASAN_REPORT_DOUBLE_FREE) {
-		pr_err("BUG: KASAN: double-free in %pS\n", (void *)info->ip);
+	if (info->type != KASAN_REPORT_ACCESS) {
+		pr_err("Free of addr %px by task %s/%d\n",
+			info->access_addr, current->comm, task_pid_nr(current));
 		return;
 	}
 
-	pr_err("BUG: KASAN: %s in %pS\n", info->bug_type, (void *)info->ip);
 	if (info->access_size)
 		pr_err("%s of size %zu at addr %px by task %s/%d\n",
 			info->is_write ? "Write" : "Read", info->access_size,
@@ -420,6 +417,18 @@ static void complete_report_info(struct kasan_report_info *info)
 	} else
 		info->cache = info->object = NULL;
 
+	switch (info->type) {
+	case KASAN_REPORT_INVALID_FREE:
+		info->bug_type = "invalid-free";
+		break;
+	case KASAN_REPORT_DOUBLE_FREE:
+		info->bug_type = "double-free";
+		break;
+	default:
+		/* bug_type filled in by kasan_complete_mode_report_info. */
+		break;
+	}
+
 	/* Fill in mode-specific report info fields. */
 	kasan_complete_mode_report_info(info);
 }
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 087c1d8c8145..043c94b04605 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -132,7 +132,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 	struct kasan_alloc_meta *alloc_meta;
 	struct kasan_free_meta *free_meta;
 
-	info->bug_type = get_bug_type(info);
+	if (!info->bug_type)
+		info->bug_type = get_bug_type(info);
 
 	if (!info->cache || !info->object)
 		return;
diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index d3510424d29b..ecede06ef374 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -37,7 +37,7 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 	bool is_free;
 	bool alloc_found = false, free_found = false;
 
-	if (!info->cache || !info->object) {
+	if ((!info->cache || !info->object) && !info->bug_type) {
 		info->bug_type = get_common_bug_type(info);
 		return;
 	}
-- 
2.25.1

