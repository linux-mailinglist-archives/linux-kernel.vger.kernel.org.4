Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A75974F425
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjGKP4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGKP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDD5FB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BE936155E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90631C433C8;
        Tue, 11 Jul 2023 15:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689090965;
        bh=uTQms5QcQbX0tLF17LHS1X7OvrScgSP+WGAXd4DsUzk=;
        h=Date:From:To:Cc:Subject:From;
        b=npK6tqEiblSIG4ozlKCi0inY6AMgiZiBoMhmqT2uHa7DIwCX+twA6HzOMrVxD5gnn
         6aYk0UeZRf+7kqvkhvR5TZwjk7fGZHTegEikFuMb3lw1RJjlIJR8X7zp5yBK5doMSd
         CWPk4HarT1+qxC/ZRNntYxN7H8WuKCFMHWfwIlyK09blwKSMcQ6LvS6mhwMM5wicFc
         8NGozJ4jbWlSJiFYjirt0w9KSLXIU222yx4J2H6TCb0bUl8Qykh8wH7xnfTe8hxTMF
         pMhwA9z6B+ax/i3FsrydWvz6dajsui0bLQ3xYfM7eX1Y37HYDvAkp9GA79v+ij7qt+
         w3dusmlP6aYLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B89B040516; Tue, 11 Jul 2023 12:56:02 -0300 (-03)
Date:   Tue, 11 Jul 2023 12:56:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/mount.h copy with the
 kernel sources
Message-ID: <ZK17kifP/iYl+Hcc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

  6ac392815628f317 ("fs: allow to mount beneath top mount")

That, after a fix to the move_mount_flags.sh script, harvests the new
MOVE_MOUNT_BENEATH move_mount flag:

  $ tools/perf/trace/beauty/move_mount_flags.sh > before
  $ cp include/uapi/linux/mount.h tools/include/uapi/linux/mount.h
  $ tools/perf/trace/beauty/move_mount_flags.sh > after
  $
  $ diff -u before after
  --- before	2023-07-11 12:38:49.244886707 -0300
  +++ after	2023-07-11 12:51:15.125255940 -0300
  @@ -6,4 +6,5 @@
   	[ilog2(0x00000020) + 1] = "T_AUTOMOUNTS",
   	[ilog2(0x00000040) + 1] = "T_EMPTY_PATH",
   	[ilog2(0x00000100) + 1] = "SET_GROUP",
  +	[ilog2(0x00000200) + 1] = "BENEATH",
   };
  $

That will then be properly decoded when used in tools like:

  # perf trace -e move_mount

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h

Cc: Christian Brauner <brauner@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/mount.h            | 3 ++-
 tools/perf/trace/beauty/move_mount_flags.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 4d93967f8aea0780..8eb0d7b758d2835a 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -74,7 +74,8 @@
 #define MOVE_MOUNT_T_AUTOMOUNTS		0x00000020 /* Follow automounts on to path */
 #define MOVE_MOUNT_T_EMPTY_PATH		0x00000040 /* Empty to path permitted */
 #define MOVE_MOUNT_SET_GROUP		0x00000100 /* Set sharing group instead */
-#define MOVE_MOUNT__MASK		0x00000177
+#define MOVE_MOUNT_BENEATH		0x00000200 /* Mount beneath top mount */
+#define MOVE_MOUNT__MASK		0x00000377
 
 /*
  * fsopen() flags.
diff --git a/tools/perf/trace/beauty/move_mount_flags.sh b/tools/perf/trace/beauty/move_mount_flags.sh
index 32e552faf37a818b..ce5e632d14484bd2 100755
--- a/tools/perf/trace/beauty/move_mount_flags.sh
+++ b/tools/perf/trace/beauty/move_mount_flags.sh
@@ -10,7 +10,7 @@ fi
 linux_mount=${linux_header_dir}/mount.h
 
 printf "static const char *move_mount_flags[] = {\n"
-regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOVE_MOUNT_([^_]+_[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MOVE_MOUNT_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
 grep -E $regex ${linux_mount} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
-- 
2.37.1

