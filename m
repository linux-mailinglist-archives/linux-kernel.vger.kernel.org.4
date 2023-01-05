Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA51865E75F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbjAEJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjAEJIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:08:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D55114028
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:08:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCE07618DC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 09:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A282C433EF;
        Thu,  5 Jan 2023 09:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672909720;
        bh=dC2abtwgmwdN1tfArHQUKSGHFcouBA0RhxdxCoHf14o=;
        h=From:To:Cc:Subject:Date:From;
        b=o21dzTZ8EJP4ZuoTkTP617ILWOb9XMeQlZNs8yWVhxbzasyhgB+0x1FNEmdnaqgU/
         KvohIPPBA1YXYZf+H24bytpa6uOxCsuHXr2m5nH/9V6iZ3biojC+ZseY82OiT7RJ32
         87FCXPAGclmnok+JmMBJ6FHmDGI6jCtlx9K1dIHlezT8iekr5KT6u8QECfYAj2cNcH
         PD05JJ6Fbxk+KPVo2yQHMAbKuV970X5dBgTflH0JYxIWcpDxUztBYGnt/xpcTBi4yv
         lOJRLj+OcFT0mQhEFetAaXTj9dexmddS9MMdH8LGMfGipIn015AqHkznBBnxEY+NPu
         oJrNycyIXhoIw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pDMEn-00Gx2C-Tn;
        Thu, 05 Jan 2023 09:08:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Hector Martin <marcan@marcan.st>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [PATCH] firmware/psci: Don't register with debugfs if PSCI isn't available
Date:   Thu,  5 Jan 2023 09:08:34 +0000
Message-Id: <20230105090834.630238-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, marcan@marcan.st, dmitry.baryshkov@linaro.org, broonie@kernel.org, ulf.hansson@linaro.org, arnd@arndb.de, mark.rutland@arm.com, lpieralisi@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to popular belief, PSCI is not a universal property of an
ARM/arm64 system. There is a garden variety of systems out there
that don't (or even cannot) implement it.

I'm the first one deplore such a situation, but hey...

On such systems, a "cat /sys/kernel/debug/psci" results in
fireworks, as no invocation callback is registered.

Check for the invoke_psci_fn and psci_ops.get_version pointers
before registering with the debugfs subsystem, avoiding the
issue altogether.

Fixes: 3137f2e60098 ("firmware/psci: Add debugfs support to ease debugging")
Reported-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
---
 drivers/firmware/psci/psci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e7bcfca4159f..447ee4ea5c90 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -440,6 +440,9 @@ static const struct file_operations psci_debugfs_ops = {
 
 static int __init psci_debugfs_init(void)
 {
+	if (!invoke_psci_fn || !psci_ops.get_version)
+		return 0;
+
 	return PTR_ERR_OR_ZERO(debugfs_create_file("psci", 0444, NULL, NULL,
 						   &psci_debugfs_ops));
 }
-- 
2.34.1

