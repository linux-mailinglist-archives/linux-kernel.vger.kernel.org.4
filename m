Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7C66E81F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDSTgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 15:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDSTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 15:36:45 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF774C25;
        Wed, 19 Apr 2023 12:36:44 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6a606135408so155446a34.0;
        Wed, 19 Apr 2023 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681933003; x=1684525003;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVCZIlNhtdCXAt4hoR3tnnBgtwHzJao5D1y0UvS0R0Q=;
        b=GrYZqph7PqaNy/epNrxJAewS4RVu6uFuF/gL805TnO8xF9W3fkm6Gssax0fUCNeZq/
         whNdIU4l8TJIiy7rHXeXtLIzAsG9u6v5Jn8/Su06LM/lP4bEwN2dw5a0AVIr6K+jc9Cu
         /VjCV55I5JjHw3nTa27Ib+hsb9T3ZDrajAA1dHtpOFeNvfjznBxZDgoDVqLhhcbBusAd
         2iHeQtnu9MKJvsX2KeRmRZAWQzChZUGr/5dtPZNu0bbfnY8+2ZUgO7kR9IIp6Tcjc1e5
         1WHcodKdTa2l6fkCq4bAFHpKdA0ZAljVFwNA900jPU68IdcheREo7wZfqP7ECiyUjklM
         BH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681933003; x=1684525003;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TVCZIlNhtdCXAt4hoR3tnnBgtwHzJao5D1y0UvS0R0Q=;
        b=Ts9bdSSDDCcKwCvVVZxavCcMakhftY2VoZXR2QcAWk5JhNoSerQMzcUZM5cybzebHY
         JPmcCmO7DBWa7Z9VVD1DZpvboKycytlyB4mICjL6nBZvV5vfwfr2H7VZB898Pec7WOPV
         2+Ur0PS7qCJfHR1sqA8yQSp5TEvgwqszOz0qFTQ3e/YqaC1w79nnIgoQQkxKgAf8B+wt
         LLCcildBsXlmAN5wGS/9sH9YipOj5PgA5TdAVA9/adYAaPEuzUbsqF4wUx7NxMmwPZ4X
         qYTDr+tHxz5BLTRA4c6niuVejvS6MaT57yQ7dYzVhWbYVp5w6oZQS02MYhH19/UnR4Df
         VLfg==
X-Gm-Message-State: AAQBX9d8VmIKGaqVZvgokggY8PSX5J2hWa+Da4dF9qZPqMfigSRprgAP
        53Uz6M/1YPoYFBLDsYMDnutCjYNxOhw=
X-Google-Smtp-Source: AKy350Y2v74z8xy4JM/OptdxSfm9Nk1VvXMee/J10OwXUF6B5zxsYYTnaJF7kunpRP2O02Xd77AylQ==
X-Received: by 2002:a05:6830:1dab:b0:6a5:e673:1243 with SMTP id z11-20020a0568301dab00b006a5e6731243mr323743oti.31.1681933003649;
        Wed, 19 Apr 2023 12:36:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.238.117])
        by smtp.gmail.com with ESMTPSA id y6-20020a9d6346000000b006a17bbe32f8sm6971849otk.51.2023.04.19.12.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 12:36:43 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A05F403B5; Wed, 19 Apr 2023 16:36:40 -0300 (-03)
Date:   Wed, 19 Apr 2023 16:36:40 -0300
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf probe: Add missing 0x prefix for addresses printed
 in hexadecimal
Message-ID: <ZEBCyFu2GjTw6qOi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

	I'm carrying this one in my tree, FYI.

- Arnaldo

---

To fix this confusing warning:

  # perf probe -l
  Failed to find debug information for address 798240
    probe_main:prometheus_new_counter__return (on github.com/prometheus/client_golang/prometheus.NewCounter%return in /home/acme/git/prometheus-uprobes/main with counter)
  #

As that 798240 is printed with PRIx64 but has no letters, better print
the 0x prefix to disambiguate.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 54b49ce85c9f2214..f171360b0ef4db06 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1729,7 +1729,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
 		addr += baseaddr;
 	/* Find cu die */
 	if (!dwarf_addrdie(dbg->dbg, (Dwarf_Addr)addr, &cudie)) {
-		pr_warning("Failed to find debug information for address %" PRIx64 "\n",
+		pr_warning("Failed to find debug information for address %#" PRIx64 "\n",
 			   addr);
 		ret = -EINVAL;
 		goto end;
-- 
2.39.2

