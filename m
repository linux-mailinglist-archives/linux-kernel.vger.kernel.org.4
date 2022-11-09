Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF750623376
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKIT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKIT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:28:34 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1816334
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:28:33 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id h16-20020a170902f55000b001871b770a83so13938804plf.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 11:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uhn/izWbmyc6oJPM/ThsWZaC9OAu56s0DbZK1LlxeR0=;
        b=DIGqhVBczwt3BrX2ZjwcfG7CUyu3SftdoAUziC9Oc3LkXSqkFBpXU+j09vJsy1YS3k
         yj/Bsd+44LNWbXtNkti2tG/boBaK1iSNWJAre0DS89T+RZ1cUosoQB0ZuKh/JVGhLm4J
         hIy2sJTnbBQL7zCSlsMnOUlfbUx+pisd0SsEPoSfy6iuKfoRP8lM6noCGxdz+ooEcrR+
         LHu3AtkKjuvdHOUxcATha0CTpmfZNvqKmui4iBvs3sAKn0gxPWK7NAqM0BsrsHVM6bmP
         t9QYauD2wfHzfS4+g3c0J/WBvgu/vELufbiXj6H14D05SIB2Peo8+9r9kI86Hfsrw00U
         ahBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhn/izWbmyc6oJPM/ThsWZaC9OAu56s0DbZK1LlxeR0=;
        b=MkJZilPJ45enV8JvRexQkEAcHvtZYE9724VU2La4alcO6ovC9E3AIty1LVpSYZPzx+
         UAl14V4nVEP7N1TmtxVyJDhZuEobFclgj8O/8SIZdCPs2WAXe/TSDsxZB2tfCrMH9hIz
         v8L3FUisnO+xwbRE+Q0Fka69AsgZLwnM5hjS8riETFArYlGV3GYIUQstnz889aALhTQn
         6qEmq4yeS491dDxEb4e0TvN6M10aV/qXJ4dukbTctyYCvgjiFcTdHhnouXKvqI4IlI6S
         qN/O4sHI70b0xtUjv57y8+eQZTi1mJe2A6mhGnQD7MNv5SAo6oA5jDQc1OmSl/gHpkNa
         SIFw==
X-Gm-Message-State: ACrzQf3m0pxHMH2uoMXv9Tniem+TKZvnHusY+az83URNeSwdOOS/kcDL
        qXC+Ucxhvf6R2AK8hrQ/ncje+Ggdxin/gKRwmcQ=
X-Google-Smtp-Source: AMsMyM7uHJUKuqxsR2zoKIJVOW/QBrkWsQuNpEo3NxnRhXuQr8I5NfDtJnaqqd6IVHZHFwmhk3jiEvuUFJng0GJpE3Y=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a17:90a:6f62:b0:20a:7294:47dd with
 SMTP id d89-20020a17090a6f6200b0020a729447ddmr1175555pjk.207.1668022113175;
 Wed, 09 Nov 2022 11:28:33 -0800 (PST)
Date:   Wed,  9 Nov 2022 19:28:31 +0000
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=samitolvanen@google.com;
 h=from:subject; bh=VPKNPjkd/bF/wEZ6qVmao9Uypu73PRnyiFbtq1FB7vI=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBja/9f/3bT87oqAsZkcr4QGkPDCG2AvGyz2K6jyg+0
 47dDtUqJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCY2v/XwAKCRBMtfaEi7xW7s6bC/
 9LItMZNO3ztZbFyP3Si5LNRh3LFcMWxjZfi9X976rp+CBbyljWuWHFj1NbbR9dodRnn5DZYvSfx7FW
 /UO7zsgM6tH+ZYY+PxzFWQ57DM94ogVG9/z0OdSXGhicbC/qRQnRwjVD+B5c9GmW4WuiRUzpSSUXxK
 7djx28X7DCxyz68eAO4so9WZWi/92bI7rXfsjKaG6aM9vb98CXPOSmtt7xVl7CXhCC2vMbpjOrJkqk
 tR0WFv7stefASbnMFAWC77TuPaTeR++tfsD7bw1394Yrnzt/LDLYZAwOyqYWH3NNgp8g/NWSHOLpVT
 SDc+T6t3KlcmvJ9lcPaHSb1kAONLaXXVjBT0SVxIAop+oJeaVaFHIjykffZR3QcWxHdjdkBvmzrZsS
 p0dK77UcnA14T8EpCV+tLNR3SsJQV35eeGZwLWwbgo9rAtLvCHJFS5dJs0+wrCMj/XeekoZ6iJzUZJ
 Qv/20nn4s+q/m7czC/fTZimFyxALUnu0N9PwNksjV3wgY=
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221109192831.3057131-1-samitolvanen@google.com>
Subject: [PATCH] arm64: ftrace: Define ftrace_stub_graph only with FUNCTION_GRAPH_TRACER
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 0-day bot reports that arm64 builds with CONFIG_CFI_CLANG +
CONFIG_FTRACE are broken when CONFIG_FUNCTION_GRAPH_TRACER is not
enabled:

 ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
 >>> referenced by entry-ftrace.S:299 (arch/arm64/kernel/entry-ftrace.S:299)
 >>>               arch/arm64/kernel/entry-ftrace.o:(.text+0x48) in archive vmlinux.a

This is caused by ftrace_stub_graph using SYM_TYPE_FUNC_START when
the address of the function is not taken in any C translation unit.

Fix the build by only defining ftrace_stub_graph when it's actually
needed, i.e. with CONFIG_FUNCTION_GRAPH_TRACER.

Link: https://lore.kernel.org/lkml/202210251659.tRMs78RH-lkp@intel.com/
Fixes: 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/kernel/entry-ftrace.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 795344ab4ec4..322a831f8ede 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -299,11 +299,11 @@ SYM_TYPED_FUNC_START(ftrace_stub)
 	ret
 SYM_FUNC_END(ftrace_stub)
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_TYPED_FUNC_START(ftrace_stub_graph)
 	ret
 SYM_FUNC_END(ftrace_stub_graph)
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
 /*
  * void return_to_handler(void)
  *

base-commit: f141df371335645ce29a87d9683a3f79fba7fd67
-- 
2.38.1.431.g37b22c650d-goog

