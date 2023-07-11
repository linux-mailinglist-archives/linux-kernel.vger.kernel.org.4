Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F167874F36B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGKP3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGKP3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:29:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2D5120
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C6EE61559
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:29:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF3CC433C8;
        Tue, 11 Jul 2023 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689089346;
        bh=wC4iYMWDJJK91aeTRakFXPAFZdRSEZjE2B0dhH2if8I=;
        h=Date:From:To:Cc:Subject:From;
        b=G8+pXIxmSSLbqzjKUjIkZm/dkzG6eWak3CQXXzP4QsIrKZ5jyXeyRfSy7F7sifto6
         fdga7jHF8K+5tijx0sN+uKxHBH7SiTr5yDbh1vjFhrv4V19PR0iMF5pFH2idXP3qKb
         XYkuQYWx8qbIS1xp3zyZhOOR8sN54l6BpsdfUN7oDeAaaCUYYBRlPBI8S70agGlul7
         WYFzji4I1iNsaV6SQaGKIktrhIGqKnCsaMouxZMJ9Xaq+nZ1Fw7W2A9WdwXiHgc5OY
         xyfKYRLnzBbjArDK3Pv960187V0XuRslkZw3IQiVAXq5vBvxwDv/cwYw9LbY5oEWkV
         Po0XSI1smKv+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F014040516; Tue, 11 Jul 2023 12:29:03 -0300 (-03)
Date:   Tue, 11 Jul 2023 12:29:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Ian Rogers <irogers@google.com>, Jan Kara <jack@suse.cz>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers uapi: Sync linux/fcntl.h with the
 kernel sources
Message-ID: <ZK11P5AwRBUxxutI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

To get the changes in:

  96b2b072ee62be8a ("exportfs: allow exporting non-decodeable file handles to userspace")

That don't add anything that is handled by existing hard coded tables or
table generation scripts.

This silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fcntl.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index e8c07da58c9f20ed..6c80f96049bd07d1 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -112,4 +112,9 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
+#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
+					compare object identity and may not
+					be usable to open_by_handle_at(2) */
+
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.37.1

