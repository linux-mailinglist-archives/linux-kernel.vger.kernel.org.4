Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C86B71F4C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjFAVcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjFAVcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F6184;
        Thu,  1 Jun 2023 14:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F45164A01;
        Thu,  1 Jun 2023 21:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4923C433EF;
        Thu,  1 Jun 2023 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685655171;
        bh=g2rzy9p5nDkRT5WQ+jqTex7ivDzoyB3d1o/6rkyQ008=;
        h=From:To:Cc:Subject:Date:From;
        b=Qt2KlGyjZVky0lAKv82opTBW9mUDkM0Vd5xFaNjCWso1aWryPa/Nb4exeTSfkSDTH
         GW1Jw1c0j3TeKqjmlsh5ccslCVjDMlnzCLX2YBzVnoUIrD3+viiRt7LloUH63oM/+/
         18jNbCe4745xU19oWfP0BkDw5RXimB4jgzkd6ZMCBVPRhzRkvK9Gi+rIdUIxutt8iZ
         CvncHntkYE6bnLHhCULprPYzhr46zG/GQxwDU80HRnFS7ckLmzC4p2Kr5qMj4fwwtO
         LZ0VUlvFlDY9sacDCiCIvMJtqjyF/pCYOCsbnF8wzC0ahpWlktBeRX7mTgWfJxdaDE
         fsxzgrF0KAnLQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Lukasz Luba <lukasz.luba@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powercap: intel_rapl: fix CONFIG_IOSF_MBI dependency
Date:   Thu,  1 Jun 2023 23:32:41 +0200
Message-Id: <20230601213246.3271412-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When the intel_rapl driver is built-in, but iosf_mbi is a loadable module,
the kernel fails to link:

x86_64-linux-ld: vmlinux.o: in function `set_floor_freq_atom':
intel_rapl_common.c:(.text+0x2dac9b8): undefined reference to `iosf_mbi_write'
x86_64-linux-ld: intel_rapl_common.c:(.text+0x2daca66): undefined reference to `iosf_mbi_read'

The driver can work with iosf_mbi completely disabled, so add a dependency
that still allows this configuration, but otherwise forces it to not be
built-in when iosf_mbi is a loadable module.

Fixes: 9eef7f9da928c ("powercap: intel_rapl: Introduce RAPL TPMI interface driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/powercap/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index e71399804c143..21ad50b22d6b9 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -36,6 +36,7 @@ config INTEL_RAPL
 config INTEL_RAPL_TPMI
 	tristate "Intel RAPL Support via TPMI Interface"
 	depends on X86
+	depends on IOSF_MBI || IOSF_MBI=n
 	depends on INTEL_TPMI
 	select INTEL_RAPL_CORE
 	help
-- 
2.39.2

