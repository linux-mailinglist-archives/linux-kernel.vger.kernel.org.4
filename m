Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E969964ECFF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiLPOiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiLPOhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:37:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6005B5E09B;
        Fri, 16 Dec 2022 06:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671201449; x=1702737449;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wMHFw5uiriRq1CxOroTGwEkfbMo+ViwT/l1yTeHdqjE=;
  b=P04BaM4a73XLi5Q7RqvGc1KleZJUmJU+w5RRynnF63nArZZCzF3BBhXe
   B8LVLsr+rfBMnwtujHl8poGxidXZQeKl1OmptcoApwVwFz44DS0sPUi8K
   27IHuxM6UsduG4dnRo/Em5IyzriV+bpXqL5/BhvH0NrZap8v3VU6MJxhO
   C8+a7D9GxL8yubRHVxFG6+jFCA1A65fl8Pd4bWQcqN7sKr5UL95GYGav1
   Yc4uOvf9cw24K4FOnCqiKTcRv8TCIA+qxcf3iiYkdsNwv/PUAvWD21AU1
   Zqpov/3/kKjT1u+cexOjQpVwK16Ju2vbl2ahMAEcihorlwR/SuhfcWjDp
   w==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="128506510"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 07:37:27 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 07:37:24 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 07:37:22 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <luis.oliveira@synopsys.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 0/4] media: dwc: add csi2host driver
Date:   Fri, 16 Dec 2022 16:37:13 +0200
Message-ID: <20221216143717.1002015-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a respin of this abandoned series of patches here:
https://lore.kernel.org/lkml/1560280855-18085-1-git-send-email-luis.oliveira@synopsys.com/

I have been using this driver for the past few years, and I have reworked
much of it to cope with latest kernel changes.
The series is surely not perfect, and there is still plenty of room for
improvement.
I did not implement all the required changes from v4.
I fixed several bugs in the driver, and implemented few things that were
needed to run in our system (required clocks, etc.)
The CSI2HOST block is present in at91 product named sama7g5 , and we have been
testing it with the sama7g5 Evaluation Kit board.

I do not think I will have the time to implement further changes to this driver.
I am sharing this with the community to try to help others, and maybe
someone will pick up this work and continue the upstreaming process.

One of the big reworks is the binding document which I converted to yaml
and added the properties that were needed in our product.
The PHY binding is still in txt format as originally sent by Luis.
Since I reworked most of the binding, I added myself as author to it.
The rest of the driver keeps Luis as author and I added myself as
Co-developer on the driver which I mostly improved. The commit log
will contain information about everything that I have added to it.

P.S. I have not kept the history change log. Sorry

Eugen


Eugen Hristev (1):
  dt-bindings: media: Document bindings for DW MIPI CSI-2 Host

Luis Oliveira (3):
  dt-bindings: phy: Document the Synopsys MIPI DPHY Rx bindings
  media: platform: dwc: Add MIPI CSI-2 controller driver
  media: platform: dwc: Add DW MIPI DPHY Rx driver

 .../bindings/media/snps,dw-csi.yaml           | 149 ++++
 .../bindings/phy/snps,dw-dphy-rx.txt          |  29 +
 MAINTAINERS                                   |  11 +
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/Makefile               |   1 +
 drivers/media/platform/dwc/Kconfig            |  41 ++
 drivers/media/platform/dwc/Makefile           |  15 +
 drivers/media/platform/dwc/dw-csi-plat.c      | 667 ++++++++++++++++++
 drivers/media/platform/dwc/dw-csi-plat.h      | 102 +++
 drivers/media/platform/dwc/dw-csi-sysfs.c     | 623 ++++++++++++++++
 drivers/media/platform/dwc/dw-dphy-plat.c     | 224 ++++++
 drivers/media/platform/dwc/dw-dphy-rx.c       | 625 ++++++++++++++++
 drivers/media/platform/dwc/dw-dphy-rx.h       | 212 ++++++
 drivers/media/platform/dwc/dw-dphy-sysfs.c    | 232 ++++++
 drivers/media/platform/dwc/dw-mipi-csi.c      | 570 +++++++++++++++
 drivers/media/platform/dwc/dw-mipi-csi.h      | 294 ++++++++
 include/media/dwc/dw-csi-data.h               |  26 +
 include/media/dwc/dw-dphy-data.h              |  32 +
 include/media/dwc/dw-mipi-csi-pltfrm.h        | 104 +++
 19 files changed, 3958 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/snps,dw-csi.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt
 create mode 100644 drivers/media/platform/dwc/Kconfig
 create mode 100644 drivers/media/platform/dwc/Makefile
 create mode 100644 drivers/media/platform/dwc/dw-csi-plat.c
 create mode 100644 drivers/media/platform/dwc/dw-csi-plat.h
 create mode 100644 drivers/media/platform/dwc/dw-csi-sysfs.c
 create mode 100644 drivers/media/platform/dwc/dw-dphy-plat.c
 create mode 100644 drivers/media/platform/dwc/dw-dphy-rx.c
 create mode 100644 drivers/media/platform/dwc/dw-dphy-rx.h
 create mode 100644 drivers/media/platform/dwc/dw-dphy-sysfs.c
 create mode 100644 drivers/media/platform/dwc/dw-mipi-csi.c
 create mode 100644 drivers/media/platform/dwc/dw-mipi-csi.h
 create mode 100644 include/media/dwc/dw-csi-data.h
 create mode 100644 include/media/dwc/dw-dphy-data.h
 create mode 100644 include/media/dwc/dw-mipi-csi-pltfrm.h

-- 
2.25.1

