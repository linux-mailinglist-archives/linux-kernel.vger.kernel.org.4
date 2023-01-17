Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865D566E1E0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAQPQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 10:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjAQPQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:16:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64B7139CC1;
        Tue, 17 Jan 2023 07:16:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C9B11FB;
        Tue, 17 Jan 2023 07:17:34 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31C783F67D;
        Tue, 17 Jan 2023 07:16:51 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        =?UTF-8?q?=C3=89meric=20Maschino?= <emeric.maschino@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Morse <james.morse@arm.com>
Subject: [PATCH] ia64: Fix build error due to switch case label appearing next to declaration
Date:   Tue, 17 Jan 2023 15:16:32 +0000
Message-Id: <20230117151632.393836-1-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to
report ITC frequency"), gcc 10.1.0 fails to build ia64 with the gnomic:
| ../arch/ia64/kernel/sys_ia64.c: In function 'ia64_clock_getres':
| ../arch/ia64/kernel/sys_ia64.c:189:3: error: a label can only be part of a statement and a declaration is not a statement
|   189 |   s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);

This line appears immediately after a case label in a switch.

Move the declarations out of the case, to the top of the function.

Fixes: aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to report ITC frequency")
Signed-off-by: James Morse <james.morse@arm.com>
---
Found when build testing another series.
I've only build tested this.

 arch/ia64/kernel/sys_ia64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index f6a502e8f02c..6e948d015332 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -170,6 +170,9 @@ ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, u
 asmlinkage long
 ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *tp)
 {
+	struct timespec64 rtn_tp;
+	s64 tick_ns;
+
 	/*
 	 * ia64's clock_gettime() syscall is implemented as a vdso call
 	 * fsys_clock_gettime(). Currently it handles only
@@ -185,8 +188,8 @@ ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *
 	switch (which_clock) {
 	case CLOCK_REALTIME:
 	case CLOCK_MONOTONIC:
-		s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
-		struct timespec64 rtn_tp = ns_to_timespec64(tick_ns);
+		tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
+		rtn_tp = ns_to_timespec64(tick_ns);
 		return put_timespec64(&rtn_tp, tp);
 	}
 
-- 
2.30.2

