Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AF867DAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjA0AUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjA0AUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:20:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB0A3B0EC;
        Thu, 26 Jan 2023 16:20:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so3398828pjl.0;
        Thu, 26 Jan 2023 16:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRrV7TjTlPA/BkPaOPUYQ8wwbHiOpKT0qv7GK3Tslrg=;
        b=JPVvykV4MhgTf7Tw6GyypSnxNUhsiEiGHYhsEUqj/dj/oY4wZ6DjIqykUAAQRoi9aM
         etlaTcQ17oDUiRwR/JpFDZcivnt3IE+Fydm9QJOrqIncAHnAhvNAJ0YFCXzUjLmKGFko
         SnTKNCgB+gb7avdiA1X8r17hkBzJBoGAsR3ZtaYrADLWrWU2OLYh30c69NfAg7QpvbNB
         C+5DEdUXbdHap9B0da+1KD03J5KYkgx4EgtR0rkY53+7do8BysYsPzKZBzrqyK64JJn7
         O0gXL5ApOoj8XukHkGKGrgrg8YmwkAaNq7ddEWxAXB3UgpR+MSnRzf9i4CO7OzlyELzY
         RfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRrV7TjTlPA/BkPaOPUYQ8wwbHiOpKT0qv7GK3Tslrg=;
        b=xp5EdG48cM9z/BuIRqcyhZUwxhC2Kg7yU0s81HB2jcvp4Kqp4a9XwutyzicPgpGWUG
         +QKmB5NSS+lDe7YN2TIUkQb8RGmEQa9Wr0iuOdyA/s0Mo5EKjRi3iHZU56GnxLu+F2Nl
         /qa8898CMSniDzzs0w1c8In1vaJnFebZVyi52KaVqjoepIUZtl5Bu7PGvpgjBnkQWm6w
         n/7IK0gwId3Y7GNGExQrd9cV16hkvN7wD3GDlpdDsbMWSxuvr8/LLyBr4pcnBh679RYx
         J7WXEW7T7VkuXxp61EdfFR0N/il6ocszCBHJ75/X/CWPrnj4bcXkeoPJOGcfrWXu7r9+
         Iv4w==
X-Gm-Message-State: AFqh2krsrufWwEGXxGATq2YiEjlCZoODNA9ULMFDC5XTnqejZFZWrxaB
        +vzLRtFPXc615XSnD8rbOow=
X-Google-Smtp-Source: AMrXdXt150PwiZkkD0pHSBQ3CST0AJEU92tONX9WSdl1dAeFrnlea4VXE1Z24xjN26lvrT9LNFb4dw==
X-Received: by 2002:a17:90b:1c0e:b0:22b:b5c7:4fc with SMTP id oc14-20020a17090b1c0e00b0022bb5c704fcmr25339679pjb.46.1674778800033;
        Thu, 26 Jan 2023 16:20:00 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1f5d:eee8:d409:8a17])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b00229f7376247sm1567270pjc.57.2023.01.26.16.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:19:59 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 4/4] perf test: Add pipe mode test to the Intel PT test suite
Date:   Thu, 26 Jan 2023 16:19:51 -0800
Message-Id: <20230127001951.3432374-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230127001951.3432374-1-namhyung@kernel.org>
References: <20230127001951.3432374-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

