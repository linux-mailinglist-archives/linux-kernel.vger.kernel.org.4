Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E45706A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjEQNix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjEQNiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:38:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069975FD0;
        Wed, 17 May 2023 06:38:37 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51f6461af24so501007a12.2;
        Wed, 17 May 2023 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684330717; x=1686922717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k8OvYgKD4CrfKg2DiZcLfhOHusqLyEctdoSrJ/WtXzM=;
        b=KEh+YWam1KnFY/K2bIyPqm3IYPMudMHDi0ZJ2katvPPvkwzo5ZIcGpMT2/VEfLz1RC
         gO9WrGrvTJvtXCTkY9hteSpAgWSDLUqfnBp6JsHIKeoRfrzCyZiE7s7B3dgCMXsH9T8g
         C/1EA3HXeVV5kUxXtsd9cCeO2fbVf5mCm1Th9Ky40uzUd0M7doxtm8kc82KOSxdCQ8QM
         I8PNXm2+bJKmOrQFC0m0ehLurGIbxWuHl4sL10ORFdrTAoK5YDXH5Jk+ZCcsXUJJ7ZK+
         JOFYm9FR8LMw4hPTjblE2pF4BphqExQ0C082VYdrqCuH/6n/3gKPx4BVdeXeNbyiCm71
         STxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684330717; x=1686922717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k8OvYgKD4CrfKg2DiZcLfhOHusqLyEctdoSrJ/WtXzM=;
        b=g4PtMMsDMc+PXH6aUIvb2wHl2noEi7eJ9oNzHKZcn7vgSaKMLn4HBUVnx4sBst8nVn
         kNudN3+zlm0pLv5wgAWH5qk/Lk9upMFEFUc3jK4uA/g4KSA7bF+fZXDzDDNt+UIbABPV
         tjvZKo/VtUMENmUD88ZvOE5vDABjT7JfrS4QWNFoW2yoetQ/n93l7DP+W/welhu97/b4
         7YfJUHy+F8sbvFLQvPTJfRIgfabRu1qf57JgZ0Hg21Ocb9X/A/8Jo11FVBMkRJ0f2dOV
         uSW1bVZLrZTFb0tuF1SAjTpQOWkRd1PZleakG1LQa8x+7/YDxQp59A+M0lYa4gXOMEoS
         w88A==
X-Gm-Message-State: AC+VfDzqNKkTC8zvzh83dgZBlevX+93PvRILzCksAd3u5+K+LKMZlFdu
        W3A59u0Nz3MWFR5L89GdWYk=
X-Google-Smtp-Source: ACHHUZ53ktGCJGR3vp/YQiRZuOPCvz7SdKay6uIQaBpaqAXvZtvtpSppG6747/Sr7TyeOCMNUjHjeg==
X-Received: by 2002:a05:6a20:3d82:b0:104:2200:8949 with SMTP id s2-20020a056a203d8200b0010422008949mr27572883pzi.56.1684330717016;
        Wed, 17 May 2023 06:38:37 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id fe25-20020a056a002f1900b0062dfe944c61sm15043509pfb.218.2023.05.17.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 06:38:36 -0700 (PDT)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg when using guest PEBS
Date:   Wed, 17 May 2023 21:38:08 +0800
Message-Id: <20230517133808.67885-1-likexu@tencent.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

After commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
PEBS_DATA_CFG"), the cpuc->pebs_data_cfg may save some bits that are not
supported by real hardware, such as PEBS_UPDATE_DS_SW. This would cause
the VMX hardware MSR switching mechanism to save/restore invalid values
for PEBS_DATA_CFG MSR, thus crashing the host when PEBS is used for guest.
Fix it by using the active host value from cpuc->active_pebs_data_cfg.

Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Like Xu <likexu@tencent.com>
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 070cc4ef2672..89b9c1cebb61 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4074,7 +4074,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 	if (x86_pmu.intel_cap.pebs_baseline) {
 		arr[(*nr)++] = (struct perf_guest_switch_msr){
 			.msr = MSR_PEBS_DATA_CFG,
-			.host = cpuc->pebs_data_cfg,
+			.host = cpuc->active_pebs_data_cfg,
 			.guest = kvm_pmu->pebs_data_cfg,
 		};
 	}
-- 
2.40.1

