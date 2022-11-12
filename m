Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC8662669C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbiKLDXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbiKLDX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:23:29 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C15A76FAA;
        Fri, 11 Nov 2022 19:23:08 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id j12so5688681plj.5;
        Fri, 11 Nov 2022 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbdcYDsOPafiPSVZSATOaxGNpCzEo4xQfFV4O82eayw=;
        b=f6lJ8r26ECT6R8yo7oa+mPmSnf0+R4JS32T/9zbBThdOT5XMFIW+6NByrFFmsWgTS1
         Q6Y0NYtG5bR2FrV8ILv91bYmzP9MTKP/948C8gEuVncwxRMqTa5fZmUzrSYZN7siQ04v
         qI176pCpR2V5bVy5HEUXDBtBujLLF/jKHMnS7Uj6u/Cpx/GsNiF4ar5ls2fS88D0gK63
         7ihLLuh0jOZaT0BF17sqY8w1YQuM01a3STrMQN8KBvO9WshWdxvbQQYOYJmeH7FT2b7d
         ZxB1ZoNDWfhced6wuJbm7ip71wKogU354ovn7EMzA+qe1PkdDkx1G9l8a8P9WGs0B3Ll
         OXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cbdcYDsOPafiPSVZSATOaxGNpCzEo4xQfFV4O82eayw=;
        b=0qL7SBX97FiTstx1paFl2ZzmdDWKmFBaBEgEQtU5acARmsDWpvD5HO7d0uM31y31yq
         zS0T5+Umunxun/SbxSd2xSPhAl658qkVsm43zSY6inUYuttxjq5NHooNl8G/J14/a04p
         /MslJ7OYTmnnlXfIDwPL7WZ3QUxHIB2wJEk3jz2IWasOOS4m6fffUDg4kwmgh52mudBj
         r3xLBpNwvAmG/0lVic4QzD3LevMj6m68AOum0myC/VsZGVFjvRvQdeSl9E3UU6/ZTAYb
         N0t+2vLJ/TXdlU8QeSp7VmaVHXlcJHZL0RZHpGytmgHSaJfZxs6QDBqnLtxL+ecOfcst
         KfGA==
X-Gm-Message-State: ANoB5pnzHkDqDi9SXFHc/Jz57R8VFAJdRdfCOVDD6SEtWyei/PKQHQIZ
        xJssqW9htS5E+2dZ7i8UzZg=
X-Google-Smtp-Source: AA0mqf61+i7dWsxeI0VjYMJSQm11smPrJi5IfQVjytbzw/XE/DkW8u3/CXChBl5Y3AioXJ10E0uPUw==
X-Received: by 2002:a17:903:c3:b0:186:8431:ece3 with SMTP id x3-20020a17090300c300b001868431ece3mr5486622plc.8.1668223387781;
        Fri, 11 Nov 2022 19:23:07 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27dc:8408:33d7:3b01:eee1:84b])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b00186f0f59d1esm2434552plb.192.2022.11.11.19.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 19:23:07 -0800 (PST)
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
Subject: [PATCH 11/11] perf stat: Add missing separator in the CSV header
Date:   Fri, 11 Nov 2022 19:22:44 -0800
Message-Id: <20221112032244.1077370-12-namhyung@kernel.org>
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

It should have a comma after 'cpus' for socket and die aggregation mode.
The output of the following command shows the issue.

  $ sudo perf stat -a --per-socket -x, --metric-only -I1 true

Before:
                  +--- here
                  V
   time,socket,cpusGhz,insn per cycle,branch-misses of all branches,
       0.000908461,S0,8,0.950,1.65,1.21,

After:
   time,socket,cpus,GHz,insn per cycle,branch-misses of all branches,
       0.000683094,S0,8,0.593,2.00,0.60,

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 96bb7a42fd41..a316807255cd 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -828,8 +828,8 @@ static int aggr_header_lens[] = {
 
 static const char *aggr_header_csv[] = {
 	[AGGR_CORE] 	= 	"core,cpus,",
-	[AGGR_DIE] 	= 	"die,cpus",
-	[AGGR_SOCKET] 	= 	"socket,cpus",
+	[AGGR_DIE] 	= 	"die,cpus,",
+	[AGGR_SOCKET] 	= 	"socket,cpus,",
 	[AGGR_NONE] 	= 	"cpu,",
 	[AGGR_THREAD] 	= 	"comm-pid,",
 	[AGGR_NODE] 	= 	"node,",
-- 
2.38.1.493.g58b659f92b-goog

