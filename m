Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C466388F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 12:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKYLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 06:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYLmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 06:42:20 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BBB1E3F6;
        Fri, 25 Nov 2022 03:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1669376539;
  x=1700912539;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JhyzSfrrReVX0sQCzaa5uP5Ld+NNauN2KVzxad0wMJA=;
  b=aaxAm7XTJ3oP5MIs8no/Lz5/MiNXLM4WVCG+f9VE7jnk/2T0EWYOBmzD
   SMnOePRCp+n+DQpYNeZYu1qZO747H2RkVWALh39sn/wi1jMfJwVRkQhwy
   EFSlVrRpfFOZUA+SBLwRFVyr8B1l7YZdwujYDIWzyWTypXpc+c+K5C+OY
   WyCiUQlcuzbpH1N/G4fYsetXX4F8a62qSSQckUDPIPkycc//Yr/2GDtFL
   kVbuhl3EM08s1QOalPdXG2ouZmS+pJl+KpWYerAd4azPPrWqOpE0Q8Zq6
   /+WmHuEFJlXZ6/Dinbpt7RL0X9fW7BcMbeesVIRkaeqrq3owkU41h2dSc
   Q==;
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
Subject: [PATCH] perf annotate: Work with vmlinux outside symfs
Date:   Fri, 25 Nov 2022 12:42:09 +0100
Message-ID: <20221125114210.2353820-1-vincent.whitchurch@axis.com>
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

It is currently possible to use --symfs along with a vmlinux which lies
outside of the symfs by passing an absolute path to --vmlinux, thanks to
the check in dso__load_vmlinux() which handles this explicitly.

However, the annotate code lacks this check and thus perf annotate does
not work ("Internal error: Invalid -1 error code") for kernel functions
with this combination.  Add the missing handling.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index db475e44f42f..52bdec764545 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1695,7 +1695,11 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 		 * cache, or is just a kallsyms file, well, lets hope that this
 		 * DSO is the same as when 'perf record' ran.
 		 */
-		__symbol__join_symfs(filename, filename_size, dso->long_name);
+		if (dso->kernel && dso->long_name[0] == '/')
+			snprintf(filename, filename_size,
+				 "%s", dso->long_name);
+		else
+			__symbol__join_symfs(filename, filename_size, dso->long_name);
 
 		mutex_lock(&dso->lock);
 		if (access(filename, R_OK) && errno == ENOENT && dso->nsinfo) {
-- 
2.34.1

