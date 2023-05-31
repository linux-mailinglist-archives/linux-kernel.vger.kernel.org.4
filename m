Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED61717871
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjEaHkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjEaHkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:40:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67125E5;
        Wed, 31 May 2023 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685518807; x=1717054807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VA6PLEl6XdXdwvvyXjGG+l70IBfaxvdpG2t3qnCADZg=;
  b=S9KKY9XZvNV1hi7mWjg2E9LQb/UFY2CMGI789O6G6pNCw4cQxp5Pw3wB
   gXs/sXpTZNK9OGEe9dOWn0yNzFv3eR3JWG6C/BwKqweb8IYAyI0lffLGg
   XLjVhUUXvbdkau1S30OXo/UDDlmYIINKR+2RciTsy9MKSKXC8YYFX03YB
   SPZuWtkI8aJ4Pfidtb6IzSwWdNF83lOSXcwVN3Wv7/2938kJ+y8gphqT4
   Zz4gCIr+0qH5GE/lB5qbyc5I87MNZN8nmwNEfYLndQ53MR1GcQEo8XxW9
   IC224FeD8bIrtJXlmoz3eQsyxIXCltW7bcfVcW543/JdfxVP0Z46El90k
   A==;
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="216163366"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 May 2023 00:40:06 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 31 May 2023 00:40:05 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Wed, 31 May 2023 00:40:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <jckuo@nvidia.com>, <vkoul@kernel.org>, <kishon@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <nkristam@nvidia.com>
CC:     <linux-phy@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] phy: tegra: xusb: check return value of devm_kzalloc()
Date:   Wed, 31 May 2023 10:39:50 +0300
Message-ID: <20230531073950.145339-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_kzalloc() returns a pointer to dynamically allocated memory.
Pointer could be NULL in case allocation fails. Check pointer validity.
Identified with coccinelle (kmerr.cocci script).

Fixes: f67213cee2b3 ("phy: tegra: xusb: Add usb-role-switch support")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Hi,

This has been addressed using kmerr.cocci script proposed for update
at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20230530074044.1603426-1-claudiu.beznea@microchip.com/

 drivers/phy/tegra/xusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
index ec335668563d..fe72bc74e7bc 100644
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -675,6 +675,9 @@ static int tegra_xusb_setup_usb_role_switch(struct tegra_xusb_port *port)
 	port->dev.driver = devm_kzalloc(&port->dev,
 					sizeof(struct device_driver),
 					GFP_KERNEL);
+	if (!port->dev.driver)
+		return -ENOMEM;
+
 	port->dev.driver->owner	 = THIS_MODULE;
 
 	port->usb_role_sw = usb_role_switch_register(&port->dev,
-- 
2.34.1

