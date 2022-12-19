Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61A3650F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiLSPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiLSPtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:49:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0815013D1B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 07:46:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796F961032
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 15:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C3BC433EF;
        Mon, 19 Dec 2022 15:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671464781;
        bh=pWSfuZOhIjqdOCy61VXp5X8qHj+yFgIvKlxmkT/QoMg=;
        h=Date:From:To:Cc:Subject:From;
        b=cesYhb6e1Iy+HV45aoxQypb5ezCh5mt3n88eMXxGAQKRsza3+oMKa05ZoB4SfMYgZ
         OmgbG2dobhuFv13QF4Kx7b098dIQUcHRLJr5sfXJdn8UYc2S4sByJV81uggpOUvu71
         pse5Ory0GhfciWzECoMJrR7cxaxDR5Q+vPs5AzM5nyIlRCupvRNrrpfnSgdH2ee4qu
         EGxpRgs8evaXvyHAom7VCkNpWGwfKMNiB4XjWzj6lCDm2UBNpJDgWUAR1t+95v4LTo
         IJsiGvYiuBlMDOzojGowzJoIFMx0wxM207+C/fBjAosB+PrzZ49PjfpHbPtiuSPNOO
         NT8YZ3c4LE13w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ABDD240367; Mon, 19 Dec 2022 12:46:17 -0300 (-03)
Date:   Mon, 19 Dec 2022 12:46:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/fscrypt.h with the
 kernel sources
Message-ID: <Y6CHSS6Rn9YOqpAd@kernel.org>
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

To pick the changes from:

  f8b435f93b7630af ("fscrypt: remove unused Speck definitions")
  e0cefada1383c5ce ("fscrypt: Add SM4 XTS/CTS symmetric algorithm support")

That don't result in any changes in tooling, just causes this to be
rebuilt:

  CC      /tmp/build/perf-urgent/trace/beauty/sync_file_range.o
  LD      /tmp/build/perf-urgent/trace/beauty/perf-in.o

addressing this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from latest version at 'include/uapi/linux/fscrypt.h'
  diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fscrypt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index a756b29afcc23749..fd1fb0d5389d3abd 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -26,6 +26,8 @@
 #define FSCRYPT_MODE_AES_256_CTS		4
 #define FSCRYPT_MODE_AES_128_CBC		5
 #define FSCRYPT_MODE_AES_128_CTS		6
+#define FSCRYPT_MODE_SM4_XTS			7
+#define FSCRYPT_MODE_SM4_CTS			8
 #define FSCRYPT_MODE_ADIANTUM			9
 #define FSCRYPT_MODE_AES_256_HCTR2		10
 /* If adding a mode number > 10, update FSCRYPT_MODE_MAX in fscrypt_private.h */
@@ -185,8 +187,6 @@ struct fscrypt_get_key_status_arg {
 #define FS_ENCRYPTION_MODE_AES_256_CTS	FSCRYPT_MODE_AES_256_CTS
 #define FS_ENCRYPTION_MODE_AES_128_CBC	FSCRYPT_MODE_AES_128_CBC
 #define FS_ENCRYPTION_MODE_AES_128_CTS	FSCRYPT_MODE_AES_128_CTS
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7	/* removed */
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8	/* removed */
 #define FS_ENCRYPTION_MODE_ADIANTUM	FSCRYPT_MODE_ADIANTUM
 #define FS_KEY_DESC_PREFIX		FSCRYPT_KEY_DESC_PREFIX
 #define FS_KEY_DESC_PREFIX_SIZE		FSCRYPT_KEY_DESC_PREFIX_SIZE
-- 
2.38.1

