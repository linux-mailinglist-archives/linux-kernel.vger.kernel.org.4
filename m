Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14C96923BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjBJQzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjBJQzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27891167C
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:55:24 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id gn18-20020a17090ac79200b0022bef1f49c9so5196434pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676048124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2+p08AfrdrQMfpJn1ylcvtO2Ig9cnBH4qygeKLOxyr4=;
        b=SJJd0x95oNZ+eJQfXnvXcpugz/a/cJ+t9ikkLVEfVtRWYvweJlyL3WsO4eM7MJcg/c
         AvuIkRDYmJfWt6mBsXaQDLbUYUv3iGwzyNiSTYdCbjk5NTtwPRCibsiHvcZPRYnkKCNj
         4vFEqat3l1uNf6/MAVgldhCHeMCpAWjiqKddoQZ2bu07652Sv7UUo0O9PZ7XLU0YGlhH
         o8+55/RBTztktn9Vpf63AFfTrFUym6cc66WxvRBEQgxqBxunk42UE7pYxOTFK/lysFhk
         1s4Osm/IfUcqfAnVjhZii9KLaMfHR7HFObkNzRTMRYTPuqXC64V60/lqDTHenBHt6+kd
         GPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676048124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+p08AfrdrQMfpJn1ylcvtO2Ig9cnBH4qygeKLOxyr4=;
        b=hrdZh9QkqBAaMJMKTW0iaEi6YvX31OjU5czGeZjRNU8goqaMDn8dlGW8tWkELjElIR
         hw+b4shykxJP3HV8j38xnCIExNuVbKrhA7mXSdaHJepQWHIkdCikns/eDFeeFGEdul7H
         dIxPlaHZs+XhkAIwLISxlpFY1ZWMs6SObKDTcWuTHqfQSlq+Q9xL3YjTF3iLShL4yKLk
         POroG0m3x+fWc2zf1YoDLu2hb4HmsDBk3TsUeJeaMm66wrp2lG680FNKTHl2pknuSLpt
         8SUbbW0gHQFwMhFdAvPBmp1WqtJKQrAfLCLGcYSLw9JkWWAYzVFqbW05iUp9hXbL1rj+
         s/sQ==
X-Gm-Message-State: AO0yUKUk24kI2lKiFjYuGKDKJizaHvlbhxEZ9G0Io5wi8pUJWP/YIZXd
        B/v3Ap09Lome88B7TwODGFDhyME/APejrRo=
X-Google-Smtp-Source: AK7set/PQpe51rDPvh02XY2GdXIh+tKbGt2sc7iL1OsES4twfuke9JZKzmdezrhfCssa+/AlaHlxPxaE7ZVOG9U=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:ea0e:b0:196:64bf:ed7a with SMTP
 id s14-20020a170902ea0e00b0019664bfed7amr3779552plg.29.1676048124218; Fri, 10
 Feb 2023 08:55:24 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:54:57 -0500
In-Reply-To: <20230210165500.2292608-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230210165500.2292608-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210165500.2292608-6-zalbassam@google.com>
Subject: [PATCH v2 5/8] perf: pmuv3: Change GENMASK to GENMASK_ULL
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
Link: https://lore.kernel.org/r/20230126204444.2204061-6-zalbassam@google.com
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

