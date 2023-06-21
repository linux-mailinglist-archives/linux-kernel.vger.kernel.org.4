Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2201739057
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjFUTor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFUTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:44:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4385D1733;
        Wed, 21 Jun 2023 12:44:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-668711086f4so3026796b3a.1;
        Wed, 21 Jun 2023 12:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376684; x=1689968684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6toF7rBgOobZWwzNn/wkMI+lBlT1PzkeUNueCz0uLY=;
        b=BRxZv5YbUO3mqeq5qnYxLw9p1M3Chql2NuBJIVn7S/h37+sCdQH2hvIf9uxu3GBKex
         RBFJ+U6Q4mVnwKcv9qpSuYIYRmrLl88/SyjZblDY40tyEWGkbBK+3bziACwCcUhwxEi8
         JEr6w09TduzhVmaQY8w4V9B2Pwjn9IfsrhGew2f0mpprnU3dYWZmDf/aSCqgvwVyG9RR
         VKVJSCHHMcNLtWETYPzfyEjbeiCL3nGa6j+EkHxHMGRxSFFuML266+W5rxqxaQb0uoNX
         11rN7GyFC5HuHTgQnBwxaFvFOEh1eVwaTZnxeVuE6Q73eYDhKWc73czoNshq5cqsB3AH
         a86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376684; x=1689968684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6toF7rBgOobZWwzNn/wkMI+lBlT1PzkeUNueCz0uLY=;
        b=OEtXtdV8fbkS0jrQ2jOKzJLlujNkZuiXoUB022Pe+avO1ysAMMcejJM5ymB4FS5kjg
         lB8wFP03WNz0Gabv9vpv/X6Zk09Leu8U8NhbHs+yBCZqw5oUHjDUAAGDRDH3ImbnDEy9
         jHQ4kou8vEs/E3FUOQhu29VW9KguVjlaw9zGV/b+XrHV29IUCv8gk/AQVL7YLsXLr+MC
         1PlSKM0S/KkN5uUiIQT13pMfvKJ87Y0pmjECDW1S71yrq/TnensFWOEcvHy9WsH4DMBo
         6KCn17YRQkhtNiruHmwafRJ+f4UzwnCMZay/WIHA023nNKOkB18TFsq0efbT91/OQOAX
         jp9Q==
X-Gm-Message-State: AC+VfDwgNNG74kB+fM/8OyHuHjAWWfUL0unSKef7aCtg8jWFIgoYWf3/
        sWTKhl6dGK+mS5amqwlYbYI=
X-Google-Smtp-Source: ACHHUZ5hAeUCMieuUlk1311Ds9jJRgR4VP52ZCM7xa99c5ayBFd8ORy0j+VV0DYo83KsU3nvqQ3cDQ==
X-Received: by 2002:a05:6a00:218e:b0:667:d0ff:6a0f with SMTP id h14-20020a056a00218e00b00667d0ff6a0fmr16310098pfi.5.1687376683591;
        Wed, 21 Jun 2023 12:44:43 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b0063b6cccd5dfsm3257338pfp.195.2023.06.21.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:44:43 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:14:35 +0530
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
Subject: [PATCH 6/9] scripts: python: implement get or create stack function
Message-ID: <f7dd718e370e7385d6652baba173b8d211661256.1687375189.git.anupnewsmail@gmail.com>
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

The get_or_create_stack function is responsible for retrieving
or creating a stack based on the provided frame and prefix.
It first generates a key using the frame and prefix values.
If the stack corresponding to the key is found in the stackMap,
it is returned. Otherwise, a new stack is created by appending
the prefix and frame to the stackTable's 'data' array. The key
and the index of the newly created stack are added to the
stackMap for future reference.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 tools/perf/scripts/python/firefox-gecko-converter.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
index cdd7f901c13f..30fc542cfdeb 100644
--- a/tools/perf/scripts/python/firefox-gecko-converter.py
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -57,6 +57,18 @@ def convertPerfScriptProfile(profile):
             },
             'data': [],
         }
+        
+        stringTable = []
+
+        stackMap = dict()
+        def get_or_create_stack(frame, prefix):
+            key = f"{frame}" if prefix is None else f"{frame},{prefix}"
+            stack = stackMap.get(key)
+            if stack is None:
+                stack = len(stackTable['data'])
+                stackTable['data'].append([prefix, frame])
+                stackMap[key] = stack
+            return stack
 
         def addSample(threadName, stackArray, time):
             nonlocal name
-- 
2.34.1

