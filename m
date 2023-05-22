Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C0970C3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjEVREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjEVRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:03:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665F9F4;
        Mon, 22 May 2023 10:03:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FAF46606E74;
        Mon, 22 May 2023 18:03:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684775025;
        bh=ce34z/CXrUq2NMhvtZdCHvp4uOK1+ORwK5t6sNy10LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kcI6B1fVLFNOtckJ7RVa23rviif43wxsc80XQ4QwZusJGSB+7f1nSpKDr/GFUZ0zV
         z2Gfd6YIIm7qQfN6KRW6cIT6ymgICqTG1NHQD6I3/walJPTZ/FtdtjAOMU8vp8nqMK
         e3clQzDzO0/qzZDWi8emT4QFEgn8nmoKf+R7pF8J9pRwpH01nfQWQzoB791PtFdpWq
         k9zeev7emXRL9ohg0hj+ZRNsqSPwJ8hfIr6ZQgxbz/xbNy4RUZxVOACzrQIn0PBLR6
         nYXY5+V798pFtVm0cnEi3WO2ZRUM/K6zyJjXLAifHN3cduF1SVkc5JAoJq9bAL6MjZ
         BWoXnbSWIDyMg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 82DD04807F1; Mon, 22 May 2023 19:03:40 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 7/7] phy: phy-rockchip-inno-usb2: improve error message
Date:   Mon, 22 May 2023 19:03:24 +0200
Message-Id: <20230522170324.61349-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522170324.61349-1-sebastian.reichel@collabora.com>
References: <20230522170324.61349-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing the OF node is not useful, since we get the same information
from the device context. Instead print the reg address, that could
not be found.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index f5c30f117cba..b982c3f0d4b5 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1377,8 +1377,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	} while (phy_cfgs[index].reg);
 
 	if (!rphy->phy_cfg) {
-		dev_err(dev, "no phy-config can be matched with %pOFn node\n",
-			np);
+		dev_err(dev, "could not find phy config for reg=0x%08x\n", reg);
 		return -EINVAL;
 	}
 
-- 
2.39.2

