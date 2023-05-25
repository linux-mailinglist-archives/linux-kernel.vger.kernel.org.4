Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF7710618
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbjEYHOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbjEYHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:13:16 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4237D1701
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:41 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5653a78102eso7037927b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684998755; x=1687590755;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fUbHbSjVoUcJs86GoUKywFnnspnn0CwjY1A+xgeJcrE=;
        b=7LtR4l2JL/M4jrlSVU40EKtOPMO9N0dHxSoR2A3E+/SFXlYWvUTFqVwUxLJUSGlzDV
         F6u5E3ufJCkrh98qSFG5E9ePrbrARJkjqi9c1X5Xttcmj/6EVj4j2RBPb8B3ZL+Amrki
         yj3ZkWUqMrq7qgqbXOH+Q+Zx7PkrJQaD9q9U/zGCebFeL2Yo17ojkCnQ60ZOmbXfptTv
         ezVT76QHlFCtJvzF54v9e5KRtWbnKLSESLXIBy9oAHjzUYpyfy/+p/fmc3NOZgZCsB+D
         CPWb/PhGo7Drd9gjoehm7CMbM1mCV3R16jIFa7AUSXDPfXFXWql0HqQM9qAInpOaZ/xA
         20RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684998755; x=1687590755;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fUbHbSjVoUcJs86GoUKywFnnspnn0CwjY1A+xgeJcrE=;
        b=J2JZ90jSklSry8bxUZ2YcwxdsLhfUoPMjbRUdS0gqRx9r3MtIM46a/IYawqCxX47Gb
         LQ1ADrOygLxVug1yo73qbMoS2bUeH0KMYTwMtKAPvDL2+s38IDXUysGJxyUGoD6IFQV+
         FHbO8sZos0meTwbtZ0n7lL5mnkK3sD1utIcnTZ9CRfnUK5thZlNMBGfzAFgjf71Vp4vc
         wmosJ5GQ88d1vDTKvKy2XvLHOU5DfbpQPSNFdRSuqYbEbSYSA1sFqespUTcuxew/2Jh3
         Kv9kMYZkK9O91tTvDy3aXte/rf0x9ZRe6mhEMlgQ9vv4ehNQhDvLKj+ZmXAljQCBIEQf
         0hjA==
X-Gm-Message-State: AC+VfDzSNCzyQmAucjcmo75hgR0BiTwXShjohPnrvMzr5QNAwudn4Mvl
        cr30q4hspWqveuCr8Lk9K/yLLitjGDwL
X-Google-Smtp-Source: ACHHUZ6DYMEKjWI2+BEz4r2CwS0UkrArsaV42OVmb0uVNSR+netmY8Zy2pEdzoCY7oajTqfSioq+92W7Wt0s
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a81:ae68:0:b0:55e:14b:bab9 with SMTP id
 g40-20020a81ae68000000b0055e014bbab9mr12549654ywk.4.1684998754691; Thu, 25
 May 2023 00:12:34 -0700 (PDT)
Date:   Thu, 25 May 2023 00:11:33 -0700
In-Reply-To: <20230525071133.2066610-1-irogers@google.com>
Message-Id: <20230525071133.2066610-17-irogers@google.com>
Mime-Version: 1.0
References: <20230525071133.2066610-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 16/16] libsubcmd: Avoid two path statics
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
2.40.1.698.g37aff9b760-goog

