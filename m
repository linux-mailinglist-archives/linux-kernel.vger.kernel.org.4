Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB827227A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjFENjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjFENjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA2C92;
        Mon,  5 Jun 2023 06:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E87C622B8;
        Mon,  5 Jun 2023 13:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77418C433D2;
        Mon,  5 Jun 2023 13:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685972340;
        bh=zmExzYudMwfGNEba20Z9ljtkQ0F7F9zZROAPpR26D08=;
        h=Date:From:To:Cc:Subject:From;
        b=hLtoQOW0x/ny+YqsSNDz9uHGIatddat8GP9vRUK7Y+Zzjv8DiYo/OLSXI37rttcfB
         wuHXW47vwDMMjAiwQJiX/IZCI/NN8E2JE+dftiZd+cUFCd6ZDCuNplc5l5fSGmhoVS
         OGbp4h37qRWTwXxYFn6uwF2ITXKstg9GB6vok4gTDh6lcPqcdg2+owbrmW4kDeZ2RF
         EIBASZBuNYItgUGrYaPYASp3M3m7IK/trTc/DPVFd8WKT2oHFAciLPUNGPRZMB+uPi
         TQh4fbH3OxgmOWbZFA1ldhap6qH/RPM3Es0HTB7PcJq8fXlSrmLdNYKFuOZnKbMwPS
         JKDvfMFJFYCYA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F22EA40692; Mon,  5 Jun 2023 10:38:57 -0300 (-03)
Date:   Mon, 5 Jun 2023 10:38:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andre Fredette <anfredet@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Dave Tucker <datucker@redhat.com>,
        Derek Barbosa <debarbos@redhat.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [FYI PATCH 1/1] perf bench: Add missing setlocale() call to allow
 usage of %'d style formatting
Message-ID: <ZH3lcepZ4tBYr1jv@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI: I'm carrying this in the perf-tools-next branch,

Thanks,

- Arnaldo

---

Without this we were not getting the thousands separator for big
numbers.

Noticed while developing 'perf bench uprobe', but the use of %' predates
that, for instance 'perf bench syscall' uses it.

Before:

  # perf bench uprobe all
  # Running uprobe/baseline benchmark...
  # Executed 1000 usleep(1000) calls
       Total time: 1054082243ns

   1054082.243000 nsecs/op

  #

After:

  # perf bench uprobe all
  # Running uprobe/baseline benchmark...
  # Executed 1,000 usleep(1000) calls
       Total time: 1,053,715,144ns

   1,053,715.144000 nsecs/op

  #

Fixes: c2a08203052f8975 ("perf bench: Add basic syscall benchmark")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andre Fredette <anfredet@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: Dave Tucker <datucker@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Derek Barbosa <debarbos@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-bench.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 58f1cfe1eb34b329..db435b791a09b69b 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -21,6 +21,7 @@
 #include "builtin.h"
 #include "bench/bench.h"
 
+#include <locale.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -260,6 +261,7 @@ int cmd_bench(int argc, const char **argv)
 
 	/* Unbuffered output */
 	setvbuf(stdout, NULL, _IONBF, 0);
+	setlocale(LC_ALL, "");
 
 	if (argc < 2) {
 		/* No collection specified. */
-- 
2.37.1

