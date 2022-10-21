Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770DC607E22
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJUSLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiJUSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:11:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DF61285D5;
        Fri, 21 Oct 2022 11:11:00 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r18so3193510pgr.12;
        Fri, 21 Oct 2022 11:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RGIAKus/Xgp2gelQEMCjN5mUafX169J7aaTKPb1JrtI=;
        b=FIwyGa5nFa/qllpYs9rRhQ4m9fVW9NILhvw4Za5RaRfnL36GJhddiCfTkYHFDAHIfe
         pN9VlLaUT/WKovBbKN+mnBbc0x0ZcWolgcc98JV6HXDJ39sHjDG+Nqg9zei2QN8Rx0B2
         IKrefMsv2LNATKgCoo/8K/3E6dJhJvfEmjd9IThoDb8x8yotI6ESUDDwatjgkN1ofcs6
         vpaJyyxbY6iy56NtTkUNbdhLh/CurXW6uZhyKuFAyyo0NzsLaRpcXiB5dAg7sDDoeu1K
         RO49CVEfGo7Dsp9szUdm0GuUHGiQN0PqMhAtDCSB7F+oV4V95DuOcH+Wz+zUHgSkbVVh
         9W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGIAKus/Xgp2gelQEMCjN5mUafX169J7aaTKPb1JrtI=;
        b=IX5qJBcHcmoQOglS9V2x6C7fz2nP90q2/yQqSgB+fMK3rIytvbzFSPfSWEB8vqYjQY
         BuNPTOZs1ig7JeHNgoifo4URjJUZ94QSqarF+kIVHlDtBhdCPAPAK1o4KWnJjXrUNjwa
         qy8YMZl5YSIyrO1Dgg5p0NtcW321XP57udWEF1rAg4bV0e8MjCvHeuc9bOJ/nFwP0io1
         Ov+yxhNUdXo+JGtqe+XT5zhRb/ILJoVL6qWduABQpnTRL59F/X732q/w/8IFLvqDBYUY
         MJ73rcO8DmJ6dBbsBWoAGb3cFO1EqjbWixAjNTyxKgohXWmz9lSAHg2088I1p4tDBfAs
         ognA==
X-Gm-Message-State: ACrzQf0u7IkKZ8ug5L3u1Zw9/Bp5aAe8KYdzvVymchuhD7m701el1+fB
        wDpg6+SH/3OBRMQWes8xWYI=
X-Google-Smtp-Source: AMsMyM7tlUNrSDUN2QfXD5FgZCwou4jlq8Mo8S4x8Cz+8wbgQsy5wx6dxXV9tFaAGyiyTCOaq2gFrQ==
X-Received: by 2002:a05:6a02:112:b0:440:5515:b908 with SMTP id bg18-20020a056a02011200b004405515b908mr17483097pgb.13.1666375860017;
        Fri, 21 Oct 2022 11:11:00 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([2607:fb90:8066:9c69:66a3:c7aa:d7e4:8f8b])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b00172897952a0sm15396223plc.283.2022.10.21.11.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:10:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH v2] perf test: Do not fail Intel-PT misc test w/o libpython
Date:   Fri, 21 Oct 2022 11:10:55 -0700
Message-Id: <20221021181055.60183-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
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

The virtuall LBR test uses a python script to check the max size of
branch stack in the Intel-PT generated LBR.  But it didn't check whether
python scripting is available (as it's optional).

Let's skip the test if the python support is not available.

Fixes: f77811a0f625 ("perf test: test_intel_pt.sh: Add 9 tests")
Cc: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_intel_pt.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 4c0aabbe33bd..f5ed7b1af419 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -526,6 +526,12 @@ test_kernel_trace()
 test_virtual_lbr()
 {
 	echo "--- Test virtual LBR ---"
+	# Check if python script is supported
+	libpython=$(perf version --build-options | grep python | grep -cv OFF)
+	if [ "${libpython}" != "1" ] ; then
+		echo "SKIP: python scripting is not supported"
+		return 2
+	fi
 
 	# Python script to determine the maximum size of branch stacks
 	cat << "_end_of_file_" > "${maxbrstack}"
-- 
2.38.0.135.g90850a2211-goog

