Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266AA6C5CCD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjCWCuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCWCuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:50:09 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF9C1F5F7;
        Wed, 22 Mar 2023 19:50:08 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso598222pjb.2;
        Wed, 22 Mar 2023 19:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679539808; x=1682131808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=a4keVKlJNdo1j4qFYE//r1eDE0ShQaX85E5D5pockwg=;
        b=WlxaKMdUWP6NF61Enqgn/cZbbwYafq7NXQi9eUxKsSptIGlgpjqSHnPEFHCeawJuk9
         X5gAh/gM5rAO0kYp2M09Zezh7woZMiofK14yeFb84H1r0Xt2XmgGYhegj3yOOyh4nUFk
         3AwLAdYWC70mD5rSB9KykDG9n2d/jVyW+az2+jNJCOq2PcxakBGU7ELXtFfHURtHCbP+
         LFWAdIZJJjrDhXBRPmD4z4+eyb6JSGzMD2p/lp7au5mK7vpdtQxeZfVmRAQhLsMzeINe
         LrH9+sQvV325fqlDdaOmIs4N16W89Sp51neKpM/rAsJLGRyqWNsiCe9SesWq+CYHnaKw
         YoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679539808; x=1682131808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4keVKlJNdo1j4qFYE//r1eDE0ShQaX85E5D5pockwg=;
        b=RbEYUxx1ONA3RHHY2MD9lNQ5xW6MBN2kpXlGKX0D4kJsdfmvbm1C7ImpM1le4Og6d7
         r9AwrSYtcOhqOVzkEdqzMWjFv98kFWOm1Z/01xNDkcZmqXjPV9y8e9sJSSviCmESneTe
         OrjSZq8wXJ4q0u7lQMQmvhSZuxDX4aXgLb3fonSIyV1TZ3mVrbKqz7zcEKbTfyit/ZXa
         SqBQkTdf4uWYkPv9Bbz9uM0FtjHtvu35loxbNqy5X1iRR0uLu3fLGKj6whU0NDJe4Rdt
         Xqxkkr/Q9M0cXb9ElkEcGckAqKV086aoUVxu2vE4v4KYkS4xFiwDT4FMF2DYJ+eDM7br
         9Okg==
X-Gm-Message-State: AO0yUKXPlj423v2dFS+sqMf7YIA+9X1UEsMNQz3gA7UxRDaurE8kYNuf
        hEX9BYRJ0w9AN4cgmG+5xsI=
X-Google-Smtp-Source: AK7set/ezdzcrTsE9YggmSOhJq3msvgSPLQjU+Vex3eUzm6YN+Mlj0bCQCBskj4eL0u/kirscVBfQQ==
X-Received: by 2002:a17:902:da8b:b0:1a1:a273:1812 with SMTP id j11-20020a170902da8b00b001a1a2731812mr5420072plx.45.1679539807527;
        Wed, 22 Mar 2023 19:50:07 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:44b0:9957:6acc:41b5:fbeb])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b00199023c688esm11274738plb.26.2023.03.22.19.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 19:50:07 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf hist: Improve srcfile sort key performance (really)
Date:   Wed, 22 Mar 2023 19:50:05 -0700
Message-Id: <20230323025005.191239-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
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

The earlier commit f0cdde28fecc ("perf hist: Improve srcfile sort key
performance") updated the srcfile logic but missed to change the ->cmp()
callback which is called for every sample.  It should use the same logic
like in the srcline to speed up the processing because it'd return the
same information repeatedly for the same address.  The real processing
will be done in sort__srcfile_collapse().

Fixes: pf0cdde28fecc ("perf hist: Improve srcfile sort key performance")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/sort.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index e11e68ecf0a2..2b5cc8e4aa6e 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -657,12 +657,7 @@ static char *hist_entry__get_srcfile(struct hist_entry *e)
 static int64_t
 sort__srcfile_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	if (!left->srcfile)
-		left->srcfile = hist_entry__get_srcfile(left);
-	if (!right->srcfile)
-		right->srcfile = hist_entry__get_srcfile(right);
-
-	return strcmp(right->srcfile, left->srcfile);
+	return sort__srcline_cmp(left, right);
 }
 
 static int64_t
-- 
2.40.0.rc1.284.g88254d51c5-goog

