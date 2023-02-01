Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DB26870B6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBAVul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:50:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBAVuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:50:39 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277264C1E;
        Wed,  1 Feb 2023 13:50:37 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 7B04F240008;
        Wed,  1 Feb 2023 21:50:32 +0000 (UTC)
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
Subject: [PATCH 1/2] perf test: Replace 'grep | wc -l' with 'grep -c'
Date:   Wed,  1 Feb 2023 22:49:44 +0100
Message-Id: <20230201214945.127474-2-didi.debian@cknow.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201214945.127474-1-didi.debian@cknow.org>
References: <20230201214945.127474-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To count the number of results from grep, use the '-c' parameter
instead of piping it to 'wc'.
See also https://www.shellcheck.net/wiki/SC2126

Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 tools/perf/tests/shell/lib/coresight.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/coresight.sh b/tools/perf/tests/shell/lib/coresight.sh
index 45a1477256b6..7e27e5c5bc9c 100644
--- a/tools/perf/tests/shell/lib/coresight.sh
+++ b/tools/perf/tests/shell/lib/coresight.sh
@@ -58,9 +58,9 @@ perf_dump_aux_verify() {
 	# compiler may produce different code depending on the compiler and
 	# optimization options, so this is rough just to see if we're
 	# either missing almost all the data or all of it
-	ATOM_FX_NUM=`grep I_ATOM_F "$DUMP" | wc -l`
-	ASYNC_NUM=`grep I_ASYNC "$DUMP" | wc -l`
-	TRACE_INFO_NUM=`grep I_TRACE_INFO "$DUMP" | wc -l`
+	ATOM_FX_NUM=`grep -c I_ATOM_F "$DUMP"`
+	ASYNC_NUM=`grep -c I_ASYNC "$DUMP"`
+	TRACE_INFO_NUM=`grep -c I_TRACE_INFO "$DUMP"`
 	rm -f "$DUMP"
 
 	# Arguments provide minimums for a pass
-- 
2.39.1

