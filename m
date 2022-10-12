Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571735FC421
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJLLKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJLLKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:10:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FF6E92F4F;
        Wed, 12 Oct 2022 04:10:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48D85D6E;
        Wed, 12 Oct 2022 04:10:41 -0700 (PDT)
Received: from e121896.Emea.Arm.com (e121896.Emea.Arm.com [10.32.36.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EA3C3F792;
        Wed, 12 Oct 2022 04:10:31 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf: Fix "Track with sched_switch" test by not printing warnings in quiet mode
Date:   Wed, 12 Oct 2022 12:10:24 +0100
Message-Id: <20221012111025.30609-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Especially when CONFIG_LOCKDEP and other debug configs are enabled,
Perf can print the following warning when running the "Track with
sched_switch" test:

  Warning:
  Processed 1378918 events and lost 4 chunks!

  Check IO/CPU overload!

  Warning:
  Processed 4593325 samples and lost 70.00%!

The test already supplies -q to run in quiet mode, so extend quiet mode
to perf_stdio__warning() and also ui__warning() for consistency.

This fixes the following failure due to the extra lines counted:

  perf test "lock cont" -vvv

  82: kernel lock contention analysis test                            :
  --- start ---
  test child forked, pid 3125
  Testing perf lock record and perf lock contention
  [Fail] Recorded result count is not 1: 9
  test child finished with -1
  ---- end ----
  kernel lock contention analysis test: FAILED!

Fixes: ec685de25b67 ("perf test: Add kernel lock contention test")
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/ui/util.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/ui/util.c b/tools/perf/ui/util.c
index 689b27c34246..1d38ddf01b60 100644
--- a/tools/perf/ui/util.c
+++ b/tools/perf/ui/util.c
@@ -15,6 +15,9 @@ static int perf_stdio__error(const char *format, va_list args)
 
 static int perf_stdio__warning(const char *format, va_list args)
 {
+	if (quiet)
+		return 0;
+
 	fprintf(stderr, "Warning:\n");
 	vfprintf(stderr, format, args);
 	return 0;
@@ -45,6 +48,8 @@ int ui__warning(const char *format, ...)
 {
 	int ret;
 	va_list args;
+	if (quiet)
+		return 0;
 
 	va_start(args, format);
 	ret = perf_eops->warning(format, args);
-- 
2.28.0

