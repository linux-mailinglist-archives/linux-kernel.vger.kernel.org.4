Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3564F260
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiLPUag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiLPUad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:30:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300723EAC7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:30:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so3396416plr.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhdvcMuCK8cVd24YqXpIq4X0YsKEOwsG/ikZkxQ8Me8=;
        b=Td09ZtE0IX5Fvm5IdQS1h9XVZyhi2weGB+7yVfa+EFDjgIFxxqIc4OAqCKlJ5ruqyX
         XNdCAR9FhchU3lupE56ZkZu2lHS9qCrUOAgQ2mmpo7ZbPwgKW01wGuQe0mVi6I3ha7Rt
         XU1UFK91y4FzgunLMUSG7yQB9W+9rQCHddMg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhdvcMuCK8cVd24YqXpIq4X0YsKEOwsG/ikZkxQ8Me8=;
        b=yMyG/1GmKCquZobHfhbqJ58IQFpsfVF2eB28ndi/AQx/apDKixnEeguY81DO4Wlran
         3tok5/MCYBiIQ/2WMlrjf2CtS43nKDpnRWKrBfsNO7bo2zAAyHcpMeIUcjXFpGNJsrP0
         X5Hs2uHMt8zhEXqSa3KDDBWKiyoM49yBy0w/tEHe+zPb0cswO5uCGMM3hH495/2RYlko
         ZLS3D7V0o//9607tQ76VIKg8BwTq/Zog+tUlUGumW7IdVLxguVkMR9t7Ki5fr8Moeo1t
         eWJy2VrZ2TJif5HIZ02SyyBKVBerPLPczj8IhalnFwD4OruBZ1WL8YSGd1nct/jhOfY8
         7ftA==
X-Gm-Message-State: ANoB5plGVHbZ5LsJmL36M2llwBExDaYMGC56MNmAiOe5w3606KujcwBq
        1OKatbiif7q/ViIN5nf1aYv0PQ==
X-Google-Smtp-Source: AA0mqf73RQLdFg1DKa5OzEUZTRGuJf67QUFJ16BcAJmMnR4C55b3SGJzfoyJBn+RJFcLiVroZRRIhw==
X-Received: by 2002:a17:90a:4f4b:b0:219:15b0:3da3 with SMTP id w11-20020a17090a4f4b00b0021915b03da3mr33713864pjl.37.1671222631618;
        Fri, 16 Dec 2022 12:30:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090a348f00b0021952b5e9bcsm5170108pjb.53.2022.12.16.12.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:30:31 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        tangmeng <tangmeng@uniontech.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Stafford Horne <shorne@gmail.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] exit: Use READ_ONCE() for all oops/warn limit reads
Date:   Fri, 16 Dec 2022 12:30:28 -0800
Message-Id: <20221216203024.never.640-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2639; h=from:subject:message-id; bh=QFDv42gSw8RrL/kT/bLCpkDTyQ5e1mjGxtt244QW9V0=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjnNVkYwcCuX3+lRp4U1y4bVoF7qP2EdUuq4JMMDD2 0AFmIzyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY5zVZAAKCRCJcvTf3G3AJlNcD/ 0QvyfFKYGmpjzAId3QIjrakY8NxwFTZRZWL6SjPD22tFgR90XCdBibLo6mbOWrszOVuhsYlDrc2/Tn jxZqKMuAVbU8ybDSpXio897z7ooUsCJe6RX3IKjAJ0M0ToVvnsY9o5k1VleYRZJH0FsIN+LQrda8Yh qClm/+UwCGCJV+mYCiLGqB9F/Bs2oLxUgdfOk0PBpNAewEVz46tTlLj/me8beXXtABSMY595LjRDVr zgUb5LaPaYYIGwksz33bGSsHRI+lyI05RWuG+DGLz5xHfTQtlz/zONesrX0Q8pAiqkVkoSz1qjXJEF h85OXdmGjwEQxQG+JXTySbrhnbsRg3kOTjHuiJKs93On3G2M9KFSC2vAWhENdi/zPTnGR8iyNg8UrU NmHvOIeTKSkRGu2Sr6zkhwWhAa76SqO+YGU4AtuFA7UGK2Xwuaq3YmQTvZENJyBojoRoley2Oc4n/4 Phu3zm03tPfE7mTAfowjhuKKvhEBOF54gnyP3sIrZ0dLcQ9aP1sbb2KpDaPA4pWWEQAah2OCjELhh6 ke4JhhJ/QoXAZ9w+dpjLUgniEDtnZSPvfMnDhWAn1RBfj06+om5o4RcdrjiOqcwxnyVQkDhzVk2vBq 8f2bsA4MpSbk+OhcluHRTvpxuVCD5apQLNDcCcoNYoIR5HI8bTiOUt2OXrQA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a temporary variable to take full advantage of READ_ONCE() behavior.
Without this, the report (and even the test) might be out of sync with
the initial test.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/Y5x7GXeluFmZ8E0E@hirez.programming.kicks-ass.net
Fixes: 9fc9e278a5c0 ("panic: Introduce warn_limit")
Fixes: d4ccd54d28d3 ("exit: Put an upper limit on how often we can oops")
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: tangmeng <tangmeng@uniontech.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/exit.c  | 6 ++++--
 kernel/panic.c | 7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index deffb8e4b1b2..15dc2ec80c46 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -931,6 +931,7 @@ void __noreturn make_task_dead(int signr)
 	 * Then do everything else.
 	 */
 	struct task_struct *tsk = current;
+	unsigned int limit;
 
 	if (unlikely(in_interrupt()))
 		panic("Aiee, killing interrupt handler!");
@@ -954,8 +955,9 @@ void __noreturn make_task_dead(int signr)
 	 * To make sure this can't happen, place an upper bound on how often the
 	 * kernel may oops without panic().
 	 */
-	if (atomic_inc_return(&oops_count) >= READ_ONCE(oops_limit) && oops_limit)
-		panic("Oopsed too often (kernel.oops_limit is %d)", oops_limit);
+	limit = READ_ONCE(oops_limit);
+	if (atomic_inc_return(&oops_count) >= limit && limit)
+		panic("Oopsed too often (kernel.oops_limit is %d)", limit);
 
 	/*
 	 * We're taking recursive faults here in make_task_dead. Safest is to just
diff --git a/kernel/panic.c b/kernel/panic.c
index 54deb743b2d5..7834c9854e02 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -231,12 +231,15 @@ static void panic_print_sys_info(bool console_flush)
 
 void check_panic_on_warn(const char *origin)
 {
+	unsigned int limit;
+
 	if (panic_on_warn)
 		panic("%s: panic_on_warn set ...\n", origin);
 
-	if (atomic_inc_return(&warn_count) >= READ_ONCE(warn_limit) && warn_limit)
+	limit = READ_ONCE(warn_limit);
+	if (atomic_inc_return(&warn_count) >= limit && limit)
 		panic("%s: system warned too often (kernel.warn_limit is %d)",
-		      origin, warn_limit);
+		      origin, limit);
 }
 
 /**
-- 
2.34.1

