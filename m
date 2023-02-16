Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354C699DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBPUgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBPUgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:36:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79446D505
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 12:36:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15C8860AB9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0F8C4339C;
        Thu, 16 Feb 2023 20:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676579764;
        bh=DXeKAcd3eTMKp1vG5AHL0YvvFqGMHFFeFHc22BJB0m4=;
        h=From:To:Cc:Subject:Date:From;
        b=GaPV64A7YUxU8YcWSm6XKvwee7LQS+D1voAY1SE7i3xwPM6V2E0hhj7fDPV+iliq3
         cY5S6c5SQ6Obm/rfzXHAXwVZhIqBULvUv1i2E+Y2JAwwabcjPhv73FMW7f9MMWTpas
         tSTfL/iiYPvhb72zfcLnxTjvltKrNKg9d4GNLVthuDLNiZCE2ZmDYgqcDHFSftTEhE
         jRBcxFw2uW6CvbZEe39ECU8WL6aX+ttgyTG+aSSVENhemAdeKCNi6+Sumj1KHNAwM9
         QYBQOk4D3Bye7q26+Pok6z4Wf+3AErDILC4cqnhS+9Vn8uJ7y/bcESZLn60OV0eesx
         gmJIIWH0vm7Ng==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [PATCH] objtool: Fix ORC 'signal' propagation
Date:   Thu, 16 Feb 2023 12:34:41 -0800
Message-Id: <97eef9db60cd86d376a9a40d49d77bb67a8f6526.1676579666.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There have been some recently reported ORC unwinder warnings like:

  WARNING: can't access registers at entry_SYSCALL_64_after_hwframe+0x63/0xcd
  WARNING: stack going in the wrong direction? at __sys_setsockopt+0x2c6/0x5b0 net/socket.c:2271

And a KASAN warning:

  BUG: KASAN: stack-out-of-bounds in unwind_next_frame (arch/x86/include/asm/ptrace.h:136 arch/x86/kernel/unwind_orc.c:455)

It turns out the 'signal' bit isn't getting propagated from the unwind
hints to the ORC entries, making the unwinder confused at times.

Fixes: ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC metadata")
Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202302161616.85f13863-oliver.sang@intel.com
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lkml.kernel.org/lkml/CACT4Y+YzZb2vscjBLiJ-p-ghbu77o851gbESfE=nZebXqfgE4g@mail.gmail.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 1 +
 tools/objtool/include/objtool/cfi.h | 1 +
 tools/objtool/orc_gen.c             | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 7c40bd51c75a..8b242634bc51 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2266,6 +2266,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		cfi.cfa.offset = bswap_if_needed(file->elf, hint->sp_offset);
 		cfi.type = hint->type;
+		cfi.signal = hint->signal;
 		cfi.end = hint->end;
 
 		insn->cfi = cfi_hash_find_or_add(&cfi);
diff --git a/tools/objtool/include/objtool/cfi.h b/tools/objtool/include/objtool/cfi.h
index f11d1ac1dadf..b1258e79a1b7 100644
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
index 1f22b7ebae58..57a4527d5988 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -27,6 +27,7 @@ static int init_orc_entry(struct orc_entry *orc, struct cfi_state *cfi,
 	}
 
 	orc->end = cfi->end;
+	orc->signal = cfi->signal;
 
 	if (cfi->cfa.base == CFI_UNDEFINED) {
 		orc->sp_reg = ORC_REG_UNDEFINED;
-- 
2.39.1

