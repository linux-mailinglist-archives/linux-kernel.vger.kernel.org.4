Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511ED5F6065
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJFFFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJFFFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:05:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64B264A9;
        Wed,  5 Oct 2022 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665032706; x=1696568706;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QRA1GR36AGgTphmZbabZa/n3GpbsquoUq0VPSDrW8oI=;
  b=wo8yKxO0g5zx1DywjXsxT/w8kvU8tA4BTQySLj9yp5xkb6r5XSMz6GSl
   qOgRvy1ErzIa1L4EPWA4o4njKDipmATLICSPcfexc0v/25fouxY1Vfofl
   XyyZPepNQjrnqGxojbZIwFs/uktcXPAytfvArBmzFbsNupDfw9kzMDxa6
   DAQr6vmVBn7jx264yAojF5lMtImWlpyNOZRUAVyn8K2IgXyeuJswi1n2B
   F/TlBsUSTtYy5GBGYGV+IrdB/VHV/ijP0gcr99ajtI7ZRCA+0BmNP6Ja/
   1HiGkgw+z6rTaIswjrLUpjZwx+bbT63S0BECC7ULJU84hz1PxqHAF44Va
   g==;
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="177283731"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Oct 2022 22:05:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 5 Oct 2022 22:05:03 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Wed, 5 Oct 2022 22:05:01 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH v2 SPI for-next 0/2]  spi: microchip: pci1xxxx: Load SPI driver for SPI endpoint of PCI1XXXX switch
Date:   Thu, 6 Oct 2022 10:35:12 +0530
Message-ID: <20221006050514.115564-1-tharunkumar.pasumarthi@microchip.com>
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

Microchip PCI1XXXX is an unmanaged PCIe3.1a switch for consumer,
industrial, and automotive applications. This switch has multiple
downstream ports. One of the switch's downstream ports is a multifunction
endpoint; one of those functions supports SPI functionality. This series
of patches provides the SPI controller driver for the SPI function of the
multifunction PCIe endpoint of the switch.

RFC -> V2:
- Added logic to handle chip select disable case
- Set SPI_MASTER_MUST_TX flag
- Added logic to ensure current transaction is complete before suspending

Tharun Kumar P (2):
  spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX
    PCIe switch
  spi: microchip: pci1xxxx: Add suspend and resume support for PCI1XXXX
    SPI driver

 drivers/spi/Kconfig        |   9 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-pci1xxxx.c | 475 +++++++++++++++++++++++++++++++++++++
 3 files changed, 485 insertions(+)
 create mode 100644 drivers/spi/spi-pci1xxxx.c

-- 
2.25.1

