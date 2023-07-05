Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FAA748E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjGETsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjGETsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:48:43 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59610FC;
        Wed,  5 Jul 2023 12:48:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6682909acadso32574b3a.3;
        Wed, 05 Jul 2023 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688586522; x=1691178522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nwmiw8kqzz8HG3/q8vV707Kb04avPuRY7Vptw/E/9iA=;
        b=XMX9vGJ3vgS1YR9suzkK1qqrmkpIqmrmAsgRRYbxxTDEBj9gP/e/b8d4VzRXQj+ZUe
         +QlXqk0PGs7Ht2p+i+KqE/0CHwQjCDPIwxj3J0sm9XQolhAAITmHVZIGPVzf+4jcA93L
         ahFqoOe59sQUzcydyip4GKLGo9GemKzuf2suRmYl3bI8jeOVQac7LZmDzAfs8znF/ioz
         JtKjRfKSo00wk7Ar9V5DE5h9RdOKdsCjYT32SxPi3WkFkDQRY62cSiCKMllaURNb8BFF
         p5tiLEFB6X3AocwXzj2R4LOVl7h00qmFJl2DDpDcJHW1E3UBNyyB8QIcaLy8R2Gyh/Kf
         u/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688586522; x=1691178522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwmiw8kqzz8HG3/q8vV707Kb04avPuRY7Vptw/E/9iA=;
        b=Ml1i0/8sqz1F0e7ME/56bpJKOkyVkIkxKsVNAXExN8baULVlqyjWUFyN0dQe2WFWPL
         fi4t4fSoIDwmKcSbtJMsU8cFgESH9V8+f1ZZfvmdlF1DXdp/HdHWqXV6Ra7yl096H/m6
         lNf3JYGvd/TP0NnXE/4eIL8XyzdWAkwdVZVqiujW/j6sRxQDsFOOXjtIzmctMAkQrsUP
         qeIpwVDTHRkWoyDot/PEb5PR7d0KHM29BAVCwJ1BRvuOXgq7cEFBOGk+H851ZDUVu+5l
         yL2l4J5sk01N3FeMTxCdBUA81+7PQJroJwzFVcL74SQtShVaW+e/oZdT8Rb4irfLi1oC
         IxMA==
X-Gm-Message-State: ABy/qLby4akpR9+bXnw2EpnVHB7ARl8UkZ2FimyvUlfYFLV20h36hZwo
        gE9B6Y40P/U/kR1vN8ca8J4=
X-Google-Smtp-Source: APBJJlHg+O+p8sad9sRSUZCKtzRPgzmOdoXVj+MU4BKD8Zr76cr6X4Pf8mLTbqeSC/zaoKAbZ5bKIA==
X-Received: by 2002:a05:6a00:248f:b0:668:7292:b2c2 with SMTP id c15-20020a056a00248f00b006687292b2c2mr15585714pfv.2.1688586521656;
        Wed, 05 Jul 2023 12:48:41 -0700 (PDT)
Received: from yoga ([2400:1f00:13:c628:31be:68ae:86f5:48b9])
        by smtp.gmail.com with ESMTPSA id x16-20020a056a00271000b0067459e92801sm16197721pfv.64.2023.07.05.12.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:48:40 -0700 (PDT)
Date:   Thu, 6 Jul 2023 01:18:33 +0530
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
Subject: [PATCH v2 5/7] scripts: python: implement get or create frame
 function
Message-ID: <a5749b6a98928b2a8fa6c1dd1c54201334edb04b.1688585597.git.anupnewsmail@gmail.com>
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

The get_or_create_frame function is responsible for retrieving or
creating a frame based on the provided frameString. If the frame
corresponding to the frameString is found in the frameMap, it is
returned. Otherwise, a new frame is created by appending relevant
information to the frameTable's 'data' array and adding the
frameString to the stringTable.

The index of the newly created frame is added to the frameMap.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 6f69c083d3ff..d5b9fb16e520 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -77,6 +77,39 @@ def process_event(param_dict):
 				stackMap[key] = stack
 			return stack
 
+		frameMap = dict()
+		def get_or_create_frame(frameString):
+			frame = frameMap.get(frameString)
+			if frame is None:
+				frame = len(frameTable['data'])
+				location = len(stringTable)
+				stringTable.append(frameString)
+				category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 \
+						or frameString.find('/vmlinux') != -1 \
+						or frameString.endswith('.ko)') \
+						else USER_CATEGORY_INDEX
+				implementation = None
+				optimizations = None
+				line = None
+				relevantForJS = False
+				subcategory = None
+				innerWindowID = 0
+				column = None
+
+				frameTable['data'].append([
+					location,
+					relevantForJS,
+					innerWindowID,
+					implementation,
+					optimizations,
+					line,
+					column,
+					category,
+					subcategory,
+				])
+				frameMap[frameString] = frame
+			return frame
+
 	def _addThreadSample(pid, tid, threadName, time_stamp, stack):
 		thread = thread_map.get(tid)
 		if not thread:
-- 
2.34.1

