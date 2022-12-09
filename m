Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA08648329
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLIOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLIOCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:02:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD7876153;
        Fri,  9 Dec 2022 06:02:16 -0800 (PST)
Date:   Fri, 09 Dec 2022 14:02:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670594534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlvOtxHlbZnArbZNDsk3G3V1HbQjDIct7Qhi937Mogs=;
        b=nJE100anZl4dA99kVQfE+kUYCy8X70dZNBcIFa/QPk/BD+YqEWwqbxjLu8GFSCm6dRHmJ6
        q6dt79lkhWAv+2mg4MPrCN6dd4TSI0apMIdPKtChOHFJdQ4LLFG6WBbOStqXI4uxjO0J+k
        ZQ79LO+OuMxepgqJj7XMQs3GAvVJS/K0ZGvYAyRll0HtYBsAWtCHRhqd3s+fbUuHG/VfrA
        d1nHnVLZk+HXdwuUvSx9a/3WsB33TGHCVe7RoFfTddzcxQCRZkEyuAvCOj3lZIBCJen3ds
        8bQbGrP0PXJDaCzey0KIPxq7oo55Mcn0++gXIzNSlCa5PA2gXMu+M2mlYUiBGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670594534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rlvOtxHlbZnArbZNDsk3G3V1HbQjDIct7Qhi937Mogs=;
        b=kK/+o9NXkYcZtDV1L+vKkElo3zm+DM0lrq5Bt/hKzCOvHAji0Pf/xlxATilzSGF+Z68H+/
        UmpycKL9wn/CUpAQ==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/vdso: Conditionally export __vdso_sgx_enter_enclave()
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221109000306.1407357-1-nathan@kernel.org>
References: <20221109000306.1407357-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <167059453391.4906.374881146743460680.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     45be2ad007a9c6bea70249c4cf3e4905afe4caeb
Gitweb:        https://git.kernel.org/tip/45be2ad007a9c6bea70249c4cf3e4905afe4caeb
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Tue, 08 Nov 2022 17:03:07 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 09 Dec 2022 14:58:02 +01:00

x86/vdso: Conditionally export __vdso_sgx_enter_enclave()

Recently, ld.lld moved from '--undefined-version' to
'--no-undefined-version' as the default, which breaks building the vDSO
when CONFIG_X86_SGX is not set:

  ld.lld: error: version script assignment of 'LINUX_2.6' to symbol '__vdso_sgx_enter_enclave' failed: symbol not defined

__vdso_sgx_enter_enclave is only included in the vDSO when
CONFIG_X86_SGX is set. Only export it if it will be present in the final
object, which clears up the error.

Fixes: 8466436952017 ("x86/vdso: Implement a vDSO for Intel SGX enclave call")                                                                                                                                                               
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://github.com/ClangBuiltLinux/linux/issues/1756
Link: https://lore.kernel.org/r/20221109000306.1407357-1-nathan@kernel.org
---
 arch/x86/entry/vdso/vdso.lds.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index 4bf4846..e8c60ae 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -27,7 +27,9 @@ VERSION {
 		__vdso_time;
 		clock_getres;
 		__vdso_clock_getres;
+#ifdef CONFIG_X86_SGX
 		__vdso_sgx_enter_enclave;
+#endif
 	local: *;
 	};
 }
