Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B234067E072
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbjA0JkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjA0Jj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:39:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719F3198;
        Fri, 27 Jan 2023 01:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05BB2619EE;
        Fri, 27 Jan 2023 09:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8303DC433D2;
        Fri, 27 Jan 2023 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674812394;
        bh=yz0DdgDxsvq7DxxUo6FE0Nv4JA5iq76tv3BvMGT3jP4=;
        h=From:To:Cc:Subject:Date:From;
        b=E7L9tdhfWI0FO5k6f7LNfeE00oHnJPOZkwXAF0V14ep1wzYOvTOAOm8SgorEfI7vW
         sp9Iv8+xX5G4TvmBV5PeA1Uo8N8CxpsagmY75hYz8mtEIylOyNW7wLgcZyADqmx3Lj
         j9b/tdjsaqHSs6KNaUclPUuViFujFEdRm/lp33TpKhSyMcafF812D3HdKo7nJNS1c1
         J9FSK4tW+HHd/69b29TIvLqwf3VHw07LnGq9ur6w+QpWT0KpygSeFgPc/IDTv3i3nd
         t9Dr/UPN8EK1jkF0Jorib0jHjPeIeFBa0nacQi7TwekTnVxk2OdENmMY9gAHXRf77S
         L6M7pF488j/XQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Naveen Krishna Chatradhi <NaveenKrishna.Chatradhi@amd.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd: pmc: add CONFIG_SERIO dependency
Date:   Fri, 27 Jan 2023 10:39:44 +0100
Message-Id: <20230127093950.2368575-1-arnd@kernel.org>
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

Using the serio subsystem now requires the code to be reachable:

x86_64-linux-ld: drivers/platform/x86/amd/pmc.o: in function `amd_pmc_suspend_handler':
pmc.c:(.text+0x86c): undefined reference to `serio_bus'

Add the usual dependency: as other users of serio use 'select'
rather than 'depends on', use the same here.

Fixes: 8e60615e8932 ("platform/x86/amd: pmc: Disable IRQ1 wakeup for RN/CZN")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
index a825af8126c8..2ce8cb2170df 100644
--- a/drivers/platform/x86/amd/Kconfig
+++ b/drivers/platform/x86/amd/Kconfig
@@ -8,6 +8,7 @@ source "drivers/platform/x86/amd/pmf/Kconfig"
 config AMD_PMC
 	tristate "AMD SoC PMC driver"
 	depends on ACPI && PCI && RTC_CLASS
+	select SERIO
 	help
 	  The driver provides support for AMD Power Management Controller
 	  primarily responsible for S2Idle transactions that are driven from
-- 
2.39.0

