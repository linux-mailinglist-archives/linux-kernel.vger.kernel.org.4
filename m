Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE96160D106
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJYPwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJYPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:52:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E11179998
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 08:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DFA4B818C7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 15:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051D1C433C1;
        Tue, 25 Oct 2022 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666713162;
        bh=91kvKoH8/P40vYGrWbcSumXzvaWg1XH1mXhite6SjEc=;
        h=Date:From:To:Cc:Subject:From;
        b=O4BNg1ecXtNlN8QoM6ffR05Dfo7bhwoP8nPcA7eeGG2y6lqpsRVXI8uJ9lThsTPHH
         kFFESfb+OGj7FBzaNAehBfOQcuWmxlmNs13DF+6YscywSue9I1xuO+PplU+AICbxjt
         2kT7OKs8oe46GNNNlhLpreOfgqv3Yf+2CjxAsbin25FOd3P62ULYE2x/nw4wblj+3E
         dSjEwzs1nCuODubH1K1a+sCUGClcqqOm2BIWDRztQ6yjTn/BiBv3Ya1qgY+1YJoXwZ
         aOJrLX36+QEo5qTaGYrVgNNLtkLKcYwjtY/FGTLQPiKmFtycKW9OYCgIybjpe3cZYV
         qDMaqXysoPXXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E7845404BE; Tue, 25 Oct 2022 12:52:32 -0300 (-03)
Date:   Tue, 25 Oct 2022 12:52:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH FYI 1/1] tools headers uapi: Sync linux/stat.h with the
 kernel sources
Message-ID: <Y1gGQL5LonnuzeYd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes from:

  825cf206ed510c4a ("statx: add direct I/O alignment information")

That add a constant that was manually added to tools/perf/trace/beauty/statx.c,
at some point this should move to the shell based automated way.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/stat.h' differs from latest version at 'include/uapi/linux/stat.h'
  diff -u tools/include/uapi/linux/stat.h include/uapi/linux/stat.h

Cc: Eric Biggers <ebiggers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/stat.h | 4 +++-
 tools/perf/trace/beauty/statx.c | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/stat.h b/tools/include/uapi/linux/stat.h
index 1500a0f58041ae24..7cab2c65d3d7fce9 100644
--- a/tools/include/uapi/linux/stat.h
+++ b/tools/include/uapi/linux/stat.h
@@ -124,7 +124,8 @@ struct statx {
 	__u32	stx_dev_minor;
 	/* 0x90 */
 	__u64	stx_mnt_id;
-	__u64	__spare2;
+	__u32	stx_dio_mem_align;	/* Memory buffer alignment for direct I/O */
+	__u32	stx_dio_offset_align;	/* File offset alignment for direct I/O */
 	/* 0xa0 */
 	__u64	__spare3[12];	/* Spare space for future expansion */
 	/* 0x100 */
@@ -152,6 +153,7 @@ struct statx {
 #define STATX_BASIC_STATS	0x000007ffU	/* The stuff in the normal stat struct */
 #define STATX_BTIME		0x00000800U	/* Want/got stx_btime */
 #define STATX_MNT_ID		0x00001000U	/* Got stx_mnt_id */
+#define STATX_DIOALIGN		0x00002000U	/* Want/got direct I/O alignment info */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
diff --git a/tools/perf/trace/beauty/statx.c b/tools/perf/trace/beauty/statx.c
index 110f0c609d840eec..5f5320f7c6e27d17 100644
--- a/tools/perf/trace/beauty/statx.c
+++ b/tools/perf/trace/beauty/statx.c
@@ -66,6 +66,7 @@ size_t syscall_arg__scnprintf_statx_mask(char *bf, size_t size, struct syscall_a
 	P_FLAG(BLOCKS);
 	P_FLAG(BTIME);
 	P_FLAG(MNT_ID);
+	P_FLAG(DIOALIGN);
 
 #undef P_FLAG
 
-- 
2.37.3

