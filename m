Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81E5743131
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjF2XnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjF2Xmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:42:55 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7CBEC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-570553a18deso11017607b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688082173; x=1690674173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rwKLI/qRUKPULIlBC3OTUhb6lfrxfVtcL7RWgMXp+DM=;
        b=xZ4gzYmgSDP58mOKR8hM46Nd3CktXTb7BWdOsL40ZpOowsFja8hHx4hEpRu7h+8XXt
         MXlo89FDD72TAUb0aNZwUN9hsD5krX9N6BIDIdgNZjO2+Q9hqoPmMO0wHRAE3CanaHoU
         CADHRRVIOfgsXUI7G64inFFIC6roC6nRP9g9q4FoTqTZt29i4bySfE6PCOpQKuDFFD+S
         qmiO+EA4gU+2Idsy+Qnduwt2kaRDhqdZTG4p59yUdS5hMXfpchMb7zXP+BfLtVyISxVO
         bziwFW/aif6c2MFD81O0+6TPzmJ57qD6QsqQF1V8sU5pSP48L18NjLafTtvf7VZj/Uf6
         mi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688082173; x=1690674173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwKLI/qRUKPULIlBC3OTUhb6lfrxfVtcL7RWgMXp+DM=;
        b=keKnIR8ZKzBmhNg9J/oiA1ia7oqOvACmfP/nFRr3oxLb8WrnzFxsk7tR+d0PyXuKIO
         i2uhGmsf6LvWjWl8dVO+O85W5NAjEX+gbw8QWTvlbxv3Gotwu2qdRPRsHFXFut/qX+xx
         pcJjfPvxmUuR+4hTswTSJwZCrq/wJsvL3EaTKrVQ2rORJe6TSL+cEd/j6GsMJJ5xqeAS
         Pd5LZcxesRo7EXUAkqy2AxYPMK/rctL7I0hY+Owx/0qecKonSV8FIYqFPeoY+wo9CdUo
         U4LFDziBJXajtuy1wBEjUgepNN8qteh5Mi1KdFa1XGSgYFLiCzvvIvvh2k/5PVKI8aVY
         B2AQ==
X-Gm-Message-State: ABy/qLbLft95GFcqXw8325HlZD2wt2xj7tnmhz4IGRoJSsFoSsQt1m3O
        ZTmZRuEvM44gLBtoHE2FF2lhuI7gKx9n8VgYHO4=
X-Google-Smtp-Source: APBJJlGvY9o8TdVQA2iFVhCCB50GqC+vEYRFxxtjURS+zUxZ3uCTPfePcPm+HJkTvW8UT4zvI1DCpmZcRMm1arw/G+E=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a81:7e0a:0:b0:56f:f62b:7a11 with SMTP
 id o10-20020a817e0a000000b0056ff62b7a11mr6436ywn.8.1688082173423; Thu, 29 Jun
 2023 16:42:53 -0700 (PDT)
Date:   Thu, 29 Jun 2023 23:42:47 +0000
In-Reply-To: <20230629234244.1752366-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20230629234244.1752366-8-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=samitolvanen@google.com;
 h=from:subject; bh=Gkp1NJ2f7yYUqQXHMI7a2x2tGYxFA1ILvi7IEKTnass=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBknhb1WHJAgo4Uq6U6j6NflafXu9jZGHzv6JSKG
 I68vAHUjwOJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZJ4W9QAKCRBMtfaEi7xW
 7ra7DACnV4oH9Zp+lDg83B8KilPxMfwy2imQEk7g4tL0+joJ7XhULu9MfK90xn7TM7i4gtaSYlw
 WWtBPr32oT+mqBypw6Zzzh3TjqvFxGw6L4NBPrew6Zv8Q2DnCsPP3MdTja4RKLIR9eYZz/6MKhY
 KoJ1U2HlLEczeZs9jBPFvTUBeodHLyEcItxzzSMGaK8gSj0HUgan9Y0jDi1r2wlPF9qgKtm/5lF
 e3pkg/Uv3sTKtwhfqNeCqnkBuo3UwEAuXmUP2BKHh1RVZRRHkXsYPbi6hckTUsHIsz/Ei36AaKy
 dYHxMndLyrFMOV55dL9x2qlhOYEwmNjRDotAMG/b0sT09z4txrkykyuszG4sHikOQg5drQ6Qt5K
 Fjw/DqnV9FeYOjowphHAm21MgWwnxwBUALJrWe92r5LVU+EqWAZEFtROnZlRkcsTrt3D8P6ozhM kSPl2dnVwxy5LCbyOS8SfKJPZbyg7P3geJcOGAJ3DcZ0TRSuOpXbTvdhgxFYPSa++A5FQ=
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629234244.1752366-10-samitolvanen@google.com>
Subject: [PATCH 2/6] riscv: Add types to indirectly called assembly functions
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_CFI_CLANG, assembly functions indirectly called
from C code must be annotated with type identifiers to pass CFI
checking. Use the SYM_TYPED_START macro to add types to the
relevant functions.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/kernel/mcount.S        | 5 +++--
 arch/riscv/kernel/suspend_entry.S | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/mcount.S b/arch/riscv/kernel/mcount.S
index 30102aadc4d7..712c1d2c2723 100644
--- a/arch/riscv/kernel/mcount.S
+++ b/arch/riscv/kernel/mcount.S
@@ -3,6 +3,7 @@
 
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 #include <asm/csr.h>
 #include <asm/unistd.h>
@@ -47,13 +48,13 @@
 	addi	sp, sp, 4*SZREG
 	.endm
 
-ENTRY(ftrace_stub)
+SYM_TYPED_FUNC_START(ftrace_stub)
 #ifdef CONFIG_DYNAMIC_FTRACE
        .global MCOUNT_NAME
        .set    MCOUNT_NAME, ftrace_stub
 #endif
 	ret
-ENDPROC(ftrace_stub)
+SYM_FUNC_END(ftrace_stub)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 ENTRY(return_to_handler)
diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
index 12b52afe09a4..f7960c7c5f9e 100644
--- a/arch/riscv/kernel/suspend_entry.S
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -5,6 +5,7 @@
  */
 
 #include <linux/linkage.h>
+#include <linux/cfi_types.h>
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
@@ -58,7 +59,7 @@ ENTRY(__cpu_suspend_enter)
 	ret
 END(__cpu_suspend_enter)
 
-ENTRY(__cpu_resume_enter)
+SYM_TYPED_FUNC_START(__cpu_resume_enter)
 	/* Load the global pointer */
 	.option push
 	.option norelax
@@ -94,4 +95,4 @@ ENTRY(__cpu_resume_enter)
 
 	/* Return to C code */
 	ret
-END(__cpu_resume_enter)
+SYM_FUNC_END(__cpu_resume_enter)
-- 
2.41.0.255.g8b1d071c50-goog

