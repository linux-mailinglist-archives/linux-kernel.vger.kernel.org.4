Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8480E613C80
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiJaRvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJaRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:51:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2586395;
        Mon, 31 Oct 2022 10:51:03 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-157-181.ewe-ip-backbone.de [95.33.157.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7792666028E6;
        Mon, 31 Oct 2022 17:51:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667238661;
        bh=pn3c/M5REulyO+/Lr9DSgob3MkqAqMgCCAmDXuQCjnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ju1XDGJwvPmDz6J1YMiJDtop4EdMYbPcN1F8Wvz4EeHGO/dnn/sx0d3x0VAsXhAAw
         wiPh1dDoYwLF2ZJJ3xfyRdl71L886oFAHC4iPfBQTFQOQrH5VjNsS8ujPypiTlUEXS
         QZaxPl+iJlk4nKQfVPMNIm6vv5FVp+NwfeKrTyCUGPUYYFRhNVccLU34FVMwJHNwz4
         K7R0tPt+y19mNFagHfE3RKHSlzsUzcWQdf0XUwvClBOU+1HqFSen85x2Wn/4v/qqEO
         0URcGDTERecc79ywpVNZAv6XADQWPnwIwra3SPiGGyZ/OZeasnEuYm3+KBETVRnykC
         fkjkDhdgB1dLQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4CE3748015F; Mon, 31 Oct 2022 18:50:59 +0100 (CET)
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
Subject: [PATCH 1/7] thermal: rockchip: Simplify getting match data
Date:   Mon, 31 Oct 2022 18:50:52 +0100
Message-Id: <20221031175058.175698-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221031175058.175698-1-sebastian.reichel@collabora.com>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to directly get the match data in a generic
way nowadays.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 819e059cde71..0a0f38c29842 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1353,16 +1353,11 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct rockchip_thermal_data *thermal;
-	const struct of_device_id *match;
 	struct resource *res;
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
@@ -1374,7 +1369,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	thermal->pdev = pdev;
 
-	thermal->chip = (const struct rockchip_tsadc_chip *)match->data;
+	thermal->chip = (const struct rockchip_tsadc_chip *) device_get_match_data(&pdev->dev);
 	if (!thermal->chip)
 		return -EINVAL;
 
-- 
2.35.1

