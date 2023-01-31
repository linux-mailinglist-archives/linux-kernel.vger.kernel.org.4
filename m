Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0068221A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 03:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjAaCeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 21:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAaCeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 21:34:05 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933243346C;
        Mon, 30 Jan 2023 18:33:58 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so13625801plr.10;
        Mon, 30 Jan 2023 18:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCu/OJvZgrHmpfb4wOiCy+fL/exx0kcJ6xVqf60vg6E=;
        b=EgbWRsq6rbwJbO0WuPuCoYZ6aLWhZ5pnB//zXVtrgvkkPl5AU4kylWRecsWuSayikh
         sF7B8CjKhpu3E6Fg3kMqGQH+4b99eBmtl02mvKwRxOd9dEOEnY+4RZ3qwVbQf/pNJIzq
         S38ioAC+VkrzSvXCWh7C6hwDlVe6yC2N5INJ+oJn94dx4seBVmafKJPRSaQ68tM9dWIC
         C/vi5ctj8pM7Z0drawFJ2Spz07IMbTpePPZc9QKq/lyn9a708OcAmbzsp+YSqPY+qrQz
         7VFWkpaWCsYwargAbQJPBbx/ZsSgDFrm/byUV/VUysoh4Yn8fy7Aw3EKkuYRDXseq9T5
         FbJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yCu/OJvZgrHmpfb4wOiCy+fL/exx0kcJ6xVqf60vg6E=;
        b=zXJ5ElRb5S5c0EpKzh5U6YOFmsfF9vpVsLAFKmYiLFJafgXs2b0DEv20jJSwOSJb+/
         4gVstBAd+gTFJ0kRer7laUf2GDzHwgoebm0ivieZrwVFcvtXX20eIPgi323ecOBzZ0d2
         rMLVkoO6OBhdTlfhy50xmBR48RPVB2OHofqg37wkm6dsl874quqOu79otLNUK8ZGj/Wu
         4JhpOS3WrQapTx639FUg+SGHXb8ZKEK67jw/gXk1ac42KUXzkywMwf6v5qwcBUkNuZcZ
         YbtkiLLPhWEQxRcfQYkD/fv4QgukN/Kum9g8GD6GgCQSt7nKqmgQGEHmCvpcTu6eAReb
         Vy4A==
X-Gm-Message-State: AFqh2kqW/YcSB20P64YxbLeBnvAlbm6bAkT823U5COnDUC1RlGxQI+Qc
        fnulQi3XwHM7Im1I/fh1ruk=
X-Google-Smtp-Source: AMrXdXsUi4qoSu7zrde/UsWbvEAOeSm8GjUL+nuLJvGh1C7RRXIoNy0XqynvF+6LguGyPdDnPDIdrQ==
X-Received: by 2002:a17:90b:1e0f:b0:22b:bcb7:610c with SMTP id pg15-20020a17090b1e0f00b0022bbcb7610cmr39986773pjb.44.1675132437475;
        Mon, 30 Jan 2023 18:33:57 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:ff0:3f41:4035:c56c:92cc])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a6a8d00b00228f45d589fsm7640582pjj.29.2023.01.30.18.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:33:56 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 3/4] perf session: Avoid calling lseek(2) for pipe
Date:   Mon, 30 Jan 2023 18:33:49 -0800
Message-Id: <20230131023350.1903992-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230131023350.1903992-1-namhyung@kernel.org>
References: <20230131023350.1903992-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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

Reviewed-by: James Clark <james.clark@arm.com>
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

