Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABED8710616
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjEYHN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbjEYHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:13:14 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0DB10F7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8bab3b392so605991276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998750; x=1687590750;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOlx2WRh+JFuq5y5J1qgtXH5kcli3Ek1O+02SLEhl6g=;
        b=kmXVsTge4xmX+270y+4v3x5uW1+11ox1yW+hi9yEMgQn9sO0CHfD+VwreYbdFONYoN
         LjcOzr176iehQTRWpLbTvBtKPzDvkKPOHMOe5UJli8zL7Q/4efTzSwUWVeoLxMGAGIL5
         52U1NI/uaGB+bmjAvbSlPl1I+T4m4aHFhvV1yeGgJzmXFBme6m9WwsXSRMKvyohQDQdH
         cRhImkqUfXu2cmZJRZ+7FtGsPaqchPbL/I0+x+Yxy7oWeIg2ikFVuyIm6Vf3Y9N+ZFFY
         A573FB21aZOIgWnAoW2z8qnTLF+RMR9aL76pKKyKZht6Sn0y9c3r/kQMunTjTkCfFftM
         I/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998750; x=1687590750;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOlx2WRh+JFuq5y5J1qgtXH5kcli3Ek1O+02SLEhl6g=;
        b=YKNMDi3mmyw4up4tZguBjlBhrEBofBWoLanHbhH5C004JhxZKw1di5RZSsmPGAV1zK
         iytxYUpOSr7GXNgK/jSkMOlUxpqJUNZBcoOtPoD5K/EwRHGSSxXpxP/xMcVBXnZ+Kl+B
         vmwxk9R1e55g42BakA2ZXkMr7zgQAtjqeh6tWv7fii7lKpGipAWekFekUC9aftuDakpn
         8PJREUY5NB/00pnV2548hQ0Vxb6DIYbM1kwd9zT4d77bOAu5f0wsyCfdgpGSOwA0nXE+
         MAglK1fGyi0AgrXJbJvOWTvalzjz4OO1cpWMu0bnVbF/ir1H9lAOAn2Oqcyb0u7DBj9q
         dT+A==
X-Gm-Message-State: AC+VfDwJVaTW0MONnaQlVKh8PdQC1DUf9H/dehGPJ1KOCTExYAfEXAGh
        gvQ7PLuweea6slSs7EMr+Himq0s3Km5y
X-Google-Smtp-Source: ACHHUZ5IKhWTV/gXJDXr9pJVclWxuWbfOiaxQn3UH+XZ67yumdh7Bo9yq4vReN/76WBymOEj6XPPtLGWFSZY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:6584:0:b0:ba8:381b:f764 with SMTP id
 z126-20020a256584000000b00ba8381bf764mr1455616ybb.3.1684998750427; Thu, 25
 May 2023 00:12:30 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:31 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-15-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 14/16] tools api fs: Dynamically allocate cgroupfs mount
 point cache
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
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Ross Zwisler <zwisler@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cgroupfs_cache_entry 4128 byte array out of .bss.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/cgroup.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/lib/api/fs/cgroup.c b/tools/lib/api/fs/cgroup.c
index 1573dae4259d..250629a09423 100644
--- a/tools/lib/api/fs/cgroup.c
+++ b/tools/lib/api/fs/cgroup.c
@@ -14,7 +14,7 @@ struct cgroupfs_cache_entry {
 };
 
 /* just cache last used one */
-static struct cgroupfs_cache_entry cached;
+static struct cgroupfs_cache_entry *cached;
 
 int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 {
@@ -24,9 +24,9 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	char *p, *path;
 	char mountpoint[PATH_MAX];
 
-	if (!strcmp(cached.subsys, subsys)) {
-		if (strlen(cached.mountpoint) < maxlen) {
-			strcpy(buf, cached.mountpoint);
+	if (cached && !strcmp(cached->subsys, subsys)) {
+		if (strlen(cached->mountpoint) < maxlen) {
+			strcpy(buf, cached->mountpoint);
 			return 0;
 		}
 		return -1;
@@ -91,8 +91,13 @@ int cgroupfs_find_mountpoint(char *buf, size_t maxlen, const char *subsys)
 	free(line);
 	fclose(fp);
 
-	strncpy(cached.subsys, subsys, sizeof(cached.subsys) - 1);
-	strcpy(cached.mountpoint, mountpoint);
+	if (!cached)
+		cached = calloc(1, sizeof(*cached));
+
+	if (cached) {
+		strncpy(cached->subsys, subsys, sizeof(cached->subsys) - 1);
+		strcpy(cached->mountpoint, mountpoint);
+	}
 
 	if (mountpoint[0] && strlen(mountpoint) < maxlen) {
 		strcpy(buf, mountpoint);
-- 
2.40.1.698.g37aff9b760-goog

