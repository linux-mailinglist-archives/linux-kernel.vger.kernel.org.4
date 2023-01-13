Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D347866973D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbjAMMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbjAMMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:32:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555F0517D0;
        Fri, 13 Jan 2023 04:31:10 -0800 (PST)
Date:   Fri, 13 Jan 2023 12:31:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EL3mPETbPdvFA800DQi92+7HmKGkuhOgYQBznH6oeWc=;
        b=i8Pf0eL7xUbYjvuLMZ4xceZpuATo3esqn8qPG9wTAA1sPhDIWngwY1QAB48E0ET4GLKFIA
        qKKdheJ/T9KW4q8w5SR4ZKb1vx5jDCmBu/0/KRrbxpTgDJN5Gf7vCPaQd3QU8Y82ECvyRx
        JNRnuCE3FNy4b3uMvmc9pCUeX5SYS1wo3Uyaa1oNqeBybMcfsCh00/bMtamgNH9YYoCV4I
        Q3G6Gzb6xFr6VNemzFSxWxC3cGeTqck02FgAC/tW4oOO6+bCG9REHZQK3u83xbKrB2i1WP
        HvuiGv+L2oDY+LGO0NhCkz7V4C2/8pT07sbnWAgIz8JEn3bZg+guRzino8jLvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673613066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EL3mPETbPdvFA800DQi92+7HmKGkuhOgYQBznH6oeWc=;
        b=8+Q8mk1aLu0aw/LeDJn5DgeyF4xmlNXMs+GoZGqFqlUfpE7vpJKP2j7ROtRtOm1P7Mmto+
        jUymaHlJDji9aWCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] ubsan: Fix objtool UACCESS warns
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230112195541.906007455@infradead.org>
References: <20230112195541.906007455@infradead.org>
MIME-Version: 1.0
Message-ID: <167361306657.4906.17949853863028198570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f18b0d7ee815abb33eb1cc540fdde64fbb922d1a
Gitweb:        https://git.kernel.org/tip/f18b0d7ee815abb33eb1cc540fdde64fbb922d1a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 12 Jan 2023 20:43:56 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jan 2023 11:48:17 +01:00

ubsan: Fix objtool UACCESS warns

clang-14 allyesconfig gives:

  vmlinux.o: warning: objtool: emulator_cmpxchg_emulated+0x705: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
  vmlinux.o: warning: objtool: paging64_update_accessed_dirty_bits+0x39e: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
  vmlinux.o: warning: objtool: paging32_update_accessed_dirty_bits+0x390: call to __ubsan_handle_load_invalid_value() with UACCESS enabled
  vmlinux.o: warning: objtool: ept_update_accessed_dirty_bits+0x43f: call to __ubsan_handle_load_invalid_value() with UACCESS enabled

Add the required eflags save/restore and whitelist the thing.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20230112195541.906007455@infradead.org
---
 lib/ubsan.c           | 5 ++++-
 tools/objtool/check.c | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index 60c7099..4d39e0b 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -339,9 +339,10 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
 {
 	struct invalid_value_data *data = _data;
 	char val_str[VALUE_LENGTH];
+	unsigned long ua_flags = user_access_save();
 
 	if (suppress_report(&data->location))
-		return;
+		goto out;
 
 	ubsan_prologue(&data->location, "invalid-load");
 
@@ -351,6 +352,8 @@ void __ubsan_handle_load_invalid_value(void *_data, void *val)
 		val_str, data->type->type_name);
 
 	ubsan_epilogue();
+out:
+	user_access_restore(ua_flags);
 }
 EXPORT_SYMBOL(__ubsan_handle_load_invalid_value);
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 64954aa..9767bab 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1216,6 +1216,7 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_type_mismatch",
 	"__ubsan_handle_type_mismatch_v1",
 	"__ubsan_handle_shift_out_of_bounds",
+	"__ubsan_handle_load_invalid_value",
 	/* misc */
 	"csum_partial_copy_generic",
 	"copy_mc_fragile",
