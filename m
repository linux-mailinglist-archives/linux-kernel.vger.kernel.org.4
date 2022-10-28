Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AB611B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJ1Ucu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJ1Ucr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:32:47 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB222BADF;
        Fri, 28 Oct 2022 13:32:42 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13c569e5ff5so7177933fac.6;
        Fri, 28 Oct 2022 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSqnTpNHbps1i+IUkYc3gnjPok+dbevRU0lz9a6eyvw=;
        b=iTU6qv2ayh4eXbj4okGU3i75GySPyiKnsl+FlqMSW/CiislYhDz0qO6o0IQDHv0i5r
         EYq+ENorLnir75FL2c/sdRs9R+icC1Ni1ufLAbGc1aTLTXBue86KP2YQErvbUP068M15
         858Oauk0ck5eUtcAzDKwISV59G3M120dEWr6izi3gdKqUREQ6jH/Y/oT720+IS1o1wh/
         0xM3fLHvuCA8lLKPS+7iAE0etRAK5yJz97qdrcqcihsjoXNL4wOTBpgNvAzypFx+QTV3
         4+R5wUcG0eoG7Phpyh71TC57DY05o0GIZZi0/Pc3pwQjQV4ieBL0VMS7fIVqEuQqhQhG
         gBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSqnTpNHbps1i+IUkYc3gnjPok+dbevRU0lz9a6eyvw=;
        b=ArCUdEOpOtz0nmdfX7Tu5PksChOkHRnefupV/HpyNSzdbp8KGR/HQAK6Gay5INHafb
         KnpPE7eqdd5ctq22crYN4DthvwK/nkjqxYkArdHKrlpIAg4wXmFm1G7wHCo1nhpWlBUa
         XE5Rq2rQWVJIxJ40q2ipcMGSqUyWRx6weC5eBxsgD4XHpvDbMva8TJngZh6JuSp+C7eH
         x+JnRWU1Pat2K0Njxm5RkZ66xOC/4VUi7tEQa5h4rlE3TqST0YUg2ZzYPPHQFYLn9UMT
         XiaEALN0IceHKZCEcjvZ8to9P/sv0DWoauGM2AueHKmqZPrDz/unUUVC71ebKgCat8pE
         Dj9w==
X-Gm-Message-State: ACrzQf0ilYUgTi2eynZiqwsUOA1kiw8AL1QeN/zDk80XXU6fi8a4jvC8
        hbTidoW8goUAGrvBdgm9sX985eOmlJ/hLA==
X-Google-Smtp-Source: AMsMyM5a3oWEc//yptM8iRA1i9OMaraSBZntQF4oDygLxwNpgS9+yLR5gq+K9LFTnzYSqGKzqmvQiA==
X-Received: by 2002:a05:6870:f221:b0:13b:254d:247a with SMTP id t33-20020a056870f22100b0013b254d247amr583828oao.173.1666989161995;
        Fri, 28 Oct 2022 13:32:41 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:c2b:f36:b54d:df2:8623])
        by smtp.gmail.com with ESMTPSA id a8-20020a056870e0c800b00130d060ce80sm2626247oab.31.2022.10.28.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:32:41 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf/x86: remove unused variable 'cpu_type'
Date:   Fri, 28 Oct 2022 17:30:05 -0300
Message-Id: <20221028203006.976831-1-rafaelmendsr@gmail.com>
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

Since the removal of function x86_pmu_update_cpu_context() by commit
983bd8543b5a ("perf: Rewrite core context handling"), there is no need to
query the type of the hybrid CPU inside function init_hw_perf_events().

Fixes: 983bd8543b5a ("perf: Rewrite core context handling")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 arch/x86/events/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 337a99afe8..85a63a41c4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2161,13 +2161,9 @@ static int __init init_hw_perf_events(void)
 		if (err)
 			goto out2;
 	} else {
-		u8 cpu_type = get_this_hybrid_cpu_type();
 		struct x86_hybrid_pmu *hybrid_pmu;
 		int i, j;
 
-		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
-			cpu_type = x86_pmu.get_hybrid_cpu_type();
-
 		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
 
-- 
2.34.1

