Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49B72B4D1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 01:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjFKXgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjFKXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 19:36:34 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EC4E4C
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:32 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b3c9fee2edso2205215ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686526591; x=1689118591;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WANpf+49bzF3fi1JQVnpe1Z3htf425reW9vyomwtVZQ=;
        b=RXGYM8eVM/uATq8am81E3Cix4a9oeYdn9M9Yuu96p5ej7mameQ8zKSPgkUa1ifzxNw
         Aa/7+j4X0E8no84CFwrdIjchQncGAHpS89BIJpDVWBTU/fbLg3xEcpRYLI8PDp6vZzTY
         yBjklgP5nBc/ANt9lrJU2RALrP+E+YA2RwMAqtuCvmelEUsaHq3/Rs+n5OUDcGBbyKlK
         4/S4UVhfdIE9G0q8v8KnDaLbTQS1RjQrPztr75ZBeyLRIBb5R8mQdEvnMHIJbKxrh93x
         06PrrzMokjdgEpL/PergNHmRVShKHdSTUAZJvRueMJn6ULiAfWgFqYoYjf5zrEmY08+2
         MAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686526591; x=1689118591;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WANpf+49bzF3fi1JQVnpe1Z3htf425reW9vyomwtVZQ=;
        b=AXcISAz4z5ma2rDCtWzxpLZzT+mw3iGOAFR4r1wsSY4nDMB+ZumkRRBL6V+bRw/uEW
         xb+4Ts/+YDd64G597kD9dMRskGej5qLBKx8sr0oCy8R2QMV45rY7w2TNouSm1bIZDY+V
         ThNaICdGwktgjRc/R9dvYIT0y+lrRkJRABoKtr7gWbcCAaPu/PhjeUZWtmS8lv7VAfPp
         rEBAHzNAyH8YPhwnjqmjjiSbFr9GhOIo/ui+4B/xEV2GcFACcAsKa3q5h2aktzKGEnhi
         j/LFumPjNymgiBwxEOdJINL+FGwVVIn2311cedOmdrvlRfuqOq4Kp2kchLaI97XCLZfD
         9HiQ==
X-Gm-Message-State: AC+VfDzW4Ok8FIe+YCgYAoHblBwieOhPqOsCqIe+dOfWc3e/hR/Y65hr
        HNRdHpOybEEU44I0eer/mqapvWpN0T/+
X-Google-Smtp-Source: ACHHUZ7WL18NUHn2IWnKxn2bm9QJXjRaix+IJOq6J8L5q2jX25NXIAuu/9DiBm2I4yggqgcIsJZOsE631zZD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:aca9:d7c7:ed17:e760])
 (user=irogers job=sendgmr) by 2002:a17:902:b08f:b0:1ab:18eb:17c8 with SMTP id
 p15-20020a170902b08f00b001ab18eb17c8mr865642plr.2.1686526591062; Sun, 11 Jun
 2023 16:36:31 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:36:06 -0700
Message-Id: <20230611233610.953456-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 1/5] lib subcmd: Avoid memory leak in exclude_cmds
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
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

exclude_cmds will shorten the cmds names array, before doing so free
the removed entry.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/help.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index bf02d62a3b2b..a66fb1a1a312 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -66,6 +66,7 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
 		if (cmp < 0) {
+			zfree(&cmds->names[cj]);
 			cmds->names[cj++] = cmds->names[ci++];
 		} else if (cmp == 0) {
 			ci++;
@@ -75,9 +76,12 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 		}
 	}
 
-	while (ci < cmds->cnt)
+	while (ci < cmds->cnt) {
+		zfree(&cmds->names[cj]);
 		cmds->names[cj++] = cmds->names[ci++];
-
+	}
+	for (ci = cj; ci < cmds->cnt; ci++)
+		zfree(&cmds->names[ci]);
 	cmds->cnt = cj;
 }
 
-- 
2.41.0.162.gfafddb0af9-goog

