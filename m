Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E097B7075AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEQW5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjEQW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:57:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073BB5588
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:57:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8338f2103so2306091276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684364233; x=1686956233;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBbfNLgp47qerbZQN8pnh9cpr4SM24rEuI3L1TB0yeI=;
        b=0BXInlF5XNaujd04SKNKhLC0QraDu3q54wJfCAI3yyCDxieZAk4aGf45OyoBtszeFf
         ksT4lb1MR0bD8kzXKq7BjbnrgSDIU73FScRY8BfaedrWMkT1AtZGg0KITWuxQ9RxB/BF
         XO9uqxPg1jiQO/y8deeMKeLgt37c4gSXm3brQngT7r0jtrxjgVeIxXjxAKth51AGS9Zp
         TlnGmoVv81vgpYDkVgJDVCipwOOvX8ptwK0+Cx1qmjAVwdbuzktg9Dt3sAwkVE2vsigs
         Izd+4RdO+grdZmyFrfDlDM91I1E2OZqezHTL7yg3laVXVVuZanrGmXnX8SP9rJZC99JX
         bS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684364233; x=1686956233;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBbfNLgp47qerbZQN8pnh9cpr4SM24rEuI3L1TB0yeI=;
        b=Avc7PUxBvk0lAsW6Fs0vVYAzNsV48JAnLSBVX+N4G22UqUKo8VO9MCDejaUdS4lIKa
         RxcG0TL6dy0aEiDn+64eXpUeJ4TqOBj00yH6RNnaPQ62mHGnvvPT9lvRTcawjBxR2foL
         AH7wHpMGkmL39IVnBgHCcQ9+76/xI3UumvJfU3u2fxjXcFB8fPh84zPvhVyr/3IZJMdK
         YE90Iyz1/LmhsNbxLPryqu3PjPL/7Of0ivPvZEa3Qoq6EmyobrDJbGU9tLF2ujiOUDAY
         ZaUIJbPAvIRe9mHuFM8M9x8H5mIcjsvXb24D9dVShuQuaXuaMR0P4rmnlA/U6q2t0L6q
         Xiug==
X-Gm-Message-State: AC+VfDzMw7PArOAiWPn+eDyZjQu0METFLkJiYE34Bo/fS5ydimJi8oQZ
        eDcg8/uvJR4lEiB2tfAuLEMRkp1co/13
X-Google-Smtp-Source: ACHHUZ5JKGrbbDm4qCCb60/dbnJrPpF6RfiNRDfeWhEA1VnkoI2Slb3dW8veIURGNW62HVzNTptEwA+fhd5t
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:eb06:5af6:40f:47ca])
 (user=irogers job=sendgmr) by 2002:a05:6902:12cd:b0:ba7:8099:c5f2 with SMTP
 id j13-20020a05690212cd00b00ba78099c5f2mr6661533ybu.8.1684364233142; Wed, 17
 May 2023 15:57:13 -0700 (PDT)
Date:   Wed, 17 May 2023 15:57:06 -0700
In-Reply-To: <20230517225707.2682235-1-irogers@google.com>
Message-Id: <20230517225707.2682235-2-irogers@google.com>
Mime-Version: 1.0
References: <20230517225707.2682235-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Subject: [PATCH v1 2/2] perf test attr: Fix deprecation warning
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address the warning:
```
tests/attr.py:155: DeprecationWarning: The SafeConfigParser class has
  been renamed to ConfigParser in Python 3.2. This alias will be
  removed in Python 3.12. Use ConfigParser directly instead.
parser = configparser.SafeConfigParser()
```
by removing the word 'Safe'.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/attr.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index ccfef861e931..e890c261ad26 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -152,7 +152,7 @@ def parse_version(version):
 #   - expected values assignments
 class Test(object):
     def __init__(self, path, options):
-        parser = configparser.SafeConfigParser()
+        parser = configparser.ConfigParser()
         parser.read(path)
 
         log.warning("running '%s'" % path)
@@ -247,7 +247,7 @@ class Test(object):
         return True
 
     def load_events(self, path, events):
-        parser_event = configparser.SafeConfigParser()
+        parser_event = configparser.ConfigParser()
         parser_event.read(path)
 
         # The event record section header contains 'event' word,
@@ -261,7 +261,7 @@ class Test(object):
             # Read parent event if there's any
             if (':' in section):
                 base = section[section.index(':') + 1:]
-                parser_base = configparser.SafeConfigParser()
+                parser_base = configparser.ConfigParser()
                 parser_base.read(self.test_dir + '/' + base)
                 base_items = parser_base.items('event')
 
-- 
2.40.1.606.ga4b1b128d6-goog

