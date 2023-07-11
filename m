Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EA74E3BE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjGKBv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGKBvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:51:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7721CB6;
        Mon, 10 Jul 2023 18:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 116CC612C3;
        Tue, 11 Jul 2023 01:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C2BC433C8;
        Tue, 11 Jul 2023 01:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689040252;
        bh=G53cisJ1oPIw1E6Ka9hA5wzdkbxHiWemrgTO3t6vUgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSU9s+PAzFuCiDGKH9vHy8rem2/DY9PbpK/6bUGql+kKCiDqfW+Qbvl4+QVA0vuDt
         zh3kL+cUW8kav3KW/YbyKIx6/2cvcDlBkB014nG4SAoDUgM99tZDWezx0nRwhQjCUq
         sQsLQtANnT7abWt+M/+6xH4QuR+7FS7qb0GzSjZCgwujOCgui2s82sWeZ6qh2g7cvP
         SUZlHejcuVrPISlkg6UI2F4ZdO7eumJkNoKsoyafTY3fowcSAAbKTfFGnJzEV2NXIs
         kBNoTqWZvHYh6mC3x/uIuD9XwIiAs1XLa1t8iSYUnR5Rjd2tJOpZYgbdtDxmbReevl
         IDVTvz1xLJXEA==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 1/2] kprobes: Prohibit probing on CFI preamble symbol
Date:   Tue, 11 Jul 2023 10:50:47 +0900
Message-Id: <168904024679.116016.18089228029322008512.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168904023542.116016.10540228903086100726.stgit@devnote2>
References: <168904023542.116016.10540228903086100726.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Do not allow to probe on "__cfi_" or "__pfx_" started symbol, because those
are used for CFI and not executed. Probing it will break the CFI.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Check "__pfx_" prefix functions too.
  - Make the check unconditional.
---
 kernel/kprobes.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91cc..3da9726232ff 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1545,6 +1545,17 @@ static int check_ftrace_location(struct kprobe *p)
 	return 0;
 }
 
+static bool is_cfi_preamble_symbol(unsigned long addr)
+{
+	char symbuf[KSYM_NAME_LEN];
+
+	if (lookup_symbol_name(addr, symbuf))
+		return false;
+
+	return str_has_prefix("__cfi_", symbuf) ||
+		str_has_prefix("__pfx_", symbuf);
+}
+
 static int check_kprobe_address_safe(struct kprobe *p,
 				     struct module **probed_mod)
 {
@@ -1563,7 +1574,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
-	    find_bug((unsigned long)p->addr)) {
+	    find_bug((unsigned long)p->addr) ||
+	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}

