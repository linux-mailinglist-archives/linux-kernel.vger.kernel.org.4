Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC14A68221C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjAaCeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjAaCeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:34:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D725336084;
        Mon, 30 Jan 2023 18:33:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b5so6408715plz.5;
        Mon, 30 Jan 2023 18:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRrV7TjTlPA/BkPaOPUYQ8wwbHiOpKT0qv7GK3Tslrg=;
        b=fFDIWDUFi/gMbk90i7BKU0biXYThbFrvns3JS/E/592VMsOumS8JfuTb8g+/ucdJvt
         DBbjZGK029lXRrU5R4C5odHdMjMagiLVyNsiPyM1ImMxDqP10zh1XWsfg6RWyfSRQXSw
         FULktgF4zgF31YYcYTcwNF/hS2OU+PmAk2g60nxMoSXv8qatZ6KGId6+wCZ0EWYTUViz
         rdDzmTyL0I2Q8HHAiwL5hRMwkrL8Lw/15o02vW9CD5SmUYWKUr83ZigvcMKeFS0uOuhN
         kWyjfC8RzHXZf1AXW+cpWu4aCfreXq8rwfUZIZqKcfUJbzqUmcitWSwDG7PYE6azh7o2
         ES7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRrV7TjTlPA/BkPaOPUYQ8wwbHiOpKT0qv7GK3Tslrg=;
        b=B+wO5DfKZrC/0jQ53RKORCPfLKbvLFjEEkaNudgsMxbk6f5Bt510RPPS104/5fPCAI
         npGNIS/Hon+779BhfYCILZGv/SnZagkMEAfg4HxblNBdmTY+jphCTtDg/1vU9TcJjAfF
         zoJRp82W2o7Y596kfwsNqWYqJCoz7ihTQUxjBT3G0/mniUqMnS0wYzLjNzPYvO94Kbwo
         EbjCH9WkQo+zw9KIfgiOkyuQkK6j7H6Hc2M2b9UhRsEZLcKZEtyoWmFoiOk5Ycu9ycy3
         08SEQFIGsryXd0QB/dRLqjrRd+spK16bdpExNUsFKNBNEfVhn/kpuP6XZdgeNS+jIset
         XEtQ==
X-Gm-Message-State: AFqh2kozbiIdcZ9eV1O+bCGccarJQkVdh03ynqyNoNFz+4XbZXJMFvE4
        VAzw37uM+kcMrZ5qJQNtO+YsLwGiwMo=
X-Google-Smtp-Source: AMrXdXsj8Bhf703AOi4LuaE3pDVGC4uJBSNELzDPXU8HKlSTT6plI4+SLecxFrnZFyZoXNQQRKYsTg==
X-Received: by 2002:a17:90a:b798:b0:229:d641:9ef2 with SMTP id m24-20020a17090ab79800b00229d6419ef2mr46407332pjr.40.1675132439097;
        Mon, 30 Jan 2023 18:33:59 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3f41:4035:c56c:92cc])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a6a8d00b00228f45d589fsm7640582pjj.29.2023.01.30.18.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:33:58 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/4] perf test: Add pipe mode test to the Intel PT test suite
Date:   Mon, 30 Jan 2023 18:33:50 -0800
Message-Id: <20230131023350.1903992-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230131023350.1903992-1-namhyung@kernel.org>
References: <20230131023350.1903992-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test_pipe() function will check perf report and perf inject with
pipe input.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_intel_pt.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index f5ed7b1af419..4ddb17cb83c5 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -620,6 +620,22 @@ test_event_trace()
 	return 0
 }
 
+test_pipe()
+{
+	echo "--- Test with pipe mode ---"
+	# Check if it works with pipe
+	if ! perf_record_no_bpf -o- -e intel_pt//u uname | perf report -q -i- --itrace=i10000 ; then
+		echo "perf record + report failed with pipe mode"
+		return 1
+	fi
+	if ! perf_record_no_bpf -o- -e intel_pt//u uname | perf inject -b > /dev/null ; then
+		echo "perf record + inject failed with pipe mode"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -647,6 +663,7 @@ test_virtual_lbr			|| ret=$? ; count_result $ret ; ret=0
 test_power_event			|| ret=$? ; count_result $ret ; ret=0
 test_no_tnt				|| ret=$? ; count_result $ret ; ret=0
 test_event_trace			|| ret=$? ; count_result $ret ; ret=0
+test_pipe				|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.39.1.456.gfc5497dd1b-goog

