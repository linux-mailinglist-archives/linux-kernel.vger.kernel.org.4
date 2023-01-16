Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833AC66B525
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 02:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjAPBBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 20:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjAPBBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 20:01:37 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1D93C3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:01:35 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k20-20020aa792d4000000b0058347d2f5e3so11675464pfa.15
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 17:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=oVMWfsW34/mGzPMwBFwgP503Mmst6dTXQwRmf7yhjQV3T611RrXu8SUNd69diz8msL
         k2m6ORMzKffSio7JKlJDYGbJNzNcYNM/zi4Lh+Neq+n+22h8KgrCElrqrFrNrnrW9Fwt
         4Q0aMoJtNkCMGnvh5OijMMjPPrdIaHndXZd6eLelQTfo1IFemkORMu4h77rN+LVcOu6N
         pgHQSYw04OOZlUZjQ0ilOFIuOJMHbrpCoEgdIhWSmdlrkjyOIUDGbWBQLdvu3u2qmQbX
         mHHPhWZK+IL4rEZKsQXiNAi2erx1zf9lypve5krMuoHLn300TU+ofqNc6LiwuoX1klx+
         5Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHhCz4k6MsqFldWGTt35hGeLdTBertltyGAk8DkitQI=;
        b=du387f7VEWdWlQ8KA40D+84g5U6s1VzcQQEovf4rn5tCXmm7bBQ1ZG2P4b9ih/x+0b
         X+J5oUMZcxldHHafPVkUJsuGK8aNCeaVEQR3jYrsfm+ui4J8qz4oojHFFF261Bk3Rzy2
         jst+DB/Eo+llGD/f4G6VZCscSKXggfgzKbRRGqhVB5RH/ItT1oT3LrnVnFadK7XJxr6/
         hQKPFZxyEbx2EWI7W5aytbQVXjBlaAKSKPInHh7eHJH1qCy39w+B6cWbaX2z2EOj2BIp
         m+Y8CUhxcg2R0DKDrsK0I1MDjKq+zEyJf7iwhpODnbhgngN8X/Nfv5G755RVOrBNNJRw
         JhoQ==
X-Gm-Message-State: AFqh2kqmnsgXxbpQ7WQ14EuEU9nILuWAjtCNXpUbx3gCbfXJ4ofXTNH/
        tcfu/7wWCbxSAvTV4+S+oUZIi+owvL/q
X-Google-Smtp-Source: AMrXdXvaEANIV4ydnJVEVN/4TOnTdYZRjSst6vBFoO6VrG5s9o9TicPq79sqg2G3TQ4ogM26FcqU7DZSUxLt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:79e:5e8e:382c:e7ce])
 (user=irogers job=sendgmr) by 2002:a17:90b:264d:b0:226:1564:643c with SMTP id
 pa13-20020a17090b264d00b002261564643cmr5421842pjb.206.1673830895350; Sun, 15
 Jan 2023 17:01:35 -0800 (PST)
Date:   Sun, 15 Jan 2023 17:01:13 -0800
In-Reply-To: <20230116010115.490713-1-irogers@google.com>
Message-Id: <20230116010115.490713-2-irogers@google.com>
Mime-Version: 1.0
References: <20230116010115.490713-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 1/3] tools build: Pass libbpf feature only if libbpf 1.0+
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andres Freund <andres@anarazel.de>,
        Quentin Monnet <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libbpf 1.0 represented a cleanup and stabilization of APIs. Simplify
development by only passing the feature test if libbpf 1.0 is
installed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/build/feature/test-libbpf.c b/tools/build/feature/test-libbpf.c
index a508756cf4cc..cd9989f52119 100644
--- a/tools/build/feature/test-libbpf.c
+++ b/tools/build/feature/test-libbpf.c
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <bpf/libbpf.h>
 
+#if !defined(LIBBPF_MAJOR_VERSION) || (LIBBPF_MAJOR_VERSION < 1)
+#error At least libbpf 1.0 is required for Linux tools.
+#endif
+
 int main(void)
 {
 	return bpf_object__open("test") ? 0 : -1;
-- 
2.39.0.314.g84b9a713c41-goog

