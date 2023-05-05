Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD246F8A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 22:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjEEUlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 16:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjEEUle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 16:41:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31D44C13
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 13:41:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a753ce33cso4273672276.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 13:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683319290; x=1685911290;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pmO/mUZslF6zk/m++XhRSloP3Is2SLrKGWDO4GiCCWg=;
        b=4IY0ACt+yzgmWBtCKxDUiZU9IShC6nZeJamyvXM5WHgmY8IcZ+w83GwaSxd6m4CC+H
         C4y+7FzWM+9v1Y7P66pyQxMtRuGs1+mupVht9iE0NUeoV+CI02LkSvVcd7U9U14qQf+x
         99ZL18CT/SmyvZFeWGegQv1DVSWinuAxXL7CqUH+erLHgxaLpqZcZRvaI09PCHzeQa6w
         2maSxVirGJzJGQI8r7+DBeJkB55OePvqGH88Hw5mhAhKhXNzrWqc8SFhJPl81s4cdn1G
         WBEnFhmt+136h8HME+hUHlyQgflXLEJYLo/fPYvp5BARa3WLBG1in3WA0X9vgCUsEEZr
         DBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683319290; x=1685911290;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmO/mUZslF6zk/m++XhRSloP3Is2SLrKGWDO4GiCCWg=;
        b=Z7NfZCJOmulwiYzOEoGuWCeDPG/p0iN53dATpnhKGtDaXn1I5+Rg0WYdikuKWxMSYB
         qortKxFdmfK6KCxmy3F95EnbQZGBWJPJl6PrOAWn0dLt5j0KOmaPu2ZXiO0pa+Wq2d96
         1JHkdoK7nrUGVXoQbAbOrG2IFidMz9RPe8mtuDoOCxn56oYr+fb0gJf7f2i36hfUbj8+
         f4ooxTw38+6pQOFH6IZ4k4RkLIjEtSZtC7wgcUZ1YtVWo5zJNhS2nh7g8Z1IieDY1GtI
         1+Oc9VK0Mdnb2PTLrX0KiyygsfcyX++sa9JaBJ6nMp+DgjZUME2pkv7ue8SCwRawXo5b
         F3cw==
X-Gm-Message-State: AC+VfDwQur9gGVElOzDERcWWsG24gbCIWd0E5EKotOPQF9EpVy7lktKp
        DcmzCb4lszt6M+GrjJrxBm4uszA/Ont0
X-Google-Smtp-Source: ACHHUZ5Dv7F5cKDlVBgpxFtZXGpdiBBv258UrDthWKLlxZdY0QJ5+1TO+9v3x3UwVzLba5d6aKz5FytMgJbr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:4715:8e64:29b7:6c4])
 (user=irogers job=sendgmr) by 2002:a05:6902:1021:b0:ba1:b908:364c with SMTP
 id x1-20020a056902102100b00ba1b908364cmr1678204ybt.12.1683319289896; Fri, 05
 May 2023 13:41:29 -0700 (PDT)
Date:   Fri,  5 May 2023 13:41:19 -0700
Message-Id: <20230505204119.3443491-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Subject: [PATCH v1] perf metrics: Fix segv with --for-each-cgroup
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
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Ensure the metric threshold is copied correctly or else a use of
uninitialized memory happens.

Fixes: d0a3052f6fae ("perf metric: Compute and print threshold values")

Reported-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4b9a16291b96..c566c6859302 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1730,6 +1730,7 @@ int metricgroup__copy_metric_events(struct evlist *evlist, struct cgroup *cgrp,
 				return -ENOMEM;
 
 			new_expr->metric_expr = old_expr->metric_expr;
+			new_expr->metric_threshold = old_expr->metric_threshold;
 			new_expr->metric_name = strdup(old_expr->metric_name);
 			if (!new_expr->metric_name)
 				return -ENOMEM;
-- 
2.40.1.521.gf1e218fcd8-goog

