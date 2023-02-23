Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E416A009C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 02:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjBWBbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 20:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjBWBbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 20:31:23 -0500
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78983D90D;
        Wed, 22 Feb 2023 17:31:21 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3C56D4214D;
        Thu, 23 Feb 2023 01:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677115879;
        bh=d/ifL75wKQnZuQURhIP2TmmZmuFYuchbACzMuBuy/+Y=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=X4A6RT/9QXidUEGAMn6bLMVrt8pEKCkBe/PMtYs7JVaVnSV3HQp3umw5H8/vJbavU
         B/jsp08QMnfMh65nr1H+RYcEEUwCDyRhzPeOqvb+dSVvFqXXr3vtJKQ4zL4P4/higb
         VPfKFHO0Jyt4S1CTosWfAycCpdr5BrR0WJXguxTAEg4YOH2C6QDHcywAxFe90OFbOo
         YlNqxQp8LrARKJGVBAMmTCx4Yp+14smQPf8+4tBWX6kX8ivd9W/3RUjcdsOqXxGGiJ
         j/hPmovsdJsRdoHVuGaIO1fGyZrwNH3Rp9DO90DGW6R1+w0Ds4Fr8KL1kzySx/38U2
         DVhd1fd+IS2gg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ray.huang@amd.com
Cc:     mario.limonciello@amd.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: amd-pstate: Let user know amd-pstate is disabled
Date:   Thu, 23 Feb 2023 09:30:32 +0800
Message-Id: <20230223013032.2011601-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 202e683df37c ("cpufreq: amd-pstate: add amd-pstate driver
parameter for mode selection") changed the driver to be disabled by
default, and this can suprise users.

Let users know what happened so they can decide what to do next.

BugLink: https://bugs.launchpad.net/bugs/2006942
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 45c88894fd8e..305f73f657ed 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
 	 * with amd_pstate=passive or other modes in kernel command line
 	 */
 	if (cppc_state == AMD_PSTATE_DISABLE) {
-		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
+		pr_info("amd_pstate is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
 	}
 
-- 
2.34.1

