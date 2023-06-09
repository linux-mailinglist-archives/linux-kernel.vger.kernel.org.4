Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE57291BA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbjFIHto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbjFIHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D33930D0;
        Fri,  9 Jun 2023 00:47:44 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4vOWr9voQDkbobHqEG1up9eGMDw9BioboJbbB7D1RQ=;
        b=hdUQjlaeNkTABcVJ4aGWE9aTYB8pFsFg2G+P38AvQ9/X4hi8LPfUHSiUljoJgW9PqG4VUC
        sDLkmbTLa64rZXASrSkz85ES4N4pMwPSDsrKqysDzDeJXcwz8Dbp4bSFD5lpXbG0tnY7kg
        0mNt6n1NEneloZR/JcYI6TgUEK2IfW608GHAJtg0Mf7S9Pl0fr+TCTsFluY84iqk5HTtx/
        jM32U84uozh2Vaqy1jp+qJc65NKwvF1wnBa1jvJjN1kCVOkC4Ds7ZmhVQPpzwi/FeWzryq
        GK4kIJGDKYEf2/y75uuHfTGuZOIQMR2fGyFvCCxzOMRKFJ0i+x/Hu8PjvdoFmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4vOWr9voQDkbobHqEG1up9eGMDw9BioboJbbB7D1RQ=;
        b=Y89Jo8RmvRB2zfmEMkrwPOw17uW3wZyfkuFwDOEe4lk598ja9eC2V9FcRVs6MmXEKiNQhl
        derpQzREMx+sAcBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] lkdtm: Avoid objtool/ibt warning
Cc:     kernel test robot <lkp@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y3JdgbXRV0MNZ+9h@hirez.programming.kicks-ass.net>
References: <Y3JdgbXRV0MNZ+9h@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <168629686249.404.5579713530746693171.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4a03aa34432abe0703abf232f31fc5e2ed8256f6
Gitweb:        https://git.kernel.org/tip/4a03aa34432abe0703abf232f31fc5e2ed8256f6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 14 Nov 2022 16:23:45 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 09:27:11 -07:00

lkdtm: Avoid objtool/ibt warning

For certain configs objtool will complain like:

  vmlinux.o: warning: objtool: lkdtm_UNSET_SMEP+0x1c3: relocation to !ENDBR: native_write_cr4+0x41

What happens is that GCC optimizes the loop:

        insn = (unsigned char *)native_write_cr4;
        for (i = 0; i < MOV_CR4_DEPTH; i++)

to read something like:

        for (insn = (unsigned char *)native_write_cr4;
             insn < (unsigned char *)native_write_cr4 + MOV_CR4_DEPTH;
             insn++)

Which then obviously generates the text reference
native_write_cr4+041. Since none of this is a fast path, simply
confuse GCC enough to inhibit this optimization.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/Y3JdgbXRV0MNZ+9h@hirez.programming.kicks-ass.net
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/misc/lkdtm/bugs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 48821f4..92110cb 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -487,6 +487,7 @@ static void lkdtm_UNSET_SMEP(void)
 	 * the cr4 writing instruction.
 	 */
 	insn = (unsigned char *)native_write_cr4;
+	OPTIMIZER_HIDE_VAR(insn);
 	for (i = 0; i < MOV_CR4_DEPTH; i++) {
 		/* mov %rdi, %cr4 */
 		if (insn[i] == 0x0f && insn[i+1] == 0x22 && insn[i+2] == 0xe7)
