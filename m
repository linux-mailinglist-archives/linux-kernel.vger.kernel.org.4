Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6A69DD12
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjBUJms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 04:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjBUJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 04:42:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A177923321;
        Tue, 21 Feb 2023 01:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676972565; x=1708508565;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5jCo9bI2Rlr0cPYMR5trVt2bN57Y+x5yVEQluTzPn3Y=;
  b=sZRZg88FgiuLa3fJu0vc9sK3gEpusaExhuv4WQsRfQWrIUm3Uhdc52+D
   yWYVmuu1QUu5ZFXGVVqoafFiVq4RCn4fh3DPHHsLIRVJS9dkYYmaTyRfo
   YiIWWjTJ7lq7Fg79zfER54MFUBcHu3l7OKa/SiDIOZvntczema3444jV8
   yQsYl8x57S5QNXvooywOZxsVsV0UAOBmMs+YNWb/tAHtiIp1WdtxXgOS8
   Bj6S4RH3NIVeUq37LBT0LoVW1b47rl0H4Jhm9v6ow4nUds7e8IydC8D00
   e/AeASp74XaHwrCbsiL2dZRgLvmu1YfExdRKRX2HAyehRzq1punRky812
   g==;
X-IronPort-AV: E=Sophos;i="5.97,315,1669100400"; 
   d="scan'208";a="197958252"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2023 02:42:44 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 02:42:43 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 02:42:39 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linus.walleij@linaro.org>,
        <dmitry.torokhov@gmail.com>, <ulf.hansson@linaro.org>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH v4 0/2] mmc: atmel-mci: Convert to gpio descriptors
Date:   Tue, 21 Feb 2023 15:12:05 +0530
Message-ID: <20230221094207.102006-1-balamanikandan.gunasundar@microchip.com>
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

Replace legacy gpio apis with gpio descriptors. This v4 is just a
rebase to the "next" branch of
https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git

I would like to have the improvements suggested by Linus as a separate
patch. Please let me know your comments.
https://lore.kernel.org/all/CACRpkdbORVt9sFCnBFE1U206M92u4fjk9enbDJYZw7HJyAC=ng@mail.gmail.com/

v4:

- Rebase on top of next branch
  https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git 

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

 drivers/mmc/host/atmel-mci.c | 116 ++++++++++++++++++++++-------------
 include/linux/atmel-mci.h    |  46 --------------
 2 files changed, 75 insertions(+), 87 deletions(-)
 delete mode 100644 include/linux/atmel-mci.h

-- 
2.25.1

