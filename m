Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6E27119FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 00:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbjEYWJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 18:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjEYWJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 18:09:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21512F;
        Thu, 25 May 2023 15:09:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53f04fdd77dso30938a12.3;
        Thu, 25 May 2023 15:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685052570; x=1687644570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=9M8nWoD6KWrYcLP+c2xne+17Aj3PiuijAzZBCy4tnBM=;
        b=UPuy1ySXcvpF9xExgdv8gW5kMgOc2DwvioFjAxKAKh+6uTzCldGq2K7xENFEspkCu+
         qZWDD88GK3bkynGTXLt13sfLNqKlBvkpQgUb9UK3KdYvYShADVw0zOhDJU3qXELSBGFW
         oUZ6tt9i4w+/Uilw7d7sp+xQUj7z1DtjwAyica3LRQv47gBekQad074dUmna9zEFbOUZ
         dX9+epKGt6YUAAUABolRNL5OE+uyq+VyLLGPoeZC1/5BZNjGj2gL+bx4C8JXklRvvqLK
         n6HLZ4v7tCua1qpM2vL5y+WyleIoO8y9ODPU4MT1XXtjYG2p29ICT7CYZwhpxAcRTXRU
         SrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685052570; x=1687644570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M8nWoD6KWrYcLP+c2xne+17Aj3PiuijAzZBCy4tnBM=;
        b=eS+Qor0hLklVu6wEMrJaRgZC3/eWLjGtL5LsFT5zNJsSSIaasQfPWfsUBWFjOrTuQ0
         0O+Pd252nPj2yp45dgojF/Zoz2TDu63gfGXMPTGGz8xk+0vma+JXs+0scgDxyZdfSVr/
         8ajRj92MWs1j0vSfFU2JSEB9Y+NWjlX6uMCOOG6Oaze9SlJENiiRQL6EsLZb+3GMtpvw
         9vzqIr7gz35K/PpIvVHANVdPnKNaBeuHy8k+lv302bwi7cG+Ek11TcX30u2cMYqcN6SQ
         a9jdGTxZRi43Er+rzOoHDWU+KW3x7yxUSpJaO/wzUjCTnCjz9aZVFArUyxOlbQyavr5U
         7aaw==
X-Gm-Message-State: AC+VfDyipTZEKcbNFMtUF8TB9Ffed3qS0c5qHFhCM8Tw4GOAcOunKkp+
        03jOmCMHp51VpMSV6k7btj4=
X-Google-Smtp-Source: ACHHUZ5xulfWCfPzYH9/YLwNiNbqV0qi7EXkYL11ysjOWGGrhN+EHNomXiXdAkVZm2KUiWB8cNLwrw==
X-Received: by 2002:a17:902:8210:b0:1ae:6882:5bc4 with SMTP id x16-20020a170902821000b001ae68825bc4mr104977pln.64.1685052570159;
        Thu, 25 May 2023 15:09:30 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2d4:203:7217:977f:12fc:72e0])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b001a6ed2d0ef8sm1851390plb.273.2023.05.25.15.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 15:09:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] tools lib subcmd: Show parent options in help
Date:   Thu, 25 May 2023 15:09:27 -0700
Message-ID: <20230525220927.3544192-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've just realized that help message in a subcommand didn't show one
in the parent command.  Since the option parser understands the parent,
display code should do the same.  For example, `perf ftrace latency -h`
should show options in the `perf ftrace` command too.

Before:

  $ perf ftrace latency -h

   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- [<command>] [<options>]
      or: perf ftrace {trace|latency} [<options>] [<command>]
      or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]

      -b, --use-bpf         Use BPF to measure function latency
      -n, --use-nsec        Use nano-second histogram
      -T, --trace-funcs <func>
                            Show latency of given function

After:

  $ perf ftrace latency -h

   Usage: perf ftrace [<options>] [<command>]
      or: perf ftrace [<options>] -- [<command>] [<options>]
      or: perf ftrace {trace|latency} [<options>] [<command>]
      or: perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]

      -a, --all-cpus        System-wide collection from all CPUs
      -b, --use-bpf         Use BPF to measure function latency
      -C, --cpu <cpu>       List of cpus to monitor
      -n, --use-nsec        Use nano-second histogram
      -p, --pid <pid>       Trace on existing process id
      -T, --trace-funcs <func>
                            Show latency of given function
      -v, --verbose         Be more verbose
          --tid <tid>       Trace on existing thread id (exclusive to --pid)

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/subcmd/parse-options.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 9fa75943f2ed..41de97671c72 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -806,18 +806,28 @@ static int option__cmp(const void *va, const void *vb)
 
 static struct option *options__order(const struct option *opts)
 {
-	int nr_opts = 0, nr_group = 0, len;
-	const struct option *o = opts;
-	struct option *opt, *ordered, *group;
+	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
+	const struct option *o, *p = opts;
+	struct option *opt, *ordered = NULL, *group;
 
-	for (o = opts; o->type != OPTION_END; o++)
+retry:
+	for (o = p; o->type != OPTION_END; o++)
 		++nr_opts;
 
-	len = sizeof(*o) * (nr_opts + 1);
-	ordered = malloc(len);
-	if (!ordered)
+	len = sizeof(*o) * (nr_opts + !o->parent);
+	group = realloc(ordered, len);
+	if (!group)
 		goto out;
-	memcpy(ordered, opts, len);
+	ordered = group;
+	memcpy(&ordered[nr_parent], p, sizeof(*o) * (nr_opts - nr_parent));
+
+	if (o->parent) {
+		p = o->parent;
+		nr_parent = nr_opts;
+		goto retry;
+	}
+	/* copy the last OPTION_END */
+	memcpy(&ordered[nr_opts], o, sizeof(*o));
 
 	/* sort each option group individually */
 	for (opt = group = ordered; opt->type != OPTION_END; opt++) {
-- 
2.41.0.rc0.172.g3f132b7071-goog

