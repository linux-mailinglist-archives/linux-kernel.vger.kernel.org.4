Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84A774E221
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjGJXPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGJXPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:15:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9321B7;
        Mon, 10 Jul 2023 16:15:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55b1238a013so3633707a12.3;
        Mon, 10 Jul 2023 16:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689030917; x=1691622917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAwiz27o1hNxGAQwrIRT6lxtMelfroQzik/QCJDjd3Q=;
        b=b0GCU0td2713cSKuiHV/PsI8IVs/WmY2ym5aADJqcjTx3HWC7XNdRQaDOPXjNIRYgc
         WEnpFPR4gSrPyWkqlStg3rQwvlKROz9w4/WU0yKShDufhQmZC3BCyxgetFfqtU8wNtIS
         QKiesFEBkm6SxRTGJc8lkWRD/sDTfDpZgEo/QYy4U73TeCaoaqqiHwTbIRFCjyi5rTHT
         3+sJxKowFugyM4/TPZSjBML2/CE3P4p00enxTxrL0ab4c/gyDRxpx6LEPqTs7n/oexWl
         OdXP/MDVFIVkjj1zGsC76AG05Gt5cueT4C3vMoQkdw4BB6BiyHuaLdtY1xVen6ZEH2WB
         GadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689030917; x=1691622917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAwiz27o1hNxGAQwrIRT6lxtMelfroQzik/QCJDjd3Q=;
        b=JTzM+cq9x4Q+ptV2Lx8YLfJx9BaiEiismcM8uVTHc7ChnITAuCSsaOku+Brnv6y2M7
         coUY+k40zJeP968xDE8R9HT7GB/IIe7e9Pw1cQnvC5g4E2bxUzfg5xrpCOdfqH+BQcUg
         vaMJlN4Z5piWF9VE1L/K3nu6So4bIHoTz9uK0L/bpYvyQOCqwyv7A2DNzrx2lwVPxTnS
         hsaRlPakX1b8THect0TgJ1x/ayVkWwLIIG+KCHwo4BIzBv5xwdXGTyqqB+bt7UQbux+U
         a9Wp4ddEJ1DUiKnFXBLdVv7lGHFFtC/ZKQ3wy/bvd3D04n1pSMWj/aS1E1N9qB8N0Jpa
         vODQ==
X-Gm-Message-State: ABy/qLZsQXZbVf4a3KCzwY3KrAN3Ues4HBW1nrX8HbFFr9OmhzYXT3LH
        6ev/mEQUuIDD148h/g//yXQ=
X-Google-Smtp-Source: APBJJlF6C6Tptsh25nmcDwQDB9YW4j1H6BPwVehKw7ItD6HJJIsYlF3lN3rYWXHtoWKCKMoVaY6dzA==
X-Received: by 2002:a05:6a20:54a7:b0:131:a21:9f96 with SMTP id i39-20020a056a2054a700b001310a219f96mr11740678pzk.6.1689030917027;
        Mon, 10 Jul 2023 16:15:17 -0700 (PDT)
Received: from yoga ([2400:1f00:13:76f2:868d:bc7d:562b:a5bb])
        by smtp.gmail.com with ESMTPSA id k22-20020aa792d6000000b00682868714fdsm325357pfa.95.2023.07.10.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:15:16 -0700 (PDT)
Date:   Tue, 11 Jul 2023 04:45:10 +0530
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
Subject: [PATCH v3 6/6] scripts: python: implement get or create frame and
 stack function
Message-ID: <dd26619520465132d33dd84780859e6bf89133bf.1689024635.git.anupnewsmail@gmail.com>
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

Complete addSample function, it takes the thread name, stack array,
and time as input parameters and  if the thread name differs from
the current name, it updates the name. The function utilizes the
get_or_create_stack and get_or_create_frame methods to construct
the stack structure. Finally, it adds the stack, time, and
responsiveness values to the 'data' list within 'samples'.

The get_or_create_stack function is responsible for retrieving
or creating a stack based on the provided frame and prefix.
It first generates a key using the frame and prefix values.
If the stack corresponding to the key is found in the stackMap,
it is returned. Otherwise, a new stack is created by appending
the prefix and frame to the stackTable's 'data' array. The key
and the index of the newly created stack are added to the
stackMap for future reference.

The get_or_create_frame function is responsible for retrieving or
creating a frame based on the provided frameString. If the frame
corresponding to the frameString is found in the frameMap, it is
returned. Otherwise, a new frame is created by appending relevant
information to the frameTable's 'data' array and adding the
frameString to the stringTable.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py | 57 ++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 6c934de1f608..97fbe562ee2b 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -21,6 +21,8 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 from perf_trace_context import *
 from Core import *
 
+USER_CATEGORY_INDEX = 0
+KERNEL_CATEGORY_INDEX = 1
 thread_map = {}
 start_time = None
 
@@ -34,7 +36,12 @@ CATEGORIES = [
 PRODUCT = os.popen('uname -op').read().strip()
 
 def trace_end():
-    thread_array = thread_map.values()))
+    thread_array = list(map(lambda thread: thread['finish'](), thread_map.values()))
+
+# Parse the callchain of the current sample into a stack array.
+    for thread in thread_array:
+        key = thread['samples']['schema']['time']
+        thread['samples']['data'].sort(key=lambda data : float(data[key]))
 
     result = {
         'meta': {
@@ -106,7 +113,55 @@ def process_event(param_dict):
 		}
 		stringTable = []
 
+		stackMap = dict()
+		def get_or_create_stack(frame, prefix):
+			key = f"{frame}" if prefix is None else f"{frame},{prefix}"
+			stack = stackMap.get(key)
+			if stack is None:
+				stack = len(stackTable['data'])
+				stackTable['data'].append([prefix, frame])
+				stackMap[key] = stack
+			return stack
+
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
 		def addSample(threadName, stackArray, time):
+			nonlocal name
+			if name != threadName:
+				name = threadName
+			stack = reduce(lambda prefix, stackFrame: get_or_create_stack
+					(get_or_create_frame(stackFrame), prefix), stackArray, None)
 			responsiveness = 0
 			samples['data'].append([stack, time, responsiveness])
 
-- 
2.34.1

