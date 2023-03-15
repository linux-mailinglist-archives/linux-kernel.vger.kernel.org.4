Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3EF6BA78B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCOGMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCOGMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:12:09 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235795B437;
        Tue, 14 Mar 2023 23:12:08 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h8so18939242plf.10;
        Tue, 14 Mar 2023 23:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678860727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mVdgwgT2qkvzpfasDSj7seSqlj6lgppVtKp0BZbtf0=;
        b=lYl0CLiE4QFY1LHjzOTsvsZ9ivFXWrocZmWnVGAWdmA3fV4ppYmG6/Mky0qQBAjEMv
         gP+i3uspGIfUeD9/qcYlGACf8RFacyO4rnKfNT9/zPFsIbpGFq6EonbzNc1n/dCePcjC
         tOaN2pcxX+7HAef+H7//wblL5HZ1aU3dMxEMRJwsnIRDWAejvwyMImqOqHpWmr9VWU0y
         ppuSDzU1BdKnnDKSaA2avR/SV8NOZj1lGZYKlMKT/H45jDdWThB4U1g3coFKD4icaTpm
         WiVqgKbfRbE+/roeexnwZkRY9aDpFYgoF7/ZTruvd3f90LxosReqO786rTQdymtZmbAe
         ASYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678860727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mVdgwgT2qkvzpfasDSj7seSqlj6lgppVtKp0BZbtf0=;
        b=Xuo8GgkPUKEdICIXckEX6VEZOnL8hnyiTQIzTeWpNAoDOQ87eQmy+enjE8q9VvDdsr
         tFmSa0byfIuqqBANbTkNPh3M4xjakRI4L1ocaO27HMzYz3w8YmX7sa20a/eUDKSAbRuC
         VXgiSD/w4n8acxW/V3ffq4ctYj0PK5sX3oSJoTk8vSpAq5BLQZMV9GYICvg+jy1Keog+
         JE35KmRxZefkddVALp4dhKodSvNu1/x+vauCYVhDRlLpOaNBRPgNnj66OG1hq15nxTB3
         mMNhJD7Y1vvi3hWDNGIkAdgO/xstd2v19+QAIT4oksGlsnRSe3ED72uT6k+pKl0fPbAM
         FhoA==
X-Gm-Message-State: AO0yUKUBHOobkHd8/8nY0YjWfWlEN/JagA7LwThIehskYcAw1QSSZoe2
        bbmlgyvg07bruoffkAXLjFk=
X-Google-Smtp-Source: AK7set/vfxBgnmopzVSGEh2xGbcrBcc/Ijhd+G4JyJ+osaoyEaOHC9c7kHUE3Jfqbsvnf6MJ5eE0jA==
X-Received: by 2002:a05:6a20:8f04:b0:cc:8107:7474 with SMTP id b4-20020a056a208f0400b000cc81077474mr46397683pzk.9.1678860727493;
        Tue, 14 Mar 2023 23:12:07 -0700 (PDT)
Received: from kim-GL702ZC.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id i31-20020a63131f000000b00502ecc282e2sm2554323pgl.5.2023.03.14.23.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 23:12:07 -0700 (PDT)
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
Subject: [RESEND PATCH] perf tools: Add levenshtein ENOMEM check
Date:   Wed, 15 Mar 2023 15:11:33 +0900
Message-Id: <20230315061132.25165-1-p4ranlee@gmail.com>
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
index 6a6712635aa4..0f0f244f142b 100644
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
+	row0 = &rows[0];
+	row1 = &rows[1];
+	row2 = &rows[2];
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

