Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBAE721ED4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFEHDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjFEHCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:02:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 508D4F7;
        Mon,  5 Jun 2023 00:02:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A08F1655;
        Mon,  5 Jun 2023 00:02:56 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C21E3F793;
        Mon,  5 Jun 2023 00:02:09 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, paulmck@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, sstabellini@kernel.org, will@kernel.org
Subject: [PATCH v2 15/27] locking/atomic: scripts: remove leftover "${mult}"
Date:   Mon,  5 Jun 2023 08:01:12 +0100
Message-Id: <20230605070124.3741859-16-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605070124.3741859-1-mark.rutland@arm.com>
References: <20230605070124.3741859-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We removed cmpxchg_double() and variants in commit:

  b4cf83b2d1da40b2 ("arch: Remove cmpxchg_double")

Which removed the need for "${mult}" in the instrumentation logic.
Unfortunately we missed an instance of "${mult}".

There is no change to the generated header.
There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 scripts/atomic/gen-atomic-instrumented.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index a2ef735be8ca9..68557bfbbdc5e 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -118,7 +118,7 @@ cat <<EOF
 EOF
 [ -n "$kcsan_barrier" ] && printf "\t${kcsan_barrier}; \\\\\n"
 cat <<EOF
-	instrument_atomic_read_write(__ai_ptr, ${mult}sizeof(*__ai_ptr)); \\
+	instrument_atomic_read_write(__ai_ptr, sizeof(*__ai_ptr)); \\
 	arch_${xchg}${order}(__ai_ptr, __VA_ARGS__); \\
 })
 EOF
-- 
2.30.2

