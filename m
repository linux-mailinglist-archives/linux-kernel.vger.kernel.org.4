Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908E272B171
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 12:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjFKKkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 06:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjFKKkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 06:40:32 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FD21B1;
        Sun, 11 Jun 2023 03:40:30 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686480028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=C55nMeIDtiQJBRlRcKRFLbxtCKPrKUT5Uj3r1tMKd3M=;
        b=VXXXJ0grXoG5uje5MHKFDs6efk0qeKbQwieCwCx1NG18jdG2FVSZbbIgIc1EVxgz77GB5B
        z5CX0xzDjrD4UlwcZBINJG767DR2N66m3UsH/4JfAB4qstQoTJtzDISUYKHyG9NN3FJ2Wm
        iIQ8G0X3dKsUjZlYSGtWMV9ucCYNP7e3rrdWILpUff+zkvTzi999Iv0YH3mCWVaY3HduBp
        vXDUy9xkuCN0I7xIP+9m/ePEKU29Z31OleAhZ1t5haUF4Q5c9dkkwqjUVk3TSKGCgfhqkA
        ePdhX1KFqcgLphRumZGInKA6ixbzzM1Nza+1TeFtA3i15lPAse6bz+FB4g3w2g==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A424FF80A;
        Sun, 11 Jun 2023 10:40:24 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Simon Horman <simon.horman@corigine.com>,
        alexis.lothore@bootlin.com
Subject: [PATCH net-next] net: altera_tse: fix init sequence to avoid races with register_netdev
Date:   Sun, 11 Jun 2023 12:40:19 +0200
Message-Id: <20230611104019.33793-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported here[1], the init sequence in altera_tse can be racy should
any operation on the registered netdev happen after netdev registration
but before phylink initialization.

Fix the registering order to avoid such races by making register_netdev
the last step of the probing sequence.

[1]: https://lore.kernel.org/netdev/ZH9XK5yEGyoDMIs%2F@shell.armlinux.org.uk/

Fixes: fef2998203e1 ("net: altera: tse: convert to phylink")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
This patch targets net-next as it fixes a commit that is in net-next
too.

 drivers/net/ethernet/altera/altera_tse_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/altera/altera_tse_main.c b/drivers/net/ethernet/altera/altera_tse_main.c
index 2e15800e5310..54f1b5ad84ce 100644
--- a/drivers/net/ethernet/altera/altera_tse_main.c
+++ b/drivers/net/ethernet/altera/altera_tse_main.c
@@ -1395,12 +1395,6 @@ static int altera_tse_probe(struct platform_device *pdev)
 	spin_lock_init(&priv->rxdma_irq_lock);
 
 	netif_carrier_off(ndev);
-	ret = register_netdev(ndev);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register TSE net device\n");
-		goto err_register_netdev;
-	}
-
 	platform_set_drvdata(pdev, ndev);
 
 	priv->revision = ioread32(&priv->mac_dev->megacore_revision);
@@ -1449,12 +1443,16 @@ static int altera_tse_probe(struct platform_device *pdev)
 		goto err_init_phylink;
 	}
 
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register TSE net device\n");
+		return ret;
+	}
+
 	return 0;
 err_init_phylink:
 	lynx_pcs_destroy(priv->pcs);
 err_init_pcs:
-	unregister_netdev(ndev);
-err_register_netdev:
 	netif_napi_del(&priv->napi);
 	altera_tse_mdio_destroy(ndev);
 err_free_netdev:
-- 
2.40.1

