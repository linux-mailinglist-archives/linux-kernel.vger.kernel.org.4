Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE975EF727
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbiI2OFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbiI2OF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:05:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881FF8C28;
        Thu, 29 Sep 2022 07:05:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6C42B824A1;
        Thu, 29 Sep 2022 14:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C743EC433C1;
        Thu, 29 Sep 2022 14:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664460320;
        bh=Q4jJh5UBgm14/k0p0SQTp+6cg7BoIH9gQ1RlsvJZTlc=;
        h=From:To:Cc:Subject:Date:From;
        b=oZm1wCR7PN6MFLGVGZzCgYKo5/tKwNxb3kg4hfADgT5SIn/M9+cujiOYS6Bo3PgY8
         6y0pUWNE6QKat2e9II7NBVmXVB9qOPolpDpAEKuHo3m8IvpzZkoBwZXfs5XOnNm/yB
         f/0P5qty6w20T7yayYD+L2CjMlDk4LMEt5OvEKIhtE9G1ZOaDZWQrfA0K3cRRDYIxO
         XZcMtJgG7+0EQPiYp1SRxqqVeTMYZyPiLHXcj5ticIXJg98wY6UrKWWf0bvDHrjd6o
         /CeP70tkxn3MYTzNGX8iZzm66ZDF0bUTwVEWEdzRohBjXVi7Lanyf37+uq3jesGC/c
         dKjvDaG/gWiGQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf tools: Fix bison object compilation with clang 15
Date:   Thu, 29 Sep 2022 16:05:13 +0200
Message-Id: <20220929140514.226807-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo reported compilation fail with clang 15:

    CC      util/parse-events-bison.o
  util/parse-events-bison.c:1401:9: error: variable 'parse_events_nerrs'
  set but not used [-Werror,-Wunused-but-set-variable]
      int yynerrs = 0;
        ^
  util/parse-events-bison.c:72:25: note: expanded from macro 'yynerrs'
  #define yynerrs         parse_events_nerrs
                        ^
  1 error generated.

Disabling -Wunused-but-set-variable check for bison object compilation.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/Build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 8fd6dc8de521..d559c80559e3 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -270,7 +270,7 @@ CFLAGS_expr-flex.o          += $(flex_flags)
 bison_flags := -DYYENABLE_NLS=0
 BISON_GE_35 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 35)
 ifeq ($(BISON_GE_35),1)
-  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum
+  bison_flags += -Wno-unused-parameter -Wno-nested-externs -Wno-implicit-function-declaration -Wno-switch-enum -Wno-unused-but-set-variable
 else
   bison_flags += -w
 endif
-- 
2.37.3

