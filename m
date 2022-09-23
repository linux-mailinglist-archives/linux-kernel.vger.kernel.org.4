Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7015E80BC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiIWRcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 13:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbiIWRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 13:32:04 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AA012BD98;
        Fri, 23 Sep 2022 10:32:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 78so825838pgb.13;
        Fri, 23 Sep 2022 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date;
        bh=JCv6sv00YaO4tU61lqZx/ARNo7oEKPFV016dlURUeFc=;
        b=OdN3pbQpOZktYmS2WG5YnbAEMZ+Bq1ZGT50wjJhl7V1Nb2ALsjFJW2xHgUWspChrEy
         uTTknjZNvhsfUKAi1+b0JYNLjuNH8B5sk645HZtEXikdHZQhnIBucAuKfS36vPRsR/g/
         UC/KFaQmtzjhd6e0AQpCphmwcaP+DaurqEU4jgOSlhRc4tiW2IMqt8Zdx/rxypjvVkK2
         Crdvge3dM5kERkGVL1F+dqp/YiMHSs2FQtvaF34wtsWJplhaZVmPhrwJxATY8NHhb9Fw
         dkJJK+h3tXtP762bCAI/NSzNsQ/3VrTPwXujPXa/5dJW9zxkjlHkbmHNOjllZWnGUSP8
         W0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=JCv6sv00YaO4tU61lqZx/ARNo7oEKPFV016dlURUeFc=;
        b=K/pkr//ZcosbSyZiJ3aMSDLVkp6ZrLR4vQXy2aGTMhKUMUlsIRqQNWYsTeKfYxuvh/
         h91DeEzw0o5MtU9VZfCQkJUuyJ9tL7C6P0o4eQitfftkZG1pnBLi8NI5QQzoDuR17CA0
         yLRQ/754MMaQH6IjMqto0zlLmjR1kS12eWQqkeTdH0/DxKYge5jnM2l90EQ4Ey4QB46x
         k8NJcAZ6n14GbpxTPJUSXWNC79ywrDPjN1uAh6sYzO1MvfjJwB2oRjaApn2SRfK8J1iH
         XIFkxlKmJz4JZ2hyNRWKxt5GeejaG9jaXJvY6vrL4z1SbETdlVWOu+SH2HKy0PA4fjwJ
         WWJA==
X-Gm-Message-State: ACrzQf1xx1Pkf5yl8kGeRd2Q04xSO6Z+JW+p0jS9II6uiozN/75ZCtHu
        nXWyLjm04U5icCPSbAYibbw01sWJxOI=
X-Google-Smtp-Source: AMsMyM5W/Nnz+Ei6eaOF7Zd7e9mvoKj+Rge261fAN0/i8Plgv3bz9R+bB+3VUn2IJEMdw3NoXrflrg==
X-Received: by 2002:a05:6a00:1248:b0:548:2e34:65e1 with SMTP id u8-20020a056a00124800b005482e3465e1mr10484417pfi.82.1663954322999;
        Fri, 23 Sep 2022 10:32:02 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:c716:a857:50ee:f56e])
        by smtp.gmail.com with ESMTPSA id 9-20020a621409000000b0053e6eae9668sm6719499pfu.2.2022.09.23.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 10:32:02 -0700 (PDT)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 0/4] perf tools: Assorted random fixes and updates
Date:   Fri, 23 Sep 2022 10:31:38 -0700
Message-Id: <20220923173142.805896-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
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

This is collection of random fixes and updates.
And I'm resending them as they seem to be lost in the list.

Thanks,
Namhyung


Namhyung Kim (4):
  perf record: Fix a segfault in record__read_lost_samples()
  perf inject: Clarify build-id options a little bit
  perf tools: Add 'addr' sort key
  perf annotate: Toggle full address <-> offset display

 tools/perf/Documentation/perf-inject.txt |  6 ++--
 tools/perf/Documentation/perf-report.txt |  3 +-
 tools/perf/builtin-record.c              |  6 ++++
 tools/perf/ui/browsers/annotate.c        |  6 +++-
 tools/perf/util/annotate.c               | 19 +++++++++++-
 tools/perf/util/annotate.h               |  4 ++-
 tools/perf/util/hist.c                   |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 38 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 10 files changed, 79 insertions(+), 6 deletions(-)

-- 
2.37.3.998.g577e59143f-goog

