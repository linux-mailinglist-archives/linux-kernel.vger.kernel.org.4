Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E566728BAF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbjFHXYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjFHXYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:24:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D5330D4;
        Thu,  8 Jun 2023 16:24:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-65055aa4ed7so958577b3a.3;
        Thu, 08 Jun 2023 16:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686266643; x=1688858643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=42lC7HZoHlaRfJs1qoI4qNHKms+PSYJbqmg+6blMOYY=;
        b=DNo8whDsFUiMToVM3Bwqf+kXF3x7FsXdfRsNq/8q4gBi7A7GeWFgkzedfEU9asiDs9
         9EeIc84YvhYQKytu3/mNmFK8fxd/aCO8UWAlQdN1FI7SJl3rNwB1a5uzMLKrDHg1gNNy
         zhPRLRHI7+I8W15YLqNArfi87mAUlari46ZX+SAlgCYtLZ09EVkMgtVE3X3BtpAr41At
         /QBOCyYuTOewz76ZD7R9ygAmgf75Edq3yKEDMenKPFkhThjoOQ/VUJ3nbkJurjGPJmSH
         2oW3rMbuySaa4yaCfwPvq0fFEE68ycE/Zwcs7mO5v4I5klx10tbFBIGdQvcc/LHqKeR6
         FYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686266643; x=1688858643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42lC7HZoHlaRfJs1qoI4qNHKms+PSYJbqmg+6blMOYY=;
        b=VnHVMDgm5HwS1FV4KE9bOiVW0F1JrNNSk0QcCytmifJN9Ufd1EHK5YSC9MyK1CCyn+
         tC9uHSN16zqU1RFEy4spmZU9ymiSfLmvUPtPe3EP/5RlW38G9HVxwIZ5tTnBl2/Bd4i0
         0LTby/+vQL7Or17dBacRf001oPd+bDkg4RGQeVPUYPKNhbrbOeArRfSQOtcVhz3yqMB/
         s+wQi8swK6ez3v00pYZ0b9gErWBxv+wabPT/zk8Enmkgs+WWya8rDHbbhiuuk/2DVl+e
         ia2RgNWN2us/Bl7uceDe+mRTZiG2ky0iOx6diDK+h1zm9C5D1N+A117gPZ45BZlCzqUE
         7jLQ==
X-Gm-Message-State: AC+VfDw/1lAIwlMWtudfZEJ3MXsna/TcUdtV+9zRNaRWBhoF7JY4gvGx
        nEUVlATvH5ZnXwraxzvUD3M=
X-Google-Smtp-Source: ACHHUZ5fFp1H3S4MLxKcxBj3sqNmsIstWNVMMcfCMB5TPt98WNt8pZsv4xzFnze0ykQsqlz8W7zqQA==
X-Received: by 2002:a17:902:efcc:b0:1b3:7de7:f852 with SMTP id ja12-20020a170902efcc00b001b37de7f852mr977043plb.55.1686266642605;
        Thu, 08 Jun 2023 16:24:02 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6700:7f00:c14c:6e39:cb7d:ad66])
        by smtp.gmail.com with ESMTPSA id e18-20020a656792000000b0053f1d55676fsm1618203pgr.2.2023.06.08.16.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 16:24:02 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 0/3] perf list: Improve libpfm4 event support
Date:   Thu,  8 Jun 2023 16:23:57 -0700
Message-ID: <20230608232400.3056312-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
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

Hello,

Ian and I found that some of libpfm4 events don't work well and it makes
confusing that perf list shows those unsupported events too.  Let's check
if the event is supported like other events and skip if it's not.

Also add a new test for it.  On my laptop, it runs ok like below:

  $ ./perf test -v 102
  102: perf all libpfm4 events test                                    :
  --- start ---
  test child forked, pid 3039688
  Testing ix86arch::UNHALTED_CORE_CYCLES
  Testing ix86arch::INSTRUCTION_RETIRED
  Testing ix86arch::UNHALTED_REFERENCE_CYCLES
  Testing ix86arch::LLC_REFERENCES
  Testing ix86arch::LLC_MISSES
  Testing ix86arch::BRANCH_INSTRUCTIONS_RETIRED
  Testing ix86arch::MISPREDICTED_BRANCH_RETIRED
  Testing perf_raw::r0000
  Testing icl::UNHALTED_CORE_CYCLES
  Testing icl::UNHALTED_REFERENCE_CYCLES
  Testing icl::INSTRUCTION_RETIRED
  Testing INSTRUCTION_RETIRED
  Testing icl::SQ_MISC
  Testing icl::SQ_MISC:SQ_FULL
  ...
  Testing icl::OCR:DEMAND_DATA_RD_L3_HIT_ANY
  Testing icl::OCR:DEMAND_DATA_RD_L3_HIT_SNOOP_HITM
  Testing icl::OCR:DEMAND_DATA_RD_L3_HIT_SNOOP_HIT_NO_FWD
  Testing icl::OCR:DEMAND_DATA_RD_L3_HIT_SNOOP_MISS
  Testing icl::OCR:DEMAND_DATA_RD_L3_HIT_SNOOP_NOT_NEEDED
  test child finished with 0
  ---- end ----
  perf all libpfm4 events test: Ok
  
Thanks,
Namhyung


Ian Rogers (2):
  perf list: Check arguments to show libpfm4 events
  perf test: Add test of libpfm4 events

Namhyung Kim (1):
  perf list: Check if libpfm4 event is supported

 tools/perf/builtin-list.c              | 12 +++++-
 tools/perf/tests/shell/stat_all_pfm.sh | 51 ++++++++++++++++++++++
 tools/perf/util/pfm.c                  | 58 ++++++++++++++++++++++----
 3 files changed, 112 insertions(+), 9 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat_all_pfm.sh

base-commit: 634c694de4cb2d050dc312ea43e0371d84c585a5
-- 
2.41.0.162.gfafddb0af9-goog

