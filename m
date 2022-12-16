Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21264DEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLOQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:52:14 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609E26107;
        Thu, 15 Dec 2022 08:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671123130; x=1702659130;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B65eeEOBlhMcgevYuQJPH0nL/7LUbZ6ZkzNYMjmoIEo=;
  b=Gf3fp1AylDqgLHmVTdAWmHp8H4zD3YMQXIcAGfWNwikGA2yA4psXKxiq
   j8aQCERVBbX0J4u1KtsJ1Eq9d/742LS9+q8FUQiQUtybq1ywpW3P2DuGm
   JLtIXDa3IJbOFHz2N6eonO0xQ2+R7Xic3u54+QW++RYDKdgXdgxW+LOjp
   OzgVB9IR7+DP/EcUvsju7K81W232VM/aiJ9qiMerldcM1GmGOuCLO4av/
   YUOb32qIiMbul0CD4mxEkKjrkiAy90l57ufXZta44yB8q7Ej8QV9vt9/J
   5iL5plCAgFR5Ae3fDXqucJZK5UrIpygG2LCvNtaHKnP8LEo3JWNMuMmoR
   g==;
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="191874359"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Dec 2022 09:52:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:52:07 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:52:02 -0700
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
Subject: [PATCH v9 tty-next 0/4] serial: 8250_pci1xxxx: Add driver for the pci1xxxx's quad-uart function
Date:   Fri, 16 Dec 2022 10:56:52 +0530
Message-ID: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
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

The changes from v1->v2->v3->v4->v5->v6->v7->v8->v9 are mentioned in
each patch in the patchset.

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
 drivers/tty/serial/8250/8250_pci1xxxx.c | 493 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pcilib.c   |  39 ++
 drivers/tty/serial/8250/8250_pcilib.h   |  15 +
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  15 +
 drivers/tty/serial/8250/Makefile        |   2 +
 include/uapi/linux/serial_core.h        |   3 +
 9 files changed, 585 insertions(+), 22 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.c
 create mode 100644 drivers/tty/serial/8250/8250_pcilib.h

-- 
2.25.1

