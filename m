Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2205EABEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiIZQDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiIZQC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:02:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F53C7D7A5;
        Mon, 26 Sep 2022 07:50:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 400511063;
        Mon, 26 Sep 2022 07:50:27 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.0.51])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9F643F66F;
        Mon, 26 Sep 2022 07:50:18 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/1] perf test: Fix attr tests for PERF_FORMAT_LOST
Date:   Mon, 26 Sep 2022 15:49:47 +0100
Message-Id: <20220926144948.223641-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220926144948.223641-1-james.clark@arm.com>
References: <20220926144948.223641-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since PERF_FORMAT_LOST was added, the default read format has that bit
set, so add it to the tests. When running on an older kernel the tests
will still fail because Perf will not set that bit.

This fixes the following failure:

  expected read_format=0|4, got 20
  FAILED './tests/attr/test-record-C0' - match failure

Fixes: 85b425f31c88 ("perf record: Set PERF_FORMAT_LOST by default")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/tests/attr/base-record                | 2 +-
 tools/perf/tests/attr/system-wide-dummy          | 2 +-
 tools/perf/tests/attr/test-record-group          | 4 ++--
 tools/perf/tests/attr/test-record-group-sampling | 6 +++---
 tools/perf/tests/attr/test-record-group1         | 4 ++--
 tools/perf/tests/attr/test-record-group2         | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 8c10955eff93..9758e22daf9c 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -9,7 +9,7 @@ size=128
 config=0
 sample_period=*
 sample_type=263
-read_format=0|4
+read_format=0|20
 disabled=1
 inherit=1
 pinned=0
diff --git a/tools/perf/tests/attr/system-wide-dummy b/tools/perf/tests/attr/system-wide-dummy
index 86a15dd359d9..0df8a997fe51 100644
--- a/tools/perf/tests/attr/system-wide-dummy
+++ b/tools/perf/tests/attr/system-wide-dummy
@@ -11,7 +11,7 @@ size=128
 config=9
 sample_period=4000
 sample_type=455
-read_format=4
+read_format=20
 # Event will be enabled right away.
 disabled=0
 inherit=1
diff --git a/tools/perf/tests/attr/test-record-group b/tools/perf/tests/attr/test-record-group
index 14ee60fd3f41..09aa40af841c 100644
--- a/tools/perf/tests/attr/test-record-group
+++ b/tools/perf/tests/attr/test-record-group
@@ -7,14 +7,14 @@ ret     = 1
 fd=1
 group_fd=-1
 sample_type=327
-read_format=4
+read_format=20
 
 [event-2:base-record]
 fd=2
 group_fd=1
 config=1
 sample_type=327
-read_format=4
+read_format=20
 mmap=0
 comm=0
 task=0
diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index 300b9f7e6d69..3ad68c3405c8 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -7,7 +7,7 @@ ret     = 1
 fd=1
 group_fd=-1
 sample_type=343
-read_format=12
+read_format=28
 inherit=0
 
 [event-2:base-record]
@@ -21,8 +21,8 @@ config=3
 # default | PERF_SAMPLE_READ
 sample_type=343
 
-# PERF_FORMAT_ID | PERF_FORMAT_GROUP
-read_format=12
+# PERF_FORMAT_ID | PERF_FORMAT_GROUP  | PERF_FORMAT_LOST
+read_format=28
 task=0
 mmap=0
 comm=0
diff --git a/tools/perf/tests/attr/test-record-group1 b/tools/perf/tests/attr/test-record-group1
index 3ffe246e0228..53e1ba38febc 100644
--- a/tools/perf/tests/attr/test-record-group1
+++ b/tools/perf/tests/attr/test-record-group1
@@ -7,7 +7,7 @@ ret     = 1
 fd=1
 group_fd=-1
 sample_type=327
-read_format=4
+read_format=20
 
 [event-2:base-record]
 fd=2
@@ -15,7 +15,7 @@ group_fd=1
 type=0
 config=1
 sample_type=327
-read_format=4
+read_format=20
 mmap=0
 comm=0
 task=0
diff --git a/tools/perf/tests/attr/test-record-group2 b/tools/perf/tests/attr/test-record-group2
index 6b9f8d182ce1..ca21b5ce71aa 100644
--- a/tools/perf/tests/attr/test-record-group2
+++ b/tools/perf/tests/attr/test-record-group2
@@ -9,7 +9,7 @@ group_fd=-1
 config=0|1
 sample_period=1234000
 sample_type=87
-read_format=12
+read_format=28
 inherit=0
 freq=0
 
@@ -19,7 +19,7 @@ group_fd=1
 config=0|1
 sample_period=6789000
 sample_type=87
-read_format=12
+read_format=28
 disabled=0
 inherit=0
 mmap=0
-- 
2.28.0

