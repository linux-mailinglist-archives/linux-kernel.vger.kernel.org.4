Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEEE611147
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiJ1MZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJ1MZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:25:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF910F882;
        Fri, 28 Oct 2022 05:25:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id l14so6409953wrw.2;
        Fri, 28 Oct 2022 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FK1/5YPkFf1Q7P1hlST2j1TGwCKOMyfu9yX7sOPqiu4=;
        b=dozcZ8KcZHyduxk/YDCY0FUTHezHt98S3E6zQLbDkiyXvW/vrmIxDZaqb+6/2jIpmT
         IfERd2QCtNUTKPTu2vch65f03UPEyjfCasTvpX2w0Ti8wWwgcp6wOBOKio/msbdfXnsd
         KNtVw0HARSmo3TDUunh/dsXcB+NbpfT9pdGToKxCEYJqf9WTyKOyc+s6tGX+Ds7T4E2F
         +vjnlAR2/MVw5NurqhWCjpVAqKnObuyXGlgal7HTr2KQUUPreJAlhI6Xc7FGFA5eyasz
         bOCZGkq4eTgdvvJRVzRLS7YP4E0CywS3nT8LSJIw3f8We0JJNXr00G83Ak2TDLteXqvI
         kkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FK1/5YPkFf1Q7P1hlST2j1TGwCKOMyfu9yX7sOPqiu4=;
        b=4g3WmMDVmWavkz+BADK4FsNJTxhFuGW8kw9QvYykejYuZZRA5cdF/53JjkwaR9rHnC
         n4ruGHIAtUqqvAL6FuXODBoMRZrdlKTn4U8A9reBzKjcvMkJ6P2PqUwQ5KIbfxPAV8dL
         YPtamVu/dSJEPeB29GkRAg0SaqG003GZKxS4j/0D8DRon/QJWZISQKV1AGAs7NhQxjdD
         oGq6nWAebfn7qzlH+XhWXeIPXYiiJBD39lTvXiBPPegD4e8yrcwnr0xE3ZfoCYobd2jU
         f/5fjCOzeoiI52kI7O/eLvGxRxvaTyJ6xI2u1lj4y5vJ1NvSLs/4TWqd3CMmhE4AjnQ3
         29Og==
X-Gm-Message-State: ACrzQf3X8VdjiF5u7e0ptsIv7kSshlGzH2Nj2Sb0zJdE9QFi/C5ieQ0Q
        /J1JyA9MGDGqwac//I2ZGyc=
X-Google-Smtp-Source: AMsMyM7lv7DKYenGFEasJTH7+oVoBU4pALFMDyuloucnUJszGGYZH1IwHoOSWbsnCJqFHbvC45s3qQ==
X-Received: by 2002:a5d:5711:0:b0:236:598d:83ed with SMTP id a17-20020a5d5711000000b00236598d83edmr24125851wrv.190.1666959946497;
        Fri, 28 Oct 2022 05:25:46 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c1d0400b003c7087f6ca8sm4493240wms.2.2022.10.28.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 05:25:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf: remove unused pointer task_ctx
Date:   Fri, 28 Oct 2022 13:25:45 +0100
Message-Id: <20221028122545.528999-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The pointer task_ctx is being assigned a value that is not read, the
assignment is redundant and so is the pointer. Remove it

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/events/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ebd9ebd53238..e7c0df152c8f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4215,7 +4215,6 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 	struct perf_cpu_context *cpuctx = this_cpu_ptr(&cpu_context);
 	struct perf_event_pmu_context *cpu_epc, *task_epc = NULL;
 	struct perf_event *cpu_event = NULL, *task_event = NULL;
-	struct perf_event_context *task_ctx = NULL;
 	int cpu_rotate, task_rotate;
 	struct pmu *pmu;
 
@@ -4229,7 +4228,6 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 	task_epc = cpc->task_epc;
 
 	cpu_rotate = cpu_epc->rotate_necessary;
-	task_ctx = cpuctx->task_ctx;
 	task_rotate = task_epc ? task_epc->rotate_necessary : 0;
 
 	if (!(cpu_rotate || task_rotate))
-- 
2.37.3

