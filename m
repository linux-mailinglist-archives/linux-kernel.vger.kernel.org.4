Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27391648ECE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 14:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLJNMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 08:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiLJNMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 08:12:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1E6448;
        Sat, 10 Dec 2022 05:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670677966; x=1702213966;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GEalOp6rlimq1PfGWGifvvxzEdgr1fsj4093Cy8b6u4=;
  b=t95mb9/qU93ATfIqPY2R4eRFwuzdGCca/hvC2AKVcHl+gL4AElaeUqrs
   l1/2Zp1OQZ+f93s9N/EEAo8In4ztxr4+2x4lIItyFpMmSHZwVf+81hLes
   NyelIvhT+H0rNWaUUN0HLqEBJGStx8Qcl3TNolDx8wUoTvhExovzmvNIi
   2JyAy6Ou5omsMam4VC0bCF0uIUVOWYyTleVt6+nHTOM+OCHnWUaXHQVW8
   PqG/zdHRIP//Kx2meJLNUqJF93L7+xZgf23HDkCCuuw710s2pC2DtPymg
   pgrsXhXsRpCjWjGz+eLyGoVQxYqyfot7lBU4G9jjntBz4pxrgzUJDBQfW
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,234,1665471600"; 
   d="scan'208";a="127478436"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Dec 2022 06:12:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 10 Dec 2022 06:12:45 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Sat, 10 Dec 2022 06:12:39 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-serial@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <ilpo.jarvinen@linux.intel.com>,
        <macro@orcam.me.uk>, <andriy.shevchenko@linux.intel.com>,
        <cang1@live.co.uk>, <colin.i.king@gmail.com>,
        <phil.edworthy@renesas.com>, <biju.das.jz@bp.renesas.com>,
        <geert+renesas@glider.be>, <lukas@wunner.de>,
        <u.kleine-koenig@pengutronix.de>, <wander@redhat.com>,
        <etremblay@distech-controls.com>, <jk@ozlabs.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v8 tty-next 0/4] serial: 8250_pci1xxxx: Add driver for the pci1xxxx's quad-uart function
Date:   Sun, 11 Dec 2022 07:17:26 +0530
Message-ID: <20221211014730.1233272-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

The changes from v1->v2->v3->v4->v5->v6->v7->v8 are mentioned in each patch
in the patchset.

Thanks to Andy Shevchenko, Ilpo Jarvinen, Chritophe JAILLET, Geert
Uytterhoeven, Greg KH for their review comments.

Kumaravel Thiagarajan (4):
  serial: 8250_pci: Add serial8250_pci_setup_port definition in
    8250_pcilib.c
  serial: 8250_pci1xxxx: Add driver for quad-uart support
  serial: 8250_pci1xxxx: Add RS485 support to quad-uart driver
  serial: 8250_pci1xxxx: Add power management functions to quad-uart
    driver

 MAINTAINERS                             |   7 +
 drivers/tty/serial/8250/8250_pci.c      |  25 +-
 drivers/tty/serial/8250/8250_pci1xxxx.c | 502 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c   |  38 ++
 drivers/tty/serial/8250/8250_pcilib.h   |  15 +
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  15 +
 drivers/tty/serial/8250/Makefile        |   2 +
 include/uapi/linux/serial_core.h        |   3 +
 9 files changed, 593 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

-- 
2.25.1

