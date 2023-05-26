Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4921712C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbjEZSfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243249AbjEZSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:35:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9570D10FF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb78a3daaso1411122276.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685126084; x=1687718084;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bJF+qzVTbz8URltVyp28Lcb70/4s1v/RxMVJtiGJPTs=;
        b=Oo93B8xhgldm2cYdd68btGpV2pdvkwlHBWlxS5icl4+MgjgBAVpiUfPCGdKNVjaXOy
         nbHfYV37Ct84mF/lYACTfPM8+Y+S5tlr/K7ZfXUgfvjx+acs9EiplHZGGC281lJ16CL2
         Rrwl7xcyB6QP+Pl7+72nAynawHHp4GqgTuZsZjj5k8BVPsqY5p+D2Y27WSTxTmq7DNmX
         X13xkE85m9vha/HAfVfZxxuL3WCs0S75DgczoEJqeiKBYRbGG1UhmMBepHt60U4692/U
         PSJZnP9nHn6WRIV9SPU7i1Sj9dXyhbsBB7wrhYKTQtO9RjYfyA1wEky8z6Bwq1tBIZry
         WjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685126084; x=1687718084;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bJF+qzVTbz8URltVyp28Lcb70/4s1v/RxMVJtiGJPTs=;
        b=hq4w7L1mtIwnDhqn7AudDDj6EiI6+a9VfYS3G5CvLvGHWMNpa88pqM5WhegegZTgaO
         ibBsHCwcpvfxM2avXQuvqaIXgyoQHhWGWzsx6gZSUB1gk8oS+oLPjD7sIDS4nYBt1z9+
         0S4R3ViUGh0z6w5sDOWIolaGBZ7BL904HZH+2GGPOUpmkyHSejGb1CRdPibyqsZudGU5
         9B6AbvyzFolfLpcbWCmRHzZCm/bRdS2UPZsSYQi9B7uZwfWyt5EbhgJdvLYqdhPNri52
         I4Z7TqUxvDYxarJonexXsgcLlqBPoomwgq2ntryUUlHdH8LDNYc0caXN6JyCYJtiQsAX
         PjJg==
X-Gm-Message-State: AC+VfDzxwYTBeeeBW8b2ZrTA4o5FBT3Zq6KRDlJ8VzfQhf1czEK/haqu
        Xr+o0tU3LIAYiGnT96+2bmrKjHTjdiE8
X-Google-Smtp-Source: ACHHUZ7nUrl4nIdvoUhRMjP56HiICrfn58XtXvw8FJD4ZtvRrtJXUh6CGXhYHum1JvN6Q2M/EhdiEl8lmy73
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a5b:644:0:b0:ba8:4c16:78b7 with SMTP id
 o4-20020a5b0644000000b00ba84c1678b7mr1394238ybq.12.1685126084648; Fri, 26 May
 2023 11:34:44 -0700 (PDT)
Date:   Fri, 26 May 2023 11:34:00 -0700
In-Reply-To: <20230526183401.2326121-1-irogers@google.com>
Message-Id: <20230526183401.2326121-16-irogers@google.com>
Mime-Version: 1.0
References: <20230526183401.2326121-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v2 15/16] perf test pmu: Avoid 2 static path arrays
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid two static paths that contributed 8,192 bytes to .bss are only
used duing the perf parse pmu test. This change helps FORTIFY
triggering 2 warnings like:

```
tests/pmu.c: In function =E2=80=98test__pmu=E2=80=99:
tests/pmu.c:121:43: error: =E2=80=98%s=E2=80=99 directive output may be tru=
ncated writing up to 4095 bytes into a region of size 4090 [-Werror=3Dforma=
t-truncation=3D]
  121 |         snprintf(buf, sizeof(buf), "rm -f %s/*\n", dir);
```

So make buf a little larger.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/pmu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
index 3cf25f883df7..a4452639a3d4 100644
--- a/tools/perf/tests/pmu.c
+++ b/tools/perf/tests/pmu.c
@@ -86,17 +86,16 @@ static struct parse_events_term test_terms[] =3D {
  * Prepare format directory data, exported by kernel
  * at /sys/bus/event_source/devices/<dev>/format.
  */
-static char *test_format_dir_get(void)
+static char *test_format_dir_get(char *dir, size_t sz)
 {
-	static char dir[PATH_MAX];
 	unsigned int i;
=20
-	snprintf(dir, PATH_MAX, "/tmp/perf-pmu-test-format-XXXXXX");
+	snprintf(dir, sz, "/tmp/perf-pmu-test-format-XXXXXX");
 	if (!mkdtemp(dir))
 		return NULL;
=20
 	for (i =3D 0; i < ARRAY_SIZE(test_formats); i++) {
-		static char name[PATH_MAX];
+		char name[PATH_MAX];
 		struct test_format *format =3D &test_formats[i];
 		FILE *file;
=20
@@ -118,12 +117,13 @@ static char *test_format_dir_get(void)
 /* Cleanup format directory. */
 static int test_format_dir_put(char *dir)
 {
-	char buf[PATH_MAX];
-	snprintf(buf, PATH_MAX, "rm -f %s/*\n", dir);
+	char buf[PATH_MAX + 20];
+
+	snprintf(buf, sizeof(buf), "rm -f %s/*\n", dir);
 	if (system(buf))
 		return -1;
=20
-	snprintf(buf, PATH_MAX, "rmdir %s\n", dir);
+	snprintf(buf, sizeof(buf), "rmdir %s\n", dir);
 	return system(buf);
 }
=20
@@ -140,7 +140,8 @@ static struct list_head *test_terms_list(void)
=20
 static int test__pmu(struct test_suite *test __maybe_unused, int subtest _=
_maybe_unused)
 {
-	char *format =3D test_format_dir_get();
+	char dir[PATH_MAX];
+	char *format =3D test_format_dir_get(dir, sizeof(dir));
 	LIST_HEAD(formats);
 	struct list_head *terms =3D test_terms_list();
 	int ret;
--=20
2.41.0.rc0.172.g3f132b7071-goog

