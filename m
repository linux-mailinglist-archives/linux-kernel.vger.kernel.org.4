Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECDA6D50DE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjDCSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjDCSl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:41:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E911D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:41:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-546422bd3ceso124306957b3.21
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680547277;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8W0bFO1La/7HK/HpWnbmeoTx54QZk6D+Z078ZNMeyCg=;
        b=m6LfHyI56ByW91W423utUqnJXSW4puezbyRvLd6hsvF1zXWMY7ZofDsdmw/fYmx7FE
         sJe5baFpA9RtIsAPV/TuuKyopzHqf8x5UkNGMNP+GpGoiGynVSQnFjaM+qXQySgIvwx+
         PpviiDCXQkgIgjISkk1CcHi80s4Dp3E3eRHHQqKOqoDDJgMb1sSV6jObKGSiFd96xoaz
         efTEqDOKLltwL2YvagCx265klOH3KpeZ04hy6yRfwooPWtXeqEVIBeKYS7iklOuGYFB+
         pE3VKKQoBOJHo7uXBa68D7TOgCN2ChVGEJEngsRm7GT4i0MP++uce4te53qFdGmSdqL+
         GkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680547277;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8W0bFO1La/7HK/HpWnbmeoTx54QZk6D+Z078ZNMeyCg=;
        b=IPkSkgpDnNljxDWhE7qC/pIqvWYQvDjmTPUBjju2rojlR73rON/UwN0ZD6Extf029T
         PWr94MHDhTDYSMruMZKF9m7uCYCUrF2RTH6S9MjR/T4H5iWBeZRF5dm7ICn5U8578US9
         ge75S44eAyT7Dm5ZwHvvl9bC5OuGvuPBxKfwoWdCPdkvMVzuKTzZrHdHCRzoXjQB3liG
         xvMR4y65T65dUm/HjU3ftN3evxYhkCQNea7nZy6bL6rOpvupslKJ3DOvMb+W9DhzP1rI
         2CTHKxP6kURjULP8Um7voEy0D9bSHrxtWljXY7obzdjxkfXCwDIoCuf8aqvUCs1O2AsN
         auUQ==
X-Gm-Message-State: AAQBX9dUGReCM5Tkv11G0mMlELuK+HNrgEnlKGMS55W6W8N8+tu7QQ8F
        HboXy4jmIoZPPk+T5GEGkFDg58wqs0Ro
X-Google-Smtp-Source: AKy350YA7iS2fx3kOTsfSZF1PwKeWeZXwx2DADzFWTKQU5tx6UHKq2lzlgfua94c/o+4RdLMBwIC0QQq9qCc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:a25:d9c7:0:b0:b46:4a5e:365f with SMTP id
 q190-20020a25d9c7000000b00b464a5e365fmr131859ybg.8.1680547277315; Mon, 03 Apr
 2023 11:41:17 -0700 (PDT)
Date:   Mon,  3 Apr 2023 11:40:33 -0700
In-Reply-To: <20230403184033.1836023-1-irogers@google.com>
Message-Id: <20230403184033.1836023-5-irogers@google.com>
Mime-Version: 1.0
References: <20230403184033.1836023-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 4/4] perf srcline: Avoid addr2line SIGPIPEs
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore SIGPIPEs when addr2line is configured.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/srcline.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index f4fcdada821b..cfca03abd6f8 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -473,6 +473,8 @@ static enum a2l_style addr2line_configure(struct child_process *a2l)
 				ch = io__get_char(&io);
 			} while (ch > 0 && ch != '\n');
 		}
+		/* Ignore SIGPIPE in the event addr2line exits. */
+		signal(SIGPIPE, SIG_IGN);
 	}
 	return style;
 }
-- 
2.40.0.348.gf938b09366-goog

