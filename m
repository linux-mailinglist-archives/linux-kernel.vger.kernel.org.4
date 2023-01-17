Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB266E401
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 17:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjAQQrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 11:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjAQQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 11:46:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25212066;
        Tue, 17 Jan 2023 08:46:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78378614DA;
        Tue, 17 Jan 2023 16:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6C8C433EF;
        Tue, 17 Jan 2023 16:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673974006;
        bh=4k47jDc2oFC0wdumIOzrC/8rIFQaQpNNWF240dXPewQ=;
        h=From:To:Cc:Subject:Date:From;
        b=G+JxLMscqfqDGxvkLUAKHErzoZUmD19GL66RO2LYXES37GfVgXui834D9cdFkq95z
         V59EoR02h9jyLGxHDb0LgXDuYRaVMZfo2KXjHt1+IXTaJAvWdY7lhdVUYXwkwDHSi7
         2G/mQuUfDSE12yinusMwYEfX/yytfMKvFQWdMKyfMPZdzE2Go1XhszmDYO6/OT8spX
         pLlU8zLcdmlfT+HZCO9FGo9U36sB79RtWWWUQYY7j78Rrn605rQjUg/9FyBwDpRAeX
         D1yFukDMScIdxHjbI7B5rRWFI9hstJbmk/mewNw1pthVFkWdpqWEXQpqQFXmIOASAU
         xaSwIPApCjsTQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: mvebu: fix duplicate flags assignment
Date:   Tue, 17 Jan 2023 17:46:35 +0100
Message-Id: <20230117164642.1672784-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The added '.flags' value is sometimes ignored here because
it gets overwritten by another initialization:

drivers/cpuidle/cpuidle-mvebu-v7.c:24:33: error: initialized field overwritten [-Werror=override-init]
   24 | #define MVEBU_V7_FLAG_DEEP_IDLE 0x10000
      |                                 ^~~~~~~
drivers/cpuidle/cpuidle-mvebu-v7.c:69:43: note: in expansion of macro 'MVEBU_V7_FLAG_DEEP_IDLE'
   69 |                 .flags                  = MVEBU_V7_FLAG_DEEP_IDLE,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~
drivers/cpuidle/cpuidle-mvebu-v7.c:24:33: note: (near initialization for 'armadaxp_idle_driver.states[2].flags')
   24 | #define MVEBU_V7_FLAG_DEEP_IDLE 0x10000
      |                                 ^~~~~~~
drivers/cpuidle/cpuidle-mvebu-v7.c:69:43: note: in expansion of macro 'MVEBU_V7_FLAG_DEEP_IDLE'
   69 |                 .flags                  = MVEBU_V7_FLAG_DEEP_IDLE,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~
drivers/cpuidle/cpuidle-mvebu-v7.c:24:33: error: initialized field overwritten [-Werror=override-init]
   24 | #define MVEBU_V7_FLAG_DEEP_IDLE 0x10000
      |                                 ^~~~~~~
drivers/cpuidle/cpuidle-mvebu-v7.c:85:43: note: in expansion of macro 'MVEBU_V7_FLAG_DEEP_IDLE'
   85 |                 .flags                  = MVEBU_V7_FLAG_DEEP_IDLE,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~
drivers/cpuidle/cpuidle-mvebu-v7.c:24:33: note: (near initialization for 'armada370_idle_driver.states[1].flags')
   24 | #define MVEBU_V7_FLAG_DEEP_IDLE 0x10000
      |                                 ^~~~~~~
drivers/cpuidle/cpuidle-mvebu-v7.c:85:43: note: in expansion of macro 'MVEBU_V7_FLAG_DEEP_IDLE'
   85 |                 .flags                  = MVEBU_V7_FLAG_DEEP_IDLE,
      |                                           ^~~~~~~~~~~~~~~~~~~~~~~

Merge the two fields into one.

Fixes: 4ce40e9dbe83 ("cpuidle, armada: Push RCU-idle into driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 114bd09eebbf..563dba609b98 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -52,21 +52,20 @@ static struct cpuidle_driver armadaxp_idle_driver = {
 	.name			= "armada_xp_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 50,
 		.target_residency	= 1000,
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "MV CPU IDLE",
 		.desc			= "CPU power down",
 	},
 	.states[2]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 1000,
 		.power_usage		= 5,
 		.target_residency	= 10000,
-		.flags			= MVEBU_V7_FLAG_DEEP_IDLE,
+		.flags			= MVEBU_V7_FLAG_DEEP_IDLE | CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "MV CPU DEEP IDLE",
 		.desc			= "CPU and L2 Fabric power down",
 	},
@@ -77,12 +76,11 @@ static struct cpuidle_driver armada370_idle_driver = {
 	.name			= "armada_370_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 100,
 		.power_usage		= 5,
 		.target_residency	= 1000,
-		.flags			= MVEBU_V7_FLAG_DEEP_IDLE,
+		.flags			= MVEBU_V7_FLAG_DEEP_IDLE | CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "Deep Idle",
 		.desc			= "CPU and L2 Fabric power down",
 	},
@@ -93,11 +91,11 @@ static struct cpuidle_driver armada38x_idle_driver = {
 	.name			= "armada_38x_idle",
 	.states[0]		= ARM_CPUIDLE_WFI_STATE,
 	.states[1]		= {
-		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.enter			= mvebu_v7_enter_idle,
 		.exit_latency		= 10,
 		.power_usage		= 5,
 		.target_residency	= 100,
+		.flags			= CPUIDLE_FLAG_RCU_IDLE,
 		.name			= "Idle",
 		.desc			= "CPU and SCU power down",
 	},
-- 
2.39.0

