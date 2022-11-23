Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF9C63680A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiKWSCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 13:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbiKWSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 13:02:13 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4466093715;
        Wed, 23 Nov 2022 10:02:13 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2837996pjt.0;
        Wed, 23 Nov 2022 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E05AU6ZdRoSB14xGjx/8Ofyvzr/jUJ5BgfZd3HvnFGE=;
        b=YN510YrGVv73yVz1JaUZ70Vb4Uu5LIUt0zqlUDyzLeUIjx6DuTXI5DJn3hrPqQ7g06
         oI2GQU4iaJDKP1NmgR85782K/zSMstYqX85lg64uzCgyHATPgDiwfgKSNLSk0D0MHTkl
         PSYwy7K6bRtqLS9eZfIq59EUTsQo8X3ZrOsI97b2AHc18p4S6s9Q0+AoApNrd7wQFnRd
         rdcV9O7wbNNQrvaYcyiv3ppEAO90Zp3NpdIh2Je0/i055XnyT4mvsgO/VmAl5yN5D77c
         iOsBzfVwNOnZhh+cpDB77mvZkdrB6NB+7wkPesVnbqsb1yrrlXwn4Yd7hDNxX768E78M
         wcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E05AU6ZdRoSB14xGjx/8Ofyvzr/jUJ5BgfZd3HvnFGE=;
        b=P5mUpZTsD3D5m1FowstDhJ0i7Ha9oTGaY0CyxrCgxw2/dtOTWeh8YTVC/P30hqk7zY
         t5LuP0IenQn2DbuBQt2Sc7RQFt2oIMrjRayu8E3E33NcYFqNoMo1YK5PNEtGcvn2jke1
         rR6qPvriPaXxC+yfSVbBS4KDOnhyyX6mgFh4GPr8JfVt43faTVVsKH+ktgArX8aZCBUW
         u1DQn5rZN7UPqPUGo7tVCIp50Q5l3cMjVc7N+Mle2xA5v6oNSPQ6iV+yHSiNC/oye9rc
         sqlxchUh9Ux5DSJ+izsOGa7XDdyNzWvpDHG4NDs+DuXrM29jn6xYFk4fVgduA1chPl2T
         QcGA==
X-Gm-Message-State: ANoB5pkkMeqkBI7/WsK5HsB0XbBVSrErviDZd5UgL6cThTYjsI1qD9ok
        kSYA/6bpwAzRiihliKBJLvs=
X-Google-Smtp-Source: AA0mqf4j+A6tpTAfHQm7UFrKh/siqpKj1hupwcqmY8E0GRF6/L3Naf9TRvqql9FozEKL/PslOhZAPQ==
X-Received: by 2002:a17:902:bd04:b0:189:38a1:30fe with SMTP id p4-20020a170902bd0400b0018938a130femr7013774pls.47.1669226532681;
        Wed, 23 Nov 2022 10:02:12 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:a80:c968:76:254b:3790])
        by smtp.gmail.com with ESMTPSA id i15-20020a655b8f000000b00470275c8d6dsm10792364pgr.10.2022.11.23.10.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:02:12 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Subject: [PATCH 01/15] perf stat: Fix cgroup display in JSON output
Date:   Wed, 23 Nov 2022 10:01:54 -0800
Message-Id: <20221123180208.2068936-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
In-Reply-To: <20221123180208.2068936-1-namhyung@kernel.org>
References: <20221123180208.2068936-1-namhyung@kernel.org>
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

It missed the 'else' keyword after checking json output mode.

Fixes: 41cb875242e7 ("perf stat: Split print_cgroup() function")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f5501760ff2e..46e90f0bb423 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -175,7 +175,7 @@ static void print_cgroup(struct perf_stat_config *config, struct cgroup *cgrp)
 
 		if (config->json_output)
 			print_cgroup_json(config, cgrp_name);
-		if (config->csv_output)
+		else if (config->csv_output)
 			print_cgroup_csv(config, cgrp_name);
 		else
 			print_cgroup_std(config, cgrp_name);
-- 
2.38.1.584.g0f3c55d4c2-goog

