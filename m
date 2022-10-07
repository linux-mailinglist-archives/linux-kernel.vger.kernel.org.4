Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03FFB5F7A5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJGPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJGPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:16:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D162CE05;
        Fri,  7 Oct 2022 08:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1665155784; x=1696691784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xvS2h3424DyB5DP3ehn441lqaYukYwiMe+ZbFqe9uds=;
  b=F82tsH1wtW2Pb1jF7XGHFhYtnv4h2cTNVSe3966tDlmD6cAg5XNJYt1+
   PPtvosf0kGR1dvptKexYgyQCnM7vq7+0q9WPT9sBlUFNZcS1SCd11tUz9
   kt0JuTopd+eNQdq58D5BlKmg9zw1Z8Ov2n+mFLs/wJ6BNMbq6iza80d8m
   HLMRyy6dFJXIeCgZZ/t20+rNyXWyeLmXl9s0WFxhP1pcOT5xtrxXRt8GK
   xLYYDC3juiQK9JhnC4A2yWpkEgkxlKehoC0Tcsc+oPucVDvQao9w7/YvH
   a7cNykbrnOjQVOg22Fr4iEzQzygme0fXZmrGRn3R/y78axfvmmAmYxSIf
   w==;
X-IronPort-AV: E=Sophos;i="5.95,167,1661842800"; 
   d="scan'208";a="194275888"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Oct 2022 08:16:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 7 Oct 2022 08:16:23 -0700
Received: from ryan-Precision-5560.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 7 Oct 2022 08:16:23 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/2] pinctrl:at91-pio4:add support for pullup/down
Date:   Fri, 7 Oct 2022 08:16:45 -0700
Message-ID: <20221007151647.98222-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.34.1
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set adds support for pull up/down pinctl configuration.
The implementation is based off of other pinctl drivers that have
implemented line bias configurations.

The second patch addes a case for PIN_CONFIG_PERSIST_STATE
this shows up becuse the gpiod api passes this into the new config_set
function that was just implemented. Looking at other drivers like TI
driver, added the ENOTSUPP to the switch case for that state flag.

How this was tested was by using a gpio program that I created to test
configuration from userspace. This program was run in the
background using & then using gpioinfo function checked if the change
has been detected by the gpiod api. Then using devmem reading the
regester making sure that the correct bit was set. The registers where
checked before and during the program is being run, making sure the
change happens.

In the program Pin 127 would be passed into the test program. Before
the program was ran devmem for pin 127 config register. After
the progam is running in the background devmem for the same status
register is called, the result is showing the change in pinconfig.
The device used to test was the SAMA5D27_som1_ek.

Ryan Wanner (2):
  pinctrl: at91-pio4: Add configuration to userspace
  pinctrl: at91-pio4: Add persist state case in config

 drivers/pinctrl/pinctrl-at91-pio4.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

-- 
2.34.1

