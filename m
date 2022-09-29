Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089BB5EF73A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbiI2OMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiI2OL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:11:57 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [IPv6:2607:5300:203:5aae::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F6916F9CB;
        Thu, 29 Sep 2022 07:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1664460712;
        bh=+v2ZYO1lkgc/LYM8PWe013yC+/t8ZcJu73Y8uuch+Ao=;
        h=From:To:Cc:Subject:Date:From;
        b=QBykbJuapgDBnBDizKGTSHZjYL5TjwaoAhgwwiuhieMfnEfedrciQn2X7WO3v+Egp
         xssoA17yPqRiMCK0tyAnNCrDhQqwW+SKMWfKgQjj/r1gqDzV8gCLoKnS8NCHQOZsou
         uTCWaUILZRIfxZ2qleJE6YtT/qHhlUIRpKqKbgm57EgGKPGYKdhBmt4Q/xbMWcc1GK
         TQCud6i5seza0IR9I4CUcX9//evSf5QDGxNJEJn7TkTW36toNm4ThroicySF3+v4rA
         dmLudWCZcqwRRz7PeoqX9lPn5TqNtBrycAsn2ED3cfFh7nsBRZZrQ9ePeux17bUowr
         vVaWhg2tuqHNg==
Received: from thinkos.internal.efficios.com (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4MdZzq5tDSzP99;
        Thu, 29 Sep 2022 10:11:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH] rseq: Use pr_warn_once() when deprecated/unknown ABI flags are encountered
Date:   Thu, 29 Sep 2022 10:12:27 -0400
Message-Id: <20220929141227.205343-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These commits use WARN_ON_ONCE() and kill the offending processes when
deprecated and unknown flags are encountered:

commit c17a6ff93213 ("rseq: Kill process when unknown flags are encountered in ABI structures")
commit 0190e4198e47 ("rseq: Deprecate RSEQ_CS_FLAG_NO_RESTART_ON_* flags")

The WARN_ON_ONCE() triggered by userspace input prevents use of
Syzkaller to fuzz the rseq system call.

Replace this WARN_ON_ONCE() by pr_warn_once() messages which contain
actually useful information.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/rseq.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index bda8175f8f99..d38ab944105d 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -171,12 +171,27 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	return 0;
 }
 
+static bool rseq_warn_flags(const char *str, u32 flags)
+{
+	u32 test_flags;
+
+	if (!flags)
+		return false;
+	test_flags = flags & RSEQ_CS_NO_RESTART_FLAGS;
+	if (test_flags)
+		pr_warn_once("Deprecated flags (%u) in %s ABI structure", test_flags, str);
+	test_flags = flags & ~RSEQ_CS_NO_RESTART_FLAGS;
+	if (test_flags)
+		pr_warn_once("Unknown flags (%u) in %s ABI structure", test_flags, str);
+	return true;
+}
+
 static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 {
 	u32 flags, event_mask;
 	int ret;
 
-	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
+	if (rseq_warn_flags("rseq_cs", cs_flags))
 		return -EINVAL;
 
 	/* Get thread flags. */
@@ -184,7 +199,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	if (ret)
 		return ret;
 
-	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
+	if (rseq_warn_flags("rseq", flags))
 		return -EINVAL;
 
 	/*
-- 
2.30.2

