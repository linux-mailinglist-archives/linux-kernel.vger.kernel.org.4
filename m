Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46F874E218
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjGJXNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjGJXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:13:19 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B99E;
        Mon, 10 Jul 2023 16:13:18 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so4468817b3a.1;
        Mon, 10 Jul 2023 16:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689030798; x=1691622798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBGlQsi0NW10Pr3RCzCrk5y26OBsbX2q8LbZgkSF6bI=;
        b=OXkAr0vN5GVizLDpJNmNvYVQjQp+Qj7fP8tDpQxWGxT6s2HOgYPgsgTnfzDoYHm6dx
         4RcrVFIT2gE18YGPJXQKkMiewTuvJOdY4DIM3LJwSW0ABQ2vtDI2xvaVFSE42p84ovd9
         PsBXCf9wa1B+ctIubXlKq9Y9NlX4zN4ugjWFYDr0DeSVAIWhktsSkXUiHfPZt8+9VHs4
         pRoboiKKOorKqUXkpYYTdoHYiizUxXILf5WugY+KXR8lDumopRYexlOlJpz3xmupdBsa
         6wWcyyRSlUMxVyMZBznBLi08YqencKeP9FYkpci2StgBYOOUsD2LH3+rwiZ9s2a9MLHm
         crbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030798; x=1691622798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBGlQsi0NW10Pr3RCzCrk5y26OBsbX2q8LbZgkSF6bI=;
        b=O3Gft5vmZNNvZYCqLUryDh9yK4R4FxnbV23TehCVS/y1VqXIA+F4hhHUKIpXJjXLzI
         XJ+hCcDdS4ddX22kpO1+Yr4kJ8nLb+kqtbLV6lK8zIOkeTRC3aFYV3JlRI1MGO0Mqaoj
         zgvPJzyb8W8JQrrrG85JDapQDjs4uReVeGTKPdio7gd9M+a9fFRirF1beO5VYC5vjmr2
         FTC42LIS38rkJGdHGMUUm10uOt5JNU1TnqEumql3gJM0jJ++6OebUh9Kjp8l6HA7gSFU
         Lyc21CQkaOukNeIQLf8rCQUG7I2bSe9u4nQsdtHf699OhPxPnEwuovTZwHP50jIkrxaB
         QfGw==
X-Gm-Message-State: ABy/qLZdLynFaT0wq/ARkt+5iLMALt247F+UE9uMSZxw2lRKPkdRRKVZ
        W09sIehSBYcAwTYvDCjuGMA=
X-Google-Smtp-Source: APBJJlEjrB+QuHD8kR2LCfYOwphuv1tRhHLaQNa/4w/WzsX/3L3Tu+ZiiG4dnZjrlHGek+hTTMltjA==
X-Received: by 2002:a05:6a20:1601:b0:10d:5430:c8d6 with SMTP id l1-20020a056a20160100b0010d5430c8d6mr18241619pzj.0.1689030797581;
        Mon, 10 Jul 2023 16:13:17 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id fe23-20020a056a002f1700b0066ebaeb149dsm314797pfb.88.2023.07.10.16.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:13:17 -0700 (PDT)
Date:   Tue, 11 Jul 2023 04:43:10 +0530
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
Subject: [PATCH v3 3/6] scripts: python: thread sample processing to create
 thread with schemas
Message-ID: <70fd94954a3872caeef5851607b245394149f4a9.1689024635.git.anupnewsmail@gmail.com>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689024635.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _addThreadSample function is responsible for adding a sample
to a specific thread. It first checks if the thread exists in
the thread_map dictionary.

The markers structure defines the schema and data for
thread markers, including fields such as 'name',
'startTime', 'endTime', 'phase', 'category', and 'data'.

The samples structure defines the schema and data for thread
samples, including fields such as 'stack', 'time', and
'responsiveness'.

The frameTable structure defines the schema and data for frame
information, including fields such as 'location', 'relevantForJS',
'innerWindowID', 'implementation', 'optimizations', 'line',
'column', 'category', and 'subcategory'.

The purpose of this function is to create a new thread structure
These structures provide a framework for storing and organizing
information related to thread markers, samples, frame details,
and stack information.

The call stack is parsed to include function names and the associated
DSO, which are requires for creating json schema. Also few libaries
has been included which will be used in later commit.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 765f1775cee5..0b8a86bdcab1 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -21,6 +21,7 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 
+thread_map = {}
 start_time = None
 
 def trace_end():
@@ -28,6 +29,57 @@ def trace_end():
 
 def process_event(param_dict):
 	global start_time
+	global thread_map
+
+	def _createThread(name, pid, tid):
+		markers = {
+			'schema': {
+				'name': 0,
+				'startTime': 1,
+				'endTime': 2,
+				'phase': 3,
+				'category': 4,
+				'data': 5,
+			},
+			'data': [],
+		}
+		samples = {
+			'schema': {
+				'stack': 0,
+				'time': 1,
+				'responsiveness': 2,
+				},
+			'data': [],
+		}
+		frameTable = {
+			'schema': {
+				'location': 0,
+				'relevantForJS': 1,
+				'innerWindowID': 2,
+				'implementation': 3,
+				'optimizations': 4,
+				'line': 5,
+				'column': 6,
+				'category': 7,
+				'subcategory': 8,
+			},
+			'data': [],
+		}
+		stackTable = {
+			'schema': {
+				'prefix': 0,
+				'frame': 1,
+			},
+			'data': [],
+		}
+		stringTable = []
+
+	def _addThreadSample(pid, tid, threadName, time_stamp, stack):
+		thread = thread_map.get(tid)
+		if not thread:
+			thread = _createThread(threadName, pid, tid)
+			thread_map[tid] = thread
+
 	# Extract relevant information from the event parameters. The event parameters
 	# are in a dictionary:
 	time_stamp = (param_dict['sample']['time'] // 1000) / 1000
@@ -37,3 +89,21 @@ def process_event(param_dict):
 
 	# Assume that start time is the time of the first event.
 	start_time = time_stamp if not start_time else start_time
+
+	# Parse the callchain of the current sample into a stack array.
+	if param_dict['callchain']:
+		stack = []
+		for call in param_dict['callchain']:
+			if 'sym' not in call:
+				continue
+			stack.append(call['sym']['name'] + f' (in {call["dso"]})')
+		if len(stack) != 0:
+			stack = stack[::-1]
+			_addThreadSample(pid, tid, thread_name, time_stamp, stack)
+
+	# During perf record if -g is not used, the callchain is not available.
+	# In that case, the symbol and dso are available in the event parameters.
+	else:
+		func = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
+		dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
+		_addThreadSample(pid, tid, thread_name, time_stamp, [func + f' (in {dso})'])
-- 
2.34.1

