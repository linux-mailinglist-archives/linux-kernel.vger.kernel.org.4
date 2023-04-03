Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEE16D3E0B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjDCHZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjDCHZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:25:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF876769D;
        Mon,  3 Apr 2023 00:25:04 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3337P3B7027302;
        Mon, 3 Apr 2023 02:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680506703;
        bh=l1WM7nqhQksZTq1YR4mffsGiXXZP+nU1/yW4cLVhbuA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VUSUAUz5n6kjVtrfFk0XNCce1wgTlLyXDO4OUjxfRCxKLxDFsY8gj7ZU8Kt3pJKoP
         fh/dhYws+gLXDNroOSHsrbucbqLAm0TitewhLygWgHMpAnkF31risS1qrFm5q8UoAd
         RVUF9YYrXS8TKlMEwlFF8NTmHk+9w7LPXU39INns=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3337P3AP038826
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Apr 2023 02:25:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 3
 Apr 2023 02:25:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 3 Apr 2023 02:25:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3337P2if022941;
        Mon, 3 Apr 2023 02:25:03 -0500
From:   Dhruva Gole <d-gole@ti.com>
To:     <linux-gpio@vger.kernel.org>
CC:     Dhruva Gole <d-gole@ti.com>, <linux-kernel@vger.kernel.org>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/2] gpio: davinci: Do not clear the bank intr enable bit in save_context
Date:   Mon, 3 Apr 2023 12:54:42 +0530
Message-ID: <20230403072443.83810-2-d-gole@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403072443.83810-1-d-gole@ti.com>
References: <20230403072443.83810-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt enable bits might be set if we want to use the GPIO as
wakeup source. Clearing this will mean disabling of interrupts in the GPIO
banks that we may want to wakeup from.
Thus remove the line that was clearing this bit from the driver's save
context function.

Cc: Devarsh Thakkar <devarsht@ti.com>
Fixes: 0651a730924b ("gpio: davinci: Add support for system suspend/resume PM")
Signed-off-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/gpio-davinci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 7fc83057990a..d7595b39e8c4 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -639,9 +639,6 @@ static void davinci_gpio_save_context(struct davinci_gpio_controller *chips,
 		context->set_falling = readl_relaxed(&g->set_falling);
 	}
 
-	/* Clear Bank interrupt enable bit */
-	writel_relaxed(0, base + BINTEN);
-
 	/* Clear all interrupt status registers */
 	writel_relaxed(GENMASK(31, 0), &g->intstat);
 }
-- 
2.25.1

