Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5959074CFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjGJIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjGJIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:14:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88242118;
        Mon, 10 Jul 2023 01:14:00 -0700 (PDT)
Date:   Mon, 10 Jul 2023 08:13:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1688976839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kbBlRYtDCHZkO48Xq/c2gicY7m6ZLit+ZxrtxvK05ak=;
        b=1IHDsNXN3CQage9sR5uyMDyyPha040tcxmrkF5k75Xr84nm0ersv3gkiav+rScPCpF0Ga1
        qI9XV08eg56YHuZ4YC/AlkPCjmQIDS6Z6PDhzrBILF0F4mR6wbYd81hdCQnDGbVHo0FpCY
        rYpuTPhlC13Z1rzDndUOgikXs1r2RKVw/VTUO3ybE0riSak7GqfjPpc6sQecm5G4+wbaE9
        8ntfXPlFunzTq2knXROQRJZq3J1M2Sv4DbWy3dE8T4t1wlk94WyNlvghS3ff2DR2BUDcI8
        KpgGLdJWKOyKfxnMSC0nuTv+xqu1A9vBprnIb/H3QVaT6AMBoJAPR2ObRn9dGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1688976839;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kbBlRYtDCHZkO48Xq/c2gicY7m6ZLit+ZxrtxvK05ak=;
        b=P5MI63ybiMlI45LbveuPELNkQDAbbpYHcGN/+sOeAq9Sr2KdAUNeKKKMjzT+nfSd2GZFJv
        pmRZNZcAfrWMNjCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cfi: Extend {JMP,CAKK}_NOSPEC comment
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168897683854.404.12338449674612649088.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0479a42d4c15bd554f54d89d12bf68218e3e70da
Gitweb:        https://git.kernel.org/tip/0479a42d4c15bd554f54d89d12bf68218e3e70da
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 22 Jun 2023 16:27:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 10 Jul 2023 09:52:23 +02:00

x86/cfi: Extend {JMP,CAKK}_NOSPEC comment

With the introduction of kCFI these helpers are no longer equivalent
to C indirect calls and should be used with care.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lkml.kernel.org/r/20230622144321.360957723%40infradead.org
---
 arch/x86/include/asm/nospec-branch.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 55388c9..1a65cf4 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -234,6 +234,10 @@
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
  * attack.
+ *
+ * NOTE: these do not take kCFI into account and are thus not comparable to C
+ * indirect calls, take care when using. The target of these should be an ENDBR
+ * instruction irrespective of kCFI.
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
