Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7628E713232
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjE0Dnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjE0Dnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:43:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B414DFB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8a5cbb012so2956731276.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159021; x=1687751021;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s/iIFRTutZ/Cgxehh+4C5m3fM6/hlPbbg/pKVn2e98A=;
        b=Ruqhmxe54X1phUoro1zDMJ0+jBGbZM1+IlrZINkNq/6Cx9BTzBijRnzcO28XGuu2cQ
         o+G9yZpvxYC058BUgh6gHor1KczcU66PyIvuho/fSIK9TroXU8+yRhuD+QsjUL4xY1yQ
         IT06eJNXwXcC9FQv+K+/AnafBZqiXO8M3MKRXkI6hpz0Oz3vOSJQbjHS99BUJdc2XXIh
         dh/4yF0nUorgFgPfFQxn/y5N48Ls5W8L565hroCl/7dzXRek5NLKe0EUqyD3rm39zWTd
         kfPeqpgAa248LODc9VWKF5P4zTCR3Ndt7LXx8TFPORrwCVOLdbS30M4MZ+MA3f0lE4+r
         DpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159021; x=1687751021;
        h=content-transfer-encoding:to:from:subject:mime-version:message-id
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/iIFRTutZ/Cgxehh+4C5m3fM6/hlPbbg/pKVn2e98A=;
        b=UGMw+CFkgYhASoCI2ig6RE753Mvsal8huYdXP1LyEFYuuRMsLk37JhmLjvoY+rvUEp
         HYLBnn6BGC7VEknmaIphQj5OhOv1R6mS4u2LnYlHjWXmlJOqzrOuJBlO9n9K4MFRIfoo
         geLXa2HlX9d9+Ppk67K2KcxbQ2vj1xVYqiT80nipYOJFtCi2ta4B6WDROipFsQQk5Vwt
         7hfkGgz1Q5gjQ4oxktZCS6Yd02nbmNr3qDUiD+roaPS45RJen1V5EasAV/tSIosGTnA6
         ePBv+ELEWvAZCpvf3ldRaxppf0beyApxklF0nXZ40gI3DYrSydVFXnVo8mhuEL8f2VE1
         /Pvg==
X-Gm-Message-State: AC+VfDyLOFLWAKxq9SeWVvtKOWpzi8Niu3hlLt3fK5IDx+ZHJbomtIGe
        fvv6VtI6oKqrrcmdfxheAaag+2Qoa90h
X-Google-Smtp-Source: ACHHUZ5zfXF4lXNV6DS2lJajmVshOGxHU54PEh2SlR+UQgpzqJCRMF3RM0t+r5MlWeqSHbNaGvoICQ9ldyZd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:68b:0:b0:bac:828a:e147 with SMTP id
 133-20020a25068b000000b00bac828ae147mr1428986ybg.9.1685159020887; Fri, 26 May
 2023 20:43:40 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:18 -0700
Message-Id: <20230527034324.2597593-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 0/4]  Avoid some large stack allocations
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following on cleaning up .data and .bss in:
https://lore.kernel.org/lkml/20230526183401.2326121-1-irogers@google.com/
Look for some probably too large stack allocations with -Wstack-usage=3D200=
00
and pahole.

Don't attempt to cleanup variable length arrays like in:
```
util/header.c: In function =E2=80=98write_cache=E2=80=99:
util/header.c:1269:12: warning: stack usage might be unbounded [-Wstack-usa=
ge=3D]
 1269 | static int write_cache(struct feat_fd *ff,
      |            ^~~~~~~~~~~
```

Also leave two allocations relating to session/event processing:
```
util/auxtrace.c: In function =E2=80=98auxtrace_queues__add_indexed_event=E2=
=80=99:
util/auxtrace.c:424:12: warning: stack usage is 65616 bytes [-Wstack-usage=
=3D]
  424 | static int auxtrace_queues__add_indexed_event(struct auxtrace_queue=
s *queues,
      |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/session.c: In function =E2=80=98perf_session__peek_events=E2=80=99:
util/session.c:1822:5: warning: stack usage is 65648 bytes [-Wstack-usage=
=3D]
 1822 | int perf_session__peek_events(struct perf_session *session, u64 off=
set,
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~
```

The biggest win is for perf inject where 128kb becomes lazily
allocated when aux or guest data is encountered.

Ian Rogers (4):
  perf sched: Avoid large stack allocations
  perf script: Remove some large stack allocations
  perf inject: Lazily allocate event_copy
  perf inject: Lazily allocate guest_event event_buf

 tools/perf/builtin-inject.c | 31 +++++++++++++++++++++++++------
 tools/perf/builtin-sched.c  | 26 ++++++++++++++++++++++----
 tools/perf/builtin-script.c | 17 +++++++++++++----
 3 files changed, 60 insertions(+), 14 deletions(-)

--=20
2.41.0.rc0.172.g3f132b7071-goog

