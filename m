Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8792C6D2978
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjCaUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjCaUaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:30:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A25922916;
        Fri, 31 Mar 2023 13:30:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id u10so22378180plz.7;
        Fri, 31 Mar 2023 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680294600; x=1682886600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kqxyb/rKt2Y/ABAu4ly+tta42zomTNbs/md/9tPbhmg=;
        b=ZmKzGxXQhI5XpYfBW7NUYEcSzjPjkr6umwjV2WNVK9ly3t1fbi9ObRFjfCt9HHmXF0
         Nr2dtH6jJBaE0Ale5lX7nhM79p17IMTkJMYM5z7Z59A7otgECj409oDF/+c4/20XRg6d
         IwbhoHm3UzLgH2V85QTxkztR/o6tfP92l/wU2FQpmF0UNRWY0dZ1nZEuy58AxhGHXCxW
         3F/xzj0B1iWz6xuUMwLc98NSJHA08BT+29DZwsiPWuXFvcCxtXCmSgiN8rgvpd4vPzKs
         Wx+IKA0ytjEk0SbeFuEON4DSAhsb68N1azPNLJZll/tDFy+q2d8iG2n4EDnD53+2VSQe
         Rc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294600; x=1682886600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kqxyb/rKt2Y/ABAu4ly+tta42zomTNbs/md/9tPbhmg=;
        b=WRHkeAmJJHFVjjtmh4ZkanrX5wzJ4G0gzf/ciXsDOuVzxrb4CFXb+hFhdQnutFp+z0
         5eW+falKOr/9ERJFWUXbIMHmCyQuBavpoKjLiG9I1UuOZzg8wJkN/FjzUEPahTF0+X95
         0p/uNvp2iqY3BeEBt84IwqqCjBt1oNGK68GaWVF06boqJbKdcababEjOQDuky7c79xrY
         6i78kwW1EaC7fvaIyFDG0aGD+QnUGT7E0pLjx9bRkuzFKl+JoducyPQEPZOSwTX/jG4Q
         hkUEFSfNOjCZk//H+bVxavbT+lODe4yy0u0eDYTXFUVm9nHcmaYr2RYDpWe8cJigpL9E
         ARwQ==
X-Gm-Message-State: AAQBX9f0/CdjhVeL2+Fc0yKq5/bXzOfy7z+Wzq2RvJQuyk21+ZOregOC
        C06udTf7Ahl8Y93fYBb2phU=
X-Google-Smtp-Source: AKy350ZAH8/+0ayD1LxdtmAHRou3pXLYNUfSkYyXNF0mtssUpc18QRNo5qF9e4msjulVr4MD1y5CVw==
X-Received: by 2002:a17:902:f315:b0:19e:9849:1767 with SMTP id c21-20020a170902f31500b0019e98491767mr22990632ple.42.1680294600644;
        Fri, 31 Mar 2023 13:30:00 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:5cfb:ad2c:e6f5:d42f])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709028c8e00b001a1dc2be791sm1916803plo.259.2023.03.31.13.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 13:30:00 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 6/9] perf pmu: Use relative path in perf_pmu__caps_parse()
Date:   Fri, 31 Mar 2023 13:29:46 -0700
Message-Id: <20230331202949.810326-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230331202949.810326-1-namhyung@kernel.org>
References: <20230331202949.810326-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Likewise, it needs to traverse the pmu/caps directory, let's use
openat() with the dirfd instead of open() using the absolute path.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/pmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9fc6b8b5732b..0c1d87f10b23 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1804,6 +1804,7 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	char caps_path[PATH_MAX];
 	DIR *caps_dir;
 	struct dirent *evt_ent;
+	int caps_fd;
 
 	if (pmu->caps_initialized)
 		return pmu->nr_caps;
@@ -1822,18 +1823,19 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	if (!caps_dir)
 		return -EINVAL;
 
+	caps_fd = dirfd(caps_dir);
+
 	while ((evt_ent = readdir(caps_dir)) != NULL) {
-		char path[PATH_MAX + NAME_MAX + 1];
 		char *name = evt_ent->d_name;
 		char value[128];
 		FILE *file;
+		int fd;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
 
-		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
-
-		file = fopen(path, "r");
+		fd = openat(caps_fd, name, O_RDONLY);
+		file = fdopen(fd, "r");
 		if (!file)
 			continue;
 
-- 
2.40.0.348.gf938b09366-goog

