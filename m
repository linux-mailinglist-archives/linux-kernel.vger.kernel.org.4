Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D28B6119D1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJ1SBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 14:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJ1SBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 14:01:36 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1DD20FB1D;
        Fri, 28 Oct 2022 11:01:35 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso10527919pjz.4;
        Fri, 28 Oct 2022 11:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRaWyTNG36H59bEp88dgewnNjHxw44C35a4VhyGtZjQ=;
        b=MWTjbjOl5lZi7Xu1Znd5gj0cW3FkMbJFkKKN/mVYofTaIK7sVXhT07pR31GWyqOnl/
         9SR9oSl2m4vw2H4zyeFubiK4coIylPo2pQNNzjHz0tDkBNkP+6C/qnBqSof6VUXLPaM1
         D12+rnxDSHhTSMvXTWP4wOoBjBM1Q4c0zz2zas65ePGiwPNVyeN9UfUGHLOD9IdlHKt0
         mWWr0YMIXY+25RgHy0noTUbYAnCaqxJ1qDtctIxR3qCOtT7kS1SIZTRedRAHPkpUIgDa
         AkSKwuY3lm2Rd54tzk9rXY18qB2SzAQf0s+zdI8gEGd1SfjBhN9LNtaNocTvUlJUdDoX
         NbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RRaWyTNG36H59bEp88dgewnNjHxw44C35a4VhyGtZjQ=;
        b=J/8IIb9V+wdyZMtqP6JaMxgUX1oP/ppuCu2p8B3u+7ygbKRhRbSKhPQ/W2wqq9dCFP
         2bFWkuvjN7yPGYFDRsC/lxtSupdd4bpq2yG1DqgPwNrIsNxJ/Dd1bueuDL61akX2v+A3
         hu4kx/Rkjxwznbh80BTEwlX54XYUcv83jziwSPqvkpDN1kCOA6AjznF5Bv+kAsyKa+Ix
         Up42Mtaqv6XgdRX/l7wOf2drt9ce0Pkcn8aYdPVVrgonPTKuWCqR6xalI7amXNvSK0k+
         UjYFSZ9NdCPS0F4+1ZwCtqEKhajWJf0Cw9JgpR/NsdiohAgl4WwGPC5KQC46MjRn+Zwq
         IDRQ==
X-Gm-Message-State: ACrzQf3jN1uCD2Rx8dBRG83/q3Yb5HkQ8YVwZ/4oazp6HkQBbAcEGFks
        niavH8x0MSP4o6AVTD8bCZ8=
X-Google-Smtp-Source: AMsMyM6r0qYzt6JLtN3tJ9YK3WpjzmR5jceTXdkdKOG21sqTVszZBLHMDbSR/AFDINwyJMNx4Xy8+g==
X-Received: by 2002:a17:902:f710:b0:184:7a4c:fdc1 with SMTP id h16-20020a170902f71000b001847a4cfdc1mr186767plo.27.1666980095311;
        Fri, 28 Oct 2022 11:01:35 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:976f:f075:7c14:87a2])
        by smtp.gmail.com with ESMTPSA id n3-20020a170903110300b00186b86ed450sm3400236plh.156.2022.10.28.11.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 11:01:34 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] perf lock contention: Check --max-stack option
Date:   Fri, 28 Oct 2022 11:01:26 -0700
Message-Id: <20221028180128.3311491-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221028180128.3311491-1-namhyung@kernel.org>
References: <20221028180128.3311491-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --max-stack option is used to allocate the BPF stack map and stack
trace array in the userspace.  Check the value properly before using.
Practically it cannot be greater than the sysctl_perf_event_max_stack.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 9722d4ab2e55..f67db60f1de6 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -24,6 +24,7 @@
 #include "util/data.h"
 #include "util/string2.h"
 #include "util/map.h"
+#include "util/util.h"
 
 #include <sys/types.h>
 #include <sys/prctl.h>
@@ -1858,6 +1859,29 @@ static int parse_map_entry(const struct option *opt, const char *str,
 	return 0;
 }
 
+static int parse_max_stack(const struct option *opt, const char *str,
+			   int unset __maybe_unused)
+{
+	unsigned long *len = (unsigned long *)opt->value;
+	long val;
+	char *endptr;
+
+	errno = 0;
+	val = strtol(str, &endptr, 0);
+	if (*endptr != '\0' || errno != 0) {
+		pr_err("invalid max stack depth: %s\n", str);
+		return -1;
+	}
+
+	if (val < 0 || val > sysctl__max_stack()) {
+		pr_err("invalid max stack depth: %ld\n", val);
+		return -1;
+	}
+
+	*len = val;
+	return 0;
+}
+
 int cmd_lock(int argc, const char **argv)
 {
 	const struct option lock_options[] = {
@@ -1913,9 +1937,9 @@ int cmd_lock(int argc, const char **argv)
 		   "Trace on existing thread id (exclusive to --pid)"),
 	OPT_CALLBACK(0, "map-nr-entries", &bpf_map_entries, "num",
 		     "Max number of BPF map entries", parse_map_entry),
-	OPT_INTEGER(0, "max-stack", &max_stack_depth,
-		    "Set the maximum stack depth when collecting lock contention, "
-		    "Default: " __stringify(CONTENTION_STACK_DEPTH)),
+	OPT_CALLBACK(0, "max-stack", &max_stack_depth, "num",
+		     "Set the maximum stack depth when collecting lopck contention, "
+		     "Default: " __stringify(CONTENTION_STACK_DEPTH), parse_max_stack),
 	OPT_INTEGER(0, "stack-skip", &stack_skip,
 		    "Set the number of stack depth to skip when finding a lock caller, "
 		    "Default: " __stringify(CONTENTION_STACK_SKIP)),
-- 
2.38.1.273.g43a17bfeac-goog

