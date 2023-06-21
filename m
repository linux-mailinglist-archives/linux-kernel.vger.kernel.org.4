Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DA473905D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjFUTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjFUTqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:46:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB511988;
        Wed, 21 Jun 2023 12:46:20 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3421fb63796so26442785ab.2;
        Wed, 21 Jun 2023 12:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376780; x=1689968780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Thtk9tiUtPYtTI2fLQD5UkCvaUPoQ9DRCNShUGEYMp0=;
        b=gSahabEwy5Hh3zXDXTEzS+tGvVUnr9R7Ck3AEIoX5cIb+dCnn2IE0KYinP06Fb/EMV
         X57O5oZJ+yzFcrOK8I3VrVNVa9taGvOSLWMdfglKt6ETHMuB21BhsCIGVvZdlVGRXjPO
         hJhT7zjipvI7zxZOiG8/Z1OxdOBXKZSNJa12rl5G8mKuMZ+5N/csQ1t6/0ulm+LVXpJu
         Gkj6JXBfPNnzshxD1dsOqFRr/meTu9Ozuow1SrZHLKSnaxqzxOxL2HyZMTGDR16oal03
         /q+Wfvqu3DYGNZa9+RSvycw6akXac6RH8ZF+SSr9s7g6yOtZTi6yS7/Ysq9rygMcIDfm
         qS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376780; x=1689968780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Thtk9tiUtPYtTI2fLQD5UkCvaUPoQ9DRCNShUGEYMp0=;
        b=Dl6i+0y8DtUCshvLUvHvU21F0r/kAsN/jxf9TZZcHHmlr+X4f9bMFdnqOLNHz4w9Kv
         wC4dW7jIgCVEjdOO/eoj9KitaSkpCeLeDsR3f63V16ysQcPJWCfG35Tl+75BK/T1OmsT
         y0gW26i7lTTE+sScbENG0TvZz4zknhfs/BZEGSkxKbhjetEbc4jrAl1IDh0LaNK9IyIX
         U0zxObK+LqfgtD9Y8uvjfB3psNwvSdkFMDvumqjCK6DD48n9l/GVBffchgJaxCVw55Re
         cSzrg0Z2kFMeogU5POExGRiDjMvD/bMJMxvfiUS05OeasDk0cTxUoijYemROfGGdV1d+
         A7Ng==
X-Gm-Message-State: AC+VfDwiJfowQlfzswWK0ml1VeR9C8MzkzTvn6HX/rhA3BrA7YHOccSd
        2XYTsnuGH+pJgxpUTuxCJryK53OwzAti1TD1
X-Google-Smtp-Source: ACHHUZ4DzJZ6oW4X5y8F1eGwtxME5iVHvNu3wvNaBGlV6HUy10Uv4T7ZSIpvlQVtyMX9TWDa9YO8YQ==
X-Received: by 2002:a92:c10e:0:b0:33f:e84c:8dfd with SMTP id p14-20020a92c10e000000b0033fe84c8dfdmr14113138ile.13.1687376780236;
        Wed, 21 Jun 2023 12:46:20 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090ad50c00b0025e2b703adesm3512336pju.41.2023.06.21.12.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:46:19 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:16:12 +0530
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
Subject: [PATCH 8/9] scripts: python: Finalize convertPerfScriptProfile and
 return profile data
Message-ID: <d77db7e64ed51c585397405ca5921ba0436b2e3b.1687375189.git.anupnewsmail@gmail.com>
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

If the stack is not empty, it is reversed and then passed to
the _addThreadSample function along with other relevant information.
This adds the final sample to the thread.

The thread_array is generated by mapping the 'finish' method on each
thread in the threadMap and collecting the results.
The samples within each thread are sorted in ascending order based on
the 'time' field to ensure they are in the correct order.
This implementation finalizes the processing of the profile data in
convertPerfScriptProfile and returns a structured profile representation

I still need to get the product from the device, having little confusion
on this so will implement it on next version.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 866751e5d1ce..385a8b77a70a 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -64,7 +64,7 @@ def convertPerfScriptProfile(profile):
             },
             'data': [],
         }
-        
+
         stringTable = []
 
         stackMap = dict()
@@ -84,7 +84,7 @@ def convertPerfScriptProfile(profile):
                 frame = len(frameTable['data'])
                 location = len(stringTable)
                 stringTable.append(frameString)
-            
+
                 category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 or frameString.find('/vmlinux') != -1 or frameString.endswith('.ko)') else USER_CATEGORY_INDEX
                 implementation = None
                 optimizations = None
@@ -203,3 +203,36 @@ def convertPerfScriptProfile(profile):
 
             stack.append(rawFunc)
 
+        if len(stack) != 0:
+            stack.reverse()
+            _addThreadSample(pid, tid, threadName, time_stamp, stack)
+
+    thread_array = list(map(lambda thread: thread['finish'](), threadMap.values()))
+
+    for thread in thread_array:
+        # The samples are not guaranteed to be in order, sort them so that they are.
+        key = thread['samples']['schema']['time']
+        thread['samples']['data'].sort(key=lambda data : float(data[key]))
+
+    return {
+        'meta': {
+            'interval': 1,
+            'processType': 0,
+            'product': 'Linux perf',  # TODO: get this from the system
+            'stackwalk': 1,
+            'debug': 0,
+            'gcpoison': 0,
+            'asyncstack': 1,
+            'startTime': startTime,
+            'shutdownTime': None,
+            'version': 24,
+            'presymbolicated': True,
+            'categories': CATEGORIES,
+            'markerSchema': []
+            },
+        'libs': [],
+        'threads': thread_array,
+        'processes': [],
+        'pausedRanges': []
+    }
+
-- 
2.34.1

