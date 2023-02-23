Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A209C6A0320
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbjBWHEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjBWHEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:04:05 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05A84AFE9;
        Wed, 22 Feb 2023 23:03:48 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1CC6B3F116;
        Thu, 23 Feb 2023 07:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677135827;
        bh=CcSI32gZ7c8S1OzBEvrF82hTekSR867LXozzHErLs6A=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=L4BExEmNk2RJDQrEB+V+MfwoSGnpouK0snNESz7nMrwsaL5QBVo8j1c72eRpu3vxj
         nxt6awngHrHP4dZfjLxKYgtUuMbY511t+gWMI3sO6qdGpsY2BXPETS5d5L0eTM4i8b
         n6vUGHCX6kNX0vg7FKGJf4S/lnR6YmnNxPdCokMY58FVViSN4XGps/hqi60ZbWvxjM
         2yHE/a3kWM/i6G/jQhooA8lfAFcDhSDXVRY3CHfZ/6PNuPogfuPhk/YEe/XlZ1oDx6
         G6z1LSQWKqvy9+qB5hFmH5YS5nIcCvJyipzcFnpQFMiqbcFjVNG0kPJ7/Sg+4bdrzh
         4H/ey04Lyd6PA==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     ray.huang@amd.com
Cc:     mario.limonciello@amd.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: amd-pstate: Let user know amd-pstate is disabled
Date:   Thu, 23 Feb 2023 15:02:52 +0800
Message-Id: <20230223070252.2029174-1-kai.heng.feng@canonical.com>
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
default, and this can surprise users.

Let users know what happened so they can decide what to do next.

Link: https://bugs.launchpad.net/bugs/2006942
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Remove redundancy in pr_info().
 - Fix spelling and URL tag.

 drivers/cpufreq/amd-pstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 45c88894fd8e..f965f54f7ae7 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1263,7 +1263,7 @@ static int __init amd_pstate_init(void)
 	 * with amd_pstate=passive or other modes in kernel command line
 	 */
 	if (cppc_state == AMD_PSTATE_DISABLE) {
-		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
+		pr_info("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
 	}
 
-- 
2.34.1

