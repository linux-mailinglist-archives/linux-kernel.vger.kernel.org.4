Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AF76D69F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjDDRMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbjDDRML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:12:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57318211D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:12:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p12-20020a25420c000000b00b6eb3c67574so32553682yba.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680628328;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LWHvqfz3YxeQD1v/uiV9mdq3g7C5VbDQGJaMWdPaOZs=;
        b=oacv3eLXntq2o9FAHTXIUdSQXy9nkSZPlH4bBsV9G3bDIWS0RQAJn3tk4AWK6DO8mQ
         nWKF4bv1x3kumGkQofYnnAh9nr2Y1KhtHkbjQSzVMlygiy8H7vPJ0Uq3cHbgEsJ8iT1G
         iMStsLk8hmuUZCtmGPT3CxG1w5p1QIEFA68llHTXGt/lMG8XVaw5qNc5gDFYzFEIFeR8
         C+XfmVqM6rp+IlQPxePQo50KXcqAQu7VcoF+ewC9q0gApZRpa/ruFz3cpA35JhHS9o2w
         mu2xn9Nto0VL8PZCd4laW+5xF4BSiRNTdompzMd2cXKj0HE2boqQ9PfaCW0WYyjVd76p
         Ahzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628328;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWHvqfz3YxeQD1v/uiV9mdq3g7C5VbDQGJaMWdPaOZs=;
        b=dreW5bWKe1qMWy/uNZrrhTxdU6KTNSj7RzOWgCHdCUECZc1yEkUMv0dFERLZdlIT1j
         2UWR/DpxbYW8mk+zGBdRdtnOA+5E7L9nB3aCZwqhSP6uWx1L1evDP55OmiMncuKGxuFg
         Wc/oX61kx0mHVaNzDFZgp8lqnTnNsID/nM4WVySBjRj7BtIq3ksJcLJrqzKFuhhnrZC5
         SCr2LWr7k8BgvFMzF3xD/SBOhQN/PxMwfGaZKWjiAD/dPJNB7bQltoJv4JUw/ZIrseC2
         DzGM+fak1Y8ZN0MaQD6NjwZazYMXz58HTCFtGzBY3ctrn5Tplwv+sgvypPxDTRPGaJPc
         IrHw==
X-Gm-Message-State: AAQBX9e8vAKRhTzgcrwFvdCbJhhteQDIpH2uwApMv3fruAXpNvU8WE2w
        igtQ/g+3RmyrJSFJ+ZxZA6rnfWzbGCHN
X-Google-Smtp-Source: AKy350Y5GIsO5mGo3nCyF5ZvP0v3U+gNaSAzd6ZQYqJOP/FQmckIs+Y0gIRss/lREdXMVm4t9PSpKkO9UAbo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a051:e074:d6f:dc29])
 (user=irogers job=sendgmr) by 2002:a25:d257:0:b0:b33:531b:3dd4 with SMTP id
 j84-20020a25d257000000b00b33531b3dd4mr2000273ybg.1.1680628328585; Tue, 04 Apr
 2023 10:12:08 -0700 (PDT)
Date:   Tue,  4 Apr 2023 10:11:45 -0700
In-Reply-To: <20230404171146.2018616-1-irogers@google.com>
Message-Id: <20230404171146.2018616-2-irogers@google.com>
Mime-Version: 1.0
References: <20230404171146.2018616-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/3] perf stat: Don't write "started on" for json output
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
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Json files don't support comments. Disable the "started on" comment
when writing json output to file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7ef565ae7265..330f00497e6e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2272,8 +2272,10 @@ int cmd_stat(int argc, const char **argv)
 			perror("failed to create output file");
 			return -1;
 		}
-		clock_gettime(CLOCK_REALTIME, &tm);
-		fprintf(output, "# started on %s\n", ctime(&tm.tv_sec));
+		if (!stat_config.json_output) {
+			clock_gettime(CLOCK_REALTIME, &tm);
+			fprintf(output, "# started on %s\n", ctime(&tm.tv_sec));
+		}
 	} else if (output_fd > 0) {
 		mode = append_file ? "a" : "w";
 		output = fdopen(output_fd, mode);
-- 
2.40.0.348.gf938b09366-goog

