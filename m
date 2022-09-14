Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114E5B8EED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiINSd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiINSdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:33:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFD281693;
        Wed, 14 Sep 2022 11:33:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so19906110pjq.3;
        Wed, 14 Sep 2022 11:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=iSoULPQWHCxzuyccY9QXbYwCw6NT6wZa9kyRRus/6yo=;
        b=LuXH7/26EMAVjurSfaKGZztyeArTr4xXhVt4XGgBSiaMZUlCG+5kWMfNiLH8yj7tsD
         P+g8fAa2XMWBk+qUI8Bk3s5PEEpnPko51UtwUeN/xQvrEz/X3Ux8bFiIJ8poxmOWbCc3
         o1xyblaiZ0MCNo0oeb+ehiTEBbpUqxuCzwhZnXooYlr8rn5GQNBPYxJs0ptGLfaNptB+
         sIl8/ry8bNH8WziTcSwzYIjdmueMh5uPg61OaNNFnYbmCbf6aCYJDJAdsMg2/GilIegf
         jIU+bTVCfUStYzFuKaFm3Jtk/WCSNCfmHeemcMSTItSXA7MocnK55f0Iztomo2gT5cHV
         uImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=iSoULPQWHCxzuyccY9QXbYwCw6NT6wZa9kyRRus/6yo=;
        b=cM/T8kzLMA/eVJwrwB7ILv0RaSSiK71aK/vogKH71/EOsg9gMRBQvRqMdvzwkVTOvR
         1P4wLbfEbTVETjMi1G4akK67UtY1dhDYWTzI1bM8KG/M/A1qAUz0/VHWNzQ9Z4wTWT0A
         d59zoXg9Vbs56sK4aoF+7Yw2sttyYLcekGm4ZmpV6P2IKpKQ5tjyO5F0g6hUEI3RN7fp
         TJZepg9YnmriHL7GvjukrA+M2z2+OBI2DzjLSnzo9YoBjzb7uyl7f+SiFIR7vCaRu1X9
         P42DdxSECoFK5rC38+K0PF74OwBckl1pEKPu4ijNRmXFi5+VyDi66UTT32qPl9IYKkL2
         rIPg==
X-Gm-Message-State: ACrzQf3mn24Hm0uzTDAzlwvNdTCau46jFpuigeIc6x2VTh8bBhka+hCM
        I37QmA1PL4NRVgCOcaPSS7U=
X-Google-Smtp-Source: AMsMyM4HnK9AwaGr5z5zDzKLgVhSIpGEQrcTg3ciEf0r1Te0S0qFmJEHDGfzEn/dtiyVb6IELzVq9A==
X-Received: by 2002:a17:902:b692:b0:176:d346:b56f with SMTP id c18-20020a170902b69200b00176d346b56fmr315803pls.140.1663180428248;
        Wed, 14 Sep 2022 11:33:48 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ba6:e12b:9910:5ea])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001728ac8af94sm11190842pla.248.2022.09.14.11.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 11:33:47 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH] perf test: Skip wp modify test on old kernels
Date:   Wed, 14 Sep 2022 11:33:38 -0700
Message-Id: <20220914183338.546357-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It uses PERF_EVENT_IOC_MODIFY_ATTRIBUTES ioctl.	 The kernel would return
ENOTTY if it's not supported.  Update the skip reason in that case.

Cc: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
I'd like to add Fixes: 2e85d5979e8d tag here but it'd conlict with the
later change in e47c6ecaae1d.

 tools/perf/tests/wp.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 9d4c45184e71..99f048cd6faa 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -2,6 +2,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <errno.h>
 #include <sys/ioctl.h>
 #include <linux/hw_breakpoint.h>
 #include <linux/kernel.h>
@@ -137,8 +138,7 @@ static int test__wp_rw(struct test_suite *test __maybe_unused,
 #endif
 }
 
-static int test__wp_modify(struct test_suite *test __maybe_unused,
-			   int subtest __maybe_unused)
+static int test__wp_modify(struct test_suite *test, int subtest)
 {
 #if defined(__s390x__)
 	return TEST_SKIP;
@@ -160,6 +160,11 @@ static int test__wp_modify(struct test_suite *test __maybe_unused,
 	new_attr.disabled = 1;
 	ret = ioctl(fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr);
 	if (ret < 0) {
+		if (errno == ENOTTY) {
+			test->test_cases[subtest].skip_reason = "missing kernel support";
+			ret = TEST_SKIP;
+		}
+
 		pr_debug("ioctl(PERF_EVENT_IOC_MODIFY_ATTRIBUTES) failed\n");
 		close(fd);
 		return ret;
-- 
2.37.2.789.g6183377224-goog

