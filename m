Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504A16525B0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiLTRmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:42:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233D13E02
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 09:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 743AFB81730
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 17:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AF4C433EF;
        Tue, 20 Dec 2022 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671558158;
        bh=ay/IGDAHS26YEOIr3j/wpp5tD0PTAZRTpXY6UkVBeCw=;
        h=Date:From:To:Cc:Subject:From;
        b=DYSCZIqKS6jqYOo4DYD4I1fbADR3kMVfSaT0nPGRzdXux4PBffsM7My3QssI2HMb3
         TUpzuVW4RoKDBbruQRuAMUdJNJf6mtsCClU3COT29L3yETHcaJKmWM2q1Yus2q+veE
         5IvaZTeGkEJJhfYJLcWEJvr/et+EbV5pRleTEiJ33ikjg5JYFZ3ueZ7PoMxmR76pDe
         wmrQwNa0Jl211MenCMNKq+Yy7GrejxUnjFEQ09pzeJNaE+SA76DfpdzK4RQGqhVV0V
         Uxsqt0GFnLVAjcapkcM3ap3s3hR8LGHJZpKLquFx4oqBwu70OqOlg6kjmwvkFosS1K
         jBCgWC2i3K3Gg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6967040367; Tue, 20 Dec 2022 14:42:35 -0300 (-03)
Date:   Tue, 20 Dec 2022 14:42:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync powerpc syscall table with
 the kernel sources
Message-ID: <Y6H0C5plZ4V4aiPm@kernel.org>
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

To pick the changes in these csets:

  ce883a2ba310cd7c ("powerpc/32: fix syscall wrappers with 64-bit arguments")

That doesn't cause any changes in the perf tools.

This table is used in tools perf to allow features as described in the
last update to this file.

This addresses this perf build warning:

  Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
  diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index e9e0df4f9a61a494..a0be127475b1f761 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -394,8 +394,11 @@
 305	common	signalfd			sys_signalfd			compat_sys_signalfd
 306	common	timerfd_create			sys_timerfd_create
 307	common	eventfd				sys_eventfd
-308	common	sync_file_range2		sys_sync_file_range2		compat_sys_ppc_sync_file_range2
-309	nospu	fallocate			sys_fallocate			compat_sys_fallocate
+308	32	sync_file_range2		sys_ppc_sync_file_range2	compat_sys_ppc_sync_file_range2
+308	64	sync_file_range2		sys_sync_file_range2
+308	spu	sync_file_range2		sys_sync_file_range2
+309	32	fallocate			sys_ppc_fallocate		compat_sys_fallocate
+309	64	fallocate			sys_fallocate
 310	nospu	subpage_prot			sys_subpage_prot
 311	32	timerfd_settime			sys_timerfd_settime32
 311	64	timerfd_settime			sys_timerfd_settime
-- 
2.38.1

