Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB74F6F626F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjEDAtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEDAtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:49:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A33C99;
        Wed,  3 May 2023 17:49:04 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74E4A66032D5;
        Thu,  4 May 2023 01:49:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683161342;
        bh=BKsoOLwf3MWeyx0HHhnkyVrCjdOFjcx9T5XOHh5ftLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cG8oO1FMlYR32CajRzJJVGbLBrqEm+Rao9pbnJI+p2DKG+H0HpAJCrzUTxu34UoFh
         J0iJ4VnhjzRXH9wGOkIfl9Cz3H1ByVdl+ZSSJfF0ZFFFN66hVLiv858pQY837vMxcu
         du+KXes9bKEAI6gZiFc1MozFZRQVslqDMBK9ZHBvEUX/14kQP3d5uDk5GiRq9bGGXf
         P/60wwO8laC5FQW6H+Ei6L7AYDD2ZPCw/K7DfP2eAYK0M5VnIwM9NWICkrpvss5ZQ+
         g31KHb6Qb6GLHi8bFy/RaPRQguhAcWcpB4ts+MqZDgMWyScTLyWIiL2z4oxGUlh5ib
         eTkSLBzCVvteg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 1/6] thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
Date:   Wed,  3 May 2023 20:48:47 -0400
Message-Id: <20230504004852.627049-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504004852.627049-1-nfraprado@collabora.com>
References: <20230504004852.627049-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a single IRQ handler for each LVTS thermal domain, and it is
supposed to check each of its underlying controllers for the origin of
the interrupt and clear its status. However due to a typo, only the
first controller was ever being handled, which resulted in the interrupt
never being cleared when it happened on the other controllers. Add the
missing index so interrupts are handled for all controllers.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

---

(no changes since v1)

 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 3df4989f9902..2988f201633a 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -450,7 +450,7 @@ static irqreturn_t lvts_irq_handler(int irq, void *data)
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
 
-		aux = lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);
+		aux = lvts_ctrl_irq_handler(&lvts_td->lvts_ctrl[i]);
 		if (aux != IRQ_HANDLED)
 			continue;
 
-- 
2.40.1

