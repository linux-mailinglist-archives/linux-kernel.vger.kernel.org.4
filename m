Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24D072D4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbjFLXAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 19:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjFLXAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 19:00:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24475C0;
        Mon, 12 Jun 2023 16:00:30 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b3b5a5134bso14775735ad.1;
        Mon, 12 Jun 2023 16:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686610829; x=1689202829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X6hTdZSx7lI19BPB+NC6SvmJWqew8gyLq/5fpHGrdNU=;
        b=s1STHSznp+8S8Qi+hRTW0MHhtF44u2FX+cRnVYL4zFZEMvG3FxkmdlQ9h1cn4IKbkF
         CkEVgF1xmCWSEFHHNytRYJMLQcepjAUJA99UbV3CD1OqZPsoFY7XsD4nDQckdh+xa/Pp
         cBhxUWjQYt93PwywYvQYinGLZn/eMYSuNTndRV6QLOy1B6qxBIow6IbcibUbKm9HRcwS
         SuoaW8cuTJgUZ8ZzEdJT4K9TpAjjy+8Jl7+2BP+sssXQxKkDutaiBfNb8YAZKkDLrixO
         i3d6FbQAMHAikGDY88bBrTfHLMSbnUuz5QXeFvl08nyQ76AVqlVGnw+U4wMLolx6YIQe
         5Ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686610829; x=1689202829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6hTdZSx7lI19BPB+NC6SvmJWqew8gyLq/5fpHGrdNU=;
        b=ijGAe4znHdt9+raHsWGzWUaTvB/jdlQa1lzVMvkVcTzHo3ev//jDow72D48zkWjJj+
         NIgVk9S+3Rn/yhtXJRsGPE+/alx7uJib8shDoplwCLeOX5uVnFjnh960O9CGntSmuBMM
         PeySsZ/8jBBDdFHTLPc9oKkNTkauAOlqKqG6u01N4+COLXRn700AA+rrWrZumEDPu1/d
         7XOjMS7lc8dOt7fbPVzl9nEHthvlR5UGU663BoE+rCQ0w5RkktZn26OW8qetkDc8t0Te
         9yNK4r2vDwPTLkpdXLaE8RXbntIaa/ISnwYEmyeqPfRhgCmNaZCxf5wEAOHZip4fuPM5
         RPkQ==
X-Gm-Message-State: AC+VfDwJAH/SBvSvK6eI18ro89KiyJdN4gJYRzgmWG4ixR+eiG3UOiol
        PNU9Uwm+yf6AgPGDgkf4z9A=
X-Google-Smtp-Source: ACHHUZ4Jbxl5JBhzMIwNbqJ2wmLJxK9hOPt+FezdqhNpze8ySOT9k1dSFnokZLsEu7sS4pbVyGDAGQ==
X-Received: by 2002:a17:902:b949:b0:1af:b97c:2353 with SMTP id h9-20020a170902b94900b001afb97c2353mr6873421pls.15.1686610829423;
        Mon, 12 Jun 2023 16:00:29 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:1e19:385a:b5d0:f4a2])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001b03a1a3151sm8841409plg.70.2023.06.12.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 16:00:28 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] perf annotate: Allow whitespace between insn operands
Date:   Mon, 12 Jun 2023 16:00:26 -0700
Message-ID: <20230612230026.3887586-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

The llvm-objdump adds a space between the operands while GNU objdump
does not.  Allow a space to handle the both.

In GNU objdump:

  Disassembly of section .text:                                      here
                                                                      |
  ffffffff81000000 <_stext>:                                          v
  ffffffff81000000:	48 8d 25 51 1f 40 01 	lea    0x1401f51(%rip),%rsp
  ffffffff81000007:	e8 d4 00 00 00       	call   ffffffff810000e0 <verify_cpu>
  ffffffff8100000c:	48 8d 3d ed ff ff ff 	lea    -0x13(%rip),%rdi

In llvm-objdump:

  Disassembly of section .text:                                      here
                                                                       |
  ffffffff81000000 <startup_64>:                                       v
  ffffffff81000000: 48 8d 25 51 1f 40 01 	leaq	20979537(%rip), %rsp
  ffffffff81000007: e8 d4 00 00 00       	callq	0xffffffff810000e0 <verify_cpu>
  ffffffff8100000c: 48 8d 3d ed ff ff ff 	leaq	-19(%rip), %rdi

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9171102dd3ad..3eab6c29eaa5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -585,7 +585,7 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
 	if (ops->source.raw == NULL)
 		return -1;
 
-	target = ++s;
+	target = skip_spaces(++s);
 	comment = strchr(s, arch->objdump.comment_char);
 
 	if (comment != NULL)
-- 
2.41.0.162.gfafddb0af9-goog

