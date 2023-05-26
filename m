Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE1712C82
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjEZSeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbjEZSe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:34:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C3CE4A
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba81b24b8a4so1403314276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126064; x=1687718064;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwZgXsbfM/yRQGwLSKe9ovUWpmwV9Y2ViG2ttFwDyVc=;
        b=P3WUQOpO/2OmEOWL4v68PeX96YDZimXT3rksqKLMrmTrK8MQxkjC2umm8fvsEWccSJ
         /+3D7ziJhJVmsGLBZHd2l5tRIO7p8REM6v+m9EM4FaGNzpkanaUiwFR4n2fGmbR3TqZj
         CyTVWt5TbJacZkoXPvlNL/2I5nV7E8WwbiLVUNRcc5sBWUoNrcZ2JbzdxgJCWl29r9R2
         tPDlq6QcYaCLHgBUZgKsG/W2uJYhOn1wo7q/9aCVZT2CPNgk1dSV5O2RtRjiuXwpMc8t
         sHTHcZHRs2MUtlMChsPH3SQmiyrViokTjF8+5FMMzdXPJjJ/eprAcM7as6bwEjmHpCpx
         Fmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126064; x=1687718064;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwZgXsbfM/yRQGwLSKe9ovUWpmwV9Y2ViG2ttFwDyVc=;
        b=jkJrBjUOcJvn/9bPsYZEdwyYvg7+/AIfOwt6ii0HS6uZWSr6bcnxq4mBx1Ze1exJuG
         Im3TPw3x7y7VFz0E5wqvgUMCs7ZU+n+iGRTZZmRT87O5nN3q0OUrDRBh7HsfDaeQynfQ
         8hD/XIPtTsi2fgVV2U0TIzMXyESy+/m1DWtHFJb+EWJtw54xH90VQ7v4K39h8klE9Vg2
         SFm0SamOw4mWoMel6hd6xBLCxv0FFtaBEi2f/x2jRA+3fF762RQsvgIQG2hogLaDwDlC
         N2+Dl+u2r/ikSO29drMYdiPBFheaOQ7f7IdUhBelHuH8cRhURQ8lLj12KecGyBqhQgDI
         iYUg==
X-Gm-Message-State: AC+VfDw2T6lWQIDaeBcK/IXAtind2x5ml8/VpW89zjA3rKnUjNb9CTfm
        vgdbUn8m+SvBZPP5QRR3qC8Pp4vCg1k/
X-Google-Smtp-Source: ACHHUZ7oC0kj5UVzgKLE84lwKOIsiFYUI4ZOIiTEKnYoI6Wvcg5eFnNtZbjn2Lxucx3jJfRhp27zzIBPDbe6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a5b:70e:0:b0:ba8:97f8:620f with SMTP id
 g14-20020a5b070e000000b00ba897f8620fmr1379099ybq.8.1685126064565; Fri, 26 May
 2023 11:34:24 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:51 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-7-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 06/16] tools api fs: Avoid large static PATH_MAX arrays
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change struct fs to have a pointer to a dynamically allocated array
rather than an array. This reduces the size of fs__entries from 24,768
bytes to 240 bytes. Read paths into a stack allocated array and
strdup. Fix off-by-1 fscanf %<num>s in fs__read_mounts caught by
address sanitizer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 82f53d81a7a7..22d34a0be8b4 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -88,7 +88,7 @@ static const char * const bpf_fs__known_mountpoints[] = {
 struct fs {
 	const char		*name;
 	const char * const	*mounts;
-	char			 path[PATH_MAX];
+	char			*path;
 	bool			 found;
 	bool			 checked;
 	long			 magic;
@@ -151,17 +151,23 @@ static bool fs__read_mounts(struct fs *fs)
 	bool found = false;
 	char type[100];
 	FILE *fp;
+	char path[PATH_MAX + 1];
 
 	fp = fopen("/proc/mounts", "r");
 	if (fp == NULL)
-		return NULL;
+		return false;
 
 	while (!found &&
 	       fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
-		      fs->path, type) == 2) {
+		      path, type) == 2) {
 
-		if (strcmp(type, fs->name) == 0)
+		if (strcmp(type, fs->name) == 0) {
+			free(fs->path);
+			fs->path = strdup(path);
+			if (!fs->path)
+				return false;
 			found = true;
+		}
 	}
 
 	fclose(fp);
@@ -188,8 +194,11 @@ static bool fs__check_mounts(struct fs *fs)
 	ptr = fs->mounts;
 	while (*ptr) {
 		if (fs__valid_mount(*ptr, fs->magic) == 0) {
+			free(fs->path);
+			fs->path = strdup(*ptr);
+			if (!fs->path)
+				return false;
 			fs->found = true;
-			strcpy(fs->path, *ptr);
 			return true;
 		}
 		ptr++;
@@ -227,10 +236,12 @@ static bool fs__env_override(struct fs *fs)
 	if (!override_path)
 		return false;
 
+	free(fs->path);
+	fs->path = strdup(override_path);
+	if (!fs->path)
+		return false;
 	fs->found = true;
 	fs->checked = true;
-	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
-	fs->path[sizeof(fs->path) - 1] = '\0';
 	return true;
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

