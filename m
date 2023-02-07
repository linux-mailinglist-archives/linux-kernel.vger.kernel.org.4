Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0068CE07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjBGENS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBGENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:13:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D60C34310;
        Mon,  6 Feb 2023 20:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675743173; x=1707279173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nt1Yv12PUujNQ0YneIiJcASld5btgnRQIadecMBH1K0=;
  b=q+PlyfNAndcrrAha3AXhGyuwvnZpzhE10qZQCik+L4XbNjoodsRJgizn
   AeJ8rZ4u0+7dx5q21h+beI2ZhYB4gfw0ZDjemqCxgPyqiKzQ/DdwUFy61
   GF9VkQSVyjmb0dN0PxFuUqcoDlXLWN+MGH74MwMTJOscWTsZsfcoqgk4W
   5ph6X408fxhJRmFlYbsjXCTORobtN+oL1QCLLeaFyaz93/mLTOydLIM8E
   lyL6Myzca0TienYKY9vY3nD7HbBYNlVU7iHXp4JztZTZ1Y2qEaXcOTs+o
   G3fRPxcFn4bubDaacfibni65NkGHNcBcgNs/RsszzdGOdS/CASQd1Lt7g
   w==;
X-IronPort-AV: E=Sophos;i="5.97,278,1669100400"; 
   d="scan'208";a="135876059"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Feb 2023 21:12:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Feb 2023 21:12:52 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 6 Feb 2023 21:12:46 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <macro@orcam.me.uk>, <andriy.shevchenko@linux.intel.com>,
        <lukas@wunner.de>, <cang1@live.co.uk>,
        <matthew.gerlach@linux.intel.com>, <deller@gmx.de>,
        <phil.edworthy@renesas.com>, <geert+renesas@glider.be>,
        <marpagan@redhat.com>, <u.kleine-koenig@pengutronix.de>,
        <etremblay@distech-controls.com>, <wander@redhat.com>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v13 tty-next 0/4] serial: 8250_pci1xxxx: Add driver for the pci1xxxx's quad-uart function
Date:   Tue, 7 Feb 2023 22:18:10 +0530
Message-ID: <20230207164814.3104605-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
downstream ports. Quad-uart is one of the functions in the multi-function
endpoint. This patch adds device driver for the quad-uart function and
enumerates between 1 to 4 instances of uarts based on the PCIe subsystem
device ID.

The changes from v1->v2->v3->v4->v5->v6->v7->v8->v9->v10->v11->v12->v13 are
mentioned in each patch in the patchset.

Thanks to Andy Shevchenko, Ilpo Jarvinen, Chritophe JAILLET, Geert
Uytterhoeven, Greg KH, Jiri Slaby for their review comments.

Kumaravel Thiagarajan (4):
  serial: 8250_pci: Add serial8250_pci_setup_port definition in
    8250_pcilib.c
  serial: 8250_pci1xxxx: Add driver for quad-uart support
  serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
  serial: 8250_pci1xxxx: Add power management functions to quad-uart
    driver

 MAINTAINERS                             |   7 +
 drivers/tty/serial/8250/8250_pci.c      |  25 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c | 494 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c   |  40 ++
 drivers/tty/serial/8250/8250_pcilib.h   |  15 +
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  15 +
 drivers/tty/serial/8250/Makefile        |   2 +
 include/uapi/linux/serial_core.h        |   3 +
 9 files changed, 587 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

-- 
2.25.1

