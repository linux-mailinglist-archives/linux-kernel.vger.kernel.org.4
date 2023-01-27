Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1275867DAA7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 01:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjA0AUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 19:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjA0AUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 19:20:36 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF01214496;
        Thu, 26 Jan 2023 16:19:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jm10so3386705plb.13;
        Thu, 26 Jan 2023 16:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7c2k3JxwqHMLdDHaXxYBGINQa6xWp1S+b3x47KyaT4=;
        b=cLcixg53FrGqCZqahgbnaolNOkBAznVNgsgxBHrcm79QRm3mpWoYXfT3kM+6YfFd4o
         v9giZWvcrCVZlqcUCzBDv7xLXsZWBtq9RjcRotaic1QfAoo4gO7L0yeCDJLrIDca+AiJ
         uXsiQ3C3MKlY7JAMHh71O6x5XN5YgAwbo3geqdiE8GTfW8WvLfs/E6Vb4sEJ5m5DolIy
         LmKjZygNcmGn2ylmsot4kBqjfdbXO1yvjCCUoJKYx5k7fZNbcl2Ifr5p6VpHalkGy9Ul
         d931pvRMHlY3URQTdg2Xh8GkmTbKMfnubK1vevbZTHC/9BNs4s0F9UnqiBS4jqEyZYWa
         c2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l7c2k3JxwqHMLdDHaXxYBGINQa6xWp1S+b3x47KyaT4=;
        b=OFLqVa4WuKx9w8o0hc9xRcaDLlif43k8noQCDyjPevP6IJh8owO6XrsPqpT9LworF9
         PH0UQF7vgztKPijGtMN8EUBKYnZ3C6ptauCvQeD5ipgFsfADiLDt9VX/x7zk1nZsxsXD
         KbozIrs9TfOt5BiH4M5Y3U5GO4DxMYWGn3W+FHwLiHxxecfvDahdLz3Td/C/4lyI2lX8
         QNq0HQxlWc+llWWcB1MGuw3lNPh8lql3abi04cw4Xgvt/P732wdYtL75Te7H0DrjLpPl
         7Xfc1sqo9ECL41TX2SZ9dXRf0dN8nKy+7DHypd2WNGVk0xLX29Y1rLrs5H42YcGLS0Bq
         Rlww==
X-Gm-Message-State: AO0yUKVNDx6wvys7zQ+tO5h6jfUhQ5xOsyvkcpXTCOJaOmIDxznjowJo
        A+549oOiRA53MYIQEEa5lUw=
X-Google-Smtp-Source: AK7set93PhuwHuth1EbjmCP60if7aPKCOjq8EXFgfdq5G8iXDZdrbce0yn82EqOK/7xHJ3JLJEJh1Q==
X-Received: by 2002:a17:90b:3b52:b0:22c:b32:4806 with SMTP id ot18-20020a17090b3b5200b0022c0b324806mr4628545pjb.27.1674778797587;
        Thu, 26 Jan 2023 16:19:57 -0800 (PST)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:1f5d:eee8:d409:8a17])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090a088f00b00229f7376247sm1567270pjc.57.2023.01.26.16.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 16:19:57 -0800 (PST)
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
Subject: [PATCH 2/4] perf intel-pt: Do not try to queue auxtrace data on pipe
Date:   Thu, 26 Jan 2023 16:19:49 -0800
Message-Id: <20230127001951.3432374-3-namhyung@kernel.org>
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

When it processes AUXTRACE_INFO, it calls to auxtrace_queue_data() to
collect AUXTRACE data first.  That won't work with pipe since it needs
lseek() to read the scattered aux data.

  $ perf record -o- -e intel_pt// true | perf report -i- --itrace=i100
  # To display the perf.data header info, please use --header/--header-only options.
  #
  0x4118 [0xa0]: failed to process type: 70
  Error:
  failed to process sample

For the pipe mode, it can handle the aux data as it gets.

Fixes: dbd134322e74 ("perf intel-pt: Add support for decoding AUX area samples")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/auxtrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c2e323cd7d49..d4b04fa07a11 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1133,6 +1133,9 @@ int auxtrace_queue_data(struct perf_session *session, bool samples, bool events)
 	if (auxtrace__dont_decode(session))
 		return 0;
 
+	if (perf_data__is_pipe(session->data))
+		return 0;
+
 	if (!session->auxtrace || !session->auxtrace->queue_data)
 		return -EINVAL;
 
-- 
2.39.1.456.gfc5497dd1b-goog

