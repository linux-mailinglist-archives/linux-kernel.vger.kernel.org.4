Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3726A0296
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjBWFx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjBWFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:53:26 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427F2A6DB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:53:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536cad819c7so98421057b3.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DDgXS1ftumo1r65N+SbOeCecYRv//vJu/P3chpFR5JQ=;
        b=nm+fgnXRAHDlICA2dS9MgRkbQs2nSJVBBOYglg3/KRf4PfqmJIHgcrQMjNcz9Imaye
         3XuYy/14YPK1YzI98f3OtdXzP+LyJywgOkBk7gjTk3Lg0WkzEGFjbSGpHQOBMOBY13o5
         GvW0Iku8BKE9SFt7eW9e3BOTuaCs685odbhFnO/6TdUKtAyk9qKZXplCsm/3S6+PmCwO
         XX13ETDSg5gEUyBVnFGjBmB6KLBP1gCFpnpBTr+GxC5ACwJdH+N/hl2Ak3tvry1+zALV
         DBWZ3fXGZbPzZnekrzozq9Zc2vGygAMxvhQUj/Ve9RgEBEi/kvOp2xU4EvY1gIuWjJkt
         caIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDgXS1ftumo1r65N+SbOeCecYRv//vJu/P3chpFR5JQ=;
        b=Z7MdbwFvzCO6tdFNlYs90Ae7KwJJ1m15LY/MLr+WSkKKKrRdv1SOlWpITklhF2/I7b
         I8TQA+dTe0oHnj0ce9WLQLh2v9JWfKwn0mpnKD0PmA8yE3D4Kw9R0qq0J7I8CqKvlbHf
         3VB+qx748PpNj9bYizebbbSv1FvQLGM/Wpfuv3mtb+O5FS5S57DPf3Ofgw57thJjuGg3
         Kw55rzr96m2fOa3fyJbs04XogSVcAH1dnuKLWYAGkl9xd0vFQnOE8itryOrVy1XICnOq
         sasE5VIbI8REAyUv1yQh0dBdixHYXm0xmXsncH9Ahh4WwJCi5Si5DepTkOFnW1t427JX
         7PeQ==
X-Gm-Message-State: AO0yUKXc38V7etGooXGBDj2t9GHpj9F+o9GSn5me8OQDiv0rgXLmvNLf
        SBEAQ2EPIn9TlbsxgUBdOfqNTJpLgINq
X-Google-Smtp-Source: AK7set+p2Eid2y8XQfngFt7UiVeZneEnwLO+j03PtLgelli3+OybfcZRHUyv64woWmRAA9xg93yark0S4EKT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9002:67cd:9e6b:7083])
 (user=irogers job=sendgmr) by 2002:a05:6902:138d:b0:a09:314f:9f09 with SMTP
 id x13-20020a056902138d00b00a09314f9f09mr1623114ybu.6.1677131604657; Wed, 22
 Feb 2023 21:53:24 -0800 (PST)
Date:   Wed, 22 Feb 2023 21:53:03 -0800
Message-Id: <20230223055306.296179-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 0/3] Update Alderlake and IcelakeX events
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Alderlake and IcelakeX events to v1.19.

Developed on the perf-tools-next branch of:
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

Ian Rogers (3):
  perf vendor events intel: Update alderlake to v1.19
  perf vendor events intel: Update alderlaken to v1.19
  perf vendor events intel: Update icelakex to v1.19

 .../pmu-events/arch/x86/alderlake/memory.json |  8 +++++
 .../arch/x86/alderlake/pipeline.json          | 10 ++++++
 .../arch/x86/alderlaken/memory.json           |  7 +++++
 .../pmu-events/arch/x86/icelakex/cache.json   |  8 +++++
 .../arch/x86/icelakex/floating-point.json     | 31 +++++++++++++++++++
 .../arch/x86/icelakex/pipeline.json           | 10 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv    |  6 ++--
 7 files changed, 77 insertions(+), 3 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

