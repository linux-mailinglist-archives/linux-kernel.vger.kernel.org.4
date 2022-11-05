Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501B661D978
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiKEKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKEKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:36:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7442AE38;
        Sat,  5 Nov 2022 03:36:28 -0700 (PDT)
Date:   Sat, 05 Nov 2022 10:36:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667644587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J2oLfthfo/dLH2t7ocF1ovI/aIMzujArDGnbhIkLGtI=;
        b=peJSQ+NC2CDrgndPuGnoUk1s65BsCDKrP2jzXt3/ugasfpE8i+2uvdv4eSXKBqs0qvVY0q
        wVMsBBZuHkxmZU0fcuD6vCcdPBSU+KRU1ozBFKZZL7OVCQ+olKp0Yke/7mIEXEtTheH9ek
        kieiok7JzRmnnZknuXL55/E3WFWs8wcEdcNiFdUhkz/Yt6MmtKtH1dp0ESJyS5Jc/pw5Q1
        GMfPTQ50aBKPe8HOg4KPftmIV8SgDfrx143tlqDGFE+fqrVfdVxkbN8HqeB8Wzo8BKtnmp
        +tvZ630gbStUPyjIZuZNCS/2RyiUKB+fqoGHNHf1xSuUZ4mkZ9ykEnXo6GLqFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667644587;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J2oLfthfo/dLH2t7ocF1ovI/aIMzujArDGnbhIkLGtI=;
        b=0fIKfg18i8yDzU4XQT5gppgjGkCcA5+BlvEA52O4L1QCiV9Fh7FBgsTZwj1ef6UVaQjhmu
        nDWtOoNbubQpwXBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86,pm: Force out-of-line memcpy()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166764458578.4906.12379655891294297691.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     b32fd8a60f5d855758208c2b5b49cba8087f03c4
Gitweb:        https://git.kernel.org/tip/b32fd8a60f5d855758208c2b5b49cba8087f03c4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 03 Nov 2022 21:17:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 05 Nov 2022 11:28:02 +01:00

x86,pm: Force out-of-line memcpy()

GCC fancies inlining memcpy(), and because it cannot prove the
destination is page-aligned (it is) it ends up generating atrocious
code like:

 19e:   48 8b 15 00 00 00 00    mov    0x0(%rip),%rdx        # 1a5 <relocate_restore_code+0x25> 1a1: R_X86_64_PC32      core_restore_code-0x4
 1a5:   48 8d 78 08             lea    0x8(%rax),%rdi
 1a9:   48 89 c1                mov    %rax,%rcx
 1ac:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi        1af: R_X86_64_32S       core_restore_code
 1b3:   48 83 e7 f8             and    $0xfffffffffffffff8,%rdi
 1b7:   48 29 f9                sub    %rdi,%rcx
 1ba:   48 89 10                mov    %rdx,(%rax)
 1bd:   48 8b 15 00 00 00 00    mov    0x0(%rip),%rdx        # 1c4 <relocate_restore_code+0x44> 1c0: R_X86_64_PC32      core_restore_code+0xff4
 1c4:   48 29 ce                sub    %rcx,%rsi
 1c7:   81 c1 00 10 00 00       add    $0x1000,%ecx
 1cd:   48 89 90 f8 0f 00 00    mov    %rdx,0xff8(%rax)
 1d4:   c1 e9 03                shr    $0x3,%ecx
 1d7:   f3 48 a5                rep movsq %ds:(%rsi),%es:(%rdi)

Notably the alignment code generates a text reference to
code_restore_code+0xff8, for which objtool raises the objection:

  vmlinux.o: warning: objtool: relocate_restore_code+0x3d: relocation to !ENDBR: next_arg+0x18

Applying some __assume_aligned(PAGE_SIZE) improve code-gen to:

 19e:   48 89 c7                mov    %rax,%rdi
 1a1:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi        1a4: R_X86_64_32S       core_restore_code
 1a8:   b9 00 02 00 00          mov    $0x200,%ecx
 1ad:   f3 48 a5                rep movsq %ds:(%rsi),%es:(%rdi)

And resolve the problem, however, none of this is important code and
a much simpler solution still is to force a memcpy() call:

 1a1:   ba 00 10 00 00          mov    $0x1000,%edx
 1a6:   48 c7 c6 00 00 00 00    mov    $0x0,%rsi        1a9: R_X86_64_32S       core_restore_code
 1ad:   e8 00 00 00 00          call   1b2 <relocate_restore_code+0x32> 1ae: R_X86_64_PLT32     __memcpy-0x4

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index e94e005..6f955eb 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -159,7 +159,7 @@ int relocate_restore_code(void)
 	if (!relocated_restore_code)
 		return -ENOMEM;
 
-	memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
+	__memcpy((void *)relocated_restore_code, core_restore_code, PAGE_SIZE);
 
 	/* Make the page containing the relocated code executable */
 	pgd = (pgd_t *)__va(read_cr3_pa()) +
