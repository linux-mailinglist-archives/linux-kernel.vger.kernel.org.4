Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1FB6C2A02
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjCUFre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCUFr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:47:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B82A152;
        Mon, 20 Mar 2023 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679377647; x=1710913647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lQJIJFxogi+f9wpwcy5bQR4Ve4cHujdBkxgNOyEbJ+I=;
  b=ALhnGtdEa53/UGguXkqfgG5XpK2Vg9Rt00t0TbY40LEJGyVzHoEfJVde
   +RskY9AAfe2W1ReG36HDiuYa8h1kzfE2wUzUTm2Qba7uQewXZgSIYzJ2o
   Lc3SakI7RT9DValajNWGTQewNrlYjlKdLGJVPWO70ME5iK2wTGEjMqXpu
   grRqG6vmq9+2wNpvPkxTcviJof4/FnhgG9gFM+4DebvW7iWvZgUEzxVvU
   zDYI6WmBAczzAYfW1XT9gf7TzSd1IorKDhq6MbkPaLDyGPU8p3x9vrlGA
   Qtq4iooJlr1yp4mnHY8RGU2sr437RHN9JWcFwOtmUR1O3cBH3nNlIXb4F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="336359303"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="336359303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="927271471"
X-IronPort-AV: E=Sophos;i="5.98,278,1673942400"; 
   d="scan'208";a="927271471"
Received: from zhouf-mobl.ccr.corp.intel.com (HELO rzhang1-DESK.intel.com) ([10.249.171.160])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 22:47:25 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] thermal/governors/step_wise: Adjust code logic to align with the comment
Date:   Tue, 21 Mar 2023 13:47:14 +0800
Message-Id: <20230321054714.76287-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321054714.76287-1-rui.zhang@intel.com>
References: <20230321054714.76287-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the algorithm of choosing the next target state in step_wise
governor, the code does the right thing but is implemented in a
way different from what the comment describes. And this hurts the code
readability.

As the logic in the comment is simpler, adjust the code logic to align
with the comment.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/gov_step_wise.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/gov_step_wise.c b/drivers/thermal/gov_step_wise.c
index 7a760b6a4279..318b38d04eb9 100644
--- a/drivers/thermal/gov_step_wise.c
+++ b/drivers/thermal/gov_step_wise.c
@@ -53,24 +53,16 @@ static unsigned long get_target_state(struct thermal_instance *instance,
 		return next_target;
 	}
 
-	switch (trend) {
-	case THERMAL_TREND_RAISING:
-		if (throttle) {
+	if (throttle) {
+		if (trend == THERMAL_TREND_RAISING)
 			next_target = clamp((cur_state + 1), instance->lower, instance->upper);
-		}
-		break;
-	case THERMAL_TREND_DROPPING:
-		if (cur_state <= instance->lower) {
-			if (!throttle)
+	} else {
+		if (trend == THERMAL_TREND_DROPPING) {
+			if (cur_state <= instance->lower)
 				next_target = THERMAL_NO_TARGET;
-		} else {
-			if (!throttle) {
+			else
 				next_target = clamp((cur_state - 1), instance->lower, instance->upper);
-			}
 		}
-		break;
-	default:
-		break;
 	}
 
 	return next_target;
-- 
2.25.1

