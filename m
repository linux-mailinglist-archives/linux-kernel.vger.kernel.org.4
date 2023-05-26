Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4CA712C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbjEZSfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242835AbjEZSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:35:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72BE54
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb51cb4d4so2274054276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126082; x=1687718082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZlCp8PAHlNCmunobQkdPrQHDqUHTnoSBSsPrysF0mwY=;
        b=Plkd/xuqK7M9SwlLAM21/d2FaIm8z5gDewz3SZdNEOECc+gV7lFjw6+UKO10fmBMZB
         pIXWE5awCZwwtkj1BDl0EmV/jGe2DVd34bup9DBTV9CgoWd5eeg+AbMzKlerhNR7X/Gw
         705gC8RpQCNguftIohd3ITPASIdqZ3kZbzcMgE28J3d3Ucwo/ZMCZke1RsbUoVXb0caA
         1vdqJ9f5BW4pqGgv/GFN30r/jEQnHeCvvO6RpFr+ppnBAyIBQIqTPKDgaeFxhAKwZVKu
         ny4EnnAWZ0rbuqFG19Kx2w6R+3Eqg4AEaVFkyrlT/mdtSGwWjLf8PD5ulwuJj1DfqdQb
         6/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126082; x=1687718082;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlCp8PAHlNCmunobQkdPrQHDqUHTnoSBSsPrysF0mwY=;
        b=AIKPlW6JfGDxDK2wbKn9q/Ur29jWnzATzPwmjrpcLLnCG2dT/u1B9BYFTGRjqqEp6C
         0f+Tt34muM43FCy4rYbsDLz8vrScDA9NarFCbgX6jjnrcFXfSo1EALK1eI14lFr4sPf9
         qK1Ir9HYWyfZsc3k1fxdZBhZ1SxwLbIpXKu45CwB5wP1srkspNLGfkOK/Ra6fB61APiQ
         9o5/ijLGKZWx6zSKwNFe2qT+sbiSPpXa3NoQoL7ClLeFUxWv/IbsemhXyDJphbiz+ktR
         UW0XGolC4tWu7bw9ohbfJ7kM8iKS5imxe/xbm7PBe4tOt1xVc6Ao90ISGdgbgySM8gj3
         NzgQ==
X-Gm-Message-State: AC+VfDwTXASduv2qVQXAiW1jAnBGuSAIihNQEO0W+gLXxD/Z+WSRzTgs
        axUs9fi9378AJRXZVy7gifWKDG20uTgc
X-Google-Smtp-Source: ACHHUZ6QAA72EtRyWFuSRwlWtGxsChIoyKoEFA62TrkZKniW/edvWdeG+Lum4DcHWumM9PH4R0IeDIbeBU87
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a25:fc1c:0:b0:bac:7086:c9b2 with SMTP id
 v28-20020a25fc1c000000b00bac7086c9b2mr992311ybd.12.1685126082416; Fri, 26 May
 2023 11:34:42 -0700 (PDT)
Date:   Fri, 26 May 2023 11:33:59 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-15-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 14/16] tools api fs: Dynamically allocate cgroupfs mount
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
        autolearn=ham autolearn_force=no version=3.4.6
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
2.41.0.rc0.172.g3f132b7071-goog

