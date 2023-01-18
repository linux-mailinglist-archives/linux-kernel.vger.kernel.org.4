Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7D671EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjARN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjARN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:57:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A714DCE1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:31:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17064B81D0F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81325C433EF;
        Wed, 18 Jan 2023 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674048658;
        bh=NmLBDxQgjqDB5FV7KAEEdcgVvEfxFe1SFqT0RQpIt8s=;
        h=Date:From:To:Cc:Subject:From;
        b=BuYQ6jut3BbfgDlhIjQno38125Gr15M0NJ5x1ugFJjA0aDo4ANmtUoDcgjutkInrQ
         9BoB9qHZDJgTc3Wq8pDDmpT2+spkqzmaebzXcmX3lT5T44ysDwMzEZlX4Tmg91gptq
         qbihfXc0afvNCW8tz+0uFHh3/dDfKGOXBdpRwCxRIj+47VaumYCc7M2hHRJWZ5lebO
         DpU9waHeojU3yPRzf06qzvzA5/XZa466sapyLjvR/RnOu1JNa8BodmHfejxHlG8heY
         PpDU/0xCDyU+/vYaeFS+ht9jfzZsdrig6L7rpF6v0nrv3Vjr5Dh6Ymv/zBqxuhPTwQ
         oloL545xw2Raw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C4004405BE; Wed, 18 Jan 2023 10:30:54 -0300 (-03)
Date:   Wed, 18 Jan 2023 10:30:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/1 FYI] tools headers: Syncronize linux/build_bug.h with the
 kernel sources
Message-ID: <Y8f0jqQFYDAOBkHx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

To pick up the changes in:

  07a368b3f55a79d3 ("bug: introduce ASSERT_STRUCT_OFFSET")

This cset only introduces a build time assert macro, that may be useful
at some point for tooling, for now it silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/linux/build_bug.h' differs from latest version at 'include/linux/build_bug.h'
  diff -u tools/include/linux/build_bug.h include/linux/build_bug.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/build_bug.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/linux/build_bug.h b/tools/include/linux/build_bug.h
index cc7070c7439ba6a5..b4898ff085ded5a9 100644
--- a/tools/include/linux/build_bug.h
+++ b/tools/include/linux/build_bug.h
@@ -79,4 +79,13 @@
 #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
 #endif // static_assert
 
+
+/*
+ * Compile time check that field has an expected offset
+ */
+#define ASSERT_STRUCT_OFFSET(type, field, expected_offset)	\
+	BUILD_BUG_ON_MSG(offsetof(type, field) != (expected_offset),	\
+		"Offset of " #field " in " #type " has changed.")
+
+
 #endif	/* _LINUX_BUILD_BUG_H */
-- 
2.39.0

