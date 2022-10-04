Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A55F4998
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJDTMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:12:43 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B440E00;
        Tue,  4 Oct 2022 12:12:42 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id d64so15382188oia.9;
        Tue, 04 Oct 2022 12:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=zERZlYe+GZ0vho+dfbChk8kktRahT29Z/NcoQWR1Vas=;
        b=NQxwcir4R8DECTRiA1K3fqzQDeMde8lwV6qP+s8rS/F76MinSwnWxQP9Cpt3sbCJ0t
         wjOwsTznp4FoIEmBCs1FX+rkHNGVNeeqeP7ltA31mTQvFWMroiaVGMkA2Mmws+TBIbgh
         TJBRFjMew/GlKxlf4ekT9MF7hEkbXZ2q33N4+zOcv0AJ2FqmQg5GozjHBbpTvSgYkKnu
         I85NvFoYgDk+qYWCd4T2Y8JCX1ZI7JF4SntJvkVT4u7bjmZkdy7Ix0a/YrKoAHdxHpiu
         aWYyHhR4c2D6k96kKmY2SbhRSCZfPmAw9HRVCdYAvn6k50o8fNHa9xUJYxWO6Gc0UqoC
         awrQ==
X-Gm-Message-State: ACrzQf32es69Z/xmKKgEg+ljyJ16EAUR0y2tdm63OSGNaYIc4AKgP23S
        mlk8xwDvYgo6ZwDodkAi6S6KtzlblQ==
X-Google-Smtp-Source: AMsMyM7BHsP8zGXFFIVnAj5wTEEJ8PHxKG7HzeqFFQuKCOtG9Q4+ekigA6cXUPk35QqK+y4rDeh0TA==
X-Received: by 2002:a05:6808:3008:b0:350:fad2:458d with SMTP id ay8-20020a056808300800b00350fad2458dmr564973oib.93.1664910761297;
        Tue, 04 Oct 2022 12:12:41 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id q206-20020acaf2d7000000b003507c386a4asm3296336oih.40.2022.10.04.12.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:12:40 -0700 (PDT)
Subject: [PATCH v4 0/3] perf tool: 'config3' attribute support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAKKFPGMC/4WNQQ6CMBBFr0Jm7ZhSQFtW3sO4KGWAxtqSKTYxhLvbeAFXP+8n7/8dErGjBH21A1
 N2ycVQoD1VYBcTZkI3FgYppBS6btHwC1fiCbcYPaaVapSYJVozXJW23dhpBcUeTCIc2AS7FD+8vS/l
 4tIW+fN7y02J+//h3KBAVSs9WdGO1l5uT+JA/hx5hsdxHF+KMskExAAAAA==
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 04 Oct 2022 14:12:34 -0500
Message-Id: <20220914-arm-perf-tool-spe1-2-v2-v4-0-83c098e6212e@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Namhyung Kim <namhyung@kernel.org>
X-Mailer: b4 0.11.0-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a fix to allow unknown 'configN' attrs and then extends 
perf tool to support a new config3 attr.

The config3 support is RFC for context as the kernel side support[1] is 
not yet accepted. Patch 1 is intended for 6.1.

[1] https://lore.kernel.org/all/20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org/

Signed-off-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Fix event parsing test segfault
- Add 'config3' in event parsing tests
- Link to v3: https://lore.kernel.org/r/20220914-arm-perf-tool-spe1-2-v2-v3-0-8189fc04dcc6@kernel.org

---
Rob Herring (3):
      perf: Skip and warn on unknown format 'configN' attrs
      perf tools: Sync perf_event_attr::config3 addition
      perf: Add support for perf_event_attr::config3

 include/uapi/linux/perf_event.h       |  3 +++
 tools/include/uapi/linux/perf_event.h |  3 +++
 tools/perf/tests/parse-events.c       | 13 ++++++++++++-
 tools/perf/util/parse-events.c        |  9 +++++++++
 tools/perf/util/parse-events.h        |  1 +
 tools/perf/util/parse-events.l        |  1 +
 tools/perf/util/pmu.c                 | 20 ++++++++++++++++++++
 tools/perf/util/pmu.h                 |  3 +++
 tools/perf/util/pmu.l                 |  2 --
 tools/perf/util/pmu.y                 | 15 ++++-----------
 10 files changed, 56 insertions(+), 14 deletions(-)
---
base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
change-id: 20220914-arm-perf-tool-spe1-2-v2-cab789c5d598

Best regards,
-- 
Rob Herring <robh@kernel.org>
