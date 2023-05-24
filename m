Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB91670ED10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjEXF2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239349AbjEXF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:28:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72CBA18B;
        Tue, 23 May 2023 22:28:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae52ce3250so5586415ad.2;
        Tue, 23 May 2023 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684906118; x=1687498118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6d5AcXkE4ZWFgJOqcetC1ECS3Bjvt7gCvqCnn13vov8=;
        b=U/BHPbdbcWy/tkay45yCh6xlRSq7ZzCreo8ZiM9J0SXDcn99NXpAe/6uBP9lyA7d2F
         P66J/y87FhsajG+llr9lw+iS+WAFfXRQjBbjrx90jSB1w6M+WbLdpwXgh42ZsBCVHzK/
         sjWVz6jeW//tv12oxCuZlJL3ODxEouLF1qdAEPsC0H2fxkZoHfbu9emTvI1G4gWvxMFW
         +6VJ3rNekRwNLSjeQUun0Kw/0UVQGvg5n+aT4td90BUKhmQJD/dFW0UAy8SLHlY0Rul4
         cIc+ph3gnJqoxbLoGWQND8q3IkqR/o5w5lSLHbKnTVu5e8+xCiCF2qWrQK+QYZCyxL/0
         3F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684906118; x=1687498118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6d5AcXkE4ZWFgJOqcetC1ECS3Bjvt7gCvqCnn13vov8=;
        b=Zu2Q+9HO7qOHoWmtq8e/yTOUInQ0HCXxSb02Sl4FoW1WFneziyX0XsqX1uKJrx9rsy
         x+bsarFnBYwauhGp04CR98FWXFT2cM9GmAWq6sd7rTvHucTks95iIacxJMQ00nCcBOyf
         denE4tvvN7hp87xBvy5S9shPQDIy5iT7z1TZq+jGWs2nQc/QFaKWYExfV6tR+/7oh8MC
         bP/bMQVlOWw5lU30bDTed0LpaOzoHcnZGJ8zyh4O0TpSvfSs2bDhDdkgvunQjsg4Zb6f
         RBxaTA+JNeYitQymvUy8Nvkwa6TBfdnIaCvTO4orqWHhj+MnWV0SSMXiqY9iRKK/85cj
         eHRg==
X-Gm-Message-State: AC+VfDyZuto9kM/PLSwBJC7aI3nYMT2yVk8xJR8XhVbnDmcu+f+2AK6R
        LklZMLFaVQ4i1IGQH4tRvSY=
X-Google-Smtp-Source: ACHHUZ49Fu91ZoPMgmRtyS2Yb8f7gQ/M+CoSj7B1dJgLO8HV4yrvDhWIi3QEUfgvw+pSXTSk+Q8tPA==
X-Received: by 2002:a17:902:ecd0:b0:1a1:b3bb:cd5b with SMTP id a16-20020a170902ecd000b001a1b3bbcd5bmr17037366plh.62.1684906117768;
        Tue, 23 May 2023 22:28:37 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:806f:2bdc:cf65:f76b])
        by smtp.gmail.com with ESMTPSA id f10-20020a170902ce8a00b001a64011899asm7706626plg.25.2023.05.23.22.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 22:28:37 -0700 (PDT)
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
Subject: [PATCH 2/2] perf annotate: Remove x86 instructions with suffix
Date:   Tue, 23 May 2023 22:28:34 -0700
Message-ID: <20230524052834.1041418-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230524052834.1041418-1-namhyung@kernel.org>
References: <20230524052834.1041418-1-namhyung@kernel.org>
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

Not the suffix is handled in the general code.  Let's get rid of them.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c | 44 +--------------------
 1 file changed, 2 insertions(+), 42 deletions(-)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 5c7bec25fee4..714fd8784d99 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -1,48 +1,29 @@
 // SPDX-License-Identifier: GPL-2.0
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
@@ -56,7 +37,6 @@ static struct ins x86__instructions[] = {
 	{ .name = "jl",		.ops = &jump_ops, },
 	{ .name = "jle",	.ops = &jump_ops, },
 	{ .name = "jmp",	.ops = &jump_ops, },
-	{ .name = "jmpq",	.ops = &jump_ops, },
 	{ .name = "jna",	.ops = &jump_ops, },
 	{ .name = "jnae",	.ops = &jump_ops, },
 	{ .name = "jnb",	.ops = &jump_ops, },
@@ -83,49 +63,31 @@ static struct ins x86__instructions[] = {
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
@@ -139,11 +101,9 @@ static struct ins x86__instructions[] = {
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
2.40.1.698.g37aff9b760-goog

