Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510BC64E1CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiLOT3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiLOT2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446550D50;
        Thu, 15 Dec 2022 11:28:31 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id x2so6599227plb.13;
        Thu, 15 Dec 2022 11:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJJL5CU7ptHXr+iHLPpq+YgdyRtPuip5im73Jo4lYDM=;
        b=R2FycQjgluMgwJfWkdtp6gE6fj/eN6kjSEw5X/LK9opDYuWTGtP0YQ3rQKEu89EyHs
         BqrSj7SZ8qJhdlgx5bPS0DVtBA9iMVJPIotietniCz6iDuatLriqtkqUWiOT0JWa2tq6
         Ixq0zD90mL6WORlCLzq0DF9V5FzWZTjGu05zubAEAJ3A6pFXcFiNJ8wH6H4bD8wChEHc
         k8wIVz6qFxyDn+MABc6A2UEFSm6O4TSFDujsypFP+xfu/k5ea2vYIsDgswOUrOUJ71Id
         N8jI9D4g5J11rnc+vrr3WOcLZ/KDJ0o7HJ8uVpkHgNAmBWv5H3rlKiOwkr6nb3XrQlD5
         mUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PJJL5CU7ptHXr+iHLPpq+YgdyRtPuip5im73Jo4lYDM=;
        b=zz/7QdIRsCbUcLwKw8toVonCmQClZm/Wg67+X4XCuXOC6Gdmj4ObcOr3Tlkc72peMd
         UTlc0hhfgAml/Jcyd+aJeK+H0yx+xk39HvuhZ47u8sM7owXw9Uxxb6BaPisMIPfAejEi
         qx7kvOJXj1DrZCXQd2cjQRLCBBEdD2hw1RIKIWEwYDOlCYbjsn7kQX18fPSWsQja5yH7
         sw+ejTU84oCLo7ZXOi0XHDylLgLFH0jvKhQ2z2/VhdhichQpCNnqi7CPkwH7azBVu3Ku
         zX8qlCQHm6A5PGfpOBin2kIUkNGl6dDnqrNtyRAOM6rg5fpjHd2wUolIsZj3ZaYLrmwE
         HoRA==
X-Gm-Message-State: ANoB5pksDIpvHzvvnQzxT+NSa1rmgqn6JNt4AhzTbmLYyOpjspvd4u/I
        XTvbfgDgq0IVaHpemXVREDo=
X-Google-Smtp-Source: AA0mqf7CFFUjtazWNMYYE0NTy5PeACLrWtOYDrA8hhyzfJTL1ACo2vMlrBB8yp+k5/6RdzRv5yM0FA==
X-Received: by 2002:a17:90a:e608:b0:219:705e:67b2 with SMTP id j8-20020a17090ae60800b00219705e67b2mr30567281pjy.10.1671132510943;
        Thu, 15 Dec 2022 11:28:30 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:30 -0800 (PST)
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
Subject: [PATCH 9/9] perf hist: Improve srcline_{from,to} sort key performance
Date:   Thu, 15 Dec 2022 11:28:17 -0800
Message-Id: <20221215192817.2734573-10-namhyung@kernel.org>
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

Likewise, modify ->cmp() callback to compare sample address and map
address.  And add ->collapse() and ->sort() to check the actual
srcfile string.  Also add ->init() to make sure it has the srcfile.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index c290539dcf43..e188f74698dd 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -432,6 +432,12 @@ static char *addr_map_symbol__srcline(struct addr_map_symbol *ams)
 
 static int64_t
 sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return left->branch_info->from.addr - right->branch_info->from.addr;
+}
+
+static int64_t
+sort__srcline_from_collapse(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info->srcline_from)
 		left->branch_info->srcline_from = addr_map_symbol__srcline(&left->branch_info->from);
@@ -442,6 +448,18 @@ sort__srcline_from_cmp(struct hist_entry *left, struct hist_entry *right)
 	return strcmp(right->branch_info->srcline_from, left->branch_info->srcline_from);
 }
 
+static int64_t
+sort__srcline_from_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__srcline_from_collapse(left, right);
+}
+
+static void sort__srcline_from_init(struct hist_entry *he)
+{
+	if (!he->branch_info->srcline_from)
+		he->branch_info->srcline_from = addr_map_symbol__srcline(&he->branch_info->from);
+}
+
 static int hist_entry__srcline_from_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
@@ -451,6 +469,9 @@ static int hist_entry__srcline_from_snprintf(struct hist_entry *he, char *bf,
 struct sort_entry sort_srcline_from = {
 	.se_header	= "From Source:Line",
 	.se_cmp		= sort__srcline_from_cmp,
+	.se_collapse	= sort__srcline_from_collapse,
+	.se_sort	= sort__srcline_from_sort,
+	.se_init	= sort__srcline_from_init,
 	.se_snprintf	= hist_entry__srcline_from_snprintf,
 	.se_width_idx	= HISTC_SRCLINE_FROM,
 };
@@ -459,6 +480,12 @@ struct sort_entry sort_srcline_from = {
 
 static int64_t
 sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return left->branch_info->to.addr - right->branch_info->to.addr;
+}
+
+static int64_t
+sort__srcline_to_collapse(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->branch_info->srcline_to)
 		left->branch_info->srcline_to = addr_map_symbol__srcline(&left->branch_info->to);
@@ -469,6 +496,18 @@ sort__srcline_to_cmp(struct hist_entry *left, struct hist_entry *right)
 	return strcmp(right->branch_info->srcline_to, left->branch_info->srcline_to);
 }
 
+static int64_t
+sort__srcline_to_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__srcline_to_collapse(left, right);
+}
+
+static void sort__srcline_to_init(struct hist_entry *he)
+{
+	if (!he->branch_info->srcline_to)
+		he->branch_info->srcline_to = addr_map_symbol__srcline(&he->branch_info->to);
+}
+
 static int hist_entry__srcline_to_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
@@ -478,6 +517,9 @@ static int hist_entry__srcline_to_snprintf(struct hist_entry *he, char *bf,
 struct sort_entry sort_srcline_to = {
 	.se_header	= "To Source:Line",
 	.se_cmp		= sort__srcline_to_cmp,
+	.se_collapse	= sort__srcline_to_collapse,
+	.se_sort	= sort__srcline_to_sort,
+	.se_init	= sort__srcline_to_init,
 	.se_snprintf	= hist_entry__srcline_to_snprintf,
 	.se_width_idx	= HISTC_SRCLINE_TO,
 };
-- 
2.39.0.314.g84b9a713c41-goog

