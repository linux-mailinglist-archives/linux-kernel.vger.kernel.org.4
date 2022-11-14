Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC6E6276BB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiKNHwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiKNHwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:52:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C718E2A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:04 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id h4-20020a5b02c4000000b006bc192d672bso9924412ybp.22
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=skjOcOVezhkNivzHdrlRJj9IRahl3h/VWNzo5hRIj2w30ZYRyRGjfWfsWLvsahiBzK
         TEnJ+26u6RFvrOCPo6OV4bihXGHHzAipuVWws+yB7a4NEACFZI2Q7dDlqmu6HYAIy1qa
         wONNR/kCNcjucqXIUpHaLv9wK4bY35su0XQUfN7U9WQ+x8e928GvxlpsO5S2ov3m23Ol
         v/2UXAyYNW+8yapyGvQjg93m7nzrSIKO6RzlOF7n76/SmP0tzX5F1rVsUv66I7RR1YO1
         Y8bepBwfBkh3DS1sysq3x/XdOVR5mjE1mk/l/VQBJRmu6SYD+rnIKXEwOmli8N9iqYWT
         Wa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=Nyqay2SP1sx5z8WWab7bX/ERhdYpDUcpBmoUlC/aG4/nEJ4lwB7pMJRIUDlNmHAezR
         r1rdLIgsxkiSI4s35rLKSoC0DvUM4bqbc3Y6aVRk5Tqjq68NB320PS1Euku5ZS8yrd84
         CT8V0ScGX1zb/eJ5e/okoXyGg5rlpQUFyr7beUU17/gP9XWpnkjT52b4S4W02wxJvBJN
         sGslF8Ar4tGoDedihNhlzAYmVnPXt5LcqyVXq8rKiTFFZj7MyYYq896uJ73BhXLy8YBi
         gFwPEA91IDX6COdU5uMlkqv89qvmQm64t+AQTqcTdZvdvKOWFp8xgv+IlWiORqto7qpC
         Mtvg==
X-Gm-Message-State: ANoB5plOF7D9KK/HcgoZG5fyABnkhGY4jQp8OIUKcaeuWF3rac4AUswA
        EeFCJ/hngAjkgxepYxF41OuIkVrR0j1X
X-Google-Smtp-Source: AA0mqf7WN3Yxf6tqN8xl9/ktJuMPykKkIqFppU42Xdn3/s9U2LduWEUC6QQNBKgNDSup0fpzwljf+fEXGQe9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cba6:8279:98e6:3d6e])
 (user=irogers job=sendgmr) by 2002:a81:61d7:0:b0:383:e534:3a7a with SMTP id
 v206-20020a8161d7000000b00383e5343a7amr0ywb.24.1668412323327; Sun, 13 Nov
 2022 23:52:03 -0800 (PST)
Date:   Sun, 13 Nov 2022 23:51:20 -0800
In-Reply-To: <20221114075127.2650315-1-irogers@google.com>
Message-Id: <20221114075127.2650315-3-irogers@google.com>
Mime-Version: 1.0
References: <20221114075127.2650315-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v1 2/9] tools lib api fs tracing_path: Add scandir alphasort
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tracing_events__opendir allows iteration over files in
<debugfs>/tracing/events but with an arbitrary sort order. Add a
scandir alternative where the results are alphabetically sorted.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/tracing_path.c | 16 ++++++++++++++++
 tools/lib/api/fs/tracing_path.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/lib/api/fs/tracing_path.c b/tools/lib/api/fs/tracing_path.c
index 5afb11b30fca..b8e457c841ab 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -113,6 +113,22 @@ DIR *tracing_events__opendir(void)
 	return dir;
 }
 
+int tracing_events__scandir_alphasort(struct dirent ***namelist)
+{
+	char *path = get_tracing_file("events");
+	int ret;
+
+	if (!path) {
+		*namelist = NULL;
+		return 0;
+	}
+
+	ret = scandir(path, namelist, NULL, alphasort);
+	put_events_file(path);
+
+	return ret;
+}
+
 int tracing_path__strerror_open_tp(int err, char *buf, size_t size,
 				   const char *sys, const char *name)
 {
diff --git a/tools/lib/api/fs/tracing_path.h b/tools/lib/api/fs/tracing_path.h
index a19136b086dc..fc6347c11deb 100644
--- a/tools/lib/api/fs/tracing_path.h
+++ b/tools/lib/api/fs/tracing_path.h
@@ -6,6 +6,7 @@
 #include <dirent.h>
 
 DIR *tracing_events__opendir(void);
+int tracing_events__scandir_alphasort(struct dirent ***namelist);
 
 void tracing_path_set(const char *mountpoint);
 const char *tracing_path_mount(void);
-- 
2.38.1.431.g37b22c650d-goog

