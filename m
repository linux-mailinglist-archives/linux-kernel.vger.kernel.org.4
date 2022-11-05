Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01F361D979
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKEKgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKEKg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:36:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F22AE3A;
        Sat,  5 Nov 2022 03:36:28 -0700 (PDT)
Date:   Sat, 05 Nov 2022 10:36:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667644586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHQrl6P86xz2am5gkMQph6NleuntroolUPtqBPFpcpw=;
        b=Sbsj5FxRfxidqlXoqvppyqEBnGbvvmT1sCI13oTzo63LmozgdJbZl/2ax3K1dC03uhKx/k
        UUcfbO+HwEYEOinVe3m0i2749o5wG2uWYg9z2Xz1w1wGwbvGsThgVYQahGNNwkHVL/EkOg
        qP7bnh8dWiIy0BusYRZYhTbNYov26xZUzWDfnhb6QIVglvL4nrf8sWCilUqNq8ZssFwK8E
        0zEy7KGC+9R2YXGf2a38Gk0GQL3Rk7HiifeKOhUy5/ln7TO1cfdPGOl3U85mtoEKl50dps
        ar16Sia7SYHT0K2uuEIOS2sBCrZlStBZeS9QHCfOOQujVm9+0lQa8JXOc1z82g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667644586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHQrl6P86xz2am5gkMQph6NleuntroolUPtqBPFpcpw=;
        b=DUHWQPQoQL6cI2I7ZKDdWn01C2fvxAinvwqCg26Jqpu0ejkharNfmFTisrTyhmaQpNEw/S
        K3KUiOtTgl29FhCw==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/Kconfig: Enable kernel IBT by default
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221101172503.gonna.094-kees@kernel.org>
References: <20221101172503.gonna.094-kees@kernel.org>
MIME-Version: 1.0
Message-ID: <166764458451.4906.10224019690835731804.tip-bot2@tip-bot2>
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

Commit-ID:     4fd5f70ce14da230c6a29648c3d51a48ee0b4bfd
Gitweb:        https://git.kernel.org/tip/4fd5f70ce14da230c6a29648c3d51a48ee0b4bfd
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 01 Nov 2022 10:25:07 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 05 Nov 2022 11:28:03 +01:00

x86/Kconfig: Enable kernel IBT by default

The kernel IBT defense strongly mitigates the common "first step" of ROP
attacks, by eliminating arbitrary stack pivots (that appear either at
the end of a function or in immediate values), which cannot be reached
if indirect calls must be to marked function entry addresses. IBT is
also required to be enabled to gain the FineIBT feature when built with
Kernel Control Flow Integrity.

Additionally, given that this feature is runtime enabled via CPU ID,
it clearly should be built in by default; it will only be enabled if the
CPU supports it. The build takes 2 seconds longer, which seems a small
price to pay for gaining this coverage by default.

Suggested-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221101172503.gonna.094-kees@kernel.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 479ee63..aaf1f0f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1856,7 +1856,7 @@ config CC_HAS_IBT
 
 config X86_KERNEL_IBT
 	prompt "Indirect Branch Tracking"
-	bool
+	def_bool y
 	depends on X86_64 && CC_HAS_IBT && HAVE_OBJTOOL
 	# https://github.com/llvm/llvm-project/commit/9d7001eba9c4cb311e03cd8cdc231f9e579f2d0f
 	depends on !LD_IS_LLD || LLD_VERSION >= 140000
