Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148A46DB916
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 07:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjDHFpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 01:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDHFp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 01:45:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FCAE06F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 22:45:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id t66-20020a254645000000b00b74680a7904so741400yba.15
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 22:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680932727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0hxgJgqnC0+JsksRdljYIzPrGg+wXpcXiVbKsfF358=;
        b=qw9MtNcA6TM4Uc404G84F/Bzns60ZkMzlndW0uwAU87+6Dlhc/IZc3HjiIoF1xeU+d
         U3hUBqNcyzYf2qfjCiz5LuYTujM7tAYuku5tArrCTytWeq+qUvoGOWGfJ3gQFcxKN3SF
         Zo3rxFWCL4J7VqGgUVzeX4fqRwQ5S9ZSGNmLuHtVDYj/0ILba7DlFJc8VBvCiI6zFPw8
         QBhWFnmZ5swLMGXSjNxXlO4hXABDdCIZB/ZGHl5wbJsGL57oSKOZc8+2+ml1t9PgUi0H
         3jwU8UEvErOiHq3d3YhdL3ozNtL/8XLtd3kG7IUMrJWrigWfB+siwFiAJD8Sk11sHWHV
         lEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680932727;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0hxgJgqnC0+JsksRdljYIzPrGg+wXpcXiVbKsfF358=;
        b=zxXoHUNR01dI6SfXW46KYge57GpYBGKHvQekXSsDw4dEWyo/n/70KLmRrxLaHLARzT
         3ti/NSsrt3PCi1TAi/hskfyeLyFuhmu4XrYWgQ5ZTdSOWwqAwSLQcriqfDuIM6ttXiad
         aXj4msfbLm2unsmzILYoUESfgYBuWjmCXN0SppHSIb7IBbjuWeENupTArAbtdpCLPaDn
         otKibwBXzwM28n6e9flSysSvxgQFrLj3ll7Otzlq0Ivt64XiwKWNsmZQ/0NL19w5W6Ht
         yopnfMZ1P6XhmI1DTs+j58S5u35SEvB3zYYSt18IO8TZpp5Ja+QOxY6ySSrkCXYEmLd+
         O0lQ==
X-Gm-Message-State: AAQBX9euGb/G+etZJtk59ftMq50utYKSvGyNGTjv2u1bRfjAMFpBTtpR
        cMlgBNDpopPdMf7RdJqnX71SXGXvNe7C
X-Google-Smtp-Source: AKy350a2BBosTV8xapP2mnsgztFIQfd2tZnlADXgK9DjzBFWcgpAyK8xa/E0fN6tT9FkBf64x47irVtA5cg/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b240:9cdf:7861:b23e])
 (user=irogers job=sendgmr) by 2002:a81:c54d:0:b0:544:8bc1:a179 with SMTP id
 o13-20020a81c54d000000b005448bc1a179mr2292963ywj.4.1680932727144; Fri, 07 Apr
 2023 22:45:27 -0700 (PDT)
Date:   Fri,  7 Apr 2023 22:44:55 -0700
In-Reply-To: <20230408054456.3001367-1-irogers@google.com>
Message-Id: <20230408054456.3001367-3-irogers@google.com>
Mime-Version: 1.0
References: <20230408054456.3001367-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 2/3] perf stat: Don't write "started on" for json output
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
index 38133afda7fc..40770926a230 100644
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
2.40.0.577.gac1e443424-goog

