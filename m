Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07FF6B5924
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCKG73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjCKG7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:59:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BEF733BF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id p79-20020a25d852000000b00b32573a21a3so3095524ybg.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678517929;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F+R3xPbwPywZgeJnsjmP8WPRT4KEekM8oOe2/6TEvNc=;
        b=GbtM2Vfzd2uFvQ6E35ynK8F12Mz9p4h3fX4fxIWbDeMGmaSb8govTXiIR7bx13KqIZ
         t0bsGbbpwQjP8kz815Hlg7oCFGUF8NTM+Nb1AJ8tMOyo/KVrOmJVHJnHFU3qWelr3BPi
         D6Nbhdqr5/xBXvBJ0IcI3dD64GMuAz4RS0EnursVquuv9NOMpAOw1fpcijqesKM0rZd9
         2HRm6ltAulua1/24fpO526B5Lw2TgG02TTd9WVKnwanBl9Pc0XDL1HXOMukDmzNXP9DQ
         shVkfNRnPhhdrmaGUuHNwUTpZSYdMRGDGH0/qLU7MeJ6vxdOmLVCC8jyclr4MHbtoEHs
         qaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517929;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+R3xPbwPywZgeJnsjmP8WPRT4KEekM8oOe2/6TEvNc=;
        b=sZOk4FJ0lrdnIoD6j0iZ/7P/k+F4aooTOSRJi2B1tGpGFolb5s9fmnR1/QXk/sSGWu
         k7a/osT4YOXEDn7mcFiwPHJY7fK5UpNejEDd6FXNO6qpMmAQ7WzNWpKLi8QGtH5T4Tsm
         C0anYCTpRUYM9pWXf6b4CuiulRpZhhC6VRpVK+j7hYSVVTgoV6hRpxln0cXTeOQak4mD
         PJOB/AfZ2+qtptBdqZFP8by67id+M427WsTkbimqCfgXWl/Vw7c+fSN66Oac+cwVep8X
         LMw1hzU5odOAX0HdOD2/GcYM9iyLOu8YNVXgsOi0E47841JslrRPFOR1lHsJwx0K2A9C
         t5Pg==
X-Gm-Message-State: AO0yUKWgJ3feAkxAsFXUWcsU5uk+30l7cu/fQwtz7sLQr4PlbH8DEPRW
        alGO77HrGN+LOgB9E95RXdW28ALglWD8
X-Google-Smtp-Source: AK7set+YGmGHUS1yB1fxA8fPS4XfwBlDXecnkj+KmRN23aQEoGof3q6DV9UBVKyc6t+I+wVdms/fMYZMYvOW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a11d:a763:a328:f2d6])
 (user=irogers job=sendgmr) by 2002:a81:ac4d:0:b0:541:6961:8457 with SMTP id
 z13-20020a81ac4d000000b0054169618457mr685807ywj.2.1678517929704; Fri, 10 Mar
 2023 22:58:49 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:57:46 -0800
In-Reply-To: <20230311065753.3012826-1-irogers@google.com>
Message-Id: <20230311065753.3012826-7-irogers@google.com>
Mime-Version: 1.0
References: <20230311065753.3012826-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v1 06/13] perf build: Error if jevents won't work and
 NO_JEVENTS=1 isn't set
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than disabling jevents if a sufficient python isn't present
error in the build. This avoids the build progressing but the binary
being degraded. The build can still succeed by specifying NO_JEVENTS=1
to the build and this is conveyed in the error message.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5691e2ffb1b9..2557654d8e29 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -872,14 +872,12 @@ endif
 ifneq ($(NO_JEVENTS),1)
   NO_JEVENTS := 0
   ifndef PYTHON
-    $(warning No python interpreter disabling jevent generation)
-    NO_JEVENTS := 1
+    $(error ERROR: No python interpreter needed for jevents generation. Install python or build with NO_JEVENTS=1.)
   else
     # jevents.py uses f-strings present in Python 3.6 released in Dec. 2016.
     JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 6) else "0")' 2> /dev/null)
     ifneq ($(JEVENTS_PYTHON_GOOD), 1)
-      $(warning Python interpreter too old (older than 3.6) disabling jevent generation)
-      NO_JEVENTS := 1
+      $(error ERROR: Python interpreter needed for jevents generation too old (older than 3.6). Install a newer python or build with NO_JEVENTS=1.)
     endif
   endif
 endif
-- 
2.40.0.rc1.284.g88254d51c5-goog

