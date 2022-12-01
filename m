Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1F163E901
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLAEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiLAEvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:51:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642C999F6F;
        Wed, 30 Nov 2022 20:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669870267; x=1701406267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z6215Ur3yWbRDSC3jbmJMVudvcf38Dw/UAq9Nd4FL6s=;
  b=Xf8leJwGzRQrmQxQ9TQs1WQamtVuAObafnv7Bh0FRZiNGZ33ji8Thqo8
   +z46xUcRaycZMkSPcV8ZHvQKKrG9LYlKjfOc/TxZooXWhsnptZvPWfADK
   C19p0nhMvOknXFvKZPu8sJw+/9oHmz7KSPSnQmfNTURho8/+MV2yHk0UD
   9sisxwhGSfr/0AtOAVNvy9kTJavcQ3dywkBzwLDj8fpbrltzhvfyypGqm
   lNU8fZWivnQtgU9U+Nl3qviROZsqHwIGLw4IaVVXthBE+QJiNk123pMKi
   6x1Vhr14wlW749Pmr1UvKkh/iHbvxktNQLcS3jUj1VUnZDvyn5wevk6MS
   g==;
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="185988701"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2022 21:51:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 30 Nov 2022 21:51:04 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 30 Nov 2022 21:50:58 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <andriy.shevchenko@linux.intel.com>,
        <ilpo.jarvinen@linux.intel.com>, <macro@orcam.me.uk>,
        <jay.dolan@accesio.com>, <cang1@live.co.uk>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <biju.das.jz@bp.renesas.com>, <geert+renesas@glider.be>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>,
        <UNGLinuxDriver@microchip.com>, <colin.i.king@gmail.com>
Subject: [PATCH v6 tty-next 0/4]  serial: 8250_pci1xxxx: Add driver for the pci1xxxx's quad-uart function
Date:   Thu, 1 Dec 2022 10:21:42 +0530
Message-ID: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

The changes from v1->v2->v3->v4->v5->v6 are mentioned in each patch in
the patchset.

Thanks to Andy Shevchenko, Ilpo Jarvinen, Chritophe JAILLET, Geert
Uytterhoeven, Greg KH for their review comments.

Kumaravel Thiagarajan (4):
  serial: 8250_pci: Add serial8250_pci_setup_port definition in
    8250_pcilib.c
  serial: 8250_pci1xxxx: Add driver for quad-uart support.
  serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
  serial: 8250_pci1xxxx: Add power management functions to quad-uart
    driver

 MAINTAINERS                             |   7 +
 drivers/tty/serial/8250/8250_pci.c      |  24 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c | 463 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c   |  38 ++
 drivers/tty/serial/8250/8250_pcilib.h   |   9 +
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  15 +
 drivers/tty/serial/8250/Makefile        |   2 +
 include/uapi/linux/serial_core.h        |   3 +
 9 files changed, 547 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

-- 
2.25.1

