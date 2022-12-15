Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F350E64E1C6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiLOT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiLOT21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:27 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFFB4AF13;
        Thu, 15 Dec 2022 11:28:26 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so36692plj.3;
        Thu, 15 Dec 2022 11:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mw/wiOLYoXrXq7I0XRVNFT/hMNwNwhuLxRKV5JN7S8=;
        b=e7QSbOZJCoCBHRDDhIIsWJbh9O3T0nRnBRdCY1f9w67KpjfbuGUtOpHOLjxP6hqaac
         dVHRLk15l31Q5yvmpjwvPE2wVJFQNpR5r1Pau2VMRwL2agIQ30eoijGfz2FrLucFUleU
         6FyV+1QEv4XEegfd3afqrxFOPSFDQYGeJv+e61aVn87uheIWTfEl81h/4XXdK1GMYXeu
         LUxQvqfbzeN4IZMP8NVP6krYJUetkbq8unNfHi1l2R1y8xAqEC/0I9bzoz0aLEpF2Ege
         Skut7ltKgXlKfn1Yv/gzUyPL1S5TE/OmISbOLHxi7PHX4unRVqDWW5RbY0EkGr7Riife
         +Jbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mw/wiOLYoXrXq7I0XRVNFT/hMNwNwhuLxRKV5JN7S8=;
        b=PP1OgpByVecRCN3HWWYZZGKGcyYrUq67Wg72beA59fz1dh1Q6wTOpItV+f7TEx/OJp
         E0e97tjOTqr9xLib0I78RpRnDpW8Vy91TfqXwA6xFn5eyrKfgX5/ppYLobjAIARu6VbV
         W34cLl9ifGHIuikvH3g5U+XFEW78/AL4a2JBCuv0Dfizcd2OO9JxjMCUGjIdmFi7pWZs
         so1iU+6MSHNg7XI6iGYn183k2BdWfZ9DRNNYXAx49asfoULdVqVVa7YOVhyaP/oizLeR
         gnpM9aTmqwRX0knQMEWIj+CKpvxs3L9lHjb6IAP34A5D5sSvYad4sT0RNEM2wZ2fqW7f
         WwOg==
X-Gm-Message-State: AFqh2krlCAz1kFvKll57HT+UPklzVUSA8D4Uj0X3FaRpdkJ+W0yVfbva
        oPdOXt4DuDlhvmXcqFtmpbWjHFlLFpc=
X-Google-Smtp-Source: AMrXdXvjescNV2ytA1ifFB/iIsLxSPB5ix9YJ5UuHq5FTUz0WZnwrHLnztWZLr7cuaKPpMmHmfRA+A==
X-Received: by 2002:a17:90a:d993:b0:223:415d:5441 with SMTP id d19-20020a17090ad99300b00223415d5441mr5235510pjv.21.1671132506485;
        Thu, 15 Dec 2022 11:28:26 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:26 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 5/9] perf srcline: Conditionally suppress addr2line warnings
Date:   Thu, 15 Dec 2022 11:28:13 -0800
Message-Id: <20221215192817.2734573-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221215192817.2734573-1-namhyung@kernel.org>
References: <20221215192817.2734573-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has symbol_conf.disable_add2line_warn to suppress some warnings.  Let's
make it consistent with others.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/srcline.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 2c212e2e1b65..33321867416b 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -573,13 +573,15 @@ static int addr2line(const char *dso_name, u64 addr,
 	 * "??"/"??:0" lines.
 	 */
 	if (fprintf(a2l->to_child, "%016"PRIx64"\n,\n", addr) < 0 || fflush(a2l->to_child) != 0) {
-		pr_warning("%s %s: could not send request\n", __func__, dso_name);
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s %s: could not send request\n", __func__, dso_name);
 		goto out;
 	}
 
 	switch (read_addr2line_record(a2l, &record_function, &record_filename, &record_line_nr)) {
 	case -1:
-		pr_warning("%s %s: could not read first record\n", __func__, dso_name);
+		if (!symbol_conf.disable_add2line_warn)
+			pr_warning("%s %s: could not read first record\n", __func__, dso_name);
 		goto out;
 	case 0:
 		/*
@@ -588,14 +590,17 @@ static int addr2line(const char *dso_name, u64 addr,
 		 */
 		switch (read_addr2line_record(a2l, NULL, NULL, NULL)) {
 		case -1:
-			pr_warning("%s %s: could not read delimiter record\n", __func__, dso_name);
+			if (!symbol_conf.disable_add2line_warn)
+				pr_warning("%s %s: could not read delimiter record\n",
+					   __func__, dso_name);
 			break;
 		case 0:
 			/* As expected. */
 			break;
 		default:
-			pr_warning("%s %s: unexpected record instead of sentinel",
-				   __func__, dso_name);
+			if (!symbol_conf.disable_add2line_warn)
+				pr_warning("%s %s: unexpected record instead of sentinel",
+					   __func__, dso_name);
 			break;
 		}
 		goto out;
-- 
2.39.0.314.g84b9a713c41-goog

