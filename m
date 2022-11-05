Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4B61DC98
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 18:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiKERkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKERkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 13:40:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBB1C938;
        Sat,  5 Nov 2022 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667670011; x=1699206011;
  h=from:to:cc:subject:date:message-id;
  bh=YNstcQSEkgMBc3Az2kOerrMpu3CRH4Immut06G88wYs=;
  b=PtTCtXZ8oXDk6ikzs6KvqugGL3cGNR3SgsIQyJd9v3w4YmskIwmDYWLD
   cOm+C0muQk6/mtx9ucYmS/IdXUEpRNOGqWgjjAa5FsqOytlm5r6fX8AHp
   kVH+D8hqcjMZ3XXIGqpXTF9BxkeiRFk4XcvXU622m4d3lf99ooiA/7zwe
   QmqRx+dINADDlhIf29EKrhBMWuVp9ghJSsR0oZb6wVaWsSe++H3xWzY+i
   95OsBygpEqkf38YagIm4aE5RHPACvh+QdT03r0Rrex5cOcFGmvrVDfZJ0
   KntvFb2rw3dug9rXekkQBa6Olw1pIW313DObA21blaNWR5rSyosmE8LMG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="297672765"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="297672765"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2022 10:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10522"; a="666729778"
X-IronPort-AV: E=Sophos;i="5.96,140,1665471600"; 
   d="scan'208";a="666729778"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2022 10:40:09 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] cpuidle: ladder: Fix bogus comparison between s64 and u64
Date:   Sun,  6 Nov 2022 01:42:23 +0800
Message-Id: <20221105174225.28673-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ladder_device_state.threshold.promotion_time_ns/demotion_time_ns
are u64 type.

In ladder_select_state(), variable 'last_residency', as calculated by

last_residency = dev->last_residency_ns - drv->states[last_idx].exit_latency_ns

are s64 type, and it can be negative value.

When this happens, comparing between 'last_residency' and
'promotion_time_ns/demotion_time_ns' become bogus. As a result, the
ladder governor promotes or stays with current state errornously.

          <idle>-0       [001] d..1.   151.893396: ladder_select_state: last_idx 7, last_residency -373033
          <idle>-0       [001] d..1.   151.893399: ladder_select_state:    dev->last_residency_ns 106967, drv->states[last_idx].exit_latency_ns 480000
          <idle>-0       [001] d..1.   151.893402: ladder_select_state:    promote, last_state->threshold.promotion_time_ns 480000
          <idle>-0       [001] d..1.   151.893404: ladder_select_state:    ---> new state 7
          <idle>-0       [001] d..1.   151.893465: ladder_select_state: last_idx 7, last_residency -463800
          <idle>-0       [001] d..1.   151.893467: ladder_select_state:    dev->last_residency_ns 16200, drv->states[last_idx].exit_latency_ns 480000
          <idle>-0       [001] d..1.   151.893468: ladder_select_state:    promote, last_state->threshold.promotion_time_ns 480000
          <idle>-0       [001] dn.1.   151.893470: ladder_select_state:    ---> new state 8

Given that promotion_time_ns/demotion_time_ns are initialized with
cpuidle_state.exit_latency_ns, which is s64 type, and they are used to
compare with 'last_residency', which is also s64 type, there is no
reason to use u64 for promotion_time_ns/demotion_time_ns.

With this patch,
          <idle>-0       [001] d..1.   523.578531: ladder_select_state: last_idx 8, last_residency -879453
          <idle>-0       [001] d..1.   523.578531: ladder_select_state:    dev->last_residency_ns 10547, drv->states[last_idx].exit_latency_ns 890000
          <idle>-0       [001] d..1.   523.578532: ladder_select_state:    demote , last_state->threshold.demotion_time_ns 890000
          <idle>-0       [001] d..1.   523.578532: ladder_select_state:    ---> new state 7
          <idle>-0       [001] d..1.   523.580220: ladder_select_state: last_idx 7, last_residency -169629
          <idle>-0       [001] d..1.   523.580221: ladder_select_state:    dev->last_residency_ns 310371, drv->states[last_idx].exit_latency_ns 480000
          <idle>-0       [001] d..1.   523.580221: ladder_select_state:    demote , last_state->threshold.demotion_time_ns 480000
          <idle>-0       [001] d..1.   523.580222: ladder_select_state:    ---> new state 6

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/cpuidle/governors/ladder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 8e9058c4ea63..fb61118aef37 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -27,8 +27,8 @@ struct ladder_device_state {
 	struct {
 		u32 promotion_count;
 		u32 demotion_count;
-		u64 promotion_time_ns;
-		u64 demotion_time_ns;
+		s64 promotion_time_ns;
+		s64 demotion_time_ns;
 	} threshold;
 	struct {
 		int promotion_count;
-- 
2.25.1

