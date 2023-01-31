Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F476682213
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjAaCdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjAaCdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:33:53 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493F21973;
        Mon, 30 Jan 2023 18:33:53 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so17592770pjq.0;
        Mon, 30 Jan 2023 18:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NfVxVXo4+yERzUlGGBwL95h13uNbeVL5DlVJJpWR694=;
        b=UL4Ep7qNhdBqcgOgjndsU5ISX66NdVZH5lEn9ncF1natRA+3Y68m3TabXwnYJMsC24
         43C+JR90NbFn/84l8sJhH9vIaRYVYLax8h9VxCbVO84WNAGdjptoi+29VOOAKaAXpQHZ
         5v9eA9csUM+YdTAexeTZbVfsWVEJASltYbag+bF+qTU4KXv8tUY4l9YebRPJTvUzCuMf
         XON1/mvIGFM08wQKlco6IlOHattjRHkUGJaU7zdSjhmNZaOFGXTvnVMcM3xM2s4Ke3AL
         mXLVE3jBwzfhUtDwW1bbkyqBHNc4GKdr8FHxUg/kOXtdGVpXchy8gpbe84r+FcyUUa8T
         xKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfVxVXo4+yERzUlGGBwL95h13uNbeVL5DlVJJpWR694=;
        b=c2Rp2VMyh0RpmO98i1ifue3kJG6IyCjB1cvH9MAr22G6f49H2dda+kO9r18NG+uVzh
         Jfp6Ie0JqApRaxvkQ3iSLoCg2T+Lu8oEO2VtASOKJHqSafD34Ge9f/0dIrdewJxLjluo
         saA/UZC2swYO53lz31hJqN6zuXR4X4QxT0aesucKUaQI7EgplhwkxfYoECHdkeowlfDU
         U8zXqIstr4yuBkAgJaUyTJ3Ep694E4s8Fn08y9FpXspSOUrRbT8UIShMwRQ+nAZCMTHW
         Ti03Fk8E+VlE1DJzxq6BR4g8nZcV6uXkirv6FxxxZGCdo4p5aQV912fQpo53sC2armI0
         uOgw==
X-Gm-Message-State: AO0yUKXxxYqVbH1wHbz+0CZi5Pmu954WAlD/xRG8L7mIODzi3tohMtwS
        +tQNQsp0YYwwB+X6+0BxhU8=
X-Google-Smtp-Source: AK7set98UfbNYV4GRE8j6VGhuWDQXfJsEilBDTUZPMbksl5tBp/KbxXN4eJoYNbxJ3/e0QNFd7NM0w==
X-Received: by 2002:a17:90b:33c8:b0:22c:1331:9c59 with SMTP id lk8-20020a17090b33c800b0022c13319c59mr12345113pjb.31.1675132432576;
        Mon, 30 Jan 2023 18:33:52 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3f41:4035:c56c:92cc])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a6a8d00b00228f45d589fsm7640582pjj.29.2023.01.30.18.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:33:52 -0800 (PST)
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
Subject: [PATCH 0/4] perf intel-pt: Fix the pipe mode (v2)
Date:   Mon, 30 Jan 2023 18:33:46 -0800
Message-Id: <20230131023350.1903992-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
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

Hello,

I found some problems in Intel-PT and auxtrace in general with pipe.
In the past it used to work with pipe, but recent code fails.  As it
also touches the generic code, other auxtrace users like ARM SPE will
be affected too.  I added a test case to verify it works with pipes.

Changes in v2)
 * add a warning in intel_pt_process_auxtrace_info()
 * add Reviewed-by from James

At last, I can run this command without a problem.

  $ perf record -o- -e intel_pt// true | perf inject -b | perf report -i- --itrace=i1000

The code is available at 'perf/auxtrace-pipe-v2' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (4):
  perf inject: Use perf_data__read() for auxtrace
  perf intel-pt: Do not try to queue auxtrace data on pipe
  perf session: Avoid calling lseek(2) for pipe
  perf test: Add pipe mode test to the Intel PT test suite

 tools/perf/Documentation/perf-intel-pt.txt | 30 ++++++++++++++++++++++
 tools/perf/builtin-inject.c                |  6 ++---
 tools/perf/tests/shell/test_intel_pt.sh    | 17 ++++++++++++
 tools/perf/util/auxtrace.c                 |  3 +++
 tools/perf/util/intel-pt.c                 |  6 +++++
 tools/perf/util/session.c                  |  9 +++++--
 6 files changed, 66 insertions(+), 5 deletions(-)


base-commit: 5670ebf54bd26482f57a094c53bdc562c106e0a9
-- 
2.39.1.456.gfc5497dd1b-goog

