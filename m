Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9975D6FEBBE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEKG1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:27:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35DDE0;
        Wed, 10 May 2023 23:27:28 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a50cb65c92so58714655ad.0;
        Wed, 10 May 2023 23:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683786448; x=1686378448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WK/vptfD+s0yQGQBHciJfzoWhRURnNdyfSrksISe1As=;
        b=gJBO284BPEnxa95PkjvJXy4xbgbF2UBpZvdagt/VBUrBSAfzfEu8DL1CmFwXPDBwve
         mId9OBLz+z5A9GE3JU6KhE7rCwXODt6+/uMmVvDikBpws/w9RZjrdm3oZVg+7rx9qrxo
         ZYNZy7hlGj88jJ7fZ7zUlTt6l5KKxKh7jJEfwrIUGtbSLFQry5rmFdiyR4YYmoJBJ5Zg
         aOIxV2uGu3MBfC/PPx9qFCSCQ9OIWxhViTmhZfXhT4wspIUol+LCrd6zRC09HPLnWCui
         5Pu6NrvfXMHa7UlXgTDGml32vKnX4XI+FbFSpw5asVznYpickyJFn/mpr8EW6sGQ8C0d
         9rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683786448; x=1686378448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WK/vptfD+s0yQGQBHciJfzoWhRURnNdyfSrksISe1As=;
        b=adMqbjOlfHoSgtaRCW8DWUHFkZyYAgZsYC2duT9Hh1yYJdEoo65FfuMUZl6gXD35OB
         zYfhmhfuIS7viOLubnG/sg9zZ4PtMbdtw6CWRznSqzNOwxEFJwty+4YCYfPdC4ce7UVA
         vIMK0g6hWKKz/T12ovESg2v9PsHciERI9p9BlRpTjSRC6n6pxhxabXK6P6mUQVxGgHtC
         NaBr25aJu2PuxIpzxLaKBdXzTOVrv0D1sjVwZXXQACwjZJiNUpU0m99lqhh/adaz68jl
         rL/9aTrP/AQwDf51KNMmtxPR/2Ii5Jhr67k+WC0a6bCPke6dnbdGGdEZ6eoARjS7sjt8
         JS0Q==
X-Gm-Message-State: AC+VfDxT79wAyqK7DzZ8mzOAWwrxgK0ScK8Fsv7JQXFUVm5aSTNEeWHN
        CtDxta8N1Nmm7r0h54V5p4Y=
X-Google-Smtp-Source: ACHHUZ7WaGgNnYjLsRO/LfW6XkiMCrq1KgpDQmq1xehf5f92Oh5Kx3GelBWTdSsGYoPzV9+O0H1ijg==
X-Received: by 2002:a17:902:8216:b0:1ac:753a:7933 with SMTP id x22-20020a170902821600b001ac753a7933mr11649636pln.39.1683786448233;
        Wed, 10 May 2023 23:27:28 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c18c:3210:36c3:c88c])
        by smtp.gmail.com with ESMTPSA id jj17-20020a170903049100b001ac2be2639asm4925683plb.223.2023.05.10.23.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 23:27:27 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/3] perf annotate: Handle more instructions on x86
Date:   Wed, 10 May 2023 23:27:23 -0700
Message-ID: <20230511062725.514752-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
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

I found some instructions didn't parse the operands properly.
Add them to the table to fix the issue.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/x86/annotate/instructions.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
index 305872692bfd..5c7bec25fee4 100644
--- a/tools/perf/arch/x86/annotate/instructions.c
+++ b/tools/perf/arch/x86/annotate/instructions.c
@@ -35,12 +35,14 @@ static struct ins x86__instructions[] = {
 	{ .name = "cs",		.ops = &mov_ops,  },
 	{ .name = "dec",	.ops = &dec_ops,  },
 	{ .name = "decl",	.ops = &dec_ops,  },
+	{ .name = "decq",	.ops = &dec_ops,  },
 	{ .name = "divsd",	.ops = &mov_ops,  },
 	{ .name = "divss",	.ops = &mov_ops,  },
 	{ .name = "gs",		.ops = &mov_ops,  },
 	{ .name = "imul",	.ops = &mov_ops,  },
 	{ .name = "inc",	.ops = &dec_ops,  },
 	{ .name = "incl",	.ops = &dec_ops,  },
+	{ .name = "incq",	.ops = &dec_ops,  },
 	{ .name = "ja",		.ops = &jump_ops, },
 	{ .name = "jae",	.ops = &jump_ops, },
 	{ .name = "jb",		.ops = &jump_ops, },
@@ -123,6 +125,8 @@ static struct ins x86__instructions[] = {
 	{ .name = "test",	.ops = &mov_ops,  },
 	{ .name = "testb",	.ops = &mov_ops,  },
 	{ .name = "testl",	.ops = &mov_ops,  },
+	{ .name = "testq",	.ops = &mov_ops,  },
+	{ .name = "tzcnt",	.ops = &mov_ops,  },
 	{ .name = "ucomisd",	.ops = &mov_ops,  },
 	{ .name = "ucomiss",	.ops = &mov_ops,  },
 	{ .name = "vaddsd",	.ops = &mov_ops,  },
-- 
2.40.1.521.gf1e218fcd8-goog

