Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18956A9F4F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCCSlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjCCSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:41:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40161887
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:40:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D52956185F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD5DC433D2;
        Fri,  3 Mar 2023 18:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677868805;
        bh=bS+ZJOe3QYQXvtmzvwTDlrH96zuJCt0tgkltyWj9I34=;
        h=Date:From:To:Cc:Subject:From;
        b=GDPQh6GvZAj1apVBozEN41X6dj5bJKB8js/14M92RCvxrOpD4vyNHQ9LvHjmx/wAn
         2WNVwclVBMNoUqs2pKDD095dTe/a0cdWvZtRCmB1uZ3xbZsIR8ZSStgGbQVKTVU2Va
         uJLMhXI1CH85a4HIJ0w0qSgDqy06D85E0CSS3xmNLmxpEkA7jFx+n/Hs/Opf4REF6m
         PNyGlBNAkCnuRoQU5IczPLUJhIsBctceC2h0yHOfq+Gi5twetLjfzrE3LFmZsExkKJ
         arj0bLYjpVDNhYoa9HFdYN8Ol9L2RaZBVlmgeYZ6CdcbpU5H+F7vaUNMN4jCf6Ej9k
         vXoCsh3eDjrcw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 702C64049F; Fri,  3 Mar 2023 15:40:02 -0300 (-03)
Date:   Fri, 3 Mar 2023 15:40:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Joey Gouly <joey.gouly@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/prctl.h with the
 kernel sources
Message-ID: <ZAI/AoPXb/sxz1/m@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

To pick new prctl options introduced in:

  b507808ebce23561 ("mm: implement memory-deny-write-execute as a prctl")

That results in:

  $ diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h
  --- tools/include/uapi/linux/prctl.h	2022-06-20 17:54:43.884515663 -0300
  +++ include/uapi/linux/prctl.h	2023-03-03 11:18:51.090923569 -0300
  @@ -281,6 +281,12 @@
   # define PR_SME_VL_LEN_MASK		0xffff
   # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */

  +/* Memory deny write / execute */
  +#define PR_SET_MDWE			65
  +# define PR_MDWE_REFUSE_EXEC_GAIN	1
  +
  +#define PR_GET_MDWE			66
  +
   #define PR_SET_VMA		0x53564d41
   # define PR_SET_VMA_ANON_NAME		0

  $ tools/perf/trace/beauty/prctl_option.sh > before
  $ cp include/uapi/linux/prctl.h tools/include/uapi/linux/prctl.h
  $ tools/perf/trace/beauty/prctl_option.sh > after
  $ diff -u before after
  --- before	2023-03-03 11:47:43.320013146 -0300
  +++ after	2023-03-03 11:47:50.937216229 -0300
  @@ -59,6 +59,8 @@
   	[62] = "SCHED_CORE",
   	[63] = "SME_SET_VL",
   	[64] = "SME_GET_VL",
  +	[65] = "SET_MDWE",
  +	[66] = "GET_MDWE",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

Now users can do:

  # perf trace -e syscalls:sys_enter_prctl --filter "option==SET_MDWE||option==GET_MDWE"
^C#
  # trace -v -e syscalls:sys_enter_prctl --filter "option==SET_MDWE||option==GET_MDWE"
  New filter for syscalls:sys_enter_prctl: (option==65||option==66) && (common_pid != 5519 && common_pid != 3404)
^C#

And when these prctl options appears in a session, they will be
translated to the corresponding string.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index a5e06dcbba136d61..1312a137f7fb85e1 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -281,6 +281,12 @@ struct prctl_mm_map {
 # define PR_SME_VL_LEN_MASK		0xffff
 # define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
 
+/* Memory deny write / execute */
+#define PR_SET_MDWE			65
+# define PR_MDWE_REFUSE_EXEC_GAIN	1
+
+#define PR_GET_MDWE			66
+
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
-- 
2.39.2

