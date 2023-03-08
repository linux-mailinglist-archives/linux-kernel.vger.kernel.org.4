Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F546B05C8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCHLXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCHLXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:23:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F122004B;
        Wed,  8 Mar 2023 03:23:00 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-248-211-125.ewe-ip-backbone.de [91.248.211.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 544DB6602FEE;
        Wed,  8 Mar 2023 11:22:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678274578;
        bh=NhlIeCsCb+Aqj/Z0GvEUknpPeB8K45sszWBuWJ+vpjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeP3q1qmT4HRCK83tiKSa2n9AUmabYwutlhR0iC8X9H7Yy6blpXxXapxgy88Wp3x3
         OnHyzWAaS5WNRDKwc7waVTzdHEF2KkIdujisb1kM+/PdJkqqgXkjPX6ZylYWcg+fO/
         kY/IHcv5IYSRre5e3aORPMz1jn4bUJ7JoBCPymp5YnbQvH9snaXpfKswH/B37yR4Vp
         WAeq9a3HTuE/kQ73LGWG8nV0woVdUtLPqIbFAy54LozZzkiJOyMeDR85l3UB/Rk9AH
         utBUsyXiKDPWvWNIxotRuorNa4MkW2lpX74GjL+sW7JIsCNzbAqYLvKt6RJuwalfEG
         5btnK5KotPBmQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6CC3B480116; Wed,  8 Mar 2023 12:22:55 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [RESEND] [PATCHv3 1/7] thermal: rockchip: Simplify getting match data
Date:   Wed,  8 Mar 2023 12:22:47 +0100
Message-Id: <20230308112253.15659-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308112253.15659-1-sebastian.reichel@collabora.com>
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to directly get the match data in a generic
way nowadays.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 4b7c43f34d1a..7e88525fe8d0 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1353,15 +1353,10 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct rockchip_thermal_data *thermal;
-	const struct of_device_id *match;
 	int irq;
 	int i;
 	int error;
 
-	match = of_match_node(of_rockchip_thermal_match, np);
-	if (!match)
-		return -ENXIO;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return -EINVAL;
@@ -1373,7 +1368,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->pdev = pdev;
 
-	thermal->chip = (const struct rockchip_tsadc_chip *)match->data;
+	thermal->chip = device_get_match_data(&pdev->dev);
 	if (!thermal->chip)
 		return -EINVAL;
 
-- 
2.39.2

