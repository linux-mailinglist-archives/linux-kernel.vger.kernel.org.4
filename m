Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6D45ECEFC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiI0Uzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiI0Uzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:55:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC3E9CDA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 13:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664312139; x=1695848139;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fCfSqRaf6A90/CtP08arOZ0XECWdPKs2j06t17vD6/E=;
  b=QcedUhUvUg+7oTDxfeHWqP1yrCKAvKXiL8vZTSzD6/XnplwtWNZeWKWz
   3V7PDKVGDnQI9EkCrldUr9ctKbtABVI5uRN98iUogn6Ix0qrlD+cUrShM
   csX0sVjDvY/Ux8upMJwZys02jAKAEbUV7ahQBDpzw2ER64fKsM/MpWQC4
   p4D7sMwoYMZLli2z+iXmZzl+bF0caNMzZm/CNK5iLKYPMuZr0q687lQuA
   V6wyV4UnmzSI1qmo7rqs4zdemTmdcdcSdsWECG49NPYqsxzAMohAhvJxi
   hwbAYV92xp0Wtp68hAtKRPLyCU5wzq0npHxFhR7AYRYrLBWvCo2Sk5TVf
   A==;
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="115696920"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 13:55:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 13:55:38 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 27 Sep 2022 13:55:36 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <gregkh@linuxfoundation.org>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>,
        kernel test robot <lkp@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: [PATCH] nvmem: lan9662-otp: Change return type of lan9662_otp_wait_flag_clear()
Date:   Tue, 27 Sep 2022 22:59:16 +0200
Message-ID: <20220927205916.511556-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
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

The blamed commit introduced the following smatch warning in the
function lan9662_otp_wait_flag_clear:
drivers/nvmem/lan9662-otpc.c:43 lan9662_otp_wait_flag_clear() warn: signedness bug returning '(-110)'

Fix this by changing the return type of the function
lan9662_otp_wait_flag_clear() to be int instead of bool.

Fixes: 9e8f208ad5229d ("nvmem: lan9662-otp: add support")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/nvmem/lan9662-otpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
index f6732fd216d80..f4348c97f6e59 100644
--- a/drivers/nvmem/lan9662-otpc.c
+++ b/drivers/nvmem/lan9662-otpc.c
@@ -36,7 +36,7 @@ struct lan9662_otp {
 	void __iomem *base;
 };
 
-static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
+static int lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
 {
 	u32 val;
 
-- 
2.33.0

