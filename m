Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487606A9ED0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjCCS3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbjCCS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:29:43 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF28A22DC5;
        Fri,  3 Mar 2023 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677868150; x=1709404150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zaFuSR9Vid7T7sXsIbAu+q7+321+DujTuapJ6SxYRd0=;
  b=2SYktlaJXjHJE5b+vZJr/MhI9L6dpzPFB06nxi0/xfJr+piC35WhU1Yf
   oXkqVK3OP5cGVuCFvarzqynvT63ZY1t30H/TfXLftga+7Ou2rLgOHDg8I
   1M3Bj8VN+IYTn1FW20ZX7Hi1eF9d0dr3z2P5YRGWvZ32eQZE5HU+FFeCn
   6kdxY264KvGwlMNgulwKBG56KmYiNHpfKbubkCfFVdhtQ6vlTzfaoCuye
   yUVmdC+ocJpgD7Qu1m1XXK/LrHFtcEg7zqUs6i4bAebasb0SxtJdt89wW
   Yt/Xhk7lRtqElgS/kvg1xidF5ycP4TzeW4K1Si14M8P4RNDY0zfpU+PQk
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,231,1673938800"; 
   d="scan'208";a="140175637"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2023 11:29:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Mar 2023 11:29:09 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 3 Mar 2023 11:29:05 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-serial@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <deller@gmx.de>, <geert+renesas@glider.be>,
        <matthew.gerlach@linux.intel.com>, <phil.edworthy@renesas.com>,
        <UNGLinuxDriver@microchip.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v1 tty-next] serial: 8250_pci1xxxx: Disable SERIAL_8250_PCI1XXXX config by default
Date:   Fri, 3 Mar 2023 23:59:22 +0530
Message-ID: <20230303182922.3903229-1-kumaravel.thiagarajan@microchip.com>
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
is enabled, disable it as this driver need not be enabled by default

Reported-by: Linus Torvalds <torvalds@linux-foundation.org> 
Link: https://lore.kernel.org/lkml/CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com/
Fixes: 32bb477fa7bf ("serial: 8250_pci1xxxx: Add driver for quad-uart support")

Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
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

