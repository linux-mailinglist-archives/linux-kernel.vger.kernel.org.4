Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBF9628B0C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiKNVIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237492AbiKNVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:08:21 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E055BCBF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:15 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id my9-20020a17090b4c8900b002130d29fd7cso10839437pjb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=pSM7kTnmOSbosw8Hcy1wsfrOJtWX0Vk4M1VXbCfpBsnal65+1d2sh4Bhl/sPSG3WjZ
         oRq//RYKeswTfgFYSJ4Nv7F1CorCaBz6F1obJiSvGR021sk3+MiS3J0CKDoAThtT7mNL
         c5XvgVjLnyw/ULU0aatlPRu9cxq7LW4TyrQHf9201uJ5GhHD/OrtslM86NlZo0FNpgY0
         JcPC2nd67BGMddaSuKOAOFjPZjksyqaw2aj3O89nIhPVu/bl9Ccf1tqlOp2uQFr7akdO
         lj4Eu321mO/ZVaguwrY9uNagHeDPUAhFSZNIxiC1unT6sMrpC8hTQ/YF+wfl+wWOmNCc
         RtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Se2me6lbjg4dS4DNtZbL4NOOrQgzrO1DuLy7bKVPgtE=;
        b=E6FZ0JyQujwzh97ql+Hj9vlqe+3cvel5vp5d/CuibVlp0vm2ZGq4KNj3V00g48TjMO
         mq7F5Ogat1BYmSxS46AKo6dTfnekDxAfn/yE8A9I3Dv0764S+rO0+VsFCXvHMJtHALYY
         k08+z/nWWa2h20iTf1qCQz/7IjH6gE1h69LaOjgwoKOvitrkOHhN17HUYiV+ENbLf/g7
         OhNJCvVee9W5kzC27+4N2g+MwtMSrz2Pck7He10D9J1/fHcU48qIsTMKRsoZNyHs4/5C
         08YiFeW1k1RjmMuHGiVRHWwz8bQ9GvDIzHc3HfgWzzILxuwoA4dAsV8sFvzxy5bIlFqE
         Iaiw==
X-Gm-Message-State: ANoB5pk+G4kTJ3DmFgtf9Lc3EpN5+TBxX8AcmBYmzozvGTXsSCe+T/rN
        uZVpEHDH9D5Wyo+jaf1fKcRTs3HdBs2R
X-Google-Smtp-Source: AA0mqf6Z9g60XXYxfp7n+hZq20oXkSrKY1lCSw9Obhp7yu+rX+Z5SlNdIamZ+6QNg/KExsAVnRH1hkcLDMw5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:aa7:8a41:0:b0:561:70b3:6a6 with SMTP id
 n1-20020aa78a41000000b0056170b306a6mr15444394pfa.25.1668460094565; Mon, 14
 Nov 2022 13:08:14 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:16 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-4-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 03/10] tools lib api fs tracing_path: Add scandir alphasort
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

