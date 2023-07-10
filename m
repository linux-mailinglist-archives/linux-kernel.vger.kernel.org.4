Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9227B74D50A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 14:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGJMOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 08:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjGJMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 08:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B520D118;
        Mon, 10 Jul 2023 05:14:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD6260FD6;
        Mon, 10 Jul 2023 12:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD20C433C7;
        Mon, 10 Jul 2023 12:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688991269;
        bh=/Q11alT8tbZRlfgyDDMM5QaswwfEKymoi7mANE+IolU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBoK6rpnc6ooaLGvz/UPIrjCuWlziMTtlLYOn/o+xtxH7S6khirTDK2EfkX1Iw6TS
         /z+f6x1g8CfW5ke4WIyvljbM9SVmTXEWKp9VnVm54zNZG92Zl9FmWi1K2VNUs1Pj+T
         /NSMYsS3CWYPeMezLNMQ4DvwhBCyxzzxj4EhjnnrgxaEObXwE87lo4lK+vQ/uXZwJr
         dXHTvksru2ImAsvrhYVHeYrYsScbel2TVzCXFdXpPIAH742h3VRB4ttuJJlThQYia+
         YlP8//zNN9PJO0cQiRcryLAuUB6HNbL/z0uOQ2Gfe6bE3h9QkQF3Nhx5/DabpCatqT
         +3+hx94BKLHUg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [RFC PATCH 1/2] kprobes: Prohibit probing on CFI preamble symbol
Date:   Mon, 10 Jul 2023 21:14:24 +0900
Message-Id: <168899126450.80889.16200438320430187434.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <168899125356.80889.17967397360941194229.stgit@devnote2>
References: <168899125356.80889.17967397360941194229.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Do not allow to probe on "__cfi_" started symbol, because it includes
a typeid value in the code for CFI. Probing it will break the typeid
checking.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/kprobes.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 00e177de91cc..ce2e460c1f79 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1545,6 +1545,20 @@ static int check_ftrace_location(struct kprobe *p)
 	return 0;
 }
 
+#ifdef CONFIG_CFI_CLANG
+static bool is_cfi_preamble_symbol(unsigned long addr)
+{
+	char symbuf[KSYM_NAME_LEN];
+
+	if (lookup_symbol_name(addr, symbuf))
+		return false;
+
+	return str_has_prefix("__cfi_", symbuf);
+}
+#else
+#define is_cfi_preamble_symbol(addr)	(0)
+#endif
+
 static int check_kprobe_address_safe(struct kprobe *p,
 				     struct module **probed_mod)
 {
@@ -1563,7 +1577,8 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    within_kprobe_blacklist((unsigned long) p->addr) ||
 	    jump_label_text_reserved(p->addr, p->addr) ||
 	    static_call_text_reserved(p->addr, p->addr) ||
-	    find_bug((unsigned long)p->addr)) {
+	    find_bug((unsigned long)p->addr) ||
+	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
 		ret = -EINVAL;
 		goto out;
 	}

