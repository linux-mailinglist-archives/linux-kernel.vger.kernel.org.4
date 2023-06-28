Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65226740F5C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjF1Kx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:53:58 -0400
Received: from foss.arm.com ([217.140.110.172]:53596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbjF1KxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:53:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464F2113E;
        Wed, 28 Jun 2023 03:54:01 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.27.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 323833F663;
        Wed, 28 Jun 2023 03:53:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, acme@kernel.org,
        masahiroy@kernel.org, leo.yan@linaro.org, broonie@kernel.org,
        Aishwarya.TCV@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] perf tools: Add a place to put kernel config fragments for test runs
Date:   Wed, 28 Jun 2023 11:53:02 +0100
Message-Id: <20230628105303.4053478-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628105303.4053478-1-james.clark@arm.com>
References: <20230628105303.4053478-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defconfig doesn't give full coverage for a perf test run, so these can
be merged with defconfig to do so. It's not complete yet, but is a
starting point as a place to add to when a specific test needs something
extra to run.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/config-fragments/README |  7 +++++++
 tools/perf/tests/config-fragments/arm64  |  1 +
 tools/perf/tests/config-fragments/config | 11 +++++++++++
 3 files changed, 19 insertions(+)
 create mode 100644 tools/perf/tests/config-fragments/README
 create mode 100644 tools/perf/tests/config-fragments/arm64
 create mode 100644 tools/perf/tests/config-fragments/config

diff --git a/tools/perf/tests/config-fragments/README b/tools/perf/tests/config-fragments/README
new file mode 100644
index 000000000000..fe7de5d93674
--- /dev/null
+++ b/tools/perf/tests/config-fragments/README
@@ -0,0 +1,7 @@
+This folder is for kernel config fragments that can be merged with
+defconfig to give full test coverage of a perf test run. This is only
+an optimistic set as some features require hardware support in order to
+pass and not skip.
+
+'config' is shared across all platforms, and for arch specific files,
+the file name should match that used in the ARCH=... make option.
diff --git a/tools/perf/tests/config-fragments/arm64 b/tools/perf/tests/config-fragments/arm64
new file mode 100644
index 000000000000..64c4ab17cd58
--- /dev/null
+++ b/tools/perf/tests/config-fragments/arm64
@@ -0,0 +1 @@
+CONFIG_CORESIGHT_SOURCE_ETM4X=y
diff --git a/tools/perf/tests/config-fragments/config b/tools/perf/tests/config-fragments/config
new file mode 100644
index 000000000000..c340b3195fca
--- /dev/null
+++ b/tools/perf/tests/config-fragments/config
@@ -0,0 +1,11 @@
+CONFIG_TRACEPOINTS=y
+CONFIG_STACKTRACE=y
+CONFIG_NOP_TRACER=y
+CONFIG_RING_BUFFER=y
+CONFIG_EVENT_TRACING=y
+CONFIG_CONTEXT_SWITCH_TRACER=y
+CONFIG_TRACING=y
+CONFIG_GENERIC_TRACER=y
+CONFIG_FTRACE=y
+CONFIG_FTRACE_SYSCALLS=y
+CONFIG_BRANCH_PROFILE_NONE=y
-- 
2.34.1

