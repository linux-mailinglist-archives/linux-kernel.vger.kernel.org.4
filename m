Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62E4748E24
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjGETmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjGETme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:42:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362969F;
        Wed,  5 Jul 2023 12:42:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262fa79e9b3so36943a91.0;
        Wed, 05 Jul 2023 12:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586152; x=1691178152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/jsFLrmNjyiYjHyvrw+WR7HDQEG+dPkNlGKVeYGi8I=;
        b=TIofqNfHFQobawWnN+T6CQEsoWs4vpXuIMoceRmfmefetUob0g5QvqAoEqZcl2i7jc
         2Mr8rKn7j5/6dwFuM2XU1I/z34IJR+FuRLXhnolSQhNqqvl02xQqaae2+vxrCQRLSMKK
         HIuIiFF0KjkmkG4oDTRRVHgHIN3Ulk/uzX+drgsTqafhvcJiuu4pE+I6CipUH3z6GIkz
         D0ouwF6+gtRkiBkyw3IGi1Eubc4orBkxsre0qlb9kd0uYewfH2rvX5KmdwPNDHCrlWnl
         btp5hmt9g/EMlHTyEoL3PZ0p/olYCCZ1cElBOt89P9UG6ftv5fLiQ84pvY3sy4xIPbZ0
         81hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586152; x=1691178152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/jsFLrmNjyiYjHyvrw+WR7HDQEG+dPkNlGKVeYGi8I=;
        b=h8HxZlihFZnhCIHAhjWHSfyWcoYf/q0/psPhwT/no0alTgd/GPiQI7fYm4GSmHLG4a
         cFhx4NHsDe7gsWydqlnv2wXmlaJXvzTAn09sj24HispeyRy4QVIqi53C0aAA3dIiToCl
         dMJiyGKlx02dAEIre374TydTIdd//knuLxsDoxd7b1uNZOnHoGqH9tFzDmKT8LD4YZmR
         2DUenN8zmCqSBEccQmtOoAkVQC/6GEhFgDHrFkWloGpOZBBrALxWffsL2ticQM4diAd9
         s11hVK4oJCoECn8++v9UjYHXVxQYMJkoVBt7CohOZNDrIxxU1L4K3Ce6n9LzBQ398Bvz
         bqJw==
X-Gm-Message-State: ABy/qLZkFu/GFsgVfKKlTJXrV98Nm+oEdYPlfjdhaVCglBOqstbLL0Qr
        ubc2n4TW/+Qa38tjwfl9Pg6PljXJY3i/CYZ4
X-Google-Smtp-Source: APBJJlEQL3jFIuy2rLQG/6Iqxy+qepTqVddqeBbkwO5Hsw9xmE7cFPHqYvTz3dUf4lfn7G5w5gSfEA==
X-Received: by 2002:a17:90b:30c3:b0:262:df79:6f81 with SMTP id hi3-20020a17090b30c300b00262df796f81mr12562185pjb.24.1688586152492;
        Wed, 05 Jul 2023 12:42:32 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001b54dcd84e2sm19286004plr.240.2023.07.05.12.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:42:31 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:12:23 +0530
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
Subject: [PATCH v2 1/7] scripts: python: Extact necessary information from
 process event
Message-ID: <de3f6251d7b0f202fac59224b9820b584233d871.1688585597.git.anupnewsmail@gmail.com>
References: <cover.1688585597.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688585597.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The script takes in a sample event dictionary(param_dict) and retrieves
relevant data such as time stamp, PID, TID, thread name, and call stack
information. If available, the call stack is parsed to include function
names and the associated DSO, which are requires for creating json schema.
Also few libaries has been included which will be used in later commit.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
new file mode 100644
index 000000000000..ce663840d212
--- /dev/null
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -0,0 +1,37 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Usage:
+#
+#     perf record -a -g -F 99 sleep 1
+#     perf script firefox-gecko-converter.py
+
+from __future__ import print_function
+import os
+import sys
+import json
+from functools import reduce
+
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+
+def process_event(param_dict):
+	time_stamp = (param_dict['sample']['time'] // 1000) / 1000
+	pid = param_dict['sample']['pid']
+	tid = param_dict['sample']['tid']
+	thread_name = param_dict['comm']
+	start_time = time_stamp if not start_time else start_time
+	if param_dict['callchain']:
+		stack = []
+		for call in param_dict['callchain']:
+			if 'sym' not in call:
+				continue
+			stack.append(call['sym']['name'] + f' (in {call["dso"]})')
+		if len(stack) != 0:
+			stack = stack[::-1]
+	else:
+		mod = param_dict['symbol'] if 'symbol' in param_dict else '[unknown]'
+		dso = param_dict['dso'] if 'dso' in param_dict else '[unknown]'
-- 
2.34.1

