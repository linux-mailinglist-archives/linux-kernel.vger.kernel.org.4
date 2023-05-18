Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D3D707A41
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjERGZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjERGZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:25:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0098A198
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 23:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684391125; x=1715927125;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k2ASCXTUiR6CdVuxJ/NidGjmihaBal4ilojdkFQY0ZE=;
  b=oxPAtE7K8+MSrkQRy2VVnz1ldkCMODNmNKa9feuwU0g7mdY91A6VVrlA
   i1gjGOMiHv+zWqAvObItRjOtFrq5djDncP4Lo5ibsXklMxgL/wueayDrk
   nV4kX31TCAfo4HnYH2mCLnu418bsvJcosM9k/acj5+Y0jMZ1pwVqSgZRH
   WOAKE/YvJAw2Q5UubtoLTeFXdUKVlUYhVbvE5htXmkW8q1nPVchl3mxBW
   p9JgQowgplkLPWAegwBsejVFs0LtfDxeCC9IL+M0i8YNPk605lRx9n0Kz
   Xtk7JdKy5ZtGK6tuiBiCaKOQLVjExU0WYmXRSTQ/2NYQklMur8VEEv0YB
   w==;
X-IronPort-AV: E=Sophos;i="5.99,284,1677567600"; 
   d="scan'208";a="216039913"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2023 23:25:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 17 May 2023 23:25:23 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 17 May 2023 23:25:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ARM: at91: pm: fix imbalanced reference counter for ethernet devices
Date:   Thu, 18 May 2023 09:25:11 +0300
Message-ID: <20230518062511.2988500-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() function is returning a struct platform_device
object with the embedded struct device member's reference counter
incremented. This needs to be dropped when done with the platform device
returned by of_find_device_by_node().

at91_pm_eth_quirk_is_valid() calls of_find_device_by_node() on
suspend and resume path. On suspend it calls of_find_device_by_node() and
on resume and failure paths it drops the counter of
struct platform_device::dev.

In case ethernet device may not wakeup there is a put_device() on
at91_pm_eth_quirk_is_valid() which is wrong as it colides with
put_device() on resume path leading to the reference counter of struct
device embedded in struct platform_device to be messed, the following
stack trace to be displayed (after 5 consecutive suspend/resume cycles)
and the execution to hang:

WARNING: CPU: 0 PID: 378 at lib/refcount.c:25 0xc07ffc08
refcount_t: addition on 0; use-after-free.
Modules linked in:
CPU: 0 PID: 378 Comm: sh Not tainted 6.1.22-linux4microchip-2023.04-rc3+ #7
Hardware name: Microchip SAMA7
Function entered at [<c010c134>] from [<c010993c>]
Function entered at [<c010993c>] from [<c0823754>]
Function entered at [<c0823754>] from [<c01162ac>]
Function entered at [<c01162ac>] from [<c0116340>]
Function entered at [<c0116340>] from [<c07ffc08>]
Function entered at [<c07ffc08>] from [<c045fe88>]
Function entered at [<c045fe88>] from [<c046004c>]
Function entered at [<c046004c>] from [<c0141e94>]
Function entered at [<c0141e94>] from [<c0142448>]
Function entered at [<c0142448>] from [<c0140da8>]
Function entered at [<c0140da8>] from [<c023dba0>]
Function entered at [<c023dba0>] from [<c01d0700>]
Function entered at [<c01d0700>] from [<c01d092c>]
Function entered at [<c01d092c>] from [<c0100060>]
Exception stack(0xe0e81fa8 to 0xe0e81ff0)
1fa0:                   00000004 0057c668 00000001 0057c668 00000004 00000000
1fc0: 00000004 0057c668 b6ecaba0 00000004 b6f4c0e0 b6ecb15c 00000000 00000000
1fe0: 005456f0 beb3a788 b6dcfac4 b6e3bab8
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 378 at lib/refcount.c:28 0xc045fef4
refcount_t: underflow; use-after-free.
Modules linked in:
CPU: 0 PID: 378 Comm: sh Tainted: G        W          6.1.22-linux4microchip-2023.04-rc3+ #7
Hardware name: Microchip SAMA7
Function entered at [<c010c134>] from [<c010993c>]
Function entered at [<c010993c>] from [<c0823754>]
Function entered at [<c0823754>] from [<c01162ac>]
Function entered at [<c01162ac>] from [<c0116340>]
Function entered at [<c0116340>] from [<c045fef4>]
Function entered at [<c045fef4>] from [<c046004c>]
Function entered at [<c046004c>] from [<c0141e94>]
Function entered at [<c0141e94>] from [<c0142448>]
Function entered at [<c0142448>] from [<c0140da8>]
Function entered at [<c0140da8>] from [<c023dba0>]
Function entered at [<c023dba0>] from [<c01d0700>]
Function entered at [<c01d0700>] from [<c01d092c>]
Function entered at [<c01d092c>] from [<c0100060>]
Exception stack(0xe0e81fa8 to 0xe0e81ff0)
1fa0:                   00000004 0057c668 00000001 0057c668 00000004 00000000
1fc0: 00000004 0057c668 b6ecaba0 00000004 b6f4c0e0 b6ecb15c 00000000 00000000
1fe0: 005456f0 beb3a788 b6dcfac4 b6e3bab8
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 378 at lib/refcount.c:22 0xc07ffbf4
refcount_t: saturated; leaking memory.
Modules linked in:
CPU: 0 PID: 378 Comm: sh Tainted: G        W          6.1.22-linux4microchip-2023.04-rc3+ #7
Hardware name: Microchip SAMA7
Function entered at [<c010c134>] from [<c010993c>]
Function entered at [<c010993c>] from [<c0823754>]
Function entered at [<c0823754>] from [<c01162ac>]
Function entered at [<c01162ac>] from [<c0116340>]
Function entered at [<c0116340>] from [<c07ffbf4>]
Function entered at [<c07ffbf4>] from [<c045eaa0>]
Function entered at [<c045eaa0>] from [<c045fcc4>]
Function entered at [<c045fcc4>] from [<c045fee4>]
Function entered at [<c045fee4>] from [<c046004c>]
Function entered at [<c046004c>] from [<c0141e94>]
Function entered at [<c0141e94>] from [<c0142448>]
Function entered at [<c0142448>] from [<c0140da8>]
Function entered at [<c0140da8>] from [<c023dba0>]
Function entered at [<c023dba0>] from [<c01d0700>]
Function entered at [<c01d0700>] from [<c01d092c>]
Function entered at [<c01d092c>] from [<c0100060>]
Exception stack(0xe0e81fa8 to 0xe0e81ff0)
1fa0:                   00000004 0057c668 00000001 0057c668 00000004 00000000
1fc0: 00000004 0057c668 b6ecaba0 00000004 b6f4c0e0 b6ecb15c 00000000 00000000
1fe0: 005456f0 beb3a788 b6dcfac4 b6e3bab8
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 378 at kernel/irq/chip.c:241 0xc014be2c
Modules linked in:
CPU: 0 PID: 378 Comm: sh Tainted: G        W          6.1.22-linux4microchip-2023.04-rc3+ #7
Hardware name: Microchip SAMA7
Function entered at [<c010c134>] from [<c010993c>]
Function entered at [<c010993c>] from [<c0823754>]
Function entered at [<c0823754>] from [<c01162ac>]
Function entered at [<c01162ac>] from [<c011637c>]
Function entered at [<c011637c>] from [<c014be2c>]
Function entered at [<c014be2c>] from [<c014f808>]
Function entered at [<c014f808>] from [<c0460050>]
Function entered at [<c0460050>] from [<c0141e94>]
Function entered at [<c0141e94>] from [<c0142448>]
Function entered at [<c0142448>] from [<c0140da8>]
Function entered at [<c0140da8>] from [<c023dba0>]
Function entered at [<c023dba0>] from [<c01d0700>]
Function entered at [<c01d0700>] from [<c01d092c>]
Function entered at [<c01d092c>] from [<c0100060>]
Exception stack(0xe0e81fa8 to 0xe0e81ff0)
1fa0:                   00000004 0057c668 00000001 0057c668 00000004 00000000
1fc0: 00000004 0057c668 b6ecaba0 00000004 b6f4c0e0 b6ecb15c 00000000 00000000
1fe0: 005456f0 beb3a788 b6dcfac4 b6e3bab8
---[ end trace 0000000000000000 ]---
at_xdmac e1200000.dma-controller: controller in mem2mem mode.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 378 at lib/kobject.c:634 0xc07ffbe8
kobject: '$���"����L��L��' (a3ba4c7d): is not initialized, yet kobject_get() is being called.
Modules linked in:
CPU: 0 PID: 378 Comm: sh Tainted: G        W          6.1.22-linux4microchip-2023.04-rc3+ #7
Hardware name: Microchip SAMA7
Function entered at [<c010c134>] from [<c010993c>]
Function entered at [<c010993c>] from [<c0823754>]
Function entered at [<c0823754>] from [<c01162ac>]
Function entered at [<c01162ac>] from [<c0116340>]
Function entered at [<c0116340>] from [<c07ffbe8>]
Function entered at [<c07ffbe8>] from [<c0460300>]
Function entered at [<c0460300>] from [<c0460634>]
Function entered at [<c0460634>] from [<c0141ed4>]
Function entered at [<c0141ed4>] from [<c0142448>]
Function entered at [<c0142448>] from [<c0140da8>]
Function entered at [<c0140da8>] from [<c023dba0>]
Function entered at [<c023dba0>] from [<c01d0700>]
Function entered at [<c01d0700>] from [<c01d092c>]
Function entered at [<c01d092c>] from [<c0100060>]
Exception stack(0xe0e81fa8 to 0xe0e81ff0)
1fa0:                   00000004 0057c668 00000001 0057c668 00000004 00000000
1fc0: 00000004 0057c668 b6ecaba0 00000004 b6f4c0e0 b6ecb15c 00000000 00000000
1fe0: 005456f0 beb3a788 b6dcfac4 b6e3bab8
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 378 at lib/kobject.c:728 0xc07ffd7c
kobject: '$���"����L��L��' (a3ba4c7d): is not initialized, yet kobject_put() is being called.
Modules linked in:
CPU: 0 PID: 378 Comm: sh Tainted: G        W          6.1.22-linux4microchip-2023.04-rc3+ #7
Hardware name: Microchip SAMA7
Function entered at [<c010c134>] from [<c010993c>]
Function entered at [<c010993c>] from [<c0823754>]
Function entered at [<c0823754>] from [<c01162ac>]
Function entered at [<c01162ac>] from [<c0116340>]
Function entered at [<c0116340>] from [<c07ffd7c>]
Function entered at [<c07ffd7c>] from [<c0460384>]
Function entered at [<c0460384>] from [<c0460634>]
Function entered at [<c0460634>] from [<c0141ed4>]
Function entered at [<c0141ed4>] from [<c0142448>]
Function entered at [<c0142448>] from [<c0140da8>]
Function entered at [<c0140da8>] from [<c023dba0>]
Function entered at [<c023dba0>] from [<c01d0700>]
Function entered at [<c01d0700>] from [<c01d092c>]
Function entered at [<c01d092c>] from [<c0100060>]
Exception stack(0xe0e81fa8 to 0xe0e81ff0)
1fa0:                   00000004 0057c668 00000001 0057c668 00000004 00000000
1fc0: 00000004 0057c668 b6ecaba0 00000004 b6f4c0e0 b6ecb15c 00000000 00000000
1fe0: 005456f0 beb3a788 b6dcfac4 b6e3bab8
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 378 at lib/kobject.c:634 0xc07ffbe8
kobject: '�Z����@Ą�?��8�H�Ĕ����UC�' (6407eb2a): is not initialized, yet kobject_get() is being called.
Modules linked in:
CPU: 0 PID: 378 Comm: sh Tainted: G        W          6.1.22-linux4microchip-2023.04-rc3+ #7
Hardware name: Microchip SAMA7
Function entered at [<c010c134>] from [<c010993c>]
Function entered at [<c010993c>] from [<c0823754>]
Function entered at [<c0823754>] from [<c01162ac>]
Function entered at [<c01162ac>] from [<c0116340>]
Function entered at [<c0116340>] from [<c07ffbe8>]
Function entered at [<c07ffbe8>] from [<c0460300>]
Function entered at [<c0460300>] from [<c0460634>]
Function entered at [<c0460634>] from [<c0141ed4>]
Function entered at [<c0141ed4>] from [<c0142448>]
Function entered at [<c0142448>] from [<c0140da8>]
Function entered at [<c0140da8>] from [<c023dba0>]
Function entered at [<c023dba0>] from [<c01d0700>]
Function entered at [<c01d0700>] from [<c01d092c>]
Function entered at [<c01d092c>] from [<c0100060>]
Exception stack(0xe0e81fa8 to 0xe0e81ff0)
1fa0:                   00000004 0057c668 00000001 0057c668 00000004 00000000
1fc0: 00000004 0057c668 b6ecaba0 00000004 b6f4c0e0 b6ecb15c 00000000 00000000
1fe0: 005456f0 beb3a788 b6dcfac4 b6e3bab8
---[ end trace 0000000000000000 ]---

Along with this the error path of at91_pm_config_quirks() had been also
adapted to decrement propertly the reference counter of struct device
embedded in struct platform_device.

Fixes: b7fc72c63399 ("ARM: at91: pm: add quirks for pm")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 60dc56d8acfb..437dd0352fd4 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -334,16 +334,14 @@ static bool at91_pm_eth_quirk_is_valid(struct at91_pm_quirk_eth *eth)
 		pdev = of_find_device_by_node(eth->np);
 		if (!pdev)
 			return false;
+		/* put_device(eth->dev) is called at the end of suspend. */
 		eth->dev = &pdev->dev;
 	}
 
 	/* No quirks if device isn't a wakeup source. */
-	if (!device_may_wakeup(eth->dev)) {
-		put_device(eth->dev);
+	if (!device_may_wakeup(eth->dev))
 		return false;
-	}
 
-	/* put_device(eth->dev) is called at the end of suspend. */
 	return true;
 }
 
@@ -439,14 +437,14 @@ static int at91_pm_config_quirks(bool suspend)
 				pr_err("AT91: PM: failed to enable %s clocks\n",
 				       j == AT91_PM_G_ETH ? "geth" : "eth");
 			}
-		} else {
-			/*
-			 * Release the reference to eth->dev taken in
-			 * at91_pm_eth_quirk_is_valid().
-			 */
-			put_device(eth->dev);
-			eth->dev = NULL;
 		}
+
+		/*
+		 * Release the reference to eth->dev taken in
+		 * at91_pm_eth_quirk_is_valid().
+		 */
+		put_device(eth->dev);
+		eth->dev = NULL;
 	}
 
 	return ret;
-- 
2.34.1

