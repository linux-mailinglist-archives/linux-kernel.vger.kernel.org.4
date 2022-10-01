Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584035F1A47
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 08:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJAGRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 02:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJAGRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:17:36 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD610D67B;
        Fri, 30 Sep 2022 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664605013; x=1696141013;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dRIqUrYVwtMkvvZEu/bX9DedHrUPU6grLy3XTjixO1Y=;
  b=ncJjwXS0cZ3H/mOhpV5etnpCwpE5emWwLhmqV7tA1Di8qK4lk5vzdlnK
   g4cswTYD+7vxDCDDfj1xM9ddc/4obtl/RhZhZN3tfNrOTXNueC3PibU2Q
   4Dbph1ax2aQjQpQNUuceygpWLadrO7IBfiiwOnRjtGPlhFbNwkrs31zv+
   N/qjsAg4dDH7H9e9ZR0KIxjLj3yAvf4QNnXLVaL9tvt59yx7Knb6DNXCn
   vLNKmLhSUc6I/NIfb9E/doQQXQu90FmMA9US21omQ+P75wd3V2cYzuOIi
   64lBL+kVwVgNTkrzZFbeFJ3ioBQLUjlbB5xiQRd8vPE/LeS88gYkO+GWW
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,360,1654585200"; 
   d="scan'208";a="182901787"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2022 23:15:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 30 Sep 2022 23:15:04 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 30 Sep 2022 23:14:59 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <ilpo.jarvinen@linux.intel.com>, <andy.shevchenko@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <johan@kernel.org>,
        <wander@redhat.com>, <etremblay@distech-controls.com>,
        <macro@orcam.me.uk>, <geert+renesas@glider.be>, <jk@ozlabs.org>,
        <phil.edworthy@renesas.com>, <lukas@wunner.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 tty-next 0/3] 8250: microchip: pci1xxxx: Add driver for the pci1xxxx's quad-uart function.
Date:   Sat, 1 Oct 2022 11:45:04 +0530
Message-ID: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

The changes from v1 are mentioned in each patch in the patchset.

Thanks to Andy Shevchenko, Ilpo Jarvinen, Geert Uytterhoeven for their
review comments for v1.

Kumaravel Thiagarajan (3):
  8250: microchip: pci1xxxx: Add driver for quad-uart support.
  8250: microchip: pci1xxxx: Add rs485 support to quad-uart driver.
  8250: microchip: pci1xxxx: Add power management functions to quad-uart
    driver.

 MAINTAINERS                             |   6 +
 drivers/tty/serial/8250/8250_pci1xxxx.c | 563 ++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c     |   8 +
 drivers/tty/serial/8250/Kconfig         |  10 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/uapi/linux/serial_core.h        |   3 +
 6 files changed, 591 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c

-- 
2.25.1

