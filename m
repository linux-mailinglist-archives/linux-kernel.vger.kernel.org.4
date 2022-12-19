Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE17650D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 15:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiLSOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 09:36:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiLSOgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 09:36:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8A0E2D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 06:35:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 062A5B80E4B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75782C433D2;
        Mon, 19 Dec 2022 14:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671460552;
        bh=pfL+GsdcRpU52Alfp1NPpm/Vx5s2knEiBXoyTHXuwy4=;
        h=Date:From:To:Cc:Subject:From;
        b=QmGJzg1kboE70UMiR/yRBXkRvYCGtVoFFT5PYSNpBwpnMf1tx6GeVtxHQJVbQwyVl
         9Kjpei9YWA0F4myXpwWpI6YeRQ49Dqt9Hhn9ooFyah4SpIA5HhvA9LJGMYYBstfZbX
         3kPMJvCUL/1rsli4Uw0+Fx8Qzulegr/nbbZpKfbsee7llsdX7hBLoBYhJ6+df5jDXn
         1WxuvN3mp3dylS9nT5n4VYUIGYyvg0PBfh90ioEa445JaDR7v9+P2tOzvy8BqchXbl
         CvTcP8EuvSZqyAZn99Fl1z4ldUydcSkTGG5WW4BW3jlwkTsMSLmQr/3LwmWV7t5ah8
         Kykgfmfh11dOQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4ACDC40367; Mon, 19 Dec 2022 11:35:47 -0300 (-03)
Date:   Mon, 19 Dec 2022 11:35:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>, Ian Rogers <irogers@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Juergen Gross <jgross@suse.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers cpufeatures: Sync with the kernel
 sources
Message-ID: <Y6B2w3WqifB/V70T@kernel.org>
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

To pick the changes from:

  15e15d64bd8e12d8 ("x86/cpufeatures: Add X86_FEATURE_XENPV to disabled-features.h")

This only causes these perf files to be rebuilt:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o

And addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/disabled-features.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 33d2cd04d2544791..c44b56f7ffba0d0e 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -69,6 +69,12 @@
 # define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
 #endif
 
+#ifdef CONFIG_CALL_DEPTH_TRACKING
+# define DISABLE_CALL_DEPTH_TRACKING	0
+#else
+# define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
+#endif
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 # define DISABLE_ENQCMD		0
 #else
@@ -81,6 +87,12 @@
 # define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
 #endif
 
+#ifdef CONFIG_XEN_PV
+# define DISABLE_XENPV		0
+#else
+# define DISABLE_XENPV		(1 << (X86_FEATURE_XENPV & 31))
+#endif
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 # define DISABLE_TDX_GUEST	0
 #else
@@ -98,10 +110,11 @@
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_TDX_GUEST)
+#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
-#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET)
+#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
+			 DISABLE_CALL_DEPTH_TRACKING)
 #define DISABLED_MASK12	0
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
-- 
2.38.1

