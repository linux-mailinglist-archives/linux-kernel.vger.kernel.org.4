Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6716C0A71
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjCTGQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCTGQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:16:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C571E1CF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:16:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c18so11341414ple.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679292988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1PCNiHBRwaL5xJfL1tCb9ZA08+SMqP8xHlVBWEBjsM=;
        b=ubremerFrl/MetJDbxTwzCxOsFFOW89dj6Ic8i/5ceVLKNiIKxbuSwBwwBres9rWXL
         RczyUY8pw2vdptN+YAmjdvfw16koh4FxeCTUIg3i3BI3GgI27Ud+40lFIW48Pr6wBFhg
         avj+/20U6Pd7CWQp3c2ZoyNHCnAA+2byccXonmJt8e2zwKKrZheocn9JpFsZKDApQeOn
         QPPYvCX3PgLbldSwEMKlIvV/0EOKA5hb88NT9rFZ5/+l1E7sQBce8pDKuuzbNQQS838e
         K3zJKq2FYFR1SAIwHlhhUvlReFgRgDnIWpIprMjT0NQWCYEF+i4Hx8Mvz3o0D6nTU8jT
         MINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1PCNiHBRwaL5xJfL1tCb9ZA08+SMqP8xHlVBWEBjsM=;
        b=lT52eTeYSgNSDtNFoHJvQXx/XvR/PISd4lPxBhqk59xbJoqsQdryzX0SG3X9ZjEd2K
         QogWd9XIeiOkOepqX1gSqRX4bPn6MWdS7SHbsY9H3IAaQMyhTr7UW6ayWijYuhXlkAg5
         vjeFkOUO3oCmICbQvY2n0c21NfbtE0m1VK7wB09BVf3ud7puzRDsyaKCZD4vzeovnU8Y
         AFU2SesnOlaLmgeKKoRPJj+WMnxydAl7RHSQa8DW9Ej9uhc5OGyw0H7XPw2mxR2NO0R9
         Zo4T0Mylyo3vPysnT2W9bLnfrdgEOl1a+o2BHhCalV9dyb9NmrL2Wv0OC+ZApTu4fJTj
         DIfg==
X-Gm-Message-State: AO0yUKWJz3n7B8cqeX4+xBJFNXAGREf8TZuatFpf1tgUmAMkB8F0NvQT
        YGZq+ZcLjMa0UyB8vl+v0u7ueQ==
X-Google-Smtp-Source: AK7set8W3WMrsItfIlYJHM1suy5V9z1TQBDnm0Genl1IweGxXIHONeZdyKN0QS7EgzRRwIel7LKh3g==
X-Received: by 2002:a17:902:ec8f:b0:1a1:d544:e5ef with SMTP id x15-20020a170902ec8f00b001a1d544e5efmr1660398plg.33.1679292988578;
        Sun, 19 Mar 2023 23:16:28 -0700 (PDT)
Received: from leoy-yangtze.lan (211-75-219-203.hinet-ip.hinet.net. [211.75.219.203])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902854900b0019c61616f82sm5750129plo.230.2023.03.19.23.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:16:27 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 0/2] perf kvm: Fix memory leak
Date:   Mon, 20 Mar 2023 14:16:17 +0800
Message-Id: <20230320061619.29520-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
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

This patch seris is to address memory leak issues in perf kvm.

The first patch introduces refcnt in structure kvm_info, so we can avoid
memory leak for it.

The second patch explicitly delete histograms entries before program
exiting rather than relying on kernel releasing memory space.


Leo Yan (2):
  perf kvm: Support refcnt in structure kvm_info
  perf kvm: Delete histograms entries before exiting

 tools/perf/builtin-kvm.c   |  6 ++++--
 tools/perf/util/hist.c     |  5 +++++
 tools/perf/util/kvm-stat.h | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

-- 
2.39.2

