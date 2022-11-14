Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B253628814
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238300AbiKNSNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238354AbiKNSNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:13:32 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B3617A98
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:13:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a250fd5000000b006ccc0e91098so11129384ybp.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=Udp1PTHKxUUEwOqdgvMUBoS44uHDNucmnfPc1wYaH/Eaj3JkdwS1KeKqeAZOzlQrsX
         xBTR9whWAVfnvkCVljv/bx91QT8WQafusEqzylUtudDl/GEJfrd1i1liZVtH2vko+2H5
         bt14BPmXoGjUfQV+rmPJb6f6rY6hfl2pfEz+gPNYzA6vBH8xk2kSlMV1KMpjVvx3w3xM
         CSm1/uSgSEJ6Is8EtJq8s9kT/lnMYVYnsJXysDAQaeu7a6c+4MUZ34saLOmYhKO+lb7k
         G9bJ0JXt9fyiSu2MfOhjnx63lMQi92IweinE5pmYDVc31iZR6FLDggptsMx3AW4BVjmd
         itMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=xlq1/gbwEYtA2zZog+aEru4c5A/8ns8jDEiJyBWB1yukMWOEJKbgTZoZW5uL4rhmVp
         IBuoMqt1zPsaplc9Go5SztutlZxQy8xG2S7WSIwNyGfsvfefE5j0jxE6czV0qZyBbyos
         v5FirBAKJxHSpF4I1ZP2v82Q/6Jd4O0wl0vLWTWPMwu2SIAAP61ipy5EPwBjIPsk/OZF
         7b64RaHse0wgHonQ0teilzOPnirZNCbU1BouXjQ2ZOuGoh11QP0eVDEgx3tpV9h81ipE
         8ceS0DO7EKyzl1WQb1NNbYuON/XW+ScRzLgLcxNSS0celS2VaNUXul1Pa5zmzQJ29FfC
         Q3pg==
X-Gm-Message-State: ACrzQf13d5qHEp6rFAWUwoLxFoRGNATU3Q8v8lXk1USAGBm3EdDoaWok
        QY0bzlh0ASsg+TFRp/AvXp0viQdsKCoZ
X-Google-Smtp-Source: AMsMyM6nI6HLGD9Jx0YaVytT+hiYtZyokdAdmg0KfsP1deiNrFwkH3PPbJEsSVXR/ANMa312Fb23d8oHANk5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a81:9214:0:b0:36c:7b94:aa57 with SMTP id
 j20-20020a819214000000b0036c7b94aa57mr63231927ywg.221.1668449608551; Mon, 14
 Nov 2022 10:13:28 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:12:44 -0800
In-Reply-To: <20221114181251.2683871-1-irogers@google.com>
Message-Id: <20221114181251.2683871-3-irogers@google.com>
Mime-Version: 1.0
References: <20221114181251.2683871-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v2 2/9] tools lib api fs tracing_path: Add scandir alphasort
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

