Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C38618ADE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKCVyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiKCVyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:54:06 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED7F72035B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:54:04 -0700 (PDT)
Received: from BRIANROB-L1.corp.microsoft.com (unknown [131.107.174.60])
        by linux.microsoft.com (Postfix) with ESMTPSA id A9BCC20C28B1;
        Thu,  3 Nov 2022 14:54:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9BCC20C28B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667512444;
        bh=j7CAPnJQ6yORsfV2hVHDeUXOOBJzSel+8Y3+4Nb7FBY=;
        h=From:To:Cc:Subject:Date:From;
        b=p1StbKfWV/WnAJgyQJ3MnFQQfvZoBFbbARKbHxgYyZBdUpPYEzenUQdxvg1pmaORH
         AJst0xV9BrI/JzWbSEPciHYJYCfZ5+NjLjKTzYsxGswW8IsVFwMfKLmJSWQj4gkq+Y
         jsqhiQUSEbmxpohQ2KS8wRu64ddTf9YOjUwFYpkE=
From:   Brian Robbins <brianrob@linux.microsoft.com>
To:     stable@kernel.org
Cc:     brianrob@linux.microsoft.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf inject jit: Ignore memfd and anonymous mmap events if jitdump present
Date:   Thu,  3 Nov 2022 14:54:01 -0700
Message-Id: <20221103215401.219892-1-brianrob@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Requesting this be applied to all stable kernels where the commit in
Fixes: tag is present.  It is already in 6.0 kernels with cset SHA
46f7bd5e1b5732acb9b95037afd052a4d2eebb1a.

Some processes store jitted code in memfd mappings to avoid having rwx
mappings.  These processes map the code with a writeable mapping and a
read-execute mapping.  They write the code using the writeable mapping
and then unmap the writeable mapping.  All subsequent execution is
through the read-execute mapping.

perf inject --jit ignores //anon* mappings for each process where a
jitdump is present because it expects to inject mmap events for each
jitted code range, and said jitted code ranges will overlap with the
//anon* mappings.

Ignore /memfd: and [anon:* mappings so that jitted code contained in
/memfd: and [anon:* mappings is treated the same way as jitted code
contained in //anon* mappings.

Fixes: 46f7bd5e1b57 ("perf inject jit: Ignore memfd and anonymous mmap events if jitdump present")
Signed-off-by: Brian Robbins <brianrob@linux.microsoft.com>
Acked-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220805220645.95855-1-brianrob@linux.microsoft.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index a23255773c60..4e6632203704 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -845,8 +845,13 @@ jit_process(struct perf_session *session,
 	if (jit_detect(filename, pid, nsi)) {
 		nsinfo__put(nsi);
 
-		// Strip //anon* mmaps if we processed a jitdump for this pid
-		if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) == 0))
+		/*
+		 * Strip //anon*, [anon:* and /memfd:* mmaps if we processed a jitdump for this pid
+		 */
+		if (jit_has_pid(machine, pid) &&
+			((strncmp(filename, "//anon", 6) == 0) ||
+			 (strncmp(filename, "[anon:", 6) == 0) ||
+			 (strncmp(filename, "/memfd:", 7) == 0)))
 			return 1;
 
 		return 0;
-- 
2.25.1

