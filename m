Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2085BBB3F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 05:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiIRDPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 23:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIRDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 23:15:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86E022299
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:15:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x1so24996476plv.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 20:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O9R+a6tAKsKk3N09bqIfrqrBjzSc1SVHcDt6BGSwBbI=;
        b=yMUkeddPLijVmgHg0vaH4Z2lzAsOv5lqJWsNwvrz4pdGCuNIU3ITXeOaE2O8PQRH+j
         NiqCR0KDbQ7aQkicZQW5A9JagoeiONKqHNfib2jccR9vGdCik5VSjdF/oWjBXizJkMdF
         GMT9qujyqEaCbLFlcgSxFfbT7GYSYtPY1GQSnXfA7vndK+mzljALtJqtTyZodo9oUf49
         Z3Ej8TwHBfXQpnL7ExUxbpReRl/DHwzCNvL2+MiqZ+O9faoM0Y6/9OT1rc6FT33AojqS
         DfFHBsor3ETKQrkcMhvEFuZIGydl6mQx3TzNUyVXjrUWZtcYPRo8yAnb0m3CH/w0m5Rs
         0DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O9R+a6tAKsKk3N09bqIfrqrBjzSc1SVHcDt6BGSwBbI=;
        b=DMc211vXJBaRoZP19ai/xDYibnr2elFryNbVe7QTf1zU8aHMDoHXs8SdR6pzmwSiO7
         bw2Ot5ty7I1V14k6lGyQE1YMLJMkXQIjlR+hX8sbAUf6DeVcWU22JoXR0LVpKfYca4Fc
         Q42xW+F4HI/p2ORP+Bmz3vI+nuM+3sPK0VdeoqqQmbWObtKZTzpmjLjpaKLp4rSBb1YJ
         LZ3hl8iTEjVX0P6q2p13J89D6lGJueLn6CGNaj5gt8OGLjv0W9sTRff9xVLM6CQKu5Su
         AyGDSbghoOMMOA+gMs1S046MDmQoP/3ayEgtcMZLHffd91LnPEc9HM791QIQgOaF0n3D
         1Buw==
X-Gm-Message-State: ACrzQf3iMMHh6v2WkOlquTduUlm5+uAkjAL4dlMZD67ydgceWnxCWzaK
        kBghY1As+ryGK7tXO/4UOkocdQ==
X-Google-Smtp-Source: AMsMyM7CZdMKQ7bgSSm5w4wMnhxPvff7yX9FEUgaZXnRC82lIKPWLzdibfpUAbFu/EQsXg0+2Go04Q==
X-Received: by 2002:a17:902:7c0b:b0:174:abfc:f5 with SMTP id x11-20020a1709027c0b00b00174abfc00f5mr7007397pll.124.1663470929916;
        Sat, 17 Sep 2022 20:15:29 -0700 (PDT)
Received: from leoy-yangtze.lan (45.78.11.189.16clouds.com. [45.78.11.189])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b00177f4ef7970sm17822647plh.11.2022.09.17.20.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 20:15:29 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/2] perf test: Add test for java symbol
Date:   Sun, 18 Sep 2022 11:15:22 +0800
Message-Id: <20220918031524.26719-1-leo.yan@linaro.org>
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

The test has been verified on x86_64 machine with mainline kernel, with
the latest commit 62e64c9d2fd1 ("perf test: Add basic core_wide
expression test").

Changes from v1:
- Added Ian's suggested tag;
- Added the search folder for the system lib libperf-jvmti.so;
- Skip the test if fail to find jvmti lib.


Leo Yan (2):
  perf subcmd: Set environment variable "PREFIX"
  perf test: Introduce script for java symbol testing

 tools/lib/subcmd/exec-cmd.c                |  3 +
 tools/perf/tests/shell/test_java_symbol.sh | 69 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)
 create mode 100755 tools/perf/tests/shell/test_java_symbol.sh

-- 
2.34.1

