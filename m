Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24F96BED2D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCQPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCQPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:43:09 -0400
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D5EB28E74;
        Fri, 17 Mar 2023 08:43:04 -0700 (PDT)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.47
        by mg.richtek.com with MailGates ESMTP Server V5.0(14117:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 17 Mar 2023 23:42:42 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Fri, 17 Mar
 2023 23:42:42 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Fri, 17 Mar 2023 23:42:42 +0800
From:   <cy_huang@richtek.com>
To:     <pavel@ucw.cz>, <lee@kernel.org>
CC:     <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <cy_huang@richtek.com>,
        <chiaen_wu@richtek.com>, <jacek.anaszewski@gmail.com>,
        <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] leds: rgb: mt6370: Fix implicit declaration for FIELD_GET
Date:   Fri, 17 Mar 2023 23:42:40 +0800
Message-ID: <1679067760-19098-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

0-DAY CI Kernel Test Service reported the implicit declaration error below:

drivers/leds/rgb/leds-mt6370-rgb.c: In function'mt6370_check_vendor_info':
>> drivers/leds/rgb/leds-mt6370-rgb.c:889:15: error: implicit  declaration
   of function 'FIELD_GET' [-Werror=implicit-function-declaration]
  889 |         vid = FIELD_GET(MT6370_VENDOR_ID_MASK, devinfo);
      |

Add the missing header 'bitfield.h' to fix it.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303171729.CcgyFx17-lkp@intel.com/
Fixes: 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/leds/rgb/leds-mt6370-rgb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
index 9c1e6d5..bb62431 100644
--- a/drivers/leds/rgb/leds-mt6370-rgb.c
+++ b/drivers/leds/rgb/leds-mt6370-rgb.c
@@ -7,6 +7,7 @@
  *   Alice Chen <alice_chen@richtek.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
-- 
2.7.4

