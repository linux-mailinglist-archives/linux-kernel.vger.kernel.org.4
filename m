Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00AD6A03D4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjBWIcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjBWIcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:32:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0604D621;
        Thu, 23 Feb 2023 00:32:08 -0800 (PST)
Date:   Thu, 23 Feb 2023 08:32:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677141126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsWzHTULbdcIhpxvYZtfDkmwAxxceRWqYM8+zpCe3qg=;
        b=pkJEGb0B3vljXtCyjamiPz8hSXPzKAJ7dVFaHDJ1d6jurvZvheRsVyV1Owg6wY5xVDliQ0
        NeHZ1JdvVZTv5r2pasGaVPqF1DH4vWbztZ1rvgjA37/3uzbyuwvea7y+Y0MNBvUVKkjOMc
        QAJa8+MrzLc1H0GE7r5gAxzrzkBVLO2sotArJj5L/XZUnCBXpBjIxMLzMA6hQ3s4vQ2xUe
        0a4grMDoBRJHiZ0b64FedB9crArB79BWYnCbzQ2se+yAbXbuuC9kke2BrJ8Z8QNt8tLiHX
        Vwv9aWmbFnfO8HGU319SwlYLuK7bs+aqEO1lQKzVRUvXVMMpE3FbLNKMOGRpFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677141126;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XsWzHTULbdcIhpxvYZtfDkmwAxxceRWqYM8+zpCe3qg=;
        b=kmFbZeWhvpjcg4bcXmMM0jX5CW3F8JT9O6jx3Gx59ANOds7WAvlgogN/yk/ACRIrVsF6Yu
        WGvpjxK5+Nx2i3Cg==
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
Message-ID: <167714112587.5837.1928053268533397694.tip-bot2@tip-bot2>
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

Commit-ID:     00c8f01c4e84637c3db76f368b8687cb61f4dd9d
Gitweb:        https://git.kernel.org/tip/00c8f01c4e84637c3db76f368b8687cb61f4dd9d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 16 Feb 2023 12:34:41 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Feb 2023 09:21:50 +01:00

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
