Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740236AB11A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCEOvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCEOvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:51:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A248CA09;
        Sun,  5 Mar 2023 06:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678027871; x=1709563871;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cD/EguBBYe4p/5f5/+uGBNDmark0HjAfGh2ODakVOW8=;
  b=GXTGmd82BfrOmXNFIBYSb+FpCSYSD5XCUZ7cx1GLogTdj/C4Bm3bXJqq
   IwIg4odg23bMmctkDLy2XAWCXPpkC3Qw5PGRMjoJFVYMrcCurlXnO3M1u
   cJX20xaKso66Zx7GT9jOMYkw783OvJDE7sJ5ibbsM+KdJd+Bcwjm3R4GX
   WCV3aYEY2j+x0Scskt/DEYMUZ2QKJ57M4gmWJMZpTfYWxSs9Y5QCvdv/u
   GW9xy5+bFyQFL8z6U8vJ9Fuo4gIi/5grqH7AmLVcAdKG3MGMI1Ai9XNd5
   3msxzjoVhBCWz2MVgKf8br63805JdBmHib+8gd4PH7hJnk1kSu4yzr7CQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,235,1673938800"; 
   d="scan'208";a="140336628"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Mar 2023 07:51:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 5 Mar 2023 07:51:09 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Sun, 5 Mar 2023 07:51:05 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-serial@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <deller@gmx.de>, <geert+renesas@glider.be>,
        <matthew.gerlach@linux.intel.com>, <phil.edworthy@renesas.com>,
        <ilpo.jarvinen@linux.intel.com>, <UNGLinuxDriver@microchip.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 tty-next] serial: 8250_pci1xxxx: Disable SERIAL_8250_PCI1XXXX config by default
Date:   Sun, 5 Mar 2023 20:21:24 +0530
Message-ID: <20230305145124.13444-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32bb477fa7bf ("serial: 8250_pci1xxxx: Add driver for quad-uart
support") made the SERIAL_8250_PCI1XXXX driver enabled when SERIAL_8250
is enabled, disable it as this driver does not need to be enabled by
default

Fixes: 32bb477fa7bf ("serial: 8250_pci1xxxx: Add driver for quad-uart support")
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/lkml/CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com/
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v1 -> v2:
- Update commit description as per review feedback

v0 -> v1:
- Add proper commit description
---
 drivers/tty/serial/8250/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 978dc196c29b..cbf11147dc89 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -299,7 +299,6 @@ config SERIAL_8250_PCI1XXXX
 	tristate "Microchip 8250 based serial port"
 	depends on SERIAL_8250 && PCI
 	select SERIAL_8250_PCILIB
-	default SERIAL_8250
 	help
 	 Select this option if you have a setup with Microchip PCIe
 	 Switch with serial port enabled and wish to enable 8250
-- 
2.25.1

