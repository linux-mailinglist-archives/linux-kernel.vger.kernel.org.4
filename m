Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5598D69529F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 22:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjBMVD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 16:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjBMVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 16:03:42 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AFD1ADE5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:41 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id c3-20020a170903234300b0019a94475927so3482179plh.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 13:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrN9jlWUGKebcMV0yhiCKjFphcO4anlDt9wV3VUtSLs=;
        b=jGU4lA8/hoEqIDLvQcR9p4fzHotKwBmrSvnF6Wow0R1HGQvNAaoEO1bMcHJHg/ge/G
         0Dg6FgengoCE+KVeRUjumTtZBJET+HTRwvM1oe29kGguaC81c9eSVb4eEFZN7bjwEj7W
         x3BgTlUqJo7pFoUOCvj/uuAZju8B4HaSGiad6kqNvVHMgH/l/BnnLj2zwDGk56mMY7w6
         +1iitZ1AJ2d+QkUVeqaO1oGEWfiLDMi3KajzG7y44b68gO5UzHzmt/IP2VWuV4JlVy9o
         FtAmUBaUaKQLJT9i56zUDjV50OWclWQBdZDisY6qkIYmi6bj8YMKtM6AA5UnUNyD2nYm
         uz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrN9jlWUGKebcMV0yhiCKjFphcO4anlDt9wV3VUtSLs=;
        b=8N9Y1IYTLI77gJRDF7Q/SScy6TY10f6i13Hr/EINkAx6BGgx1Z3m7yPTyeFm+zMAtp
         xrQ5YjK8eegPtguWhR60SCbQmsCCsdp6JiRW7dvlwarR+ViIqkl+mgivI0dKoE6TYA9l
         PeiUsPGeFmV0tNKpEnknMY4tKpZavtsF5tnpl/0bYOsEYeWpbiK7h+n7Z/451BHsfBA+
         /aoma2Ixdofmdp1BkoucRjDZ8nLCx98D+lcMxUVOv0Lk0IXwNPTeJIbMkmOP4131IpE+
         FJlvEnCbAcixKzAIWW4UaECh+5hA9XKp+8I4IHRgFyxamST7e+j/d2CsQ1gNmFhFWE2B
         +ZhQ==
X-Gm-Message-State: AO0yUKUrvNBjkNhLfnAdYIUPm0XbNAq4paQormkpqj74auVRZyRgwCT4
        k9sBMZgmWoj5RY793wYFAwG09H1bpc2j21Q=
X-Google-Smtp-Source: AK7set+fIZPdMnmqrLDxEeV303sJ8KLR7tYv16tUjdhla8rqMw8CnQM55yRxFm/Zin2t6D5s0G6MgPEgavkoAT8=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:90b:1483:b0:233:e9c9:67f with SMTP
 id js3-20020a17090b148300b00233e9c9067fmr1318318pjb.9.1676322220898; Mon, 13
 Feb 2023 13:03:40 -0800 (PST)
Date:   Mon, 13 Feb 2023 16:03:16 -0500
In-Reply-To: <20230213210319.1075872-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230213210319.1075872-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213210319.1075872-6-zalbassam@google.com>
Subject: [PATCH v3 5/8] perf: pmuv3: Change GENMASK to GENMASK_ULL
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GENMASK macro uses "unsigned long" (32-bit wide on arm and 64-bit
on arm64), This causes build issues when enabling PMUv3 on arm as
it tries to access bits > 31. This patch switches the GENMASK to
GENMASK_ULL, which uses "unsigned long long" (64-bit on both arm
and arm64).

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmuv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index b3683fdf8d0b9..dc8b8c8f1b3ed 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -489,7 +489,7 @@ static bool armv8pmu_event_needs_bias(struct perf_event *event)
 static u64 armv8pmu_bias_long_counter(struct perf_event *event, u64 value)
 {
 	if (armv8pmu_event_needs_bias(event))
-		value |= GENMASK(63, 32);
+		value |= GENMASK_ULL(63, 32);
 
 	return value;
 }
@@ -497,7 +497,7 @@ static u64 armv8pmu_bias_long_counter(struct perf_event *event, u64 value)
 static u64 armv8pmu_unbias_long_counter(struct perf_event *event, u64 value)
 {
 	if (armv8pmu_event_needs_bias(event))
-		value &= ~GENMASK(63, 32);
+		value &= ~GENMASK_ULL(63, 32);
 
 	return value;
 }
-- 
2.39.1.581.gbfd45094c4-goog

