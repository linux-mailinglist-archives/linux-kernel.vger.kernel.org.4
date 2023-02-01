Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B676870B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjBAVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbjBAVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:50:50 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81BA86BF;
        Wed,  1 Feb 2023 13:50:46 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 7CDE3240002;
        Wed,  1 Feb 2023 21:50:42 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Carsten Haitzler <carsten.haitzler@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 2/2] perf test: Replace legacy `...` with $(...)
Date:   Wed,  1 Feb 2023 22:49:45 +0100
Message-Id: <20230201214945.127474-3-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201214945.127474-1-didi.debian@cknow.org>
References: <20230201214945.127474-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As detailed in https://www.shellcheck.net/wiki/SC2006:

The use of `...` is legacy syntax with several issues:
1. It has a series of undefined behaviors related to quoting in POSIX.
2. It imposes a custom escaping mode with surprising results.
3. It's exceptionally hard to nest.

$(...) command substitution has none of these problems,
and is therefore strongly encouraged.

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 tools/perf/tests/shell/lib/coresight.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
index 7e27e5c5bc9c..6c3d34ec64d8 100644
--- a/tools/perf/tests/shell/lib/coresight.sh
+++ b/tools/perf/tests/shell/lib/coresight.sh
@@ -58,9 +58,9 @@ perf_dump_aux_verify() {
 	# compiler may produce different code depending on the compiler and
 	# optimization options, so this is rough just to see if we're
 	# either missing almost all the data or all of it
-	ATOM_FX_NUM=`grep -c I_ATOM_F "$DUMP"`
-	ASYNC_NUM=`grep -c I_ASYNC "$DUMP"`
-	TRACE_INFO_NUM=`grep -c I_TRACE_INFO "$DUMP"`
+	ATOM_FX_NUM=$(grep -c I_ATOM_F "$DUMP")
+	ASYNC_NUM=$(grep -c I_ASYNC "$DUMP")
+	TRACE_INFO_NUM=$(grep -c I_TRACE_INFO "$DUMP")
 	rm -f "$DUMP"
 
 	# Arguments provide minimums for a pass
@@ -96,18 +96,18 @@ perf_dump_aux_tid_verify() {
 
 	# The TID test tools will print a TID per stdout line that are being
 	# tested
-	TIDS=`cat "$2"`
+	TIDS=$(cat "$2")
 	# Scan the perf report to find the TIDs that are actually CID in hex
 	# and build a list of the ones found
-	FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
+	FOUND_TIDS=$(perf report --stdio --dump -i "$1" | \
 			grep -o "CID=0x[0-9a-z]\+" | sed 's/CID=//g' | \
-			uniq | sort | uniq`
+			uniq | sort | uniq)
 	# No CID=xxx found - maybe your kernel is reporting these as
 	# VMID=xxx so look there
 	if test -z "$FOUND_TIDS"; then
-		FOUND_TIDS=`perf report --stdio --dump -i "$1" | \
+		FOUND_TIDS=$(perf report --stdio --dump -i "$1" | \
 				grep -o "VMID=0x[0-9a-z]\+" | sed 's/VMID=//g' | \
-				uniq | sort | uniq`
+				uniq | sort | uniq)
 	fi
 
 	# Iterate over the list of TIDs that the test says it has and find
@@ -116,7 +116,7 @@ perf_dump_aux_tid_verify() {
 	for TID2 in $TIDS; do
 		FOUND=""
 		for TIDHEX in $FOUND_TIDS; do
-			TID=`printf "%i" $TIDHEX`
+			TID=$(printf "%i" $TIDHEX)
 			if test "$TID" -eq "$TID2"; then
 				FOUND="y"
 				break
-- 
2.39.1

