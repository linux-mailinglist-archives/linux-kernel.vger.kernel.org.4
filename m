Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080645B8298
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiINIDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiINICb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:02:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFAE72FDE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 01:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663142529; x=1694678529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sYDk3njobQPmmB4ASleMB/Ig33xRGDX/XnXmi4n6FGg=;
  b=ngViOJf78NWAUP+FiTNRyKRPCQKNpAfDDZedL5W8T6fJiz+wdSzcwMoB
   pZUkWbLmeUm0RO59V6kNudRIoHxa3i0keGx06pEXlGMyluKIk8pFDIdP6
   jClGCzC8BQZKxBgOix4ZSUf0HnnYSMAnWZPILsoz+wF7MWwY1FkyJbE8o
   a3VmWu/ZKyzjABDiTDKB5Ibewv76fJCAimWqvbndRsNaju3kJmsU1n4fd
   8uTsEY1EANYWSAFO2D39aosC4M8zojiEqzVDL5P//JEn8WdsANIl2ITJ7
   t6xpaaJ4XVcS8MxgrcoQHajy61vLBws2Q0knwlmsSkWJC19pFi7bXN8Xo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="295953256"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="295953256"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:02:07 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="678942523"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.32.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 01:02:05 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf test: waiting.sh: Parameterize timeouts
Date:   Wed, 14 Sep 2022 11:01:50 +0300
Message-Id: <20220914080150.5888-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914080150.5888-1-adrian.hunter@intel.com>
References: <20220914080150.5888-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let helper functions accept a parameter to specify time out values in
tenths of a second.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/lib/waiting.sh | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/lib/waiting.sh b/tools/perf/tests/shell/lib/waiting.sh
index dbd5bd90105e..e7a39134a68e 100644
--- a/tools/perf/tests/shell/lib/waiting.sh
+++ b/tools/perf/tests/shell/lib/waiting.sh
@@ -3,16 +3,18 @@
 tenths=date\ +%s%1N
 
 # Wait for PID $1 to have $2 number of threads started
+# Time out after $3 tenths of a second or 5 seconds if $3 is ""
 wait_for_threads()
 {
+	tm_out=$3 ; [ -n "${tm_out}" ] || tm_out=50
 	start_time=$($tenths)
 	while [ -e "/proc/$1/task" ] ; do
 		th_cnt=$(find "/proc/$1/task" -mindepth 1 -maxdepth 1 -printf x | wc -c)
 		if [ "${th_cnt}" -ge "$2" ] ; then
 			return 0
 		fi
-		# Wait at most 5 seconds
-		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
+		# Wait at most tm_out tenths of a second
+		if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
 			echo "PID $1 does not have $2 threads"
 			return 1
 		fi
@@ -22,8 +24,10 @@ wait_for_threads()
 
 # Wait for perf record -vvv 2>$2 with PID $1 to start by looking at file $2
 # It depends on capturing perf record debug message "perf record has started"
+# Time out after $3 tenths of a second or 5 seconds if $3 is ""
 wait_for_perf_to_start()
 {
+	tm_out=$3 ; [ -n "${tm_out}" ] || tm_out=50
 	echo "Waiting for \"perf record has started\" message"
 	start_time=$($tenths)
 	while [ -e "/proc/$1" ] ; do
@@ -31,8 +35,8 @@ wait_for_perf_to_start()
 			echo OK
 			break
 		fi
-		# Wait at most 5 seconds
-		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
+		# Wait at most tm_out tenths of a second
+		if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
 			echo "perf recording did not start"
 			return 1
 		fi
@@ -41,12 +45,14 @@ wait_for_perf_to_start()
 }
 
 # Wait for process PID %1 to exit
+# Time out after $2 tenths of a second or 5 seconds if $2 is ""
 wait_for_process_to_exit()
 {
+	tm_out=$2 ; [ -n "${tm_out}" ] || tm_out=50
 	start_time=$($tenths)
 	while [ -e "/proc/$1" ] ; do
-		# Wait at most 5 seconds
-		if [ $(($($tenths) - start_time)) -ge 50 ] ; then
+		# Wait at most tm_out tenths of a second
+		if [ $(($($tenths) - start_time)) -ge $tm_out ] ; then
 			echo "PID $1 did not exit as expected"
 			return 1
 		fi
@@ -54,13 +60,15 @@ wait_for_process_to_exit()
 	return 0
 }
 
-# Check if PID $1 is still running after 0.3 seconds
+# Check if PID $1 is still running after $2 tenths of a second
+# or 0.3 seconds if $2 is ""
 is_running()
 {
+	tm_out=$2 ; [ -n "${tm_out}" ] || tm_out=3
 	start_time=$($tenths)
 	while [ -e "/proc/$1" ] ; do
-		# Check for at least 0.3s
-		if [ $(($($tenths) - start_time)) -gt 3 ] ; then
+		# Check for at least tm_out tenths of a second
+		if [ $(($($tenths) - start_time)) -gt $tm_out ] ; then
 			return 0
 		fi
 	done
-- 
2.25.1

