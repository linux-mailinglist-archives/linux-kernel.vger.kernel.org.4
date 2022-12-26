Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725CA6560D1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiLZHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLZHje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:39:34 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E63DD2;
        Sun, 25 Dec 2022 23:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1672040373; x=1703576373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YploI0GYMd3aQwff+CXU2zROOWyWbNVdL7nyot226OE=;
  b=WWj8AjS4eqVkPL4bbD1YFJDbiVT3dvOAjDxqd6z86XLIYvozxmTE8+ZC
   V8suOqVuo1AX/PkSYC6cPGm78HURebA+rhYHMtJnEs4toWjGSwvA3F8LM
   QozeuaSU+/J2JxTlAHGlzgwgiICA0wJIoUqZX9ScboklfWiFUS9rAExfc
   Yibs+TugPlohGGQKNyBZau/vVle++BfM9OOa6y2XnA2exlby8fu2N1ZpQ
   QDdziKVfnkR16HxcbgI14PJGj2Yy21uvoo8rW54HeQSyAwBnyJIb4h0y8
   NHt9wm96Q/Zaub15P+Vw8tWd2rP0mjz7kcWMQSbwvwF8lvbjGUQg8GSRJ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,274,1665471600"; 
   d="scan'208";a="194420546"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Dec 2022 00:39:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 26 Dec 2022 00:39:31 -0700
Received: from che-lt-i64410lx.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 26 Dec 2022 00:39:27 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        <hari.prasathge@microchip.com>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>
CC:     <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v3 0/2] mmc: atmel-mci: Convert to gpio descriptors
Date:   Mon, 26 Dec 2022 13:09:06 +0530
Message-ID: <20221226073908.17317-1-balamanikandan.gunasundar@microchip.com>
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

Replace legacy gpio apis with gpio descriptors

v3:

- [PATCH v3 1/2] mmc: atmel-mci: Convert to gpio descriptors
  Convert devm_gpiod_get_from_of_node() into devm_fwnode_gpiod_get()

v2:

- [PATCH 1/2] mmc: atmel-mci: Convert to gpio descriptors
  Remove "#include <linux/gpio.h>" as it is not necessary

- [PATCH 2/2] mmc: atmel-mci: move atmel MCI header file
  Move linux/atmel-mci.h into drivers/mmc/host/atmel-mci.c as it is
  used only by one file

Balamanikandan Gunasundar (2):
  mmc: atmel-mci: Convert to gpio descriptors
  mmc: atmel-mci: move atmel MCI header file

 drivers/mmc/host/atmel-mci.c | 117 ++++++++++++++++++++++-------------
 include/linux/atmel-mci.h    |  46 --------------
 2 files changed, 75 insertions(+), 88 deletions(-)
 delete mode 100644 include/linux/atmel-mci.h

-- 
2.25.1

