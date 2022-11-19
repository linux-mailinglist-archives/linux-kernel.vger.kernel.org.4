Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139B6630875
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiKSB1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiKSB0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:26:41 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F40107B7A;
        Fri, 18 Nov 2022 16:27:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g10so5926673plo.11;
        Fri, 18 Nov 2022 16:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/iPMbl38syWjs5zIcb6fGRCtARpyLfweUo++FtYMEqs=;
        b=ldhL2wnq8KpoU6+joFgyyzIoqcIhC7ujwyw/cavZq7CBiGYgWLupUQghx5UZHb3UCg
         BGG4SFs9BYrfCBLreTzJFi9JhfB/IfOuKviN1F9MFj5sAWpjm6dMQ1F+l6puDr+mluo1
         mm1DRxUY3mqAeXgXqy9It/duBgd5Tw26b3V48uYkPKEGgYnGY80RHUKRo+myiQ/OPrtQ
         ZeNKYJLaH29H+TBl4ezlpIJVpPKtcsEG9k+qhen3SjWYCvWHUupVu9XIdBhtv+quV5h0
         HXoegCYV1LtI2YjxrRh/gHcI+PTnISuY0+niBhp47UpHGJxprGycmQ+2oqExdzPLUr1W
         wf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/iPMbl38syWjs5zIcb6fGRCtARpyLfweUo++FtYMEqs=;
        b=Ts+E8npm1MAmpqaYs7PeZElEQUJIgZWr8vENRjrwz/UiLUCk5F7olveejTRMbhXDlV
         fn2kCGEIxI/PuSIBOwqwR7wC4jf/JMMmt4xKA650uhcotCUObVWgyU7pGElOzBPNFi50
         k/95YdmLFqUaHAG85o7wb6WdKITBhmfITmGRG1bBVNZ+6xf+IkdC/zBsV/nIwnA93gCE
         v4VaDA910OpX8SDWZZ9zAVBYFQ/pJQMEiDyTw3WMYxqofKk6M6LlTQwTB3meSIhm+x4B
         hjmAvHvNk/am9PfM6Rf/AuR2nFtpLg5S0tv40E60c65zwMg6C4+IpEvn/w+v9v/7jd/F
         0Vaw==
X-Gm-Message-State: ANoB5plgDzGanNQpfhwgtGNbQ9ZeQW/IgadwwrRQ7j4aOAJaASUAa42Z
        u2EPCL43zyJZpmRwu4ePk4M=
X-Google-Smtp-Source: AA0mqf69rRiHMW713fQToGlnZQ+rtEpJu8PHiZv6UFzDB4Be9+eKfAPi2RAJ6dOPURixWFxz4jgD3g==
X-Received: by 2002:a17:90a:ac03:b0:216:bd33:b287 with SMTP id o3-20020a17090aac0300b00216bd33b287mr10282988pjq.26.1668817675923;
        Fri, 18 Nov 2022 16:27:55 -0800 (PST)
Received: from balhae.roam.corp.google.com ([2607:fb90:27d7:f680:581f:5527:bc6:1576])
        by smtp.gmail.com with ESMTPSA id c15-20020a63ea0f000000b004393f60db36sm3406275pgi.32.2022.11.18.16.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 16:27:55 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf inject: Set PERF_RECORD_MISC_BUILD_ID_SIZE
Date:   Fri, 18 Nov 2022 16:27:50 -0800
Message-Id: <20221119002750.1568027-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With perf inject -b, it synthesizes build-id event for DSOs.  But it
missed to set the size and resulted in having trailing zeros.

As perf record sets the size in write_build_id(), let's set the size
here as well.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index cccd293b5312..0645795ff080 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2218,8 +2218,9 @@ int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16
 	len = pos->long_name_len + 1;
 	len = PERF_ALIGN(len, NAME_ALIGN);
 	memcpy(&ev.build_id.build_id, pos->bid.data, sizeof(pos->bid.data));
+	ev.build_id.size = pos->bid.size;
 	ev.build_id.header.type = PERF_RECORD_HEADER_BUILD_ID;
-	ev.build_id.header.misc = misc;
+	ev.build_id.header.misc = misc | PERF_RECORD_MISC_BUILD_ID_SIZE;
 	ev.build_id.pid = machine->pid;
 	ev.build_id.header.size = sizeof(ev.build_id) + len;
 	memcpy(&ev.build_id.filename, pos->long_name, pos->long_name_len);
-- 
2.38.1.584.g0f3c55d4c2-goog

