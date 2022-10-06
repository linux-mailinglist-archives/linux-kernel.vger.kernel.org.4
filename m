Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3535F7115
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJFWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiJFWWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:22:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55075183ECA;
        Thu,  6 Oct 2022 15:22:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id v186so3295762pfv.11;
        Thu, 06 Oct 2022 15:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jhNrOzEJoHpU7L6T/hd/++SuohbRXsLLnzlQMkHYgSg=;
        b=PSjgMXZgkNKvJj3wjg6DvE1cSQ9X9HDA5c6jHPgYlYPZMlNnywOSeC3o3ZC/IaEfxv
         LjAic3Fbg37rjHZ56XKDwmqojKOTtR/Yxxy3sAyX1dNLad7Bl1PTgOVj81JD2+Dl8KpW
         SfAzngPxTMj0GdjTdbZjSM32sDwyu0+WDzQixcSRBx2tCozNf/HR/zW/54IpEr0rHs78
         q6qHZFKBsCkmzE7I7jdhWQ1iz8vB+BgVTJqyK3nMCdoUGT2wy2lpZSqDrFXk4QU47Hup
         KXFuLlwIOdbfWyA0KaeokDo1lXfJkBo1QJPIPQ81kW8E1tUanoMati6ujtgtbRK16xoy
         DQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhNrOzEJoHpU7L6T/hd/++SuohbRXsLLnzlQMkHYgSg=;
        b=6aPF19g8ZJTUvy77UlnjaV0xoJERb1xs/dBQGRSHzDOXJMKtRQ7tzWC+TDkp+ifF41
         sbTwGQyHc8ZoSirOjo2WSn+7zNOo6hL9+AjwgL/EVRS60apne8dAxUmML7h9Nbh/WvFb
         udDFlt+ramQhTRKKbk+92513Liu6S2ykGEpdSWgorOvQZdprtzC4sKeIgXbkNqnthvtr
         iSxX/V8DD6cQSUfDHky5sv89zE0AKji3iaP2DVOUBbQKJo+n3eSQIS53DOnD8GaViLOk
         OvxugBxlwllRHLyBbAI6riAeuVcCXMqcgYLjBx1VjRxcdX4StTGHcQrkp8unlWPgDe1R
         GV4Q==
X-Gm-Message-State: ACrzQf0XE0lfAMVDLnt6Zv+P0gQOfA5SzbaIAhIcO3V8ipT2A8Mh54UP
        ozyVgS7DufBhpkR4Yu5WRVI=
X-Google-Smtp-Source: AMsMyM4FI92O4/hYG1/GICks/lXFq/NcfMStg/5hJCSa2wF26GIFvpc40RLDxUT+oimKtEWHSJNOKQ==
X-Received: by 2002:a05:6a02:202:b0:42b:d711:f27c with SMTP id bh2-20020a056a02020200b0042bd711f27cmr1739168pgb.246.1665094955773;
        Thu, 06 Oct 2022 15:22:35 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1ec5:e390:bb36:a4ba])
        by smtp.gmail.com with ESMTPSA id c82-20020a624e55000000b0056265011136sm116988pfb.112.2022.10.06.15.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 15:22:35 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Kevin Nomura <nomurak@google.com>
Subject: [PATCH] perf annotate: Add missing condition flags for arm64
Date:   Thu,  6 Oct 2022 15:22:32 -0700
Message-Id: <20221006222232.266416-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the document [1], it can also have 'hs', 'lo', 'vc', 'vs' as a
condition code.  Let's add them too.

[1] https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/condition-codes-1-condition-flags-and-codes

Reported-by: Kevin Nomura <nomurak@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/arm64/annotate/instructions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
index 037e292ecd8e..4af0c3a0f86e 100644
--- a/tools/perf/arch/arm64/annotate/instructions.c
+++ b/tools/perf/arch/arm64/annotate/instructions.c
@@ -102,7 +102,7 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
 	if (err)
 		goto out_free_arm;
 	/* b, b.cond, br, cbz/cbnz, tbz/tbnz */
-	err = regcomp(&arm->jump_insn, "^[ct]?br?\\.?(cc|cs|eq|ge|gt|hi|le|ls|lt|mi|ne|pl)?n?z?$",
+	err = regcomp(&arm->jump_insn, "^[ct]?br?\\.?(cc|cs|eq|ge|gt|hi|hs|le|lo|ls|lt|mi|ne|pl|vc|vs)?n?z?$",
 		      REG_EXTENDED);
 	if (err)
 		goto out_free_call;
-- 
2.38.0.rc1.362.ged0d419d3c-goog

