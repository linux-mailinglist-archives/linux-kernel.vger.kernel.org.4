Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97AC72B4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 01:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjFKXgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 19:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjFKXgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 19:36:35 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58061193
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:34 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5488dccfbdfso2593846a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686526594; x=1689118594;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k9cwHrs21djZApS7zUbHblwlDRTI+1czCtHQubUC6Kg=;
        b=7xIkn6oyjG3Q7/kGPqSYyW4IIf90AkZn+Xz1ZYmfUMHQv28egJJNMUZ7HGg69SXPBq
         tkFBwo2YgooqkUvUTjyjL5B5+GdpvIJwlscTSXfJiHZlnKN0YzSOVPSU75LEtRaBiBDP
         v7qEpbZ8daH06a4DQlgEW6iIVI6FXiHOq7FvZFnPSSGlmISz99yhDjX0gH/g0OTZIY9C
         ir8/aQ1jM6AzGQes+rQMfrqn62rlJyv+ZqmglSy0wJD3LSpfqGnw2yoj2PtCSl2mf3Y8
         91zGPGxHBYSsxSOWxwJ5SfHHbYoNsKAo/5DmjG7R3xiKCk42ckrzxa+G62EwZmhu8Hp2
         x4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686526594; x=1689118594;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9cwHrs21djZApS7zUbHblwlDRTI+1czCtHQubUC6Kg=;
        b=P7BCXdWsBUmW0aAuDO8y3m9PehEStgrDcWI/5TueiopK5D5yIWB4m5ylikjFoA9iaQ
         8aUXQ9qMgo30I/lTd3b4cxb5WGWy4lu5hQ53qy3Aa/InKSJwNs/qf+WjNM5BQc3m8tty
         /jQ/Oz9JhGhdqlXc6OPnil+AmDPs5cehSaJvqFfbPKaftfeJT6g8KwVSnfNI6YPIKvjz
         4rteVmncJk3B7We1Jnn1koP+5GduyN7WBkkHROk5vcWRA+Ss8+TL5qnv4ra8vQkiAY3R
         3qn5T8bzam/WrTmAtSI6obyUGL+aalHf3R457eWVMtRbxV9KkvQ+X9J+RXGo1pPtwHAy
         /VtQ==
X-Gm-Message-State: AC+VfDwnbDN+vmdmBxb6Z3EmmcsxZxtmBqOgswwa6dLD2/risI6Gp8G2
        WAJIBnZHSgaF3WQR3Bg/vKnGPxFF7XYD
X-Google-Smtp-Source: ACHHUZ40TT/qLzJOYNWxXVqlD3If2CWCua1Ha+mUvlN75NgOBRCCkKrrMpatRWEOlLRMv2oD0dcCEqHxTsbe
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:aca9:d7c7:ed17:e760])
 (user=irogers job=sendgmr) by 2002:a65:66ca:0:b0:519:d08d:a4d5 with SMTP id
 c10-20020a6566ca000000b00519d08da4d5mr1003460pgw.6.1686526593620; Sun, 11 Jun
 2023 16:36:33 -0700 (PDT)
Date:   Sun, 11 Jun 2023 16:36:07 -0700
In-Reply-To: <20230611233610.953456-1-irogers@google.com>
Message-Id: <20230611233610.953456-2-irogers@google.com>
Mime-Version: 1.0
References: <20230611233610.953456-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 2/5] perf help: Ensure clean_cmds is called on all paths
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

Avoid potential memory leaks.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/help-unknown-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index ab9e16123626..eab99ea6ac01 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -92,6 +92,7 @@ const char *help_unknown_cmd(const char *cmd)
 
 		main_cmds.names[0] = NULL;
 		clean_cmdnames(&main_cmds);
+		clean_cmdnames(&other_cmds);
 		fprintf(stderr, "WARNING: You called a perf program named '%s', "
 			"which does not exist.\n"
 			"Continuing under the assumption that you meant '%s'\n",
@@ -114,5 +115,7 @@ const char *help_unknown_cmd(const char *cmd)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 end:
+	clean_cmdnames(&main_cmds);
+	clean_cmdnames(&other_cmds);
 	exit(1);
 }
-- 
2.41.0.162.gfafddb0af9-goog

