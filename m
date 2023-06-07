Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6119572532B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjFGFCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjFGFB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:01:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C15AA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:01:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so90582867b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686114118; x=1688706118;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QvFi009GvUhOjM1RbLEv9NwcPxaGqqvSNJxQoAxRjS0=;
        b=vW/A1GC/wbZqorAlFqZNL8iWKoE4whibGqUyFC0L6jPjX5lhAzhXMA/ADgJBVJ5bHI
         naRwZdeLS1N/D81KP5rkupydoYZgWclSYIJkRo1xvCO+gQ9e53tbA5Vld3nCc+QMngzl
         9nuZQ1xB+HA2jnO9W5Q7fPelFYUF/FXxuo9TZpuNuftN7S17Xfa2UBp9ZdIKvVvQyt3J
         xhMmhkS34U0+eWDie+q84TH03bhox6RH/MoSTv2647hm3o1weyNLncj6U8Yz0Dd4A6O5
         mw4cWOJGgAZMN3lqgySFBg4QqfFliZOKNWuiQVNZlOJnytkFRGATuzwdw43do24L5pmi
         9SYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686114118; x=1688706118;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvFi009GvUhOjM1RbLEv9NwcPxaGqqvSNJxQoAxRjS0=;
        b=NE/ScF67+FPqhxI8JkL67gD6i+Xa4Hbq5R7/FZj2d9pm2shWV998xHDdmpRqelYsWJ
         S6Ym3Zab/I5NJl4WqmQ2Qj2ZSsyQ4bvu6iOqgPsLbsVQUf3r8nBHvGkmOx6ARRYWC+xW
         89oEIhryeRtqefELXIuCwYDw73h0Zlovz87GhC2JWC45hNMuVDQpD9r2SSzgOZYRQY8n
         QzgPCxZ5HXnQD302ycuUewCdLRMTQ9pfG/dqFxhWHAwi4cHkhN9CTtawEJWW77Pw0kSM
         Ozr/Agd7dA64ERMowhVY0Ds1AOQxl//KTiiTTnj5xa0Y/TfeeTkJBqwhq7KE/9+nqhRI
         TqJA==
X-Gm-Message-State: AC+VfDxWA5iNp4F4TdfMF/UZCGUg7PUvgTsR+0qJs+VFDuzO4rymZp5U
        nDA2q7NdW4vRpSMhPU5xfPpiGfIf+f0j
X-Google-Smtp-Source: ACHHUZ6Vptuh7rpIg3guxouK2GwApLkfX1l+4RVrKhqAIHgtz2ACf15XrQZFJx/5uA/BI9L0MNH05zhSVqe2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3c35:209f:5d38:b7a1])
 (user=irogers job=sendgmr) by 2002:a81:ac08:0:b0:552:d924:a304 with SMTP id
 k8-20020a81ac08000000b00552d924a304mr2179004ywh.4.1686114117942; Tue, 06 Jun
 2023 22:01:57 -0700 (PDT)
Date:   Tue,  6 Jun 2023 22:01:45 -0700
Message-Id: <20230607050148.3248353-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 0/2] Fix leak sanitizer warnings in perf top
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andres Freund <andres@anarazel.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With these two patches perf top/report/script will largely run without
leak sanitizer warnings.

Ian Rogers (2):
  perf annotate: Fix parse_objdump_line memory leak
  perf top: Add exit routine for main thread

 tools/perf/builtin-top.c   | 11 ++++++++++-
 tools/perf/util/annotate.c |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

-- 
2.41.0.rc0.172.g3f132b7071-goog

