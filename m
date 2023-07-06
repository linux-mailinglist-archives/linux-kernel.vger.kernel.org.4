Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7D374A128
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjGFPip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjGFPik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:38:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04230171D;
        Thu,  6 Jul 2023 08:38:39 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2F37D6606FDA;
        Thu,  6 Jul 2023 16:38:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688657918;
        bh=HO4nDuWbgJLp3N3SyhPaXs/hZj7uYhYlvxsZ7dSo314=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJsTH/a/arRPGkkgAo8mvSy/ygWuAwMYYF5AXrojN9/7jZ5ZS8WCtW7LnNpJNXn9/
         qTPtU/K2hdX4e9NWlp/Irm+Rn0JiHnh7bgRUeZPjAhkOSrE3EfTUHhYy/Ncr5ofEFA
         rHobrTrkQYVQ1aD6um1C68uTS6a5EQTFQlH6qy+20QVqudwgBvDnKH+VMaZVFScImS
         beKNfpbQAHa6ukA1zFVF9KUuZKUeLWOl6t1NGvf+2VXDpncoOsntGLNo3jGlIDLVZt
         IDcnGVvYs6ZXGPjU5+Xoo7/eAHIuFQYIaAVmHgFMqWXVC2vQeQVXbsekQ/anUbKwfx
         Ev8+AgwIsiQbg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 1/6] thermal/drivers/mediatek/lvts_thermal: Handle IRQ on all controllers
Date:   Thu,  6 Jul 2023 11:37:32 -0400
Message-ID: <20230706153823.201943-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706153823.201943-1-nfraprado@collabora.com>
References: <20230706153823.201943-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v1)

 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 1e11defe4f35..ba8f86ee12b6 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -451,7 +451,7 @@ static irqreturn_t lvts_irq_handler(int irq, void *data)
 
 	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
 
-		aux = lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);
+		aux = lvts_ctrl_irq_handler(&lvts_td->lvts_ctrl[i]);
 		if (aux != IRQ_HANDLED)
 			continue;
 
-- 
2.41.0

