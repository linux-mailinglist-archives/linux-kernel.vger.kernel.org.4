Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A76FF1EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 14:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbjEKMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 08:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237233AbjEKMxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 08:53:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25412106;
        Thu, 11 May 2023 05:53:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D27181FE91;
        Thu, 11 May 2023 12:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683809607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=62ALVCH5ZevkIHeaTUvt0zHjnJ7Is2/sjOVWpC5SGqQ=;
        b=gtO0bURAAmLSMXELEolZprS8f5jLRq8u9m5BtTDFG9Ppbih92HvAJDtnVmcRcebCLtflZK
        d6ydqx3qMsm7QwSqFwiszwrNX00eeNVfjtD8HGmjUvO9GhGg3DfQp6XSp0WuIDSMHFLDtp
        ws3waSrkF6q3ZAhFa1ZRo8k1/MwLowk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BE9C138FA;
        Thu, 11 May 2023 12:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id orjKG0flXGT3EgAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Thu, 11 May 2023 12:53:27 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     rafael@kernel.org, kevin@kevinlocke.name
Cc:     viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] ACPI: cpufreq: Prevent a warning when another frequency driver is loaded
Date:   Thu, 11 May 2023 14:53:12 +0200
Message-Id: <20230511125312.24207-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to use platform devices to load ACPI PPC and PCC
drivers caused that a misleading warning is reported when a respective
module cannot be loaded because another CPU frequency driver is already
registered:

kernel: acpi-cpufreq: probe of acpi-cpufreq failed with error -17

Address it by changing the return code in acpi-cpufreq and pcc-cpufreq
for this case from -EEXIST to -ENODEV which silences the warning in
call_driver_probe().

The change has also a benefit for users of init_module() as this return
code is propagated out from the syscall. The previous -EEXIST code made
the callers, such as kmod, wrongly believe that the module was already
loaded instead of that it failed to load.

Fixes: 691a63712347 ("ACPI: cpufreq: Use platform devices to load ACPI PPC and PCC drivers")
Reported-by: Kevin Locke <kevin@kevinlocke.name>
Link: https://lore.kernel.org/lkml/ZFreh8SDMX67EaB6@kevinlocke.name/
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 drivers/cpufreq/pcc-cpufreq.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 29904395e95f..b2f05d27167e 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -975,7 +975,7 @@ static int __init acpi_cpufreq_probe(struct platform_device *pdev)
 
 	/* don't keep reloading if cpufreq_driver exists */
 	if (cpufreq_get_current_driver())
-		return -EEXIST;
+		return -ENODEV;
 
 	pr_debug("%s\n", __func__);
 
diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index 1d2cfea9858a..73efbcf5513b 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -583,7 +583,7 @@ static int __init pcc_cpufreq_probe(struct platform_device *pdev)
 
 	/* Skip initialization if another cpufreq driver is there. */
 	if (cpufreq_get_current_driver())
-		return -EEXIST;
+		return -ENODEV;
 
 	if (acpi_disabled)
 		return -ENODEV;
-- 
2.35.3

