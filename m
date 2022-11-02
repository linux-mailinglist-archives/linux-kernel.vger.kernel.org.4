Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790C0615F7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiKBJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiKBJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0C96577;
        Wed,  2 Nov 2022 02:20:05 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:20:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Fs7rx3JLGWegzERC8SiWPfw1n/3JssDfTzRJBvdwY8=;
        b=dhNDLZ/fJro858ZGiKXPzHtrA2hRSjq+qVmhQrXNMt9CJc1nwfa6zR0SIfD+fNRzZd2aEc
        IyU2UStJxcbj0WRgJ+MONn0SgNOmKCqYVAvonCUfJ/IB1KBM+YMKZ9WpNXQvvY4KQHlg6C
        Ldw0X+ch9g2bHZDGKT/xxzMSj2L08d3jxtrOYCzTeG1RsXae+Jb/F7JW3XQu4Aqfy5EbfB
        iSCeuECK+my0iv+u6OtOcEIjEqybFt1EXOCZRC5z1ZEaA727B/QdfBby6Iz00foMxVIBtd
        ht/igB5kPZdQj/thVq3R1iqfMge1H1S50jnTgXC9ZOPEEnXM5wJVsJRdKj/5og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380804;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Fs7rx3JLGWegzERC8SiWPfw1n/3JssDfTzRJBvdwY8=;
        b=fOeAFzr6VeoNvEjpHWNF0jhTT4Bf95nQuirUucH0CFJb19il5AkPaaNOlaWk/4rkCPv+m5
        T2nYBneacMI0PGCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Add prefix symbols for function padding
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yujie Liu <yujie.liu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028194453.592512209@infradead.org>
References: <20221028194453.592512209@infradead.org>
MIME-Version: 1.0
Message-ID: <166738080290.7716.15262986984663902819.tip-bot2@tip-bot2>
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

Commit-ID:     b341b20d648bb7e9a3307c33163e7399f0913e66
Gitweb:        https://git.kernel.org/tip/b341b20d648bb7e9a3307c33163e7399f0913e66
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 28 Oct 2022 21:08:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:09 +01:00

x86: Add prefix symbols for function padding

When code is compiled with:

  -fpatchable-function-entry=${PADDING_BYTES},${PADDING_BYTES}

functions will have PADDING_BYTES of NOP in front of them. Unwinders
and other things that symbolize code locations will typically
attribute these bytes to the preceding function.

Given that these bytes nominally belong to the following symbol this
mis-attribution is confusing.

Inspired by the fact that CFI_CLANG emits __cfi_##name symbols to
claim these bytes, use objtool to emit __pfx_##name symbols to do
the same when CFI_CLANG is not used.

This then shows the callthunk for symbol 'name' as:

  __pfx_##name+0x6/0x10

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Link: https://lkml.kernel.org/r/20221028194453.592512209@infradead.org
---
 arch/x86/Kconfig     | 4 ++++
 scripts/Makefile.lib | 1 +
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b52ad13..32818aa 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2471,6 +2471,10 @@ config CALL_THUNKS
 	def_bool n
 	select FUNCTION_ALIGNMENT_16B
 
+config PREFIX_SYMBOLS
+	def_bool y
+	depends on CALL_THUNKS && !CFI_CLANG
+
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
 	default y
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 85f0275..2e03bcb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -265,6 +265,7 @@ objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
+objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
