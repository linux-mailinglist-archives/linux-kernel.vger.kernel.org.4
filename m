Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891F73904C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjFUTmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjFUTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:41:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EE81733;
        Wed, 21 Jun 2023 12:41:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b52864b701so48363325ad.3;
        Wed, 21 Jun 2023 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376517; x=1689968517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EOjusGezgUEDaoouw0ul4hE6YXmt391w2kXuFkLv/E=;
        b=l3fqFnRFxZnqbhQOOMFmGaKdbzianAEuvAsWRZi2xnf6kpwmW78uMK7SYQcz99HQOV
         G3JNbW1/SBgFXl5woRvHfbAOoxkKBBN5jtrA/w+txXRJ0eMvzTaiEFW7+56aE16nw/1G
         s7Qk5O8kTFut6rh5YhzhfJ9s9E3aiTfh/fqM9BzN5gUIyCyCGH/F32pCDXurmmfoZjNZ
         g7eEx4SgM/ddPfqtEKf52CnX2n86nq7Bkos+k66rWmigk2Mda+rspj5t+oXayTFY0fBm
         B4zVoG5rYTZxf4OBmuCrOXZ8Ec+PGkyUgwTECUUv/AVKz8f4jYUDhZXXp0qy3aOJbB9D
         9RGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376517; x=1689968517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EOjusGezgUEDaoouw0ul4hE6YXmt391w2kXuFkLv/E=;
        b=RHvFTfI0oR6fyC4lg9WSgYg+xP6ysJaWsKiH5JBtNlnZy1unN9AgF22xW8FSlqP8xM
         CwAebp2KRg0gJ5dMTYYJHiN3SSJjBrvHFhDkqeBCQieVmmOIA6yeOd9GmLInyuFzvJDY
         1DYzExnnMkDvUB5+M9lQNFnthIci9KG7JsonkUJz14+mZ73GxoCvKZ5DMG1B0ycCcoS4
         xzolBFuNBZgKF7N6maVLcfboqeVHf53sNxVR64Weiku6wmtDG8c1nDmtBVs7U4ml7vJL
         lomsuicRmZ/rvHWvY0Ap9j7z2GD7WDlw2WhfOeX3WgOhS/U/Eb99lHAU3n3/bcbhc5sx
         jr9A==
X-Gm-Message-State: AC+VfDwku36HeQ6y3/mzljz+X+JqJZ2ruPnTmcv7Rz75euVSie26lXcY
        QCSiReAK2WLEnLsKr94V68s=
X-Google-Smtp-Source: ACHHUZ5lbjS2yji51QQw2AqUU4zvpeVZrjVQzZsWH7OScLOZWinv5Wiylwwt33cJWwGei7hS2UuPVQ==
X-Received: by 2002:a17:902:a3c7:b0:1b5:361:cefe with SMTP id q7-20020a170902a3c700b001b50361cefemr14038204plb.52.1687376516573;
        Wed, 21 Jun 2023 12:41:56 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902a60d00b001ae0a4b1d3fsm3883794plq.153.2023.06.21.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:41:55 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:11:48 +0530
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
Subject: [PATCH 4/9] scripts: python: Implement parsing of input data in
 convertPerfScriptProfile
Message-ID: <3772bce9068962f2a4c57672e919ebdf30edbc5c.1687375189.git.anupnewsmail@gmail.com>
References: <cover.1687375189.git.anupnewsmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687375189.git.anupnewsmail@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lines variable is created by splitting the profile string into individual
lines. It allows for iterating over each line for processing.

The line is considered the start of a sample. It is matched against a regular
expression pattern to extract relevant information such as before_time_stamp,
time_stamp, threadNamePidAndTidMatch, threadName, pid, and tid.

The stack frames of the current sample are then parsed in a nested loop.
Each stackFrameLine is matched against a regular expression pattern to
extract rawFunc and mod information.

Also fixed few checkpatch warnings.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 62 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 0ff70c0349c8..e5bc7a11c3e6 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -1,4 +1,5 @@
 #!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
 import re
 import sys
 import json
@@ -14,13 +15,13 @@ def isPerfScriptFormat(profile):
     firstLine = profile[:profile.index('\n')]
     return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
 
-def convertPerfScriptProfile(profile): 
+def convertPerfScriptProfile(profile):
 
         def addSample(threadName, stackArray, time):
             nonlocal name
             if name != threadName:
                 name = threadName
-            # TODO: 
+            # TODO:
             # get_or_create_stack will create a new stack if it doesn't exist, or return the existing stack if it does.
             # get_or_create_frame will create a new frame if it doesn't exist, or return the existing frame if it does.
             stack = reduce(lambda prefix, stackFrame: get_or_create_stack(get_or_create_frame(stackFrame), prefix), stackArray, None)
@@ -54,3 +55,60 @@ def convertPerfScriptProfile(profile):
             thread = _createtread(threadName, pid, tid)
             threadMap[tid] = thread
         thread['addSample'](threadName, stack, time_stamp)
+
+    lines = profile.split('\n')
+
+    line_index = 0
+    startTime = 0
+    while line_index < len(lines):
+        line = lines[line_index]
+        line_index += 1
+    # perf script --header outputs header lines beginning with #
+        if line == '' or line.startswith('#'):
+            continue
+
+        sample_start_line = line
+
+        sample_start_match = re.match(r'^(.*)\s+([\d.]+):', sample_start_line)
+        if not sample_start_match:
+            print(f'Could not parse line as the start of a sample in the "perf script" profile format: "{sample_start_line}"')
+            continue
+
+        before_time_stamp = sample_start_match[1]
+        time_stamp = float(sample_start_match[2]) * 1000
+        threadNamePidAndTidMatch = re.match(r'^(.*)\s+(?:(\d+)\/)?(\d+)\b', before_time_stamp)
+
+        if not threadNamePidAndTidMatch:
+            print('Could not parse line as the start of a sample in the "perf script" profile format: "%s"' % sampleStartLine)
+            continue
+        threadName = threadNamePidAndTidMatch[1].strip()
+        pid = int(threadNamePidAndTidMatch[2] or 0)
+        tid = int(threadNamePidAndTidMatch[3] or 0)
+        if startTime == 0:
+            startTime = time_stamp
+        # Parse the stack frames of the current sample in a nested loop.
+        stack = []
+        while line_index < len(lines):
+            stackFrameLine = lines[line_index]
+            line_index += 1
+            if stackFrameLine.strip() == '':
+                # Sample ends.
+                break
+            stackFrameMatch = re.match(r'^\s*(\w+)\s*(.+) \(([^)]*)\)', stackFrameLine)
+            if stackFrameMatch:
+                rawFunc = stackFrameMatch[2]
+                mod = stackFrameMatch[3]
+                rawFunc = re.sub(r'\+0x[\da-f]+$', '', rawFunc)
+
+            if rawFunc.startswith('('):
+                continue # skip process names
+
+            if mod:
+                # If we have a module name, provide it.
+                # The code processing the profile will search for
+                # "functionName (in libraryName)" using a regexp,
+                # and automatically create the library information.
+                rawFunc += f' (in {mod})'
+
+            stack.append(rawFunc)
+
-- 
2.34.1

