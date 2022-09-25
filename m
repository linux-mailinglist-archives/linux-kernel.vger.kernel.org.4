Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7195E90CB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 04:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIYC7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 22:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIYC7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 22:59:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A5F43626
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 19:59:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d24so3434389pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 19:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Ze7hH0t/gP8ZC1eQRaIjQjlxIkny84c949uR2bepf6Y=;
        b=I+GAiJ3GEm892A4gkHivtoHbaBsitppjp5S+laoBM5oYh92ca+ySFXXUofK1b2967F
         TpZ8Vvdk7T9NHrbSYIGGFzbuPl1/teQMEzSovZtzxb7RcgaJBxX+R2t2fF1KbUkZeVVq
         VfHFvgg18C78jQqH/AgLyS8evjDnvGJ5MQSugM045QVISD99/Cs3Lq2vCwis+cSNpCAo
         I32LQOJBHk35Fo3F27waGuJ6os22Ok2aPIK1CyHuM1ihfnyJ5fXSenjNJx0EQxBbgn7T
         eOOI420Gmc6A/JCXWO7DLZkQRpdYaTCM0Jr4jqetk+R9FbGzJYORpXLIwS6uvzfSFO8e
         Uuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Ze7hH0t/gP8ZC1eQRaIjQjlxIkny84c949uR2bepf6Y=;
        b=DcrnOserz8dttvgbCjX+oL3fNugMbyL052FoaP9/Ab1x4Lud4Ezdqf8gIHYGKOvg/W
         uGXtOUghCRjL57H9HnZ3LLZmvOlvLu2MX5ccwgnvaP9P+SO/e/9iy+UB0BbIrOWit++O
         RduQM5VRXQrsxTgsGeuVG+g7WXLq+ZlPS3OgpUZDs/9FgMi6MUNElRge8qxKJUCAeYqj
         Qb2wfo7yh91Q5GcBntcDniGSpImn8hFPqvmXH9mBNgMUy7sxsleI5tX2ULliZfwuOvNO
         Q/yMsWP/bikBJgy4/WL9zTw3z+hQtDqdILxntyt/lzhlOWLtgNzcg9XhJw/R0mh5EaGw
         DOFA==
X-Gm-Message-State: ACrzQf2Voc7X38yKz3qjoSmlmziyIDYSp4uuUHldN8nMLprFLqIXTyu7
        HBgzdS2o8OmYrKoTQ1DKNCTQ4A==
X-Google-Smtp-Source: AMsMyM5xhOW5ZFCm2qYXEI4DQ+m+2aei5Of+RoohyXvH8XpbIetpHYScIK39PtGTqPuDLkeXl5h9Vg==
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id oo2-20020a17090b1c8200b001eeeb41b141mr18366231pjb.143.1664074746462;
        Sat, 24 Sep 2022 19:59:06 -0700 (PDT)
Received: from leoy-huanghe.lan ([137.184.34.254])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b0016bf5557690sm8409198plg.4.2022.09.24.19.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 19:59:05 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/2] perf test: Add test for java symbol
Date:   Sun, 25 Sep 2022 10:58:33 +0800
Message-Id: <20220925025835.70364-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add a test for java symbol.

To allow a shell script to know the installed lib path, we need to
export the environment variable "PREFIX" in the C code.  We use the
first patch for this purpose.  The second patch introduces the java
symbol testing.

The test has been verified on x86_64 machine with perf/core branch with
the latest commit 62e64c9d2fd1 ("perf test: Add basic core_wide
expression test").

Changes from v2:
- Skipped test if jshell is not existed (Namhyung);
- Fixed a typo for s/if/elif/ (Namhyung).

Changes from v1:
- Added Ian's suggested tag;
- Added the search folder for the system lib libperf-jvmti.so;
- Skip the test if fail to find jvmti lib.


Leo Yan (2):
  perf subcmd: Set environment variable "PREFIX"
  perf test: Introduce script for java symbol testing

 tools/lib/subcmd/exec-cmd.c                |  3 +
 tools/perf/tests/shell/test_java_symbol.sh | 75 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

-- 
2.34.1

