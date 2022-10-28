Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E189611B23
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJ1TsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJ1Trz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:47:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD6241B35
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=dw2+KyAKk/Vgq7gh3A5Vj3COoPkFBdj0Z6avPUlckh4=; b=qeQgNOm135IQHespPW8tvobp0V
        xikJ7xB2qqPBPAkaBL+pXNXryXDzY40SdFMIATyVZY1JFlOA6t9rDpCCgLGBBIArPoXgT/POmZ7DT
        AewooojZW7SNctC8ZLtyopjhGxrOmc4I9PMiiwO3O2sNpz5oRqZTyHgS2GjvkZlPbUqCUAaqBM8DV
        4zd6qANrbAaxe06rPPKQ2QJ+jwH62H44tVnTZU7+wXh/N4doeluoBp69JNo6Tlf/PgV5d/wj0Lnyj
        uH++5Q5Qy4/2Wj5P4dt2SM5aBTdgrcfVOQ2fgd4yqYGW8neDvfi//ilCMsWPX5oTpni4S3yt0SQrr
        JaTR6KGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooVKW-001V60-V0; Fri, 28 Oct 2022 19:47:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 20B90300C19;
        Fri, 28 Oct 2022 21:47:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A7BBD2C6DAB2E; Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Message-ID: <20221028194453.592512209@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Oct 2022 21:40:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        djwong@kernel.org, yujie.liu@intel.com, tglx@linutronix.de,
        jpoimboe@kernel.org, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: [PATCH 5/5] x86: Add prefix symbols for function padding
References: <20221028194022.388521751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/Kconfig     |    4 ++++
 scripts/Makefile.lib |    1 +
 2 files changed, 5 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2472,6 +2472,10 @@ config CALL_THUNKS
 	def_bool n
 	select FUNCTION_ALIGNMENT_16B
 
+config PREFIX_SYMBOLS
+	def_bool y
+	depends on CALL_THUNKS && !CFI_CLANG
+
 menuconfig SPECULATION_MITIGATIONS
 	bool "Mitigations for speculative execution vulnerabilities"
 	default y
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -265,6 +265,7 @@ objtool-args-$(CONFIG_STACK_VALIDATION)
 objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
 objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
 objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
+objtool-args-$(CONFIG_PREFIX_SYMBOLS)			+= --prefix=$(CONFIG_FUNCTION_PADDING_BYTES)
 
 objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\


