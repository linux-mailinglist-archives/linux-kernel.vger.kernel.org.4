Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140776CDAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjC2Ngi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjC2Ngg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:36:36 -0400
Received: from out-46.mta0.migadu.com (out-46.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B2549DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:36:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680096990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UiPBpxfgqtblG7e87/gO/rTDIyusVpWOK3LN9PbGo4M=;
        b=eOOy+X26B7Q/Qcfu70uyttKgSCXxeLseZzn7JN7s8AO4yC9+Uo7gov+4GrGwUSCBsibb0A
        XWMtcwpFIykKphDfIpGJGTlk09NJHo6tok2qWscH1ZBlQq7z+ou4VeqPnGMdwUXQVUS5Oe
        FOWa45iFSfbigpVe3u5fYpwqWJ+THzo=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rafael@kernel.org, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] cpufreq: Fix policy->freq_table is NULL in __cpufreq_driver_target()
Date:   Wed, 29 Mar 2023 21:36:00 +0800
Message-Id: <20230329133600.908723-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__resolve_freq() may be return target_freq if policy->freq_table is
NULL. In this case, it should return -EINVAL before __target_index().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c0e5be0fe2d6..308a3df1a940 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2299,7 +2299,7 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 		return cpufreq_driver->target(policy, target_freq, relation);
 	}
 
-	if (!cpufreq_driver->target_index)
+	if (!cpufreq_driver->target_index || !policy->freq_table)
 		return -EINVAL;
 
 	return __target_index(policy, policy->cached_resolved_idx);
-- 
2.25.1

