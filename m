Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFB713234
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjE0Dn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjE0Dnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:43:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043510E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5659c7dad06so34190257b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 20:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685159026; x=1687751026;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9j0CmaHr2uUosemIHAtUjvq8XY3iHL9ps0luhHrIcCk=;
        b=gP94xvi6b+zhoRwIWTjg46ZhS6rkzx7v2svFGYNNXWxrKKjrKZkCgerCW+USwJJ5lr
         DphEbgs/fpN3tL9iFWsEFPBd+QjBekbrjKrxPgtRMJMBINdRoYhtv0HLbHsNnNNjTto4
         zMvN9LoQtn8FeVFK5PRMnzt2aRP753TSS7fC6UUkL5JanuPV+CXgQjKFSEiYbAnnMpG9
         cnE92FWvxzPhyH5dbrPYcZ42MLhrVpMCSwkBajyldLx8h8j3+VLE9sX6eYCWWtoIkuee
         2W+LDEDYaiXbiWzCioLXqN1ZLyZ/Jsg+mkIeRy0Qseny+WqOUKzauWYSRsQGe6BioBKT
         if5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685159026; x=1687751026;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9j0CmaHr2uUosemIHAtUjvq8XY3iHL9ps0luhHrIcCk=;
        b=IAVoV3cBmu1pvNH3MkMBi8c2ed4+nvOMF7q473VFlT4CpvlBOg9tJVWDJ/rF/PSObO
         oKh6pcHoST442dCnwtX3nyXCHppATVUV138TUphVT56ig9Ctm+1WfozKCor2oNtAVD7n
         Wagecq9Vw367xNEkNp0wYbU07RfzRbdEXwnExTwJ3LJVv3Ws1kAm2BlqH63t/EPxluOQ
         rp6Hw6xz90KYQUHDjG4bi+H74HaFtuDmXIeq/2zUt5JRQl9mUmqPWsrf1LU7/ofNhKtU
         74Zjnn2TPGfBwKa8CDNTbCjRCqcbs5jP05lcOZWrNDOpAQrFwDmecacXYJQRhEMDLQBS
         o81g==
X-Gm-Message-State: AC+VfDwkT+maqfNyG04NElfYGJrS5kWCnuC5jm8OBP/72ztDJitFCqKU
        t69scta69Nn252Rl4b+yT/anA9EGcFtl
X-Google-Smtp-Source: ACHHUZ7wKIEQLbYrXocZnASUfMtDn0vBZ80GIpjSaCu532B0ZhkyGJlfAThjscSW670Al1jbCvv3BrlWv1wv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:4421:0:b0:565:9f59:664f with SMTP id
 r33-20020a814421000000b005659f59664fmr2275624ywa.6.1685159025953; Fri, 26 May
 2023 20:43:45 -0700 (PDT)
Date:   Fri, 26 May 2023 20:43:20 -0700
In-Reply-To: <20230527034324.2597593-1-irogers@google.com>
Message-Id: <20230527034324.2597593-3-irogers@google.com>
Mime-Version: 1.0
References: <20230527034324.2597593-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v1 2/4] perf script: Remove some large stack allocations
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some char buffers are stack allocated but in total they come to
24kb. Avoid Wstack-usage warnings by moving the arrays to being
dynamically allocated.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 029d5a597233..3875c4b72db1 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3299,14 +3299,21 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 				  int unset __maybe_unused)
 {
 	struct dirent *script_dirent, *lang_dirent;
-	char scripts_path[MAXPATHLEN];
+	char *buf, *scripts_path, *script_path, *lang_path, *first_half;
 	DIR *scripts_dir, *lang_dir;
-	char script_path[MAXPATHLEN];
-	char lang_path[MAXPATHLEN];
 	struct script_desc *desc;
-	char first_half[BUFSIZ];
 	char *script_root;
 
+	buf = malloc(3 * MAXPATHLEN + BUFSIZ);
+	if (!buf) {
+		pr_err("malloc failed\n");
+		exit(-1);
+	}
+	scripts_path = buf;
+	script_path = buf + MAXPATHLEN;
+	lang_path = buf + 2 * MAXPATHLEN;
+	first_half = buf + 3 * MAXPATHLEN;
+
 	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
 
 	scripts_dir = opendir(scripts_path);
@@ -3315,6 +3322,7 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 			"open(%s) failed.\n"
 			"Check \"PERF_EXEC_PATH\" env to set scripts dir.\n",
 			scripts_path);
+		free(buf);
 		exit(-1);
 	}
 
@@ -3345,6 +3353,7 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 			desc->half_liner ? desc->half_liner : "");
 	}
 
+	free(buf);
 	exit(0);
 }
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

