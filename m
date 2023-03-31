Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99D6D145A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 02:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjCaAtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 20:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjCaAtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 20:49:47 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA1412CF4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:49:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5417f156cb9so205503247b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680223779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjS2ubyipVi2ZMDZ77od8b4DQTs3LsPG+UyJYia9quE=;
        b=Z3sRXpowh/3nWuTnA9ABQqlwKz9e/xaBcX8rB1G+JuHoqvIkDMhppRkNVRu2bUEHZD
         DcC346N6icjGxjlxtlLeXPBaAoXHoIDXDh/8n1hZk1rYidPWX5OaeuTCkDt50Bv0q+Lu
         80Xjxt8eqOOsrqHIuSE0bNDLJRDkZXu6yTVVZ62h9kqTeGsLVb9Yo0Ov9CtNO8orwV9A
         0LmbNG+Wz6nzzMPQ19TvVwytQedxgKy0Nm7IRaiblHe2QebEnrZhCIxN1WOuvKyBciAi
         d/wPJXHFQHM9MVHHwCPIjIIKK7gCJj02pIeZBIQipfsYZR+VBL4ws1tnoHf+kPTyKWXD
         gnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680223779;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjS2ubyipVi2ZMDZ77od8b4DQTs3LsPG+UyJYia9quE=;
        b=mTKOcF6zRZA2XS9ttMyQn/vjDa7e0Ee+wLRhbK6KqWrNkUz6rmoR03QMAJ4JmRc5Vf
         IAibeS1nwmpfB/sTvFaDcRMbwHwIfFHau681ulGmxv7ZM8Hq0x7unJzF9snCjBQR5xCc
         qrFzd89GXuM7mRdjGbIxsW2KUUyzXgJo7XKj5vQcjoHMGq18fCXw9/y7GEPKDU4xlYb+
         RBoaZCJOXE5YAUgQJCTzO/qjoj2hyCyTPzcVe5nntgCpMDh4sXhhZ95QymuzYsPcngeg
         OIlVvAz/URHnn5vA4WFfjRK2mz/G3oZJtkI6Wo7x1/plh4Iy/k4q82b2l8hzLdzz3ZiV
         /kvg==
X-Gm-Message-State: AAQBX9cHcue8/ZhKcVpxmtvJ7u6N9B36RAppii0AhzFLMBUBTyJO0J7V
        ETHurni9FU+6lz74a7Ae62T41Hee8cns
X-Google-Smtp-Source: AKy350a3m5BHFnMmj6UwcvTHHQb2LbUjX3nn1IHOfBofEyRM+5fd1eyYoe8wYYAs+1wdFn70nEN5YmCfcHDW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:11ea:eb75:e48c:2c04])
 (user=irogers job=sendgmr) by 2002:a81:ac64:0:b0:545:6106:5334 with SMTP id
 z36-20020a81ac64000000b0054561065334mr12667656ywj.8.1680223779432; Thu, 30
 Mar 2023 17:49:39 -0700 (PDT)
Date:   Thu, 30 Mar 2023 17:48:44 -0700
In-Reply-To: <20230331004844.1592789-1-irogers@google.com>
Message-Id: <20230331004844.1592789-5-irogers@google.com>
Mime-Version: 1.0
References: <20230331004844.1592789-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 4/4] perf srcline: Avoid addr2line SIGPIPEs
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
index 423ddf3967b0..bc3e48afe054 100644
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

