Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB270FF77
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 22:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjEXUvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 16:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjEXUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 16:51:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DE210B;
        Wed, 24 May 2023 13:50:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ae454844edso5430755ad.1;
        Wed, 24 May 2023 13:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684961459; x=1687553459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvYYr0PzLjjU1LQxplybqUfs91wuvddueNT+aDefplo=;
        b=DOH4k9gWSApzqFteThph9qUj2XS+eZSOD/snYq2wYKo1CeJWKFjRuGtFkIH6NPE9nr
         pX8k9B4DFR81mzWmAvOSgb8tpYNSr5Zur1EUTUC2pYUqhbPsNFT9UpCoVGiePhXP2bJT
         ydXN1BiwaGxjfYckUa89599kBhhYuEjv+Gljz+2addAteNM7JxU715T3cwfx2crpA3db
         JUMqb8oIuWsO/4WHG53fJMpvL95U82d0ylPVHTEAMNIRtnmADBVj5/DqaCmdzTcl2mpV
         tyd2Ei+0i4nAWDRekSI+9wRD2omjuRl4t6KaOZLNfR1eE9D7oiL8XvIMg49Ze2VJpOxt
         q9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684961459; x=1687553459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rvYYr0PzLjjU1LQxplybqUfs91wuvddueNT+aDefplo=;
        b=Y3rcoe7uwTYF0vEmJAXFPIJBYXu9qrq0C1jZUkLe2PeWVFKI1hJ8MyyKS3Qol3s2fG
         UpVSKBGnPqoxALdQWBX8bZUXpWCGHXUPkKBlLyOlENJ8xUssGquQL4uKvkivobxWWfdW
         I5/HYHcJIEu8Kc7FzSgjPLYk9688wl48BrZv1eXUMUlCQtHLIkVavCg9PBeK9rPuc6jc
         djb/lIYulksXjGFF/lhf0FtfET7Nb/9FqWFyOOn7P2c5CgufAsAjbn9WchRkMXD1RZlH
         Q6Hsmhowom9vuM2T+RbQQo/Iy93jQC44E2wd/xkTdSQ9nP4divVHNHqVHaue7sypHvS2
         OhmQ==
X-Gm-Message-State: AC+VfDxF5JbNfG5f5ZllfivnCgQZVztMKYf59VotIxH+EqCLFW6Vxp1p
        1jihLiwkAmkj1yrr53HweFc=
X-Google-Smtp-Source: ACHHUZ5EqhXsgvlBQOEqYRaWmgor4dDzHsybz1FD0k7Rrc8aF5bPOMgUVae208qERownQuZ40b/e9Q==
X-Received: by 2002:a17:902:da87:b0:1af:bdeb:a09c with SMTP id j7-20020a170902da8700b001afbdeba09cmr10270644plx.31.1684961459201;
        Wed, 24 May 2023 13:50:59 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:121:f908:b42d:c399])
        by smtp.gmail.com with ESMTPSA id 31-20020a63185f000000b00513973a7014sm5215340pgy.12.2023.05.24.13.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 13:50:58 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH v2 2/2] perf annotate: Remove x86 instructions with suffix
Date:   Wed, 24 May 2023 13:50:54 -0700
Message-ID: <20230524205054.3087004-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <20230524205054.3087004-1-namhyung@kernel.org>
References: <20230524205054.3087004-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the suffix is handled in the general code.  Let's get rid of them.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c | 52 ++++-----------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 5c7bec25fee4..5f4ac4fc7fcf 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -1,48 +1,37 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * x86 instruction nmemonic table to parse disasm lines for annotate.
+ * This table is searched twice - one for exact match and another for
+ * match without a size suffix (b, w, l, q) in case of AT&T syntax.
+ *
+ * So this table should not have entries with the suffix unless it's
+ * a complete different instruction than ones without the suffix.
+ */
 static struct ins x86__instructions[] = {
 	{ .name = "adc",	.ops = &mov_ops,  },
-	{ .name = "adcb",	.ops = &mov_ops,  },
-	{ .name = "adcl",	.ops = &mov_ops,  },
 	{ .name = "add",	.ops = &mov_ops,  },
-	{ .name = "addl",	.ops = &mov_ops,  },
-	{ .name = "addq",	.ops = &mov_ops,  },
 	{ .name = "addsd",	.ops = &mov_ops,  },
-	{ .name = "addw",	.ops = &mov_ops,  },
 	{ .name = "and",	.ops = &mov_ops,  },
-	{ .name = "andb",	.ops = &mov_ops,  },
-	{ .name = "andl",	.ops = &mov_ops,  },
 	{ .name = "andpd",	.ops = &mov_ops,  },
 	{ .name = "andps",	.ops = &mov_ops,  },
-	{ .name = "andq",	.ops = &mov_ops,  },
-	{ .name = "andw",	.ops = &mov_ops,  },
 	{ .name = "bsr",	.ops = &mov_ops,  },
 	{ .name = "bt",		.ops = &mov_ops,  },
 	{ .name = "btr",	.ops = &mov_ops,  },
 	{ .name = "bts",	.ops = &mov_ops,  },
-	{ .name = "btsq",	.ops = &mov_ops,  },
 	{ .name = "call",	.ops = &call_ops, },
-	{ .name = "callq",	.ops = &call_ops, },
 	{ .name = "cmovbe",	.ops = &mov_ops,  },
 	{ .name = "cmove",	.ops = &mov_ops,  },
 	{ .name = "cmovae",	.ops = &mov_ops,  },
 	{ .name = "cmp",	.ops = &mov_ops,  },
-	{ .name = "cmpb",	.ops = &mov_ops,  },
-	{ .name = "cmpl",	.ops = &mov_ops,  },
-	{ .name = "cmpq",	.ops = &mov_ops,  },
-	{ .name = "cmpw",	.ops = &mov_ops,  },
 	{ .name = "cmpxch",	.ops = &mov_ops,  },
 	{ .name = "cmpxchg",	.ops = &mov_ops,  },
 	{ .name = "cs",		.ops = &mov_ops,  },
 	{ .name = "dec",	.ops = &dec_ops,  },
-	{ .name = "decl",	.ops = &dec_ops,  },
-	{ .name = "decq",	.ops = &dec_ops,  },
 	{ .name = "divsd",	.ops = &mov_ops,  },
 	{ .name = "divss",	.ops = &mov_ops,  },
 	{ .name = "gs",		.ops = &mov_ops,  },
 	{ .name = "imul",	.ops = &mov_ops,  },
 	{ .name = "inc",	.ops = &dec_ops,  },
-	{ .name = "incl",	.ops = &dec_ops,  },
-	{ .name = "incq",	.ops = &dec_ops,  },
 	{ .name = "ja",		.ops = &jump_ops, },
 	{ .name = "jae",	.ops = &jump_ops, },
 	{ .name = "jb",		.ops = &jump_ops, },
@@ -56,7 +45,6 @@ static struct ins x86__instructions[] = {
 	{ .name = "jl",		.ops = &jump_ops, },
 	{ .name = "jle",	.ops = &jump_ops, },
 	{ .name = "jmp",	.ops = &jump_ops, },
-	{ .name = "jmpq",	.ops = &jump_ops, },
 	{ .name = "jna",	.ops = &jump_ops, },
 	{ .name = "jnae",	.ops = &jump_ops, },
 	{ .name = "jnb",	.ops = &jump_ops, },
@@ -83,49 +71,31 @@ static struct ins x86__instructions[] = {
 	{ .name = "mov",	.ops = &mov_ops,  },
 	{ .name = "movapd",	.ops = &mov_ops,  },
 	{ .name = "movaps",	.ops = &mov_ops,  },
-	{ .name = "movb",	.ops = &mov_ops,  },
 	{ .name = "movdqa",	.ops = &mov_ops,  },
 	{ .name = "movdqu",	.ops = &mov_ops,  },
-	{ .name = "movl",	.ops = &mov_ops,  },
-	{ .name = "movq",	.ops = &mov_ops,  },
 	{ .name = "movsd",	.ops = &mov_ops,  },
 	{ .name = "movslq",	.ops = &mov_ops,  },
 	{ .name = "movss",	.ops = &mov_ops,  },
 	{ .name = "movupd",	.ops = &mov_ops,  },
 	{ .name = "movups",	.ops = &mov_ops,  },
-	{ .name = "movw",	.ops = &mov_ops,  },
 	{ .name = "movzbl",	.ops = &mov_ops,  },
 	{ .name = "movzwl",	.ops = &mov_ops,  },
 	{ .name = "mulsd",	.ops = &mov_ops,  },
 	{ .name = "mulss",	.ops = &mov_ops,  },
 	{ .name = "nop",	.ops = &nop_ops,  },
-	{ .name = "nopl",	.ops = &nop_ops,  },
-	{ .name = "nopw",	.ops = &nop_ops,  },
 	{ .name = "or",		.ops = &mov_ops,  },
-	{ .name = "orb",	.ops = &mov_ops,  },
-	{ .name = "orl",	.ops = &mov_ops,  },
 	{ .name = "orps",	.ops = &mov_ops,  },
-	{ .name = "orq",	.ops = &mov_ops,  },
 	{ .name = "pand",	.ops = &mov_ops,  },
 	{ .name = "paddq",	.ops = &mov_ops,  },
 	{ .name = "pcmpeqb",	.ops = &mov_ops,  },
 	{ .name = "por",	.ops = &mov_ops,  },
-	{ .name = "rclb",	.ops = &mov_ops,  },
-	{ .name = "rcll",	.ops = &mov_ops,  },
+	{ .name = "rcl",	.ops = &mov_ops,  },
 	{ .name = "ret",	.ops = &ret_ops,  },
-	{ .name = "retq",	.ops = &ret_ops,  },
 	{ .name = "sbb",	.ops = &mov_ops,  },
-	{ .name = "sbbl",	.ops = &mov_ops,  },
 	{ .name = "sete",	.ops = &mov_ops,  },
 	{ .name = "sub",	.ops = &mov_ops,  },
-	{ .name = "subl",	.ops = &mov_ops,  },
-	{ .name = "subq",	.ops = &mov_ops,  },
 	{ .name = "subsd",	.ops = &mov_ops,  },
-	{ .name = "subw",	.ops = &mov_ops,  },
 	{ .name = "test",	.ops = &mov_ops,  },
-	{ .name = "testb",	.ops = &mov_ops,  },
-	{ .name = "testl",	.ops = &mov_ops,  },
-	{ .name = "testq",	.ops = &mov_ops,  },
 	{ .name = "tzcnt",	.ops = &mov_ops,  },
 	{ .name = "ucomisd",	.ops = &mov_ops,  },
 	{ .name = "ucomiss",	.ops = &mov_ops,  },
@@ -139,11 +109,9 @@ static struct ins x86__instructions[] = {
 	{ .name = "vsubsd",	.ops = &mov_ops,  },
 	{ .name = "vucomisd",	.ops = &mov_ops,  },
 	{ .name = "xadd",	.ops = &mov_ops,  },
-	{ .name = "xbeginl",	.ops = &jump_ops, },
-	{ .name = "xbeginq",	.ops = &jump_ops, },
+	{ .name = "xbegin",	.ops = &jump_ops, },
 	{ .name = "xchg",	.ops = &mov_ops,  },
 	{ .name = "xor",	.ops = &mov_ops, },
-	{ .name = "xorb",	.ops = &mov_ops, },
 	{ .name = "xorpd",	.ops = &mov_ops, },
 	{ .name = "xorps",	.ops = &mov_ops, },
 };
-- 
2.41.0.rc0.172.g3f132b7071-goog

