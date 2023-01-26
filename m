Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6C67D6AB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjAZUpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjAZUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:45:02 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89261744A1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:45:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i17-20020a25bc11000000b007b59a5b74aaso3123232ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tR+9e0WH8ejfT5bQyMqYGVgHaYV65JzCXZXsv3/vdaE=;
        b=sBf6nSf9W+yg3jl9ikNbQCUJZLO/WPlZKu2y4EiVKKHALKTncjVIKZC02SWuWSNETc
         XuoE1whnOWClQf6umgz02GeGah23sex7PlInifYrLbTjjMCPHzjJIBT3ymT3wAc1vbYH
         BCqk4JZWiJNnnBgb6HO+ynmd+qkT7n1tPD0PZSkRXo6Cl9AQle9UVEXQdRW4rgwjIAmP
         VSFrR5lLVDeDKkispgnL16j4J2m9pPCoeBcrFV+catr9AAF/lyMxldG8a5qFtmxed6t4
         iKhuGXj7NAXNGVI9+VDG9pGvK8MHnHHoCP8dfW+IyglTyrsCc/pB+vXj6YAO1QNKuUm8
         yv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tR+9e0WH8ejfT5bQyMqYGVgHaYV65JzCXZXsv3/vdaE=;
        b=7rT/ghrHDohy11KH5TUXXDzq2stlcuI/8gQ5rA9pbMKCvKhm6Dl7fStSB6vu829zPl
         GDpN56q0eKZB+fxXM2zyYWfTdLihc+RZzRcsraF3nRcO+SgoS2T7SVn0jGO+rbysvCCt
         0xGCI7gPL82HaWmssa3eBBWvM9Vk/SmLy5+K7ckbLzWH4CRvddnvPi0U4uOv+cndqU7S
         pzIENBEdSPZ5IKz67HsoMYl/iXR6M7+DzLl/UjQJm6slHF34Yuke2Whmju5L3Wtu2/o+
         J6CS2EkNjavzsq4dHRwTTVf96u1g7ctiBAIpDUBe/I+Ae1+RLaWT9An3RynwdTM4N38+
         Nf8A==
X-Gm-Message-State: AO0yUKXGZyZ2Sn7dnQShTJL6aeruRHySYdgYFyvNUOvzpAybEXMwVWwy
        g7wuInEcTShMfnitMm5kpgDqVft8OxFHZPk=
X-Google-Smtp-Source: AK7set/hsVwW2nMS3JQswecSr6rmsnIhyJiRn87by2p6kpGIzHO5WnDstl5QfvYOaOlZ2lyNCHAfN95tSsHwFt4=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a25:4148:0:b0:80b:7569:8227 with SMTP id
 o69-20020a254148000000b0080b75698227mr955575yba.282.1674765900796; Thu, 26
 Jan 2023 12:45:00 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:41 -0500
In-Reply-To: <20230126204444.2204061-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-6-zalbassam@google.com>
Subject: [PATCH 5/8] perf: pmuv3: Change GENMASK to GENMASK_ULL
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
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
---
 drivers/perf/arm_pmuv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index d7063dd52827..67d90c1d4bae 100644
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
2.39.0.246.g2a6d74b583-goog

