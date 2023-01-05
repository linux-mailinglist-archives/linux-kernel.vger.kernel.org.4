Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4910565EF4F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjAEOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjAEOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:52:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 772C0E50;
        Thu,  5 Jan 2023 06:52:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A92A16F2;
        Thu,  5 Jan 2023 06:53:01 -0800 (PST)
Received: from e126311.arm.com (unknown [10.57.76.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7FCB3F71A;
        Thu,  5 Jan 2023 06:52:17 -0800 (PST)
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] cpuidle: teo: Optionally skip polling states in teo_find_shallower_state()
Date:   Thu,  5 Jan 2023 14:51:58 +0000
Message-Id: <20230105145159.1089531-2-kajetan.puchalski@arm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
References: <20230105145159.1089531-1-kajetan.puchalski@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a no_poll flag to teo_find_shallower_state() that will let the
function optionally not consider polling states.
This allows the caller to guard against the function inadvertently
resulting in TEO putting the CPU in a polling state when that
behaviour is undesirable.

Signed-off-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
---
 drivers/cpuidle/governors/teo.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index d9262db79cae..e2864474a98d 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -258,15 +258,17 @@ static s64 teo_middle_of_bin(int idx, struct cpuidle_driver *drv)
  * @dev: Target CPU.
  * @state_idx: Index of the capping idle state.
  * @duration_ns: Idle duration value to match.
+ * @no_poll: Don't consider polling states.
  */
 static int teo_find_shallower_state(struct cpuidle_driver *drv,
 				    struct cpuidle_device *dev, int state_idx,
-				    s64 duration_ns)
+				    s64 duration_ns, bool no_poll)
 {
 	int i;
 
 	for (i = state_idx - 1; i >= 0; i--) {
-		if (dev->states_usage[i].disable)
+		if (dev->states_usage[i].disable ||
+				(no_poll && drv->states[i].flags & CPUIDLE_FLAG_POLLING))
 			continue;
 
 		state_idx = i;
@@ -469,7 +471,7 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		if (idx > idx0 &&
 		    drv->states[idx].target_residency_ns > delta_tick)
-			idx = teo_find_shallower_state(drv, dev, idx, delta_tick);
+			idx = teo_find_shallower_state(drv, dev, idx, delta_tick, false);
 	}
 
 	return idx;
-- 
2.37.1

