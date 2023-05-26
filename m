Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E587712C90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjEZSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbjEZSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:35:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDCE77
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb78a3daaso1411155276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126087; x=1687718087;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7VTTKtJ+YCmNAzWS6HH1h35ihzZOE/hPBS/qDm91hC0=;
        b=RnExY6ZhiUsGU/Xentrdy3UMPkxwr6rNYwsycye1nTC7/8jZe1qfzeTGi8SBvaT+AV
         s1p20pEAtLwnLMgJ6JYIucfFa8uAD1GbQ5Jr3trkadq5Mf8R1bEXVSq7rvpSJ6fYxyhm
         i0DQjoDIb2JrxkF27AdoYZYTlIiCK4p/JIZv2TmSsaogeqt92G8VOk5D0VtrsRbHlKT6
         RoL78G7gNEsM7X0ixUo7P18Hz0x6GOCwxyWj0/RZM5+6ev/AYhCS0PgNoZCdHZMWlkxy
         cMdedvwrzsAqeNOl/mkmD5TyA5RgkJoCvN6+EKvxR2cp4DIA8F7BzRc+x92ihrDxDFf1
         Pk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126087; x=1687718087;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7VTTKtJ+YCmNAzWS6HH1h35ihzZOE/hPBS/qDm91hC0=;
        b=hK2FDxzxqCx9XmTaAmSq9Wj3mBhTRsssGVaJVIvi4sF4AIM8nmP7n3vMQkZVo4/MQT
         jJs2nBKBnvK9lH4XotL2wlD87peBfhb2lS+dCkvodYq0tSEil/nBVGpIF4qU5CC6+7zL
         mcJllzikJvR8H+L8E6PaYNcErVqCswjT2pF10Nu5jxlLF4Tx7w+qDAY53dEhBiLqdv3P
         K4IGbXuCGLR5xNYmWC0bvMflwjtBAHAyTzgqzCebx29ji8wwm+Eol1MRd05/EFEVajJo
         tZc1QTWfKrFC9BNgpUZNbd5b8gDwSqmLy3UPl6JqY6PdC5uLtTbdSY2l4gvOpm65wgyl
         kCug==
X-Gm-Message-State: AC+VfDztCeiBc+usu2xVqMdfwW11MwWuMn9f1KQsPjA2zekijvjmydB/
        +3jgknbudHQUGOwKSTQ9kkrRK1i558Sp
X-Google-Smtp-Source: ACHHUZ6VjiV8Ug0wv3GGrTVFrA/kp7xEirEOm2PN7sV0f+t+HxN+6Uw2r4vd73pfoFtHjbVNoFkMaHWU/AVS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:2403:0:b0:ba8:8ab3:3806 with SMTP id
 k3-20020a252403000000b00ba88ab33806mr1305870ybk.13.1685126086892; Fri, 26 May
 2023 11:34:46 -0700 (PDT)
Date:   Fri, 26 May 2023 11:34:01 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-17-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 16/16] libsubcmd: Avoid two path statics
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

Use a single stack allocated buffer and avoid 8,192 bytes in .bss.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/exec-cmd.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
index 5dbea456973e..7739b5217cf6 100644
--- a/tools/lib/subcmd/exec-cmd.c
+++ b/tools/lib/subcmd/exec-cmd.c
@@ -36,38 +36,40 @@ static int is_absolute_path(const char *path)
 	return path[0] == '/';
 }
 
-static const char *get_pwd_cwd(void)
+static const char *get_pwd_cwd(char *buf, size_t sz)
 {
-	static char cwd[PATH_MAX + 1];
 	char *pwd;
 	struct stat cwd_stat, pwd_stat;
-	if (getcwd(cwd, PATH_MAX) == NULL)
+	if (getcwd(buf, sz) == NULL)
 		return NULL;
 	pwd = getenv("PWD");
-	if (pwd && strcmp(pwd, cwd)) {
-		stat(cwd, &cwd_stat);
+	if (pwd && strcmp(pwd, buf)) {
+		stat(buf, &cwd_stat);
 		if (!stat(pwd, &pwd_stat) &&
 		    pwd_stat.st_dev == cwd_stat.st_dev &&
 		    pwd_stat.st_ino == cwd_stat.st_ino) {
-			strlcpy(cwd, pwd, PATH_MAX);
+			strlcpy(buf, pwd, sz);
 		}
 	}
-	return cwd;
+	return buf;
 }
 
-static const char *make_nonrelative_path(const char *path)
+static const char *make_nonrelative_path(char *buf, size_t sz, const char *path)
 {
-	static char buf[PATH_MAX + 1];
-
 	if (is_absolute_path(path)) {
-		if (strlcpy(buf, path, PATH_MAX) >= PATH_MAX)
+		if (strlcpy(buf, path, sz) >= sz)
 			die("Too long path: %.*s", 60, path);
 	} else {
-		const char *cwd = get_pwd_cwd();
+		const char *cwd = get_pwd_cwd(buf, sz);
+
 		if (!cwd)
 			die("Cannot determine the current working directory");
-		if (snprintf(buf, PATH_MAX, "%s/%s", cwd, path) >= PATH_MAX)
+
+		if (strlen(cwd) + strlen(path) + 2 >= sz)
 			die("Too long path: %.*s", 60, path);
+
+		strcat(buf, "/");
+		strcat(buf, path);
 	}
 	return buf;
 }
@@ -133,8 +135,11 @@ static void add_path(char **out, const char *path)
 	if (path && *path) {
 		if (is_absolute_path(path))
 			astrcat(out, path);
-		else
-			astrcat(out, make_nonrelative_path(path));
+		else {
+			char buf[PATH_MAX];
+
+			astrcat(out, make_nonrelative_path(buf, sizeof(buf), path));
+		}
 
 		astrcat(out, ":");
 	}
-- 
2.41.0.rc0.172.g3f132b7071-goog

