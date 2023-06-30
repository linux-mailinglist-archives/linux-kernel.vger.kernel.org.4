Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987857437F8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjF3JL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjF3JLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:11:55 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B192680;
        Fri, 30 Jun 2023 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1688116312;
  x=1719652312;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=4cKZGDaggu9U53oCy9qu6BEZZ+/3aZHSr1DqRIwuEcY=;
  b=YU/5ZUTHnRJwQBHU/32mHz7KUoJDHILJ+8WeNnv71VAYWkxGrkshrbzw
   7UJYQx3HQ4/eaFDuCcUzMPeWDuvb7KjV6Nh+d58BdQ27/O/y0owVFLS88
   OBLfsP3E0l7ucziNu6oj4gwqlldTKZrP4thdO7GrdV+s1F2Mzs7d9uJE3
   gO/7PfIiTSNvO2a9j0AJ1+xz6Gul5/k3GpZd6YEKzthRuHqlPiILH3hz3
   AAoIHjUTNpaM+U8tB9r24zeLT6bmIQuBDsKRpO7YpfKq8F6060KTFh5iC
   UJewWAEkk6c/DvodH+6qL+2S1omYwFwPPG4Ifb4wBxzaR+Fyy2+9V6Q9w
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 30 Jun 2023 11:11:48 +0200
Subject: [PATCH v2] perf: unwind: Fix symfs with libdw
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230630-perf-libdw-symfs-v2-1-469760dd4d5b@axis.com>
X-B4-Tracking: v=1; b=H4sIAFOcnmQC/zWNzQ6CMBCEX8X07BJY/sST72E8lHZrN5GWtAgYw
 rtbTDzM4Zvkm9lEpMAUxfW0iUAzR/YuAZ5PQlnpngSsEwvMscybMoeRgoEX93qB+BlMhE7qHjt
 TadNqkbReRoI+SKfsIRrvm6MeAxlef0/3R2IT/ACTDST/+1gUWKe0VZkhXuq27qCAmZ0iN2WL5
 UnZd1D2JleOmfKD2Pcv+zZIAsAAAAA=
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
I posted this last year but didn't receive any comments.  This patch is
still needed in current mainline so here is a rebased version, fixing
some merge conflicts.

Changes in v2:
- Rebased to v6.4.
- Link to v1: https://lore.kernel.org/lkml/20221125112743.2285759-1-vincent.whitchurch@axis.com/
---
 tools/perf/util/unwind-libdw.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index bdccfc511b7e2..30a63d819d74e 100644
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
 				      map__start(al->map) - map__pgoff(al->map), false);
+	}
 	if (!mod) {
 		char filename[PATH_MAX];
 

---
base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1
change-id: 20230630-perf-libdw-symfs-9adb29f4df7d

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

