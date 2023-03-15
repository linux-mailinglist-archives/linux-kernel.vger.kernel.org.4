Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B286BA776
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCOGB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCOGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:01:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99911B2FD;
        Tue, 14 Mar 2023 23:01:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y19so10172746pgk.5;
        Tue, 14 Mar 2023 23:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678860115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ph4mEsJfMGt8x6D4O/q6Z6jc9EvXuEN8fjxp1ja/3Y=;
        b=p7tvfCMc7cgnlwBeJkbUGcf+q54nucaVu1UeJgUjkCPpb/cOsPmDgMzLzX5dbBW+RM
         5/4YiG1GMlv0GFAnRpfP58XQBOegUWXNPOIp38jrMOvWE9SxGvyqxzZ2IXg1NtlY3NEP
         6eVEuKtJmQCDyZekGb01ANO92z+rgMxHleD2aQxMlCYRA2enP//23yWvI/2CJAcfRvuD
         5UGT1CUvo+Vj7Q7NpKtqECVSldqTkVBM9Tf0nwcLWUv+rhIuNFe9kS76xNBt2rot62yz
         4XppaBBYP9712eXN8G0r5SHFaijDrYf8OQyQw3ODqY8IQqYWPqT7CEcZptA1I9sf775J
         HFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678860115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ph4mEsJfMGt8x6D4O/q6Z6jc9EvXuEN8fjxp1ja/3Y=;
        b=AW8RugZIXHbXAjd7DhPRK4EGInF/NES5T1tf51EUzJlTL3ZZ9cAunwzGoP6XmbyRN/
         KfUZ9Gk6xbMTiXF4+7npTLE0yoC6lf58WEJ8ROcUY9DVfFd+qTBXDYWtnqu/TMok8U2E
         rA7dvG+NAmPxsLBGgWTGs+TfqjLvAA2S+D5OjX96dRnCWToIfTBdmECceOl67INhmfGM
         V+jibnTQsva+l7WTgO9BLNsv6WvukwY9wAvoLGa2kTPgQ9SWltEDHKklkdvnFK23mbAh
         cU26gM/VtfykWKnOqTxHoBpjC6OxtXof6Nja5nryvX4LjKpu9WC6kye4p115wnng5Maj
         RoBw==
X-Gm-Message-State: AO0yUKVwygRpJLUIaU78305UnyIAIC2NawbItykukdv8RG3J77DVRvdB
        upPndTL7Krocwa+zABnU6zhWjKeFY1MYXjXH
X-Google-Smtp-Source: AK7set9xAV/grl8gRzV8cOUkens4vcIqbtsttQsAh3A2Ht0R7RVwbr9fD7Y5eWezkV7K2JnNB82+WQ==
X-Received: by 2002:aa7:9602:0:b0:624:2e60:f21e with SMTP id q2-20020aa79602000000b006242e60f21emr7694296pfg.29.1678860115030;
        Tue, 14 Mar 2023 23:01:55 -0700 (PDT)
Received: from kim-GL702ZC.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id x28-20020aa793bc000000b00593baab06dcsm2585648pff.198.2023.03.14.23.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:01:54 -0700 (PDT)
From:   Paran Lee <p4ranlee@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paran Lee <p4ranlee@gmail.com>
Subject: [PATCH] perf tools: Add levenshtein ENOMEM check
Date:   Wed, 15 Mar 2023 14:59:38 +0900
Message-Id: <20230315055937.22769-1-p4ranlee@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The levenshtein algorithm requires exception handling
when making dynamic allocations strings.

Signed-off-by: Paran Lee <p4ranlee@gmail.com>
---
 tools/perf/util/help-unknown-cmd.c |  6 +++++-
 tools/perf/util/levenshtein.c      | 16 ++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/help-unknown-cmd.c b/tools/perf/util/help-unknown-cmd.c
index ab9e16123626..a70ef339b8af 100644
--- a/tools/perf/util/help-unknown-cmd.c
+++ b/tools/perf/util/help-unknown-cmd.c
@@ -74,10 +74,14 @@ const char *help_unknown_cmd(const char *cmd)
 
 	if (main_cmds.cnt) {
 		/* This reuses cmdname->len for similarity index */
-		for (i = 0; i < main_cmds.cnt; ++i)
+		for (i = 0; i < main_cmds.cnt; ++i) {
 			main_cmds.names[i]->len =
 				levenshtein(cmd, main_cmds.names[i]->name, 0, 2, 1, 4);
 
+			if(main_cmds.names[i]->len == -ENOMEM)
+				goto end;
+		}
+
 		qsort(main_cmds.names, main_cmds.cnt,
 		      sizeof(*main_cmds.names), levenshtein_compare);
 
diff --git a/tools/perf/util/levenshtein.c b/tools/perf/util/levenshtein.c
index 6a6712635aa4..ce273d34af5f 100644
--- a/tools/perf/util/levenshtein.c
+++ b/tools/perf/util/levenshtein.c
@@ -45,11 +45,17 @@ int levenshtein(const char *string1, const char *string2,
 		int w, int s, int a, int d)
 {
 	int len1 = strlen(string1), len2 = strlen(string2);
-	int *row0 = malloc(sizeof(int) * (len2 + 1));
-	int *row1 = malloc(sizeof(int) * (len2 + 1));
-	int *row2 = malloc(sizeof(int) * (len2 + 1));
+	int *rows, *row0, *row1, *row2;
 	int i, j;
 
+	rows = malloc(3 * sizeof(int) * (len2 + 1));
+	if(!rows)
+		return -ENOMEM;
+
+	row0 = rows[0];
+	row1 = rows[1];
+	row2 = rows[2];
+
 	for (j = 0; j <= len2; j++)
 		row1[j] = j * a;
 	for (i = 0; i < len1; i++) {
@@ -79,9 +85,7 @@ int levenshtein(const char *string1, const char *string2,
 	}
 
 	i = row1[len2];
-	free(row0);
-	free(row1);
-	free(row2);
+	free(rows);
 
 	return i;
 }
-- 
2.34.1

