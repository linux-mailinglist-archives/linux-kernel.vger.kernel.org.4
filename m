Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E21E73151D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbjFOKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbjFOKTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:19:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3EAC;
        Thu, 15 Jun 2023 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686824390; x=1718360390;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B4/Z1h3AQ48U04RvgeIpvrrwMHtFfF4+aajBAn0RzwE=;
  b=M29KIfhzb5jwXcPxw3cGYVUxeRozeUVgagMnBgSxX/hp6DQfCr3et5h0
   rRib3GWUgrrfnAPq2gc2P0Gz/kvc+jpGdZM9RADAbxIqRdNTXUClsVTTl
   UVXepiYBIFoFvrXKpjGwKdkz14PMCW0U6MtIaIOrFNiNTyr5MetXM2uDK
   kfSxjcgv3s9tcuVKq+3yUJHR/f2hNilDbbel/S88e2ckm+oHpVEX2zkdY
   m86ZZ067gEgUu1zR4PC2D1ALlqFAqeZbmguNUjvD8GGFVXgffZBxhb3Ua
   LcPPyX4DOfaVN7i+kypWNCoPG9dR9Ka+uvZxDIL/LgdQkGAtGt35GvsPT
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="218635071"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 03:19:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 03:19:46 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 15 Jun 2023 03:19:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH] clk: fix typo in clk_hw_register_fixed_rate_parent_data() macro
Date:   Thu, 15 Jun 2023 13:19:31 +0300
Message-ID: <20230615101931.581060-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_hw_register_fixed_rate_parent_data() 3rd parameter is parent_data
not parent_hw. Inner function (__clk_hw_register_fixed_rate()) is called
with parent_data parameter as valid. To have this parameter taken into
account update the name of the 3rd parameter of
clk_hw_register_fixed_rate_parent_data() macro to parent_data.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 include/linux/clk-provider.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 842e72a5348f..0b18a17dca3e 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -415,7 +415,7 @@ struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
  * @flags: framework-specific flags
  * @fixed_rate: non-adjustable clock rate
  */
-#define clk_hw_register_fixed_rate_parent_data(dev, name, parent_hw, flags,   \
+#define clk_hw_register_fixed_rate_parent_data(dev, name, parent_data, flags, \
 					     fixed_rate)		      \
 	__clk_hw_register_fixed_rate((dev), NULL, (name), NULL, NULL,	      \
 				     (parent_data), (flags), (fixed_rate), 0, \
-- 
2.34.1

