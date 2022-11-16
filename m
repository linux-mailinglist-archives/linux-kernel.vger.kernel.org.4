Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5962B3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 08:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKPHWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 02:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiKPHWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 02:22:16 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C3A18F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:22:15 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-367f94b9b16so156237687b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 23:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VVBCM8+4ewIYbqSIURDFLLj3mOBnhhjT5+m4tbboLyQ=;
        b=T2CTy0cXc+GbTTmMdiCb9Zgs01lpkfqGh1mujEL0GETIM00jpRJOTM9isl/57BYYpO
         am7/2xYPhQGL51IQmeSydcgTMgOaCbBe/iWEF/1QaNs4uMmDGOjEvr6tThLTBP3xiTiu
         qHPrsTyARDCHIwmhf8qzvhgHN23WAFC155FXfQcUEMwQV117ZtFFqH+O50YFhgh70Lma
         P1Jyk6OLy9hgpbPJwnr+QQng0IkyDGXVKgZgY8bk5ZQGLHQ6yXAPN9Ft9qPzLO7+v4EV
         GNSDYjSHCj6mSU/5ZwuQxW88YpPNfWX0MEcWIElm4vIJpR4TkovIKaI5bhMOUMYLpEAD
         QKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVBCM8+4ewIYbqSIURDFLLj3mOBnhhjT5+m4tbboLyQ=;
        b=szu39fpqH0oXE7ydrM+C6gd/M9eK3Zwb/GlLAZ7dduUSelcc1C3LjNLANzxQGK1gpM
         46M6lLlWs+FpC43y2Aow5CsPXGx0QDLdQ/ejKzrz9OzGXOL55OqoWl7I6w1APH3zwp2h
         CfyLy1+QoYYiDy5cNuNaBWwxUABq6MjFh49Qi1HJuEBDlG/4h3crmEaMHvlryu0kSRuR
         9LR8BOqV37JeAnuWA1ia3JjoD7QW0a2xLdwkt8Ee4VC8ZU+V9SfnaCjGiU4HHICMDchV
         0RW8i/iJtgTkcPOwkGVn6+hpn7CpB5762oREI1VJtoI1uZKJU3V2YoWCTaqOffiSEnTm
         kjyQ==
X-Gm-Message-State: ANoB5pnAwzG8moO2pVxr/snFk1qRoKbtB9uxp1IgOcFJ/h+zpDRzwJ+H
        uiMfJ0ovRhFtRcRXWsgTz0kSfLzPVYgu
X-Google-Smtp-Source: AA0mqf4pIXOLejh00a4sx9JINJstuwQskCv32hgKgt29OuWehxer6qcT4BwlWPt2AFedMoyAfDHNiWoMQG9r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf0f:58f3:342e:c1ec])
 (user=irogers job=sendgmr) by 2002:a05:6902:10c4:b0:6ca:1f22:2bed with SMTP
 id w4-20020a05690210c400b006ca1f222bedmr19587576ybu.462.1668583335191; Tue,
 15 Nov 2022 23:22:15 -0800 (PST)
Date:   Tue, 15 Nov 2022 23:22:10 -0800
Message-Id: <20221116072211.2837834-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH 0/1] Fix perf tools/lib includes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

This patch replaces the last on kernel/git/acme/linux.git branch
perf/tools-libs-includes and fixes the race issue by using the prepare
dependency. pmu-events.c needs this dependency too, as the header
files it includes also include libperf - using perpare as a dependency
rather than $(LIBPERF) is more consistent with the rest of the makefile.

Ian Rogers (1):
  perf build: Use tools/lib headers from install path

 tools/perf/Makefile.config |  2 --
 tools/perf/Makefile.perf   | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

