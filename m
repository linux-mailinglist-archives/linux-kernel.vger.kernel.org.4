Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9737739047
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjFUTlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjFUTk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:40:58 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C486F10F2;
        Wed, 21 Jun 2023 12:40:57 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b5853a140cso2955398a34.2;
        Wed, 21 Jun 2023 12:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376457; x=1689968457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6fzDc08vVPZzlFC9nTdHH7skPWJt+F7WIyjmhwelB8=;
        b=o9YaNWhP84f6bgxDYS3eKfvgDpWCQISxWH1ZNUz6gEJ9JTNtPNhStfAaNEkWoJAuVI
         VjDv1f7/7kbBkEwPgfpLslKslOnNxkoNj/qAwp4aZ7pFcxliZ8Z0WRg8IRiUZLa0dQMA
         f7sXdniO/by9pHXMQY1LICC2J7WRSQpYLlPf/z4lCya0ushy/zO+yBPX1Zgo2ddm+0yA
         oC4nUiJhrtBLA+39llzcPkS5juc4mgs+3SO3T0sq2WSsATSV6aoKHEe2ufv/7b5l/59I
         /wR+21Cbu6/AXi7Px4u0zq52udxHPGts+BK79XXwyUXV3Hns0v/pF3hO8xpdFaT5lW6/
         q1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376457; x=1689968457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6fzDc08vVPZzlFC9nTdHH7skPWJt+F7WIyjmhwelB8=;
        b=h6maqWUXqRarT9Fg5zOny8B0qRVAGoDS8hTeLcMHc6a5UNd6ob36+9mByAG/P6uO77
         lT90C4BHdTzIzaUpYATAQUNvD4i1gmDss7UxTHYb4tvvHGz7iUnVN2V8KYr9Vv5BdTMO
         rctlsF06Lay+b9/fpWp1Zx2/utnaoIT+GOsUw6V0he0GjUK5324aXe0VVmSZ7CsbOnlP
         /W90rhL+mlhAGkGbDWE3C3zJOuSoviv+INmrloYHc0f7FM7BDfMRzFW2yJGdC4cP6Njf
         12fFPpjm3dJ08X3ZpXHdGWOhq+4QtgT2KIzHZNVHR+4gU6dKRt6wHxcafyTi3+/IU7aG
         g/Tw==
X-Gm-Message-State: AC+VfDyHd9MxWELjuGGTTWGGCjy8q0yapvtOV/FQpsTFlNw5Fhr+lSlJ
        JXuz2KqlrVmNCUIJCseTKPc=
X-Google-Smtp-Source: ACHHUZ5v8fJJe/3SfN1+J65oY7NO0euJvdyFcCsON0i8S62Mc+vZy99GBz0EMzt0KE2ju7x93h+BWQ==
X-Received: by 2002:a05:6830:10d6:b0:6b5:8de5:a02c with SMTP id z22-20020a05683010d600b006b58de5a02cmr6145285oto.6.1687376456926;
        Wed, 21 Jun 2023 12:40:56 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id c9-20020a631c49000000b0054fa8539681sm3457291pgm.34.2023.06.21.12.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:40:56 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:10:48 +0530
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
Subject: [PATCH 3/9] scripts: python: Introduce thread sample processing in
 convertPerfScriptProfile
Message-ID: <42ba5416982056273960f182e8a79fd998639bcd.1687375189.git.anupnewsmail@gmail.com>
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

The _addThreadSample function is responsible for adding a sample to a specific
thread. It takes the process ID (pid), thread ID (tid), thread name, timestamp
(time_stamp), and stack as parameters. It first checks if the thread exists in
the threadMap dictionary. If not, it creates a new thread using the _createtread
function and assigns it to the threadMap. Finally, it calls the 'addSample' method
of the thread, passing the thread name, stack, and timestamp.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/firefox-gecko-converter.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index 2817d4a96269..0ff70c0349c8 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -46,3 +46,11 @@ def convertPerfScriptProfile(profile):
             "addSample": addSample,
             "finish": finish
         }
+
+    threadMap = dict()
+    def _addThreadSample(pid, tid, threadName, time_stamp, stack):
+        thread = threadMap.get(tid)
+        if not thread:
+            thread = _createtread(threadName, pid, tid)
+            threadMap[tid] = thread
+        thread['addSample'](threadName, stack, time_stamp)
-- 
2.34.1

