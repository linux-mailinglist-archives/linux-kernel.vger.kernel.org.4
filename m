Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7D474E20E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjGJXKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGJXKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:10:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4A31BC;
        Mon, 10 Jul 2023 16:10:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-26598fc0825so1752305a91.0;
        Mon, 10 Jul 2023 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689030642; x=1691622642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNmeeRduS9hujTrUN0M+dmMgGxYGX8uEUfhYcfOYymg=;
        b=CPziO0/boaqbaHNRFbRAn6svFGoaxS4y3UQaqEdmPdQD100wdIzoZZUBW/OdaFqKyR
         kVJWKil7yB7MDnWrCkpO0Re0A9fbvIaxU3TXI1RjMy5Pe7Jcwi38EOuuu/2pcGnwsStI
         76HznsqwJK3SFEqR94ILTF+sq3Fo8mckSCamxKqiN3y4TPY1sohZZLShFkk63gFjbrLl
         MLhQxoRaCXrUK8ZSHIcuOA88Y7ZvfquaPuA5CM2R8PXMkPZRbEvTdOfEafvWiJ2EF19s
         VBWIEGEtAJ40rYhekFltZKyn43g17t3a+qhPx/ylexbrITG9Q2uhyUFh62XodybWS9/v
         PEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030642; x=1691622642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNmeeRduS9hujTrUN0M+dmMgGxYGX8uEUfhYcfOYymg=;
        b=lDh/+F8ujKNQnvXLQ9KlDo/k2TOHQ+DQd23mQaFbOAn/yu84SrD8VAr0sLrjKJYywL
         NBPxU6eZjkxlLSc1mM6xpx5ypXAbStIXzWHN2eBx2nB5bFqRT+Px5MpHzcAO8uY5qblw
         xIiDYZY4onoCj1wX1Gw7aSIRFWkdVqCdT+1EHLsxanjYFIstsN9Hu8dAu9Wtzhasw2r9
         ELcDWPZJd2k45L4bvvASbjqGgaQ+fMvzZ5jXhXPjR0oJbCsaJ+aNPUP9Beugn5fZ54Tj
         ddjpcdlDGrZ6kjjk86GVUkf5N7mnSLq4HrjzNjiQ4hqv1axXjsWJAFDK+CK2EHMi++Jh
         ddpQ==
X-Gm-Message-State: ABy/qLYzOhl0uXBBWy8h0XQ9RkNG3+MgacVhQ471qVtsepS8HhFynxS9
        wyBFnKgArCv0oi03iHA9htU=
X-Google-Smtp-Source: APBJJlEOEGGbDVkNWLd92CS4nQGfnhewo7Lu4+7IWWAmdosKrgva54gLe97Ro1WymAGaE2Rh3ybmAQ==
X-Received: by 2002:a17:90a:8a14:b0:261:219b:13b3 with SMTP id w20-20020a17090a8a1400b00261219b13b3mr20346474pjn.16.1689030641684;
        Mon, 10 Jul 2023 16:10:41 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0026333ad02c1sm505433pjc.10.2023.07.10.16.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:10:41 -0700 (PDT)
Date:   Tue, 11 Jul 2023 04:40:33 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anup Sharma <anupnewsmail@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] scripts: python: Extact necessary information from
 process event
Message-ID: <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689024635.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script takes in a sample event dictionary(param_dict) and retrieves
relevant data such as time stamp, PID, TID, thread name. Also start time
is defined.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../perf/scripts/python/firefox-gecko-converter.py  | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 5b342641925c..765f1775cee5 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -21,8 +21,19 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 
+start_time = None
+
 def trace_end():
 	pass
 
 def process_event(param_dict):
-	pass
+	global start_time
+	# Extract relevant information from the event parameters. The event parameters
+	# are in a dictionary:
+	time_stamp = (param_dict['sample']['time'] // 1000) / 1000
+	pid = param_dict['sample']['pid']
+	tid = param_dict['sample']['tid']
+	thread_name = param_dict['comm']
+
+	# Assume that start time is the time of the first event.
+	start_time = time_stamp if not start_time else start_time
-- 
2.34.1

