Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24496388B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKYL1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKYL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:27:48 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852FF08;
        Fri, 25 Nov 2022 03:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669375667;
  x=1700911667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6RwO0n+pzzOhCsDKCSVeKrBpyMVuCVb4JiVVtM5sYu4=;
  b=pwHCbBbeukyXnq5WdhibKNMqILv/3oNZENB5q/WzOkjsO9VLbGULNFoX
   O/w8YPpYzRdLodVL4+Kiv6+uWLPpPxm5snUoKfawJHHX2g11uBI9Xso5o
   o9+971M1svpPjjhIyAGKbUzhLr1cu/TC9LR+yxUWOMytDkHOsfhdy2qJH
   XuIY5riI3UOwzugDf53UhteALEyJHrqqw8X7i9ELSO0WHE39mx19F9Ama
   +35kRnZIB+NQOMavTBUr9z1xlNitn1YOznuVAeOaESkBmfnwPfIlE9Un0
   EmrPLwpaJsCMpSbZWLhZ5f7vPr/HzXBvypTTr/m9vb/bYXV9hiVpDSn0q
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf: unwind: Fix symfs with libdw
Date:   Fri, 25 Nov 2022 12:27:42 +0100
Message-ID: <20221125112743.2285759-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass the full path including the symfs (if any) to libdw.  Without this
unwinding fails with errors like this when a symfs is used:

  unwind: failed with 'No such file or directory'"

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 tools/perf/util/unwind-libdw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 94aa40f6e348..1915c9769dbe 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -66,9 +66,13 @@ static int __report_module(struct addr_location *al, u64 ip,
 			mod = 0;
 	}
 
-	if (!mod)
-		mod = dwfl_report_elf(ui->dwfl, dso->short_name, dso->long_name, -1,
+	if (!mod) {
+		char filename[PATH_MAX];
+
+		__symbol__join_symfs(filename, sizeof(filename), dso->long_name);
+		mod = dwfl_report_elf(ui->dwfl, dso->short_name, filename, -1,
 				      al->map->start - al->map->pgoff, false);
+	}
 	if (!mod) {
 		char filename[PATH_MAX];
 
-- 
2.34.1

