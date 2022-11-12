Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD68B626697
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiKLDXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiKLDW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:22:59 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9AD6CA1D;
        Fri, 11 Nov 2022 19:22:59 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id o13so5795786pgu.7;
        Fri, 11 Nov 2022 19:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRuX+j+EX9l8i8hDmmemd16C6a6HV399XyOmvJyZheQ=;
        b=eCmqycyV6SF4+MBfj8mZjtXU83WS4vKKwxamThMHBx5bhoGOBddHio63RFoG1x/S6q
         dduEPCFh01zoEp6IVarbUn5JnQhJejBfO5ppqWTHXHQl5drY0pxIDRtZgdKAxuuwkIJq
         0vUkrfCXO+f+KeIf9WJ2UCfW7T8/2RnrOGw+bBS2R+5rs6zHezmlhRPOimkiiHLdOyip
         kTQPUFtBQJgC77VAgAxF56CH6ITFZ8hV4HWQWPJsD9rje8WvhIfmt3nWUIbx+VbpdqCc
         JBt8x8P0CKxwmOTPf5vzF1EWE4PQxoIC6zmDQH07uOQG2SxDDFh2nWSSS5A/H55+Jy+N
         VD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mRuX+j+EX9l8i8hDmmemd16C6a6HV399XyOmvJyZheQ=;
        b=PfMltaOb7ltalhSghgXoEJ+krMOldG+CQfutiSaaS15SxB2BB/1ckdXtWpU+/FvgYV
         5f4EQz+ue6nN8iPy+oYMvASEC9x49X3dhPdzJHWnPCEISgDMgt0vNjIXwQ72s3OXIIwQ
         /mS2UZ0U+/usME12ryHmpquwZfyh3/+eVNtbJunWwTaWrO5Xv1rzWBTpudMiKqNm0kgO
         yuBpR/qJ1FFGk97P81zur9e6Ht/LQ2QjmTGgtBc0T/or6onsYveZHIH9EnINpdXjP1ci
         tolux5t5vRUr+pyrtJCevP3AltHjZeNw2oNmXMnFziun3jpHpxouBjjg1Ur5uvmXel8h
         9BYQ==
X-Gm-Message-State: ANoB5pnc2NG23EvtRy8Nyi7n8Z6/arDbbaoE1Ip2ls0rwYG3IjNN2nwO
        YlO1OKFDHbb/ME8N7N6DENSRGlFRoXQ=
X-Google-Smtp-Source: AA0mqf6RGm5DjGG9GMLCY75uITjGxkEM4Mqa16cxF9++STXV2UR+3A8KGDgUgmcCm1lvrQsS1KHv7w==
X-Received: by 2002:a65:498c:0:b0:46f:918e:7338 with SMTP id r12-20020a65498c000000b0046f918e7338mr4179286pgs.8.1668223378601;
        Fri, 11 Nov 2022 19:22:58 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:22:58 -0800 (PST)
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
Subject: [PATCH 06/11] perf stat: Do not indent headers for JSON
Date:   Fri, 11 Nov 2022 19:22:39 -0800
Message-Id: <20221112032244.1077370-7-namhyung@kernel.org>
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

Currently --metric-only with --json indents header lines.  This is not
needed for JSON.

  $ perf stat -aA --metric-only -j true
        {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
  {"cpu" : "0", {"metric-value" : "0.101"}{"metric-value" : "0.86"}{"metric-value" : "1.91"}
  {"cpu" : "1", {"metric-value" : "0.102"}{"metric-value" : "0.87"}{"metric-value" : "2.02"}
  {"cpu" : "2", {"metric-value" : "0.085"}{"metric-value" : "1.02"}{"metric-value" : "1.69"}
  ...

Note that the other lines are broken JSON, but it will be handled later.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 3ddc159df4b2..dbd3ba380c9f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -851,7 +851,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 	if (prefix && !config->json_output)
 		fprintf(config->output, "%s", prefix);
 
-	if (!config->csv_output && !no_indent)
+	if (!config->csv_output && !config->json_output && !no_indent)
 		fprintf(config->output, "%*s",
 			aggr_header_lens[config->aggr_mode], "");
 	if (config->csv_output) {
-- 
2.38.1.493.g58b659f92b-goog

