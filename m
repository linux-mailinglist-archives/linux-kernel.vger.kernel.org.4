Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8373E713233
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjE0DoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjE0Dnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:43:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B0198
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-565d6824f2dso1681927b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159030; x=1687751030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4yvnrpEe2huDW+hchGpet0pGN4yM12JCmRSaRQwE34o=;
        b=vdiA+trob+vQwP/l9vkYEO9/z+6U1/nBEc0wU3JdgwguFq/5kezVdXsk02KtLWokic
         jtJreMGHT9MVlRplIvKdvswFPCDUeXNkYxrFl04Xx1hGU5kHz2z3sLpamee0nh/RrOVI
         viBOVpD596XUao9fsS4EeOEBtVMwghxosbyEPpZtX4JNhLSEfcL0wOtlv10Kg4p/dXau
         NkkT0UwPv0AZ2aBwmuokplOO+N00TAIddsDVI3u4RfDaT6FgTuPAzVfa5dzTk8Yfc6wV
         029oV8TOze6RTO2N7r1o0vCDMPnWgvQ3bwIbYujMjtLmDtk1Ybas1ucjEbaCOQQnwSxQ
         tiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159030; x=1687751030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yvnrpEe2huDW+hchGpet0pGN4yM12JCmRSaRQwE34o=;
        b=M1bcdRFQv4dZqfB1g07kx0yrvORIxUH+M5rsrR8coVFHJEz+Ii34AWEEluWVTNMGUO
         2Q5l/rwaqXJED1rLARmMJREJP0SZNzn53xm2S0+T9pNKi+PqUlqHFXZBhi9BqziWuO+x
         poiIygKP6CtqkVo+MyrcM6MBCMKklSKcU7p8a0i4AbnmfMooR7Ifzz4lMvklsmrX9TSk
         BrUrOJvu+He6dSW8XGYK0GGOGWfyp9I2ioJWXMzCB4AhMPWSkTvz/dXBMi+NV1xvy5V0
         ae+BXIHQfuZSr7IeC6E2ffRdMl0PRLr317SfWvzGaeHKCRrRqxO/au6G00JFrRFsXFkK
         U/6g==
X-Gm-Message-State: AC+VfDy3hvtMN+/ZwW2foR5YX159oW0x0zli4aBq/IxDgeNkL3Ngoql0
        AOG4hlGw54x+3yS0A9YFwX0dfobpGUNd
X-Google-Smtp-Source: ACHHUZ4Zsr/NqIVSUKSFW44V5X/YdTceRVOHBh7ZeU4ozH2kjIPNTkmdKhb86VBC89V8M7NU9xpcWemAwXDt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a05:690c:711:b0:565:cfac:6d15 with SMTP id
 bs17-20020a05690c071100b00565cfac6d15mr502739ywb.8.1685159030508; Fri, 26 May
 2023 20:43:50 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:22 -0700
In-Reply-To: <20230527034324.2597593-1-irogers@google.com>
Message-Id: <20230527034324.2597593-5-irogers@google.com>
Mime-Version: 1.0
References: <20230527034324.2597593-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 4/4] perf inject: Lazily allocate guest_event event_buf
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_buf is 64kb (PERF_SAMPLE_SIZE_MAX) and stack allocated in
struct perf_inject. It is used for guest events that may not exist in
a file. Make the array allocation lazy to cut down on the stack usage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index da8c89fefa3a..d68d25575b6c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -47,7 +47,7 @@
 struct guest_event {
 	struct perf_sample		sample;
 	union perf_event		*event;
-	char				event_buf[PERF_SAMPLE_MAX_SIZE];
+	char				*event_buf;
 };
 
 struct guest_id {
@@ -1372,11 +1372,19 @@ static void guest_session__convert_time(struct guest_session *gs, u64 guest_time
 
 static int guest_session__fetch(struct guest_session *gs)
 {
-	void *buf = gs->ev.event_buf;
-	struct perf_event_header *hdr = buf;
+	void *buf;
+	struct perf_event_header *hdr;
 	size_t hdr_sz = sizeof(*hdr);
 	ssize_t ret;
 
+	buf = gs->ev.event_buf;
+	if (!buf) {
+		buf = malloc(PERF_SAMPLE_MAX_SIZE);
+		if (!buf)
+			return -ENOMEM;
+		gs->ev.event_buf = buf;
+	}
+	hdr = buf;
 	ret = readn(gs->tmp_fd, buf, hdr_sz);
 	if (ret < 0)
 		return ret;
@@ -2399,5 +2407,6 @@ int cmd_inject(int argc, const char **argv)
 		perf_data__close(&inject.output);
 	free(inject.itrace_synth_opts.vm_tm_corr_args);
 	free(inject.event_copy);
+	free(inject.guest_session.ev.event_buf);
 	return ret;
 }
-- 
2.41.0.rc0.172.g3f132b7071-goog

