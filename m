Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425D5709BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbjESQBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjESQBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:01:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2074DC9;
        Fri, 19 May 2023 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684512112; x=1716048112;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=woiVgG+lB3Jrua/VFkeuakZaRdLvhRt3/KjqVe4gzPw=;
  b=iCDj6ZjSb9f/diGfui1cXgnkS5WSmVqVL5v+T4TBWik3arriPkybUHKZ
   U3qkogIECWPbflyhsr+VpjBcDXmr+5ydSV5hYjN5pJj0qIbgQI8Jh7Fly
   HaPYho0JVQFXxsuTfIOnSOmaCLEPb0Dc0urBwYfQV3PPO/qz2bUXUqEl9
   DqscBkgIK2VcnO39aix/DeLA5COrZCXPl/c29nnYf8xq8kF1WNl/j02bU
   CdnmPrxXM1aiB+9gxQgB6Mqeq6MR4gw4dAyODEz4WYuw729hzBVnSDV3b
   BETQMaAGnYDm32rIA4Nq7VIlThywA1zZRtE0+mtj2MO6+a+0yCt83z0PG
   w==;
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="212153658"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 May 2023 09:01:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 19 May 2023 09:01:51 -0700
Received: from marius-VM.mshome.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 19 May 2023 09:01:49 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <marius.cristea@microchip.com>
Subject: [PATCH 0/2] Adding support for Microchip MCP3564 ADC family
Date:   Fri, 19 May 2023 19:01:43 +0300
Message-ID: <20230519160145.44208-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

Adding support for Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
Delta-Sigma ADCs with an SPI interface. This driver covers the following part
numbers:
 - MCP3561, MCP3562, MCP3564, MCP3561R, MCP3562R, MCP3564R,
 - MCP3461, MCP3462, MCP3464, MCP3461R, MCP3462R and MCP3464R. 

Differences related to previous patch:

v0:
- first version comitted to review

Marius Cristea (2):
  dt-bindings: iio: adc: adding MCP3564 ADC
  iio: adc: adding support for MCP3564 ADC

 .../ABI/testing/sysfs-bus-iio-mcp3564         |  143 ++
 .../bindings/iio/adc/microchip,mcp3564.yaml   |   88 ++
 MAINTAINERS                                   |    7 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/mcp3564.c                     | 1395 +++++++++++++++++
 6 files changed, 1647 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-mcp3564
 create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
 create mode 100644 drivers/iio/adc/mcp3564.c


base-commit: a508fbfed333aea05e4ac42d98803a031cda8ce8
-- 
2.34.1

