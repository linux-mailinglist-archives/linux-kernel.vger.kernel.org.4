Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653C067DAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjA0AUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjA0AUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:20:36 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3D2B60F;
        Thu, 26 Jan 2023 16:19:59 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id jm10so3386744plb.13;
        Thu, 26 Jan 2023 16:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLtqR2vTJPsyXL+Kk95QTPsvoc9EHhO85tO4NsvnR/s=;
        b=D4iBm1OlCFLot8f30ioPALHeV1nPkB9M+r03xCKGGLDWICpvxtoxUhGC8wgbGo5xC4
         ZMveWAISnon9BSgXnVGxveZ3krPkz6pOsZYanbW4rB9BDr0c2PbODYapGNewpnxwiRip
         /fAzDiNktmmGLgQojkqqHPKTJ3reuVA74595ClD6E4vrxAojTM4KHcOrLTz7DDS5W7D2
         r3/Ie7MgvXLQUUem4YNRel1ZEQMdJ42UkEpBWJeaFJAN8YT93KJ+/Fq9eMvVaCISTNg7
         Qj7WDsa0hPFR/59/wY4Kcp2Gjqngo2rzvawG+q7mMdBPEafKbvWtRn4CUpLkbv/bluVa
         3o2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLtqR2vTJPsyXL+Kk95QTPsvoc9EHhO85tO4NsvnR/s=;
        b=xdV1rriFLEHKtg+bz7BRQjcf10RL2rMsZNb0T+FRInY3oFeaDPn4IHAWbALirBSENt
         2vUs++JMGFiATm4bNaIOTo9qX6BJm/4pYGqM4smFGw4oqxjAfwE+Sg3cG/nWeLFJgF0O
         +BuwtjUiOG9KVoSG8YscPIGUBJ7fpezCs+leG+ZjsN/l30FoQ1yhSDA7ZZivOakvvxHq
         4E4Lbdqo6ASll8QtvYNNIrjufoy48ewHswYBdq63GccxMjkE7qtx84Ze1zaZlArClrUP
         CnCISzUP8sc8HNyt592y0S71nbPYPDn4MDUwXxiClI5GQX+ZKiCMPTnHsxnf+U6aE2SF
         3ixg==
X-Gm-Message-State: AFqh2kpbIlxzo9it9etDmFgc0y6wd+zJCPQM2OOBOH04ZCxKSfSvEXXj
        Voh95dnV/FoHT6pfXbocFOU=
X-Google-Smtp-Source: AMrXdXvkUR5oRbtsV5mWjJFH2P+uge3F8ZbD/MTQdfjQ29IbZjd8stskDXG0epzqIWhCEjZtb5NXhA==
X-Received: by 2002:a17:90b:4d8e:b0:229:ade0:d0cf with SMTP id oj14-20020a17090b4d8e00b00229ade0d0cfmr37357783pjb.3.1674778798772;
        Thu, 26 Jan 2023 16:19:58 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1f5d:eee8:d409:8a17])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b00229f7376247sm1567270pjc.57.2023.01.26.16.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:19:58 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        James Clark <james.clark@arm.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/4] perf session: Avoid calling lseek(2) for pipe
Date:   Thu, 26 Jan 2023 16:19:50 -0800
Message-Id: <20230127001951.3432374-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230127001951.3432374-1-namhyung@kernel.org>
References: <20230127001951.3432374-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should not call lseek(2) for pipes as it won't work.  And we already
in the proper place to read the data for AUXTRACE.  Add the comment like
in the PERF_RECORD_HEADER_TRACING_DATA.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7c021c6cedb9..fdfe772f2699 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1699,8 +1699,13 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_AUXTRACE_INFO:
 		return tool->auxtrace_info(session, event);
 	case PERF_RECORD_AUXTRACE:
-		/* setup for reading amidst mmap */
-		lseek(fd, file_offset + event->header.size, SEEK_SET);
+		/*
+		 * Setup for reading amidst mmap, but only when we
+		 * are in 'file' mode.  The 'pipe' fd is in proper
+		 * place already.
+		 */
+		if (!perf_data__is_pipe(session->data))
+			lseek(fd, file_offset + event->header.size, SEEK_SET);
 		return tool->auxtrace(session, event);
 	case PERF_RECORD_AUXTRACE_ERROR:
 		perf_session__auxtrace_error_inc(session, event);
-- 
2.39.1.456.gfc5497dd1b-goog

