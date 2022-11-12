Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CFB626696
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234559AbiKLDXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbiKLDW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:22:57 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501D96BDEF;
        Fri, 11 Nov 2022 19:22:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 4so5730035pli.0;
        Fri, 11 Nov 2022 19:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rt0OZoaxk4oNSiXVua0yf4Wn8zR1kll8hc9QqXyH+pA=;
        b=UOLbFmT5ToNAoU3oPqqERXV5uMrPQHnO6gCJI8tQqh9v7o8jFkF5sgAzfSAWDG6InF
         l3ATOCc1++/TBvjiELfNQhZLn1wBtovjj0FqUIsQIMaFBV7B265HLHDIk4a8vxaZvMMp
         SPPnyIiNweg1NQ5W2X0lR5WWJmc2zqdRZQD0njN/0r9NfrSqz8eW7tFSZ0ZwNuvdH1eO
         2q+uBE43cMrIHHElSIuJKdAO7VPhCW7xBSTD98Q/OOLPTMtJmEOFyuR3QnlGmEvEUJ/v
         BbRqwHcdfb89H608XYwh2esOsLAEGjwNQIMlKQFHklbzK4M3Kxp83i2WOgKsmHBwGZMk
         kKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rt0OZoaxk4oNSiXVua0yf4Wn8zR1kll8hc9QqXyH+pA=;
        b=c/6ToJCf3CbQK3fHwCWdixZFyU8sZvn7zdInM4WKBtO4rJjqj/xNN41K3HBzgSta9+
         3+RczZcitl3HilLVMEWvmjEuK70cgQ6d3zD4pBy8b1hOITN2KGsFwQZyXRubGSADW3I+
         oR2Z7ZuCgcVcEVKPUAA9Wjbl+MeoEt5WexVqC8RgI/+Uxer1NPmKaafFbnYqr/GVNRTF
         mAKJW4GnMTN2jTjtdU2c5j5GEPNBrpnfdFyGX5dAETDTJYQGDVgG13eWOumkZNX6Micq
         q1rq3UUleda4YFpFwZZcHoFPaeTq28nZEfTMQTiC1KpklEBR84ROs7fYv1YbWk5N6wMb
         +5ig==
X-Gm-Message-State: ANoB5plHbetTn7ujbyUH7EWDhLWp56FdyfKU2udY54CDWM66cmZDXJpt
        RRtkTVz8ENrDwcf+gerKB9c=
X-Google-Smtp-Source: AA0mqf6WQ2r0loAsYfJ0U9RXsOW2smIyvrjswGe+P030nHeXeNJEG6ZNblGhhVim1Fc3v44nZl4PBA==
X-Received: by 2002:a17:90b:3c4b:b0:215:f80c:18e6 with SMTP id pm11-20020a17090b3c4b00b00215f80c18e6mr4908393pjb.45.1668223376717;
        Fri, 11 Nov 2022 19:22:56 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:22:56 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: [PATCH 05/11] perf stat: Clear screen only if output file is a tty
Date:   Fri, 11 Nov 2022 19:22:38 -0800
Message-Id: <20221112032244.1077370-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
In-Reply-To: <20221112032244.1077370-1-namhyung@kernel.org>
References: <20221112032244.1077370-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --interval-clear option makes perf stat to clear the terminal at
each interval.  But it doesn't need to clear the screen when it saves
to a file.  Make it fail when it's enabled with the output options.

  $ perf stat -I 1 --interval-clear -o myfile true
  --interval-clear does not work with output

   Usage: perf stat [<options>] [<command>]

      -o, --output <file>   output file name
          --log-fd <n>      log output to fd, instead of stderr
          --interval-clear  clear screen in between new interval

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-stat.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d5e1670bca20..1d79801f4e84 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2403,6 +2403,14 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
+	if (stat_config.interval_clear && !isatty(fileno(output))) {
+		fprintf(stderr, "--interval-clear does not work with output\n");
+		parse_options_usage(stat_usage, stat_options, "o", 1);
+		parse_options_usage(NULL, stat_options, "log-fd", 0);
+		parse_options_usage(NULL, stat_options, "interval-clear", 0);
+		return -1;
+	}
+
 	stat_config.output = output;
 
 	/*
-- 
2.38.1.493.g58b659f92b-goog

