Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5CE739036
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjFUThZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFUThU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:37:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4121992;
        Wed, 21 Jun 2023 12:37:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b5465a79cdso28158575ad.3;
        Wed, 21 Jun 2023 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376234; x=1689968234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wysmKxTjA5POXPuSnL3ZWdPlXIDrR3joMPak2RW+D1M=;
        b=S07+kLCUT/SwJ5u1DA+bkwXwy97NCQpkedZxhO8+z6Wq8+W6n5xNfqYhJNk24Dtx2J
         dsZxb94BkFneFYNQTcJrx8e3lpkdZnE1tJk7lz0V00qnMvjNIHqsPDTZbhqhTz6jHwvO
         6zjxgjTnw/hw9pNYqi6jVBHgBPAjDkE30MLk8M06RDHtHJa4nxy0YJn5kUvO35SLeyT8
         zy1l6SfvqEVmjFVNjvRL/Mr0Ot5X1KwelKNhaHVqD36RmV561WGqqqenu8/0Ran/6sRe
         Xlp8JlZCoyOMC3ds4twYoRWsqJkF0S9kPLKsYbVG52nnv76D7niK19XtvLp/MrLrzw6O
         9m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376234; x=1689968234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wysmKxTjA5POXPuSnL3ZWdPlXIDrR3joMPak2RW+D1M=;
        b=Qw9zjJPq7bIfEC1mR7TQtVVIb7vCsL/kWdwCB3rhWUgEsRkQP405SMK2pIwbcwlxYi
         p5Kgq7pIqYUqi2K4igh6HXqFt9IXKTipAB13Q0yu9fAhsKtEiQJqAHjaPV+2pwp1gEbD
         wFb8ZqPxTyu0ZWOryfLlWln5GGCn9XXSndZbfOjSnS1i3uZLmOQ4TpJGt0VYFN+TipZb
         dfaVSQVyXUCF9/qVjX3jLawxt3rOT2C7qPRfi7huTSSfJ+Y4i1oJs5fvvitfcWUn3sN/
         xlTY1iiA7ucUA93pAMpeuWFX/CyR8XVvzY5rxAYRdNBbBvqqrwgGOs54dSx1zrDVhx39
         SA4w==
X-Gm-Message-State: AC+VfDx9w7XVG2rEP+V6pSdeGmmLHiUd7WwVH2YRiDgnjSueYVyxE1ku
        XbXgjAfFiEuXSPkismqhwHs=
X-Google-Smtp-Source: ACHHUZ69TGI7UgaMNHlz30M9h5OSeOZkCCWPBquKQ2Y9Gao9+QHOyGF1n9se2Rl8repP0FTskygALQ==
X-Received: by 2002:a17:902:f551:b0:1b5:4f50:f1e0 with SMTP id h17-20020a170902f55100b001b54f50f1e0mr11017305plf.29.1687376234097;
        Wed, 21 Jun 2023 12:37:14 -0700 (PDT)
Received: from yoga ([2400:1f00:13:6258:556c:aad7:2240:7612])
        by smtp.gmail.com with ESMTPSA id jl17-20020a170903135100b001b39f8dc06fsm3862326plb.152.2023.06.21.12.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:37:13 -0700 (PDT)
Date:   Thu, 22 Jun 2023 01:07:05 +0530
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
Subject: [PATCH 1/9] scripts: python: Add check for correct perf script format
Message-ID: <c43a51b4895b5b0b40f8c526d6e5e92b9d646a62.1687375189.git.anupnewsmail@gmail.com>
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

The isPerfScriptFormat function, validates the format of a perf script.
The function checks if the given input meets specific criteria to
determine if it is a valid perf script output.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 .../scripts/python/firefox-gecko-converter.py     | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 tools/perf/scripts/python/firefox-gecko-converter.py

diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
new file mode 100644
index 000000000000..73a431d0c7d1
--- /dev/null
+++ b/tools/perf/scripts/python/firefox-gecko-converter.py
@@ -0,0 +1,15 @@
+#!/usr/bin/env python3
+import re
+import sys
+import json
+from functools import reduce
+
+def isPerfScriptFormat(profile):
+    if profile.startswith('# ========\n'):
+        return True
+
+    if profile.startswith('{'):
+        return False
+
+    firstLine = profile[:profile.index('\n')]
+    return bool(re.match(r'^\S.*?\s+(?:\d+/)?\d+\s+(?:\d+\d+\s+)?[\d.]+:', firstLine))
-- 
2.34.1

