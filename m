Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACF974B491
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjGGPqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGGPqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:46:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 226C62121;
        Fri,  7 Jul 2023 08:46:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5AFDD75;
        Fri,  7 Jul 2023 08:46:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C87373F762;
        Fri,  7 Jul 2023 08:46:01 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, radhey.shyam.pandey@amd.com
Cc:     coresight@lists.linaro.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf build: Fix library not found error when using CSLIBS
Date:   Fri,  7 Jul 2023 16:45:46 +0100
Message-Id: <20230707154546.456720-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-L only specifies the search path for libraries directly provided in the
link line with -l. Because -lopencsd isn't specified, it's only linked
because it's a dependency of -lopencsd_c_api. Dependencies like this are
resolved using the default system search paths or -rpath-link=... rather
than -L. This means that compilation only works if OpenCSD is installed
to the system rather than provided with the CSLIBS (-L) option.

This could be fixed by adding -Wl,-rpath-link=$(CSLIBS) but that is less
conventional than just adding -lopencsd to the link line so that it uses
-L. -lopencsd seems to have been removed in commit ed17b1914978 ("perf
tools: Drop requirement for libstdc++.so for libopencsd check") because
it was thought that there was a chance compilation would work even if it
didn't exist, but I think that only applies to libstdc++ so there is no
harm to add it back. libopencsd.so and libopencsd_c_api.so would always
exist together.

Testing
=======

The following scenarios now all work:

 * Cross build with OpenCSD installed
 * Cross build using CSLIBS=...
 * Native build with OpenCSD installed
 * Native build using CSLIBS=...
 * Static cross build with OpenCSD installed
 * Static cross build with CSLIBS=...

Reported-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Closes: https://lore.kernel.org/linux-arm-kernel/56905d7a-a91e-883a-b707-9d5f686ba5f1@arm.com/
Link: https://lore.kernel.org/all/36cc4dc6-bf4b-1093-1c0a-876e368af183@kleine-koenig.org/
Fixes: ed17b1914978 ("perf tools: Drop requirement for libstdc++.so for libopencsd check")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.config | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0609c19caabd..c5db0de49868 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -155,9 +155,9 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
 ifdef CSINCLUDES
   LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
 endif
-OPENCSDLIBS := -lopencsd_c_api
+OPENCSDLIBS := -lopencsd_c_api -lopencsd
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  OPENCSDLIBS += -lopencsd -lstdc++
+  OPENCSDLIBS += -lstdc++
 endif
 ifdef CSLIBS
   LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
-- 
2.34.1

