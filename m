Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8352564E1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiLOT24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiLOT2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:28:31 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5085847310;
        Thu, 15 Dec 2022 11:28:29 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id m4so31385pls.4;
        Thu, 15 Dec 2022 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlyNdOzS6lefhSSM/VlTz3GSPTVPpMK1oqgfJv5rmjM=;
        b=ZgWLJedYJWqeU21kwV1U4jSCjyytuO7e/mc+L1bD3knCJBNvT/LsCEKT6X6UdBTzHr
         r2krlBSmYgKXcS0AFPDmeL8MvSFznFYDZ/ok4Mqk+lbvEWY9B6VFOfSxJzyWmKockKtp
         JJGmfdApCm1DAAzmEixI6JdkgSIFJFJELW0PAIwqodbenS2sESq41Oi6C16eoSLRmes5
         +Ibka/Nv7i+L2jgddMoYZILVURo6IylI2QYDbVLXUCZdj/LFw+Xpn14mtUg1C+TnxG0x
         WiEKYPZP88XIbw1UuhG53wklEG/ttt2T7wvXTcY2/Oy8PH90Kh4argzwCNvb25grFv4i
         qPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rlyNdOzS6lefhSSM/VlTz3GSPTVPpMK1oqgfJv5rmjM=;
        b=NnGW9fpBhG//zG61/eYqlXCRp8dSdQqxz94NKiuwz8Sh4F6eMWOSEfnDsAcIX/EBlr
         SzvG1Dh78RebHRKBNwUQgFfFeP+ltKCeNKpnmB/U7gdYRoNozO6ju0+ZbTa2CDnB4vB5
         7oo2yRY7Gl3udR/8qTilW2DFSW5rrGuDsNWqjY2xVveARgHKrTEEVevS9WvP1+h8+TH7
         lfASYj4JP3AvrbmS6IEWQ7gnqa67R0CIRrBReOjropmBscDeaAOFwchCldpPsX/ICGpy
         X3emMx4PMM+q+xJnmRypd1UrEUWA31M3uTnpiNU8RxeLR2N2Yvj0OURa3HdbGAyPatec
         rY3g==
X-Gm-Message-State: ANoB5pn2uly5KD0zRHAErSTnN2fiDu22xjWugHdF06l/L1u7qYPXihEO
        idMmtjR4yEvXLfVMM8fUuto=
X-Google-Smtp-Source: AA0mqf4mJLL40VGDcnosZch6InOpLE0yZmjOD9tt56/lEPgL4rxXCVkK2uJ1B9JBg7ErCtkXg3GEgQ==
X-Received: by 2002:a17:90b:2315:b0:219:8b27:e065 with SMTP id mt21-20020a17090b231500b002198b27e065mr36884986pjb.17.1671132508708;
        Thu, 15 Dec 2022 11:28:28 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:ecc1:3e44:be34:129c])
        by smtp.gmail.com with ESMTPSA id ep14-20020a17090ae64e00b00219cf5c3829sm3475129pjb.57.2022.12.15.11.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:28:28 -0800 (PST)
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
Subject: [PATCH 7/9] perf hist: Improve srcline sort key performance
Date:   Thu, 15 Dec 2022 11:28:15 -0800
Message-Id: <20221215192817.2734573-8-namhyung@kernel.org>
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

The sort_entry->cmp() will be called for eventy sample data to find a
matching entry.  When it has 'srcline' sort key, that means it needs to
call addr2line or libbfd everytime.

This is not optimal because many samples will have same address and it
just can call addr2line once.  So postpone the actual srcline check to
the sort_entry->collpase() and compare addresses in ->cmp().

Also it needs to add ->init() callback to make sure it has srcline info.
If a sample has a unique data, chances are the entry can be sorted out
by other (previous) keys and callbacks in sort_srcline never called.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index f6333b3dca35..913045c5b2b2 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -373,6 +373,18 @@ char *hist_entry__srcline(struct hist_entry *he)
 
 static int64_t
 sort__srcline_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	int64_t ret;
+
+	ret = _sort__addr_cmp(left->ip, right->ip);
+	if (ret)
+		return ret;
+
+	return sort__dso_cmp(left, right);
+}
+
+static int64_t
+sort__srcline_collapse(struct hist_entry *left, struct hist_entry *right)
 {
 	if (!left->srcline)
 		left->srcline = hist_entry__srcline(left);
@@ -382,18 +394,31 @@ sort__srcline_cmp(struct hist_entry *left, struct hist_entry *right)
 	return strcmp(right->srcline, left->srcline);
 }
 
-static int hist_entry__srcline_snprintf(struct hist_entry *he, char *bf,
-					size_t size, unsigned int width)
+static int64_t
+sort__srcline_sort(struct hist_entry *left, struct hist_entry *right)
+{
+	return sort__srcline_collapse(left, right);
+}
+
+static void
+sort__srcline_init(struct hist_entry *he)
 {
 	if (!he->srcline)
 		he->srcline = hist_entry__srcline(he);
+}
 
+static int hist_entry__srcline_snprintf(struct hist_entry *he, char *bf,
+					size_t size, unsigned int width)
+{
 	return repsep_snprintf(bf, size, "%-.*s", width, he->srcline);
 }
 
 struct sort_entry sort_srcline = {
 	.se_header	= "Source:Line",
 	.se_cmp		= sort__srcline_cmp,
+	.se_collapse	= sort__srcline_collapse,
+	.se_sort	= sort__srcline_sort,
+	.se_init	= sort__srcline_init,
 	.se_snprintf	= hist_entry__srcline_snprintf,
 	.se_width_idx	= HISTC_SRCLINE,
 };
-- 
2.39.0.314.g84b9a713c41-goog

