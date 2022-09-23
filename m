Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D8C5E80BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiIWRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiIWRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:32:07 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F614F2A1;
        Fri, 23 Sep 2022 10:32:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t70so864980pgc.5;
        Fri, 23 Sep 2022 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=W36UO1DduOC6lC3UNJg02JeBSkjr99vbivlTYF45xZc=;
        b=gDA5yBkpK4OWYC5cZvGc6utQAk9oEdh/gpbKjvPsXUNTMrEb2lwTSQiS5ZvKB+1MN9
         XOrCSW+9RLLenEQ5V6tzeC8riGsKy/5HNhqseAvW9M5RKBHBEukFaoXsmCccq281TBG6
         jbv5xI/hzc73ldboUea3lLak3pn0hJchYcTe7gWb5IYggIGaYrnGAl6P5p+9pPqdr3Z+
         RQ60tKvK//lU4G7FEAsIK5JVwXIKuSrBVJNMjYQjGvSgdvGvR0WXdj3vGA2DSxCE9l9u
         DMfk/XpCAtq3tEYeANahQJEcils1agEfHzHFw6iNvIxSRU6Sr2+szRJsYDMM1dOKAVGw
         9CDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=W36UO1DduOC6lC3UNJg02JeBSkjr99vbivlTYF45xZc=;
        b=ZE8SPPLImx51W1UZp2A4OeiWQFXxVQvKg0ycgMKR4waj4+qYaB9QWLVg2LtnExFP40
         QcWZWSDNY/WnN/tTCGZzYtPyttAbkpmL66Q3JSrcSqJCpfTGQOoruBFEV8hIGROpp0FR
         h+TjxpFwzgHtYxyveCNpH27du5ypbrOZd+OATt4tPnOAJSGqHiI7lyykUBbxzIPK0d7V
         bhgFq2cs0kOnNeWSwOnppNx8whSuJ1R1qwR/aUtsDUFUnScZHPJ4QfAwEGtX9nh3LwIl
         /71Ych+N7kgdy9DnYz49F6m0xktHIWcD7FdVNqTfgDW6CPCpJMPcOvcx3AmH01zq3R6V
         vKzA==
X-Gm-Message-State: ACrzQf26OImHNpJ34+V3NQFae8PK4h8NKuZ46tcIW3tH/ijMHOf3UYai
        OAH2tssMISiq/ezU79gro74=
X-Google-Smtp-Source: AMsMyM4cDzwcYZgEgP7IP60ApaJgt3rydvMoQd0oGcAKuxwhoEnd6NOUDlUCSiJ5dRHvSoh492r5JQ==
X-Received: by 2002:a63:618d:0:b0:43c:268a:8510 with SMTP id v135-20020a63618d000000b0043c268a8510mr6152772pgb.518.1663954325589;
        Fri, 23 Sep 2022 10:32:05 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:c716:a857:50ee:f56e])
        by smtp.gmail.com with ESMTPSA id 9-20020a621409000000b0053e6eae9668sm6719499pfu.2.2022.09.23.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:32:05 -0700 (PDT)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 2/4] perf inject: Clarify build-id options a little bit
Date:   Fri, 23 Sep 2022 10:31:40 -0700
Message-Id: <20220923173142.805896-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923173142.805896-1-namhyung@kernel.org>
References: <20220923173142.805896-1-namhyung@kernel.org>
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

Update the documentation of --build-id and --buildid-all options to
clarify the difference between them.  The former requires full sample
processing to find which DSOs are actually used.  While the latter simply
injects every DSO's build-id from MMAP{,2} records, skipping SAMPLEs.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-inject.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-inject.txt b/tools/perf/Documentation/perf-inject.txt
index 70e2ac3cc91a..c972032f4ca0 100644
--- a/tools/perf/Documentation/perf-inject.txt
+++ b/tools/perf/Documentation/perf-inject.txt
@@ -25,10 +25,12 @@ OPTIONS
 -------
 -b::
 --build-ids::
-        Inject build-ids into the output stream
+	Inject build-ids of DSOs hit by samples into the output stream.
+	This means it needs to process all SAMPLE records to find the DSOs.
 
 --buildid-all::
-	Inject build-ids of all DSOs into the output stream
+	Inject build-ids of all DSOs into the output stream regardless of hits
+	and skip SAMPLE processing.
 
 --known-build-ids=::
 	Override build-ids to inject using these comma-separated pairs of
-- 
2.37.3.998.g577e59143f-goog

