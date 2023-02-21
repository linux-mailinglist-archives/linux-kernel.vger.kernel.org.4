Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508569E3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjBUPpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjBUPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:45:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1A02BF36;
        Tue, 21 Feb 2023 07:44:57 -0800 (PST)
Date:   Tue, 21 Feb 2023 15:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676994295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvVF51qU71MZBHDXPIhqzIRdH5CtwkzAppuwxXgMEG0=;
        b=W5Esqn58uJKK4ZgwRFDEB3sejlKn+obIK5dHNdI3v+zOW17jhHpR2C2cK459aGHpmx5zyP
        kgpcdNUIw1WFL0FrW5Nymmq0tKvEigmLRjiFFaaPaaHYk1FexkZ/1786aTAcU6VNlKbGb0
        8FWWu7M84QbETvjIVjq4bftxlU1G4wIqyjNuT/qwy1IiuxJwqLtDO705z/Wn49nAGGbIyx
        oDUy8kCnlmw3eZWvDbSyYmcnPfWOigr62nNAraBtb5E9T5C/x3EKsdhnFY3W+zhzYz8x4W
        N234iotY6ui5janPJBJj1hnm5AKcFQA+mkCNxOxw+4HTYcCGi02HYPYl/1s3iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676994295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZvVF51qU71MZBHDXPIhqzIRdH5CtwkzAppuwxXgMEG0=;
        b=V2rPIKTmXgp5L1+9yv8zvNhdw0S0EAzm031cmv7f4sjluPHbkmFs5UpfylCs2efszC2nBE
        deWOfwGDCTVz9QCA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix ORC 'signal' propagation
Cc:     kernel test robot <oliver.sang@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <97eef9db60cd86d376a9a40d49d77bb67a8f6526.1676579666.git.jpoimboe@kernel.org>
References: <97eef9db60cd86d376a9a40d49d77bb67a8f6526.1676579666.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <167699429466.387.9214673997610395558.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     801d48faf6bbf985d14aa1027889f3a3fe4206f1
Gitweb:        https://git.kernel.org/tip/801d48faf6bbf985d14aa1027889f3a3fe4206f1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 16 Feb 2023 12:34:41 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 21 Feb 2023 16:40:14 +01:00

objtool: Fix ORC 'signal' propagation

There have been some recently reported ORC unwinder warnings like:

  WARNING: can't access registers at entry_SYSCALL_64_after_hwframe+0x63/0xcd
  WARNING: stack going in the wrong direction? at __sys_setsockopt+0x2c6/0x5b0 net/socket.c:2271

And a KASAN warning:

  BUG: KASAN: stack-out-of-bounds in unwind_next_frame (arch/x86/include/asm/ptrace.h:136 arch/x86/kernel/unwind_orc.c:455)

It turns out the 'signal' bit isn't getting propagated from the unwind
hints to the ORC entries, making the unwinder confused at times.

Fixes: ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC metadata")
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/97eef9db60cd86d376a9a40d49d77bb67a8f6526.1676579666.git.jpoimboe@kernel.org
---
 tools/objtool/check.c               | 1 +
 tools/objtool/include/objtool/cfi.h | 1 +
 tools/objtool/orc_gen.c             | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b0b467d..5822de3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2330,6 +2330,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		cfi.cfa.offset = bswap_if_needed(file->elf, hint->sp_offset);
 		cfi.type = hint->type;
+		cfi.signal = hint->signal;
 		cfi.end = hint->end;
 
 		insn->cfi = cfi_hash_find_or_add(&cfi);
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
index f11d1ac..b1258e7 100644
--- a/tools/objtool/include/objtool/cfi.h
+++ b/tools/objtool/include/objtool/cfi.h
@@ -34,6 +34,7 @@ struct cfi_state {
 	unsigned char type;
 	bool bp_scratch;
 	bool drap;
+	bool signal;
 	bool end;
 };
 
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 1f22b7e..57a4527 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -27,6 +27,7 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
 	}
 
 	orc->end = cfi->end;
+	orc->signal = cfi->signal;
 
 	if (cfi->cfa.base == CFI_UNDEFINED) {
 		orc->sp_reg = ORC_REG_UNDEFINED;
