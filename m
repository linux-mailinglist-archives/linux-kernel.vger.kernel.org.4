Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF95964E1C9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiLOT3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiLOT2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F104B9A1;
        Thu, 15 Dec 2022 11:28:30 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so36842plj.3;
        Thu, 15 Dec 2022 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRJhsYD6Q8d3CjTB733ncypYkegZvAGinKhexPwhiRs=;
        b=Om7CYEY7dnjsSshVnzhztwQx5Wx7srg6j2+WpPqCN1ZKgkMHQ+mEVG7lE5zle0hmAX
         nCzlvchTjD5/hNptvIT4pQ+UZUN/CW/FWrWpVLWhA+ayzc3eCrGt0YO2W9ffWBNab+Mu
         p6SHupNBRrQ1Kb1viujAuVgjFmzgudeA0wG2ewKq89ti4t0UtJi/vhL33gBKdYCZxA0K
         D2C1udzxGBPCVyQgPIY7hHVHq398+47QYU7Ux79H+R6IPwAh4DXUAOK7UB1636U63hMY
         5Q9BUOr+PW6XZ5SGfzRfsNyMI18hWUkGihMjfqh11Avuq22i1j0gRIZn2lGTm1ONeO5I
         aCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lRJhsYD6Q8d3CjTB733ncypYkegZvAGinKhexPwhiRs=;
        b=U5rVzb+10U/ins+bLuoNWSQBpi7cqoiy/H7H7JkBmbcfPL4B7wC7eYdUoiNUeceo/f
         KRJOQZpULeSYzQq8sDy8JVt2dXOOn+IJ9xVCxFQfwn33jpFAQ+ZibDkJX+LlVNlXQo/w
         bPVe7hVDlTvVj+yfC9jNDKQT6MfxYI/s4V6vT2fXgcDyE+f2IQSNTIq441ke9D4E1JRH
         T+kHnlrWU6GaK6wzG1sr6p7eOiZO2sv4JFSQyexbue5AEGwsOvRDtj+LtSoV6N672kg/
         bOrwNuquYYqx3fAbcQlJnptMsQouv3bJ0A+Pj/9/sg8W48lYttdK3tzGeBUR5jnfDxWy
         yqMg==
X-Gm-Message-State: ANoB5pmJPH5mKjYxhhkV/74h3txBd2xkeuYzXwp8g3RJ75vct4IRrvDS
        wTCQ3O0jC9l/cpVBaos0xXs=
X-Google-Smtp-Source: AA0mqf5Lm+1UkoW8s8mQkmLI6b68vjTrnFHEfYIFV0K6KAEpTWuAocOSKYWdpne0rjHZ1QELAXX6+w==
X-Received: by 2002:a05:6a20:9589:b0:9d:efbf:785d with SMTP id iu9-20020a056a20958900b0009defbf785dmr10620141pzb.18.1671132509823;
        Thu, 15 Dec 2022 11:28:29 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:29 -0800 (PST)
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
Subject: [PATCH 8/9] perf hist: Improve srcfile sort key performance
Date:   Thu, 15 Dec 2022 11:28:16 -0800
Message-Id: <20221215192817.2734573-9-namhyung@kernel.org>
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
 tools/perf/util/sort.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 913045c5b2b2..c290539dcf43 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -569,18 +569,41 @@ sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
 	return strcmp(right->srcfile, left->srcfile);
 }
 
-static int hist_entry__srcfile_snprintf(struct hist_entry *he, char *bf,
-					size_t size, unsigned int width)
+static int64_t
+sort__srcfile_collapse(struct hist_entry *left, struct hist_entry *right)
+{
+	if (!left->srcfile)
+		left->srcfile = hist_entry__get_srcfile(left);
+	if (!right->srcfile)
+		right->srcfile = hist_entry__get_srcfile(right);
+
+	return strcmp(right->srcfile, left->srcfile);
+}
+
+static int64_t
+sort__srcfile_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__srcfile_collapse(left, right);
+}
+
+static void sort__srcfile_init(struct hist_entry *he)
 {
 	if (!he->srcfile)
 		he->srcfile = hist_entry__get_srcfile(he);
+}
 
+static int hist_entry__srcfile_snprintf(struct hist_entry *he, char *bf,
+					size_t size, unsigned int width)
+{
 	return repsep_snprintf(bf, size, "%-.*s", width, he->srcfile);
 }
 
 struct sort_entry sort_srcfile = {
 	.se_header	= "Source File",
 	.se_cmp		= sort__srcfile_cmp,
+	.se_collapse	= sort__srcfile_collapse,
+	.se_sort	= sort__srcfile_sort,
+	.se_init	= sort__srcfile_init,
 	.se_snprintf	= hist_entry__srcfile_snprintf,
 	.se_width_idx	= HISTC_SRCFILE,
 };
-- 
2.39.0.314.g84b9a713c41-goog

